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
                         <td>
    <button type="button"
            class="btn btn-link text-danger"
            data-pid="<%# Eval("ProductID") %>"
            onclick="removeFromWishlist(this)">
        ×
    </button>
</td>

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


    <script>
        function removeFromWishlist(btn) {

            var pid = btn.getAttribute("data-pid");

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "<%= ResolveUrl("~/Client/Handlers/WishlistHandler.ashx") %>", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {

            try {
                var res = JSON.parse(xhr.responseText);

                if (res.status === "REMOVED") {

                    // 🔥 remove row instantly
                    var row = btn.closest("tr");
                    if (row) row.remove();

                    // 🔢 update header count
                    var countEl = document.getElementById("wishlistCount");
                    if (countEl && res.count !== undefined) {
                        countEl.innerText = res.count;
                    }

                    // ❤️ empty message
                    var table = document.querySelector(".shop_table tbody");
                    if (!table || table.children.length === 0) {
                        location.reload(); // show empty panel properly
                    }
                }

            } catch (e) {
                console.error("Wishlist remove error", e);
            }
        }
    };

    xhr.send("pid=" + encodeURIComponent(pid));
}
</script>


</asp:Content>

