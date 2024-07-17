using Online_Examination_System.Models;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Examination_System
{
    public partial class LoadExamination : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            string searchResult = PerformSearch();
            Response.Clear();
            Response.ContentType = "application/json";
            Response.Write(searchResult);
            //Debug.WriteLine(searchResult);
        }
        private string PerformSearch()
        {

            MySQL mySQL1 = new MySQL();
            var returnJson = new JObject();
            var jsonArray = new JArray();

            try
            {
                string query = "select currentExamId from user where userid='" + Session["UserID"] + "';";
                String examId = mySQL1.ExecuteScalar(query).ToString();
                //Debug.WriteLine(examId);
                MySQL mySQL2 = new MySQL();
                
                try
                {
                    string query2 = "select * from examination where examinationId=" + examId + ";";
                    String questionList = null;
                    using (var reader2 = mySQL2.ExecuteReader(query2))
                    {
                        while (reader2.Read())
                        {
                            var jsonExamination = new JObject();
                            returnJson["examinationId"] = reader2.GetUInt16("examinationId");
                            returnJson["teachersId"] = reader2.GetUInt16("teacherId");
                            returnJson["examinationName"] = reader2.GetString("examinationName");
                            questionList = reader2.GetString("questionList");
                            returnJson["startTime"] = reader2.GetDateTime("startTime").ToString();
                            
                            DateTime endTime = reader2.GetDateTime("endTime");
                            TimeSpan timeLeft = endTime - DateTime.Now;
                            int secondsLeft = (int)timeLeft.TotalSeconds;
                            
                            returnJson["secondsLeft"] = secondsLeft;
                            returnJson["endTime"] = endTime.ToString();
                            returnJson["config"] = reader2.GetString("config");
                        }
                    }
                    //String questionList = mySQL2.ExecuteScalar(query2).ToString();
                    MySQL mySQL3 = new MySQL();
                    Array questions = questionList.Split('|');
                    foreach (var item in questions)
                    {
                        
                        string query3 = "select * from questions where questionId=" + item + ";";
                        //Debug.WriteLine(query3);
                        using (var reader3 = mySQL3.ExecuteReader(query3))
                        {
                            while (reader3.Read())
                            {
                                var jsonQuestion = new JObject();
                                jsonQuestion["questionId"] = reader3.GetUInt16("questionId");
                                jsonQuestion["content"] = reader3.GetString("content");
                                jsonQuestion["type"] = reader3.GetUInt16("type");
                                jsonQuestion["imageLink"] = reader3.GetString("imageLink");
                                jsonQuestion["questionOption"] = reader3.GetString("questionOption");
                                jsonQuestion["answer"] = reader3.GetString("answer");
                                jsonArray.Add(jsonQuestion);
                            }
                            returnJson["questionList"] = jsonArray;
                        }
                    }
                    

                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }

            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }
            return returnJson.ToString();

        }
    }
}