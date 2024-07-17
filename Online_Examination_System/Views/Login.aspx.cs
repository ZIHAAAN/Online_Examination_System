using Online_Examination_System.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Online_Examination_System.Views
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginBtn_Click(object sender, EventArgs e)
        {
            Int16 accountTypeFromPage = 0;
            if (AccountType.Value == "Teacher")
            {
                accountTypeFromPage = 1;
            }

            if (Username.Value == "" || Password.Value == "")
            {
                ErrMsg.Text = "Please input Username or Password";
            }
            else
            {
                MySQL mySQL = new MySQL();
                try
                {
                    string query = "select * from user where username='" + Username.Value + "';";

                    //Debug.WriteLine();
                    using (var reader = mySQL.ExecuteReader(query))   
                    {
                        reader.Read();

                        string password = reader.GetString("password");
                        UInt16 accounttype = reader.GetUInt16("accounttype");
                        if (Password.Value == password && accountTypeFromPage == accounttype)
                        {
                            UInt16 userid = reader.GetUInt16("userid");
                            Session["UserID"] = userid;
                            Session["Username"] = Username.Value;
                            Session["RealName"] = reader.GetString("name");
                            Session["AccountType"] = AccountType.Value;
                            if (accountTypeFromPage == 1)
                            {
                                Response.Redirect("Admin/StudentManagement.aspx", false);
                            }
                            else
                            {
                                Response.Redirect("Student/MyExamination.aspx", false);
                            }
                            
                        }
                        else
                        {
                            ErrMsg.Text = "The information you entered is incorrect";
                        }
                        //while (reader.Read())
                        //{
                        //    string username = reader.GetString("username");
                        //    string password = reader.GetString("password");
                        //    Debug.WriteLine($"NM: {username}, PD: {password}");

                        //}
                    }
                }
                catch (Exception ex)
                {
                    //Debug.WriteLine($"An error occurred: {ex.Message}");
                    ErrMsg.Text = "The account you entered does not exist!";
                }
            }
            //Response.Redirect("Admin/Questions.aspx");
        }

    }
}