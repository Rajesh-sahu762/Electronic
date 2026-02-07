<%@ Page Title="" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="Wishlist.aspx.cs" Inherits="Client_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    	<div class="container">
    <div class="row">
        <div class="col-lg-12">

            <asp:Panel ID="pnlEmpty" runat="server" Visible="false"
                CssClass="woosw-popup-content-mid-message text-center"
                Style="padding:40px;font-size:18px;">
                Your wishlist is empty ❤️<br />
                <a href="Shop.aspx" class="btn btn-dark mt-3">Continue Shopping</a>
            </asp:Panel>

            <asp:Repeater ID="rptWishlist" runat="server"
                OnItemCommand="rptWishlist_ItemCommand">

                <HeaderTemplate>
                    <table class="shop_table shop_table_responsive cart">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>

                <ItemTemplate>
                    <tr>
                        <td class="product-name">
                            <img src="../Uploads/ProductImages/<%# Eval("ImagePath") %>"
                                 style="width:80px;margin-right:10px;" />
                            <%# Eval("ProductName") %>
                        </td>

                        <td>₹ <%# Eval("Price") %></td>

                        <td>
                            <asp:LinkButton ID="btnAddToCart"
                                runat="server"
                                CommandName="ADD"
                                CommandArgument='<%# Eval("ProductID") %>'
                                CssClass="btn btn-dark btn-sm">
                                Add to Cart
                            </asp:LinkButton>
                        </td>

                        <td>
                            <asp:LinkButton ID="btnRemove"
                                runat="server"
                                CommandName="REMOVE"
                                CommandArgument='<%# Eval("ProductID") %>'
                                CssClass="btn btn-link text-danger">
                                ×
                            </asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>

                <FooterTemplate>
                        </tbody>
                    </table>
                </FooterTemplate>

            </asp:Repeater>

        </div>
    </div>
</div>

</asp:Content>

