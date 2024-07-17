using Online_Examination_System.Models;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Examination_System.Views.Student
{
    public partial class ExamProgress : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                //string script = "alert('No login! Please login first.');";
                string script = "window.location.href = '../Login.aspx';";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerAlert", script, true);
            }
            

        }
    }
}