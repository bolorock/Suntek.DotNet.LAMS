using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Net;
using SunTek.Assessment.Domain;
using SunTek.Assessment.Service;
using SunTek.EAFrame.Infrastructure.Domain;
using SunTek.EAFrame.Infrastructure.Service;
using EAFrame.Core;
using System.Diagnostics;

namespace WebSite.Assessment
{
    /// <summary>
    /// Summary description for UploadHandler
    /// </summary>
    public class UploadHandler : IHttpHandler
    {

        private void ExcutedCmd(string cmd, string args)
        {
            using (Process p = new Process())
            {

                ProcessStartInfo psi = new ProcessStartInfo(cmd, args);
                p.StartInfo = psi;
                p.Start();
                p.WaitForExit();
            }
        }

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Charset = "utf-8";

            //获取上传文件队列  
            HttpPostedFile oFile = context.Request.Files["Filedata"];
            if (oFile != null)
            {
                string fileName=oFile.FileName;
                string filePath=string.Format(@"{0}\{1}", SunTek.LAMS.LAMSContext.AssessmentFileDirectory, oFile.FileName);
                oFile.SaveAs(filePath);

                //切记，使用pdf2swf.exe 打开的文件名之间不能有空格，否则会失败
                string cmdStr = HttpContext.Current.Server.MapPath("../Scripts/FlashView/SWFTools/pdf2swf.exe");
                string savePath = HttpContext.Current.Server.MapPath("../AssessmentFile/");
                string sourcePath = @"""" + savePath + fileName + @"""";
                string targetPath = @"""" + savePath + fileName.Substring(0, fileName.LastIndexOf(".")) + ".swf" + @"""";
                //@"""" 四个双引号得到一个双引号，如果你所存放的文件所在文件夹名有空格的话，要在文件名的路径前后加上双引号，才能够成功
                // -t 源文件的路径
                // -s 参数化（也就是为pdf2swf.exe 执行添加一些窗外的参数(可省略)）
                string argsStr = "  -t " + sourcePath + " -s flashversion=9 -o " + targetPath;


                ExcutedCmd(cmdStr, argsStr);


                //保存信息到数据库
                using (ITransaction trans = UnitOfWork.BeginTransaction(typeof(Report)))
                {

                    SunTek.EAFrame.Infrastructure.Domain.UploadFile uploadFile = new SunTek.EAFrame.Infrastructure.Domain.UploadFile()
                    {
                        ID = IdGenerator.NewComb().ToString(),
                        FileName = oFile.FileName,
                        FilePath = filePath,
                        CreateTime = DateTime.Now,
                    };
                    UploadFileService uploadFileService = new UploadFileService();
                    uploadFileService.SaveOrUpdate(uploadFile);

                    Report report = new Report()
                    {
                        UploadFileID=uploadFile.ID,
                        Name = oFile.FileName,
                        CreateTime = DateTime.Now,
                        ID = IdGenerator.NewComb().ToString(),
                         
                    };

                    ReportService reportService = new ReportService();
                    reportService.SaveOrUpdate(report);

                    trans.Commit();
                }
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