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

using SunTek.Register.Service;

namespace WebSite.Register
{
    public partial class ChooseOrgTree : BasePage
    {
        OrganizationService sOrg = new OrganizationService();
        CorpSortService corpSortService = new CorpSortService();

        #region 显示
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
            AjaxTree1.ShowCheckBox = true;
            AjaxTree1.IsAjaxLoad = true;
            AjaxTree1.SelectionMode = SelectionMode.Multiple;
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
        /// 创建目录树方法
        /// </summary>
        /// <param name="tn">目录树的节点</param>
        private void BuildTree(AjaxTreeNode tn)
        {
            List<Organization> resources = sOrg.All().Where(o => o.ParentID == tn.ID && o.Status == 0).OrderBy(o => o.SortOrder).ToList();

            foreach (var res in resources)
            {
                AjaxTreeNode node = new AjaxTreeNode()
                {
                    ID = res.ID,
                    Text = res.Name,
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
        #endregion 

        #region 操作处理方法
        public string AddCorp(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Success;
            string actionMessage = string.Empty;
            try
            {
                IList<SunTek.Register.Domain.CorpSort> corpSorts = JsonConvert.DeserializeObject<IList<SunTek.Register.Domain.CorpSort>>(argument);
                UnitOfWork.ExecuteWithTrans<SunTek.Register.Domain.CorpSort>(() =>
                {
                    foreach (var corpSort in corpSorts)
                    {
                        if (corpSortService.GetDomain(corpSort.ID) == null)
                        {
                            int index = (int)corpSortService.Count(new Dictionary<string, object>()) + 1;
                            corpSort.SortOrder = index;
                            corpSortService.SaveOrUpdate(corpSort);
                        }
                        else
                        {
                            actionResult = ActionResult.Other;
                            
                        }
                    }

                });

            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
                actionResult = ActionResult.Failed;
            }

            //获取提示信息
            actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

            ajaxResult.ActionResult = actionResult;
            ajaxResult.PromptMsg = actionMessage;

            return JsonConvert.SerializeObject(ajaxResult);
        }
        #endregion
    }
}