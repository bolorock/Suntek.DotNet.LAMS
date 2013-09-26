using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Configuration;


using EAFrame.Core.Utility;
using EAFrame.Core.Extensions;

namespace SunTek.LAMS
{
    public class LAMSContext
    {
        static LAMSContext()
        {
            //string path = Path.Combine(WebUtil.GetSiteDirectory(), EmployeePhotoDirectory);
            if (!Directory.Exists(EmployeePhotoDirectory)) Directory.CreateDirectory(EmployeePhotoDirectory);
        }

        public static string EmployeePhotoDirectory
        {
            get
            {
                return Path.Combine(WebUtil.GetSiteDirectory(), ConfigurationManager.AppSettings["EmployeePhotoDirectory"]);
            }
        }

        public static string RelativePhotoDirectory
        {
            get
            {
                return Path.Combine(@"..", ConfigurationManager.AppSettings["EmployeePhotoDirectory"]);
            }
        }

        public static string AssessmentFileDirectory
        {
            get
            {
                return Path.Combine(WebUtil.GetSiteDirectory(), ConfigurationManager.AppSettings["AssessmentFileDirectory"]);
            }
        }
    }
}
