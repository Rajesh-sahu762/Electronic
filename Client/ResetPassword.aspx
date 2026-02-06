<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ResetPassword.aspx.cs" Inherits="Client_ResetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Reset Password</title>

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

        .box {
            width: 400px;
            background: #fff;
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.12);
        }

        .icon {
            font-size: 40px;
            color: #4f46e5;
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

        .eye {
            position: absolute;
            right: 12px;
            top: 8px;
            cursor: pointer;
            color: #6b7280;
        }

        .btn-main {
            height: 45px;
            background: linear-gradient(135deg, #4f46e5, #06b6d4);
            border: none;
            font-weight: 600;
        }

        .loader {
            display: none;
            text-align: center;
            margin-top: 10px;
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

<div class="box" id="box">

    <div class="text-center mb-2">
        <i class="bi bi-shield-lock icon"></i>
    </div>

    <h4 class="text-center mb-4">Reset Password</h4>

    <div class="position-relative mb-3">
        <asp:TextBox ID="txtPassword" runat="server"
            TextMode="Password"
            CssClass="form-control"
            placeholder="New password" />
        <i class="bi bi-eye-fill eye"
           onclick="togglePwd('<%= txtPassword.ClientID %>')"></i>
    </div>

    <div class="position-relative mb-3">
        <asp:TextBox ID="txtConfirm" runat="server"
            TextMode="Password"
            CssClass="form-control"
            placeholder="Confirm password" />
        <i class="bi bi-eye-fill eye"
           onclick="togglePwd('<%= txtConfirm.ClientID %>')"></i>
    </div>

    <div class="mb-2">
    <div class="progress" style="height:6px;">
        <div id="strengthBar" class="progress-bar"></div>
    </div>
    <small id="strengthText"></small>
</div>


    <asp:Button ID="btnReset" runat="server"
        Text="Reset Password"
        CssClass="btn btn-main w-100 text-white"
        OnClientClick="showLoader()"
        OnClick="btnReset_Click" />

    <div class="loader" id="loader">
        <div class="spinner-border spinner-border-sm text-primary"></div>
        Updating password...
    </div>

    <asp:Label ID="lblMsg" runat="server"
        CssClass="text-danger text-center d-block mt-2"></asp:Label>

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

        var pwd = document.getElementById('<%= txtPassword.ClientID %>');
    var bar = document.getElementById('strengthBar');
    var text = document.getElementById('strengthText');

    pwd.onkeyup = function () {
        var val = pwd.value;
        var score = 0;

        if (val.length >= 8) score++;
        if (/[A-Z]/.test(val)) score++;
        if (/[0-9]/.test(val)) score++;
        if (/[^A-Za-z0-9]/.test(val)) score++;

        if (score <= 1) {
            bar.style.width = "25%";
            bar.className = "progress-bar bg-danger";
            text.innerHTML = "Weak password";
        }
        else if (score <= 3) {
            bar.style.width = "60%";
            bar.className = "progress-bar bg-warning";
            text.innerHTML = "Medium strength";
        }
        else {
            bar.style.width = "100%";
            bar.className = "progress-bar bg-success";
            text.innerHTML = "Strong password";
        }
    };


</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>