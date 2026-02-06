using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Client_Login : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (txtEmail.Text == "" || txtPassword.Text == "")
        {
            lblMsg.Text = "Enter email and password";
            return;
        }

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
SELECT UserID, FullName, PasswordHash,
       EmailVerified, IsBlocked,
       LoginAttempts, LockUntil
FROM Users
WHERE Email=@e AND Role='Client'", con);

            cmd.Parameters.AddWithValue("@e", txtEmail.Text.Trim());

            SqlDataReader dr = cmd.ExecuteReader();

            if (!dr.Read())
            {
                lblMsg.Text = "Invalid credentials";
                return;
            }

            int userId = Convert.ToInt32(dr["UserID"]);
            string fullName = dr["FullName"].ToString();
            string dbPassword = dr["PasswordHash"].ToString();
            bool emailVerified = Convert.ToBoolean(dr["EmailVerified"]);
            bool isBlocked = Convert.ToBoolean(dr["IsBlocked"]);

            int attempts = Convert.ToInt32(dr["LoginAttempts"]);
            DateTime? lockUntil = dr["LockUntil"] == DBNull.Value
                ? (DateTime?)null
                : Convert.ToDateTime(dr["LockUntil"]);

            dr.Close();

            // 🔐 ACCOUNT LOCK CHECK
            if (lockUntil != null && DateTime.Now < lockUntil.Value)
            {
                lblMsg.Text = "Account temporarily locked. Try again later.";
                return;
            }

            // ❌ WRONG PASSWORD
            if (dbPassword != txtPassword.Text.Trim())
            {
                SqlCommand fail = new SqlCommand(@"
UPDATE Users
SET LoginAttempts = LoginAttempts + 1,
    LockUntil = CASE 
        WHEN LoginAttempts >= 4 THEN DATEADD(MINUTE, 15, GETDATE())
        ELSE NULL END
WHERE UserID=@id", con);

                fail.Parameters.AddWithValue("@id", userId);
                fail.ExecuteNonQuery();

                lblMsg.Text = "Invalid credentials";
                return;
            }

            // ✅ RESET ATTEMPTS
            SqlCommand reset = new SqlCommand(
                "UPDATE Users SET LoginAttempts=0, LockUntil=NULL WHERE UserID=@id", con);
            reset.Parameters.AddWithValue("@id", userId);
            reset.ExecuteNonQuery();

            // ❌ EMAIL NOT VERIFIED
            if (!emailVerified)
            {
                lblMsg.Text = "Please verify your email first";
                return;
            }

            // ❌ BLOCKED
            if (isBlocked)
            {
                lblMsg.Text = "Your account has been blocked";
                return;
            }

            // ✅ LOGIN SUCCESS
            Session["UserID"] = userId;
            Session["FullName"] = fullName;
            Session["Role"] = "Client";

            // 🔁 Redirect logic (cart friendly)
            if (Session["RETURN_URL"] != null)
            {
                string url = Session["RETURN_URL"].ToString();
                Session["RETURN_URL"] = null;
                Response.Redirect(url);
            }
            else
            {
                Response.Redirect("Index.aspx");
            }
        }
    }
}
