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
using SunTek.LAMS.Service;
using SunTek.LAMS.Domain;

namespace WebSite
{
    public partial class CandidateManagerTree : BasePage
    {
        OrganizationService sOrg = new OrganizationService();
        EmployeeService employeeService = new EmployeeService();
        CandidateManagerService candidateManagerService = new CandidateManagerService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                (this.Master as PageMaster).IsShowNavInfo = false;
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
            IList<CandidateManagerEmployee> employeeList = candidateManagerService.GetAllCandidateManager();
            if (employeeList == null) employeeList = new List<CandidateManagerEmployee>();
            AjaxTreeNode nodePrincipal = null; //正职节点
            AjaxTreeNode nodeDeputy = null;//副职节点

            AjaxTree1.PostType = PostType.NoPost;
            AjaxTree1.SelectionMode = SelectionMode.Multiple;

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
                IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(2.Cast<ResourceType>(ResourceType.Page)))
            };
            AjaxTree1.Nodes.Add(ParentNode);



            AjaxTreeNode nodeTwo = new AjaxTreeNode()
            {
                ID = "11",
                Text = "二级经理",
                Value = "11",
                Tag = "11",
                NodeState = NodeState.Open,
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
                    IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(2.Cast<ResourceType>(ResourceType.Menu)))
                };
                nodeTwo.ChildNodes.Add(nodePrincipal);
                IList<CandidateManagerEmployee> emps = employeeList.Where<CandidateManagerEmployee>(q => q.Grade == "二级经理" && q.IsChief == 1).ToList<CandidateManagerEmployee>(); // candidateManagerService.GetEmployee("grade2",1,"");
                if (emps != null)
                {
                    foreach (var emp in emps)
                    {
                        AjaxTreeNode newNode = CreateNode(emp);
                        nodePrincipal.ChildNodes.Add(newNode);
                    }
                }

                nodeDeputy = new AjaxTreeNode()
                {
                    ID = "22",
                    Text = "副职",
                    Value = "22",
                    Tag = "22",
                    NodeState = NodeState.Open,
                    IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(2.Cast<ResourceType>(ResourceType.Menu)))
                };
                nodeTwo.ChildNodes.Add(nodeDeputy);
            }
            #endregion

            if (grade != 0) //分公司人员，直接在二，三级经理节点下加分公司名称节点
            {
                AjaxTreeNode newNode;
                Dictionary<string, object> dic = new Dictionary<string, object>();
                dic.Add("ID", User.CorpID);

                //二级经理
                Organization model = sOrg.FindOne(dic);
                newNode = CreateNode(model, "2", "0", "2_");
                nodeTwo.ChildNodes.Add(newNode);
                addNodeByCorpID(newNode, employeeList, model.ID, "二级经理");

                newNode = CreateNode(model, "3", "0", "3_");
                nodeThree.ChildNodes.Add(newNode);
                addNodeByCorpID(newNode, employeeList, model.ID, "三级经理");

                return;
            }

            //三级经理下节点
            string nodeString = System.Configuration.ConfigurationManager.AppSettings["CandidateManagerOrgTreeThree"];
            string[] nodeArr = nodeString.Split(',');
            foreach (var nodeStr in nodeArr)
            {
                AddNodeByParentID(nodeThree, employeeList, nodeStr, "grade3", 0, "3_");
            }

            //二级经理-副职下节点
            string nodestr = System.Configuration.ConfigurationManager.AppSettings["CandidateManagerOrgTreeTwo"];
            string[] nodeList = nodestr.Split(',');
            foreach (var sNode in nodeList)
            {
                AddNodeByParentID(nodeDeputy, employeeList, sNode, "grade2", 0, "2_");
            }
        }

        /// <summary>
        /// 分公司人员，在二，三级经理节点下加分公司名称节点下直接加人员 
        /// </summary>
        /// <param name="parentNode"></param>
        /// <param name="employeeList"></param>
        /// <param name="corpID"></param>
        /// <param name="grade"></param>
        private void addNodeByCorpID(AjaxTreeNode parentNode, IList<CandidateManagerEmployee> employeeList, string corpID, string grade)
        {
            AjaxTreeNode newNode = null;
            IList<CandidateManagerEmployee> emps = employeeList.Where<CandidateManagerEmployee>(q => q.Grade == grade && q.CorpID == corpID).ToList<CandidateManagerEmployee>();
            if (emps != null)
            {
                foreach (var emp in emps)
                {
                    newNode = CreateNode(emp);
                    parentNode.ChildNodes.Add(newNode);
                }
            }
        }

        //加载
        private void AddNodeByParentID(AjaxTreeNode parentNode, IList<CandidateManagerEmployee> employeeList, string parentID, string grade, int isChief, string pre = "")
        {
            AjaxTreeNode node;
            Dictionary<string, object> dic = new Dictionary<string, object>();
            dic.Add("ParentID", parentID);

            //先加第一层
            Organization model = sOrg.GetDomain(parentID);
            AjaxTreeNode pNode = CreateNode(model, grade, "1", pre);
            parentNode.ChildNodes.Add(pNode);

            //再加第二层
            List<Organization> orgs = sOrg.FindAll(dic).OrderBy(o => o.SortOrder).ToList();

            foreach (var org in orgs)
            {
                node = CreateNode(org, grade, "0", pre);
                pNode.ChildNodes.Add(node);
                //IList<Employee> emps = candidateManagerService.GetEmployee(grade, isChief, org.ID);
                IList<CandidateManagerEmployee> emps = employeeList.Where<CandidateManagerEmployee>(q => q.Grade == (grade == "grade2" ? "二级经理" : "三级经理") && q.IsChief == isChief && q.CorpID == org.ID).ToList<CandidateManagerEmployee>();
                if (emps != null)
                {
                    foreach (var emp in emps)
                    {
                        AjaxTreeNode newNode = CreateNode(emp);
                        node.ChildNodes.Add(newNode);
                    }
                }
            }

        }

        /// <summary>
        /// 创建树节点
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private AjaxTreeNode CreateNode(Organization model, string grade, string parent, string pre = "")
        {
            if (model == null) return null;
            return new AjaxTreeNode()
            {
                ID = pre + model.ID,
                Text = model.Name,
                Value = model.ID,
                LinkUrl = "#",
                Tag = model.Type.ToString(),
                IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(2.Cast<ResourceType>(ResourceType.Menu)))
            };
        }

        /// <summary>
        /// 创建树节点
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private AjaxTreeNode CreateNode(CandidateManagerEmployee model, string pre = "")
        {
            if (model == null) return null;
            return new AjaxTreeNode()
            {
                ID = pre + model.ID,
                Text = model.Name,
                Value = model.ID,
                LinkUrl = "#",
                ShowCheckBox = true,
                //Tag = model.Type.ToString(),
                IcoSrc = string.Format("{0}Skins/{1}/Images/{2}", WebUtil.GetRootPath(), Skin, getResourceIcon(3.Cast<ResourceType>(ResourceType.Menu)))
            };
        }

    }
}