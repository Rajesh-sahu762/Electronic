using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Client_MyOrders : Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null || Session["Role"].ToString() != "Client")
        {
            Session["RETURN_URL"] = "MyOrders.aspx";
            Response.Redirect("Login.aspx");
            return;
        }

        if (!IsPostBack)
            LoadOrders();
    }

    void LoadOrders()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlDataAdapter da = new SqlDataAdapter(@"
SELECT o.OrderID,o.OrderDate,o.TotalAmount,o.OrderStatus,
       a.Address,a.City,a.State,a.Pincode
FROM Orders o
LEFT JOIN OrderAddress a ON a.OrderID=o.OrderID
WHERE o.UserID=@uid
ORDER BY o.OrderDate DESC", con);

            da.SelectCommand.Parameters.AddWithValue("@uid",
                Convert.ToInt32(Session["UserID"]));

            DataTable dt = new DataTable();
            da.Fill(dt);

            rptOrders.DataSource = dt;
            rptOrders.DataBind();
        }
    }

    public DataTable GetItems(object orderId)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlDataAdapter da = new SqlDataAdapter(@"
SELECT p.ProductName, i.Quantity, i.Price,
       (SELECT TOP 1 ImagePath FROM ProductImages WHERE ProductID=p.ProductID) ImagePath
FROM OrderItems i
JOIN Products p ON p.ProductID=i.ProductID
WHERE i.OrderID=@oid", con);

            da.SelectCommand.Parameters.AddWithValue("@oid", orderId);

            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }
    }

    public string StepClass(object status, string step)
    {
        string s = status.ToString();
        string[] flow = { "Placed", "Packed", "Shipped", "Delivered" };

        return Array.IndexOf(flow, s) >= Array.IndexOf(flow, step)
            ? "active-step"
            : "inactive-step";
    }

    protected void rptOrders_ItemCommand(object source,
        System.Web.UI.WebControls.RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Cancel")
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"
UPDATE Orders
SET OrderStatus='Cancelled'
WHERE OrderID=@id AND UserID=@uid
AND OrderStatus IN ('Placed','Packed')", con);

                cmd.Parameters.AddWithValue("@id", e.CommandArgument);
                cmd.Parameters.AddWithValue("@uid",
                    Convert.ToInt32(Session["UserID"]));
                cmd.ExecuteNonQuery();
            }
            LoadOrders();
        }
    }
}
