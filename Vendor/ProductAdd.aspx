<%@ Page Title="" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="ProductAdd.aspx.cs" Inherits="Vendor_ProductAdd" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h3 class="mb-3">Add / Edit Product</h3>

<asp:TextBox ID="txtName" runat="server"
    CssClass="form-control mb-2"
    placeholder="Product Name" />

<asp:TextBox ID="txtPrice" runat="server"
    CssClass="form-control mb-2"
    placeholder="Price" />

<asp:TextBox ID="txtStock" runat="server"
    CssClass="form-control mb-2"
    placeholder="Stock" />

<!-- MAIN CATEGORY -->
<asp:DropDownList ID="ddlCategory" runat="server"
    CssClass="form-select mb-2"
    AutoPostBack="true"
    OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" />

<!-- SUB CATEGORY -->
<asp:DropDownList ID="ddlSubCategory" runat="server"
    CssClass="form-select mb-2" />

<asp:TextBox ID="txtDesc" runat="server"
    CssClass="form-control mb-3"
    TextMode="MultiLine"
    placeholder="Description" />

<label>Product Images</label>
<asp:FileUpload ID="fuProductImages" runat="server"
    CssClass="form-control mb-2"
    AllowMultiple="true" />

<asp:Button ID="btnSave" runat="server"
    Text="Save Product"
    CssClass="btn btn-success"
    OnClick="btnSave_Click" />

<asp:Label ID="lblMsg" runat="server"
    CssClass="text-danger d-block mt-2" />

</asp:Content>
