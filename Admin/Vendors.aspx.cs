using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.UI.WebControls;

public partial class Admin_Default2 : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            LoadVendors("All", "");
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        LoadVendors(ddlStatus.SelectedValue, txtSearch.Text.Trim());
    }

    void LoadVendors(string status, string search)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"
            SELECT UserID, FullName, Email, ApprovalStatus, IsBlocked
            FROM Users WHERE Role='Vendor'";

            if (status != "All")
            {
                if (status == "Blocked")
                    query += " AND IsBlocked=1";
                else
                    query += " AND ApprovalStatus=@st";
            }

            if (search != "")
                query += " AND (FullName LIKE @s OR Email LIKE @s)";

            SqlCommand cmd = new SqlCommand(query, con);

            if (status != "All" && status != "Blocked")
                cmd.Parameters.AddWithValue("@st", status);

            if (search != "")
                cmd.Parameters.AddWithValue("@s", "%" + search + "%");

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvVendors.DataSource = dt;
            gvVendors.DataBind();
        }
    }

    protected void gvVendors_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int id = Convert.ToInt32(e.CommandArgument);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            if (e.CommandName == "ViewDocs")
            {
                SqlCommand cmd = new SqlCommand(
                "SELECT DocumentPath, LogoPath FROM VendorDetails WHERE VendorID=@id", con);
                cmd.Parameters.AddWithValue("@id", id);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    StringBuilder sb = new StringBuilder();
                    sb.Append("<p><a href='" + dr["DocumentPath"] + "' target='_blank'>View Document</a></p>");
                    sb.Append("<img src='" + dr["LogoPath"] + "' style='max-height:100px;' />");
                    litDocs.Text = sb.ToString();
                }
                dr.Close();

                ClientScript.RegisterStartupScript(this.GetType(),
     "showModal", "$('#docModal').modal('show');", true);

            }

            if (e.CommandName == "Approve" || e.CommandName == "Reject" ||
                e.CommandName == "Block" || e.CommandName == "Unblock")
            {
                string action = e.CommandName;

                SqlCommand cmd = new SqlCommand(
                @"UPDATE Users SET
                  ApprovalStatus = CASE 
                    WHEN @a='Approve' THEN 'Approved'
                    WHEN @a='Reject' THEN 'Rejected'
                    ELSE ApprovalStatus END,
                  IsApproved = CASE WHEN @a='Approve' THEN 1 ELSE IsApproved END,
                  IsBlocked = CASE WHEN @a='Block' THEN 1 WHEN @a='Unblock' THEN 0 ELSE IsBlocked END
                  WHERE UserID=@id", con);

                cmd.Parameters.AddWithValue("@a", action);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();

                SqlCommand hist = new SqlCommand(
                "INSERT INTO VendorApprovalHistory(VendorID,Action) VALUES(@id,@a)", con);
                hist.Parameters.AddWithValue("@id", id);
                hist.Parameters.AddWithValue("@a", action);
                hist.ExecuteNonQuery();
            }
        }

        LoadVendors(ddlStatus.SelectedValue, txtSearch.Text.Trim());
    }
}
