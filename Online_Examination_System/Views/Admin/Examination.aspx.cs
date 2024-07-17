using Online_Examination_System.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Online_Examination_System.Views.Admin.StudentManagement;

namespace Online_Examination_System.Views.Admin
{
    public partial class Examination : System.Web.UI.Page
    {
        public class Exam_Info
        {
            public int examId { get; set; }
            public string examName { get; set; }
            public string startTime { get; set; }
            public string endTime { get; set; }
        }
        public List<Exam_Info> examList = new List<Exam_Info>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                //string script = "alert('No login! Please login first.');";
                string script = "window.location.href = '../Login.aspx';";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerAlert", script, true);
            }
            else
            {
                string teacherId = Session["UserID"].ToString();
                if (!IsPostBack)
                {
                    MySQL mySQL = new MySQL();
                    try
                    {
                        string query = "select * from examination where teacherId=" + teacherId + ";";
                        using (var reader = mySQL.ExecuteReader(query))
                        {
                            while (reader.Read())
                            {
                                Exam_Info exam = new Exam_Info();
                                exam.examId = reader.GetUInt16("examinationId");
                                exam.examName = reader.GetString("examinationName");
                                exam.startTime = reader.GetDateTime("startTime").ToString();
                                exam.endTime = reader.GetDateTime("endTime").ToString();

                                examList.Add(exam);
                                
                            }
                            examTable.DataSource = examList;
                            examTable.DataBind();
                        }
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine(ex.Message);
                    }

                }
            }
        }
        protected void DeleteExam_Click(object sender, EventArgs e)
        {
            Button btnDelete = sender as Button;
            if (btnDelete != null)
            {
                int examIdToDelete;
                if (int.TryParse(btnDelete.CommandArgument, out examIdToDelete))
                {
                    MySQL mySQL = new MySQL();
                    try
                    {
                        string query = "delete from examination where teacherId=" + Session["UserID"].ToString() + " and examinationId=" + examIdToDelete + "; ";
                        //Debug.WriteLine(query);
                        if (mySQL.ExecuteNonQuery(query) > 0)
                        {
                            Response.Redirect(Request.Url.AbsoluteUri, false);
                            HttpContext.Current.ApplicationInstance.CompleteRequest();
                        }
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine("Delete fail: " + ex.Message);
                    }

                }
            }
        }
    }
}