using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Net;

namespace WebSite.Register
{
    /// <summary>
    /// Summary description for UploadHandler
    /// </summary>
    public class UploadHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Charset = "utf-8";

            //获取上传文件队列  
            HttpPostedFile oFile = context.Request.Files["Filedata"];
            if (oFile != null)
            {
                string fileName = string.Empty;
                string code = context.Request["code"];
                if (string.IsNullOrEmpty(code))
                {
                    fileName = oFile.FileName.Substring(0, oFile.FileName.IndexOf("."));
                }
                else
                {
                    fileName = code;
                }
                oFile.SaveAs(string.Format(@"{0}\{1}.jpg", SunTek.LAMS.LAMSContext.EmployeePhotoDirectory, fileName));
                context.Response.Write("1");
            }
            else
            {
                context.Response.Write("0");
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}