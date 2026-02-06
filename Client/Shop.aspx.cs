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
        LoadShopProducts();

    }

    protected void LoadShopProducts()
    {
        string orderBy = "P.ProductID DESC";

        string sort = Request.QueryString["orderby"];
        if (sort == "date")
            orderBy = "P.CreatedAt DESC";
        else if (sort == "price")
            orderBy = "P.Price ASC";
        else if (sort == "price-desc")
            orderBy = "P.Price DESC";

        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString))
        {
            string sql = @"
        SELECT 
            P.ProductID,
            P.ProductName,
            P.Price,

            -- Main Image
            (SELECT TOP 1 ImagePath 
             FROM ProductImages 
             WHERE ProductID = P.ProductID 
             ORDER BY ImageID ASC) AS MainImage,

            -- Hover Image
            (SELECT TOP 1 ImagePath 
             FROM ProductImages 
             WHERE ProductID = P.ProductID 
             ORDER BY ImageID DESC) AS HoverImage

        FROM Products P
        WHERE P.IsBlocked = 0
        ORDER BY " + orderBy;

            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptShopProducts.DataSource = dt;
            rptShopProducts.DataBind();
        }
    }



}

