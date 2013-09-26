using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

using Newtonsoft.Json;
using EAFrame.Core;
using EAFrame.Core.Web;
using EAFrame.Core.Enums;
using EAFrame.WebControls;
using SunTek.Assessment.Domain;
using SunTek.Assessment.Service;
using SunTek.EAFrame.Infrastructure.Domain;
using SunTek.EAFrame.Infrastructure.Service;

namespace WebSite.Assessment
{
    public partial class ThirdParty : BasePage
    {
        ReportService reportService = new ReportService();
        UploadFileService uploadFileService = new UploadFileService();
        /// <summary>
        /// 初始化页面
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            gvList.PageChanged += new PagedGridView.PagintEventHandler(gvList_PageChanged);
        }

        void gvList_PageChanged(object sender, PagingArgs e)
        {
            ShowList(gvList, new PageInfo(e.PageIndex, e.PageSize, e.ItemCount));
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                ShowList(gvList, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
            }
        }

        /// <summary>
        /// 显示列表信息
        /// </summary>
        /// <param name="gvList">GridView对象</param>
        /// <param name="pageInfo">分页信息</param>
        public void ShowList(PagedGridView gvList, PageInfo pageInfo)
        {
            //  DataTable registers = registerService.GetRegisterByCorpID(parameters, RegisterType, corpID, yearMonth, pageInfo);
            IList<Report> reports = reportService.All();
            gvList.ItemCount = reports.Count;
            gvList.DataSource = reports;
            gvList.DataBind();
        }

        /// <summary>
        /// 刷新
        /// </summary>
        public void Refresh()
        {
            ShowList(gvList, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
        }

        public string DelFile(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                if (!string.IsNullOrWhiteSpace(argument))
                {
                    Report report = reportService.GetDomain(argument);
                    if (report != null)
                    {
                        reportService.Delete(report);
                        SunTek.EAFrame.Infrastructure.Domain.UploadFile uploadFile = uploadFileService.GetDomain(report.UploadFileID);
                        if (uploadFile != null)
                        {
                            uploadFileService.Delete(uploadFile);

                            if (File.Exists(uploadFile.FilePath))
                            {
                                File.Delete(uploadFile.FilePath);
                                File.Delete(uploadFile.FilePath.Substring(0,uploadFile.FilePath.LastIndexOf("."))+".swf");
                            }
                        }
                    }
                    actionResult = ActionResult.Success;


                    //记录操作日志
                    AddActionLog(report, PageContext.Action, actionResult, actionMessage);

                    ajaxResult.ActionResult = actionResult;
                 
                }
            }
            catch (Exception ex)
            {
                log.Error(actionMessage, ex);
            }
            //获取提示信息
            actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
            ajaxResult.PromptMsg = actionMessage;
            return JsonConvert.SerializeObject(ajaxResult);
        }

    }
}