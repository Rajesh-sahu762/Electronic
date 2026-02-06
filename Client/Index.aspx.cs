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

    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDeals();
            LoadCategories();
            LoadPopularProducts();
            LoadTopSellingProducts();
        }
    }


    void LoadTopSellingProducts()
    {
        SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString
        );

        SqlCommand cmd = new SqlCommand(@"
       SELECT TOP 6 *
FROM (
    SELECT
        p.ProductID,
        p.ProductName,
        p.Price,
        p.CategoryID,
        c.CategoryName,
        p.CreatedAt,

        (SELECT TOP 1 ImagePath 
         FROM ProductImages 
         WHERE ProductID = p.ProductID 
         ORDER BY ImageID ASC) AS MainImage,

        (SELECT TOP 1 ImagePath 
         FROM ProductImages 
         WHERE ProductID = p.ProductID 
         ORDER BY ImageID DESC) AS HoverImage

    FROM Products p
    INNER JOIN Categories c ON c.CategoryID = p.CategoryID
    WHERE p.IsBlocked = 0
) x
ORDER BY CreatedAt DESC;

    ", con);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        rptTopSelling.DataSource = dt;
        rptTopSelling.DataBind();
    }



    void LoadPopularProducts()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlDataAdapter da = new SqlDataAdapter(@"
            SELECT TOP 10
    p.ProductID,
    p.ProductName,
    p.Price,
    p.CategoryID,
    c.CategoryName,

    -- MAIN IMAGE
    (
        SELECT TOP 1 ImagePath
        FROM ProductImages
        WHERE ProductID = p.ProductID
        ORDER BY ImageID ASC
    ) AS MainImage,

    -- HOVER IMAGE
    (
        SELECT TOP 1 ImagePath
        FROM ProductImages
        WHERE ProductID = p.ProductID
          AND ImageID NOT IN (
              SELECT TOP 1 ImageID
              FROM ProductImages
              WHERE ProductID = p.ProductID
              ORDER BY ImageID ASC
          )
        ORDER BY ImageID ASC
    ) AS HoverImage

FROM Products p
JOIN Categories c ON c.CategoryID = p.CategoryID
WHERE p.IsBlocked = 0
ORDER BY p.CreatedAt DESC;

        ", con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            rptPopularProducts.DataSource = dt;
            rptPopularProducts.DataBind();
        }
    }


    void LoadCategories()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlDataAdapter da = new SqlDataAdapter(
                "SELECT TOP 6 CategoryID, CategoryName, ImagePath FROM Categories WHERE IsActive=1",
                con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            rptCategories.DataSource = dt;
            rptCategories.DataBind();
        }
    }

    protected void rptCategories_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView row = (DataRowView)e.Item.DataItem;
            int cid = Convert.ToInt32(row["CategoryID"]);

            Repeater rptSub = (Repeater)e.Item.FindControl("rptSub");

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand(
                    @"SELECT TOP 4 SubCategoryID, SubCategoryName, CategoryID
                  FROM SubCategories
                  WHERE CategoryID=@cid AND IsActive=1", con);

                cmd.Parameters.AddWithValue("@cid", cid);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptSub.DataSource = dt;
                rptSub.DataBind();
            }
        }
    }

    void LoadDeals()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlDataAdapter da = new SqlDataAdapter(@"
SELECT TOP 4
p.ProductID,
p.ProductName,
p.Price,
p.Stock,
c.CategoryName,
(SELECT TOP 1 ImagePath FROM ProductImages 
 WHERE ProductID=p.ProductID ORDER BY ImageID ASC) AS MainImage,
(SELECT TOP 1 ImagePath FROM ProductImages 
 WHERE ProductID=p.ProductID ORDER BY ImageID DESC) AS HoverImage
FROM Products p
INNER JOIN Categories c ON c.CategoryID=p.CategoryID
WHERE p.IsBlocked=0 AND p.IsDeal=1
ORDER BY p.ProductID DESC
", con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            rptDeals.DataSource = dt;
            rptDeals.DataBind();
        }
    }

}