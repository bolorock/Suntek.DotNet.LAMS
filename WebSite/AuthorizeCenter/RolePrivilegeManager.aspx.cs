﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: AuthorizeCenter
 * Module:  RolePrivilege
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

    public partial class RolePrivilegeManager : BasePage
    {
        private RolePrivilegeService rolePrivilegeService = new RolePrivilegeService();
        private ResourceService resourceService = new ResourceService();

        protected void Page_Load(object sender, EventArgs e)
        {

            string roleID = Request.QueryString["RoleID"];
            //初始化角色权限
            InitRolePrivilege(roleID);
        }



        /// <summary>
        /// 初始化树
        /// </summary>
        private void InitRolePrivilege(string roleID)
        {
            (this.Master as PageMaster).IsShowNavInfo = false;
            AjaxTree1.PostType = PostType.NoPost;
            AjaxTree1.IsAjaxLoad = false;
            AjaxTree1.ShowNodeIco = false;
            AjaxTree1.ShowCheckBox = true;
            AjaxTree1.Nodes.Clear();

            //Resource appResource = resourceService.All().FirstOrDefault(o => o.ID == ApplicationContext.AppID);
            SunTek.EAFrame.Infrastructure.Domain.SysParam sysparam = new SunTek.EAFrame.Infrastructure.Service.SysParamService().GetSysParam("AppID");
            string rootPriId = GetPidByResId(sysparam.Value);

            IDictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.SafeAdd("RoleID", roleID);
            IList<RolePrivilege> rolePrivileges = rolePrivilegeService.FindAll(parameters);
            List<string> privileges = rolePrivileges != null ? rolePrivileges.Select(o => o.PrivilegeID).ToList() : new List<string>();

            AjaxTreeNode appNode = new AjaxTreeNode()
            {
                ID = rootPriId,
                Text = sysparam.Description,
                Value = rootPriId,
                Tag = "root",
                IcoSrc = string.Format("{0}Skins/{1}/Images/menu.gif", WebUtil.GetRootPath(), Skin),
                NodeState = NodeState.Open,
                Checked = privileges.Contains(rootPriId),

            };
            AjaxTree1.Nodes.Add(appNode);

            //取得当前登录角色的权限组合
            List<string> privilegeIDs = new OperatorService().GetPrivilegeIDs(User.ID);

            //根据权限id取到资源id集合
            List<string> resIDs = new PrivilegeService().All().Where(o => User.UserType == (short)UserType.Administrator || privilegeIDs.Contains(o.ID)).Select(o => o.ResourceID).ToList();

            //根据权限id取到操作项id集合
            List<string> operateIds = new PrivilegeService().All().Where(p =>  !string.IsNullOrWhiteSpace(p.OperateID) && (User.UserType == (short)UserType.Administrator || privilegeIDs.Contains(p.ID))).Select(p => p.OperateID).ToList() ?? new List<string>();


            List<Resource> resources = resourceService.All().Where(o => o.ParentID == sysparam.Value && (User.UserType == (short)UserType.Administrator || resIDs.Contains(o.ID))).OrderBy(o => o.SortOrder).ToList();


            foreach (Resource resource in resources)
            {
                string priId = GetPidByResId(resource.ID);
                AjaxTreeNode node = new AjaxTreeNode()
                {
                    ID = priId,
                    Text = resource.Text,
                    Value = resource.ID,
                    Tag = ResourceType.Page.ToString(),
                    NodeState = NodeState.Open,
                    Checked = privileges.Contains(priId)
                };

                AddChildResource(node, privileges, resIDs, operateIds);
                appNode.ChildNodes.SafeAdd(node);
            }
        }





        void AddChildResource(AjaxTreeNode parentNode, List<string> privileges, List<string> resIDs, List<string> operateIds)
        {
            List<Resource> resources = resourceService.All().Where(o => o.ParentID == parentNode.Value && resIDs.Contains(o.ID)).OrderBy(o => o.SortOrder).ToList();
            foreach (var resource in resources)
            {
                string priId = GetPidByResId(resource.ID);
                AjaxTreeNode node = new AjaxTreeNode()
                {
                    ID = priId,
                    Text = resource.Text,
                    Value = resource.ID,
                    NodeState = NodeState.Close,
                    IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(resource.Type.Cast<ResourceType>(ResourceType.Menu))),
                    Checked = privileges.Contains(priId)
                };

                BuildOperate(node, privileges, operateIds);

                parentNode.ChildNodes.SafeAdd(node);
                AddChildResource(node, privileges, resIDs, operateIds);
            }
        }

        /// <summary>
        /// 绑定操作项（因为树用了级联，所以判断如果下边有操作项的时候，将模拟一个访问）
        /// </summary>
        /// <param name="parentNode">父节点</param>
        /// <param name="privileges">权限集合</param>
        void BuildOperate(AjaxTreeNode parentNode, List<string> privileges, List<string> operateIds)
        {
            List<Privilege> operates = new PrivilegeService().All().Where(p => p.ResourceID == parentNode.Value && !string.IsNullOrWhiteSpace(p.OperateID) && operateIds.Contains(p.OperateID)).ToList(); //取得资源相关的所有操作项id

            //   List<Operate> operates = new OperateService().All().Where(o => operateIDs.Contains(o.ID)).ToList(); //根据操作项id集合得到操作项集合

            //判断如果下边有操作项的时候，将模拟一个访问
            if (operates.Count > 0)
            {
                AjaxTreeNode node = new AjaxTreeNode()
                {
                    ID = "tempAccess",
                    Text = "访问",
                    Value = "tempAccess",
                    Tag = "Operate",
                    Checked = parentNode.Checked
                };
                parentNode.ChildNodes.SafeAdd(node);
            }

            foreach (var operate in operates)
            {
                AjaxTreeNode node = new AjaxTreeNode()
                {
                    ID = operate.ID,
                    Text = operate.Name,
                    Value = operate.ID,
                    Tag = "Operate",
                    Checked = privileges.Contains(operate.ID)
                };
                parentNode.ChildNodes.SafeAdd(node);
            }

        }


        /// <summary>
        /// 设置目录图标
        /// </summary>
        /// <param name="ResourceType"></param>
        /// <returns></returns>
        private string getResourceIcon(ResourceType ResourceType)
        {
            string icon = "menu.gif";

            switch (ResourceType)
            {
                case ResourceType.Button:
                    icon = "menu.gif";
                    break;
                case ResourceType.Menu:
                    icon = "menu.gif";
                    break;
                case ResourceType.Page:
                    icon = "menu.gif";
                    break;
            }

            return icon;
        }

        /// <summary>
        /// 创建目录树方法
        /// </summary>
        /// <param name="tn">目录树的节点</param>
        private void BuildTree(AjaxTreeNode tn)
        {
            List<Resource> resources = resourceService.All().Where(o => o.ParentID == tn.ID).OrderBy(o => o.SortOrder).ToList();

            foreach (var res in resources)
            {
                AjaxTreeNode node = new AjaxTreeNode()
                {
                    ID = res.ID,
                    Text = res.Text,
                    Value = res.ID,
                    Tag = res.Type.ToString(),
                    NodeIcoSrc = tn.NodeIcoSrc,
                    IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(res.Type.Cast<ResourceType>(ResourceType.Menu)))
                };

                tn.ChildNodes.Add(node);
                //递归获取目录树
                BuildTree(node);
            }
        }

        public string Save(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();
            try
            {
                IList<string> parameters = argument.Trim(',').Split(',').ToList();

                string roleID = Request.QueryString["RoleID"];

                if (string.IsNullOrEmpty(roleID))
                {
                    ajaxResult.ActionResult = ActionResult.Failed;
                    ajaxResult.PromptMsg = "角色ID为空！";
                    log.Error("角色ID为空");
                    return JsonConvert.SerializeObject(ajaxResult);
                }

                if (parameters == null || parameters.Count == 0)
                {
                    ajaxResult.PromptMsg = "您没有选择任何资源，请选择后再保存！";
                    return JsonConvert.SerializeObject(ajaxResult);
                }

                IList<RolePrivilege> rolePrivileges = parameters.Where(o => o != "tempAccess").Select(p => new RolePrivilege()
                {
                    ID = IdGenerator.NewComb().ToSafeString(),
                    RoleID = roleID,
                    PrivilegeID = p
                }).ToList();


                rolePrivilegeService.SaveRolePrivilege(rolePrivileges);

                ajaxResult.RetValue = string.Empty;
                ajaxResult.ActionResult = ActionResult.Success;
                ajaxResult.PromptMsg = "保存成功！";
                WebUtil.CloseWidow(false);
            }
            catch (Exception ex)
            {
                ajaxResult.ActionResult = ActionResult.Failed;
                ajaxResult.PromptMsg = "保存角色出错，请联系管理员！";
                log.Error(ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }


        string GetPidByResId(string resourceID)
        {
            return new PrivilegeService().GetPidByResId(resourceID);
        }
    }
}
