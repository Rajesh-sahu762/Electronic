using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

public partial class Vendor_ProductAdd : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
    int productId = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null || Session["Role"].ToString() != "Vendor")
        {
            Response.Redirect("Login.aspx");
            return;
        }

        if (Request.QueryString["id"] != null)
            int.TryParse(Request.QueryString["id"], out productId);

        if (!IsPostBack)
        {
            LoadCategories();
            if (productId > 0)
                LoadProduct();
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

            ddlCategory.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Category --", ""));
        }
    }

    void LoadSubCategories(int categoryId)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(
            @"SELECT SubCategoryID, SubCategoryName
              FROM SubCategories
              WHERE VendorID=@vid AND CategoryID=@cid AND IsActive=1", con);

            cmd.Parameters.Add("@vid", SqlDbType.Int).Value = Convert.ToInt32(Session["UserID"]);
            cmd.Parameters.Add("@cid", SqlDbType.Int).Value = categoryId;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlSubCategory.DataSource = dt;
            ddlSubCategory.DataTextField = "SubCategoryName";
            ddlSubCategory.DataValueField = "SubCategoryID";
            ddlSubCategory.DataBind();

            ddlSubCategory.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Sub Category --", ""));
        }
    }

    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlSubCategory.Items.Clear();
        int cid;
        if (int.TryParse(ddlCategory.SelectedValue, out cid))
            LoadSubCategories(cid);
    }

    void LoadProduct()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(
            @"SELECT * FROM Products
              WHERE ProductID=@id AND VendorID=@vid", con);

            cmd.Parameters.Add("@id", SqlDbType.Int).Value = productId;
            cmd.Parameters.Add("@vid", SqlDbType.Int).Value = Convert.ToInt32(Session["UserID"]);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                txtName.Text = dr["ProductName"].ToString();
                txtPrice.Text = dr["Price"].ToString();
                txtStock.Text = dr["Stock"].ToString();
                txtDesc.Text = dr["Description"].ToString();

                ddlCategory.SelectedValue = dr["CategoryID"].ToString();
                LoadSubCategories(Convert.ToInt32(dr["CategoryID"]));
                ddlSubCategory.SelectedValue = dr["SubCategoryID"].ToString();
            }
            dr.Close();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        decimal price;
        int stock, catId, subId;

        if (string.IsNullOrWhiteSpace(txtName.Text) ||
            !decimal.TryParse(txtPrice.Text, out price) ||
            !int.TryParse(txtStock.Text, out stock) ||
            !int.TryParse(ddlCategory.SelectedValue, out catId) ||
            !int.TryParse(ddlSubCategory.SelectedValue, out subId))
        {
            lblMsg.Text = "Fill all fields correctly";
            return;
        }

        int finalProductId = productId; // for edit case

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();
            SqlCommand cmd;

            if (productId > 0)
            {
                // 🔄 UPDATE PRODUCT
                cmd = new SqlCommand(@"
UPDATE Products
SET ProductName=@n,
    Price=@p,
    Stock=@s,
    Description=@d,
    CategoryID=@c,
    SubCategoryID=@sc
WHERE ProductID=@id AND VendorID=@vid", con);

                cmd.Parameters.Add("@id", SqlDbType.Int).Value = productId;
                cmd.Parameters.Add("@vid", SqlDbType.Int).Value = Convert.ToInt32(Session["UserID"]);
            }
            else
            {
                // ➕ INSERT PRODUCT
                cmd = new SqlCommand(@"
INSERT INTO Products
(VendorID, CategoryID, SubCategoryID, ProductName, Description, Price, Stock)
OUTPUT INSERTED.ProductID
VALUES (@vid,@c,@sc,@n,@d,@p,@s)", con);

                cmd.Parameters.Add("@vid", SqlDbType.Int).Value = Convert.ToInt32(Session["UserID"]);
            }

            cmd.Parameters.Add("@c", SqlDbType.Int).Value = catId;
            cmd.Parameters.Add("@sc", SqlDbType.Int).Value = subId;
            cmd.Parameters.Add("@n", SqlDbType.NVarChar).Value = txtName.Text.Trim();
            cmd.Parameters.Add("@d", SqlDbType.NVarChar).Value = txtDesc.Text.Trim();
            cmd.Parameters.Add("@p", SqlDbType.Decimal).Value = price;
            cmd.Parameters.Add("@s", SqlDbType.Int).Value = stock;

            if (productId > 0)
            {
                cmd.ExecuteNonQuery();
            }
            else
            {
                finalProductId = Convert.ToInt32(cmd.ExecuteScalar());
            }

            // 🖼️ SAVE PRODUCT IMAGES (🔥 FIX PART 🔥)
            if (fuProductImages.HasFiles)
            {
                foreach (HttpPostedFile file in fuProductImages.PostedFiles)
                {
                    string fileName = Guid.NewGuid().ToString() +
                                      System.IO.Path.GetExtension(file.FileName);

                    string savePath = Server.MapPath("~/Uploads/ProductImages/" + fileName);
                    file.SaveAs(savePath);

                    SqlCommand imgCmd = new SqlCommand(
                        "INSERT INTO ProductImages (ProductID, ImagePath) VALUES (@pid,@img)", con);

                    imgCmd.Parameters.Add("@pid", SqlDbType.Int).Value = finalProductId;
                    imgCmd.Parameters.Add("@img", SqlDbType.NVarChar).Value = fileName;
                    imgCmd.ExecuteNonQuery();
                }
            }
        }

        Response.Redirect("Products.aspx");
    }

}
