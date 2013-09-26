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

namespace WebSite
{
    public partial class ExpertScore : BasePage
    {
        private ExamPaperService examPaperService = new ExamPaperService();
        private SubjectService subjectService = new SubjectService();
        private ExpertService expertService = new ExpertService();
        private MarkItemService markItemService = new MarkItemService();
        private SubjectItemService subjectItemService = new SubjectItemService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !IsAjaxPost)
            {
              
                
                ShowPageDetail();
            }
        }

        protected bool ShowPageDetail()
        {
        
            Literal lit = new Literal();
            Expert expert = expertService.GetDomain(CurrentId);

            string surveyID = expert.SurveyID;
            Survey survey = new SurveyService().GetDomain(surveyID);
            ExamPaper examPaper = examPaperService.GetDomain(survey.ExamPaperID);


            if (expert.Status == (short)ExpertStatus.Finished)
            {
                //if (expert.IsLock == 1)
                //{
                //    WebUtil.PromptMsg("状态不正常");
                //    return false;
                //}
            }

            //基本信息
            if (examPaper != null)
            {
                exapPaperTitle.InnerText = examPaper.Title;
                Literal litInfo = new Literal();
                litInfo.Text = examPaper.Description;
                phdExamPaper.Controls.Add(litInfo);

                IList<string> subjectIDs = examPaperService.GetDataSubjects(survey.ExamPaperID);
                subjectCount.InnerText = subjectIDs.Count.ToSafeString();

            }





            IDictionary<string, object> para = new Dictionary<string, object>();
            para.SafeAdd("SurveyID", surveyID);
            para.SafeAdd("Tester", expert.Tester);
            IList<AnswerRecord> answerRecords = new AnswerRecordService().GetAnswerRecords(para);
            para.Clear();
            para.SafeAdd("AssessmentResultID", expert.ID);
            IList<MarkItem> markItems = markItemService.FindAll(para);

            litTips.Text = new ExamPaperHelper().TipsHtml(expert);

            lit.Text = new ExamPaperHelper().GenerateExamPaper(survey.ExamPaperID, answerRecords, true, markItems);
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
                List<MarkItem> markItems = JsonConvert.DeserializeObject<List<MarkItem>>(answerRecordStr);




                //判断是否已经提交
                Expert expert = expertService.GetDomain(CurrentId);
                if (expert == null)
                {
                    ajaxResult.PromptMsg = "数据出错";
                    return JsonConvert.SerializeObject(ajaxResult);
                }
                if (expert.Status == (int)ExpertStatus.Finished)
                {
                    ajaxResult.PromptMsg = "您已经完成了评分，无法再进行提交！";
                    return JsonConvert.SerializeObject(ajaxResult);
                }



                foreach (MarkItem p in markItems)
                {
                    p.AssessmentResultID = expert.ID;
                    p.Scorer = expert.Scorer;
                    p.ScoreTime = DateTime.Now;
                }

                markItemService.SaveMarkItems(markItems); //保存答题
                Survey survey = new SurveyService().GetDomain(expert.SurveyID);
                //进行提交处理
                if (Request.Form["SubmiteOK"] != null && Request.Form["SubmiteOK"].EqualIgnoreCase("OK"))
                {

                    expert.Status = (short)ExpertStatus.Finished;
                    expert.IsLock = 1;

                    expertService.SaveOrUpdate(expert);
                    #region 结束待办

                   
                    EIACMessage eIACMessage = new EIACMessage()
                    {
                        AppProcInstID = expert.SurveyID,
                        CreateTime = DateTime.Now,
                        Initiator = User.LoginName,
                        InitiatorName = User.Name,
                        Title = string.Format("专家评分 - {0}", survey.Title),
                        RequestType = "2"
                    };

                    EIACFinishedItem finishedItem = new EIACFinishedItem()
                        {
                            AppWorkQueueID = expert.ID,
                            Executor=User.LoginName,
                            ExecutorName=User.Name, 
                            CurrActivity="评分"
                        };
                        eIACMessage.FinishedItems.Add(finishedItem);

                        EIACClearItem clearItem = new EIACClearItem()
                        {
                            Executor = User.LoginName,
                            WorkQueueID = expert.ID,
                        };
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




                    #endregion
                   
                }
                

                actionResult = ActionResult.Success;
                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                //记录操作日志
                AddActionLog(markItems, PageContext.Action, actionResult, actionMessage);

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