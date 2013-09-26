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
using System.Text;

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
using EAFrame.Core.Data;

namespace WebSite
{
    public partial class ExpertResult : BasePage
    {
        private SurveyResultService surveyResultService = new SurveyResultService();
        private ExpertService expertService = new ExpertService();
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
            litTable.Text = GetTableHtml(Request.QueryString["SurveyID"].ToSafeString(),false);
        }

        public void Export(string arg)
        {
            Survey survey = new SurveyService().GetDomain(Request.QueryString["SurveyID"].ToSafeString());

            HttpContext.Current.Response.Clear();
            string FileName = string.Format("Mark - {0}",  DateTime.Now.ToString("yyyyMMdd"));
            HttpContext.Current.Response.Charset = "UTF-8"; // 或UTF-7 以防乱码
            HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.Default;
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment;filename=" + "" + FileName + ".xls");

            //HttpContext.Current.Response.Write("\t 姓名 \t 电话  \t 地址 \t 备注 \n \t 姓名 \t 电话  \t 地址 \t 备注 \n \t 姓名 \t 电话  \t 地址 \t 备注 \n \t 姓名 \t 电话  \t 地址 \t 备注 \n \t 姓名 \t 电话  \t 地址 \t 备注 \n ");

            StringBuilder sb = new StringBuilder();

            sb.AppendFormat(GetTableHtml(survey.ID, true));

            HttpContext.Current.Response.Write(sb.ToSafeString());
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.End();
            //try
            //{
            //    HttpContext.Current.Response.End();
            //}
            //catch (Exception ex)
            //{

            //}

        }


        public string GetTableHtml(string surveyID,bool isExport)
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
            StringBuilder html = new StringBuilder();
            StringBuilder headHtml = new StringBuilder();
            StringBuilder ctnHtml = new StringBuilder();


            html.Append("<table cellspacing=\"0\" border=\"1\" style=\"width:100%;border-collapse:collapse;\">");

            IDictionary<string, object> para = new Dictionary<string, object>();

            if (!string.IsNullOrWhiteSpace(CurrentId))
            {
                Survey survey = new SurveyService().GetDomain(surveyID);

                para.SafeAdd("SurveyID", surveyID);
                IList<SurveyResult> surveyResults = surveyResultService.FindAll(para).ToList();
                para.Clear();
                para.SafeAdd("AssessmentResultID", new EAFrame.Core.Data.Condition(string.Format("(AssessmentResultID in (select ID from LA_SurveyResult where SurveyID='{0}'))", surveyID)));
                IList<AnswerRecord> answerRecords = new AnswerRecordService().FindAll(para).ToList();
                if (answerRecords.Count == 0)
                {
                    WebUtil.PromptMsg("该问卷还没有任何评分人进行打分或还未添加任何评分人！");
                    WebUtil.CloseWidow(true);
                    return "";
                }


                List<Subject> subjects = new ExamPaperService().GetSubjectByExamPaper(survey.ExamPaperID);  //获取问卷题目





                //获取专家列表
                DataTable dtExperts = expertService.GetSurveyExpert(survey.ID);

                para.Clear();
                para.SafeAdd("Tester", new Condition("a.Tester!='-1'"));
                para.SafeAdd("SurveyID", new Condition(string.Format("a.SurveyID='{0}'", survey.ID)));
                DataTable dtExpertStatus = expertService.GetSurveyExpert(para, null);

                //制作表头
                headHtml.AppendFormat("<tr class='th'><td rowspan=2>员工编号</td><td rowspan=2>姓名</td><td rowspan=2>题目</td>");

                StringBuilder subHeadHtml = new StringBuilder("");

                foreach (DataRow dr in dtExperts.Rows)
                {
                    headHtml.AppendFormat("<td rowspan=2 colspan='2'>{0}</td>", dr["Name"]);
                }
                headHtml.Append("</tr>");
                headHtml.AppendFormat("<tr class='th'>{0}</tr>", subHeadHtml.ToSafeString());

                foreach (SurveyResult surveyResult in surveyResults)
                {
                    //获取专家评分结果列表
                    para.Clear();
                    para.SafeAdd("AssessmentResultID", new Condition(string.Format("AssessmentResultID in (select id from LA_Expert where SurveyID='{0}' and  Tester='{1}') ", surveyID, surveyResult.Tester)));
                    IList<MarkItem> markItems = new MarkItemService().FindAll(para).ToList();

                    ctnHtml.Append("<tr>");
                    Employee employee = new EmployeeService().GetDomain(surveyResult.Tester);

                    ctnHtml.AppendFormat("<td rowspan='{2}'>{0}</td><td rowspan='{2}'>{1}</td>", employee.Code, employee.Name, subjects.Count);

                    //取得所有相关的题目，循环遍历
                    if (subjects != null && subjects.Count > 0)
                    {

                        for (int i = 0; i < subjects.Count; i++)
                        {
                            if (i > 0)
                                ctnHtml.AppendFormat("<tr>");
                            ctnHtml.AppendFormat("<td>{0}</td>", i + 1);

                            int j = 0;
                            if (subjects[i].SubjectType == (int)SubjectType.TextArea)
                            {
                                //显示专家的评分结果
                                foreach (DataRow dr in dtExpertStatus.Rows)
                                {
                                    if (dr["Tester"].ToSafeString() == surveyResult.Tester)
                                    {
                                        j++;
                                        string statusStr = string.Empty;

                                        MarkItem markItem = markItems.FirstOrDefault(o => o.Scorer.EqualIgnoreCase(dr["Scorer"].ToSafeString()) && o.SubjectID.EqualIgnoreCase(subjects[i].ID));
                                        if (markItem == null)
                                        {
                                            ctnHtml.AppendFormat("<td>{0}</td><td>{0}</td>", "");
                                        }
                                        else
                                        {
                                            
                                            ctnHtml.AppendFormat("<td>{0}</td>", markItem.Score);

                                            if (!isExport && markItem.Comment != null && markItem.Comment.Length > 15)
                                            {
                                                ctnHtml.AppendFormat("<td >{0}...</td>",markItem.Comment.Substring(0, 15));
                                            }
                                            else
                                            {
                                                ctnHtml.AppendFormat("<td >{0}</td>", markItem.Comment);
                                            }

                                        }
                                    }

                                }
                                ctnHtml.AppendFormat("</tr>");
                            }
                            else
                            {
                                ctnHtml.AppendFormat("<td colspan='{0}'> </td></tr>", j*2);
                            }

                            //  ctnHtml.AppendFormat("</tr><tr>");

                        }
                    }


                    //<td></td>





                    ctnHtml.Append("</tr>");

                }


                html.AppendFormat("{0}{1}</table>", headHtml, ctnHtml);
               

            }
            return html.ToSafeString();
        }

        

        
        #endregion
    }
}
