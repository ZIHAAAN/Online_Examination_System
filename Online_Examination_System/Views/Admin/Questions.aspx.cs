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
    public partial class Questions : System.Web.UI.Page
    {
        public class Question
        {
            public int questionId { get; set; }
            public int type { get; set; }
            public string content { get; set; }
            public string imageLink { get; set; }
            public string questionOption { get; set; }
            public string answer { get; set; }
            public int submissionSum { get; set; }
            public int correct { get; set; }
            public string accuracy { get; set; }

        }
        public List<Question> queList = new List<Question>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                string script = "alert('No login! Please login first.');";
                script += "window.location.href = '../Login.aspx';";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerAlert", script, true);
                return;
            }
            string userid = Session["UserID"].ToString();
            if (!IsPostBack)
            {
                MySQL mySQL = new MySQL();
                try
                {
                    string query = "select * from questions where userId=" + userid + ";";
                    using (var reader = mySQL.ExecuteReader(query))
                    {
                        while (reader.Read())
                        {
                            Question que = new Question();
                            que.questionId = reader.GetUInt16("questionId");
                            que.type = reader.GetUInt16("type");
                            que.content = reader.GetString("content");
                            que.imageLink = reader.GetString("imageLink");
                            que.questionOption = reader.GetString("questionOption");
                            que.answer = reader.GetString("answer");
                            que.correct = 0;
                            que.submissionSum = 0;
                            MySQL mySQL1 = new MySQL();
                            try
                            {
                                string query1 = "select * from submittedquestion where questionId=" + que.questionId + ";";
                                using (var reader1 = mySQL1.ExecuteReader(query1))
                                {
                                    while (reader1.Read())
                                    {
                                        if (reader1.GetBoolean("result"))
                                        {
                                            que.correct++; que.submissionSum++;
                                        }
                                        else
                                        {
                                            que.submissionSum++;
                                        }
                                    }
                                }
                            }
                            catch (Exception ex) { Debug.WriteLine(ex.Message); }
                            if (que.submissionSum != 0)
                            {
                                que.accuracy = (que.correct / que.submissionSum).ToString()+"%";
                            }else { que.accuracy = "No result"; }
                            queList.Add(que);
                        }
                        questionTable.DataSource = queList;
                        questionTable.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }

            }
        }


        protected void DeleteQuestion_Click(object sender, EventArgs e)
        {
            Button btnDelete = sender as Button;
            if (btnDelete != null)
            {
                int questionIdToDelete;
                if (int.TryParse(btnDelete.CommandArgument, out questionIdToDelete))
                {
                    MySQL mySQL = new MySQL();
                    try
                    {
                        string query = "delete from questions where userId=" + Session["UserID"].ToString() + " and questionId=" + questionIdToDelete + "; ";
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