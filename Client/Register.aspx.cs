using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Client_Register : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (txtName.Text == "" || txtEmail.Text == "" ||
            txtPassword.Text == "" || txtConfirm.Text == "")
        {
            lblMsg.Text = "All fields are required";
            lblMsg.CssClass = "msg text-danger";
            return;
        }

        if (txtPassword.Text != txtConfirm.Text)
        {
            lblMsg.Text = "Passwords do not match";
            lblMsg.CssClass = "msg text-danger";
            return;
        }

        string otp = new Random().Next(100000, 999999).ToString();
        DateTime expiry = DateTime.Now.AddMinutes(10);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            // 🔍 Email already exists?
            SqlCommand chk = new SqlCommand(
                "SELECT COUNT(*) FROM Users WHERE Email=@e", con);
            chk.Parameters.AddWithValue("@e", txtEmail.Text.Trim());

            if (Convert.ToInt32(chk.ExecuteScalar()) > 0)
            {
                lblMsg.Text = "Email already registered";
                lblMsg.CssClass = "msg text-danger";
                return;
            }

            // ✅ CLIENT REGISTER (PLAIN PASSWORD)
            SqlCommand cmd = new SqlCommand(@"
INSERT INTO Users
(Role, FullName, Email, PasswordHash,
 IsApproved, IsBlocked,
 EmailOTP, OTPExpiry, EmailVerified, IsSetupComplete)
VALUES
('Client', @n, @e, @p, 1, 0, @otp, @exp, 0, 0)", con);

            cmd.Parameters.AddWithValue("@n", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@e", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@p", txtPassword.Text.Trim()); // 👈 NO HASH
            cmd.Parameters.AddWithValue("@otp", otp);
            cmd.Parameters.AddWithValue("@exp", expiry);

            cmd.ExecuteNonQuery();
        }

        SendOTP(txtEmail.Text.Trim(), otp);

        Response.Redirect("VerifyOTP.aspx?email=" + txtEmail.Text.Trim() + "&type=register");
    }

    void SendOTP(string to, string otp)
    {
        MailMessage mail = new MailMessage();
        mail.To.Add(to);
        mail.From = new MailAddress("yourmail@gmail.com");
        mail.Subject = "Email Verification OTP";
        mail.Body = "Your OTP is: " + otp;

        SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
        smtp.Credentials = new System.Net.NetworkCredential(
            "rajeshsahu3406@gmail.com", "ksch jicp cwye gbnk");
        smtp.EnableSsl = true;
        smtp.Send(mail);
    }
}
