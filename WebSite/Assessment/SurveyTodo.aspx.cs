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

namespace WebSite
{
    public partial class SurveyTodo : BasePage
    {
        private SurveyService surveyService = new SurveyService();

        #region ---界面处理方法---

        /// <summary>
        /// 初始化页面
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }
        public override bool Authorize(EAFrame.Core.Authentication.User user, string requestUrl, bool isForce)
        {
            return base.Authorize(user, requestUrl, false);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowList();
            }
        }

        #endregion

        #region ---操作处理方法---
     
        /// <summary>
        /// 显示列表信息
        /// </summary>
        /// <param name="gvList">GridView对象</param>
        /// <param name="pageInfo">分页信息</param>
        public void ShowList()
        {
            IDictionary<string, object> para = GetFilterParameters();
              para.SafeAdd("Status", new Condition(" Status!=3"));
              para.SafeAdd("ID", new Condition(string.Format("ID in (select SurveyID from LA_SurveyResult r where r.Tester='{0}' and r.Status={1}) and Status=1", User.ID,(int)SurveyResultStatus.InTest)));

            IPageOfList<Survey> result = surveyService.FindAll(para, new PageInfo(0, 6, 20));

            if (result.Count() == 0)
            {
                litTips.Visible = true;
            }
            else
            {
                rptList.DataSource = result.OrderBy(o => o.CreateTime);
                rptList.DataBind();
            }

         
            //gvList.ItemCount = result.PageInfo.ItemCount;
            //gvList.DataSource = result.OrderBy(o=>o.CreateTime);
            //gvList.DataBind();
        }

        public string GetStatus(string status)
        {
                status = ((int)SurveyResultStatus.InTest).ToSafeString();
            return RemarkAttribute.GetEnumRemark((SurveyResultStatus)Enum.Parse(typeof(SurveyResultStatus), status));
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
