using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Examination_System.Views.Admin
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                // Already login
                string username = Session["Username"].ToString();
                RealName.Text = Session["RealName"].ToString();

            }
            else
            {
                // No login, back to Login.aspx
                //string script = "alert('No login! Please login first.');";
                string script = "window.location.href = '../Login.aspx';";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerAlert", script, true);
                return;
                //Response.Redirect("../Login.aspx");
            }
        }
    }
}