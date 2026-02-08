<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="Products.aspx.cs" Inherits="Admin_Products" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h3 class="mb-4">Product Management</h3>

<!-- FILTER BAR -->
<div class="card mb-4">
<div class="card-body">
<div class="row g-3">

    <div class="col-md-3">
        <asp:TextBox ID="txtSearch" runat="server"
            CssClass="form-control"
            placeholder="Product / Vendor" />
    </div>

    <div class="col-md-3">
        <asp:DropDownList ID="ddlCategory" runat="server"
            CssClass="form-select" />
    </div>

    <div class="col-md-3">
        <asp:DropDownList ID="ddlVendor" runat="server"
            CssClass="form-select" />
    </div>

    <div class="col-md-3">
        <asp:Button ID="btnFilter" runat="server"
            Text="Apply Filter"
            CssClass="btn btn-primary w-100"
            OnClick="btnFilter_Click" />
    </div>

</div>
</div>
</div>

<!-- PRODUCT TABLE -->
<div class="card">
<div class="card-body">

<asp:GridView ID="gvProducts" runat="server"
    CssClass="table table-bordered table-hover align-middle"
    AutoGenerateColumns="False"
    OnRowCommand="gvProducts_RowCommand">

<Columns>

    <asp:BoundField DataField="ProductName" HeaderText="Product" />
    <asp:BoundField DataField="VendorName" HeaderText="Vendor" />
    <asp:BoundField DataField="CategoryName" HeaderText="Category" />
    <asp:BoundField DataField="Price" HeaderText="Price" />
    <asp:BoundField DataField="Stock" HeaderText="Stock" />

    <asp:TemplateField HeaderText="Deal">
        <ItemTemplate>
           <%# Eval("IsDeal") != DBNull.Value && Convert.ToBoolean(Eval("IsDeal"))
    ? "<span class='badge bg-warning'>Deal</span>"
    : "<span class='badge bg-secondary'>Normal</span>" %>

        </ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Status">
        <ItemTemplate>
           <%# Eval("IsBlocked") != DBNull.Value && Convert.ToBoolean(Eval("IsBlocked"))
    ? "<span class='badge bg-danger'>Blocked</span>"
    : "<span class='badge bg-success'>Active</span>" %>

        </ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Images">
        <ItemTemplate>
            <asp:Button ID="Button1" runat="server"
                Text="View"
                CssClass="btn btn-info btn-sm"
                CommandName="Images"
                CommandArgument='<%# Eval("ProductID") %>' />
        </ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Action">
        <ItemTemplate>

            <asp:Button ID="Button2" runat="server"
                Text="Block"
                CssClass="btn btn-danger btn-sm"
                CommandName="Block"
                CommandArgument='<%# Eval("ProductID") %>'
                Visible='<%# !Convert.ToBoolean(Eval("IsBlocked")) %>' />

            <asp:Button ID="Button3" runat="server"
                Text="Unblock"
                CssClass="btn btn-success btn-sm ms-1"
                CommandName="Unblock"
                CommandArgument='<%# Eval("ProductID") %>'
                Visible='<%# Convert.ToBoolean(Eval("IsBlocked")) %>' />

            <asp:Button ID="Button4" runat="server"
                Text="Toggle Deal"
                CssClass="btn btn-warning btn-sm ms-1"
                CommandName="Deal"
                CommandArgument='<%# Eval("ProductID") %>' />

        </ItemTemplate>
    </asp:TemplateField>

</Columns>
</asp:GridView>

</div>
</div>

<!-- IMAGE MODAL -->
<div class="modal fade" id="imgModal" tabindex="-1" aria-hidden="true">

<div class="modal-dialog modal-lg">
<div class="modal-content">

<div class="modal-header">
    <h5 class="modal-title">Product Images</h5>
    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body">
    <asp:Repeater ID="rptImages" runat="server">
        <ItemTemplate>
            <img src="/Uploads/ProductImages/<%# Eval("ImagePath") %>"
                 class="img-thumbnail m-2"
                 style="width:150px;height:150px;" />
        </ItemTemplate>
    </asp:Repeater>
</div>

</div>
</div>
</div>


    <script>
        document.addEventListener("click", function (e) {
            if (e.target.matches("[data-bs-dismiss='modal'], .modal")) {
                var modal = document.getElementById("imgModal");
                modal.classList.remove("show");
                modal.style.display = "none";
                document.body.classList.remove("modal-open");
            }
        });
</script>


</asp:Content>
