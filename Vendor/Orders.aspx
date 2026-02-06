<%@ Page Title="" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master" AutoEventWireup="true" CodeFile="Orders.aspx.cs" Inherits="Vendor_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<h3 class="mb-3">My Orders</h3>


<div class="row mb-3">
    <div class="col-md-3">
        <asp:TextBox ID="txtSearch" runat="server"
            CssClass="form-control"
            placeholder="Search Order / Client" />
    </div>

    <div class="col-md-3">
        <asp:TextBox ID="txtFrom" runat="server"
            CssClass="form-control"
            TextMode="Date" />
    </div>

    <div class="col-md-3">
        <asp:TextBox ID="txtTo" runat="server"
            CssClass="form-control"
            TextMode="Date" />
    </div>

    <div class="col-md-3">
        <asp:Button ID="btnFilter" runat="server"
            Text="Apply"
            CssClass="btn btn-primary w-100"
            OnClick="btnFilter_Click" />
    </div>
</div>

<asp:GridView ID="gvOrders" runat="server"
    CssClass="table table-bordered table-hover align-middle"
    AutoGenerateColumns="False"
    OnRowCommand="gvOrders_RowCommand">

    <Columns>

        <asp:BoundField DataField="OrderID" HeaderText="Order #" />
        <asp:BoundField DataField="OrderDate" HeaderText="Date"
            DataFormatString="{0:dd-MMM-yyyy}" />
        <asp:BoundField DataField="ClientName" HeaderText="Client" />
        <asp:BoundField DataField="TotalAmount" HeaderText="Amount" />


        <asp:TemplateField HeaderText="Status">
            <ItemTemplate>
                <span class='badge
                <%# Eval("OrderStatus").ToString()=="Pending" ? "bg-warning text-dark" :
                    Eval("OrderStatus").ToString()=="Packed" ? "bg-info" :
                    Eval("OrderStatus").ToString()=="Shipped" ? "bg-primary" :
                    Eval("OrderStatus").ToString()=="Cancelled" ? "bg-danger" :
                    "bg-success" %>'>
                    <%# Eval("OrderStatus") %>
                </span>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:BoundField DataField="PaymentMode" HeaderText="Payment" />


        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>

                <asp:LinkButton ID="LinkButton1" runat="server"
                    CommandName="Items"
                    CommandArgument='<%# Eval("OrderID") %>'
                    CssClass="btn btn-sm btn-outline-primary">
                    Items
                </asp:LinkButton>

                <asp:LinkButton ID="LinkButton2" runat="server"
                    CommandName="NextStatus"
                    CommandArgument='<%# Eval("OrderID") %>'
                    CssClass="btn btn-sm btn-outline-success ms-1"
                    Visible='<%# Eval("OrderStatus").ToString()!="Delivered" 
                               && Eval("OrderStatus").ToString()!="Cancelled" %>'>
                    Update
                </asp:LinkButton>

                <asp:LinkButton ID="LinkButton3" runat="server"
                    CommandName="CancelOrder"
                    CommandArgument='<%# Eval("OrderID") %>'
                    CssClass="btn btn-sm btn-outline-danger ms-1"
                    Visible='<%# Eval("OrderStatus").ToString()=="Pending" 
                               || Eval("OrderStatus").ToString()=="Packed" %>'>
                    Cancel
                </asp:LinkButton>

            </ItemTemplate>
        </asp:TemplateField>

    </Columns>

</asp:GridView>

<hr />


<asp:Panel ID="pnlItems" runat="server" Visible="false">
    <h5>Order Items (Order #<asp:Label ID="lblOrderId" runat="server" />)</h5>

    <asp:GridView ID="gvItems" runat="server"
        CssClass="table table-sm table-bordered"
        AutoGenerateColumns="False">

        <Columns>
            <asp:BoundField DataField="ProductName" HeaderText="Product" />
            <asp:BoundField DataField="Quantity" HeaderText="Qty" />
            <asp:BoundField DataField="Price" HeaderText="Price" />
        </Columns>

    </asp:GridView>
</asp:Panel>

</asp:Content>
