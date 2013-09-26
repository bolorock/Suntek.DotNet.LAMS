using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;

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
using EAFrame.Core.Data;

namespace WebSite
{
    public class ExamPaperHelper
    {
        private SubjectItemService subjectItemService = new SubjectItemService();
        private IList<AnswerRecord> _answerRecords=new List<AnswerRecord>();
        private IList<MarkItem> _markItems = new List<MarkItem>();

        public string GenerateExamPaper(string examPaperID)
        {
            return GenerateExamPaper(examPaperID, null);
        }


        public string GenerateExamPaper(string examPaperID, IList<AnswerRecord> answerRecords, bool isShowExpert,IList<MarkItem> markItems)
        {
            _answerRecords = answerRecords;
            _markItems = markItems;
            StringBuilder html = new StringBuilder();

            //获取小题的集合
            List<Subject> subjects = new ExamPaperService().GetSubjectByExamPaper(examPaperID);

            //获取大题的集合
            IDictionary<string, object> para = new Dictionary<string, object>();
            para.SafeAdd("ExamPaperID", examPaperID);
            IList<MainSubject> mainSubjects = new MainSubjectService().FindAll(para).ToList<MainSubject>();


            int i = 1;

            if (mainSubjects == null || subjects == null)
                return string.Empty;



            foreach (MainSubject mainSubject in mainSubjects)
            {
                //过滤剩下大题下边的小题
                List<Subject> subjectsByMainSubject = subjects.Where(o => o.MainSubjectID.EqualIgnoreCase(mainSubject.ID)).ToList();

                //生成大题的信息
                html.Append(HeadHtmlMain(mainSubject, subjectsByMainSubject.Count));

                //循环生成小题
                foreach (Subject subject in subjectsByMainSubject)
                {
                    html.Append(HeadHtml(subject, i++));


                    switch (subject.SubjectType.ToSafeString().Cast<SubjectType>())
                    {
                        case SubjectType.Radio:
                            html.Append(RadioHtml(subject));
                            break;
                        case SubjectType.CheckBox:
                            html.Append(CheckBoxHtml(subject));
                            break;
                        case SubjectType.TextArea:
                            html.Append(TextAreaHtml(subject));
                            break;
                        case SubjectType.TextBox:
                            html.Append(TextBoxHtml(subject));
                            break;
                        case SubjectType.Table:
                            html.Append(TableHtml(subject));
                            break;
                        case SubjectType.TableBoth:
                            html.Append(TableBothHtml(subject));
                            break;
                        case SubjectType.TableDim:
                            html.Append(TableDimHtml(subject));
                            break;

                    }
                    if (isShowExpert && subject.SubjectType == (int)SubjectType.TextArea)
                    {

                        html.Append(CommentHtml(subject));
                    }
                    html.Append("</div></div>");

                }
                html.Append("</div>");
            }

            return html.ToString();
        }


        public string CommentHtml(Subject subject)
        {
            StringBuilder html = new StringBuilder();
            
            MarkItem markItem = GetScoreBySubject(subject.ID);
            string score= markItem==null?"":markItem.Score.ToSafeString();
            string comment= markItem==null?"":markItem.Comment.ToSafeString();
            html.AppendFormat("<div class='comment'><table width=100%><tr><td width='60px'>分数：</td><td><input type=\"text\" id='score_{0}' subjectID='{0}' value='{1}' /></td></tr>", subject.ID, score);
            html.AppendFormat("<tr><td>点评：</td><td><textarea  id='comment_{0}'  subjectID='{0}'  style=\"width: 90%; \" rows='4'>{1}</textarea></td></tr></table></div>", subject.ID, comment);

            return html.ToString();
        }

        public string TipsHtml(Expert expert)
        {
            Dictionary<string, object> para = new Dictionary<string, object>();
            para.SafeAdd("Tester", new Condition("Tester!='-1'"));
            para.SafeAdd("Scorer", expert.Scorer);
            para.SafeAdd("SurveyID", expert.SurveyID);

            //获取要被评分的人
            DataTable dt = new ExpertService().GetSurveyExpertScore(para, new PageInfo());
            Survey survey = new SurveyService().GetDomain(expert.SurveyID);
            StringBuilder html = new StringBuilder();
            html.Append("<table  style=\"width: 90%; display: inline-table;\" border=1>");
            if (survey != null)
            {
                html.AppendFormat("<tr><td width='200px'>当前测评活动：</td><td>{0}</td></tr>", survey.Title);
               
            }
            StringBuilder testerList = new StringBuilder();
            foreach (DataRow dr in dt.Rows)
            {
                testerList.AppendFormat("{0},", dr["Name"]);
            }
            html.AppendFormat("<tr><td>测评活动相关被评对象：</td><td>{0}</td></tr>",testerList.ToSafeString().Trim(','));
            Employee employee=new EmployeeService().GetDomain(expert.Tester);
            html.AppendFormat("<tr><td>当前评分对象：</td><td>{0}</td></tr>", employee.Name);
            html.Append("</table>");
            return html.ToString();

        }

