using Online_Examination_System.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Examination_System.Views.Admin
{
    public partial class Grade : System.Web.UI.Page
    {
        public class Exam_Grade
        {
            public int examId { get; set; }
            public string examName { get; set; }
            public int submissions { get; set; }    //Number of submissions
            public Double averageGrades { get; set; }


        }
        public List<Exam_Grade> ExamGradeList = new List<Exam_Grade>();
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
                MySQL mySQL1 = new MySQL();
                try
                {
                    string query1 = "select * from examination where teacherId=" + userid + ";";
                    using (var reader1 = mySQL1.ExecuteReader(query1))
                    {
                        while (reader1.Read())
                        {
                            Exam_Grade exam_Grade = new Exam_Grade();
                            exam_Grade.examId = reader1.GetUInt16("examinationId");
                            exam_Grade.examName = reader1.GetString("examinationName");
                            MySQL mySQL2 = new MySQL();
                            string query2 = string.Format("select grades from submittedpaper where teachersId='{0}' and examinationId='{1}'", userid, exam_Grade.examId);
                            try
                            {
                                using (var reader2 = mySQL2.ExecuteReader(query2))
                                {
                                    UInt16 sum = 0;
                                    Double average = 0;
                                    while (reader2.Read())
                                    {
                                        sum++;
                                        string grades = reader2.GetString("grades");
                                        if(grades != "-1" && grades != "-2")
                                        {
                                            string[] parts = grades.Split('/');
                                            Double DGrade = Double.Parse(parts[0])/ Double.Parse(parts[1]);
                                            average += DGrade;
                                        }
                                    }
                                    exam_Grade.submissions = sum;
                                    exam_Grade.averageGrades = average / sum * 100;
                                }
                                
                            }
                            catch (Exception ex) { 
                                Debug.WriteLine(ex.Message); 
                            }
                            ExamGradeList.Add(exam_Grade);
                        }
                        gradeTable.DataSource = ExamGradeList;
                        gradeTable.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }
            }
        }
    }
}