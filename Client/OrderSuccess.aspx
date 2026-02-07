<%@ Page Language="C#" AutoEventWireup="true"
    MasterPageFile="~/Client/ClientMaster.master"
    CodeFile="OrderSuccess.aspx.cs"
    Inherits="Client_OrderSuccess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>

    .card {
    border-radius: 14px !important;
}


.success-box{
    background:#fff;
    border-radius:14px;
    padding:30px;
    box-shadow:0 15px 35px rgba(0,0,0,0.12);
}
.success-icon{
    font-size:70px;
    color:#22c55e;
}
.order-card{
    background:#f9fafb;
    border-radius:10px;
    padding:15px;
}
.product-img{
    width:60px;
    height:60px;
    object-fit:cover;
    border-radius:8px;
}
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div id="bwp-main" class="bwp-main">
<div class="container">

<div class="row justify-content-center">
<div class="col-xl-8 col-lg-9 col-md-12">

<!-- SUCCESS CARD -->
<div class="card shadow-lg border-0 text-center p-4 mb-4">
    <div style="font-size:70px;color:#22c55e;">✔</div>
    <h3 class="mt-2">Order Placed Successfully</h3>
    <p class="text-muted">
        Order ID :
        <b>#<asp:Label ID="lblOrderId" runat="server" /></b>
    </p>
</div>

<!-- ORDER + ADDRESS -->
<div class="row mb-4">
    <div class="col-md-4">
        <div class="card border-0 shadow-sm p-3 h-100">
            <h6>Order Details</h6>
            <p>Date : <b><asp:Label ID="lblDate" runat="server" /></b></p>
            <p>Payment : <b>Cash on Delivery</b></p>
            <span class="badge bg-warning text-dark w-50">Placed</span>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card border-0 shadow-sm p-3 h-100">
            <h6>Delivery Address</h6>
            <asp:Label ID="lblAddress" runat="server" />
        </div>
    </div>

    <!-- ITEMS -->
<div class="col-md-4">
<div class="card-body">
<h5 class="mb-3">Order Items</h5>

<asp:Repeater ID="rptItems" runat="server">
<ItemTemplate>
<div class="d-flex align-items-center mb-3 border-bottom pb-2">
    <img src="../Uploads/ProductImages/<%# Eval("ImagePath") %>"
         style="width:60px;height:60px;border-radius:8px;object-fit:cover"
         class="me-3" />

    <div class="flex-grow-1">
        <b><%# Eval("ProductName") %></b><br />
        Qty: <%# Eval("Quantity") %> × ₹<%# Eval("Price") %>
    </div>

    <div class="fw-bold">
        ₹ <%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %>
    </div>
</div>
</ItemTemplate>
</asp:Repeater>

<h4 class="text-end mt-3">
Total : ₹ <asp:Label ID="lblTotal" runat="server" />
</h4>

</div>
</div>


</div>



<!-- ACTIONS -->
<div class="text-center mt-4">
    <a href="MyOrders.aspx" class="btn btn-primary me-2">My Orders</a>
    <a href="Index.aspx" class="btn btn-outline-secondary">Continue Shopping</a>
</div>

</div>
</div>

</div>
</div>

</asp:Content>

