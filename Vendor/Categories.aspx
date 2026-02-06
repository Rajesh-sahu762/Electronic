<%@ Page Title="" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master" AutoEventWireup="true" CodeFile="Categories.aspx.cs" Inherits="Vendor_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<h3 class="mb-3">Categories</h3>

<!-- ADMIN CATEGORIES -->
<div class="card mb-4">
    <div class="card-header">
        <strong>Admin Categories</strong>
    </div>
    <div class="card-body">
        <asp:Repeater ID="rptCategories" runat="server">
            <ItemTemplate>
                <span class="badge bg-secondary me-2 mb-2">
                    <%# Eval("CategoryName") %>
                </span>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

<!-- ADD SUB CATEGORY -->
<div class="card mb-4">
    <div class="card-header">
        <strong>Add Sub-Category</strong>
    </div>
    <div class="card-body">

        <div class="row">
            <div class="col-md-4">
                <asp:DropDownList ID="ddlCategory" runat="server"
                    CssClass="form-select mb-2" />
            </div>

            <div class="col-md-4">
                <asp:TextBox ID="txtSubCategory" runat="server"
                    CssClass="form-control mb-2"
                    Placeholder="Sub-Category name" />
            </div>

            <div class="col-md-4">
                <asp:Button ID="btnAdd" runat="server"
                    Text="Add"
                    CssClass="btn btn-primary"
                    OnClick="btnAdd_Click" />
            </div>
        </div>

        <asp:Label ID="lblMsg" runat="server"
            CssClass="text-danger mt-2 d-block"></asp:Label>

    </div>
</div>

<!-- SUB CATEGORY LIST -->
<div class="card">
    <div class="card-header">
        <strong>My Sub-Categories</strong>
    </div>
    <div class="card-body">

        <asp:GridView ID="gvSub" runat="server"
            CssClass="table table-hover align-middle"
            AutoGenerateColumns="False"
            OnRowCommand="gvSub_RowCommand">

            <Columns>

                <asp:BoundField DataField="CategoryName" HeaderText="Category" />
                <asp:BoundField DataField="SubCategoryName" HeaderText="Sub-Category" />

                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <%# Convert.ToBoolean(Eval("IsActive"))
                            ? "<span class='badge bg-success'>Active</span>"
                            : "<span class='badge bg-secondary'>Inactive</span>" %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>

                        <asp:LinkButton ID="LinkButton1" runat="server"
                            CommandName="Toggle"
                            CommandArgument='<%# Eval("SubCategoryID") %>'
                            CssClass="btn btn-sm btn-outline-secondary">
                            Toggle
                        </asp:LinkButton>

                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>

    </div>
</div>

</asp:Content>

