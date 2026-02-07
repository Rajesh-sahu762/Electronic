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

    protected void Page_Init(object sender, EventArgs e)
    {
        string page = Request.Url.AbsolutePath.ToLower();

        bool isProtected =
            page.Contains("cart.aspx") ||
            page.Contains("checkout.aspx") ||
            page.Contains("wishlist.aspx") ||
            page.Contains("order.aspx");

        if (isProtected)
        {
            if (Session["UserID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Client")
            {
                Response.Redirect("Login.aspx");
            }
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCategories();
            HandleLoginState();
            LoadWishlistCount();
        }

        LoadCartCount();
        LoadMiniCart();

    }

    void HandleLoginState()
    {
        bool isClient =
            Session["UserID"] != null &&
            Session["Role"] != null &&
            Session["Role"].ToString() == "Client";

        phGuest.Visible = !isClient;
        phUser.Visible = isClient;

        phHeaderGuest.Visible = !isClient;
        phHeaderUser.Visible = isClient;

        if (isClient && Session["FullName"] != null)
        {
            lblUser.Text = Session["FullName"].ToString();
            lblHeaderUser.Text = Session["FullName"].ToString();
        }
    }


    void LoadMiniCart()
    {
        if (Session["CART"] == null)
            return;

        var cart = Session["CART"] as List<CartItem>;
        if (cart == null) return;

        rptMiniCart.DataSource = cart;
        rptMiniCart.DataBind();

        upMiniCart.Update();

    }

    protected void rptMiniCart_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (Session["CART"] == null) return;

        List<CartItem> cart = Session["CART"] as List<CartItem>;
        if (cart == null) return;

        int pid = Convert.ToInt32(e.CommandArgument);

        CartItem item = cart.FirstOrDefault(x => x.ProductID == pid);
        if (item != null)
            cart.Remove(item);

        Session["CART"] = cart;

        LoadMiniCart();
        LoadCartCount();
    }



    void LoadCartCount()
    {
        int totalQty = 0;

        if (Session["CART"] != null)
        {
            List<CartItem> cart = Session["CART"] as List<CartItem>;
            if (cart != null)
            {
                foreach (CartItem item in cart)
                {
                    totalQty += item.Quantity;
                }
            }
        }

        lblCartCount.Text = totalQty.ToString();
        upCartCount.Update(); // 🔥 THIS IS THE KEY

    }




    void LoadWishlistCount()
    {
        if (Session["UserID"] == null)
        {
            lblWishCount.Text = "0";
            return;
        }

        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(
                "SELECT COUNT(*) FROM Wishlist WHERE UserID=@uid", con);
            cmd.Parameters.AddWithValue("@uid", Session["UserID"]);

            con.Open();
            int count = Convert.ToInt32(cmd.ExecuteScalar());
            lblWishCount.Text = count.ToString();
        }

        upWishCount.Update(); // 🔥 SAME AS CART
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