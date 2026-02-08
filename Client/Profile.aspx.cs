using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

public partial class Client_Profile : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
            return;
        }

        if (!IsPostBack)
        {
            LoadProfile();
            LoadStats();
        }
    }

    void LoadProfile()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(@"
SELECT FullName, Email, Mobile, Role, CreatedAt
FROM Users WHERE UserID=@id", con);

            cmd.Parameters.AddWithValue("@id", Session["UserID"]);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                txtName.Text = dr["FullName"].ToString();
                txtEmail.Text = dr["Email"].ToString();
                txtMobile.Text = dr["Mobile"].ToString();
                txtRole.Text = dr["Role"].ToString();
                txtDate.Text = Convert.ToDateTime(dr["CreatedAt"]).ToString("dd MMM yyyy");
            }
        }
    }

    void LoadStats()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            SqlCommand c1 = new SqlCommand(
                "SELECT COUNT(*) FROM Orders WHERE UserID=@id", con);
            c1.Parameters.AddWithValue("@id", Session["UserID"]);
            lblOrders.Text = c1.ExecuteScalar().ToString();

            SqlCommand c2 = new SqlCommand(
                "SELECT COUNT(*) FROM Wishlist WHERE UserID=@id", con);
            c2.Parameters.AddWithValue("@id", Session["UserID"]);
            lblWishlist.Text = c2.ExecuteScalar().ToString();
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(
                "UPDATE Users SET FullName=@n, Mobile=@m WHERE UserID=@id", con);

            cmd.Parameters.AddWithValue("@n", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@m", txtMobile.Text.Trim());
            cmd.Parameters.AddWithValue("@id", Session["UserID"]);

            con.Open();
            cmd.ExecuteNonQuery();
        }

        lblMsg.Text = "Profile updated successfully";
    }

    protected void btnPassword_Click(object sender, EventArgs e)
    {
        if (txtNew.Text != txtConfirm.Text)
        {
            lblMsg.Text = "Passwords do not match";
            return;
        }

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            SqlCommand chk = new SqlCommand(
                "SELECT PasswordHash FROM Users WHERE UserID=@id", con);
            chk.Parameters.AddWithValue("@id", Session["UserID"]);

            string dbPwd = chk.ExecuteScalar().ToString();
            if (dbPwd != Hash(txtOld.Text))
            {
                lblMsg.Text = "Old password incorrect";
                return;
            }

            SqlCommand upd = new SqlCommand(
                "UPDATE Users SET PasswordHash=@p WHERE UserID=@id", con);
            upd.Parameters.AddWithValue("@p", Hash(txtNew.Text));
            upd.Parameters.AddWithValue("@id", Session["UserID"]);
            upd.ExecuteNonQuery();
        }

        lblMsg.Text = "Password changed successfully";
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("Login.aspx");
    }

    string Hash(string input)
    {
        SHA256 s = SHA256.Create();
        return Convert.ToBase64String(
            s.ComputeHash(Encoding.UTF8.GetBytes(input)));
    }
}
