using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Web.UI.WebControls;

public partial class Client_Default : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
            Response.Redirect("Login.aspx");

        if (!IsPostBack)
            LoadWishlist();
    }

    void LoadWishlist()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string sql = @"
SELECT 
    P.ProductID,
    P.ProductName,
    P.Price,
    (SELECT TOP 1 ImagePath 
     FROM ProductImages 
     WHERE ProductID = P.ProductID
     ORDER BY ImageID ASC) AS ImagePath
FROM Wishlist W
INNER JOIN Products P ON P.ProductID = W.ProductID
WHERE W.UserID = @uid";

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@uid", Session["UserID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            pnlEmpty.Visible = dt.Rows.Count == 0;
            rptWishlist.Visible = dt.Rows.Count > 0;

            rptWishlist.DataSource = dt;
            rptWishlist.DataBind();
        }
    }

    protected void rptWishlist_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int pid = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "REMOVE")
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "DELETE FROM Wishlist WHERE UserID=@u AND ProductID=@p", con);
                cmd.Parameters.AddWithValue("@u", Session["UserID"]);
                cmd.Parameters.AddWithValue("@p", pid);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadWishlist();
        }

        if (e.CommandName == "ADD")
        {
            Response.Redirect("ProductDetails.aspx?pid=" + pid);
        }
    }
}
