using Online_Examination_System.Models;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Online_Examination_System.Views.Admin.StudentManagement;

namespace Online_Examination_System
{
    public partial class Search_Member : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string keyword = Request.QueryString["keyword"];
            string searchResult = PerformSearch(keyword);
            Response.Clear();
            Response.ContentType = "application/json";
            Response.Write(searchResult);
            Debug.WriteLine(searchResult);
        }
        private string PerformSearch(string keyword)
        {
            MySQL mySQL1 = new MySQL();
            var responseObject = new JObject();
            if (keyword == "")
                keyword = "%";
            try
            {
                string query1 = "select * from participant where teachersId='" + Session["UserID"].ToString() + "' and studentsId like'" + keyword + "';";
                Debug.WriteLine(query1);
                using (var reader1 = mySQL1.ExecuteReader(query1))
                {
                    var jsonArray = new JArray();
                    while (reader1.Read())
                    {
                        UInt16 studentsId = reader1.GetUInt16("studentsId");
                        MySQL mySQL2 = new MySQL();
                        try
                        {
                            string query2 = "select * from user where userid=" + studentsId + ";";
                            using (var reader2 = mySQL2.ExecuteReader(query2))
                            {
                                while (reader2.Read())
                                {
                                    var jsonObject = new JObject();
                                    jsonObject["userid"] = reader2.GetUInt16("userid");
                                    jsonObject["username"] = reader2.GetString("username");
                                    jsonObject["name"] = reader2.GetString("name");

                                    jsonArray.Add(jsonObject);
                                }
                            }

                        }
                        catch (Exception ex)
                        {
                            Debug.WriteLine(ex.Message);
                        }
                        
                        

                    }
                    if (jsonArray.Count > 0)
                    {
                        responseObject["student_info"] = jsonArray;
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