using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Newtonsoft.Json;
using EAFrame.Core;
using EAFrame.Core.Extensions;
using EAFrame.Core.Web;
using EAFrame.Core.Utility;
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;
using EAFrame.WebControls;
using EAFrame.Core.Enums;
using Newtonsoft.Json.Converters;
using System.IO;

namespace WebSite.AuthorizeCenter
{
    public partial class OrgTree : BasePage
    {
        OrganizationService sOrg = new OrganizationService();

        protected void Page_Load(object sender, EventArgs e)
        {
            PageMaster baseMaster = Master as PageMaster;
            baseMaster.IsShowNavInfo = false;
            InitTree();
        }

        /// <summary>
        /// 初始化树
        /// </summary>
        private void InitTree()
        {
            AjaxTree1.PostType = PostType.None;
            AjaxTree1.ShowNodeIco = true;
            AjaxTree1.ShowCheckBox = string.Equals(Request.QueryString["Entry"], "Choose") || string.Equals(Request.QueryString["Entry"], "ConfigureRolePrivilege");
            AjaxTree1.IsAjaxLoad = true;
            AjaxTree1.SelectionMode = SelectionMode.Single;
            AjaxTree1.Nodes.Clear();

            List<Organization> organizations = sOrg.All().Where(o => o.ParentID == "OR1000000001" && o.Status == 0).OrderBy(o => o.SortOrder).ToList();//中国电信广东公司 的id
            foreach (var org in organizations)
            {
                AjaxTreeNode node = new AjaxTreeNode()
                {
                    ID = org.ID,
                    Text = org.Name,
                    Value = org.ID,
                    Tag = org.Type.ToString(),
                    IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(org.Type.Cast<ResourceType>(ResourceType.Menu))),
                    VirtualNodeCount = sOrg.All().Count(o => o.ParentID == org.ID)
                };

                AjaxTree1.Nodes.Add(node);
            }
        }
        private AjaxTreeNodeCollection getChildrenNodes(string id)
        {
            AjaxTreeNodeCollection result = new AjaxTreeNodeCollection();


            IList<Organization> organizations = sOrg.All().Where(o => o.ParentID == id && o.Status == 0).OrderBy(o => o.SortOrder).ToList<Organization>();

            if (organizations == null) return null;

            foreach (var org in organizations)
            {
                AjaxTreeNode node = new AjaxTreeNode()
                {
                    ID = org.ID,
                    Text = org.Name,
                    Value = org.ID,
                    Tag = org.Type.ToString(),
                    IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(org.Type.Cast<ResourceType>(ResourceType.Menu))),
                    VirtualNodeCount = sOrg.All().Count(o => o.ParentID == org.ID),
                    LinkUrl = string.Format("{0}AuthorizeCenter/OrgUserList.aspx?orgid={1}", WebUtil.GetRootPath(), org.ID),
                    Target = "ifrMain"
                };

                result.Add(node);
            }

            return result;
        }



        public string AjaxExpand(string id)
        {
            bool isLastNode = Request.Form["IsLastNode"].Cast<bool>(false);
            AjaxTreeNodeCollection ajaxTreeNodes = getChildrenNodes(id);
            ajaxTreeNodes.Owner = AjaxTree1;
            ajaxTreeNodes.NodesState = NodeState.Open;
            Html32TextWriter writer = new Html32TextWriter(Response.Output);
            ajaxTreeNodes.AjaxRender(writer, 1, isLastNode);

            return string.Empty;
        }

        /// <summary>
        /// 设置目录图标
        /// </summary>
        /// <param name="ResourceType"></param>
        /// <returns></returns>
        private string getResourceIcon(ResourceType ResourceType)
        {
            string icon = "orgtree.gif";

            switch (ResourceType)
            {
                case ResourceType.Button:
                    icon = "orgtree.gif";
                    break;
                case ResourceType.Menu:
                    icon = "orgtree.gif";
                    break;
                case ResourceType.Page:
                    icon = "orgtree.gif";
                    break;
            }

            return icon;
        }
        /// <summary>
        /// 删除节点
        /// </summary>
        /// <param name="argument"></param>
        public string DeleteTreeNode(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                Organization org = sOrg.GetDomain(argument);

                if (org != null)
                {
                    org.Status = 1;
                    sOrg.SaveOrUpdate(org);
                    actionResult = ActionResult.Success;
                }
                else
                {
                    actionResult = ActionResult.Failed;
                }

                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                //记录操作日志
                AddActionLog(org, PageContext.Action, actionResult, actionMessage);

                ajaxResult.ActionResult = actionResult;
                ajaxResult.RetValue = org.ParentID;
                ajaxResult.PromptMsg = actionMessage;
            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }
        /// <summary>
        /// 创建目录树方法
        /// </summary>
        /// <param name="tn">目录树的节点</param>
        private void BuildTree(AjaxTreeNode tn)
        {
            List<Organization> resources = sOrg.All().Where(o => o.ParentID == tn.ID && o.Status ==0).OrderBy(o => o.SortOrder).ToList();

            foreach (var res in resources)
            {
                AjaxTreeNode node = new AjaxTreeNode()
                {
                    ID = res.ID,
                    Text = res.Name,
                    Value = res.ID,
                    Tag = res.Type.ToString(),
                    NodeIcoSrc = tn.NodeIcoSrc,
                    LinkUrl = string.Format("{0}AuthorizeCenter/OrgUserList.aspx?orgid={1}", WebUtil.GetRootPath(), res.ID),
                    Target = "ifrMain",
                    IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(res.Type.Cast<ResourceType>(ResourceType.Menu)))
                };


                tn.ChildNodes.Add(node);
                //递归获取目录树
                BuildTree(node);
            }
        }
    }
}