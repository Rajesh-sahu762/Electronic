<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Client_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Client Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

<style>
body{background:#fff;}
.auth-box{
    max-width:420px;
    margin:90px auto;
    padding:35px;
    border-radius:14px;
    box-shadow:0 15px 40px rgba(0,0,0,.08);
}
.btn-main{
    background:#FFB300;
    color:#000;
    border:none;
    font-weight:600;
}
.btn-main:hover{background:#e6a200;}
.form-control:focus{
    border-color:#FFB300;
    box-shadow:none;
}
</style>
</head>

<body>
<form id="Form1" runat="server">

<div class="auth-box">
    <h4 class="text-center fw-bold mb-3">Client Login</h4>

    <asp:TextBox ID="txtEmail" runat="server"
        CssClass="form-control mb-2"
        placeholder="Email or Mobile" />

    <asp:TextBox ID="txtPassword" runat="server"
        CssClass="form-control mb-3"
        TextMode="Password"
        placeholder="Password" />

    <asp:Button ID="btnLogin" runat="server"
        Text="Login"
        CssClass="btn btn-main w-100 py-2"
        OnClick="btnLogin_Click" />

    <div class="text-center mt-3">
        <a href="Register.aspx" style="color:#000">Create new account</a>
    </div>

    <asp:Label ID="lblMsg" runat="server"
        CssClass="text-danger d-block text-center mt-2" />
</div>

</form>
</body>
</html>