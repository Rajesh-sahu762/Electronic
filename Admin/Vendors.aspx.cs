using System.Web.UI;
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
                SqlCommand cmd = new SqlCommand(@"
SELECT 
    U.FullName,
    U.Email,
    U.ApprovalStatus,
    U.IsBlocked,
    V.ShopName,
    V.DocumentPath,
    V.LogoPath
FROM Users U
INNER JOIN VendorDetails V ON U.UserID = V.VendorID
WHERE U.UserID = @id
", con);

                cmd.Parameters.AddWithValue("@id", id);



                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    StringBuilder sb = new StringBuilder();

                    sb.Append("<div class='row'>");

                    // LEFT
                    sb.Append("<div class='col-md-6'>");
                    sb.Append("<h6>Vendor Info</h6>");
                    sb.Append("<p><b>Name:</b> " + dr["FullName"] + "</p>");
                    sb.Append("<p><b>Email:</b> " + dr["Email"] + "</p>");
                    sb.Append("<p><b>Status:</b> " + dr["ApprovalStatus"] + "</p>");
                    sb.Append("<p><b>Blocked:</b> " +
                        (Convert.ToBoolean(dr["IsBlocked"]) ? "Yes" : "No") + "</p>");
                    sb.Append("</div>");

                    // RIGHT
                    sb.Append("<div class='col-md-6'>");
                    sb.Append("<h6>Business Info</h6>");
                    sb.Append("<p><b>Shop Name:</b> " + dr["ShopName"] + "</p>");
                    sb.Append("</div>");

                    sb.Append("</div><hr/>");

                    // DOCUMENTS
                    string docPath = ResolveUrl("~/Uploads/VendorDocs/") + dr["DocumentPath"];
                    string logoPath = ResolveUrl("~/Uploads/VendorLogos/") + dr["LogoPath"];

                    sb.Append("<a href='" + docPath +
                              "' target='_blank' class='btn btn-sm btn-outline-primary'>View Document</a><br/>");

                    sb.Append("<img src='" + logoPath +
                              "' class='img-fluid mt-3' style='max-height:120px;' />");


                    litDocs.Text = sb.ToString();


                }
                dr.Close();

                ClientScript.RegisterStartupScript(
    this.GetType(),
    "showModal",
    "document.getElementById('docModal').classList.add('show');" +
    "document.getElementById('docModal').style.display='block';" +
    "document.body.classList.add('modal-open');",
    true
);




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
