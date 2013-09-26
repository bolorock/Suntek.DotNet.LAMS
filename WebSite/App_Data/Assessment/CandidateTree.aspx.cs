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
    public partial class CandidateTree : BasePage
    {
        OrganizationService sOrg = new OrganizationService();
        EmployeeService employeeService = new EmployeeService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int grade = employeeService.GetEmployeeCorpGrade(User.ID);
                InitTree(grade);
            }
        }

        /// <summary>
        /// 设置目录图标
        /// </summary>
        /// <param name="ResourceType"></param>
        /// <returns></returns>
        private string getResourceIcon(ResourceType ResourceType)
        {
            string icon = "group.png";

            switch (ResourceType)
            {
                case ResourceType.Button:
                    icon = "group.png";
                    break;
                case ResourceType.Menu:
                    icon = "group.png";
                    break;
                case ResourceType.Page:
                    icon = "orgtree.gif";
                    break;
            }

            return icon;
        }

        /// <summary>
        /// 初始化树
        /// </summary>
        private void InitTree(int grade)
        {
            AjaxTreeNode nodePrincipal = null; //正职节点
            AjaxTreeNode nodeDeputy = null;//副职节点

            AjaxTree1.PostType = PostType.NoPost;

            AjaxTree1.ShowNodeIco = true;
            AjaxTree1.ShowCheckBox = false;
            AjaxTree1.IsAjaxLoad = false;
            AjaxTree1.Nodes.Clear();

            #region "固定树节点"
            AjaxTreeNode ParentNode = new AjaxTreeNode()
            {
                ID = "0",
                Text = "后备经理人",
                Value = "0",
                Tag = "0",
                NodeState = NodeState.Open,
                LinkUrl = "CandidateMList.aspx?layer=1&grade=" + grade + (grade != 0 ? "&corpID=" + User.CorpID : string.Empty),
                Target = "ifrMain",
                IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(2.Cast<ResourceType>(ResourceType.Page)))
            };
            AjaxTree1.Nodes.Add(ParentNode);
            
           

            AjaxTreeNode nodeTwo = new AjaxTreeNode()
            {
                ID = "11",
                Text = "二级经理",
                Value = "11",
                Tag = "11",
                NodeState=NodeState.Open,
                LinkUrl = "CandidateMList.aspx?layer=2&grade=" + grade + (grade != 0 ? "&corpID=" + User.CorpID : string.Empty),
                Target = "ifrMain",
                IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(2.Cast<ResourceType>(ResourceType.Menu)))
            };
            ParentNode.ChildNodes.Add(nodeTwo);
           
            AjaxTreeNode nodeThree = new AjaxTreeNode()
            {
                ID = "12",
                Text = "三级经理",
                Value = "12",
                Tag = "12",
                NodeState = NodeState.Open,
                LinkUrl = "CandidateMList.aspx?layer=3&grade=" + grade + (grade != 0 ? "&corpID=" + User.CorpID : string.Empty),
                Target = "ifrMain",
                IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(2.Cast<ResourceType>(ResourceType.Menu)))
            };
            ParentNode.ChildNodes.Add(nodeThree);

            if (grade == 0) //省公司人员才加正副职节点
            {
                nodePrincipal = new AjaxTreeNode()
                {
                    ID = "21",
                    Text = "正职",
                    Value = "21",
                    Tag = "21",
                    NodeState = NodeState.Open,
                    LinkUrl = "CandidateMList.aspx?isChief=1",
                    Target = "ifrMain",
                    IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(3.Cast<ResourceType>(ResourceType.Menu)))
                };
                nodeTwo.ChildNodes.Add(nodePrincipal);

                nodeDeputy = new AjaxTreeNode()
                {
                    ID = "22",
                    Text = "副职",
                    Value = "22",
                    Tag = "22",
                    NodeState = NodeState.Open,
                    LinkUrl = "CandidateMList.aspx?isChief=0",
                    Target = "ifrMain",
                    IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(3.Cast<ResourceType>(ResourceType.Menu)))
                };
                nodeTwo.ChildNodes.Add(nodeDeputy);
            }
            #endregion

            if (grade != 0) //分公司人员，直接在二，三级经理节点下加分公司名称节点
            {
                AjaxTreeNode newNode;
                Dictionary<string, object> dic = new Dictionary<string, object>();
                dic.Add("ID", User.CorpID);

                Organization model = sOrg.FindOne(dic);
                newNode = CreateNode(model, "2", "0");
                nodeTwo.ChildNodes.Add(newNode);
                
                newNode=CreateNode(model,"3","0");
                nodeThree.ChildNodes.Add(newNode);

                return;
            }

            //三级经理下节点
            string nodeString = System.Configuration.ConfigurationManager.AppSettings["CandidateManagerOrgTreeThree"];
            string[] nodeArr = nodeString.Split(',');
            foreach (var nodeStr in nodeArr)
            {
                AddNodeByParentID(nodeThree, nodeStr,"3");
            }

            //二级经理-副职下节点
            string nodestr = System.Configuration.ConfigurationManager.AppSettings["CandidateManagerOrgTreeTwo"];
            string[] nodeList = nodestr.Split(',');
            foreach (var sNode in nodeList)
            {
                AddNodeByParentID(nodeDeputy, sNode,"2","S");
            }
        }

        //加载
        private void AddNodeByParentID(AjaxTreeNode parentNode,string parentID,string grade,string pre="")
        {
            AjaxTreeNode node;
            Dictionary<string, object> dic = new Dictionary<string, object>();
            dic.Add("ParentID", parentID);

            //先加第一层
            Organization model = sOrg.GetDomain(parentID);
            AjaxTreeNode pNode = CreateNode(model,grade,"1",pre);
            parentNode.ChildNodes.Add(pNode);

            //再加第二层
            List<Organization> orgs = sOrg.FindAll(dic).OrderBy(o => o.SortOrder).ToList();

            foreach (var org in orgs)
            {
                node = CreateNode(org,grade,"0",pre);
                pNode.ChildNodes.Add(node);
            }

        }

        /// <summary>
        /// 创建树节点
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private AjaxTreeNode CreateNode(Organization model,string grade,string parent,string pre="")
        {
            if (model == null) return null;
            return new AjaxTreeNode()
            {
                ID =pre+ model.ID,
                Text = model.Name,
                Value =pre+ model.ID,
                Tag = model.Type.ToString(),
                LinkUrl = string.Format("CandidateMList.aspx?corpID={0}&layer={1}&parent={2}", model.ID, grade, parent),
                Target = "ifrMain",
                IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(model.Type.Cast<ResourceType>(ResourceType.Menu)))
            };
        }

    }
}