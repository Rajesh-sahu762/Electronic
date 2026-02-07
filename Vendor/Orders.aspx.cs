using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendor_Default : System.Web.UI.Page
{

    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null || Session["Role"].ToString() != "Vendor")
        {
            Response.Redirect("Login.aspx");
            return;
        }

        if (!IsPostBack)
            LoadOrders();
    }

    void LoadOrders(string search = "", DateTime? from = null, DateTime? to = null)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"
SELECT DISTINCT
    o.OrderID,
    o.OrderDate,
    o.TotalAmount,
    o.OrderStatus,
    o.PaymentMode,
    u.FullName AS ClientName
FROM Orders o
JOIN OrderItems oi ON oi.OrderID = o.OrderID
JOIN Products p ON p.ProductID = oi.ProductID
JOIN Users u ON u.UserID = o.UserID
WHERE p.VendorID = @vid
";

            // 🔎 SEARCH
            if (!string.IsNullOrEmpty(search))
                query += " AND (u.FullName LIKE @s OR CAST(o.OrderID AS NVARCHAR) LIKE @s)";

            // 📅 DATE FILTER
            if (from != null)
                query += " AND o.OrderDate >= @f";

            if (to != null)
                query += " AND o.OrderDate <= @t";

            // ✅ ORDER BY ALWAYS LAST
            query += " ORDER BY o.OrderDate DESC";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.Add("@vid", SqlDbType.Int).Value =
                Convert.ToInt32(Session["UserID"]);

            if (!string.IsNullOrEmpty(search))
                cmd.Parameters.Add("@s", SqlDbType.NVarChar).Value = "%" + search + "%";

            if (from != null)
                cmd.Parameters.Add("@f", SqlDbType.DateTime).Value = from;

            if (to != null)
                cmd.Parameters.Add("@t", SqlDbType.DateTime).Value = to;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvOrders.DataSource = dt;
            gvOrders.DataBind();
        }
    }


    protected void btnFilter_Click(object sender, EventArgs e)
    {
        DateTime? from = null, to = null;

        DateTime f, t;
        if (DateTime.TryParse(txtFrom.Text, out f)) from = f;
        if (DateTime.TryParse(txtTo.Text, out t)) to = t;

        LoadOrders(txtSearch.Text.Trim(), from, to);
    }

    protected void gvOrders_RowCommand(object sender,
        System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int orderId;
        if (!int.TryParse(e.CommandArgument.ToString(), out orderId))
            return;

        if (e.CommandName == "Items")
            LoadItems(orderId);

        if (e.CommandName == "NextStatus")
        {
            UpdateStatus(orderId);
            LoadOrders();
        }

        if (e.CommandName == "CancelOrder")
        {
            CancelOrder(orderId);
            LoadOrders();
        }
    }

    void LoadItems(int orderId)
    {
        pnlItems.Visible = true;
        lblOrderId.Text = orderId.ToString();

        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(@"
                SELECT p.ProductName, i.Quantity, i.Price
                FROM OrderItems i
                JOIN Products p ON p.ProductID = i.ProductID
                WHERE i.OrderID=@id", con);

            cmd.Parameters.Add("@id", SqlDbType.Int).Value = orderId;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvItems.DataSource = dt;
            gvItems.DataBind();
        }
    }

    void UpdateStatus(int orderId)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            // 1️⃣ GET CURRENT STATUS (VENDOR SAFE)
            SqlCommand get = new SqlCommand(@"
SELECT TOP 1 o.OrderStatus
FROM Orders o
JOIN OrderItems oi ON oi.OrderID = o.OrderID
JOIN Products p ON p.ProductID = oi.ProductID
WHERE o.OrderID = @id AND p.VendorID = @vid
", con);

            get.Parameters.AddWithValue("@id", orderId);
            get.Parameters.AddWithValue("@vid",
                Convert.ToInt32(Session["UserID"]));

            object obj = get.ExecuteScalar();
            if (obj == null) return; // ❌ not vendor's order

            string s = obj.ToString();

            if (s == "Delivered" || s == "Cancelled")
                return;

            string next =
                s == "Placed" ? "Packed" :
                s == "Packed" ? "Shipped" :
                s == "Shipped" ? "Delivered" : s;

            // 2️⃣ UPDATE STATUS
            SqlCommand upd = new SqlCommand(@"
UPDATE Orders 
SET OrderStatus = @s 
WHERE OrderID = @id", con);

            upd.Parameters.AddWithValue("@s", next);
            upd.Parameters.AddWithValue("@id", orderId);

            upd.ExecuteNonQuery();
        }
    }



    void CancelOrder(int orderId)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
UPDATE Orders
SET OrderStatus='Cancelled'
WHERE OrderID=@id
AND OrderID IN (
    SELECT o.OrderID
    FROM Orders o
    JOIN OrderItems oi ON oi.OrderID = o.OrderID
    JOIN Products p ON p.ProductID = oi.ProductID
    WHERE p.VendorID = @vid
)
AND OrderStatus IN ('Placed','Packed')", con);

            cmd.Parameters.AddWithValue("@id", orderId);
            cmd.Parameters.AddWithValue("@vid",
                Convert.ToInt32(Session["UserID"]));

            cmd.ExecuteNonQuery();
        }
    }

}