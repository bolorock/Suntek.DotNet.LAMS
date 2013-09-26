﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: AuthorizeCenter
 * Module:  ObjectRole
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
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;

using Newtonsoft.Json;

namespace WebSite
{
    public partial class ObjectRoleManager : BasePage
    {
 		private ObjectRoleService objectRoleService=new ObjectRoleService();
        
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
                InitTree();
            }
        }

        #endregion

        #region ---操作处理方法---
	
		
        private void InitTree()
        {
            AjaxTree1.PostType = PostType.NoPost;
            AjaxTree1.IsAjaxLoad = false;
            AjaxTree1.ShowNodeIco = false;
            AjaxTree1.ShowCheckBox = true;
            AjaxTree1.Nodes.Clear();

            List<Role> roles = new RoleService().All().ToList();

              string userID = Request.QueryString["UserID"];
            IDictionary<string, object> para = new Dictionary<string, object>();
            para.Add("ObjectID", userID);
            IList<string> objectRoleIDs = objectRoleService.FindAll(para).Select(o => o.RoleID).ToList<string>();


            foreach (var role in roles)
            {
                AjaxTreeNode node = new AjaxTreeNode()
                {
                    ID = role.ID,
                    Text = role.Name,
                    Value = role.ID,
                    Checked = objectRoleIDs.Contains(role.ID)
                };

                AjaxTree1.Nodes.Add(node);
            }
        }


        public string Save(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();
            try
            {
                

                IList<AjaxTreeNode> parameters = JsonConvert.DeserializeObject<IList<AjaxTreeNode>>(argument);

                string userID = Request.QueryString["UserID"];

                if (string.IsNullOrEmpty(userID))
                {
                    ajaxResult.ActionResult = ActionResult.Failed;
                    ajaxResult.PromptMsg = "用户对象为空！";
                    log.Error("角色ID为空");
                    return JsonConvert.SerializeObject(ajaxResult);
                }

                if (parameters == null || parameters.Count == 0)
                {
                    ajaxResult.PromptMsg = "您没有选择任何角色，请选择后再保存！";
                    return JsonConvert.SerializeObject(ajaxResult);
                }

                ObjectRoleService urService = new ObjectRoleService();
                IList<ObjectRole> userRoles = parameters.Select(p => new ObjectRole()
                {
                    ID = IdGenerator.NewComb().ToSafeString(),
                    RoleID = p.Value,
                    ObjectID = userID
                }).ToList();


                urService.SaveObjectRoles(userRoles);
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