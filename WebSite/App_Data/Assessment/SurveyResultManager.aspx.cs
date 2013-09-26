﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Assessment
 * Module:  SurveyResult
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
using System.Data;
using System.Collections;

using Microsoft.Practices.Unity;
using log4net;
using EAFrame.Core;
using EAFrame.Core.Enums;
using EAFrame.Core.Service;
using EAFrame.Core.Security;
using EAFrame.Core.Utility;
using EAFrame.Core.Extensions;
using EAFrame.Core.Web;
using EAFrame.Core.Caching;
using EAFrame.Core.FastInvoker;
using EAFrame.Core.DataFilter;
using EAFrame.WebControls;
using SunTek.Assessment.Domain;
using SunTek.Assessment.Service;
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;


namespace WebSite
{
    public partial class SurveyResultManager : BasePage
    {
        private SurveyResultService surveyResultService = new SurveyResultService();

        #region ---界面处理方法---

      

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
            //IPageOfList<SurveyResult> result = surveyResultService.FindAll(GetFilterParameters(), pageInfo);
            //IDictionary<string, object> para = new Dictionary<string, object>();

            //if (!string.IsNullOrWhiteSpace(CurrentId))
            //{
            //    para.SafeAdd("SurveyID", CurrentId);
            //}

            //IPageOfList<SurveyResult> result = surveyResultService.FindAll(para, pageInfo);
            //gvList.ItemCount = result.PageInfo.ItemCount;
            //gvList.DataSource = result;
            //gvList.DataBind();

            IDictionary<string, object> para = new Dictionary<string, object>();

            if (!string.IsNullOrWhiteSpace(CurrentId))
            {
                Survey survey = new SurveyService().GetDomain(CurrentId);

                para.SafeAdd("SurveyID", CurrentId);
                IList<SurveyResult> surveyResults = surveyResultService.FindAll(para).ToList();
                para.Clear();
                para.SafeAdd("AssessmentResultID", new EAFrame.Core.Data.Condition(string.Format("(AssessmentResultID in (select ID from LA_SurveyResult where SurveyID='{0}'))", CurrentId)));
                IList<AnswerRecord> answerRecords = new AnswerRecordService().FindAll(para).ToList();

                if (answerRecords.Count == 0)
                {
                    WebUtil.PromptMsg("该问卷还没有添加任何评估人！");
                    return;
                }

                List<Subject> subjects = new ExamPaperService().GetSubjectByExamPaper(survey.ExamPaperID);  //获取问卷题目

                DataTable dt = new DataTable();
                dt.Columns.Add(new DataColumn("员工编号"));
                dt.Columns.Add(new DataColumn("姓名"));

                for (int i = 1; i <= subjects.Count; i++)
                {
                    dt.Columns.Add(new DataColumn(i.ToSafeString()));
                }


                foreach (SurveyResult surveyResult in surveyResults)
                {
                    object[] newrow = new object[2 + subjects.Count];
                    Employee employee = new EmployeeService().GetDomain(surveyResult.Tester);
                    newrow[0] = employee!=null?employee.Code:"";
                    newrow[1] = employee != null ? employee.Name : "";

                    for (int i = 0; i < subjects.Count; i++)
                    {
                        string answerStr = string.Empty;
                        //先取是否有子题目
                        IDictionary<string, object> parameter = new Dictionary<string, object>();
                        parameter.Add("ParentID", subjects[i].ID);
                        List<Subject> subSubjects = new SubjectService().FindAll(parameter).ToList();
                        if (subSubjects.Count > 0)
                        {
                            IList<string> subSubjectIDs = subSubjects.Select(p => p.ID).ToList();
                            IList<AnswerRecord> subAnswebRecords = answerRecords.Where(p => subSubjectIDs.Contains(p.SubjectID)).ToList();
                            foreach (AnswerRecord subAnswerRecord in subAnswebRecords)
                            {
                               answerStr += subAnswerRecord.Anwser + ",";
                            }
                          
                        }
                        else
                        {
                            AnswerRecord answerRecord = answerRecords.Single(o => o.SubjectID.EqualIgnoreCase(subjects[i].ID));
                            answerStr = answerRecord != null ? answerRecord.Anwser : "";
                        }

                        newrow[2 + i] = answerStr.Trim(',');
                    }
                    dt.Rows.Add(newrow);
                }

                GridView1.DataSource = dt;
                GridView1.DataBind();

            }
        }

      

        
        #endregion
    }
}