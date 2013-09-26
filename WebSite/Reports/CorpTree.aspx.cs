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
using System.Data;
using EAFrame.Workflow.Engine;
using SunTek.Assessment.Domain;
using SunTek.Assessment.Service;

namespace WebSite
{
    public partial class CorpTree : BasePage
    {
        OrganizationService sOrg = new OrganizationService();
        public override bool Authorize(EAFrame.Core.Authentication.User user, string requestUrl, bool isForce)
        {
            return base.Authorize(user, requestUrl, false);
        }
        private string IfrMainURL
        {
            get
            {
                string type = Request.QueryString["type"] ?? string.Empty;
                switch (type)
                {
                    case "edu":
                        return "EducationStructureReport.aspx";
                    case "age":
                        return "AgeStructureReport.aspx";
                }
                return string.Empty;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !IsAjaxPost)
            {
                PageMaster baseMaster = Master as PageMaster;
                baseMaster.IsShowNavInfo = false;
                string[] strArray=new string[]{"OR1500025055","OR1500025056","OR1500025057","OR1200000535"};
                List<Organization> orgs = sOrg.All().Where(o => o.ID == "OR1000000001" || strArray.Contains(o.ID) || strArray.Contains(o.ParentID)).ToList();
                InitTree(orgs);
            }
        }

        /// <summary>
        /// 创建目录树方法
        /// </summary>
        /// <param name="tn">目录树的节点</param>
        private void BuildTree(AjaxTreeNode tn,IList<Organization> orgs)
        {
            List<Organization> resources = orgs.Where(o => o.ParentID == tn.ID).OrderBy(o => o.SortOrder).ToList();

            foreach (var res in resources)
            {
                AjaxTreeNode node = new AjaxTreeNode()
                {
                    ID = res.ID,
                    Text = res.Name,
                    Value = res.ID,
                    Tag = res.Type.ToString(),
                    NodeIcoSrc = tn.NodeIcoSrc,
                    Target = "ifrMain",
                    LinkUrl = string.Format("{0}?corpID={1}",IfrMainURL,res.ID),
                    IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(res.Type.Cast<ResourceType>(ResourceType.Menu)))
                };

                tn.ChildNodes.Add(node);
                //递归获取目录树
               // BuildTree(node);
            }
        }

        /// <summary>
        /// 初始化树
        /// </summary>
        private void InitTree(IList<Organization> orgs)
        {
            AjaxTree1.PostType = PostType.NoPost;

            AjaxTree1.ShowNodeIco = true;
            AjaxTree1.ShowCheckBox = false;
            AjaxTree1.IsAjaxLoad = false;
            AjaxTree1.Nodes.Clear();

            Organization organization = orgs.First(o => o.ID == "OR1000000001");
            AjaxTreeNode parentNode = new AjaxTreeNode()
            {
                ID = organization.ID,
                Text = organization.Name,
                Value = organization.ID,
                Tag = organization.Type.ToString(),
                Target = "ifrMain",
                LinkUrl = IfrMainURL,
                NodeState= EAFrame.WebControls.NodeState.Open,
                IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(organization.Type.Cast<ResourceType>(ResourceType.Menu))),
            };

            AjaxTree1.Nodes.Add(parentNode);

            List<Organization> organizations = orgs.Where(o => o.ParentID == "OR1000000001").OrderBy(o => o.SortOrder).ToList();//中国电信广东公司 的id
            foreach (var org in organizations)
            {
                AjaxTreeNode node = new AjaxTreeNode()
                {
                    ID = org.ID,
                    Text = org.Name,
                    Value = org.ID,
                    Tag = org.Type.ToString(),
                    Target = "ifrMain",
                    LinkUrl = string.Format("{0}?corpID={1}",IfrMainURL, org.ID),
                    IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(org.Type.Cast<ResourceType>(ResourceType.Menu))),
                };

                parentNode.ChildNodes.Add(node);
                BuildTree(node,orgs);
            }
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
    }
}