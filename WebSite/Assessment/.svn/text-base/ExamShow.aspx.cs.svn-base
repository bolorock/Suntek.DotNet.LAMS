using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using System.Text;

using log4net;
using Newtonsoft.Json;
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
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;
using SunTek.Assessment.Domain;
using SunTek.Assessment.Service;

using SunTek.EAFrame.ExternalInterface.Entity;
using SunTek.EAFrame.ExternalInterface.Domain;
using SunTek.EAFrame.ExternalInterface.Service;

using WebSite;
namespace WebSite.Assessment
{
    public partial class ExamShow : BasePage
    {
        private ExamPaperService examPaperService = new ExamPaperService();
        private SubjectService subjectService = new SubjectService();
        private SubjectItemService subjectItemService = new SubjectItemService();
        SurveyResultService surveyResultService = new SurveyResultService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
              
                
                ShowPageDetail();
            }
        }

        protected bool ShowPageDetail()
        {
            Literal lit = new Literal();

            string surveyID = Request.QueryString["SurveyID"];
            Survey survey = new SurveyService().GetDomain(surveyID);
            if (!Request.QueryString["Entry"].EqualIgnoreCase("Preview") &&(string.IsNullOrWhiteSpace(surveyID) || survey == null))
            {
                WebUtil.PromptMsg("参数出错");
                return false;
            }
            ExamPaper examPaper = examPaperService.GetDomain(CurrentId);

            //基本信息
            if (examPaper != null)
            {
                exapPaperTitle.InnerText = examPaper.Title;
                Literal litInfo = new Literal();
                litInfo.Text = examPaper.Description;
                phdExamPaper.Controls.Add(litInfo);

                IList<string> subjectIDs = examPaperService.GetDataSubjects(CurrentId);
                subjectCount.InnerText = subjectIDs.Count.ToSafeString();

            }


            if (Request.QueryString["Entry"].EqualIgnoreCase("Preview"))
            {

                //这里是从试卷列表进来的预览，传入的是试卷id
                lit.Text = new ExamPaperHelper().GenerateExamPaper(CurrentId);
                //remainTime.InnerText = string.Format("{0}小时{1}分0秒", (int)(survey.LimitTime / 60), survey.LimitTime %60);

            }
            else
            {


                //这个是从测评活动进来的测评


                // 验证是否有权限查看试卷
                IDictionary<string, object> para = new Dictionary<string, object>();
                para.SafeAdd("SurveyID", surveyID);
                para.SafeAdd("Tester", User.ID);
                SurveyResult surveyResult = new SurveyResultService().FindOne(para);
                if (surveyResult == null)
                {
                    if (User.UserType != (short)UserType.Administrator)
                        WebUtil.PromptMsg("非法操作");
                    return false;
                }
                else
                {
                    hdfSurveyResultID.Value = surveyResult.ID;

                    if (surveyResult.Status == (short)SurveyResultStatus.InTest)
                    {
                        if (surveyResult.IsLock == 1)
                        {
                            WebUtil.PromptMsg("测评状态不正常");
                            return false;
                        }
                        remainSeconds.Value = surveyResult.RemainTime.ToSafeString();
                    }
                }

                para.Clear();
                para.SafeAdd("SurveyID", surveyID);
                para.SafeAdd("Tester", User.ID);
                IList<AnswerRecord> answerRecords = new AnswerRecordService().GetAnswerRecords(para);
                lit.Text = new ExamPaperHelper().GenerateExamPaper(CurrentId, answerRecords);


                Employee employee = new EmployeeService().GetDomain(survey.SurveyTarget);
                if (employee != null)
                {
                    litTips.Text = string.Format("测评对象：{0}", employee.Name);
                }
            }
            
            phdExamPaper.Controls.Add(lit);

            return true;
        }



        public string Save(string answerRecordStr)
        {
            AjaxResult ajaxResult = new AjaxResult();
            
            AnswerRecordService answerRecordService = new AnswerRecordService();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                List<AnswerRecord> answerRecords = JsonConvert.DeserializeObject<List<AnswerRecord>>(answerRecordStr);
                //判断是否已经提交
                string surveyResultID = Request.Form["SurveyResultID"];
                string remainTime = Request.Form["RemainTime"];

                SurveyResult surveyResult = new SurveyResultService().GetDomain(surveyResultID);
                if (surveyResult == null)
                {
                    actionMessage = "找不到相应的答题人记录";
                    return JsonConvert.SerializeObject(ajaxResult);
                }

                surveyResult.RemainTime = remainTime.ToInt(0) ;
                if (surveyResult.Status == (short)SurveyResultStatus.Finished) //如果已经完成，则提示错误
                {
                    ajaxResult.PromptMsg = "您已经完成了答题，无法再对问卷进行提交！";
                    return JsonConvert.SerializeObject(ajaxResult);
                }

                //为答题记录添加分值


                answerRecordService.SaveAnswerRecords(answerRecords); //保存答题

                //进行提交处理
                if (Request.Form["SubmiteOK"] != null && Request.Form["SubmiteOK"].EqualIgnoreCase("OK"))
                {
                    surveyResult.Status = (short)SurveyResultStatus.Finished;
                    surveyResult.IsLock = 1;
                    surveyResult.RemainTime = 0;
                    surveyResult.EntTime = DateTime.Now;
                    SurveyService surveyService = new SurveyService();
                    Survey childSurvey = surveyService.GetDomain(surveyResult.SurveyID);

                    new SurveyResultService().SaveOrUpdate(surveyResult);

                    log.InfoFormat("开始检测是否要发待办:{0},{1},{2}", new SurveyService().GetNotTesterNum(childSurvey.ParentID, User.ID), childSurvey.ParentID, User.ID);
                    if (new SurveyService().GetNotTesterNum(childSurvey.ParentID, User.ID) == 0)
                    {
                        #region 结束待办
                        log.Info("结束待办条件成立");
                        IDictionary<string, object> para = new Dictionary<string, object>();

                       
                       if (childSurvey != null)
                       {
                           para.SafeAdd("SurveyID", childSurvey.ParentID);
                           para.SafeAdd("Tester", surveyResult.Tester);
                           SurveyResult surveyResultToSend = surveyResultService.FindOne(para);

                       

                        EIACMessage eIACMessage = new EIACMessage()
                        {
                            AppProcInstID = surveyResultToSend.SurveyID,
                            CreateTime = DateTime.Now,
                            Initiator = User.LoginName,
                            InitiatorName = User.Name,
                            Title = string.Format("测评 - {0}", childSurvey.Title),
                              RequestType="2"

                        };

                        EIACFinishedItem finishedItem = new EIACFinishedItem()
                            {
                                AppWorkQueueID = surveyResultToSend.ID,
                                Executor = User.LoginName,
                                ExecutorName = User.Name,
                                CurrActivity = "测评",
                                FinishItemURL=string.Format("{0}Assessment/SurveyManager.aspx?Entry=test", RootPath)
                                  
                            };

                        EIACClearItem clearItem = new EIACClearItem()
                        {
                            Executor = User.LoginName,
                            WorkQueueID = surveyResultToSend.ID,
                        };
                        eIACMessage.FinishedItems.Add(finishedItem);
                        eIACMessage.ClearItems.Add(clearItem);

                        //存进数据库
                        MessagePump message = new MessagePump()
                        {
                            CreateTime = DateTime.Now,
                            ID = IdGenerator.NewGuid().ToSafeString(),
                            MessageContent = eIACMessage.ToXml(),
                            MessageType = (short)SunTek.EAFrame.ExternalInterface.Domain.MessageType.Init,

                        };
                        //

                        bool isSuccess = false;
                        string result = string.Empty;
                        EIAC_OA_XWorkQueue client = new EIAC_OA_XWorkQueue();
                        try
                        {
                            result = client.CreateWorkItems(message.MessageContent);
                        }
                        catch (Exception ex)
                        {

                        }
                        if (result.IndexOf("<ResultCode>0</ResultCode>") > -1)
                        {
                            isSuccess = true;
                        }
                        if (!isSuccess)
                        {
                            new MessagePumpService().SaveOrUpdate(message);
                        }


                       }

                        #endregion
                    }


                }
              

                actionResult = ActionResult.Success;
                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                //记录操作日志
                AddActionLog(answerRecords, PageContext.Action, actionResult, actionMessage);

                ajaxResult.ActionResult = actionResult;
                ajaxResult.RetValue = "";
                ajaxResult.PromptMsg = actionMessage;
            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }


    }
}