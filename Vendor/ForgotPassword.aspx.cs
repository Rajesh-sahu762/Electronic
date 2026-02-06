using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendor_ForgotPassword : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnSend_Click(object sender, EventArgs e)
    {
        if (txtEmail.Text == "")
        {
            lblMsg.Text = "Enter email";
            return;
        }

        string otp = new Random().Next(100000, 999999).ToString();

        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(
            @"UPDATE Users
              SET EmailOTP=@o, OTPExpiry=@e
              WHERE Email=@mail AND Role='Vendor' AND EmailVerified=1", con);

            cmd.Parameters.AddWithValue("@o", otp);
            cmd.Parameters.AddWithValue("@e", DateTime.Now.AddMinutes(10));
            cmd.Parameters.AddWithValue("@mail", txtEmail.Text.Trim());

            con.Open();
            int rows = cmd.ExecuteNonQuery();
            if (rows == 0)
            {
                lblMsg.Text = "Email not found or not verified";
                return;
            }
        }

        SendOTP(txtEmail.Text, otp);
        Response.Redirect("VerifyOTP.aspx?email=" + txtEmail.Text + "&type=reset");

    }

    void SendOTP(string to, string otp)
    {
        MailMessage mail = new MailMessage();
        mail.To.Add(to);
        mail.From = new MailAddress("yourmail@gmail.com");
        mail.Subject = "Password Reset OTP";
        mail.Body = "Your OTP is: " + otp;

        SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
        smtp.Credentials =
            new System.Net.NetworkCredential("rajeshsahu3406@gmail.com", "ksch jicp cwye gbnk");
        smtp.EnableSsl = true;
        smtp.Send(mail);
    }
}