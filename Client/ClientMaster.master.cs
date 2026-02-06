using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Client_ClientMaster : System.Web.UI.MasterPage
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCategories();
            HandleLoginState();
            LoadCartCount();
            LoadWishlistCount();
        }
    }

    void HandleLoginState()
    {
        if (Session["UserID"] != null && Session["Role"].ToString() == "Client")
        {
            phGuest.Visible = false;
            phUser.Visible = true;
            lblUser.Text = Session["ClientName"].ToString();
        }
    }

    void LoadCartCount()
    {
        if (Session["Cart"] != null)
        {
            DataTable dt = (DataTable)Session["Cart"];
            lblCartCount.Text = dt.Rows.Count.ToString();
        }
        else
            lblCartCount.Text = "0";
    }


    void LoadWishlistCount()
    {
        if (Session["UserID"] == null) return;

        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(
                "SELECT COUNT(*) FROM Wishlist WHERE UserID=@uid", con);
            cmd.Parameters.AddWithValue("@uid", Session["UserID"]);

            con.Open();
            lblWishCount.Text = cmd.ExecuteScalar().ToString();
        }
    }


    void LoadCategories()
    {
        DataTable dtCat = new DataTable();
        dtCat.Columns.Add("CategoryID");
        dtCat.Columns.Add("CategoryName");
        dtCat.Columns.Add("SubCategories", typeof(DataTable));

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            SqlCommand cmdCat = new SqlCommand(
                "SELECT CategoryID, CategoryName FROM Categories WHERE IsActive=1", con);

            SqlDataAdapter daCat = new SqlDataAdapter(cmdCat);
            DataTable cats = new DataTable();
            daCat.Fill(cats);

            foreach (DataRow row in cats.Rows)
            {
                DataRow dr = dtCat.NewRow();
                dr["CategoryID"] = row["CategoryID"];
                dr["CategoryName"] = row["CategoryName"];

                SqlCommand cmdSub = new SqlCommand(
                    "SELECT SubCategoryID, SubCategoryName FROM SubCategories WHERE IsActive=1 AND CategoryID=@cid", con);
                cmdSub.Parameters.AddWithValue("@cid", row["CategoryID"]);

                SqlDataAdapter daSub = new SqlDataAdapter(cmdSub);
                DataTable subs = new DataTable();
                daSub.Fill(subs);

                dr["SubCategories"] = subs;
                dtCat.Rows.Add(dr);
            }
        }

        rptCategories.DataSource = dtCat;
        rptCategories.DataBind();
    }
}