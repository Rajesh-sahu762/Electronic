using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Client_VerifyOTP : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnVerify_Click(object sender, EventArgs e)
    {
        string email = Request.QueryString["email"];
        string type = Request.QueryString["type"]; // register | reset

        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(type) || txtOTP.Text == "")
        {
            lblMsg.Text = "Invalid request";
            return;
        }

        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(@"
SELECT EmailOTP, OTPExpiry 
FROM Users 
WHERE Email=@e AND Role='Client'", con);

            cmd.Parameters.AddWithValue("@e", email);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (!dr.Read())
            {
                lblMsg.Text = "Invalid request";
                return;
            }

            if (DateTime.Now > Convert.ToDateTime(dr["OTPExpiry"]))
            {
                lblMsg.Text = "OTP expired. Please resend.";
                return;
            }

            if (dr["EmailOTP"].ToString() != txtOTP.Text.Trim())
            {
                lblMsg.Text = "Invalid OTP";
                return;
            }

            dr.Close();
        }

        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd;

            if (type == "register")
            {
                cmd = new SqlCommand(@"
UPDATE Users SET
EmailVerified=1,
IsSetupComplete=1,
EmailOTP=NULL,
OTPExpiry=NULL
WHERE Email=@e AND Role='Client'", con);
            }
            else if (type == "reset")
            {
                cmd = new SqlCommand(@"
UPDATE Users SET
EmailOTP=NULL,
OTPExpiry=NULL
WHERE Email=@e AND Role='Client'", con);
            }
            else
            {
                lblMsg.Text = "Invalid request";
                return;
            }

            cmd.Parameters.AddWithValue("@e", email);
            con.Open();
            cmd.ExecuteNonQuery();
        }

        if (type == "register")
            Response.Redirect("Login.aspx");
        else
            Response.Redirect("ResetPassword.aspx?email=" + email);
    }

    protected void btnResend_Click(object sender, EventArgs e)
    {
        string email = Request.QueryString["email"];
        if (string.IsNullOrEmpty(email)) return;

        string otp = new Random().Next(100000, 999999).ToString();

        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(@"
UPDATE Users
SET EmailOTP=@o,
    OTPExpiry=@exp,
    ResendCount = ISNULL(ResendCount,0)+1
WHERE Email=@e AND Role='Client' AND ResendCount < 3", con);

            cmd.Parameters.AddWithValue("@o", otp);
            cmd.Parameters.AddWithValue("@exp", DateTime.Now.AddMinutes(10));
            cmd.Parameters.AddWithValue("@e", email);

            con.Open();
            int rows = cmd.ExecuteNonQuery();

            if (rows == 0)
            {
                lblMsg.Text = "Resend limit reached";
                return;
            }
        }

        SendOTP(email, otp);
        lblMsg.Text = "New OTP sent";
        lblMsg.CssClass = "text-success";
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