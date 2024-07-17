using Online_Examination_System.Models;
using Mysqlx.Crud;
using Org.BouncyCastle.Asn1.Cmp;
using Org.BouncyCastle.Tls;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Examination_System.Views
{
    public partial class Register : System.Web.UI.Page
    {
        //int accountType = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        //protected void RadioButton3_CheckedChanged(object sender, EventArgs e)
        //{
        //    if (RadioButton3.Checked)
        //    {
        //        accountType = 0;
        //    }
        //}

        //protected void RadioButton4_CheckedChanged(object sender, EventArgs e)
        //{
        //    if (RadioButton4.Checked)
        //    {
        //        accountType = 1;
        //    }
        //}

        protected void RegisterBtn_Click(object sender, EventArgs e)
        {
            if (Username.Value == "" || Password.Value == "")
            {
                ErrMsg.Text = "Please input Username or Password";
            }else if(Password.Value!=CPassword.Value)
            {
                ErrMsg.Text = "Passwords do not match. Please try again";
            }
            else if (Name.Value == "")
            {
                ErrMsg.Text = "Please input your real name";
            }
            else
            {
                MySQL mySQL = new MySQL();
                try
                {
                    UInt16 inoutAccountType = 0;
                    if (AccountType.Value == "Teacher")
                    {
                        inoutAccountType = 1;
                    }
                    string query = "insert into user(username, password, accounttype, name) values('" + Username.Value + "', '" + Password.Value + "'," + inoutAccountType + ",'"+ Name.Type+"')";
                    int row = mySQL.ExecuteNonQuery(query);
                    if (row == 1)   //Registration successful
                    { 
                        ErrMsg.Text = "Registration successful";
                        string script = "alert('Registration successful!');";
                        script += "window.location.href = 'Login.aspx';";
                        ScriptManager.RegisterStartupScript(this, GetType(), "ServerAlert", script, true);
                    }
                    

                    
                }
                catch (Exception ex)
                {
                    ErrMsg.Text = "Sorry, Username already exists.<br> Try another one.";
                    Debug.WriteLine($"An error occurred: {ex.Message}");
                    
                }
            }

        }
    }
}