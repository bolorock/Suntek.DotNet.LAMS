using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using System.Data;

using log4net;
using EAFrame.Core.FastInvoker;
using EAFrame.Core;
using EAFrame.Core.Authentication;
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;
using EAFrame.Core.Web;
using EAFrame.Core.Extensions;
using EAFrame.Core.Utility;
using EAFrame.WebControls;
using EAFrame.Core.Enums;
using System.Text;

namespace WebSite
{
    public partial class PageMaster : BaseMasterPage
    {
        StringBuilder sbNavi = new StringBuilder();
        #region Properties
        // <summary>
        /// 系统日志对象
        /// </summary>
        protected ILog log = LogManager.GetLogger(typeof(User));

        public User User
        {
            get
            {
                return Session.Get<User>(ApplicationContext.CurrentUserKey);
            }
        }

        public string Skin
        {
            get
            {
                string skin = User.Skin;
                if (ApplicationContext.Skins.ContainsKey(skin))
                    return ApplicationContext.Skins[skin];

                return ApplicationContext.DefaultSkin;
            }
        }

        private bool isShowNavInfo = true;
        public bool IsShowNavInfo
        {
            get
            {
                return isShowNavInfo;
            }
            set
            {
                isShowNavInfo = value;
            }
        }


        #endregion

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            commandBar.CommandExecute += new CommandBar.CommandExecuteEventHandler(commandBar_CommandExecute);
        }

        /// <summary>
        /// 调用操作按钮执行方法
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void commandBar_CommandExecute(object sender, CommandExecuteEventArgs e)
        {
            try
            {
                object[] args = { e.CommandArgument };
                Type type = this.Page.GetType();
                MethodInfo methodInfo = type.GetMethod(e.CommandName);
                FastInvokeHandler invoker = BaseMethodInvoker.GetMethodInvoker(methodInfo);
                invoker(this.Page, args);
            }
            catch (Exception ex)
            {
                log.Error(ex.Message, ex);

                WebUtil.PromptMsg(string.Format("按钮触发{0}出错！", e.CommandName));
            }
        }

        /// <summary>
        /// 加载页面操作按钮
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void loadCommandBar()
        {
            string appPath = HttpContext.Current.Request.ApplicationPath;
            string requestUrl = Request.Url.AbsolutePath.Remove(0, appPath.Length).TrimStart("/".ToCharArray());
            string entry = Request.QueryString["Entry"].ToSafeString();

            Resource resource = new ResourceService().All().FirstOrDefault(r => r.URL.EqualIgnoreCase(requestUrl) && r.Entry.EqualIgnoreCase(entry));
            if (resource == null) return;

            #region 页面操作权限验证 ljz 添加
            //取得用户的角色
            List<string> privilegeIDs = new OperatorService().GetPrivilegeIDs(User.ID);
            //根据权限id取到操作项id集合
            List<string> operateIds = new PrivilegeService().All().Where(p => p.ResourceID == resource.ID && !string.IsNullOrWhiteSpace(p.OperateID) && (User.UserType == (short)UserType.Administrator || privilegeIDs.Contains(p.ID))).Select(p => p.OperateID).ToList() ?? new List<string>();

            #endregion



            IList<Operate> operates = new OperateService().All().Where(o => operateIds.Contains(o.ID)).ToList();//UserBiz.GetAuthorizeActions(User, requestUrl, entry);
            foreach (Operate operate in operates)
            {
                CommandItem item = new CommandItem();
                item.Text = operate.OperateName;
                item.CommandName = operate.CommandName;
                item.CommandArgument = operate.CommandArgument;
                item.OnClientClick = operate.CommandName;
                item.Runat = operate.Runat;
                item.DoValid = operate.IsVerify == 1;

                commandBar.Items.Add(item);
            }
        }
        //加载页面导航信息
        private void loadNaviInfo()
        {
            if (isShowNavInfo)
            {
                string appPath = HttpContext.Current.Request.ApplicationPath;
                string requestUrl = Request.Url.AbsolutePath.Remove(0, appPath.Length).TrimStart("/".ToCharArray());
                string entry = Request.QueryString["Entry"].ToSafeString();

                List<Resource> navResources = new ResourceService().All().Where(r => r.Type == (short)(int)ResourceType.Menu || r.Type == (short)(int)ResourceType.Page).ToList();
                Resource resource = navResources.FirstOrDefault(r => r.URL == requestUrl && string.Equals(r.Entry, entry, StringComparison.OrdinalIgnoreCase));

                if (resource == null) return;
                var func = ExpressionUtil.MakeRecursion<List<Resource>, Resource, string>(f => (all, r) => { Resource parent = all.FirstOrDefault(a => a.ID == r.ParentID); return parent == null ? r.Text : string.Format("{0}>>{1}", f(all, parent), r.Text); });
                divNav.InnerHtml = "<img src='../Skins/Default/Images/aico_direct.gif' /><label style=' font-weight:bold;color:#696969'>当前位置：" + func(navResources, resource) + "</label>";
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(Request.QueryString["AjaxAction"]))
            {
                //加载页面操作按钮
                loadCommandBar();
                //加载页面导航信息
                loadNaviInfo();
            }
        }
    }
}