        public string GenerateExamPaper(string examPaperID,IList<AnswerRecord> answerRecords)
        {
            _answerRecords = answerRecords;
            StringBuilder html = new StringBuilder();
            
            //获取小题的集合
            List<Subject> subjects = new ExamPaperService().GetSubjectByExamPaper(examPaperID);

            //获取大题的集合
            IDictionary<string, object> para = new Dictionary<string, object>();
            para.SafeAdd("ExamPaperID", examPaperID);
            IList<MainSubject> mainSubjects = new MainSubjectService().FindAll(para).ToList<MainSubject>();


            int i = 1;

            if (mainSubjects==null || subjects == null)
                return string.Empty;



            foreach (MainSubject mainSubject in mainSubjects)
            {
                //过滤剩下大题下边的小题
                List<Subject> subjectsByMainSubject = subjects.Where(o => o.MainSubjectID.EqualIgnoreCase(mainSubject.ID)).ToList();

                //生成大题的信息
                html.Append(HeadHtmlMain(mainSubject, subjectsByMainSubject.Count));

                //循环生成小题
                foreach (Subject subject in subjectsByMainSubject)
                {
                    html.Append(HeadHtml(subject, i++));


                    switch (subject.SubjectType.ToSafeString().Cast<SubjectType>())
                    {
                        case SubjectType.Radio:
                            html.Append(RadioHtml(subject));
                            break;
                        case SubjectType.CheckBox:
                            html.Append(CheckBoxHtml(subject));
                            break;
                        case SubjectType.TextArea:
                            html.Append(TextAreaHtml(subject));
                            break;
                        case SubjectType.TextBox:
                            html.Append(TextBoxHtml(subject));
                            break;
                        case SubjectType.Table:
                            html.Append(TableHtml(subject));
                            break;
                        case SubjectType.TableBoth:
                        html.Append(TableBothHtml(subject));
                            break;
                        case SubjectType.TableDim:
                            html.Append(TableDimHtml(subject));
                            break;
                            
                    }
                    html.Append("</div></div>");

                }
                html.Append("</div>");
            }
            
            return html.ToString();

        }


        public string HeadHtmlMain(MainSubject mainSubject, int subjectCount)
        {
            StringBuilder html = new StringBuilder();
            html.AppendFormat("<div class=\"Maintitle\">{0} &nbsp;&nbsp;&nbsp;<span>(共{1}小题，{2}分)</span></div><div class=\"MainCtn\">",  mainSubject.Title, subjectCount, mainSubject.Score);
            return html.ToString();
        }

        public string HeadHtml(Subject subject,int i)
        {
            StringBuilder html = new StringBuilder();
            html.AppendFormat("<div class=\"subject\"><input type=\"hidden\" name=\"data_{0}\" id=\"data_{1}\" value='{2}' />", subject.ID, subject.ID, GetAnswerBySubject(subject.ID));
            html.AppendFormat("<div class=\"title\">{0}. {1}:</div>",i.ToString(), subject.SubjectTitle);
            html.AppendFormat("<div class=\"item\">");

            return html.ToString();
        }



        public string RadioHtml(Subject subject)
        {
            string answer = GetAnswerBySubject(subject.ID);
           
            StringBuilder html = new StringBuilder();
            List<SubjectItem> subjectItems = subjectItemService.All().Where(o => o.SubjectID.Equals(subject.ID, StringComparison.OrdinalIgnoreCase)).OrderBy(p=>p.SortOrder).ToList();
            foreach (SubjectItem item in subjectItems)
            {
                string selectedStr=string.Empty;
                if (item.SortOrder.ToANSIChar().EqualIgnoreCase(answer))
                    selectedStr="checked='checked'";
                
                html.AppendFormat("<input type=\"radio\" value=\"{0}\" name=\"name_{2}\" {3} onclick=\"radioChooseItem(this)\"/>{1}<br>", item.SortOrder.ToANSIChar(), string.Format(" {0}.{1}", item.SortOrder.ToANSIChar(), item.ItemTitle), subject.ID, selectedStr);
            }
            return html.ToString();
        }

