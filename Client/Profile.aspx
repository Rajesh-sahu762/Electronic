<%@ Page Language="C#" AutoEventWireup="true"
    MasterPageFile="~/Client/ClientMaster.master"
    CodeFile="Profile.aspx.cs" Inherits="Client_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
/* ===== ACCOUNT PAGE UX ===== */

    .space {
    margin:10px;
    }

.account-wrap{
    max-width:1200px;
    margin:auto;
}

/* CARD BASE */
.account-card{
    background:#fff;
    border-radius:16px;
    box-shadow:0 12px 30px rgba(0,0,0,.08);
    padding:28px;
}

/* TITLES */
.account-title{
    font-size:18px;
    font-weight:600;
    margin-bottom:20px;
    display:flex;
    align-items:center;
    gap:8px;
}

/* INPUTS */
.account-card .form-control{
    border-radius:10px;
    padding:12px 14px;
    border:1px solid #e5e7eb;
}

.account-card label{
    font-size:13px;
    color:#6b7280;
    margin-bottom:6px;
}

/* PRIMARY BUTTON */
.btn-primary{
    margin: 10px;
    background:#ffb300;
    border:none;
    border-radius:10px;
    padding:12px;
    font-weight:600;
}

.btn-primary:hover{
    background:#f59e0b;
}

/* PASSWORD BUTTON */
.btn-warning{
    margin: 10px;
    background:#111827;
    color:#fff;
    border:none;
    border-radius:10px;
    padding:12px;
    font-weight:600;
}

/* STATS */
.stat-grid{
    display:grid;
    grid-template-columns:repeat(2,1fr);
    gap:16px;
}

.stat-box{
    background:#f9fafb;
    border-radius:14px;
    padding:20px;
    text-align:center;
}

.stat-box h3{
    font-size:26px;
    margin:0;
    font-weight:700;
}

.stat-box span{
    font-size:13px;
    color:#6b7280;
}

/* ACTIONS */
.account-actions{
    margin-top:20px;
    display:flex;
    flex-direction:column;
    gap:12px;
}

.btn-outline-primary{
    border-radius:10px;
    padding:12px;
    font-weight:600;
}

.btn-danger{
    border-radius:10px;
    padding:12px;
    font-weight:600;
}

/* MOBILE */
@media(max-width:768px){
    .stat-grid{
        grid-template-columns:1fr;
    }
}

</style>

<div class="container my-5 account-wrap">


    <div class="row g-4 align-items-stretch">

        <!-- LEFT : PROFILE -->
        <div class="col-lg-6 col-md-12">
           <div class="account-card h-100">

<h5 class="account-title">👤 My Profile</h5>


                <asp:Label ID="lblMsg" runat="server"
                    CssClass="text-danger mb-3 d-block" />

                <div class="mb-3">
                    <label class="form-label">Full Name</label>
                    <asp:TextBox ID="txtName" runat="server"
                        CssClass="form-control" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Mobile</label>
                    <asp:TextBox ID="txtMobile" runat="server"
                        CssClass="form-control" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server"
                        CssClass="form-control" ReadOnly="true" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Role</label>
                    <asp:TextBox ID="txtRole" runat="server"
                        CssClass="form-control" ReadOnly="true" />
                </div>

                <div class="mb-4">
                    <label class="form-label">Joined On</label>
                    <asp:TextBox ID="txtDate" runat="server"
                        CssClass="form-control" ReadOnly="true" />
                </div>

                <asp:Button ID="btnUpdate" runat="server"
                    Text="Update Profile"
                    CssClass="btn btn-primary w-100"
                    OnClick="btnUpdate_Click" />
            </div>
        </div>

        <!-- RIGHT : PASSWORD + STATS -->
        <div class="col-lg-6 col-md-12">

            <!-- PASSWORD -->
            <div class="profile-card p-4 mb-4">
                <h5 class="profile-title">🔐 Change Password</h5>

                <asp:TextBox ID="txtOld" runat="server"
                    TextMode="Password"
                    CssClass="form-control space mb-2"
                    placeholder="Old Password" />

                <asp:TextBox ID="txtNew" runat="server"
                    TextMode="Password"
                    CssClass="form-control space mb-2"
                    placeholder="New Password" />

                <asp:TextBox ID="txtConfirm" runat="server"
                    TextMode="Password"
                    CssClass="form-control space mb-3"
                    placeholder="Confirm Password" />

                <asp:Button ID="btnPassword" runat="server"
                    Text="Change Password"
                    CssClass="btn btn-warning w-100"
                    OnClick="btnPassword_Click" />
            </div>

            <!-- STATS -->
            <div class="stat-grid">


                <div class="col-6">
                    <div class="stat-box">
                        <h3><asp:Label ID="lblOrders" runat="server" /></h3>
                        <span>Total Orders</span>
                    </div>
                </div>

                <div class="col-6">
                    <div class="stat-box">
                        <h3><asp:Label ID="lblWishlist" runat="server" /></h3>
                        <span>Wishlist</span>
                    </div>
                </div>

             <div class="account-actions">
    <asp:Button ID="btnOrders" runat="server"
        Text="View My Orders"
        CssClass="btn btn-outline-primary w-100"
        PostBackUrl="~/Client/MyOrders.aspx" />

    <asp:Button ID="btnLogout" runat="server"
        Text="Logout"
        CssClass="btn btn-danger w-100"
        OnClick="btnLogout_Click" />
</div>


            </div>

        </div>

    </div>
</div>

</asp:Content>

