using Online_Examination_System.Models;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Examination_System
{
    public partial class AddStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string studentid = Request.QueryString["studentid"];
            string searchResult = ExcuteAdd(studentid);
            Response.Clear();
            Response.ContentType = "application/json";
            Response.Write(searchResult);
            Debug.WriteLine(searchResult);
        }
        private string ExcuteAdd(string studentid)
        {
            //string script = "alert('success、fail');";
            //ScriptManager.RegisterStartupScript(this, GetType(), "ServerAlert", script, true);
            var jsonObject = new JObject();
            MySQL mySQL = new MySQL();
            try
            {
                //string query = "select * from user where userid=" + studentsId + ";";
                string query = "insert into participant(teachersId,studentsId) values(" + Session["UserID"].ToString() + ","+ studentid+"); ";
                //Debug.WriteLine(query);
                
                if (mySQL.ExecuteNonQuery(query) > 0)
                    jsonObject["status"] = "success";
                else
                    jsonObject["status"] = "existed";
                //Debug.WriteLine(a);
            }
            catch
            {
                jsonObject["status"] = "something went wrong";
            }
            return jsonObject.ToString();
        }
    }
}