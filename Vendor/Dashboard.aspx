<%@ Page Title="" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Vendor_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    
<h3 class="mb-4">Dashboard</h3>

<div class="row g-4">

    <div class="col-md-3">
        <div class="card shadow-sm border-0">
            <div class="card-body text-center">
                <h6>Total Products</h6>
                <h3 class="text-primary">
                    <asp:Label ID="lblProducts" runat="server" Text="0"></asp:Label>
                </h3>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card shadow-sm border-0">
            <div class="card-body text-center">
                <h6>Total Orders</h6>
                <h3 class="text-success">
                    <asp:Label ID="lblOrders" runat="server" Text="0"></asp:Label>
                </h3>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card shadow-sm border-0">
            <div class="card-body text-center">
                <h6>Pending Orders</h6>
                <h3 class="text-warning">
                    <asp:Label ID="lblPending" runat="server" Text="0"></asp:Label>
                </h3>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card shadow-sm border-0">
            <div class="card-body text-center">
                <h6>Total Revenue</h6>
                <h3 class="text-danger">
                    ₹ <asp:Label ID="lblRevenue" runat="server" Text="0"></asp:Label>
                </h3>
            </div>
        </div>
    </div>

</div>

<!-- STATUS CARD -->
<div class="card shadow-sm border-0 mt-4">
    <div class="card-body">
        <h5>Account Status</h5>
        <p>
            Status:
            <strong>
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </strong>
        </p>
        <asp:Label ID="lblRemark" runat="server"
            CssClass="text-danger"></asp:Label>
    </div>
</div>

    <hr class="my-4" />

<div class="row">

    <!-- MONTHLY SALES CHART -->
    <div class="col-md-8">
        <div class="card shadow-sm border-0">
            <div class="card-body">
                <h5 class="mb-3">Monthly Sales</h5>
                <canvas id="salesChart" height="120"></canvas>
            </div>
        </div>
    </div>

    <!-- LOW STOCK ALERT -->
    <div class="col-md-4">
        <div class="card shadow-sm border-0">
            <div class="card-body">
                <h5 class="mb-3 text-danger">Low Stock Alert</h5>

             <asp:Repeater ID="rptLowStock" runat="server">
    <ItemTemplate>
        <div class="alert alert-warning py-1 mb-2">
            <%# Eval("ProductName") %>
            (Stock: <%# Eval("Stock") %>)
        </div>
    </ItemTemplate>
</asp:Repeater>


                <asp:Label ID="lblNoLowStock" runat="server"
                    CssClass="text-success"></asp:Label>
            </div>
        </div>
    </div>

</div>

<!-- LATEST ORDERS -->
<div class="card shadow-sm border-0 mt-4">
    <div class="card-body">
        <h5 class="mb-3">Latest Orders</h5>

        <asp:GridView ID="gvLatestOrders" runat="server"
    CssClass="table table-bordered table-sm"
    AutoGenerateColumns="False">
    <Columns>
        <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
        <asp:BoundField DataField="OrderDate" HeaderText="Date" />
        <asp:BoundField DataField="TotalAmount" HeaderText="Amount" />
        <asp:BoundField DataField="OrderStatus" HeaderText="Status" />
    </Columns>
</asp:GridView>

    </div>
</div>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


</asp:Content>

