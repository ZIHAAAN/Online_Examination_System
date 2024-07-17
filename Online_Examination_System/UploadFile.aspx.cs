using Online_Examination_System.Models;
using System;
using System.IO;
using System.Web;

namespace Online_Examination_System
{
    public partial class UploadFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Files.Count > 0)
            {
                HttpPostedFile postedFile = Request.Files[0];
                if (postedFile != null && postedFile.ContentLength > 0)
                {
                    try
                    {
                        string fileExtension = Path.GetExtension(postedFile.FileName);
                        //string fileName = Path.GetFileName(postedFile.FileName);
                        string fileName = "File_" + DateTime.Now.ToString("yyyyMMdd_HHmmss_") + Guid.NewGuid().ToString() + fileExtension;
                        string uploadPath = Server.MapPath("~/ImageUploads/") + fileName;

                        postedFile.SaveAs(uploadPath);
                        Response.Write(fileName);
                        
                    }
                    catch (Exception ex)
                    {
                        Response.Write("File upload failed. Error: " + ex.Message);
                    }
                }
            }
            else
            {
                Response.Write("Please select a file to upload.");
            }
        }
    }
}
