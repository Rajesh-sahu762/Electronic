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

        string q = Request.QueryString["q"];
        string cat = Request.QueryString["cat"];
        string sub = Request.QueryString["sub"];

        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString))
        {
            string sql = @"
        SELECT DISTINCT
            P.ProductID,
            P.ProductName,
            P.Price,

            (SELECT TOP 1 ImagePath 
             FROM ProductImages 
             WHERE ProductID = P.ProductID 
             ORDER BY ImageID ASC) AS MainImage,

            (SELECT TOP 1 ImagePath 
             FROM ProductImages 
             WHERE ProductID = P.ProductID 
             ORDER BY ImageID DESC) AS HoverImage

        FROM Products P
        INNER JOIN Categories C ON P.CategoryID = C.CategoryID
        LEFT JOIN SubCategories S ON P.SubCategoryID = S.SubCategoryID
        WHERE P.IsBlocked = 0";

            // 🔍 SMART SEARCH
            if (!string.IsNullOrEmpty(q))
            {
                sql += @"
            AND (
                P.ProductName LIKE @q
                OR C.CategoryName LIKE @q
                OR S.SubCategoryName LIKE @q
            )";
            }

            // 📂 CATEGORY FILTER
            if (!string.IsNullOrEmpty(cat))
            {
                sql += " AND P.CategoryID = @cat";
            }

            // 📁 SUB CATEGORY FILTER
            if (!string.IsNullOrEmpty(sub))
            {
                sql += " AND P.SubCategoryID = @sub";
            }

            sql += " ORDER BY " + orderBy;

            SqlCommand cmd = new SqlCommand(sql, con);

            if (!string.IsNullOrEmpty(q))
                cmd.Parameters.AddWithValue("@q", "%" + q + "%");

            if (!string.IsNullOrEmpty(cat))
                cmd.Parameters.AddWithValue("@cat", cat);

            if (!string.IsNullOrEmpty(sub))
                cmd.Parameters.AddWithValue("@sub", sub);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptShopProducts.DataSource = dt;
            rptShopProducts.DataBind();
        }
    }



}