        public string CheckBoxHtml(Subject subject)
        {
            StringBuilder html = new StringBuilder();
            List<SubjectItem> subjectItems = subjectItemService.All().Where(o => o.SubjectID.Equals(subject.ID, StringComparison.OrdinalIgnoreCase)).OrderBy(p => p.SortOrder).ToList();
            string answer = GetAnswerBySubject(subject.ID);
            foreach (SubjectItem item in subjectItems)
            {
                string selectedStr = string.Empty;
                IList<string> values = answer.Split(',').Select(p => p).ToList();
                if (values.Where(p1=>p1.EqualIgnoreCase(item.SortOrder.ToANSIChar())).ToList().Count>0)
                    selectedStr = "checked='checked'";
                html.AppendFormat("<input type=\"checkbox\" value=\"{0}\" {2} onclick=\"comboxChooseItem(this)\"/>{1}<br>", item.SortOrder.ToANSIChar(), string.Format(" {0}.{1}", item.SortOrder.ToANSIChar(), item.ItemTitle), selectedStr);
            }
            return html.ToString();
        }

        public string TextBoxHtml(Subject subject)
        {
            StringBuilder html = new StringBuilder();
            html.AppendFormat("<input type=\"text\" onblur=\"textItem(this)\" value='{0}' />", GetAnswerBySubject(subject.ID));
            return html.ToString();
        }

        public string TextAreaHtml(Subject subject)
        {
         
            StringBuilder html = new StringBuilder();
            html.AppendFormat("<textarea  onblur=\"textareaItem(this)\"  style=\"width: 90%; \" rows='4'>{0}</textarea>", GetAnswerBySubject(subject.ID));
            return html.ToString();
        }

        public string TableHtml(Subject subject)
        {

            StringBuilder html = new StringBuilder();
            StringBuilder itemHtml = new StringBuilder();
            html.AppendFormat("<table  style=\"width: 90%; display: inline-table;\" border=1><thead><tr>");
            html.AppendFormat("<th>问题</th>");

            List<SubjectItem> subjectItems = subjectItemService.All().Where(o => o.SubjectID.Equals(subject.ID, StringComparison.OrdinalIgnoreCase)).OrderBy(p => p.SortOrder).ToList();

            foreach (SubjectItem item in subjectItems)
            {
                html.AppendFormat("<th>{0}</th>", string.Format(" {0}.{1}", item.SortOrder.ToANSIChar(), item.ItemTitle));
              //  itemHtml.AppendFormat("<td align='center'><input type=\"radio\" value=\"{0}\" temp_Checked_{1}=\"\" name=\"name_name_temp\"   onclick=\"radioChooseItem(this)\"/></td>", item.SortOrder.ToANSIChar(), item.SortOrder.ToANSIChar());

                itemHtml.AppendFormat("<td align='center'><input type=\"radio\" value=\"{0}\" name=\"name_name_temp\"   onclick=\"radioChooseItem(this)\"/></td>", item.SortOrder.ToANSIChar());
            }

            html.AppendFormat("</tr> </thead>");

            List<Subject> subjects = new SubjectService().All().Where(o => o.ParentID.Equals(subject.ID, StringComparison.OrdinalIgnoreCase)).OrderBy(p => p.SortOrder).ToList();

           
            foreach (Subject item in subjects)
            {
                string answer = GetAnswerBySubject(item.ID);
                // "checked='checked'";

                html.AppendFormat("<tr><td><input type=\"hidden\" value=\"{2}\" name=\"data_{0}\" id=\"data_{0}\" />{1}</td>", item.ID, item.SubjectTitle, answer);


                foreach (SubjectItem item2 in subjectItems)
                {
                    string itemHtmlTempCheck = answer.IndexOf(item2.SortOrder.ToANSIChar()) > -1 ? "checked='checked'" : "";
                    html.AppendFormat("<td align='center'><input type=\"radio\" value=\"{0}\" name=\"name_{1}\" {2}  onclick=\"radioChooseItem(this)\"/></td>", item2.SortOrder.ToANSIChar(), item.ID, itemHtmlTempCheck);
                }

                html.AppendFormat("</tr>");

            }

            html.AppendFormat("</table>");

            return html.ToString();
        }

