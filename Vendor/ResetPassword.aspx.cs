using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendor_ResetPassword : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnReset_Click(object sender, EventArgs e)
    {
        string email = Request.QueryString["email"];

        if (email == null)
        {
            lblMsg.Text = "Invalid request";
            return;
        }

        if (txtPassword.Text == "" || txtConfirm.Text == "")
        {
            lblMsg.Text = "All fields required";
            return;
        }

        if (txtPassword.Text != txtConfirm.Text)
        {
            lblMsg.Text = "Passwords do not match";
            return;
        }

        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(
            @"UPDATE Users
              SET PasswordHash=@p
              WHERE Email=@e AND Role='Vendor'", con);

            cmd.Parameters.AddWithValue("@p", txtPassword.Text.Trim()); // hashing later
            cmd.Parameters.AddWithValue("@e", email);

            con.Open();
            int rows = cmd.ExecuteNonQuery();

            if (rows == 0)
            {
                lblMsg.Text = "Unable to reset password";
                return;
            }
        }

        SendPasswordChangeMail(email);
        Response.Redirect("Login.aspx");

    }


void SendPasswordChangeMail(string to)
{
    MailMessage mail = new MailMessage();
    mail.To.Add(to);
    mail.From = new MailAddress("yourmail@gmail.com");
    mail.Subject = "Password Changed Successfully";
    mail.Body =
        "Hello,\n\n" +
        "Your vendor account password has been changed successfully.\n\n" +
        "If this was not you, please contact support immediately.\n\n" +
        "Regards,\nSecurity Team";

    SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
    smtp.Credentials = new System.Net.NetworkCredential(
        "rajeshsahu3406@gmail.com", "ksch jicp cwye gbnk");
    smtp.EnableSsl = true;
    smtp.Send(mail);
}


}
