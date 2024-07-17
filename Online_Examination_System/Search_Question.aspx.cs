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
    public partial class Search_Question : System.Web.UI.Page
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
            if (keyword == "")
                keyword = "%";
            try
            {
                string query = "select * from questions where userId='"+ Session["UserID"].ToString()+"' and (content like'" + keyword + "' or questionId like'" + keyword + "');";
                Debug.WriteLine(query);
                using (var reader = mySQL.ExecuteReader(query))
                {
                    var jsonArray = new JArray();
                    while (reader.Read())
                    {
                        //Debug.WriteLine();
                        var jsonObject = new JObject();
                        jsonObject["questionId"] = reader.GetUInt16("questionId");
                        jsonObject["content"] = reader.GetString("content");
                        jsonObject["type"] = reader.GetUInt16("type");
                        jsonArray.Add(jsonObject);

                    }
                    if (jsonArray.Count > 0)
                    {
                        responseObject["question_info"] = jsonArray;
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