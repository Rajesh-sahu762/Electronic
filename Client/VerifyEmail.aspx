<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VerifyEmail.aspx.cs" Inherits="Client_VerifyEmail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Verify Email</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
            background:#f4f4f4;
        }
        .box {
            width:380px;
            background:#fff;
            padding:30px;
            border-radius:14px;
            text-align:center;
            box-shadow:0 15px 40px rgba(0,0,0,0.25);
        }
        .btn-main {
            background:#FFB300;
            font-weight:600;
        }
        .otp {
            letter-spacing:6px;
            font-size:20px;
            text-align:center;
            font-weight:600;
        }
        .resend {
            color:#FFB300;
            font-weight:600;
            cursor:pointer;
        }
        .disabled {
            pointer-events:none;
            opacity:.5;
        }
    </style>
</head>

<body>
<form id="Form1" runat="server">

<div class="box">
    <h4>Verify Email</h4>
    <p class="text-muted">Enter OTP sent to your email</p>

    <asp:TextBox ID="txtOTP" runat="server"
        CssClass="form-control otp mb-3"
        MaxLength="6"
        placeholder="______" />

    <asp:Button ID="btnVerify" runat="server"
        Text="Verify OTP"
        CssClass="btn btn-main w-100"
        OnClick="btnVerify_Click" />

    <div class="mt-3">
        <span id="resendBtn" class="resend">Resend OTP</span>
        <div id="timerBox" class="text-muted mt-2" style="display:none;">
            Resend in <span id="sec">60</span>s
        </div>
    </div>

    <asp:Label ID="lblMsg" runat="server" CssClass="text-danger mt-2 d-block" />
</div>

<script>
    var resendCount = 0;
    var timeLeft = 60;
    var timer;

    document.getElementById("resendBtn").onclick = function () {

        if (resendCount > 0 && timeLeft > 0) return;

        __doPostBack("ResendOTP", "");
        resendCount++;

        if (resendCount >= 2) startTimer();
    };

    function startTimer() {
        var btn = document.getElementById("resendBtn");
        var box = document.getElementById("timerBox");
        var sec = document.getElementById("sec");

        btn.classList.add("disabled");
        box.style.display = "block";
        timeLeft = 60;
        sec.innerText = timeLeft;

        timer = setInterval(function () {
            timeLeft--;
            sec.innerText = timeLeft;

            if (timeLeft <= 0) {
                clearInterval(timer);
                box.style.display = "none";
                btn.classList.remove("disabled");
            }
        }, 1000);
    }
</script>

</form>
</body>
</html>