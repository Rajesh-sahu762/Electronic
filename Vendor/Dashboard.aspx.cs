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
        if (!IsPostBack)
        {
            LoadDashboard();
        }
    }

    void LoadDashboard()
    {
        int vendorId = Convert.ToInt32(Session["UserID"]);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            LoadCounts(con, vendorId);
            LoadLatestOrders(con, vendorId);
            LoadLowStock(con, vendorId);
            LoadMonthlySales(con, vendorId);
        }
    }

    // 🔢 DASHBOARD COUNTS
    void LoadCounts(SqlConnection con, int vendorId)
    {
        // Total products
        SqlCommand pCmd = new SqlCommand(
            "SELECT COUNT(*) FROM Products WHERE VendorID=@id", con);
        pCmd.Parameters.AddWithValue("@id", vendorId);
        lblProducts.Text = pCmd.ExecuteScalar().ToString();

        // Total orders
        SqlCommand oCmd = new SqlCommand(
            "SELECT COUNT(*) FROM Orders WHERE VendorID=@id", con);
        oCmd.Parameters.AddWithValue("@id", vendorId);
        lblOrders.Text = oCmd.ExecuteScalar().ToString();

        // Pending orders
        SqlCommand pendCmd = new SqlCommand(
            "SELECT COUNT(*) FROM Orders WHERE VendorID=@id AND OrderStatus='Pending'", con);
        pendCmd.Parameters.AddWithValue("@id", vendorId);
        lblPending.Text = pendCmd.ExecuteScalar().ToString();

        // Revenue (Delivered COD orders)
        SqlCommand rCmd = new SqlCommand(
            @"SELECT ISNULL(SUM(TotalAmount),0)
              FROM Orders
              WHERE VendorID=@id AND OrderStatus='Delivered'", con);
        rCmd.Parameters.AddWithValue("@id", vendorId);
        lblRevenue.Text = rCmd.ExecuteScalar().ToString();
    }

    // 🧾 LATEST 5 ORDERS
    void LoadLatestOrders(SqlConnection con, int vendorId)
    {
        SqlCommand cmd = new SqlCommand(
        @"SELECT TOP 5 OrderID, OrderDate, TotalAmount, OrderStatus
          FROM Orders
          WHERE VendorID=@id
          ORDER BY OrderDate DESC", con);

        cmd.Parameters.AddWithValue("@id", vendorId);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        gvLatestOrders.DataSource = dt;
        gvLatestOrders.DataBind();
    }

    // ⚠️ LOW STOCK ALERT (Products.Stock)
    void LoadLowStock(SqlConnection con, int vendorId)
    {
        SqlCommand cmd = new SqlCommand(
        @"SELECT ProductName, Stock
          FROM Products
          WHERE VendorID=@id AND Stock <= 5 AND IsBlocked=0", con);

        cmd.Parameters.AddWithValue("@id", vendorId);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count > 0)
        {
            rptLowStock.DataSource = dt;
            rptLowStock.DataBind();
            lblNoLowStock.Text = "";
        }
        else
        {
            lblNoLowStock.Text = "All products have sufficient stock.";
        }
    }

    // 📈 MONTHLY SALES (CURRENT YEAR, DELIVERED ONLY)
    void LoadMonthlySales(SqlConnection con, int vendorId)
    {
        SqlCommand cmd = new SqlCommand(
        @"SELECT MONTH(OrderDate) AS MonthNo,
                 DATENAME(MONTH, OrderDate) AS MonthName,
                 SUM(TotalAmount) AS Total
          FROM Orders
          WHERE VendorID=@id
            AND OrderStatus='Delivered'
            AND YEAR(OrderDate)=YEAR(GETDATE())
          GROUP BY MONTH(OrderDate), DATENAME(MONTH, OrderDate)
          ORDER BY MonthNo", con);

        cmd.Parameters.AddWithValue("@id", vendorId);

        SqlDataReader dr = cmd.ExecuteReader();

        string labels = "";
        string values = "";

        while (dr.Read())
        {
            labels += "'" + dr["MonthName"].ToString() + "',";
            values += dr["Total"].ToString() + ",";
        }
        dr.Close();

        if (labels != "")
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                "salesChart",
                "loadChart([" + labels.TrimEnd(',') + "],[" + values.TrimEnd(',') + "]);",
                true);
        }
    }
}