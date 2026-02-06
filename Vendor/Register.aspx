<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Vendor_Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Vendor Registration</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            background: #f8fafc;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', sans-serif;
        }

        .card-box {
            width: 420px;
            background: #ffffff;
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.12);
        }

        .lock {
            font-size: 42px;
            color: #4f46e5;
            animation: pulse 1.5s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.15); }
            100% { transform: scale(1); }
        }

        .title {
            color: #4f46e5;
            font-weight: 600;
        }

        .form-control {
            height: 45px;
            border-radius: 8px;
        }

        .btn-main {
            height: 45px;
            border-radius: 8px;
            background: linear-gradient(135deg, #4f46e5, #06b6d4);
            border: none;
            font-weight: 600;
        }

        .btn-main:hover {
            opacity: 0.95;
        }

        .eye {
            position: absolute;
            right: 12px;
            top: 8px;
            cursor: pointer;
            color: #6b7280;
        }

        .loader {
            display: none;
            text-align: center;
            margin-top: 10px;
        }

        .error {
            color: #dc3545;
            text-align: center;
            margin-top: 8px;
            font-size: 14px;
        }

        .shake {
            animation: shake 0.4s;
        }

        @keyframes shake {
            0% { transform: translateX(0); }
            25% { transform: translateX(-6px); }
            50% { transform: translateX(6px); }
            75% { transform: translateX(-6px); }
            100% { transform: translateX(0); }
        }
    </style>
</head>

<body>
<form id="Form1" runat="server">

<div class="card-box" id="box">

    <div class="text-center mb-2">
        <i class="bi bi-shop-window lock"></i>
    </div>

    <h4 class="text-center title mb-4">Vendor Registration</h4>

    <asp:TextBox ID="txtName" runat="server"
        CssClass="form-control mb-3"
        placeholder="Full Name" />

    <asp:TextBox ID="txtEmail" runat="server"
        CssClass="form-control mb-3"
        placeholder="Email address" />

    <div class="position-relative mb-3">
        <asp:TextBox ID="txtPassword" runat="server"
            TextMode="Password"
            CssClass="form-control"
            placeholder="Password" />
        <i class="bi bi-eye-fill eye"
           onclick="togglePwd('<%= txtPassword.ClientID %>')"></i>
    </div>

    <div class="position-relative mb-3">
        <asp:TextBox ID="txtConfirm" runat="server"
            TextMode="Password"
            CssClass="form-control"
            placeholder="Confirm Password" />
        <i class="bi bi-eye-fill eye"
           onclick="togglePwd('<%= txtConfirm.ClientID %>')"></i>
    </div>

    <asp:Button ID="btnRegister" runat="server"
        Text="Register"
        CssClass="btn btn-main w-100 text-white"
        OnClientClick="showLoader()"
        OnClick="btnRegister_Click" />

    <div class="loader" id="loader">
        <div class="spinner-border text-primary spinner-border-sm"></div>
        <span> Creating account...</span>
    </div>

    <asp:Label ID="lblMsg" runat="server" CssClass="error"></asp:Label>

</div>

</form>

<script>
    function togglePwd(id) {
        var x = document.getElementById(id);
        x.type = x.type === "password" ? "text" : "password";
    }

    function showLoader() {
        document.getElementById("loader").style.display = "block";
    }

    window.onload = function () {
        var msg = document.getElementById('<%= lblMsg.ClientID %>');
        if (msg.innerText !== "") {
            document.getElementById("box").classList.add("shake");
        }
    };
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>