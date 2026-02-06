<%@ Page Language="C#" AutoEventWireup="true" CodeFile="setup.aspx.cs" Inherits="Vendor_setup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Vendor Setup</title>

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
            width: 520px;
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
            50% { transform: scale(1.1); }
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
<form id="Form1" runat="server" enctype="multipart/form-data">

<div class="box" id="box">

    <div class="text-center mb-3">
        <i class="bi bi-shop icon"></i>
        <h4 class="mt-2">Vendor Setup</h4>
        <p class="text-muted">Complete setup to activate your account</p>
    </div>

    <asp:Label ID="lblRemark" runat="server"
        CssClass="text-danger text-center d-block mb-2"></asp:Label>

    <asp:TextBox ID="txtShopName" runat="server"
        CssClass="form-control mb-3"
        placeholder="Shop Name" />

    <asp:TextBox ID="txtGST" runat="server"
        CssClass="form-control mb-3"
        placeholder="GST Number" />

    <asp:TextBox ID="txtAddress" runat="server"
        CssClass="form-control mb-3"
        TextMode="MultiLine"
        Rows="3"
        placeholder="Shop Address" />

    <label>Upload Document (GST / ID Proof)</label>
    <asp:FileUpload ID="fuDoc" runat="server"
        CssClass="form-control mb-3" />

    <label>Upload Shop Logo</label>
    <asp:FileUpload ID="fuLogo" runat="server"
        CssClass="form-control mb-2"
        onchange="previewLogo(this)" />

    <img id="logoPreview"
         style="max-height:80px; display:none; margin-bottom:10px;" />

    <asp:Button ID="btnSubmit" runat="server"
        Text="Submit for Approval"
        CssClass="btn btn-primary w-100"
        OnClientClick="showLoader()"
        OnClick="btnSubmit_Click" />

    <div class="text-center mt-2" id="loader" style="display:none;">
        <div class="spinner-border spinner-border-sm"></div>
        Submitting...
    </div>

    <asp:Label ID="lblMsg" runat="server"
        CssClass="text-danger text-center d-block mt-2"></asp:Label>

</div>

</form>

<script>
    function previewLogo(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                var img = document.getElementById('logoPreview');
                img.src = e.target.result;
                img.style.display = "block";
            };
            reader.readAsDataURL(input.files[0]);
        }
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

</body>
</html>