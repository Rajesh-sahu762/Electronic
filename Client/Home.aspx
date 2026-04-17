<%@ Page Title="" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Client_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- HERO -->
<div class="p-5 mb-4 bg-light rounded-3">
<div class="container-fluid py-4">
    <h1 class="display-6 fw-bold">Electronics that inspire</h1>
    <p class="col-md-8 fs-5">
        Discover premium gadgets from trusted vendors
    </p>
</div>
</div>

<!-- PRODUCTS -->
<h4 class="mb-3">Featured Products</h4>

<div class="row">
<asp:Repeater ID="rptProducts" runat="server">
<ItemTemplate>
    <div class="col-md-3 mb-4">
        <div class="card h-100 shadow-sm">
            <img src="/Uploads/ProductImages/<%# Eval("ImagePath") %>"
                 class="card-img-top"
                 style="height:180px; object-fit:cover;" />

            <div class="card-body">
                <h6 class="card-title"><%# Eval("ProductName") %></h6>
                <p class="fw-bold text-primary">₹ <%# Eval("Price") %></p>
                <a href="ProductDetail.aspx?id=<%# Eval("ProductID") %>"
                   class="btn btn-sm btn-outline-primary w-100">
                    View Product
                </a>
            </div>
        </div>
    </div>
</ItemTemplate>
</asp:Repeater>
</div>


</asp:Content>

