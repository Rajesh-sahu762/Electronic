using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_Products : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCategories();
            LoadVendors();
            LoadProducts();
        }
    }

    void LoadCategories()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlDataAdapter da = new SqlDataAdapter(
                "SELECT CategoryID, CategoryName FROM Categories WHERE IsActive=1", con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CategoryID";
            ddlCategory.DataBind();

            ddlCategory.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All Categories", "0"));
        }
    }

    void LoadVendors()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlDataAdapter da = new SqlDataAdapter(
                "SELECT UserID, FullName FROM Users WHERE Role='Vendor'", con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlVendor.DataSource = dt;
            ddlVendor.DataTextField = "FullName";
            ddlVendor.DataValueField = "UserID";
            ddlVendor.DataBind();

            ddlVendor.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All Vendors", "0"));
        }
    }

    void LoadProducts()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(@"
SELECT p.ProductID, p.ProductName, p.Price, p.Stock, p.IsBlocked, p.IsDeal,
       u.FullName AS VendorName,
       ISNULL(c.CategoryName,'-') AS CategoryName
FROM Products p
INNER JOIN Users u ON u.UserID = p.VendorID
LEFT JOIN Categories c ON c.CategoryID = p.CategoryID
WHERE
(@s='' OR p.ProductName LIKE '%'+@s+'%' OR u.FullName LIKE '%'+@s+'%')
AND (@c=0 OR p.CategoryID=@c)
AND (@v=0 OR p.VendorID=@v)", con);

            cmd.Parameters.Add("@s", SqlDbType.NVarChar).Value = txtSearch.Text.Trim();
            cmd.Parameters.Add("@c", SqlDbType.Int).Value = Convert.ToInt32(ddlCategory.SelectedValue);
            cmd.Parameters.Add("@v", SqlDbType.Int).Value = Convert.ToInt32(ddlVendor.SelectedValue);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvProducts.DataSource = dt;
            gvProducts.DataBind();
        }
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        LoadProducts();
    }

    protected void gvProducts_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int pid = Convert.ToInt32(e.CommandArgument);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            if (e.CommandName == "Block")
                new SqlCommand("UPDATE Products SET IsBlocked=1 WHERE ProductID=@id", con) { Parameters = { new SqlParameter("@id", pid) } }.ExecuteNonQuery();

            if (e.CommandName == "Unblock")
                new SqlCommand("UPDATE Products SET IsBlocked=0 WHERE ProductID=@id", con) { Parameters = { new SqlParameter("@id", pid) } }.ExecuteNonQuery();

            if (e.CommandName == "Deal")
                new SqlCommand(
                    "UPDATE Products SET IsDeal = CASE WHEN IsDeal=1 THEN 0 ELSE 1 END WHERE ProductID=@id", con) { Parameters = { new SqlParameter("@id", pid) } }.ExecuteNonQuery();

            if (e.CommandName == "Images")
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT ImagePath FROM ProductImages WHERE ProductID=@id", con);
                da.SelectCommand.Parameters.Add("@id", SqlDbType.Int).Value = pid;

                DataTable dt = new DataTable();
                da.Fill(dt);

                rptImages.DataSource = dt;
                rptImages.DataBind();

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "img",
                    "$('#imgModal').modal('show');",
                    true);
            }
        }

        LoadProducts();
    }
}
