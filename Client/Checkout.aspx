<%@ Page Title="" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="Client_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <style>
/* ===== CHECKOUT PAGE ===== */
.checkout-container {
    max-width: 1100px;
    margin: auto;
}

.checkout-title {
    font-size: 26px;
    font-weight: 600;
    margin-bottom: 25px;
}

/* CARD */
.checkout-card {
    background: #ffffff;
    border-radius: 14px;
    box-shadow: 0 12px 30px rgba(0,0,0,0.08);
    border: none;
    margin-bottom: 20px;
}

.checkout-card-header {
    font-size: 16px;
    font-weight: 600;
    padding: 14px 20px;
    border-bottom: 1px solid #eee;
    background: #fafafa;
    border-radius: 14px 14px 0 0;
}

.checkout-card-body {
    padding: 20px;
}

/* INPUTS */
.checkout-input {
    height: 46px;
    border-radius: 10px;
    border: 1px solid #ddd;
    padding-left: 12px;
    margin-bottom: 14px;
    font-size: 14px;
}

.checkout-input:focus {
    border-color: #ff9800;
    box-shadow: 0 0 0 2px rgba(255,152,0,0.15);
}

/* CART ITEM */
.checkout-item {
    display: flex;
    align-items: center;
    margin-bottom: 14px;
}

.checkout-item img {
    width: 64px;
    height: 64px;
    border-radius: 10px;
    object-fit: cover;
    border: 1px solid #eee;
}

.checkout-item-info {
    margin-left: 12px;
    font-size: 14px;
}

.checkout-item-info strong {
    font-weight: 600;
    display: block;
}

/* TOTAL */
.checkout-total {
    display: flex;
    justify-content: space-between;
    font-size: 18px;
    font-weight: 600;
    margin-top: 10px;
}

/* BUTTON */
.btn-placeorder {
    height: 48px;
    border-radius: 12px;
    background: linear-gradient(135deg, #ff9800, #ff5722);
    color: #fff;
    font-weight: 600;
    border: none;
    margin-top: 15px;
    transition: all 0.3s ease;
}

.btn-placeorder:hover {
    transform: translateY(-1px);
    box-shadow: 0 10px 20px rgba(255,87,34,0.35);
}

/* SUCCESS MESSAGE */
.checkout-msg {
    text-align: center;
    margin-top: 10px;
    font-size: 14px;
}
</style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="checkout-container mt-4 mb-5">

    <div class="checkout-title">Checkout</div>

    <div class="row">

        <!-- ADDRESS -->
        <div class="col-md-7">

            <div class="checkout-card">
                <div class="checkout-card-header">
                    Delivery Address
                </div>

                <div class="checkout-card-body">

                    <asp:TextBox ID="txtAddress" runat="server"
                        CssClass="checkout-input form-control"
                        placeholder="Full Address" />

                    <asp:TextBox ID="txtCity" runat="server"
                        CssClass="checkout-input form-control"
                        placeholder="City" />

                    <asp:TextBox ID="txtState" runat="server"
                        CssClass="checkout-input form-control"
                        placeholder="State" />

                    <asp:TextBox ID="txtPincode" runat="server"
                        CssClass="checkout-input form-control"
                        placeholder="Pincode" />

                </div>
            </div>

        </div>

        <!-- ORDER SUMMARY -->
        <div class="col-md-5">

            <div class="checkout-card">
                <div class="checkout-card-header">
                    Order Summary
                </div>

                <div class="checkout-card-body">

                    <asp:Repeater ID="rptCart" runat="server">
                        <ItemTemplate>
                            <div class="checkout-item">
                                <img src="../Uploads/ProductImages/<%# Eval("ImagePath") %>" />
                                <div class="checkout-item-info">
                                    <strong><%# Eval("ProductName") %></strong>
                                    ₹ <%# Eval("Price") %> × <%# Eval("Quantity") %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <hr />

                    <div class="checkout-total">
                        <span>Total</span>
                        <span>₹ <asp:Label ID="lblTotal" runat="server" /></span>
                    </div>

                    <asp:Button ID="btnPlaceOrder" runat="server"
                        Text="Place Order"
                        CssClass="btn btn-placeorder w-100"
                        OnClick="btnPlaceOrder_Click" />

                    <asp:Label ID="lblMsg" runat="server"
                        CssClass="checkout-msg text-danger" />

                </div>
            </div>

        </div>

    </div>
</div>


</asp:Content>

