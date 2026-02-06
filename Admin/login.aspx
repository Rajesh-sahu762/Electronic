<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="Admin_login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Admin Login</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #ff9800, #ff5722);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background 0.3s;
        }

        body.dark {
            background: linear-gradient(135deg, #1e1e1e, #121212);
        }

        .login-card {
            width: 380px;
            background: #ffffff;
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.3);
            transition: background 0.3s;
        }

        body.dark .login-card {
            background: #1f1f1f;
            color: #fff;
        }

        .login-title {
            color: #ff5722;
            font-weight: 600;
        }

        .lock-icon {
            font-size: 40px;
            color: #ff5722;
            animation: pulse 1.5s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.15); }
            100% { transform: scale(1); }
        }

        .form-control {
            height: 45px;
            border-radius: 8px;
        }

        .btn-login {
            height: 45px;
            border-radius: 8px;
            background: linear-gradient(135deg, #ff5722, #ff9800);
            border: none;
            font-weight: 600;
        }

        .btn-login:hover {
            opacity: 0.9;
        }

        .error {
            color: #dc3545;
            text-align: center;
            margin-top: 10px;
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

        .loader {
            display: none;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

<div class="login-card" id="loginCard">

    <div class="text-center mb-3">
        <i class="bi bi-shield-lock-fill lock-icon"></i>
    </div>

    <h4 class="text-center login-title mb-4">Admin Login</h4>

    <div class="mb-3">
        <label>Email or Mobile</label>
        <asp:TextBox ID="txtUser" runat="server"
            CssClass="form-control"
            placeholder="Enter email or mobile" />
    </div>

    <div class="mb-3 position-relative">
        <label>Password</label>
        <asp:TextBox ID="txtPassword" runat="server"
            TextMode="Password"
            CssClass="form-control"
            placeholder="Enter password" />
        <i class="bi bi-eye-fill position-absolute"
           style="top:38px; right:12px; cursor:pointer;"
           onclick="togglePassword()"></i>
    </div>

    <asp:Button ID="btnLogin" runat="server"
        Text="Login"
        CssClass="btn btn-login w-100 text-white"
        OnClientClick="showLoader()"
        OnClick="btnLogin_Click" />

    <div class="text-center mt-2 loader" id="loader">
        <div class="spinner-border text-warning spinner-border-sm"></div>
        <span> Logging in...</span>
    </div>

    <asp:Label ID="lblMsg" runat="server" CssClass="error"></asp:Label>

    <div class="text-center mt-3">
        <button type="button" class="btn btn-sm btn-outline-secondary"
            onclick="toggleDarkMode()">🌙 Dark Mode</button>
    </div>

</div>

</form>

<script>
    function togglePassword() {
        var pwd = document.getElementById('<%= txtPassword.ClientID %>');
        pwd.type = pwd.type === "password" ? "text" : "password";
    }

    function showLoader() {
        document.getElementById("loader").style.display = "block";
    }

    function toggleDarkMode() {
        document.body.classList.toggle("dark");
        localStorage.setItem("dark",
            document.body.classList.contains("dark"));
    }

    // Remember dark mode
    if (localStorage.getItem("dark") === "true") {
        document.body.classList.add("dark");
    }

    // Shake on error
    window.onload = function () {
        var msg = document.getElementById('<%= lblMsg.ClientID %>');
        if (msg.innerText !== "") {
            document.getElementById("loginCard").classList.add("shake");
        }
    };
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
