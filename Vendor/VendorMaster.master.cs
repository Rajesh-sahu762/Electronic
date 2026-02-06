using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendor_VendorMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 🔐 Vendor only
        if (Session["UserID"] == null || Session["Role"] == null
            || Session["Role"].ToString() != "Vendor")
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            lblVendor.Text = Session["FullName"].ToString();
        }
    }
}