        public string TableBothHtml(Subject subject)
        {

            StringBuilder html = new StringBuilder();
            StringBuilder itemHtml = new StringBuilder();
            html.AppendFormat("<table  style=\"width: 90%; display: inline-table;\" border=1><thead><tr>");
            html.AppendFormat("<th></th><th></th>");

            List<SubjectItem> subjectItems = subjectItemService.All().Where(o => o.SubjectID.Equals(subject.ID, StringComparison.OrdinalIgnoreCase)).OrderBy(p => p.SortOrder).ToList();

            foreach (SubjectItem item in subjectItems)
            {
                html.AppendFormat("<th>{0}</th>", string.Format("{0}",item.ItemTitle));
                itemHtml.AppendFormat("<td align='center'>temp_text_{0}<input type=\"radio\" value=\"temp_text_{0}\" temp_Checked_{1}=\"\" name=\"temp_name_{0}\"   onclick=\"TableBothChooseItem(this)\"/></td>", item.SortOrder.ToSafeString(), item.SortOrder.ToANSIChar());
            }
            html.AppendFormat("</tr> </thead>");

            //取得相关的大题
            List<Subject> mainSubjects = new SubjectService().All().Where(o => o.ParentID.Equals(subject.ID, StringComparison.OrdinalIgnoreCase)).OrderBy(p => p.SortOrder).ToList();
            foreach (Subject mainSubject in mainSubjects)
            {
                string answer = GetAnswerBySubject(mainSubject.ID);
                List<Subject> subjects = new SubjectService().All().Where(o => o.ParentID.Equals(mainSubject.ID, StringComparison.OrdinalIgnoreCase)).OrderBy(p => p.SortOrder).ToList();
                int itemCount = subjects.Count;

                html.AppendFormat("<tr><td rowspan='{3}'><input type=\"hidden\" value=\"{2}\" name=\"data_{0}\" id=\"data_{0}\" />第{1}题</td>", mainSubject.ID,  mainSubject.SortOrder, answer, itemCount);

                int rowIndex = 0;
                foreach (Subject item in subjects)
                {
                    html.AppendFormat("<td>{0}</td>",item.SubjectTitle);
                    int colIndex = 0;

                    foreach (SubjectItem chooseItem in subjectItems)
                    {
                        string itemHtmlTemp = answer.IndexOf((rowIndex + colIndex * itemCount+1).ToANSIChar()) > -1 ? "checked='checked'" : "";
                        html.AppendFormat("<td align='center'>{0} <input type=\"radio\" value=\"{0}\"  name=\"name_{3}_{1}\" position='{4}' onclick=\"TableBothChooseItem(this)\" {2}/></td>", (rowIndex + colIndex * itemCount+1).ToANSIChar(), colIndex, itemHtmlTemp, mainSubject.ID, rowIndex);
                        colIndex++;
                    }
                     html.AppendFormat("</tr>");
                     rowIndex++;

                }

            }

            html.AppendFormat("</table>");

            return html.ToString();

        }



