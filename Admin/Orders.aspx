<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Orders.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h3 class="mb-4">Orders Monitoring</h3>

<!-- FILTER BAR -->
<div class="card shadow border-0 mb-4">
    <div class="card-body">
        <div class="row g-3">

            <div class="col-md-3">
                <asp:TextBox ID="txtSearch" runat="server"
                    CssClass="form-control"
                    placeholder="Order ID / Client / Vendor" />
            </div>

            <div class="col-md-2">
                <asp:DropDownList ID="ddlStatus" runat="server"
                    CssClass="form-select">
                    <asp:ListItem Text="All Status" Value="" />
                    <asp:ListItem Text="Pending" />
                    <asp:ListItem Text="Processing" />
                    <asp:ListItem Text="Shipped" />
                    <asp:ListItem Text="Delivered" />
                    <asp:ListItem Text="Cancelled" />
                </asp:DropDownList>
            </div>

            <div class="col-md-2">
                <asp:TextBox ID="txtFrom" runat="server"
                    CssClass="form-control"
                    TextMode="Date" />
            </div>

            <div class="col-md-2">
                <asp:TextBox ID="txtTo" runat="server"
                    CssClass="form-control"
                    TextMode="Date" />
            </div>

            <div class="col-md-3">
                <asp:Button ID="btnSearch" runat="server"
                    Text="Apply Filters"
                    CssClass="btn btn-primary w-100"
                    OnClick="btnSearch_Click" />
            </div>

        </div>
    </div>
</div>

<!-- ORDERS TABLE -->
<div class="card shadow border-0">
    <div class="card-body">

        <asp:GridView ID="gvOrders" runat="server"
            CssClass="table table-bordered table-hover align-middle"
            AutoGenerateColumns="False"
            OnRowCommand="gvOrders_RowCommand" OnRowCancelingEdit="gvOrders_RowCancelingEdit">

            <Columns>

                <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
                <asp:BoundField DataField="ClientName" HeaderText="Client" />
                <asp:BoundField DataField="VendorNames" HeaderText="Vendor(s)" />
                <asp:BoundField DataField="TotalAmount" HeaderText="Amount" />
                <asp:BoundField DataField="PaymentMode" HeaderText="Payment" />
                <asp:BoundField DataField="OrderStatus" HeaderText="Status" />
                <asp:BoundField DataField="OrderDate" HeaderText="Date" />

                <asp:TemplateField HeaderText="Items">
                    <ItemTemplate>
                        <asp:Button ID="btnItems" runat="server"
                            Text="View"
                            CssClass="btn btn-info btn-sm"
                            CommandName="Items"
                            CommandArgument='<%# Eval("OrderID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:Button ID="btnCancel" runat="server"
                            Text="Cancel"
                            CssClass="btn btn-danger btn-sm"
                            CommandName="Cancel"
                            CommandArgument='<%# Eval("OrderID") %>'
                            Visible='<%# Eval("OrderStatus").ToString() != "Cancelled" && Eval("OrderStatus").ToString() != "Delivered" %>' />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

        </asp:GridView>

    </div>
</div>

<!-- ORDER ITEMS MODAL -->
<div class="modal fade" id="itemsModal" tabindex="-1" aria-hidden="true">

    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Order Items</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <asp:GridView ID="gvItems" runat="server"
                    CssClass="table table-bordered"
                    AutoGenerateColumns="True" />
            </div>
        </div>
    </div>
</div>


    <script>
        document.addEventListener("click", function (e) {
            if (e.target.matches("[data-bs-dismiss='modal'], .modal")) {
                var modal = document.getElementById("itemsModal");
                modal.classList.remove("show");
                modal.style.display = "none";
                document.body.classList.remove("modal-open");
            }
        });
</script>



</asp:Content>
