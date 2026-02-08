<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="Vendors.aspx.cs" Inherits="Admin_Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
.modal-body p { margin-bottom: 6px; }
.modal-body h6 { margin-top: 10px; font-weight: 600; }
</style>



<h3 class="mb-3">Vendor Management</h3>

<div class="row mb-3">
    <div class="col-md-4">
        <asp:TextBox ID="txtSearch" runat="server"
            CssClass="form-control"
            placeholder="Search by name or email" />
    </div>
    <div class="col-md-3">
        <asp:DropDownList ID="ddlStatus" runat="server"
            CssClass="form-select">
            <asp:ListItem Text="All" Value="All" />
            <asp:ListItem Text="Pending" />
            <asp:ListItem Text="Approved" />
            <asp:ListItem Text="Rejected" />
            <asp:ListItem Text="Blocked" />
        </asp:DropDownList>
    </div>
    <div class="col-md-2">
        <asp:Button ID="btnFilter" runat="server"
            Text="Apply"
            CssClass="btn btn-primary w-100"
            OnClick="btnFilter_Click" />
    </div>
</div>

<div class="card shadow-sm">
<div class="card-body">

<asp:GridView ID="gvVendors" runat="server"
    CssClass="table table-bordered table-hover align-middle"
    AutoGenerateColumns="False"
    OnRowCommand="gvVendors_RowCommand">

<Columns>

<asp:BoundField DataField="FullName" HeaderText="Vendor Name" />
<asp:BoundField DataField="Email" HeaderText="Email" />

<asp:TemplateField HeaderText="Status">
<ItemTemplate>
    <%# Eval("ApprovalStatus") %>
    <%# Convert.ToBoolean(Eval("IsBlocked")) ? " (Blocked)" : "" %>
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="View">
<ItemTemplate>
    <asp:Button ID="Button1" runat="server"
        Text="Docs"
        CssClass="btn btn-info btn-sm"
        CommandName="ViewDocs"
        CommandArgument='<%# Eval("UserID") %>' />
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Action">
<ItemTemplate>

<asp:Button ID="Button2" runat="server" Text="Approve"
    CssClass="btn btn-success btn-sm"
    CommandName="Approve"
    CommandArgument='<%# Eval("UserID") %>'
    Visible='<%# Eval("ApprovalStatus").ToString() != "Approved" %>' />

<asp:Button ID="Button3" runat="server" Text="Reject"
    CssClass="btn btn-warning btn-sm ms-1"
    CommandName="Reject"
    CommandArgument='<%# Eval("UserID") %>' />

<asp:Button ID="Button4" runat="server" Text="Block"
    CssClass="btn btn-danger btn-sm ms-1"
    CommandName="Block"
    CommandArgument='<%# Eval("UserID") %>'
    Visible='<%# !Convert.ToBoolean(Eval("IsBlocked")) %>' />

<asp:Button ID="Button5" runat="server" Text="Unblock"
    CssClass="btn btn-secondary btn-sm ms-1"
    CommandName="Unblock"
    CommandArgument='<%# Eval("UserID") %>'
    Visible='<%# Convert.ToBoolean(Eval("IsBlocked")) %>' />

</ItemTemplate>
</asp:TemplateField>

</Columns>
</asp:GridView>

</div>
</div>

<!-- DOCUMENT MODAL -->
<div class="modal fade" id="docModal" tabindex="-1" aria-hidden="true">
<div class="modal-dialog modal-lg">
<div class="modal-content">
<div class="modal-header">
<h5>Vendor Documents</h5>
<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
</div>
<div class="modal-body">
    <asp:Literal ID="litDocs" runat="server"></asp:Literal>
</div>
</div>
</div>
</div>


    <script>
        document.addEventListener("click", function (e) {
            if (e.target.matches("[data-bs-dismiss='modal'], .modal")) {
                var modal = document.getElementById("docModal");
                modal.classList.remove("show");
                modal.style.display = "none";
                document.body.classList.remove("modal-open");
            }
        });
</script>



</asp:Content>