        public string TableDimHtml(Subject subject)
        {

            StringBuilder html = new StringBuilder();
            StringBuilder itemHtml = new StringBuilder();
            html.AppendFormat("<table  style=\"width: 90%; display: inline-table;\" border=1><thead><tr>");
            html.AppendFormat("<th>问题</th>");

            List<SubjectItem> subjectItems = subjectItemService.All().Where(o => o.SubjectID.Equals(subject.ID, StringComparison.OrdinalIgnoreCase) && o.Dim==0).OrderBy(p => p.SortOrder).ToList();

            List<SubjectItem> subjectItems_dim1 = subjectItemService.All().Where(o => o.SubjectID.Equals(subject.ID, StringComparison.OrdinalIgnoreCase) && o.Dim == 1).OrderBy(p => p.SortOrder).ToList();

            foreach (SubjectItem item_dim1 in subjectItems_dim1)
            {
                html.AppendFormat("<th>{0}</th>", string.Format("{1}", item_dim1.SortOrder.ToANSIChar(), item_dim1.ItemTitle));

                itemHtml.AppendFormat("<td align='center'>");

                foreach (SubjectItem item in subjectItems)
                {
                    itemHtml.AppendFormat("{0}<input type=\"radio\" value=\"{0}\" temp_Checked_{1}=\"\" name=\"temp_name_{2}\"   onclick=\"TableDimChooseItem(this)\"/> ", item.SortOrder.ToANSIChar(), item.SortOrder.ToANSIChar(), item_dim1.ID);
                }
                itemHtml.AppendFormat("</td>");
            }
           

            html.AppendFormat("</tr> </thead>");

            List<Subject> subjects = new SubjectService().All().Where(o => o.ParentID.Equals(subject.ID, StringComparison.OrdinalIgnoreCase)).OrderBy(p => p.SortOrder).ToList();


            foreach (Subject item in subjects)
            {
                string answer = GetAnswerBySubject(item.ID);
               
                //string isCheck= string.IsNullOrEmpty(answer)?"": "checked='checked'";
                string itemHtmlTemp = itemHtml.ToSafeString().Replace("temp_name_", string.Format("name_{0}_", item.ID));

                if (!string.IsNullOrEmpty(answer))
                {
                   List<string> arrAnswers= answer.Split(',').ToList();
                   foreach (string answerItem in arrAnswers)
                   {
                       itemHtmlTemp = itemHtmlTemp.Replace("temp_Checked_" + answerItem, "checked='checked'");
                   }
                }

                html.AppendFormat("<tr><td><input type=\"hidden\" value=\"{4}\" name=\"data_{0}\" id=\"data_{0}\" />{1}.{2}</td>{3}</tr>", item.ID, item.SortOrder, item.SubjectTitle, itemHtmlTemp, answer);

            }

            html.AppendFormat("</table>");

            return html.ToString();
        }



        public string GetAnswerBySubject(string subjectId)
        {
            string answer = string.Empty;
            if (_answerRecords != null && _answerRecords.Count > 0)
            {
                IList<AnswerRecord> value = _answerRecords.Where(o => o.SubjectID.EqualIgnoreCase(subjectId)).ToList();
                if (value.Count > 0)
                    answer = value[0].Anwser;
            }
            return answer;
        }

        public MarkItem GetScoreBySubject(string subjectId)
        {
            MarkItem markItem =null;
            if (_markItems != null && _markItems.Count > 0)
            {
                IList<MarkItem> value = _markItems.Where(o => o.SubjectID.EqualIgnoreCase(subjectId)).ToList();
                if (value.Count > 0)
                    markItem = value[0];
            }
            return markItem;
        }

        //处理分值
        //public List<AnswerRecord> DealScore(List<AnswerRecord> answerRecords, string examPaperID)
        //{
        //    //取出来所有题目的分数
        //    List<Subject> subjects = new ExamPaperService().GetSubjectByExamPaper(examPaperID);

        //    //循环生成小题
        //    foreach (Subject subject in subjects)
        //    {

        //        switch (subject.SubjectType.ToSafeString().Cast<SubjectType>())
        //        {
        //            case SubjectType.Radio:
        //                RadioScore(subject, answerRecords);
        //                break;
        //            case SubjectType.CheckBox:
        //                CheckBoxScore(subject);
        //                break;
        //            case SubjectType.TextArea:
        //                break;
        //            case SubjectType.TextBox:
        //                break;
        //            case SubjectType.Table:
        //                TableScore(subject);
        //                break;
        //        }

        //    }


        //    //计算相应选项值比例

        //    //

        //    return answerRecords;
        //}

        //public int RadioScore(Subject subject, List<AnswerRecord> answerRecords)
        //{
        //    int score = 0;
        //    List<SubjectItem> subjectItems = subjectItemService.All().Where(o => o.SubjectID.Equals(subject.ID, StringComparison.OrdinalIgnoreCase)).OrderBy(p => p.SortOrder).ToList();
        //    int scoreSum = 0;
        //    foreach (SubjectItem item in subjectItems)
        //    {
        //        scoreSum += item.ItemScore;
        //    }
        //    string answer = GetAnswerBySubject(subject.ID);
        //    foreach (SubjectItem item in subjectItems)
        //    {
        //        string selectedStr = string.Empty;
        //        if (item.SortOrder.ToANSIChar().EqualIgnoreCase(answer))
        //            score=item.ItemScore/scoreSum)*subject.

        //    }

        //}

    }
}