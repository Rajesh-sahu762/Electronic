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
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(@"
SELECT UserID, FullName
FROM Users
WHERE Role='Client'
AND IsActive=1
AND (Email=@u OR Mobile=@u)
AND PasswordHash=@p", con);

            cmd.Parameters.AddWithValue("@u", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@p", txtPassword.Text.Trim());

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                Session["UserID"] = dr["UserID"];
                Session["Role"] = "Client";
                Session["Name"] = dr["FullName"];
                Response.Redirect("~/Client/Home.aspx");
            }
            else
            {
                lblMsg.Text = "Invalid login credentials";
            }
        }
    }
}
