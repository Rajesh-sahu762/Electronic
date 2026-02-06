using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendor_setup : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null || Session["Role"].ToString() != "Vendor")
        {
            Response.Redirect("Login.aspx");
        }


        if (!IsPostBack)
        {
            LoadApprovalStatus();
        }
    }

    void LoadApprovalStatus()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(
            "SELECT ApprovalStatus, AdminRemark FROM Users WHERE UserID=@id", con);
            cmd.Parameters.AddWithValue("@id", Session["UserID"]);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                if (dr["ApprovalStatus"].ToString() == "Rejected")
                {
                    lblRemark.Text = "Rejected: " + dr["AdminRemark"].ToString();
                }
            }
        }
    }

   protected void btnSubmit_Click(object sender, EventArgs e)
{
    if (txtShopName.Text == "" || txtGST.Text == "" ||
        txtAddress.Text == "" || !fuDoc.HasFile || !fuLogo.HasFile)
    {
        lblMsg.Text = "All fields are required";
        return;
    }

    int userId = Convert.ToInt32(Session["UserID"]);

    // ✅ ONLY FILE NAMES
    string docFileName = Guid.NewGuid() + Path.GetExtension(fuDoc.FileName);
    string logoFileName = Guid.NewGuid() + Path.GetExtension(fuLogo.FileName);

    // ✅ FULL SERVER PATH FOR SAVING
    string docSavePath = Server.MapPath("~/Uploads/VendorDocs/" + docFileName);
    string logoSavePath = Server.MapPath("~/Uploads/VendorLogos/" + logoFileName);

    fuDoc.SaveAs(docSavePath);
    fuLogo.SaveAs(logoSavePath);

    using (SqlConnection con = new SqlConnection(conStr))
    {
        con.Open();

        SqlCommand chk = new SqlCommand(
            "SELECT COUNT(*) FROM VendorDetails WHERE VendorID=@id", con);
        chk.Parameters.AddWithValue("@id", userId);

        int exists = Convert.ToInt32(chk.ExecuteScalar());

        SqlCommand cmd;

        if (exists > 0)
        {
            cmd = new SqlCommand(@"
                UPDATE VendorDetails
                SET ShopName=@shop,
                    GSTNumber=@gst,
                    Address=@addr,
                    DocumentPath=@doc,
                    LogoPath=@logo
                WHERE VendorID=@id", con);
        }
        else
        {
            cmd = new SqlCommand(@"
                INSERT INTO VendorDetails
                (VendorID, ShopName, GSTNumber, Address, DocumentPath, LogoPath)
                VALUES
                (@id, @shop, @gst, @addr, @doc, @logo)", con);
        }

        cmd.Parameters.AddWithValue("@id", userId);
        cmd.Parameters.AddWithValue("@shop", txtShopName.Text.Trim());
        cmd.Parameters.AddWithValue("@gst", txtGST.Text.Trim());
        cmd.Parameters.AddWithValue("@addr", txtAddress.Text.Trim());

        // ✅ DB ME SIRF FILE NAME
        cmd.Parameters.AddWithValue("@doc", docFileName);
        cmd.Parameters.AddWithValue("@logo", logoFileName);

        cmd.ExecuteNonQuery();

        SqlCommand upd = new SqlCommand(@"
            UPDATE Users
            SET IsSetupComplete=1,
                ApprovalStatus='Pending',
                AdminRemark=NULL
            WHERE UserID=@id", con);

        upd.Parameters.AddWithValue("@id", userId);
        upd.ExecuteNonQuery();
    }

    lblMsg.CssClass = "text-success text-center d-block mt-2";
    lblMsg.Text = "Setup submitted. Waiting for admin approval.";

    Response.Redirect("Login.aspx");
}

}