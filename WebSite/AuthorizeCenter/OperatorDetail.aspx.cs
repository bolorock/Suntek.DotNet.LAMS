﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: AuthorizeCenter
 * Module:  Operator
 * Descrption:
 * CreateDate: 2010/11/18 13:55:37
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
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;

using Newtonsoft.Json;

namespace WebSite
{
    public partial class OperatorDetail : BasePage
    {
        private OperatorService operatorService = new OperatorService();

        #region ---界面处理方法---
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            cboRole.DataSource = new RoleService().FindAll(null);
            cboRole.DataTextField = "Name";
            cboRole.DataValueField = "ID";
            cboRole.DataBind();
            cboRole.Items.Insert(0, new ListItem("请选择", "-1"));


        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !IsAjaxPost)
            {
                ShowPageDetail();
            }
        }

        protected bool ShowPageDetail()
        {
         

            if (PageContext.Action == ActionType.Add)
            {
                dtpExpireTime.Text = DateTime.Now.ToShortDateString();
                dtpLastLogin.Text = DateTime.Now.ToShortDateString();
                dtpStartTime.Text = DateTime.Now.ToShortDateString();
                dtpEndTime.Text = DateTime.Now.ToShortDateString();
                dtpCreateTime.Text = DateTime.Now.ToShortDateString();
                return false;
            }

            Operator entity = operatorService.GetDomain(CurrentId);

            //绑定用户角色
            IDictionary<string, object> para = new Dictionary<string, object>();
            para.Add("ObjectID", CurrentId);
            ObjectRole objectRole = new ObjectRoleService().FindOne(para);
            if (objectRole != null)
                cboRole.SelectedValue = objectRole.RoleID;

            if (entity == null) return false;

            SetControlValues(entity);



            return true;
        }
        #endregion

        #region ---操作处理方法---
        protected Operator GetDomainObject()
        {
            Operator _operator = operatorService.GetDomain(CurrentId);

            if (_operator == null)
            {
                _operator = new Operator();
                _operator.ID = CurrentId;
            }

            GetControlValues(ref _operator);

            return _operator;
        }


         public string Save()
        {
            AjaxResult ajaxResult = new AjaxResult();
            try
            {
                Operator _operator = GetDomainObject();
                operatorService.SaveOrUpdate(_operator);
                ajaxResult.RetValue = string.Empty;
                ajaxResult.ActionResult = ActionResult.Success;
                ajaxResult.PromptMsg = "保存成功！";
            }
            catch (Exception ex)
            {
                ajaxResult.ActionResult = ActionResult.Failed;
                ajaxResult.PromptMsg = "保存角色出错，请联系管理员！";
                log.Error(ex);

               
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }
        #endregion

        

    }
}
