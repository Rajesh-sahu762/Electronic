using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendor_Default : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null || Session["Role"].ToString() != "Vendor")
        {
            Response.Redirect("Login.aspx");
            return;
        }

        if (!IsPostBack)
            LoadProfile();
    }

    void LoadProfile()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(@"
                SELECT u.ApprovalStatus, u.AdminRemark,
                       v.ShopName, v.GSTNumber, v.Address, v.LogoPath
                FROM Users u
                LEFT JOIN VendorDetails v ON v.VendorID = u.UserID
                WHERE u.UserID=@id", con);

            cmd.Parameters.AddWithValue("@id", Session["UserID"]);
            con.Open();

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                lblStatus.Text = dr["ApprovalStatus"].ToString();
                lblRemark.Text = dr["AdminRemark"] == DBNull.Value
                    ? "" : "Remark: " + dr["AdminRemark"].ToString();

                txtShopName.Text = dr["ShopName"] == DBNull.Value ? "" : dr["ShopName"].ToString();
                lblGST.Text = dr["GSTNumber"] == DBNull.Value ? "-" : dr["GSTNumber"].ToString();

                txtAddress.Text = dr["Address"] == DBNull.Value ? "" : dr["Address"].ToString();

                if (dr["LogoPath"] != DBNull.Value)
                    imgLogo.ImageUrl = "~/Uploads/VendorLogos/" + dr["LogoPath"];
            }
            dr.Close();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtShopName.Text))
        {
            lblMsg.Text = "Shop name required";
            return;
        }

        string logoFile = null;
        string docFile = null;

        if (fuLogo.HasFile)
        {
            logoFile = Guid.NewGuid() + System.IO.Path.GetExtension(fuLogo.FileName);
            fuLogo.SaveAs(Server.MapPath("~/Uploads/VendorLogos/" + logoFile));
        }

        if (fuDoc.HasFile)
        {
            docFile = Guid.NewGuid() + System.IO.Path.GetExtension(fuDoc.FileName);
            fuDoc.SaveAs(Server.MapPath("~/Uploads/VendorDocs/" + docFile));
        }

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            // UPSERT VendorDetails
            SqlCommand cmd = new SqlCommand(@"
IF EXISTS (SELECT 1 FROM VendorDetails WHERE VendorID=@id)
BEGIN
    UPDATE VendorDetails
    SET ShopName=@s,
        Address=@a,
        LogoPath=ISNULL(@l,LogoPath),
        DocumentPath=ISNULL(@d,DocumentPath)
    WHERE VendorID=@id
END
ELSE
BEGIN
    INSERT INTO VendorDetails
    (VendorID, ShopName, GSTNumber, Address, LogoPath, DocumentPath)
    VALUES
    (@id, @s,
     (SELECT GSTNumber FROM VendorDetails WHERE VendorID=@id),
     @a, @l, @d)
END", con);


            cmd.Parameters.AddWithValue("@id", Session["UserID"]);
            cmd.Parameters.AddWithValue("@s", txtShopName.Text.Trim());
            cmd.Parameters.AddWithValue("@a", txtAddress.Text.Trim());
            cmd.Parameters.AddWithValue("@l", (object)logoFile ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@d", (object)docFile ?? DBNull.Value);


            cmd.ExecuteNonQuery();

            // If rejected earlier → mark setup complete but approval stays Pending
            SqlCommand upd = new SqlCommand(
                "UPDATE Users SET IsSetupComplete=1 WHERE UserID=@id", con);
            upd.Parameters.AddWithValue("@id", Session["UserID"]);
            upd.ExecuteNonQuery();
        }

        lblMsg.Text = "Profile updated successfully";
        LoadProfile();
    }
}