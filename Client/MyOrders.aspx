<%@ Page Language="C#" MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true" CodeFile="MyOrders.aspx.cs" Inherits="Client_MyOrders" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div id="bwp-main" class="bwp-main">
<div class="container my-4">

<h3 class="mb-4 fw-bold">📦 My Orders</h3>

<asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">
<ItemTemplate>

<div class="order-card mb-4">

    <!-- HEADER -->
    <div class="order-header">
        <div>
            <div class="order-id">Order #<%# Eval("OrderID") %></div>
            <div class="order-date">
                <%# Eval("OrderDate","{0:dd MMM yyyy, hh:mm tt}") %>
            </div>
        </div>

        <div class="text-end">
            <div class="order-amount">₹ <%# Eval("TotalAmount") %></div>
            <span class="status-badge <%# Eval("OrderStatus") %>">
                <%# Eval("OrderStatus") %>
            </span>
        </div>
    </div>

    <!-- TRACKING -->
    <div class="tracking">
        <div class="step <%# StepClass(Eval("OrderStatus"),"Placed") %>">Placed</div>
        <div class="line"></div>
        <div class="step <%# StepClass(Eval("OrderStatus"),"Packed") %>">Packed</div>
        <div class="line"></div>
        <div class="step <%# StepClass(Eval("OrderStatus"),"Shipped") %>">Shipped</div>
        <div class="line"></div>
        <div class="step <%# StepClass(Eval("OrderStatus"),"Delivered") %>">Delivered</div>
    </div>

    <!-- ITEMS -->
    <div class="items">
        <asp:Repeater ID="rptItems" runat="server"
            DataSource='<%# GetItems(Eval("OrderID")) %>'>
        <ItemTemplate>
            <div class="item-row">
                <img src="../Uploads/ProductImages/<%# Eval("ImagePath") %>" />
                <div class="item-info">
                    <div class="item-name"><%# Eval("ProductName") %></div>
                    <div class="item-qty">Qty: <%# Eval("Quantity") %></div>
                </div>
                <div class="item-price">
                    ₹ <%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %>
                </div>
            </div>
        </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- ADDRESS -->
    <div class="address-box">
        <b>Delivery Address</b>
        <p>
            <%# Eval("Address") %>, <%# Eval("City") %>,  
            <%# Eval("State") %> - <%# Eval("Pincode") %>
        </p>
    </div>

    <!-- ACTION -->
    <div class="text-end">
        <asp:Button ID="btnCancel" runat="server"
            Text="Cancel Order"
            CssClass="btn btn-outline-danger btn-sm"
            CommandName="Cancel"
            CommandArgument='<%# Eval("OrderID") %>'
            Visible='<%# Eval("OrderStatus").ToString()=="Placed" || Eval("OrderStatus").ToString()=="Packed" %>' />
    </div>

</div>

</ItemTemplate>
</asp:Repeater>

</div>
</div>


    <style>
        .order-card{
    background:#fff;
    border-radius:14px;
    padding:18px;
    box-shadow:0 8px 25px rgba(0,0,0,0.08);
}

.order-header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:15px;
}

.order-id{
    font-weight:600;
    font-size:16px;
}

.order-date{
    font-size:13px;
    color:#6b7280;
}

.order-amount{
    font-size:18px;
    font-weight:700;
}

.status-badge{
    display:inline-block;
    padding:4px 10px;
    border-radius:20px;
    font-size:12px;
    color:#fff;
    margin-top:4px;
}

.status-badge.Placed{background:#3b82f6}
.status-badge.Packed{background:#8b5cf6}
.status-badge.Shipped{background:#f59e0b}
.status-badge.Delivered{background:#22c55e}
.status-badge.Cancelled{background:#ef4444}

/* TRACKING */
.tracking{
    display:flex;
    align-items:center;
    justify-content:center;
    margin:18px 0;
}

.step{
    font-size:12px;
    padding:6px 10px;
    border-radius:20px;
    background:#e5e7eb;
    color:#6b7280;
}

.step.active-step{
    background:#22c55e;
    color:#fff;
    font-weight:600;
}

.line{
    width:30px;
    height:2px;
    background:#d1d5db;
}

/* ITEMS */
.items{
    border-top:1px solid #eee;
    border-bottom:1px solid #eee;
    padding:12px 0;
}

.item-row{
    display:flex;
    align-items:center;
    gap:12px;
    margin-bottom:10px;
}

.item-row img{
    width:55px;
    height:55px;
    object-fit:cover;
    border-radius:8px;
    border:1px solid #eee;
}

.item-info{
    flex:1;
}

.item-name{
    font-weight:500;
}

.item-qty{
    font-size:13px;
    color:#6b7280;
}

.item-price{
    font-weight:600;
}

/* ADDRESS */
.address-box{
    background:#f9fafb;
    padding:12px;
    border-radius:10px;
    margin-top:12px;
    font-size:14px;
}

/* MOBILE */
@media(max-width:768px){
    .tracking{flex-wrap:wrap;gap:6px}
    .line{display:none}
}

    </style>


</asp:Content>
