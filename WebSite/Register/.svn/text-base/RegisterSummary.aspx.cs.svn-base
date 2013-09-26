using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Newtonsoft.Json;

using EAFrame.Core;
using EAFrame.WebControls;
using SunTek.LAMS.Domain;
using SunTek.LAMS.Service;
using SunTek.Register.Domain;
using SunTek.Register.Service;

using System.Xml.Linq;
using EAFrame.Core.Web;
using EAFrame.Core.Enums;
using EAFrame.Core.Extensions;
using EAFrame.Core.Utility;

namespace WebSite.Register
{
    public partial class RegisterSummary : BasePage
    {
        private RegisterService registerService = new RegisterService();

        #region ---界面处理方法---
        /// <summary>
        /// 初始化页面
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                drpYear.SelectedValue = DateTime.Now.Year.ToString();
                drpMonth.SelectedValue = DateTime.Now.Month.ToString();
                ShowList();
            }
        }

      

        #endregion

        /// <summary>
        /// 显示列表信息
        /// </summary>
        /// <param name="gvList">GridView对象</param>
        /// <param name="pageInfo">分页信息</param>
        public void ShowList()
        {
            var yearMonth=drpYear.SelectedValue+drpMonth.SelectedValue;

            IList<SunTek.Register.Domain.RegisterSummary> registerSummarys = registerService.GetRegisterSummary(yearMonth);
            gvList.DataSource = registerSummarys;
            gvList.DataBind();
        }

        protected void gvList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            string yearMonth = drpYear.SelectedValue + drpMonth.SelectedValue;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //重新绑定单选按钮
                SunTek.Register.Domain.RegisterSummary entity=((List<SunTek.Register.Domain.RegisterSummary>)gvList.DataSource)[e.Row.RowIndex];
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                
                foreach(int value in Enum.GetValues(typeof(ManagerType)))
                {
                    string url = string.Empty;
                    string hint = string.Empty;
                    string css = string.Empty;
                    switch(entity.IsSummitDetail[value])
                    {
                        case SunTek.Register.Domain.RegisterStatus.UnSummit:
                 
                            break;
                        case SunTek.Register.Domain.RegisterStatus.Unaudited:
                            url = "#";
                            hint = "未确认";
                            css = "color:Red";
                            break;
                        case SunTek.Register.Domain.RegisterStatus.Confirmed:
                            url = string.Format(@"ImportRegister.aspx?Entry={0}&rtnFlag=1&corpID={1}&yearMonth={2}", value, entity.CorpID, yearMonth);
                            hint = "已确认";
                            css = "";
                            break;
                        case SunTek.Register.Domain.RegisterStatus.Summary:
                            url = string.Format(@"ImportRegister.aspx?Entry={0}&rtnFlag=1&corpID={1}&yearMonth={2}", value, entity.CorpID, yearMonth);
                            css = "color:Gray";
                            hint = "已汇总";
                            break;
                        case SunTek.Register.Domain.RegisterStatus.HistoryState:
                            url = string.Format(@"ImportRegister.aspx?Entry={0}&rtnFlag=1&corpID={1}&yearMonth={2}", value, entity.CorpID, yearMonth);
                            hint = "历史";
                            css = "color:Gray";
                            break;
                    }
                    if (entity.IsSummitDetail[value] != SunTek.Register.Domain.RegisterStatus.UnSummit)
                    {
                        sb.Append(string.Format(@"<a href='{0}' style='{1}' title='{2}'>&nbsp{3}&nbsp </a>", url, css, hint, RemarkAttribute.GetEnumRemark((ManagerType)value)));
                        sb.Append("|");
                    }
                }
                if (sb.ToString() != string.Empty) sb.Remove(sb.Length - 2, 1);
                e.Row.Cells[5].Text = sb.ToString();
            }
        }

        #region 按钮相关操作

        /// <summary>
        /// 名册汇总
        /// </summary>
        /// <param name="argument"></param>
        /// <returns></returns>
        public string Gather(string ajaxArgument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            string yearMonth = ajaxArgument;  //所属年月
            try
            {
                if (!registerService.IsSummary(yearMonth))
                {
                    actionResult = ActionResult.Failed;

                    actionMessage = "汇总失败！请确认所有名册已确认！";

                }
                else
                {
                    registerService.Summary(yearMonth);

                    actionResult = ActionResult.Success;

                    actionMessage = "汇总成功！";

                    AddActionLog(new RegisterInfo(), PageContext.Action, actionResult, actionMessage);//添加操作日志
                }
            }
            catch (Exception ex)
            {
                actionMessage = "汇总失败!";
                log.Error(string.Format("名册汇总失败！【所属年月：{0}】", yearMonth), ex);
            }
            ajaxResult.ActionResult = actionResult;
            ajaxResult.PromptMsg = actionMessage;
            return JsonConvert.SerializeObject(ajaxResult);
        }

        /// <summary>
        /// 把名册回退到待审核状态
        /// </summary>
        /// <param name="ajaxArgument"></param>
        /// <returns></returns>
        public string Rollback(string ajaxArgument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            string yearMonth = ajaxArgument;  //所属年月
            try
            {
                    registerService.Rollback(yearMonth);

                    actionResult = ActionResult.Success;

                    actionMessage = "回退成功！";

                    AddActionLog(new RegisterInfo(), PageContext.Action, actionResult, actionMessage);//添加操作日志
            }
            catch (Exception ex)
            {
                actionMessage = "回退失败!";
                log.Error(string.Format("名册回退失败！【所属年月：{0}】", yearMonth), ex);
            }
            ajaxResult.ActionResult = actionResult;
            ajaxResult.PromptMsg = actionMessage;
            return JsonConvert.SerializeObject(ajaxResult);
        }

        protected void drpMonth_SelectedIndexChanged(Object sender, EventArgs e)
        {
            ShowList();

        }
       
        #endregion
    }
}