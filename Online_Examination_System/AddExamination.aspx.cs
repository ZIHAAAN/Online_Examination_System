using Online_Examination_System.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Examination_System
{
    public partial class AddExamination : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string teacherId = Session["UserID"].ToString();

            
            string examinationName = Request.QueryString["examinationName"];
            string questionList = Request.QueryString["questionList"];
            string startTime = Request.QueryString["startTime"];
            string endTime = Request.QueryString["endTime"];
            string memberList = Request.QueryString["memberList"];
            string config = Request.QueryString["config"];

            string status = "success";
            MySQL mySQL = new MySQL();
            string query = string.Format("INSERT INTO examination(teacherId, examinationName, questionList, startTime, endTime, memberList, config) VALUES ('{0}', '{1}', '{2}', '{3}', '{4}', '{5}', '{6}')", teacherId, examinationName, questionList, startTime, endTime, memberList, config);
            Debug.WriteLine(query);
            try
            {
                mySQL.ExecuteNonQuery(query);
            }
            catch (Exception ex)
            {
                status = "fail";
            }
            Response.Write(status);
        }
    }
}