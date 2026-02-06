using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Prevent back button after logout
        Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string user = txtUser.Text.Trim();
        string pass = txtPassword.Text.Trim();

        if (user == "" || pass == "")
        {
            lblMsg.Text = "Please enter login details";
            return;
        }

        string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"
                SELECT UserID, FullName, Role, IsBlocked 
                FROM Users 
                WHERE (Email=@user OR Mobile=@user)
                AND PasswordHash=@pass
                AND Role='Admin'";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@user", user);
            cmd.Parameters.AddWithValue("@pass", pass); // hashing later

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                if (Convert.ToBoolean(dr["IsBlocked"]) == true)
                {
                    lblMsg.Text = "Account is blocked";
                    return;
                }

                Session["UserID"] = dr["UserID"].ToString();
                Session["Role"] = dr["Role"].ToString();
                Session["FullName"] = dr["FullName"].ToString();

                Response.Redirect("AdminDashboard.aspx");
            }
            else
            {
                lblMsg.Text = "Invalid login details";
            }
        }
    }
}