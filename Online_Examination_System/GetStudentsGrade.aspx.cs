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
    public partial class GetStudentsGrade : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string examId = Request.QueryString["examId"];
            string searchResult = PerformSearch(examId);
            Response.Clear();
            Response.ContentType = "application/json";
            Response.Write(searchResult);
            //Debug.WriteLine(searchResult);
        }
        private string PerformSearch(string examId)
        {
            MySQL mySQL = new MySQL();
            var responseObject = new JObject();
            try
            {
                string query = "select * from submittedpaper where examinationId='" + examId + "';";
                using (var reader = mySQL.ExecuteReader(query))
                {
                    var jsonArray = new JArray();
                    while (reader.Read())
                    {
                        //Debug.WriteLine();
                        var jsonObject = new JObject();
                        jsonObject["studentsId"] = reader.GetUInt16("studentsId");
                        jsonObject["studentsName"] = reader.GetString("studentsName");
                        jsonObject["grades"] = reader.GetString("grades");

                        jsonArray.Add(jsonObject);

                    }
                    if (jsonArray.Count > 0)
                    {
                        responseObject["grades_info"] = jsonArray;
                        responseObject["status"] = "success";
                    }
                    else
                    {
                        responseObject["status"] = "no result";
                    }

                }
            }
            catch (Exception ex)
            {
                responseObject["status"] = "something went wrong!";
            }

            return responseObject.ToString();
        }
    }
}