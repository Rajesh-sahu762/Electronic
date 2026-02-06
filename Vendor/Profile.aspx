<%@ Page Title="" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="Vendor_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<h3 class="mb-3">Shop Profile</h3>


<div class="alert alert-info mb-3">
    <strong>Status:</strong>
    <asp:Label ID="lblStatus" runat="server"></asp:Label>
    <br />
    <asp:Label ID="lblRemark" runat="server" CssClass="text-danger"></asp:Label>
</div>

<div class="card">
<div class="card-body">

    <label>Shop Name</label>
    <asp:TextBox ID="txtShopName" runat="server"
        CssClass="form-control mb-2" />

   <label>GST Number</label>
<asp:Label ID="lblGST" runat="server"
    CssClass="form-control bg-light mb-2"></asp:Label>


    <label>Address</label>
    <asp:TextBox ID="txtAddress" runat="server"
        CssClass="form-control mb-2"
        TextMode="MultiLine" />

    <label>Current Logo</label><br />
    <asp:Image ID="imgLogo" runat="server"
        Width="120" Height="120"
        CssClass="border mb-2" /><br />

    <label>Change Logo</label>
    <asp:FileUpload ID="fuLogo" runat="server"
        CssClass="form-control mb-2" />

    <label>Upload Document</label>
    <asp:FileUpload ID="fuDoc" runat="server"
        CssClass="form-control mb-3" />

    <asp:Button ID="btnSave" runat="server"
        Text="Update Profile"
        CssClass="btn btn-success"
        OnClick="btnSave_Click" />

    <asp:Label ID="lblMsg" runat="server"
        CssClass="text-danger d-block mt-2" />

</div>
</div>

</asp:Content>

