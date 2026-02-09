using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Client_Default : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
            return;
        }

        if (!IsPostBack)
        {
            string mode = Request.QueryString["mode"];

            if (mode == "buynow")
            {
                LoadBuyNowProduct();
            }
            else
            {
                if (Session["Cart"] == null)
                {
                    Response.Redirect("Cart.aspx");
                    return;
                }

                BindCart();
            }
        }
    }



    void LoadBuyNowProduct()
    {
        BuyNowModel item = Session["BuyNowItem"] as BuyNowModel;

        if (item == null)
        {
            Response.Redirect("Cart.aspx");
            return;
        }

        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString))
        {
            SqlCommand cmd = new SqlCommand(@"
            SELECT ProductID, ProductName, Price
            FROM Products
            WHERE ProductID = @pid", con);

            cmd.Parameters.AddWithValue("@pid", item.ProductID);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptCheckout.DataSource = dt;
            rptCheckout.DataBind();
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
        if (txtAddress.Text.Trim() == "" ||
            txtCity.Text.Trim() == "" ||
            txtState.Text.Trim() == "" ||
            txtPincode.Text.Trim() == "")
        {
            lblMsg.Text = "Please fill delivery address";
            return;
        }

        int userId = Convert.ToInt32(Session["UserID"]);
        string mode = Request.QueryString["mode"];

        int orderId = 0;
        decimal total = 0;

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();
            SqlTransaction tx = con.BeginTransaction();

            try
            {
                // 🔥 ORDER MASTER
                SqlCommand cmdOrder = new SqlCommand(@"
INSERT INTO Orders
(UserID, OrderDate, TotalAmount, PaymentMode, OrderStatus)
OUTPUT INSERTED.OrderID
VALUES
(@uid, GETDATE(), @total, 'COD', 'Placed')", con, tx);

                // ===== BUY NOW =====
                if (mode == "buynow")
                {
                    BuyNowModel item = Session["BuyNowItem"] as BuyNowModel;
                    if (item == null)
                    {
                        Response.Redirect("Cart.aspx");
                        return;
                    }

                    SqlCommand priceCmd = new SqlCommand(
                        "SELECT Price FROM Products WHERE ProductID=@pid", con, tx);
                    priceCmd.Parameters.AddWithValue("@pid", item.ProductID);

                    decimal price = Convert.ToDecimal(priceCmd.ExecuteScalar());
                    total = price * item.Qty;

                    cmdOrder.Parameters.AddWithValue("@uid", userId);
                    cmdOrder.Parameters.AddWithValue("@total", total);

                    orderId = Convert.ToInt32(cmdOrder.ExecuteScalar());

                    InsertAddress(con, tx, orderId);

                    SqlCommand cmdItem = new SqlCommand(@"
INSERT INTO OrderItems
(OrderID, ProductID, Quantity, Price)
VALUES
(@oid, @pid, @qty, @price)", con, tx);

                    cmdItem.Parameters.AddWithValue("@oid", orderId);
                    cmdItem.Parameters.AddWithValue("@pid", item.ProductID);
                    cmdItem.Parameters.AddWithValue("@qty", item.Qty);
                    cmdItem.Parameters.AddWithValue("@price", price);
                    cmdItem.ExecuteNonQuery();

                    Session["BuyNowItem"] = null;
                }
                // ===== CART =====
                else
                {
                    List<CartItem> cart = (List<CartItem>)Session["Cart"];

                    foreach (CartItem c in cart)
                        total += c.Price * c.Quantity;

                    cmdOrder.Parameters.AddWithValue("@uid", userId);
                    cmdOrder.Parameters.AddWithValue("@total", total);

                    orderId = Convert.ToInt32(cmdOrder.ExecuteScalar());

                    InsertAddress(con, tx, orderId);

                    foreach (CartItem item in cart)
                    {
                        SqlCommand cmdItem = new SqlCommand(@"
INSERT INTO OrderItems
(OrderID, ProductID, Quantity, Price)
VALUES
(@oid, @pid, @qty, @price)", con, tx);

                        cmdItem.Parameters.AddWithValue("@oid", orderId);
                        cmdItem.Parameters.AddWithValue("@pid", item.ProductID);
                        cmdItem.Parameters.AddWithValue("@qty", item.Quantity);
                        cmdItem.Parameters.AddWithValue("@price", item.Price);
                        cmdItem.ExecuteNonQuery();
                    }

                    Session["Cart"] = null;
                }

                tx.Commit();
            }
            catch
            {
                tx.Rollback();
                lblMsg.Text = "Order failed. Please try again.";
                return;
            }
        }

        Response.Redirect("OrderSuccess.aspx?id=" + orderId);
    }

    void InsertAddress(SqlConnection con, SqlTransaction tx, int orderId)
    {
        SqlCommand cmdAddr = new SqlCommand(@"
INSERT INTO OrderAddress
(OrderID, Address, City, State, Pincode)
VALUES
(@oid, @add, @city, @state, @pin)", con, tx);

        cmdAddr.Parameters.AddWithValue("@oid", orderId);
        cmdAddr.Parameters.AddWithValue("@add", txtAddress.Text.Trim());
        cmdAddr.Parameters.AddWithValue("@city", txtCity.Text.Trim());
        cmdAddr.Parameters.AddWithValue("@state", txtState.Text.Trim());
        cmdAddr.Parameters.AddWithValue("@pin", txtPincode.Text.Trim());

        cmdAddr.ExecuteNonQuery();
    }


}
