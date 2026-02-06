<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="Categories.aspx.cs" Inherits="Admin_Categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h3 class="mb-4">Category Management</h3>

<div class="card mb-4">
<div class="card-body">

    <asp:HiddenField ID="hfCategoryId" runat="server" />

    <div class="row g-3">
        <div class="col-md-4">
            <label>Category Name</label>
            <asp:TextBox ID="txtCategory" runat="server"
                CssClass="form-control" />
        </div>

        <div class="col-md-4">
            <label>Category Image</label>
            <asp:FileUpload ID="fuImage" runat="server"
                CssClass="form-control" />
        </div>

        <div class="col-md-4 d-flex align-items-end">
            <asp:Button ID="btnSave" runat="server"
                Text="Save Category"
                CssClass="btn btn-primary w-100"
                OnClick="btnSave_Click" />
        </div>
    </div>

    <asp:Label ID="lblMsg" runat="server"
        CssClass="text-danger mt-2 d-block" />

</div>
</div>

<div class="card">
<div class="card-body">

    <asp:GridView ID="gvCategories" runat="server"
        CssClass="table table-bordered table-hover align-middle"
        AutoGenerateColumns="False"
        OnRowCommand="gvCategories_RowCommand">

        <Columns>

            <asp:TemplateField HeaderText="Image">
                <ItemTemplate>
                    <img src="/Uploads/CategoryImages/<%# Eval("ImagePath") %>"
                         style="width:60px;height:60px;object-fit:cover;" />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="CategoryName" HeaderText="Category" />

            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <%# Convert.ToBoolean(Eval("IsActive"))
                        ? "<span class='badge bg-success'>Active</span>"
                        : "<span class='badge bg-secondary'>Inactive</span>" %>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>

                    <asp:Button ID="Button1" runat="server"
                        Text="Edit"
                        CssClass="btn btn-warning btn-sm"
                        CommandName="EditRow"
                        CommandArgument='<%# Eval("CategoryID") %>' />

                    <asp:Button ID="Button2" runat="server"
                        Text="Deactivate"
                        CssClass="btn btn-danger btn-sm ms-1"
                        CommandName="Deactivate"
                        CommandArgument='<%# Eval("CategoryID") %>'
                        Visible='<%# Convert.ToBoolean(Eval("IsActive")) %>' />

                    <asp:Button ID="Button3" runat="server"
                        Text="Activate"
                        CssClass="btn btn-success btn-sm ms-1"
                        CommandName="Activate"
                        CommandArgument='<%# Eval("CategoryID") %>'
                        Visible='<%# !Convert.ToBoolean(Eval("IsActive")) %>' />

                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>

</div>
</div>

</asp:Content>
