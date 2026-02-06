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
        if (Session["UserID"] == null || Session["Role"] == null ||
            Session["Role"].ToString() != "Vendor")
        {
            Response.Redirect("Login.aspx");
            return;
        }

        if (!IsPostBack)
        {
            LoadAdminCategories();
            LoadCategoryDropdown();
            LoadSubCategories();
        }
    }

    void LoadAdminCategories()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlDataAdapter da = new SqlDataAdapter(
                "SELECT CategoryName FROM Categories WHERE IsActive=1", con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            rptCategories.DataSource = dt;
            rptCategories.DataBind();
        }
    }

    void LoadCategoryDropdown()
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
        }
    }

    void LoadSubCategories()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(@"
                SELECT s.SubCategoryID, s.SubCategoryName, s.IsActive, c.CategoryName
                FROM SubCategories s
                JOIN Categories c ON c.CategoryID = s.CategoryID
                WHERE s.VendorID=@vid", con);

            cmd.Parameters.Add("@vid", SqlDbType.Int)
                .Value = Convert.ToInt32(Session["UserID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvSub.DataSource = dt;
            gvSub.DataBind();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtSubCategory.Text))
        {
            lblMsg.Text = "Enter sub-category name";
            return;
        }

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            // 🔒 Duplicate check
            SqlCommand chk = new SqlCommand(
    @"SELECT COUNT(*) FROM SubCategories
  WHERE VendorID=@vid 
    AND CategoryID=@cid
    AND SubCategoryName=@n", con);

            chk.Parameters.Add("@vid", SqlDbType.Int)
               .Value = Convert.ToInt32(Session["UserID"]);
            chk.Parameters.Add("@cid", SqlDbType.Int)
               .Value = Convert.ToInt32(ddlCategory.SelectedValue);
            chk.Parameters.Add("@n", SqlDbType.NVarChar)
               .Value = txtSubCategory.Text.Trim();

            int exists = Convert.ToInt32(chk.ExecuteScalar());
            if (exists > 0)
            {
                lblMsg.Text = "Sub-category already exists in this category";
                return;
            }


            SqlCommand cmd = new SqlCommand(
                @"INSERT INTO SubCategories
                  (CategoryID, VendorID, SubCategoryName, IsActive)
                  VALUES (@c,@v,@n,1)", con);

            cmd.Parameters.Add("@c", SqlDbType.Int)
                .Value = Convert.ToInt32(ddlCategory.SelectedValue);
            cmd.Parameters.Add("@v", SqlDbType.Int)
                .Value = Convert.ToInt32(Session["UserID"]);
            cmd.Parameters.Add("@n", SqlDbType.NVarChar)
                .Value = txtSubCategory.Text.Trim();

            cmd.ExecuteNonQuery();
        }

        txtSubCategory.Text = "";
        lblMsg.Text = "";
        LoadSubCategories();
    }

    protected void gvSub_RowCommand(object sender,
        System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Toggle")
        {
            int id = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand(
                    @"UPDATE SubCategories
                      SET IsActive = CASE WHEN IsActive=1 THEN 0 ELSE 1 END
                      WHERE SubCategoryID=@id AND VendorID=@vid", con);

                cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                cmd.Parameters.Add("@vid", SqlDbType.Int)
                    .Value = Convert.ToInt32(Session["UserID"]);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadSubCategories();
        }
    }
}