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
                SELECT o.OrderID, o.TotalAmount, o.PaymentMode, o.OrderStatus, o.OrderDate,
                       c.FullName AS ClientName, v.FullName AS VendorName
                FROM Orders o
                INNER JOIN Users c ON o.ClientID=c.UserID
                INNER JOIN Users v ON o.VendorID=v.UserID
                WHERE
                (@search='' OR o.OrderID LIKE '%'+@search+'%' 
                 OR c.FullName LIKE '%'+@search+'%' 
                 OR v.FullName LIKE '%'+@search+'%')
                AND (@status='' OR o.OrderStatus=@status)
                AND (@from='' OR o.OrderDate>=@from)
                AND (@to='' OR o.OrderDate<=@to)
                ORDER BY o.OrderDate DESC";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@search", txtSearch.Text.Trim());
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@from", txtFrom.Text == "" ? (object)DBNull.Value : txtFrom.Text);
            cmd.Parameters.AddWithValue("@to", txtTo.Text == "" ? (object)DBNull.Value : txtTo.Text);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvOrders.DataSource = dt;
            gvOrders.DataBind();
        }
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