using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Client_Default : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            LoadProducts();
    }

    void LoadProducts()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(@"
SELECT TOP 8 p.ProductID, p.ProductName, p.Price,
       (SELECT TOP 1 ImagePath FROM ProductImages WHERE ProductID=p.ProductID) AS ImagePath
FROM Products p
JOIN Users u ON u.UserID = p.VendorID
WHERE p.IsBlocked=0 AND u.IsApproved=1
ORDER BY p.CreatedAt DESC", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptProducts.DataSource = dt;
            rptProducts.DataBind();
        }
    }
}
