using Online_Examination_System.Models;
using Online_Examination_System.Views.Admin;
using MySqlX.XDevAPI;
using Newtonsoft.Json.Linq;
using System;
using System.Diagnostics;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Online_Examination_System.Views.Admin.Marking;
using System.Collections;

namespace Online_Examination_System
{
    public partial class AutoMark : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string teachersId = Session["UserID"].ToString();
            string status = "success";
            MySQL mySQL1 = new MySQL();
            try
            {
                string query1 = "select * from submittedpaper where teachersId=" + teachersId + ";";
                using (var reader1 = mySQL1.ExecuteReader(query1))
                {
                    while (reader1.Read())
                    {
                        UInt16 examId = reader1.GetUInt16("examinationId");
                        UInt16 studentsId = reader1.GetUInt16("studentsId");
                        string content = reader1.GetString("content");
                        Int16 grades = reader1.GetInt16("grades");

                        JObject json = JObject.Parse(content);

                        int a = 0, b = json.Count;
                        foreach (var item in json)
                        {
                            MySQL mySQL2 = new MySQL();
                            string query2 = "select answer from questions where questionId=" + item.Key + ";";
                            Debug.WriteLine(query2);
                            string answer = mySQL2.ExecuteScalar(query2).ToString();
                            MySQL mySQLQuestion = new MySQL();
                            string queryQuestion = string.Format("INSERT INTO submittedquestion(studentsId, teachersId, examinationId, questionId, result) VALUES ('{0}', '{1}', '{2}', '{3}', '{4}')", studentsId, teachersId, examId, item.Key, '1');
                            if (answer == item.Value.ToString())
                            {
                                a++;
                            }
                            else
                            {
                                queryQuestion = string.Format("INSERT INTO submittedquestion(studentsId, teachersId, examinationId, questionId, result) VALUES ('{0}', '{1}', '{2}', '{3}', '{4}')", studentsId, teachersId, examId, item.Key, '0');
                            }
                            //Debug.WriteLine(queryQuestion);
                            mySQLQuestion.ExecuteNonQuery(queryQuestion);
                        }
                        //Debug.WriteLine(a + "/" + b);
                        MySQL mySQL3 = new MySQL();
                        try
                        {
                            string query3 = "update submittedpaper set grades='" + a + "/" + b + "' where studentsId=" + studentsId + " and examinationId="+ examId + "; ";
                            //Debug.WriteLine(query3);
                            mySQL3.ExecuteNonQuery(query3);
                        }
                        catch (Exception ex)
                        {
                            status = "fail";
                            Debug.WriteLine("Delete fail: " + ex.Message);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                status = "fail";
                Debug.WriteLine("Delete fail: " + ex.Message);
            }
            Response.Write(status);
        }
    }
}