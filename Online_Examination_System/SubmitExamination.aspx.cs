using Online_Examination_System.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Examination_System
{
    public partial class SubmitExamination : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string userId = Session["UserID"].ToString();
            string studentsName = Session["RealName"].ToString();
            string content = Request.QueryString["content"];
            string examinationId = Request.QueryString["examinationId"];
            string examinationName = Request.QueryString["examinationName"];
            string teachersId = Request.QueryString["teachersId"];
            //Debug.WriteLine(userId);
            //Debug.WriteLine(content);
            //Debug.WriteLine(examinationId);
            //Check exam time!
            MySQL mySQL = new MySQL(); 
            string query = string.Format("INSERT INTO submittedpaper(studentsId, teachersId, studentsName, examinationId, examinationName, content) VALUES ('{0}', '{1}', '{2}', '{3}', '{4}', '{5}')", userId, teachersId, studentsName, examinationId, examinationName, content);
            Debug.WriteLine(query);
            string status = "success";
            try
            {
                mySQL.ExecuteNonQuery(query);
            }
            catch (Exception ex)
            {
                status = "fail";
            }
            Response.Write(status);

            if (status == "success")
            {
                MySQL mySQL1 = new MySQL();
                try
                {
                    string query1 = "update user set currentExamId=NULL where userid=" + Session["UserID"].ToString() + "; ";
                    Debug.WriteLine(query1);
                    mySQL.ExecuteNonQuery(query1);
                }
                catch (Exception ex)
                {
                    Debug.WriteLine("Delete fail: " + ex.Message);
                }
            }
        }
    }
}