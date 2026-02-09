<%@ WebHandler Language="C#" Class="WishlistHandler" %>

using System;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;

public class WishlistHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";

        if (context.Session["UserID"] == null)
        {
            context.Response.Write("{\"status\":\"LOGIN\"}");
            return;
        }

        if (string.IsNullOrEmpty(context.Request.Form["pid"]))
        {
            context.Response.Write("{\"status\":\"ERROR\"}");
            return;
        }

        int uid = Convert.ToInt32(context.Session["UserID"]);
        int pid = Convert.ToInt32(context.Request.Form["pid"]);

        string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
        string status = "ADDED";

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            SqlCommand chk = new SqlCommand(
                "SELECT COUNT(*) FROM Wishlist WHERE UserID=@u AND ProductID=@p", con);
            chk.Parameters.AddWithValue("@u", uid);
            chk.Parameters.AddWithValue("@p", pid);

            int exists = Convert.ToInt32(chk.ExecuteScalar());

            if (exists > 0)
            {
                SqlCommand del = new SqlCommand(
                    "DELETE FROM Wishlist WHERE UserID=@u AND ProductID=@p", con);
                del.Parameters.AddWithValue("@u", uid);
                del.Parameters.AddWithValue("@p", pid);
                del.ExecuteNonQuery();

                status = "REMOVED";
            }
            else
            {
                SqlCommand ins = new SqlCommand(
                    "INSERT INTO Wishlist(UserID, ProductID) VALUES(@u,@p)", con);
                ins.Parameters.AddWithValue("@u", uid);
                ins.Parameters.AddWithValue("@p", pid);
                ins.ExecuteNonQuery();

                status = "ADDED";
            }

            SqlCommand cnt = new SqlCommand(
                "SELECT COUNT(*) FROM Wishlist WHERE UserID=@u", con);
            cnt.Parameters.AddWithValue("@u", uid);

            int total = Convert.ToInt32(cnt.ExecuteScalar());

            context.Response.Write(
                "{\"status\":\"" + status + "\",\"count\":" + total + "}"
            );
        }
    }

    // 🔥 THIS WAS MISSING
    public bool IsReusable
    {
        get { return false; }
    }
}
