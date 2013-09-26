﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Workflow
 * Module:  ProcessDef
 * Descrption:
 * CreateDate: 2010/11/18 12:00:10
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

using log4net;
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
using EAFrame.Workflow.Domain;
using EAFrame.Workflow.Service;
using SunTek.EAFrame.Infrastructure.Domain;
using SunTek.EAFrame.Infrastructure.Service;
using Newtonsoft.Json;
using EAFrame.Workflow.Engine;

namespace WebSite
{
    public partial class ProcessDefDetail : BasePage
    {
        private ProcessDefService processDefService = new ProcessDefService();

        private DictService dictService = new DictService();

        private DictItemService dictItemService = new DictItemService();

        #region ---界面处理方法---

        protected bool ShowPageDetail()
        {
            if (PageContext.Action == ActionType.Add)
            {
                //dtpCreateTime.Text=DateTime.Now.ToShortDateString();
                //dtpModifyTime.Text=DateTime.Now.ToShortDateString();

                return false;
            }

            ProcessDef entity = processDefService.GetDomain(CurrentId);

            if (entity == null) return false;

            SetControlValues(entity);

            return true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //txtCreator.Text = User.Name;

            if (!IsPostBack)
            {
                setDropValue();
                ShowPageDetail();
            }
        }

        protected void setDropValue()
        {
            cboCurrentState.IsSingle = true;
            cboCurrentState.BindCombox(EAFrame.Workflow.Enums.ProcessStatus.Candidate);

            cboCurrentFlag.IsSingle = true;
            ComboxItem cbi1 = new ComboxItem();
            cbi1.Text = "是";
            cbi1.Value = "1";
            cboCurrentFlag.Items.Add(cbi1);
            cboIsActive.Items.Add(cbi1);
            ComboxItem cbi2 = new ComboxItem();
            cbi2.Text = "否";
            cbi2.Value = "0";
            cboCurrentFlag.Items.Add(cbi2);
            cboIsActive.Items.Add(cbi2);
            cboCurrentFlag.SelectedValue = "0";
            cboIsActive.SelectedValue = "0";

            Combobox_Load("ProcessCategory", chbCategoryID);
        }

        protected void Combobox_Load(string dictName, Combox comboBox)
        {

            IList<DictItem> dictItems = dictService.GetDictItems(dictName);

            foreach (var item in dictItems)
            {
                ComboxItem cbi = new ComboxItem();
                cbi.Text = item.Text;
                cbi.Value = item.ID;
                comboBox.Items.Add(cbi);
            }

            if (dictItems != null && dictItems.Count > 0)
                comboBox.SelectedValue = dictItems[0].ID;
        }

        #endregion

        #region ---操作处理方法---
        protected ProcessDef GetDomainObject()
        {
            ProcessDef processDef = processDefService.GetDomain(CurrentId);


            if (processDef == null)
            {
                processDef = new ProcessDef();
                processDef.ID = CurrentId;
            }

            GetControlValues(ref processDef);
            processDef.Content = Server.HtmlDecode(txtContent.Text);

            return processDef;
        }

        /// <summary>
        /// 保存
        /// </summary>
        public string Save(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                ProcessDef processDef = JsonConvert.DeserializeObject<ProcessDef>(argument);
                processDef.Content = HttpUtility.UrlDecode(processDef.Content);
                processDef.CategoryID = chbCategoryID.SelectedValue;
                if (PageContext.Action == ActionType.Add)
                {
                    processDef.CreateTime = DateTime.Now;
                    processDef.Creator = User.ID;
                }
                else if (PageContext.Action == ActionType.Update)
                {
                    processDef.ModifyTime = DateTime.Now;
                    processDef.Modifier = User.ID;
                }
                processDef.ID = string.IsNullOrEmpty(CurrentId) ? CurrentId = IdGenerator.NewComb().ToString() : CurrentId;

                if (processDef.CurrentFlag == 1)  //是当前版本
                {
                    IDictionary<string, object> parameters = new Dictionary<string, object>();
                    parameters.Add("Name", processDef.Name);
                    parameters.Add("CurrentFlag", 1);

                    if (processDefService.FindOne(parameters) == null)
                    {
                        processDefService.SaveOrUpdate(processDef);
                        actionResult = ActionResult.Success;

                        //获取提示信息
                        actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                        //记录操作日志
                        AddActionLog(processDef, PageContext.Action, actionResult, actionMessage);

                        ajaxResult.ActionResult = actionResult;
                    }
                    else
                    {
                        actionMessage = "已存在同名当前版本，请重新选择‘是否当前版本’！";
                    }
                }
                else
                {
                    processDefService.SaveOrUpdate(processDef);
                    actionResult = ActionResult.Success;

                    //获取提示信息
                    actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                    //记录操作日志
                    AddActionLog(processDef, PageContext.Action, actionResult, actionMessage);

                    ajaxResult.ActionResult = actionResult;
                }

                ajaxResult.RetValue = processDef.ID;
                ajaxResult.PromptMsg = actionMessage;
                CacheManager.Remove("all_ProcessDefine");
            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
            //try
            //{
            //    ProcessDef processDef = GetDomainObject();

            //    if (PageContext.Action == ActionType.Add)
            //    {
            //        processDef.CreateTime = DateTime.Now;
            //        processDef.Creator = User.ID;
            //    }
            //    else if (PageContext.Action == ActionType.Update)
            //    {
            //        processDef.ModifyTime = DateTime.Now;
            //        processDef.Modifier = User.ID;
            //    }
            //    processDef.Content = HttpUtility.HtmlEncode(txtText.Text);

            //    processDefService.SaveOrUpdate(processDef);

            //    WebUtil.PromptMsg("保存操作成功");
            //}
            //catch (Exception ex)
            //{
            //    log.Error("保存操作失败", ex);

            //    WebUtil.PromptMsg("保存操作失败");
            //}
        }

        #endregion
    }
}
