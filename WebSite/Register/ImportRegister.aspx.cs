using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;
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
using Suntek.SAPService.BLL;

namespace WebSite.Register
{
    public partial class ImportRegister : BasePage
    {
        private CandidateManagerService candidateManagerService = new CandidateManagerService();
        private RegisterService registerService = new RegisterService();
        private RegisterBaseInfoService registerBaseInfoService = new RegisterBaseInfoService();
        private SAPBll sapBLL = new SAPBll();

        public ManagerType managerType
        {
            get { return (ManagerType)Enum.Parse(typeof(ManagerType), Request.QueryString["Entry"] ?? "0"); }
        }

        public string RegisterType
        {
            get { return RemarkAttribute.GetEnumRemark(managerType); }
        }



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
                this.hfAuth.Value = Request.Cookies[FormsAuthentication.FormsCookieName] == null ?
                string.Empty : Request.Cookies[FormsAuthentication.FormsCookieName].Value;
                this.hfAspSessID.Value = Session.SessionID;

                string yearMonth = Request.QueryString["yearMonth"];
                if (string.IsNullOrEmpty(yearMonth))
                {
                    drpYear.SelectedValue = DateTime.Now.Year.ToString();
                    drpMonth.SelectedValue = DateTime.Now.Month.ToString();
                }
                else
                {
                    drpYear.SelectedValue = yearMonth.Substring(0, 4);
                    drpMonth.SelectedValue = yearMonth.Substring(4, yearMonth.Length - 4);
                }
                //string template = System.IO.Path.Combine(System.IO.Path.Combine(Server.MapPath("~"), "FileTemplate/Register"), "RegisterManager2.template");
                //IDictionary<string, string> dict = getField(template, "RegisterInfo");

                //AddTemplateField(gvList, dict);
                ShowList(gvList, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
            }
        }

