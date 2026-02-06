using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class Vendor_Login : System.Web.UI.Page
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

            SqlCommand cmd = new SqlCommand(
            @"SELECT UserID, FullName, PasswordHash, EmailVerified,
                     IsSetupComplete, IsBlocked,
                     LoginAttempts, LockUntil,
                     ApprovalStatus, AdminRemark
              FROM Users
              WHERE Email=@e AND Role='Vendor'", con);

            cmd.Parameters.AddWithValue("@e", txtEmail.Text.Trim());

            SqlDataReader dr = cmd.ExecuteReader();

            if (!dr.Read())
            {
                lblMsg.Text = "Invalid credentials";
                return;
            }

            // 🔹 Read all values FIRST
            int userId = Convert.ToInt32(dr["UserID"]);
            string fullName = dr["FullName"].ToString();
            string dbPassword = dr["PasswordHash"].ToString();
            bool emailVerified = Convert.ToBoolean(dr["EmailVerified"]);
            bool isSetupComplete = Convert.ToBoolean(dr["IsSetupComplete"]);
            bool isBlocked = Convert.ToBoolean(dr["IsBlocked"]);
            string approvalStatus = dr["ApprovalStatus"].ToString();
            string adminRemark = dr["AdminRemark"] == DBNull.Value ? "" : dr["AdminRemark"].ToString();

            int attempts = Convert.ToInt32(dr["LoginAttempts"]);
            DateTime? lockUntil = dr["LockUntil"] == DBNull.Value
                ? (DateTime?)null
                : Convert.ToDateTime(dr["LockUntil"]);

            dr.Close(); // ✅ reader closed safely

            // 🔐 TEMP LOCK CHECK
            if (lockUntil != null && DateTime.Now < lockUntil.Value)
            {
                lblMsg.Text = "Account temporarily locked. Try later.";
                return;
            }

            // ❌ WRONG PASSWORD
            if (dbPassword != txtPassword.Text.Trim())
            {
                SqlCommand fail = new SqlCommand(
                @"UPDATE Users
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

            // ✅ SUCCESS → RESET ATTEMPTS
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
                lblMsg.Text = "Your account has been blocked by admin";
                return;
            }

            // ✅ SESSION SET
            Session["UserID"] = userId;
            Session["FullName"] = fullName;
            Session["Role"] = "Vendor";

            // ❌ REJECTED → FORCE SETUP + REMARK
            if (approvalStatus == "Rejected")
            {
                Session["AdminRemark"] = adminRemark; // optional
                Response.Redirect("Setup.aspx");
                return;
            }

            // ❌ SETUP INCOMPLETE
            if (!isSetupComplete)
            {
                Response.Redirect("Setup.aspx");
                return;
            }

            // ⏳ PENDING APPROVAL
            if (approvalStatus == "Pending")
            {
                lblMsg.Text = "Your account is under admin review";
                return;
            }

            // ✅ APPROVED
            if (approvalStatus == "Approved")
            {
                Response.Redirect("Dashboard.aspx");
                return;
            }

            lblMsg.Text = "Unable to login. Contact support.";
        }
    }
}
