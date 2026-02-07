using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Default : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadOrders();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadOrders();
    }

    private void LoadOrders()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"
SELECT 
    o.OrderID,
    o.OrderDate,
    o.TotalAmount,
    o.PaymentMode,
    o.OrderStatus,
    c.FullName AS ClientName,

    -- 🔥 MULTI VENDOR NAMES
    STUFF((
        SELECT DISTINCT ', ' + v.FullName
        FROM OrderItems oi
        JOIN Products p ON p.ProductID = oi.ProductID
        JOIN Users v ON v.UserID = p.VendorID
        WHERE oi.OrderID = o.OrderID
        FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,2,'') 
    AS VendorNames

FROM Orders o
JOIN Users c ON c.UserID = o.UserID
WHERE
    (@search = '' OR 
     CAST(o.OrderID AS NVARCHAR) LIKE '%' + @search + '%' OR
     c.FullName LIKE '%' + @search + '%')
AND
    (@status = '' OR o.OrderStatus = @status)
AND
    (@from IS NULL OR o.OrderDate >= @from)
AND
    (@to IS NULL OR o.OrderDate <= @to)
ORDER BY o.OrderDate DESC";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@search", txtSearch.Text.Trim());
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@from",
                txtFrom.Text == "" ? (object)DBNull.Value : Convert.ToDateTime(txtFrom.Text));
            cmd.Parameters.AddWithValue("@to",
                txtTo.Text == "" ? (object)DBNull.Value : Convert.ToDateTime(txtTo.Text));

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvOrders.DataSource = dt;
            gvOrders.DataBind();
        }
    }

    protected void gvOrders_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        // 🔒 We are NOT using edit mode, so just reset
        gvOrders.EditIndex = -1;
    }



    protected void gvOrders_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int orderId = Convert.ToInt32(e.CommandArgument);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            if (e.CommandName == "Items")
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    @"SELECT p.ProductName, oi.Quantity, oi.Price
                      FROM OrderItems oi
                      INNER JOIN Products p ON oi.ProductID=p.ProductID
                      WHERE oi.OrderID=" + orderId, con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvItems.DataSource = dt;
                gvItems.DataBind();

                ScriptManager.RegisterStartupScript(this, GetType(),
                    "items", "$('#itemsModal').modal('show');", true);
            }

            if (e.CommandName == "Cancel")
            {
                SqlCommand cmd = new SqlCommand(
                    "UPDATE Orders SET OrderStatus='Cancelled' WHERE OrderID=@id", con);
                cmd.Parameters.AddWithValue("@id", orderId);
                cmd.ExecuteNonQuery();
            }
        }

        LoadOrders();
    }
}