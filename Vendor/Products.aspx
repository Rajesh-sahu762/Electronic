<%@ Page Title="Products" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="Products.aspx.cs" Inherits="Vendor_Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h3 class="mb-3">My Products</h3>

<a href="ProductAdd.aspx" class="btn btn-primary mb-3">
    + Add Product
</a>

<asp:GridView ID="gvProducts" runat="server"
    CssClass="table table-hover align-middle"
    AutoGenerateColumns="False"
    OnRowCommand="gvProducts_RowCommand">

    <Columns>

        
        <asp:TemplateField HeaderText="Product Image">
            <ItemTemplate>
                <img src='<%# string.IsNullOrEmpty(Eval("ImagePath").ToString())
                    ? "/assets/no-image.png"
                    : "/Uploads/ProductImages/" + Eval("ImagePath") %>'
                    style="width:60px;height:60px;object-fit:cover;border-radius:6px;" />
            </ItemTemplate>
        </asp:TemplateField>

        
        <asp:BoundField DataField="ProductName" HeaderText="Name" />

        
        <asp:BoundField DataField="CategoryName" HeaderText="Category" />

        
        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="₹ {0:N2}" />

        
        <asp:TemplateField HeaderText="Status">
            <ItemTemplate>
                <%# Convert.ToBoolean(Eval("IsBlocked"))
                    ? "<span class='badge bg-danger'>Blocked</span>"
                    : "<span class='badge bg-success'>Approved</span>" %>
            </ItemTemplate>
        </asp:TemplateField>

        
        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>

                <asp:LinkButton ID="LinkButton1" runat="server"
                    CssClass="btn btn-sm btn-outline-warning me-1"
                    CommandName="Edit"
                    CommandArgument='<%# Eval("ProductID") %>'>
                    ✏️
                </asp:LinkButton>

                <asp:LinkButton ID="LinkButton2" runat="server"
                    CssClass="btn btn-sm btn-outline-danger"
                    CommandName="DeleteProduct"
                    CommandArgument='<%# Eval("ProductID") %>'
                    OnClientClick="return confirm('Delete product and all images?');">
                    🗑️
                </asp:LinkButton>

            </ItemTemplate>
        </asp:TemplateField>

    </Columns>
</asp:GridView>

</asp:Content>
