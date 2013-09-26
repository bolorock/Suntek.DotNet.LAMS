#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Website
 * Module:  LAMS
 * Descrption:
 * CreateDate: 2010/11/18 
 * Author: hgq
 * Version:1.0
 * ===============================================================================*/
#endregion
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using log4net;
using Microsoft.Practices.Unity;
using EAFrame.Core;
using EAFrame.Core.Enums;
using EAFrame.Core.Service;
using EAFrame.Core.Security;
using EAFrame.Core.Extensions;
using EAFrame.Core.Web;
using EAFrame.Core.Caching;
using EAFrame.Core.Utility;
using EAFrame.Core.FastInvoker;
using EAFrame.WebControls;
using EAFrame.Core.Data;

using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;
using SunTek.LAMS.Domain;
using SunTek.LAMS.Service;
using Newtonsoft.Json;
using SunTek.LAMS.Uitl;

namespace WebSite
{
    /// <summary>
    /// Summary description for jqgridData
    /// </summary>
    public class jqgridData : IHttpHandler
    {
        protected ILog log = LogManager.GetLogger(typeof(jqgridData));
        EmployeeService employeeService = new EmployeeService();
        CandidateManagerService candidateManagerService = new CandidateManagerService();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Buffer = true;
            context.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
            context.Response.AddHeader("pragma", "no-cache");
            context.Response.AddHeader("cache-control", "");
            context.Response.CacheControl = "no-cache";

            //参数
            string type = string.IsNullOrEmpty(context.Request.QueryString["type"]) ? null : context.Request.QueryString["type"].ToString();
            string createTime =string.IsNullOrWhiteSpace(context.Request.QueryString["createTime"]) ? null : context.Request.QueryString["createTime"].ToString();

            //jqgrid传来的参数
            string sPage = HttpContext.Current.Request.Params["page"].ToString();  //当前请求第几页        
            int iPage = int.Parse(sPage);  
            string sLimit = HttpContext.Current.Request.Params["rows"].ToString(); //grid需要显示几行      
            int iLimit = int.Parse(sLimit);       
            string sSidx = HttpContext.Current.Request.Params["sidx"].ToString();  //按什么排序      
            string sSord = HttpContext.Current.Request.Params["sord"].ToString();  //排序方式('desc'/'asc')

            string strJson = string.Empty;

            if (string.IsNullOrWhiteSpace(type)) return;

            switch (type)
            {
                case "0": //导入后备经理人
                    strJson = GetEmployeeListFromImport(iPage - 1, iLimit, sSidx, sSord,createTime);
                    break;
                case "1": //导入后备资格经理人
                    strJson = GetCandidateManagerFromImport(iPage - 1, iLimit, sSidx, sSord,createTime);
                    break;
                case "2": //后备经理人列表信息
                    strJson = GetEmployeeList(iPage - 1, iLimit, sSidx, sSord);
                    break;
                case "3": //后备资格经理人列表信息
                    strJson = GetCandidateManager(iPage - 1, iLimit, sSidx, sSord);
                    break;
            }
            context.Response.Write(strJson);
        }

