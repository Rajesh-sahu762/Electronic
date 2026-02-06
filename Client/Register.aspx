<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Client_Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Register</title>

    <style>
        body{
            font-family:Arial;
            background:#f6f6f6;
        }
        .auth-card{
            width:420px;
            margin:60px auto;
            background:#fff;
            padding:30px;
            border-radius:10px;
            box-shadow:0 10px 30px rgba(0,0,0,0.1);
        }
        h2{
            text-align:center;
            margin-bottom:20px;
        }
        .input{
            width:100%;
            padding:10px;
            margin-bottom:12px;
            border:1px solid #ccc;
            border-radius:5px;
        }
        .btn{
            width:100%;
            background:#ffb300;
            color:#fff;
            border:none;
            padding:12px;
            border-radius:6px;
            font-size:15px;
            cursor:pointer;
        }
        .error{
            color:red;
            font-size:13px;
        }
        .success{
            color:green;
            font-size:14px;
            text-align:center;
        }
        .otp-box{
            display:flex;
            gap:8px;
            justify-content:center;
        }
        .otp-box input{
            width:40px;
            text-align:center;
            font-size:18px;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

<div class="auth-card">

    <h2>User Register</h2>

    <!-- REGISTER PANEL -->
    <asp:Panel ID="pnlRegister" runat="server">

        <asp:TextBox ID="txtName" runat="server" CssClass="input" Placeholder="Full Name" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtName" CssClass="error"
            ErrorMessage="Name required" runat="server" Display="Dynamic" />

        <asp:TextBox ID="txtEmail" runat="server" CssClass="input" Placeholder="Email" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtEmail" CssClass="error"
            ErrorMessage="Email required" runat="server" Display="Dynamic" />
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtEmail" CssClass="error"
            ValidationExpression="^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$"
            ErrorMessage="Invalid Email" runat="server" Display="Dynamic" />

        <asp:TextBox ID="txtMobile" runat="server" CssClass="input" Placeholder="Mobile" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtMobile" CssClass="error"
            ErrorMessage="Mobile required" runat="server" Display="Dynamic" />

        <asp:TextBox ID="txtPassword" runat="server" CssClass="input"
            TextMode="Password" Placeholder="Password" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtPassword" CssClass="error"
            ErrorMessage="Password required" runat="server" Display="Dynamic" />

        <asp:TextBox ID="txtConfirm" runat="server" CssClass="input"
            TextMode="Password" Placeholder="Confirm Password" />
        <asp:CompareValidator ID="CompareValidator1" ControlToCompare="txtPassword"
            ControlToValidate="txtConfirm"
            CssClass="error"
            ErrorMessage="Password mismatch"
            runat="server" Display="Dynamic" />

        <asp:Label ID="lblMsg" runat="server" CssClass="error" />

        <asp:Button ID="btnRegister" runat="server"
            Text="Register & Send OTP"
            CssClass="btn"
            OnClick="btnRegister_Click" />

    </asp:Panel>

    <!-- OTP PANEL -->
    <asp:Panel ID="pnlOTP" runat="server" Visible="false">

        <p class="success">OTP sent to your email</p>

        <div class="otp-box">
            <asp:TextBox ID="otp1" runat="server" CssClass="input" MaxLength="1" />
            <asp:TextBox ID="otp2" runat="server" CssClass="input" MaxLength="1" />
            <asp:TextBox ID="otp3" runat="server" CssClass="input" MaxLength="1" />
            <asp:TextBox ID="otp4" runat="server" CssClass="input" MaxLength="1" />
            <asp:TextBox ID="otp5" runat="server" CssClass="input" MaxLength="1" />
            <asp:TextBox ID="otp6" runat="server" CssClass="input" MaxLength="1" />
        </div>

        <br />

        <asp:Label ID="lblOtpMsg" runat="server" CssClass="error" />

        <asp:Button ID="btnVerify" runat="server"
            Text="Verify OTP"
            CssClass="btn"
            OnClick="btnVerify_Click" />

    </asp:Panel>

</div>

</form>
</body>
</html>