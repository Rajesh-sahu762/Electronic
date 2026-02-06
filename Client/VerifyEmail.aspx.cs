using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Client_VerifyEmail : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VerifyEmail"] == null)
        {
            Response.Redirect("Register.aspx");
            return;
        }

        // Handle resend postback
        if (IsPostBack && Request["__EVENTTARGET"] == "ResendOTP")
        {
            GenerateAndSendOTP();
        }
    }

    protected void btnVerify_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(@"
                UPDATE Users
                SET EmailVerified = 1,
                    EmailOTP = NULL,
                    OTPExpiry = NULL
                WHERE Email = @email
                  AND EmailOTP = @otp
                  AND OTPExpiry > GETDATE()", con);

            cmd.Parameters.AddWithValue("@email", Session["VerifyEmail"]);
            cmd.Parameters.AddWithValue("@otp", txtOTP.Text.Trim());

            int rows = cmd.ExecuteNonQuery();

            if (rows > 0)
            {
                Session.Remove("VerifyEmail");
                Response.Redirect("Login.aspx");
            }
            else
            {
                lblMsg.Text = "Invalid or expired OTP";
            }
        }
    }

    private void GenerateAndSendOTP()
    {
        string otp = new Random().Next(100000, 999999).ToString();

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(@"
                UPDATE Users
                SET EmailOTP = @otp,
                    OTPExpiry = DATEADD(MINUTE, 5, GETDATE())
                WHERE Email = @email", con);

            cmd.Parameters.AddWithValue("@otp", otp);
            cmd.Parameters.AddWithValue("@email", Session["VerifyEmail"]);
            cmd.ExecuteNonQuery();
        }

        // 👉 yaha EMAIL SEND logic ayega
        // EmailHelper.SendOTP(Session["VerifyEmail"].ToString(), otp);
    }
}