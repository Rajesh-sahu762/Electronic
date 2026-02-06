using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Client_Register : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(
        ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        // 🔥 THIS LINE FIXES THE ERROR
        System.Web.UI.ValidationSettings.UnobtrusiveValidationMode =
            System.Web.UI.UnobtrusiveValidationMode.None;
    }


    protected void btnRegister_Click(object sender, EventArgs e)
    {
        // Duplicate check
        SqlCommand chk = new SqlCommand(
            "SELECT COUNT(*) FROM Users WHERE Email=@E OR Mobile=@M", con);
        chk.Parameters.AddWithValue("@E", txtEmail.Text.Trim());
        chk.Parameters.AddWithValue("@M", txtMobile.Text.Trim());

        con.Open();
        int exists = Convert.ToInt32(chk.ExecuteScalar());
        con.Close();

        if (exists > 0)
        {
            lblMsg.Text = "Email or Mobile already registered";
            return;
        }

        string otp = new Random().Next(100000, 999999).ToString();
        DateTime expiry = DateTime.Now.AddMinutes(10);

        SqlCommand cmd = new SqlCommand(@"
INSERT INTO Users
(Role,FullName,Email,Mobile,PasswordHash,
 EmailOTP,OTPExpiry,EmailVerified,IsSetupComplete)
VALUES
('Client',@N,@E,@M,@P,@OTP,@EXP,0,0)", con);

        cmd.Parameters.AddWithValue("@N", txtName.Text.Trim());
        cmd.Parameters.AddWithValue("@E", txtEmail.Text.Trim());
        cmd.Parameters.AddWithValue("@M", txtMobile.Text.Trim());
        cmd.Parameters.AddWithValue("@P", Hash(txtPassword.Text));
        cmd.Parameters.AddWithValue("@OTP", otp);
        cmd.Parameters.AddWithValue("@EXP", expiry);

        con.Open();
        cmd.ExecuteNonQuery();
        //con.Close();

        SendOTP(txtEmail.Text, otp);

        Response.Redirect("VerifyOTP.aspx?email=" + txtEmail.Text + "&type=reset");

        pnlRegister.Visible = false;
        pnlOTP.Visible = true;
    }



    void SendOTP(string to, string otp)
    {
        MailMessage mail = new MailMessage();
        mail.To.Add(to);
        mail.From = new MailAddress("yourmail@gmail.com");
        mail.Subject = "Vendor Email Verification OTP";
        mail.Body = "Your OTP is: " + otp;

        SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
        smtp.Credentials = new System.Net.NetworkCredential(
            "rajeshsahu3406@gmail.com", "ksch jicp cwye gbnk");
        smtp.EnableSsl = true;
        smtp.Send(mail);
    }

    protected void btnVerify_Click(object sender, EventArgs e)
    {
        string entered =
            otp1.Text + otp2.Text + otp3.Text +
            otp4.Text + otp5.Text + otp6.Text;

        SqlCommand cmd = new SqlCommand(@"
SELECT COUNT(*) FROM Users
WHERE Email=@E AND EmailOTP=@O AND OTPExpiry > GETDATE()", con);

        cmd.Parameters.AddWithValue("@E", txtEmail.Text.Trim());
        cmd.Parameters.AddWithValue("@O", entered);

        con.Open();
        int ok = Convert.ToInt32(cmd.ExecuteScalar());
        con.Close();

        if (ok == 0)
        {
            lblOtpMsg.Text = "Invalid or expired OTP";
            return;
        }

        SqlCommand upd = new SqlCommand(@"
UPDATE Users SET
EmailVerified=1,
IsSetupComplete=1
WHERE Email=@E", con);

        upd.Parameters.AddWithValue("@E", txtEmail.Text.Trim());

        con.Open();
        upd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("Login.aspx");
    }

    string Hash(string input)
    {
        SHA256 s = SHA256.Create();
        byte[] b = s.ComputeHash(Encoding.UTF8.GetBytes(input));
        return Convert.ToBase64String(b);
    }
}
