using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Admin_Categories : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            LoadCategories();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string name = txtCategory.Text.Trim();

        if (name == "")
        {
            lblMsg.Text = "Enter category name";
            return;
        }

        string imgName = null;

        if (fuImage.HasFile)
        {
            imgName = Guid.NewGuid() + Path.GetExtension(fuImage.FileName);
            fuImage.SaveAs(Server.MapPath("~/Uploads/CategoryImages/" + imgName));
        }

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            SqlCommand cmd;

            if (hfCategoryId.Value == "")
            {
                cmd = new SqlCommand(
                @"INSERT INTO Categories (CategoryName, ImagePath, IsActive)
                  VALUES (@n,@i,1)", con);
            }
            else
            {
                cmd = new SqlCommand(
                @"UPDATE Categories
                  SET CategoryName=@n,
                      ImagePath=ISNULL(@i,ImagePath)
                  WHERE CategoryID=@id", con);

                cmd.Parameters.AddWithValue("@id",
                    Convert.ToInt32(hfCategoryId.Value));
            }

            cmd.Parameters.AddWithValue("@n", name);
            cmd.Parameters.AddWithValue("@i",
                (object)imgName ?? DBNull.Value);

            cmd.ExecuteNonQuery();
        }

        txtCategory.Text = "";
        hfCategoryId.Value = "";
        lblMsg.Text = "";

        LoadCategories();
    }

    void LoadCategories()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlDataAdapter da = new SqlDataAdapter(
                "SELECT CategoryID, CategoryName, ImagePath, IsActive FROM Categories", con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvCategories.DataSource = dt;
            gvCategories.DataBind();
        }
    }

    protected void gvCategories_RowCommand(object sender,
        System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int id = Convert.ToInt32(e.CommandArgument);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            if (e.CommandName == "EditRow")
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT CategoryName FROM Categories WHERE CategoryID=@id", con);
                cmd.Parameters.AddWithValue("@id", id);

                txtCategory.Text = Convert.ToString(cmd.ExecuteScalar());
                hfCategoryId.Value = id.ToString();
            }

            if (e.CommandName == "Deactivate")
            {
                new SqlCommand(
                    "UPDATE Categories SET IsActive=0 WHERE CategoryID=" + id, con)
                    .ExecuteNonQuery();
            }

            if (e.CommandName == "Activate")
            {
                new SqlCommand(
                    "UPDATE Categories SET IsActive=1 WHERE CategoryID=" + id, con)
                    .ExecuteNonQuery();
            }
        }

        LoadCategories();
    }
}
