﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Assessment
 * Module:  Survey
 * Descrption:
 * CreateDate: 2010/11/18 14:01:00
 * Author: trenhui
 * Version:1.0
 * ===============================================================================
 * History
 *
 * Update Descrption:
 * Remark:
 * Update Time:
 * Author:generated by codesmithTemplate
 * 
 * ===============================================================================*/
#endregion
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using System.Text;

using Microsoft.Practices.Unity;
using log4net;
using EAFrame.Core;
using EAFrame.Core.Enums;
using EAFrame.Core.Service;
using EAFrame.Core.Security;
using EAFrame.Core.Extensions;
using EAFrame.Core.Web;
using EAFrame.Core.Caching;
using EAFrame.Core.FastInvoker;
using EAFrame.Core.DataFilter;
using EAFrame.WebControls;
using SunTek.Assessment.Domain;
using SunTek.Assessment.Service;
using Newtonsoft.Json;
using EAFrame.Core.Data;
using System.Data;

namespace WebSite
{
    public partial class ExpertScoreList : BasePage
    {
        private SurveyService surveyService = new SurveyService();
        private ExpertService expertService = new ExpertService();
        #region ---界面处理方法---

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
                gvList.IncludeRowDoubleClick = !Request.QueryString["Entry"].EqualIgnoreCase("test");
                ShowList(gvList, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
            }
        }

        #endregion

        #region ---操作处理方法---
        /// <summary>
        /// 转向明细页面
        /// </summary>
        /// <param name="param"></param>
        protected void Redirect(string param)
        {
            var currentIdParam = PageContext.Action == ActionType.Add ? string.Empty : string.Format("&CurrentId={0}", CurrentId);
            Response.Redirect(string.Format("SurveyDetail.aspx?LastUrl={0}&Runat=1&ActionFlag={1}{2}{3}", Request.Url.PathAndQuery, PageContext.Action, currentIdParam, string.IsNullOrEmpty(param) ? param : "&" + param));
        }

        /// <summary>
        /// 新增
        /// </summary>
        public void Add()
        {
            PageContext.Action = ActionType.Add;
            PageContext.PageIndex = gvList.PageIndex;
            SavePageContext(PageContext);

            Redirect(string.Empty);
        }

        /// <summary>
        /// 查看
        /// </summary>
        public void View()
        {
            PageContext.Action = ActionType.View;
            PageContext.PageIndex = gvList.PageIndex;
            SavePageContext(PageContext);

            Redirect(string.Empty);
        }

        /// <summary>
        /// 修改
        /// </summary>
        public void Update()
        {
            PageContext.Action = ActionType.Update;
            PageContext.PageIndex = gvList.PageIndex;
            SavePageContext(PageContext);

            Redirect(string.Empty);
        }
        /// <summary>
        /// 查询
        /// </summary>
        public void Search()
        {
            ShowList(gvList, new PageInfo(1, gvList.PageSize, gvList.ItemCount));
        }
        /// <summary>
        /// 刷新
        /// </summary>
        public void Refresh()
        {
            ShowList(gvList, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
        }

        /// <summary>
        /// 显示列表信息
        /// </summary>
        /// <param name="gvList">GridView对象</param>
        /// <param name="pageInfo">分页信息</param>
        public void ShowList(PagedGridView gvList, PageInfo pageInfo)
        {
            IDictionary<string, object> para = GetFilterParameters();
            para.SafeAdd("Tester", new Condition("Tester!='-1'"));
            para.SafeAdd("Scorer", User.ID);


            

            if (Request.QueryString["Entry"].EqualIgnoreCase("Score"))
            {
                para.SafeAdd("Status",new Condition(string.Format("t1.Status={0}",(int)ExpertStatus.InTest)));
                //if (Request.QueryString["SurveyID"].ToSafeString()!="")
                //{
                //    para.SafeAdd("ParentID", new Condition(string.Format("t3.ParentID='{0}')", Request.QueryString["SurveyID"].ToSafeString())));
                //}
            }

            if (Request.QueryString["Entry"].EqualIgnoreCase("finished"))
            {
                para.SafeAdd("Status", new Condition(string.Format("t1.Status={0}", (int)ExpertStatus.Finished)));
               // para.SafeAdd("t1.Status", (int)ExpertStatus.Finished);
            }


           // IPageOfList<Survey> result = expertService.GetSurveyExpertScore(para, pageInfo);
          DataTable  result = expertService.GetSurveyExpertScore(para, pageInfo);
           // gvList.ItemCount = result.PageInfo.ItemCount;
            gvList.DataSource = result;
            gvList.DataBind();
        }

        public string GetStatus(string status)
        {
            if (Request.QueryString["Entry"].EqualIgnoreCase("Score"))
                status = ((int)ExpertStatus.InTest).ToSafeString();
            else if (Request.QueryString["Entry"].EqualIgnoreCase("finished"))
                status = ((int)ExpertStatus.Finished).ToSafeString();
            else
                return RemarkAttribute.GetEnumRemark((ExpertStatus)Enum.Parse(typeof(ExpertStatus), status));
            return RemarkAttribute.GetEnumRemark((ExpertStatus)Enum.Parse(typeof(ExpertStatus), status));
        }


        public string GetCatDDl()
        {
            StringBuilder sb = new StringBuilder("<select onchange='onCatSelect(this)'><option  value='-1'>请选择</option>");

            IList<KeyValuePair<string, string>> values = SubjectCategory.FullTest.GetRemarks();
            IList<ComboxItem> items = values.Select(v => new ComboxItem() { Tag = "combox", Text = v.Value, Value = v.Key }).ToList();

            foreach (ComboxItem item in items)
            {
                sb.Append(string.Format("<option value='{0}'", item.Value));
                sb.Append(string.Format(">{0}</option>", item.Text));
            }

            sb.Append("</select>");

            return sb.ToSafeString();

        }


        public string Save(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                Survey survey = JsonConvert.DeserializeObject<Survey>(argument);
                if (string.IsNullOrEmpty(survey.ID))
                {
                    survey.ID = IdGenerator.NewComb().ToString();
                    survey.CreateTime = DateTime.Now;
                    survey.Creator = User.ID;
                    survey.OwnerOrg = User.OrgPath;
                    surveyService.SaveOrUpdate(survey);
                }
                else
                {
                    surveyService.Update(survey);
                }

                actionResult = ActionResult.Success;

                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                //记录操作日志
                AddActionLog(survey, PageContext.Action, actionResult, actionMessage);

                ajaxResult.ActionResult = actionResult;
                ajaxResult.RetValue = survey.ID;
                ajaxResult.PromptMsg = actionMessage;

            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }


        public string Delete(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                if (!string.IsNullOrWhiteSpace(argument))
                {
                    Survey survey = surveyService.GetDomain(argument);
                    if (survey != null)
                    {
                        survey.Status = 3;
                        surveyService.Update(survey);
                    }
                    actionResult = ActionResult.Success;

                    //获取提示信息
                    actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                    //记录操作日志
                    AddActionLog(survey, PageContext.Action, actionResult, actionMessage);

                    ajaxResult.ActionResult = actionResult;
                    ajaxResult.RetValue = survey.ID;
                    ajaxResult.PromptMsg = actionMessage;
                }
            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }

        public string GetExamName(string examPaperID)
        {
            ExamPaper examPaper = new ExamPaperService().GetDomain(examPaperID);
            string examPaperName = examPaper != null ? examPaper.Title : "";
            return examPaperName;
        }

        #endregion
    }
}
