using Online_Examination_System.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Online_Examination_System.Views.Admin.Examination;

namespace Online_Examination_System.Views.Student
{
    public partial class MyExamination : System.Web.UI.Page
    {
        public class MyExam_Info
        {
            public int examId { get; set; }
            public string examName { get; set; }
            public string startTime { get; set; }
            public string endTime { get; set; }
            public bool submitted { get; set; }
        }
        public List<MyExam_Info> myExamList = new List<MyExam_Info>();
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
                string userid = Session["UserID"].ToString();
                if (!IsPostBack)
                {
                    MySQL mySQL = new MySQL();
                    try
                    {
                        string query = "select * from examination where memberList like'%" + userid + "%';";
                        //Debug.WriteLine(query);
                        using (var reader = mySQL.ExecuteReader(query))
                        {
                            while (reader.Read())
                            {
                                MySQL mySQL1 = new MySQL();
                                MyExam_Info exam = new MyExam_Info();
                                exam.examId = reader.GetUInt16("examinationId");

                                string query1 = "select * from submittedpaper where studentsId='" + userid + "' and examinationId='"+ exam.examId + "';";
                                try
                                {
                                    using (var reader1 = mySQL1.ExecuteReader(query1)) 
                                    {
                                        if (!reader1.Read())
                                        {
                                            exam.submitted = false;
                                        }else
                                        {
                                            exam.submitted = true;
                                        }
                                    }
                                }
                                catch (Exception ex)
                                {
                                    Debug.WriteLine(ex.Message);
                                }
                                Debug.WriteLine(query1);
                                Debug.WriteLine(exam.submitted);
                                exam.examName = reader.GetString("examinationName");
                                exam.startTime = reader.GetDateTime("startTime").ToString();
                                exam.endTime = reader.GetDateTime("endTime").ToString();
                                
                                myExamList.Add(exam);

                            }
                            examTable.DataSource = myExamList;
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
        protected void StartExam_Click(object sender, EventArgs e)
        {
            Button btnStartExam = sender as Button;
            if (btnStartExam != null)
            {
                int examIdToStart;
                if (int.TryParse(btnStartExam.CommandArgument, out examIdToStart))
                {
                    MySQL mySQL = new MySQL();
                    try
                    {
                        string query = "update user set currentExamId=" + examIdToStart + " where userid=" + Session["UserID"].ToString() + "; ";
                        Debug.WriteLine(query);
                        if (mySQL.ExecuteNonQuery(query) > 0)
                        {
                            Response.Redirect("ExamProgress.aspx", false);
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
        protected bool IsExamTimeValid(object startObj, object endObj)
        {
            DateTime startTime, endTime;
            if (DateTime.TryParse(startObj.ToString(), out startTime) && DateTime.TryParse(endObj.ToString(), out endTime))
            {
                DateTime now = DateTime.Now;
                return now >= startTime && now <= endTime;
            }
            return false;
        }


    }
}