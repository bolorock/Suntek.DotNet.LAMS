using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

using EAFrame.Core;
using EAFrame.Core.Enums;
using SunTek.Register.Domain;
using SunTek.Register.Service;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using log4net;

namespace WebSite.Register
{
    /// <summary>
    /// Summary description for jqGridData
    /// </summary>
    public class jqGridData : IHttpHandler
    {
        protected ILog log = LogManager.GetLogger(typeof(jqgridData));
        RegisterService registerService = new RegisterService();
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
            string createTime = string.IsNullOrWhiteSpace(context.Request.QueryString["createTime"]) ? null : context.Request.QueryString["createTime"].ToString();

            //jqgrid传来的参数
            string sPage = HttpContext.Current.Request.Params["page"];  //当前请求第几页        
            int iPage = int.Parse(sPage);
            string sLimit = HttpContext.Current.Request.Params["rows"].ToString(); //grid需要显示几行      
            int records = int.Parse(sLimit);
            string sSidx = HttpContext.Current.Request.Params["sidx"].ToString();  //按什么排序      
            string sSord = HttpContext.Current.Request.Params["sord"].ToString();  //排序方式('desc'/'asc')

            string strJson = string.Empty;

            if (string.IsNullOrWhiteSpace(type)) return;
            strJson = GetDataList(iPage, records, sSidx, sSord, createTime);
            context.Response.Write(strJson);
        }

        private string GetDataList(int page, int records, string sidx, string sord, string createTime)
        {
            string yearMonth = HttpContext.Current.Request.Params["yearMonth"];
            string registerType = HttpContext.Current.Request.Params["registerType"] ?? string.Empty;
            string managerType = RemarkAttribute.GetEnumRemark((ManagerType)Enum.Parse(typeof(ManagerType), registerType.Replace("Complete", "")));
            string corpID = HttpContext.Current.Request.Params["corpID"];
            string corpName = HttpContext.Current.Request.Params["corpName"];
            string filterStr = HttpContext.Current.Request.Params["filterStr"]; //查询条件
            IDictionary<string, object> para = new Dictionary<string, object>();
            string showField = string.Empty;
            string template =SystemUtil.GetTemplateFilePath(registerType);
            IList<FieldSet> fields = SystemUtil.GetFieldList(template).Where(p => p.IsShow == 1).OrderBy(f => f.SortOrder).ToList();
            if (fields == null)
            {
                return string.Empty;
            }

            foreach (var field in fields)
            {
                showField += field.FieldCode + ",";
            }

            PageInfo pageInfo = new PageInfo(page, records, 0);

            if (!string.IsNullOrEmpty(filterStr))
            {
                para = JsonConvert.DeserializeObject<IDictionary<string, object>>(filterStr)
                    .Where(p => !string.IsNullOrEmpty(p.Value.ToString()) && p.Value.ToString()!="-1")
                    .ToDictionary(p => p.Key, p => p.Value);
               
            }
            if (!para.Keys.Contains("Department") && !string.IsNullOrEmpty(corpName))
            {
                if (corpName != "中国电信广东公司")
                {
                    para.Add("Department", corpName);
                }
            }
            DataTable dt = registerService.GetRegisters(para, corpID, managerType, yearMonth, showField, pageInfo);

            if (dt == null) return string.Empty;

            int pageTotal = (int)Math.Ceiling((double)pageInfo.ItemCount / (double)records);
            try
            {
                //    //排序
                //    string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "asc");
                //    data = LinqSort.OrderBy(data.AsQueryable(), sortExpression);

                string strJson = JsonConvert.SerializeObject(dt, new DataTableConverter()); //JsonConvert.SerializeObject(dt, new Newtonsoft.Json.Converters.IsoDateTimeConverter());
                return string.Format("{{\"total\":{0},\"page\":{1},\"records\":{2},\"rows\":{3}}}", pageTotal, page, pageInfo.ItemCount, strJson);
            }
            catch (Exception ex)
            {
                log.Error("获取名册数据出错！", ex);
                return string.Empty;
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