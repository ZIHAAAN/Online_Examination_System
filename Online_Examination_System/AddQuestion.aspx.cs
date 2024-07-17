using Online_Examination_System.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Examination_System
{
    public partial class AddQuestion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string userId = Session["UserID"].ToString();
            string content = Request.QueryString["content"];
            string type = Request.QueryString["type"];
            string imageLink = Request.QueryString["imageLink"];
            string questionOption = Request.QueryString["questionOption"];
            string answer = Request.QueryString["answer"];
            string action = Request.QueryString["action"];
            string questionId = Request.QueryString["questionId"];

            string status = "success";
            MySQL mySQL = new MySQL();
            string query = string.Format("INSERT INTO questions(userId, content, type, imageLink, questionOption, answer) VALUES ('{0}', '{1}', '{2}', '{3}', '{4}', '{5}')", userId, content, type, imageLink, questionOption, answer);
            if (action == "updata")
            {
                query = string.Format("UPDATE questions SET content='{0}', type='{1}', imageLink='{2}', questionOption='{3}', answer='{4}' WHERE questionId='{5}'" , content, type, imageLink, questionOption, answer, questionId);

            }
            Debug.WriteLine(query);
            try
            {
                mySQL.ExecuteNonQuery(query);
            }
            catch(Exception ex)
            {
                status = "fail";
            }
            Response.Write(status);

        }
    }
}