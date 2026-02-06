<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="Vendor_ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Forgot Password</title>

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
        <i class="bi bi-key icon"></i>
    </div>

    <h5 class="text-center mb-3">Forgot Password</h5>

    <asp:TextBox ID="txtEmail" runat="server"
        CssClass="form-control mb-3"
        placeholder="Enter registered email" />

    <asp:Button ID="btnSend" runat="server"
        Text="Send OTP"
        CssClass="btn btn-primary w-100"
        OnClientClick="showLoader()"
        OnClick="btnSend_Click" />

    <div class="text-center mt-2" id="loader" style="display:none;">
        <div class="spinner-border spinner-border-sm"></div>
        Sending OTP...
    </div>

    <asp:Label ID="lblMsg" runat="server"
        CssClass="text-danger text-center d-block mt-2"></asp:Label>

</div>

</form>

<script>
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