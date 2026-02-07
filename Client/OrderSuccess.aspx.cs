using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class Client_OrderSuccess : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null || Request.QueryString["id"] == null)
        {
            Response.Redirect("Index.aspx");
            return;
        }

        if (!IsPostBack)
            LoadOrder();
    }

    void LoadOrder()
    {
        int orderId = Convert.ToInt32(Request.QueryString["id"]);
        int userId = Convert.ToInt32(Session["UserID"]);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            // 🔒 ORDER HEADER (SECURE)
            SqlCommand cmd = new SqlCommand(@"
SELECT OrderID, OrderDate, TotalAmount
FROM Orders
WHERE OrderID=@oid AND UserID=@uid", con);

            cmd.Parameters.AddWithValue("@oid", orderId);
            cmd.Parameters.AddWithValue("@uid", userId);

            SqlDataReader dr = cmd.ExecuteReader();
            if (!dr.Read())
            {
                Response.Redirect("Index.aspx");
                return;
            }

            lblOrderId.Text = dr["OrderID"].ToString();
            lblDate.Text = Convert.ToDateTime(dr["OrderDate"]).ToString("dd MMM yyyy");
            lblTotal.Text = Convert.ToDecimal(dr["TotalAmount"]).ToString("0.00");
            dr.Close();

            // 📦 ADDRESS
            SqlCommand addr = new SqlCommand(@"
SELECT Address, City, State, Pincode
FROM OrderAddress WHERE OrderID=@oid", con);

            addr.Parameters.AddWithValue("@oid", orderId);
            dr = addr.ExecuteReader();
            if (dr.Read())
            {
                lblAddress.Text =
                    dr["Address"] + "<br/>" +
                    dr["City"] + ", " +
                    dr["State"] + " - " +
                    dr["Pincode"];
            }
            dr.Close();

            // 🛒 ITEMS
            SqlDataAdapter da = new SqlDataAdapter(@"
SELECT p.ProductName, oi.Quantity, oi.Price,
       (SELECT TOP 1 ImagePath FROM ProductImages WHERE ProductID=p.ProductID) ImagePath
FROM OrderItems oi
JOIN Products p ON p.ProductID=oi.ProductID
WHERE oi.OrderID=@oid", con);

            da.SelectCommand.Parameters.AddWithValue("@oid", orderId);

            DataTable dt = new DataTable();
            da.Fill(dt);

            rptItems.DataSource = dt;
            rptItems.DataBind();
        }
    }
}