        #region 获取导入的后备经理人详细信息
        /// <summary>
        /// 获取满足条件的员工
        /// </summary>
        /// <param name="employeeCodes"></param>
        /// <returns></returns>
        private string GetEmployeeListFromImport(int page, int rows, string sidx, string sord,string createTime)
        {
            Dictionary<string, object> dictionary = new Dictionary<string, object>();
            DateTimePair dateTimePair = new DateTimePair() { StartTime = createTime.ToDateTime(), EndTime = null };
            dictionary.Add("CreateTime", dateTimePair);
            IList<Employee> employeeList = employeeService.FindAll(dictionary);
            if (employeeList.Count==0) return string.Empty;

            int pageTotal = (int)Math.Ceiling((double)employeeList.Count / (double)rows);
            try
            {
                var data = from emp in employeeList
                           select new
                           {
                               ID=emp.ID,
                               Code = emp.Code,
                               Name = emp.Name,
                               Gender = emp.Gender == 0 ? "男" : "女",
                               Birthday = emp.Birthday,
                               Nation = emp.Nation,
                               CreateTime=emp.CreateTime
                           };
                //排序
                string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "asc");
                data = LinqSort.OrderBy(data.AsQueryable(), sortExpression);

                //分页
                var query = data.Skip(page * rows).Take(rows);

                var ret = new
                {
                    total = pageTotal, //总页数
                    page = page + 1,  //当前页
                    records = employeeList.Count, //每页显示条数                        
                    rows = query
                };

                string strJson = JsonConvert.SerializeObject(ret, new Newtonsoft.Json.Converters.IsoDateTimeConverter());
                return strJson;
            }
            catch (Exception ex)
            {
                log.Error("导入后备经理Excel数据后获取数据列表出错！", ex);
                return string.Empty;
            }
        }
        #endregion

        #region "后备经理人列表信息"
        private string GetEmployeeList(int page, int rows, string sidx, string sord)
        {
            IList<Employee> employeeList = employeeService.FindAll(null);
            int pageTotal = (int)Math.Ceiling((double)employeeList.Count / (double)rows);
            try
            {
                //用linq获取 部分字段，且由List生成json
                var data = from emp in employeeList
                           select new
                           {
                               Code = emp.Code,
                               Name = emp.Name,
                               Gender = emp.Gender == 0 ? "男" : "女",
                               Birthday = emp.Birthday,
                               Nation = emp.Nation,
                               CreateTime = emp.CreateTime
                           };
                //排序
                string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "asc");
                data = LinqSort.OrderBy(data.AsQueryable(), sortExpression);

                //分页
                var query = data.Skip(page * rows).Take(rows);

                var ret = new
                {
                    total = pageTotal, //总页数
                    page = page + 1,  //当前页
                    records = employeeList.Count, //每页显示条数                        
                    rows = query
                };

                string strJson = JsonConvert.SerializeObject(ret, new Newtonsoft.Json.Converters.IsoDateTimeConverter());
                return strJson;

            }
            catch (Exception ex)
            {
                log.Error("获取后备经理人数据列表出错！", ex);
                return string.Empty;
            }
        }
        #endregion

        #region "后备资格经理人列表信息"
        private string GetCandidateManager(int page, int rows, string sidx, string sord)
        {
            IList<CandidateManager> candidateManagerList = candidateManagerService.FindAll(null);
            int pageTotal = (int)Math.Ceiling((double)candidateManagerList.Count / (double)rows);
            try
            {
                var data = from c in candidateManagerList
                           select new
                           {
                               Code = c.Code,
                               TargetCandidate = c.TargetCandidate,
                               InPostDate = c.InPostDate,
                               InGradeDate = c.InGradeDate,
                               Tenure = c.Tenure,
                               CandidateMaturity = c.CandidateMaturity,
                               CreateTime = c.CreateTime
                           };
                //排序
                string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "asc");
                data = LinqSort.OrderBy(data.AsQueryable(), sortExpression);

                //分页
                var query = data.Skip(page * rows).Take(rows);

                var ret = new
                {
                    total = pageTotal, //总页数
                    page = page + 1,  //当前页
                    records = candidateManagerList.Count, //总条数                        
                    rows = query
                };

                string strJson = JsonConvert.SerializeObject(ret, new Newtonsoft.Json.Converters.IsoDateTimeConverter());
                return strJson;
            }
            catch (Exception ex)
            {
                log.Error("获取后备资格经理人数据列表出错！", ex);
                return string.Empty;
            }
        }
        #endregion

        #region 获取导入的后备经理人资格信息
        private string GetCandidateManagerFromImport(int page, int rows, string sidx, string sord,string createTime)
        {
            Dictionary<string,object> dictionary=new Dictionary<string,object>();
            DateTimePair dateTimePair = new DateTimePair() { StartTime =createTime.ToDateTime(), EndTime =null };
            dictionary.Add("CreateTime",dateTimePair);
            IList<CandidateManager> candidateManagerList = candidateManagerService.FindAll(dictionary);
            if (candidateManagerList.Count==0) return string.Empty;

            int pageTotal = (int)Math.Ceiling((double)candidateManagerList.Count / (double)rows);
            try
            {
                var data = from c in candidateManagerList
                           select new
                           {
                               Code = c.Code,
                               TargetCandidate = c.TargetCandidate,
                               InPostDate = c.InPostDate,
                               InGradeDate = c.InGradeDate,
                               Tenure = c.Tenure,
                               CandidateMaturity = c.CandidateMaturity,
                               CreateTime=c.CreateTime
                           };
                //排序
                string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "asc");
                data = LinqSort.OrderBy(data.AsQueryable(), sortExpression);

                //分页
                var query = data.Skip(page * rows).Take(rows);

                var ret = new
                {
                    total = pageTotal, //总页数
                    page = page + 1,  //当前页
                    records = candidateManagerList.Count, //每页显示条数                        
                    rows = query
                };

                string strJson = JsonConvert.SerializeObject(ret, new Newtonsoft.Json.Converters.IsoDateTimeConverter());
                return strJson;
            }
            catch (Exception ex)
            {
                log.Error("导入二级经理Excel数据后获取数据列表出错！", ex);
                return string.Empty;
            }
        }
        #endregion

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}