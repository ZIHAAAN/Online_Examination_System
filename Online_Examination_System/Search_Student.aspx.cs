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
    public partial class Search_Student : System.Web.UI.Page
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
            MySQL mySQL = new MySQL();
            var responseObject = new JObject();
            try
            {
                string query = "select * from user where name='" + keyword + "' or userid='" + keyword + "';";
                using (var reader = mySQL.ExecuteReader(query))
                {
                    var jsonArray = new JArray();
                    while (reader.Read())
                    {
                        //Debug.WriteLine();
                        var jsonObject = new JObject();
                        jsonObject["studentid"] =  reader.GetUInt16("userid");
                        jsonObject["username"] = reader.GetString("username");
                        jsonObject["name"] = reader.GetString("name");
                        jsonArray.Add(jsonObject);

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