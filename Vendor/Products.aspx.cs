using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Vendor_Products : System.Web.UI.Page
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
            LoadProducts();
    }

    void LoadProducts()
    {
        int vendorId = Convert.ToInt32(Session["UserID"]);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(@"
                SELECT p.ProductID,
                       p.ProductName,
                       p.Price,
                       p.IsBlocked,
                       c.CategoryName,
                       ISNULL((
                            SELECT TOP 1 ImagePath 
                            FROM ProductImages 
                            WHERE ProductID = p.ProductID
                       ), '') AS ImagePath
                FROM Products p
                LEFT JOIN Categories c ON c.CategoryID = p.CategoryID
                WHERE p.VendorID = @vid", con);

            cmd.Parameters.Add("@vid", SqlDbType.Int).Value = vendorId;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvProducts.DataSource = dt;
            gvProducts.DataBind();
        }
    }

    protected void gvProducts_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int productId = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "Edit")
        {
            Response.Redirect("ProductAdd.aspx?id=" + productId);
            return;
        }

        if (e.CommandName == "DeleteProduct")
        {
          

            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();

                // delete image files
                SqlCommand imgCmd = new SqlCommand(
                    "SELECT ImagePath FROM ProductImages WHERE ProductID=@pid", con);
                imgCmd.Parameters.Add("@pid", SqlDbType.Int).Value = productId;

                SqlDataReader dr = imgCmd.ExecuteReader();
                while (dr.Read())
                {
                    string img = dr["ImagePath"].ToString();
                    string path = Server.MapPath("~/Uploads/ProductImages/" + img);
                    if (System.IO.File.Exists(path))
                        System.IO.File.Delete(path);
                }
                dr.Close();

                // delete image records
                SqlCommand delImgs = new SqlCommand(
                    "DELETE FROM ProductImages WHERE ProductID=@pid", con);
                delImgs.Parameters.Add("@pid", SqlDbType.Int).Value = productId;
                delImgs.ExecuteNonQuery();

                // delete product
                SqlCommand delProd = new SqlCommand(
                    "DELETE FROM Products WHERE ProductID=@pid AND VendorID=@vid", con);
                delProd.Parameters.Add("@pid", SqlDbType.Int).Value = productId;
                delProd.Parameters.Add("@vid", SqlDbType.Int).Value =
                    Convert.ToInt32(Session["UserID"]);
                delProd.ExecuteNonQuery();
            }

            LoadProducts();
        }

    }
}
