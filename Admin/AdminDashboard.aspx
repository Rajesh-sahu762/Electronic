<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AdminDashboard.aspx.cs" Inherits="Admin_Default" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

   <h3 class="mb-4">Dashboard</h3>

    <div class="row g-4">

        <!-- TOTAL VENDORS -->
        <div class="col-md-3">
            <div class="card shadow border-0">
                <div class="card-body text-center">
                    <h6 class="text-muted">Total Vendors</h6>
                    <h2 class="text-primary">
                        <asp:Label ID="lblVendors" runat="server"></asp:Label>
                    </h2>
                </div>
            </div>
        </div>

        <!-- PENDING VENDORS -->
        <div class="col-md-3">
            <div class="card shadow border-0">
                <div class="card-body text-center">
                    <h6 class="text-muted">Pending Approval</h6>
                    <h2 class="text-warning">
                        <asp:Label ID="lblPendingVendors" runat="server"></asp:Label>
                    </h2>
                </div>
            </div>
        </div>

        <!-- TOTAL PRODUCTS -->
        <div class="col-md-3">
            <div class="card shadow border-0">
                <div class="card-body text-center">
                    <h6 class="text-muted">Total Products</h6>
                    <h2 class="text-success">
                        <asp:Label ID="lblProducts" runat="server"></asp:Label>
                    </h2>
                </div>
            </div>
        </div>

        <!-- TOTAL ORDERS -->
        <div class="col-md-3">
            <div class="card shadow border-0">
                <div class="card-body text-center">
                    <h6 class="text-muted">Total Orders</h6>
                    <h2 class="text-danger">
                        <asp:Label ID="lblOrders" runat="server"></asp:Label>
                    </h2>
                </div>
            </div>
        </div>

    </div>

</asp:Content>