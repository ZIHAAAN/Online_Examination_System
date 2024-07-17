using Online_Examination_System.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using MySqlX.XDevAPI;
using System.Collections;

namespace Online_Examination_System.Views.Admin
{
    public partial class StudentManagement : System.Web.UI.Page
    {
        public class Stu_Info
        {
            public int id { get; set; }
            public string realName { get; set; }
            public string nickName { get; set; }
        }

        public List<Stu_Info> stuList = new List<Stu_Info>();

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
                if (!IsPostBack)
                {
                    MySQL mySQL1 = new MySQL();
                    try
                    {
                        string query = "select * from participant where teachersId=" + userid + ";";
                        using (var reader1 = mySQL1.ExecuteReader(query))
                        {
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
                                            Stu_Info stu = new Stu_Info();
                                            stu.id = reader2.GetUInt16("userid");
                                            stu.nickName = reader2.GetString("username");
                                            stu.realName = reader2.GetString("name");

                                            stuList.Add(stu);
                                        }
                                    }

                                }
                                catch (Exception ex)
                                {
                                    Debug.WriteLine(ex.Message);
                                }
                            }
                            studentTable.DataSource = stuList;
                            studentTable.DataBind();
                        }
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine(ex.Message);
                    }

                }
            }

            
        }

        protected void DeleteStudent_Click(object sender, EventArgs e)
        {
            Button btnDelete = sender as Button;
            if (btnDelete != null)
            {
                int studentIdToDelete;
                if (int.TryParse(btnDelete.CommandArgument, out studentIdToDelete))
                {
                    // 在这里执行删除学生的逻辑
                    MySQL mySQL = new MySQL();
                    try
                    {
                        string query = "delete from participant where teachersId=" + Session["UserID"].ToString() + " and studentsId=" + studentIdToDelete + "; ";
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