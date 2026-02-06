using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Client_Default : System.Web.UI.Page
{

  List<CartItem> cart;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CART"] == null)
            cart = new List<CartItem>();
        else
            cart = (List<CartItem>)Session["CART"];

        if (!IsPostBack)
            BindCart();
    }

    void BindCart()
    {
        rptCart.DataSource = cart;
        rptCart.DataBind();

        decimal total = 0;
        foreach (CartItem item in cart)
            total += item.Price * item.Quantity;

        lblTotal.Text = total.ToString("0.00");
        Session["CART"] = cart;
    }

    protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int pid = Convert.ToInt32(e.CommandArgument);
        CartItem item = cart.Find(x => x.ProductID == pid);

        if (item == null) return;

        if (e.CommandName == "PLUS")
            item.Quantity++;

        else if (e.CommandName == "MINUS")
        {
            item.Quantity--;
            if (item.Quantity <= 0)
                cart.Remove(item);
        }
        else if (e.CommandName == "REMOVE")
            cart.Remove(item);

        BindCart();
        Session["CART"] = cart;

    }

    protected void btnCheckout_Click(object sender, EventArgs e)
    {
        Response.Redirect("Checkout.aspx");
    }
}