<%@ Page Title="" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true" CodeFile="Cart.aspx.cs" Inherits="Client_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

<style>
.cart-table img{width:70px}
.qty-btn{padding:4px 10px;border:1px solid #ccc;background:#f5f5f5;cursor:pointer}
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container">
    <h2>Your Cart</h2>

    <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
        <HeaderTemplate>
            <table class="table cart-table">
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Qty</th>
                        <th>Total</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
        </HeaderTemplate>

        <ItemTemplate>
            <tr>
                <td>
                    <img src="../Uploads/ProductImages/<%# Eval("ImagePath") %>" />
                </td>
                <td><%# Eval("ProductName") %></td>
                <td>₹ <%# Eval("Price") %></td>
                <td>
                    <asp:LinkButton ID="LinkButton1" runat="server" Text="−"
                        CssClass="qty-btn"
                        CommandName="MINUS"
                        CommandArgument='<%# Eval("ProductID") %>' />
                    <%# Eval("Quantity") %>
                    <asp:LinkButton ID="LinkButton2" runat="server" Text="+"
                        CssClass="qty-btn"
                        CommandName="PLUS"
                        CommandArgument='<%# Eval("ProductID") %>' />
                </td>
                <td>
                    ₹ <%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %>
                </td>
                <td>
                    <asp:LinkButton ID="LinkButton3" runat="server" Text="Remove"
                        CommandName="REMOVE"
                        CommandArgument='<%# Eval("ProductID") %>' />
                </td>
            </tr>
        </ItemTemplate>

        <FooterTemplate>
                </tbody>
            </table>
        </FooterTemplate>
    </asp:Repeater>

    <h4>Total: ₹ <asp:Label ID="lblTotal" runat="server" /></h4>

    <asp:Button ID="btnCheckout" runat="server"
        Text="Place Order"
        CssClass="button"
        OnClick="btnCheckout_Click" />
</div>

</asp:Content>