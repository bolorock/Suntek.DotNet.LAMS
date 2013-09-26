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

namespace WebSite
{
    public partial class ResourceTree : BasePage
    {
        ResourceService resourceService = new ResourceService();

        protected void Page_Load(object sender, EventArgs e)
        {
            InitTree();
        }

        /// <summary>
        /// 初始化树
        /// </summary>
        private void InitTree()
        {
            (this.Master as PageMaster).IsShowNavInfo = false;
            AjaxTree1.PostType = PostType.NoPost;
            AjaxTree1.IsAjaxLoad = false;
            AjaxTree1.ShowNodeIco = true;
            AjaxTree1.ShowCheckBox = false;
            AjaxTree1.Nodes.Clear();

           // Resource appResource = resourceService.All().FirstOrDefault(o => o.ID == ApplicationContext.AppID);
            SunTek.EAFrame.Infrastructure.Domain.SysParam sysParam = new SunTek.EAFrame.Infrastructure.Service.SysParamService().GetSysParam("AppID");
            AjaxTreeNode appNode = new AjaxTreeNode()
            {
                ID = sysParam.Value.ToString(), //appResource.ID,
                Text = sysParam.Description, //appResource.Text,
                Value = sysParam.Value.ToString(), //appResource.Type.ToString(),
                Tag = "root",
                IcoSrc = string.Format("{0}Skins/{1}/Images/resource.png", WebUtil.GetRootPath(), Skin),
                NodeState = NodeState.Open
            };
            AjaxTree1.Nodes.Add(appNode);

            List<Resource> resources = resourceService.All().Where(o => o.ParentID == appNode.ID).OrderBy(o => o.SortOrder).ToList();
            foreach (var res in resources)
            {
                AjaxTreeNode node = new AjaxTreeNode()
                {
                    ID = res.ID,
                    Text = res.Text,
                    Value = res.ID,
                    Tag = res.Type.ToString(),
                    IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(res.Type.Cast<ResourceType>(ResourceType.Menu)))
                };

                BuildTree(node);

                appNode.ChildNodes.Add(node);
            }
        }

        /// <summary>
        /// 设置目录图标
        /// </summary>
        /// <param name="ResourceType"></param>
        /// <returns></returns>
        private string getResourceIcon(ResourceType ResourceType)
        {
            string icon = "page.png";

            switch (ResourceType)
            {
                case ResourceType.Button:
                    icon = "button.png";
                    break;
                case ResourceType.Menu:
                    icon = "menu.gif";
                    break;
                case ResourceType.Page:
                    icon = "page.png";
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
                Resource resource = resourceService.GetDomain(argument);

                if (resource != null)
                {
                    resourceService.Delete(resource);
                    actionResult = ActionResult.Success;
                }
                else
                {
                    actionResult = ActionResult.Failed;
                }

                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                //记录操作日志
                AddActionLog(resource, PageContext.Action, actionResult, actionMessage);

                ajaxResult.ActionResult = actionResult;
                ajaxResult.RetValue = resource.ParentID;
                ajaxResult.PromptMsg = actionMessage;
            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }
    }
}
