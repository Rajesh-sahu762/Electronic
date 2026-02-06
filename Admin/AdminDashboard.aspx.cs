using System;
using System.Collections.Generic;
using System.Configuration;
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
            LoadDashboardCounts();
        }
    }

    private void LoadDashboardCounts()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            // Total Vendors
            SqlCommand cmdVendors = new SqlCommand(
                "SELECT COUNT(*) FROM Users WHERE Role='Vendor'", con);
            lblVendors.Text = cmdVendors.ExecuteScalar().ToString();

            // Pending Vendors
            SqlCommand cmdPending = new SqlCommand(
                "SELECT COUNT(*) FROM Users WHERE Role='Vendor' AND IsApproved=0", con);
            lblPendingVendors.Text = cmdPending.ExecuteScalar().ToString();

            // Total Products
            SqlCommand cmdProducts = new SqlCommand(
                "SELECT COUNT(*) FROM Products", con);
            lblProducts.Text = cmdProducts.ExecuteScalar().ToString();

            // Total Orders
            SqlCommand cmdOrders = new SqlCommand(
                "SELECT COUNT(*) FROM Orders", con);
            lblOrders.Text = cmdOrders.ExecuteScalar().ToString();
        }
    }
}