        protected void gvList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //重新绑定单选按钮
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<input id='radioId' type='radio' value=" + ((DataTable)gvList.DataSource).Rows[e.Row.RowIndex]["ID"].ToString() + " name='radioId' />");
                e.Row.Cells[0].Text = sb.ToString();
            }
        }



        #endregion

        /// <summary>
        /// 转向明细页面
        /// </summary>
        /// <param name="param"></param>
        protected void Redirect(string param)
        {
            var currentIdParam = PageContext.Action == ActionType.Add ? string.Empty : string.Format("&CurrentId={0}", CurrentId);
            Response.Redirect(string.Format("RegisterDetail.aspx?LastUrl={0}&Runat=1&ActionFlag={1}{2}{3}", Request.Url.PathAndQuery, PageContext.Action, currentIdParam, string.IsNullOrEmpty(param) ? param : "&" + param));
        }

        /// <summary>
        /// 显示列表信息
        /// </summary>
        /// <param name="gvList">GridView对象</param>
        /// <param name="pageInfo">分页信息</param>
        public void ShowList(PagedGridView gvList, PageInfo pageInfo)
        {
            string corpID = Request.QueryString["corpID"] ?? User.CorpID;
            var yearMonth = drpYear.SelectedValue + drpMonth.SelectedValue;

            IDictionary<string, object> parameters = GetFilterParameters();
            //动态列
            gvList.Columns.Clear();
            string template = System.IO.Path.Combine(System.IO.Path.Combine(Server.MapPath("~"), "FileTemplate/Register"), string.Format("{0}.xml", managerType.ToString()));
            IDictionary<string, string> dict = SystemUtil.GetField(template, "RegisterInfo");
            SystemUtil.AddTemplateField(gvList, dict);

            DataTable registers = registerService.GetRegisterByCorpID(parameters, RegisterType, corpID, yearMonth, pageInfo);
            gvList.ItemCount = pageInfo.ItemCount;
            gvList.DataSource = registers;
            gvList.DataBind();
            if (registers!=null)
            {

                hidRegisterStatus.Value = registers.Rows[0]["Status"].ToString();
            }
            else
            {
                hidRegisterStatus.Value = string.Empty;
            }
        }

        /// <summary>
        /// 查询
        /// </summary>
        public void Search()
        {
            ShowList(gvList, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
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
        /// 刷新
        /// </summary>
        public void Refresh()
        {
            ShowList(gvList, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
        }

        protected void cmdRefresh_Click(object sender, EventArgs e)
        {
            Refresh();
        }

        #region 按钮相关操作
        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="argument"></param>
        /// <returns></returns>
        public void Delete()
        {
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                RegisterInfo registerInfo = registerService.GetDomain(CurrentId);
                registerService.Delete(registerInfo);
                actionResult = ActionResult.Success;
                actionMessage = "删除成功！";


                AddActionLog(registerInfo, PageContext.Action, actionResult, actionMessage);//添加操作日志

                Refresh();
            }
            catch (Exception ex)
            {
                actionMessage = "删除失败!";
                log.Error(actionMessage, ex);
            }

            WebUtil.PromptMsg(actionMessage);

        }

        /// <summary>
        /// 删除所有数据
        /// </summary>
        public string DeleteAll(string ajaxArgument)
        {
            AjaxResult ajaxResult = new AjaxResult();
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                registerService.DeleteAll(ajaxArgument, RegisterType);
                actionResult = ActionResult.Success;
                actionMessage = "删除成功！";

            }
            catch (Exception ex)
            {
                actionMessage = "删除失败!";
                log.Error(actionMessage, ex);
            }

            ajaxResult.ActionResult = actionResult;
            ajaxResult.PromptMsg = actionMessage;
            return JsonConvert.SerializeObject(ajaxResult);
        }

        /// <summary>
        /// 名册审核确认
        /// </summary>
        public string ConfirmSubmit(string ajaxArgument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            string yearMonth = ajaxArgument;  //所属年月
            string corpID = User.CorpID; //所属分公司
            try
            {
                registerService.ChangeRegisterStatus(corpID, yearMonth, (int)RegisterStatus.Confirmed, RegisterType);

                actionResult = ActionResult.Success;

                actionMessage = "确认成功！";

                AddActionLog(new RegisterInfo(), PageContext.Action, actionResult, actionMessage);//添加操作日志
            }
            catch (Exception ex)
            {
                actionMessage = "确认失败!";
                log.Error(string.Format("名册确认失败！【分公司：{0}】【所属年月：{1}】", corpID, yearMonth), ex);
            }
            ajaxResult.ActionResult = actionResult;
            ajaxResult.PromptMsg = actionMessage;
            return JsonConvert.SerializeObject(ajaxResult);
        }

        /// <summary>
        /// SAP同步
        /// </summary>
        public string Synchronize(string ajaxArgument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            string corpID = Request.QueryString["corpID"] ?? User.CorpID;
            bool isComplete = Request.QueryString["isComplete"] == "1" ? true : false;
            try
            {
               
                DataTable registers = registerService.GetRegisterByCorpID(null, RegisterType, corpID, ajaxArgument, null);
                if (registers == null)
                {
                    actionResult = ActionResult.Other;
                    ajaxResult.RetValue = string.Empty;
                    actionMessage = "没有名册信息，不能同步！";
                }
                else
                {
                    string registerCodes = string.Empty;
                    for (int i = 0; i < registers.Rows.Count; i++)
                    {
                        DataRow row = registers.Rows[i];
                        registerCodes += row["Code"] + ",";
                    }
                    if (!string.IsNullOrEmpty(registerCodes))
                    {
                        registerCodes = registerCodes.Substring(0, registerCodes.Length - 1);
                        ajaxResult.RetValue = sapBLL.SapSynchronize(registerCodes,isComplete);
                        if (!string.IsNullOrEmpty(ajaxResult.RetValue.ToSafeString()))
                        {
                            log.Error(ajaxResult.RetValue);
                            actionMessage = "同步完成，请查看提示信息。";
                        }
                        else
                        {
                            actionMessage = "同步成功！";
                        }
                        actionResult = ActionResult.Success;
                    }
                }
            }
            catch (Exception ex)
            {
                actionMessage = "同步失败!";
                log.Error(string.Format("名册同步失败！【分公司：{0}】【所属年月：{1}】", corpID, ajaxArgument), ex);
            }
            ajaxResult.ActionResult = actionResult;
            ajaxResult.PromptMsg = actionMessage;
            return JsonConvert.SerializeObject(ajaxResult);
        }
        #endregion
    }
}