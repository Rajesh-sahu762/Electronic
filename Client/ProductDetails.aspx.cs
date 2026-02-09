using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Client_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["pid"] == null)
                Response.Redirect("Shop.aspx");

            LoadProduct();
            LoadImages();
            LoadRelatedProducts();
        }
    }


    void LoadRelatedProducts()
    {
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString))
        {
            string sql = @"
SELECT TOP 8 
    P.ProductID,
    P.ProductName,
    P.Price,

    -- MAIN IMAGE
    (SELECT TOP 1 ImagePath 
     FROM ProductImages 
     WHERE ProductID = P.ProductID
     ORDER BY ImageID ASC) AS MainImage,

    -- HOVER IMAGE
    (SELECT TOP 1 ImagePath 
     FROM ProductImages 
     WHERE ProductID = P.ProductID
     ORDER BY ImageID DESC) AS HoverImage

FROM Products P
WHERE P.IsBlocked = 0
  AND P.ProductID <> @ProductID
ORDER BY NEWID()";


            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@ProductID", Request.QueryString["pid"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptRelated.DataSource = dt;
            rptRelated.DataBind();
        }
    }


    void LoadProduct()
    {
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString))
        {
            string sql = @"
            SELECT 
                ProductID,
                ProductName,
                Description,
                Price,
                Stock
            FROM Products
            WHERE ProductID = @ProductID
              AND IsBlocked = 0";

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@ProductID", Request.QueryString["pid"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            fvProduct.DataSource = dt;
            fvProduct.DataBind();
        }
    }

    protected void btnAddToCart_Click(object sender, EventArgs e)
    {
        int productId = Convert.ToInt32(Request.QueryString["pid"]);

        int quantity = 1;
        if (Request.Form["quantity"] != null)
        {
            int.TryParse(Request.Form["quantity"], out quantity);
            if (quantity <= 0) quantity = 1;
        }

        string productName = "";
        decimal price = 0;
        string imagePath = "";

        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString))
        {
            string sql = @"
        SELECT 
            P.ProductName,
            P.Price,
            (SELECT TOP 1 ImagePath 
             FROM ProductImages 
             WHERE ProductID = P.ProductID 
             ORDER BY ImageID ASC) AS ImagePath
        FROM Products P
        WHERE P.ProductID = @ProductID";

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@ProductID", productId);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                productName = dr["ProductName"].ToString();
                price = Convert.ToDecimal(dr["Price"]);
                imagePath = dr["ImagePath"].ToString();
            }
            dr.Close();
        }

        List<CartItem> cart;
        if (Session["CART"] == null)
            cart = new List<CartItem>();
        else
            cart = (List<CartItem>)Session["CART"];

        CartItem existing = cart.Find(x => x.ProductID == productId);

        if (existing != null)
        {
            existing.Quantity += quantity;
        }
        else
        {
            cart.Add(new CartItem
            {
                ProductID = productId,
                ProductName = productName,
                Price = price,
                ImagePath = imagePath,
                Quantity = quantity
            });
        }

        Session["CART"] = cart;

        Response.Redirect("Cart.aspx");
    }




    void LoadImages()
    {
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString))
        {
            string sql = @"
            SELECT ImagePath
            FROM ProductImages
            WHERE ProductID = @ProductID
            ORDER BY ImageID ASC";

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@ProductID", Request.QueryString["pid"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptThumbs.DataSource = dt;
            rptThumbs.DataBind();

            rptMainImages.DataSource = dt;
            rptMainImages.DataBind();

            rptMainImagesBig.DataSource = dt;
            rptMainImagesBig.DataBind();


        }
    }


    protected void btnBuyNow_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
            return;
        }

        int pid = Convert.ToInt32(Request.QueryString["pid"]);

        // 🔥 clear old buy-now item
        Session["BuyNowItem"] = null;

        // 🔥 store only THIS product
        Session["BuyNowItem"] = new BuyNowModel
        {
            ProductID = pid,
            Qty = 1
        };

        // 🔥 redirect to checkout
        Response.Redirect("Checkout.aspx?mode=buynow");
    }

}