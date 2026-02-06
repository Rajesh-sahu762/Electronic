using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AdminMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Prevent back button
        Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));

        // Session & role protection
        if (Session["UserID"] == null || Session["Role"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else if (Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            lblAdmin.Text = Session["FullName"].ToString();
        }
    }
}