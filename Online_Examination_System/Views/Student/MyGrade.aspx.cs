using Online_Examination_System.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Online_Examination_System.Views.Admin.Marking;

namespace Online_Examination_System.Views.Student
{
    public partial class MyGrade : System.Web.UI.Page
    {
        public class SubPaper_Info
        {
            public int examId { get; set; }
            public string examName { get; set; }
            public string studentsName { get; set; }
            public int studentsId { get; set; }
            public string content { get; set; }
            public string grades { get; set; }


        }
        public List<SubPaper_Info> mySubPaper = new List<SubPaper_Info>();
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
                MySQL mySQL = new MySQL();
                try
                {
                    string query = "select * from submittedpaper where studentsId=" + userid + ";";
                    using (var reader = mySQL.ExecuteReader(query))
                    {
                        while (reader.Read())
                        {
                            SubPaper_Info subPaper_Info = new SubPaper_Info();
                            subPaper_Info.examId = reader.GetUInt16("examinationId");
                            subPaper_Info.examName = reader.GetString("examinationName");
                            subPaper_Info.studentsName = reader.GetString("studentsName");
                            //subPaper_Info.studentsId = reader.GetUInt16("studentsId");
                            subPaper_Info.content = reader.GetString("content");
                            subPaper_Info.grades = reader.GetString("grades");
                            mySubPaper.Add(subPaper_Info);


                        }
                        markTable.DataSource = mySubPaper;
                        markTable.DataBind();
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