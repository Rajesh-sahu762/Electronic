using System;
using System.Collections.Generic;
using System.Configuration;
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
            if (Session["Cart"] == null)
            {
                Response.Redirect("Cart.aspx");
                return;
            }

            BindCart();
        }
    }

    void BindCart()
    {
        List<CartItem> cart = (List<CartItem>)Session["Cart"];

        rptCart.DataSource = cart;
        rptCart.DataBind();

        decimal total = 0;
        foreach (CartItem c in cart)
        {
            total += c.Price * c.Quantity;
        }

        lblTotal.Text = total.ToString("0.00");
        ViewState["Total"] = total;
    }

    protected void btnPlaceOrder_Click(object sender, EventArgs e)
    {
        if (txtAddress.Text == "" || txtCity.Text == "" ||
            txtState.Text == "" || txtPincode.Text == "")
        {
            lblMsg.Text = "Please fill delivery address";
            return;
        }

        List<CartItem> cart = (List<CartItem>)Session["Cart"];
        int userId = Convert.ToInt32(Session["UserID"]);
        decimal total = Convert.ToDecimal(ViewState["Total"]);

        int orderId = 0;

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            // 1️⃣ INSERT ORDER
            SqlCommand cmd = new SqlCommand(@"
INSERT INTO Orders
(UserID, OrderDate, TotalAmount, PaymentMode,
 OrderStatus, Address, City, State, Pincode)
OUTPUT INSERTED.OrderID
VALUES
(@uid, GETDATE(), @total, 'COD',
 'Placed', @add, @city, @state, @pin)", con);

            cmd.Parameters.AddWithValue("@uid", userId);
            cmd.Parameters.AddWithValue("@total", total);
            cmd.Parameters.AddWithValue("@add", txtAddress.Text);
            cmd.Parameters.AddWithValue("@city", txtCity.Text);
            cmd.Parameters.AddWithValue("@state", txtState.Text);
            cmd.Parameters.AddWithValue("@pin", txtPincode.Text);

            orderId = Convert.ToInt32(cmd.ExecuteScalar());

            // 2️⃣ INSERT ORDER ITEMS
            foreach (CartItem item in cart)
            {
                SqlCommand cmdItem = new SqlCommand(@"
INSERT INTO OrderItems
(OrderID, ProductID, Quantity, Price)
VALUES
(@oid, @pid, @qty, @price)", con);

                cmdItem.Parameters.AddWithValue("@oid", orderId);
                cmdItem.Parameters.AddWithValue("@pid", item.ProductID);
                cmdItem.Parameters.AddWithValue("@qty", item.Quantity);
                cmdItem.Parameters.AddWithValue("@price", item.Price);

                cmdItem.ExecuteNonQuery();
            }
        }

        // 3️⃣ CLEAR CART
        Session["Cart"] = null;

        // 4️⃣ REDIRECT SUCCESS
        Response.Redirect("OrderSuccess.aspx?id=" + orderId);
    }
}
