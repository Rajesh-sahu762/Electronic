<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VerifyOTP.aspx.cs" Inherits="Client_VerifyOTP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title>Verify OTP</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            background: #f8fafc;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .box {
            width: 380px;
            background: #fff;
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.12);
        }

        .lock {
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
            text-align: center;
            letter-spacing: 6px;
            font-size: 18px;
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

        .timer {
            font-size: 14px;
            color: #6b7280;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>

<body>
<form id="Form1" runat="server">

<div class="box" id="box">

    <div class="text-center mb-2">
        <i class="bi bi-shield-lock-fill lock"></i>
    </div>

    <h5 class="text-center mb-2">Verify OTP</h5>
    <p class="text-center text-muted">Enter the OTP sent to your email</p>

    <asp:TextBox ID="txtOTP" runat="server"
        CssClass="form-control mb-3"
        MaxLength="6"
        placeholder="------" />

    <asp:Button ID="btnVerify" runat="server"
        Text="Verify OTP"
        CssClass="btn btn-primary w-100"
        OnClientClick="showLoader()"
        OnClick="btnVerify_Click" />

    <div class="text-center mt-2" id="loader" style="display:none;">
        <div class="spinner-border spinner-border-sm text-primary"></div>
        Verifying...
    </div>

    <asp:Label ID="lblMsg" runat="server" CssClass="text-danger text-center d-block mt-2"></asp:Label>

    <div class="timer">
        Resend OTP in <span id="count">60</span> sec
    </div>

    <div class="text-center mt-2">
        <asp:Button ID="btnResend" runat="server"
            Text="Resend OTP"
            CssClass="btn btn-link"
            Enabled="false"
            OnClick="btnResend_Click" />
    </div>

</div>

</form>

<script>
    var sec = 60;
    var t = setInterval(function () {
        sec--;
        document.getElementById("count").innerText = sec;
        if (sec <= 0) {
            clearInterval(t);
            document.getElementById('<%= btnResend.ClientID %>').disabled = false;
        }
    }, 1000);

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

</body>
</html>