using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.Security;
using System.Reflection;
using System.Configuration;
using System.Data;

using log4net;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using EAFrame.Core;
using EAFrame.Core.FastInvoker;
using EAFrame.Core.Extensions;
using EAFrame.Core.Enums;
using EAFrame.Core.Authentication;
using EAFrame.Core.Utility;
using EAFrame.Core.Web;
using EAFrame.Core.Domain;
using EAFrame.Core.Service;
using EAFrame.WebControls;
using SunTek.EAFrame.Infrastructure.Domain;
using SunTek.EAFrame.Infrastructure.Service;
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;

using EIAC.SSO.PSO;

namespace WebSite
{
    public class BasePage : Page
    {
        protected ILog log = LogManager.GetLogger(typeof(BasePage));
        protected static PageContextStore contextStore = PageContextStore.Database;

        public new User User
        {
            get
            {
                if (Session[ApplicationContext.CurrentUserKey] == null)
                {
                    if (ConfigurationManager.AppSettings["RunMode"].Equals("Debug", StringComparison.OrdinalIgnoreCase))
                    {
                        User user = new User()
                        {
                            ID = "UR1500028529",
                            LoginName = "shengp",
                            Name = "沈国萍",
                            Skin = "Default",
                            OrgID = "OR1200001684",
                            CorpID = "OR1000000001",
                            OrgPath = new OrganizationService().GetOrgPath("OR1200001684"),
                            UserType = (short)UserType.Administrator
                        };

                        Session[ApplicationContext.CurrentUserKey] = user;
                        return user;
                    }

                    #region 单点登录

                    //如果没有经过SSO认证，则转向SSO进行统一认证
                    if (Request["IASID"] == null)
                    {
                        if (AppSSOBLL.TOEACAuthenticat(InterfaceUtility.GetIASID(), AppSSOBLL.GetTimeStamp(), Request.Url.ToString(), ""))
                        {
                            //todo    ;                
                        }
                    }

                    //接受EAC发送回来的认证信息,如果通过定位到保护页面
                    if (Request["IASID"] != null)
                    {
                        if (Request["Result"].ToString() == "0")
                        {
                            //验证EAC发回的信息
                            if (AppSSOBLL.ValidateFromEAC(Request["IASID"].ToString(), Request["TimeStamp"].ToString(), Request["UserAccount"].ToString(), Request["Result"].ToString(), Request["ErrorDescription"].ToString(), Request["Authenticator"].ToString()))
                            {
                                string account = Request["UserAccount"].ToString();
                                IDictionary<string, object> parameter = new Dictionary<string, object>();
                                parameter.Add("LoginName", account);
                                Employee employee = new EmployeeService().FindOne(parameter);
                                if (employee != null)
                                {
                                    Operator operatorInfo = new OperatorService().FindOne(parameter);
                                    parameter.Clear();
                                    parameter.SafeAdd("EmployeeID", employee.ID);
                                    IList<EmployeeOrg> orgs = new EmployeeOrgService().FindAll(parameter);
                                    string orgID = (orgs.FirstOrDefault(o => o.IsMajor == 1) ?? orgs[0]).OrgID;

                                    User user = new User()
                                    {
                                        ID = employee.ID,
                                        LoginName = employee.LoginName,
                                        Name = employee.Name,
                                        CorpID = employee.CorpID,
                                        Skin = operatorInfo.Skin ?? "Default",
                                        OrgID = orgID,
                                        UserType = operatorInfo.UserType,
                                        OrgPath = new OrganizationService().GetOrgPath(orgID)
                                    };

                                    //todo: 临时
                                    //para.Clear();
                                    //para.SafeAdd("ID", User.ID);
                                    //Operator operatorInfo = new OperatorService().FindOne(para);
                                    //user.UserType = operatorInfo == null ? (short)UserType.Administrator : operatorInfo.UserType;
                                    // user.UserType = (short)UserType.Administrator;

                                    //设置验证Cookie
                                    // FormsAuthentication.SetAuthCookie(Request["UserAccount"], false);

                                    //将用户重定向到访问的页面
                                    FormsAuthentication.RedirectFromLoginPage(Request["UserAccount"], false);
                                    Session[ApplicationContext.CurrentUserKey] = user;
                                }

                                #region 将EAC返回的IACToken保存起来
                                //IASToken token = new IASToken();
                                //token.Authenticator = Request["Authenticator"].ToString();
                                //token.ErrorDescription = Request["ErrorDescription"].ToString();
                                //token.IASID = Request["IASID"].ToString();
                                //token.Result = Request["Result"].ToString();
                                //token.TimeStamp = Request["TimeStamp"].ToString();
                                //token.UserAccount = Request["UserAccount"].ToString();
                                //token.ip = Request.UserHostAddress;
                                ////进行本地IAS的处理
                                //UserLoginer.SetIAS(token);

                                #endregion
                            }
                        }
                    }


                    #endregion

                }
                return Session[ApplicationContext.CurrentUserKey] as User;
            }
            set
            {
                Session[ApplicationContext.CurrentUserKey] = value;
            }
        }

        public string Skin
        {
            get
            {
                return (User ?? new User() { Skin = "Default" }).Skin;
            }
        }

        public string AppID
        {
            get
            {
                return new SysParamService().GetSysParamValue<string>("AppID");
            }
        }

        #region IAuthorize 成员

        public virtual bool Authorize(User user, string requestUrl)
        {
            return Authorize(user, requestUrl, true);
        }

        public virtual bool Authorize(User user, string requestUrl, bool isForce)
        {
            if (user == null)
            {
                if (!Request.Url.AbsolutePath.ToLower().EndsWith("Default.aspx"))
                {
                    StringBuilder script = new StringBuilder();

                    script.AppendLine("<script language='javascript'>");
                    script.AppendLine("document.close();window.parent.opener = null;window.opener = null;window.close();");
                    script.AppendFormat("window.open('{0}Login.aspx','_blank');\n", RootPath);
                    script.AppendLine("</script>");
                    Response.Write(script);
                    Response.Flush();
                    Response.End();
                    return false;
                }

                Server.Transfer(string.Format("{0}Login.aspx", WebUtil.GetRootPath()));
            }

            if (!isForce) return true;

            if (user.UserType == (short)UserType.Administrator) return true;

            #region 页面权限验证  ljz 添加
            //取得用户的角色
            List<string> privilegeIDs = new OperatorService().GetPrivilegeIDs(User.ID);
            //根据权限id取到资源id集合
            IList<string> resIDs = new PrivilegeService().All().Where(o => privilegeIDs.Contains(o.ID)).Select(o => o.ResourceID).ToList();
            //获取有权限的资源实体集合，判断当前的url是不是在资源实体集合里边
            return new ResourceService().All().FirstOrDefault(r => string.Equals(r.URL, requestUrl, StringComparison.OrdinalIgnoreCase) && resIDs.Contains(r.ID)) != null;

            #endregion
        }


        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            if (!IsPostBack && !Authorize(User, WebUtil.GetRequestFullUrl()))
            {
                Response.Write(string.Format("对不起，您没有访问{0}权限！请联系管理员", Request.Url.ToSafeString()));
                Response.Write(WebUtil.GetRequestFullUrl());
                Response.End();
            }

            //恢复页面上下文对象
            pageContext = RestorePageContext();
            if (pageContext == null) pageContext = NewPageContext();

            string actionFlag = Request.QueryString["ActionFlag"];
            try
            {
                if (!string.IsNullOrEmpty(actionFlag))
                {
                    pageContext.Action = (ActionType)Enum.Parse(typeof(ActionType), actionFlag);
                }

                pageContext.Runat = Request.QueryString["Runat"].ToShort(0);

                string lastUrl = Request.QueryString["LastUrl"];
                if (!string.IsNullOrEmpty(lastUrl))
                    pageContext.LastUrl = lastUrl;
                else if (string.IsNullOrEmpty(pageContext.LastUrl))
                    pageContext.LastUrl = Request.Url.PathAndQuery;

                string currentId = CurrentId;
                if (currentId != null && !string.IsNullOrEmpty(currentId.ToSafeString()))
                    pageContext.CurrentId = currentId;
                else
                    CurrentId = pageContext.CurrentId;

                if (!IsPostBack && string.IsNullOrEmpty(Request.Form["ajaxPost"]))
                    SavePageContext(pageContext);
            }
            catch (Exception ex)
            {
                log.Error(string.Format("字符串{0}转换为{1}时出错", actionFlag, "ActionType类型"), ex);
            }
        }

        #endregion

        public bool IsAjaxPost
        {
            get
            {
                return !string.IsNullOrWhiteSpace(Request.QueryString["AjaxAction"]);
            }
        }

        private string currentId = string.Empty;
        public string CurrentId
        {
            get
            {
                currentId = !string.IsNullOrWhiteSpace(Request["CurrentId"]) ? Request["CurrentId"] : Request.Form["hidCurrentId"];
                if (string.IsNullOrEmpty(currentId))
                {
                    HidTextBox hidCurrentId = this.FindControl("hidCurrentId") as HidTextBox;
                    if (hidCurrentId != null && !string.IsNullOrWhiteSpace(hidCurrentId.Value))
                    {
                        currentId = hidCurrentId.Value;
                    }
                    else
                    {
                        currentId = IdGenerator.NewComb().ToSafeString();
                    }
                }
                return currentId;
            }
            set
            {
                HidTextBox hidCurrentId = this.FindControl("hidCurrentId") as HidTextBox;
                if (hidCurrentId != null) hidCurrentId.Value = value;
            }
        }


        /// <summary>
        /// 页面上下文对象
        /// </summary>
        private PageContext<string> pageContext;
        public virtual PageContext<string> PageContext
        {
            get
            {
                if (pageContext == null)
                {
                    pageContext = NewPageContext();
                }
                return pageContext;
            }
            set
            {
                pageContext = value;
            }
        }

        protected override void Render(HtmlTextWriter writer)
        {
            string ajaxArgument = Request.Form["AjaxArgument"];
            string ajaxAction = Request.Form["AjaxAction"];
            if (!string.IsNullOrEmpty(ajaxAction))
            {
                try
                {
                    Type type = this.Page.GetType();
                    MethodInfo methodInfo;
                    try
                    {
                        methodInfo = type.GetMethod(ajaxAction, new Type[] { typeof(string) });
                    }
                    catch
                    {
                        methodInfo = type.GetMethod(ajaxAction);
                    }
                    if (methodInfo == null)
                    {
                        methodInfo = type.GetMethod(ajaxAction);
                    }
                    FastInvokeHandler invoker = BaseMethodInvoker.GetMethodInvoker(methodInfo);
                    object result = invoker(this.Page, new object[] { ajaxArgument });

                    if (result != null)
                        writer.Write(result.ToString());
                }
                catch (Exception ex)
                {
                    log.Error("Execute AjaxAction {0} Error!", ex);
                }
            }
            else
            {
                base.Render(writer);
            }
        }

        /// <summary>
        /// 新建上下页面上下文对象
        /// </summary>
        /// <returns></returns>
        protected PageContext<string> NewPageContext()
        {
            string lastUrl = Request.QueryString["LastUrl"];

            pageContext = new PageContext<string>();
            pageContext.LastUrl = string.IsNullOrEmpty(lastUrl) ? Request.Url.PathAndQuery : lastUrl;
            pageContext.Action = ActionType.Other;
            pageContext.CurrentId = CurrentId;

            return pageContext;
        }

        /// <summary>
        /// 写异常日志,不进行提示。
        /// </summary>
        /// <param name="actionMessage"></param>
        /// <param name="exception"></param>
        protected void WriteErrorLog(string actionMessage, Exception exception)
        {
            log.Error(actionMessage, exception);
        }
        /// <summary>
        /// 读Cookie值
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        protected string ReadCookie(string key)
        {
            HttpCookie cookie = Request.Cookies[key];

            return cookie == null ? string.Empty : Server.UrlDecode(cookie.Value);
        }

        /// <summary>
        /// 写Cookie值
        /// </summary>
        /// <param name="key"></param>
        /// <param name="value"></param>
        protected void WriteCookie(string key, string value)
        {
            HttpCookie cookie = new HttpCookie(key, Server.UrlEncode(value));
            Response.Cookies.Add(cookie);
        }


        /// <summary>
        /// 写Cookie值
        /// </summary>
        /// <param name="key"></param>
        /// <param name="value"></param>
        protected void WriteCookie(string key, string value, string controlType)
        {
            HttpCookie cookie = new HttpCookie(key);
            cookie[key] = Server.UrlEncode(value);
            cookie["controlType"] = controlType;
            Response.Cookies.Add(cookie);
        }

        /// <summary>
        /// 读Cookie值
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        protected string ReadCookie(string key, out string controlType)
        {
            HttpCookie cookie = Request.Cookies[key];
            controlType = cookie == null ? string.Empty : cookie["controlType"];
            return cookie == null ? string.Empty : Server.UrlDecode(cookie[key]);
        }

        /// <summary>
        /// 给页面表单对象赋值
        /// </summary>
        /// <param name="entity">要赋值的对象</param>
        protected virtual void SetControlValues<T>(T entity) where T : class, new()
        {
            //获取模板页的内容容器对象
            Control parent = ((Page.Master != null) ? Page.Master.FindControl("contentPlace") : this) ?? this;
            if (entity == null) return;
            Type type = entity.GetType();//获取类型
            var pi = (from p in type.GetProperties() where ((p.PropertyType.Equals(typeof(string)) || p.PropertyType.IsValueType) && !p.Name.Equals("TableName")) select p).ToArray<PropertyInfo>();//获取属性集合
            foreach (PropertyInfo p in pi)
            {
                try
                {
                    string controlName = getControlName(p.Name, p.PropertyType);

                    object propertyValue = p.GetValue(entity, null);//获取属性值
                    object value = p.PropertyType == typeof(DateTime) && propertyValue != null ? ((DateTime)propertyValue).ToShortDateString() : propertyValue;

                    Control control = parent.FindControl(controlName);
                    //判断是不是userid，如果是显示中文名
                    if (p.Name.Equals("Creator", StringComparison.OrdinalIgnoreCase))
                    {
                        Operator operatorInfo = new OperatorService().GetDomain((string)value);
                        value = operatorInfo == null ? User.Name : operatorInfo.UserName;
                    }


                    if (control != null && value != null)
                    {
                        if (control is ComboBox)
                        {
                            ((ComboBox)control).Value = value.ToSafeString().Trim();
                        }
                        if (control is Combox)
                        {
                            ((Combox)control).SelectedValue = value.ToSafeString();
                        }
                        else if (control is DropDownList)
                        {
                            DropDownList ddlControl = ((DropDownList)control);
                            ddlControl.SelectedIndex = ddlControl.IndexOfByValue(value.ToSafeString().Trim());
                        }
                        else if (control is TextBox)
                        {
                            ((TextBox)control).Text = value.ToString().Trim();
                        }
                        else if (control is HtmlInputText)
                        {
                            ((HtmlInputText)control).Value = value.ToString().Trim();
                        }
                        else if (control is RadioButtonList)
                        {
                            RadioButtonList rblControl = ((RadioButtonList)control);
                            rblControl.IndexOfByValue(value.ToString().Trim());
                        }
                    }
                    else
                    {
                        controlName = string.Format("txt{0}", p.Name);
                        control = parent.FindControl(controlName);
                        if (control != null && value != null)
                        {
                            //string text = (value != null && p.PropertyType == typeof(DateTime)) ? ((DateTime)value).ToShortDateString() : value.ToSafeString();
                            if (control is TextBox)
                            {
                                ((TextBox)control).Text = value.ToString().Trim();
                            }
                            else if (control is HtmlInputText)
                            {
                                ((HtmlInputText)control).Value = value.ToString().Trim();
                            }
                        }
                        else
                        {
                            controlName = string.Format("rbl{0}", p.Name);
                            control = parent.FindControl(controlName);
                            if (control != null && value != null)
                            {
                                if (control is RadioButtonList)
                                {
                                    RadioButtonList rblControl = ((RadioButtonList)control);
                                    rblControl.SelectedIndex = rblControl.IndexOfByValue(value.ToString().Trim());
                                }
                            }
                            else
                            {
                                controlName = string.Format("ddl{0}", p.Name);
                                control = parent.FindControl(controlName);
                                if (control != null && value != null)
                                {
                                    if (control is DropDownList)
                                    {
                                        DropDownList ddlControl = ((DropDownList)control);
                                        ddlControl.SelectedIndex = ddlControl.IndexOfByValue(value.ToString().Trim());
                                    }
                                }
                                else
                                {
                                    controlName = string.Format("cbo{0}", p.Name);
                                    control = parent.FindControl(controlName);
                                    if (control != null && value != null)
                                    {
                                        if (control is ComboBox)
                                        {
                                            ComboBox cboControl = ((ComboBox)control);
                                            cboControl.Value = value.ToSafeString().Trim();
                                        }
                                    }
                                    else
                                    {
                                        controlName = string.Format("dtp{0}", p.Name);
                                        control = parent.FindControl(controlName);
                                        if (control != null && value != null)
                                        {
                                            if (control is DatePicker)
                                            {
                                                DatePicker cboControl = ((DatePicker)control);
                                                cboControl.Text = value.ToSafeString().Trim();
                                            }
                                        }
                                    }
                                }
                                log.Debug(string.Format("Can't set entity {0} property {1} value {2}!", type, p.Name, value));
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    log.Error(ex);
                }
            }
        }

        /// <summary>
        /// 获取表单赋值的实体对象
        /// </summary>
        /// <returns>获取自动赋值的实体对象</returns>
        protected virtual void GetControlValues<T>(ref T entity) where T : class, new()
        {
            NameValueCollection form = Request.Form;
            string parentUniqueID = string.Empty;
            if (Page.Master != null)
            {
                Control parent = Page.Master.FindControl("contentPlace");
                if (parent != null)
                    parentUniqueID = string.Format("{0}$", parent.UniqueID);
            }

            Type type = entity.GetType();//获取类型
            var pi = (from p in type.GetProperties() where ((p.PropertyType.Equals(typeof(string)) || p.PropertyType.IsValueType) && !p.Name.Equals("TableName")) select p).ToArray<PropertyInfo>();//获取属性集合
            foreach (PropertyInfo p in pi)
            {

                if (p.Name.Equals("ID", StringComparison.OrdinalIgnoreCase)) continue;

                string controlName = string.Format("{0}{1}", parentUniqueID, getControlName(p.Name, p.PropertyType));
                if (form[controlName] != null)
                {
                    try
                    {
                        if (!string.Equals(p.Name, "Creator"))
                        {
                            p.SetValue(entity, Convert.ChangeType(form[controlName], p.PropertyType), null);//为属性赋值，并转换键值的类型为该属性的类型
                        }
                        else if (PageContext.Action == ActionType.Add)
                        {
                            p.SetValue(entity, User.ID, null);//为属性赋值，并转换键值的类型为该属性的类型
                        }
                    }
                    catch (Exception ex)
                    {
                        log.Error(string.Format("Entity {0} Set Property  {1}  Value Error!", typeof(T), controlName), ex);
                    }
                }
                else
                {
                    controlName = string.Format("{0}txt{1}", parentUniqueID, p.Name);
                    if (form[controlName] == null)
                    {
                        controlName = string.Format("{0}rbl{1}", parentUniqueID, p.Name);
                        if (form[controlName] == null)
                        {
                            controlName = string.Format("{0}ddl{1}", parentUniqueID, p.Name);
                            if (form[controlName] == null)
                            {
                                controlName = string.Format("{0}dtp{1}", parentUniqueID, p.Name);
                                if (form[controlName] == null)
                                {
                                    controlName = string.Format("{0}chb{1}", parentUniqueID, p.Name);
                                    if (form[controlName] == null)
                                    {
                                        controlName = string.Format("{0}cbo{1}", parentUniqueID, p.Name);
                                    }
                                }
                            }
                        }
                    }
                    if (form[controlName] != null)
                    {
                        try
                        {
                            p.SetValue(entity, Convert.ChangeType(form[controlName], p.PropertyType), null);//为属性赋值，并转换键值的类型为该属性的类型
                        }
                        catch (Exception ex)
                        {
                            log.Error(string.Format("Entity {0} Set Property  {1}  Value Error!", typeof(T), controlName), ex);
                        }
                    }
                    else
                    {
                        log.Error(string.Format("Entity {0} Can't Get Property  {1}  Value !", typeof(T), controlName));
                    }
                }
            }
        }

        /// <summary>
        /// 按控件命名规范获取控件名称
        /// </summary>
        /// <param name="propertyName">属性名称</param>
        /// <param name="propertyType">属性类型</param>
        /// <returns></returns>
        private string getControlName(string propertyName, Type propertyType)
        {
            if (propertyType == typeof(DateTime))
            {
                return string.Format("dtp{0}", propertyName);
            }
            else if (propertyName.EndsWith("Code") || (propertyName.EndsWith("ID") && !propertyName.Equals("ID", StringComparison.OrdinalIgnoreCase)))
            {
                return string.Format("chb{0}", propertyName);
            }

            if (propertyType == typeof(short) || propertyType == typeof(Int16))
                return string.Format("cbo{0}", propertyName);

            return string.Format("txt{0}", propertyName);
        }

        /// <summary>
        /// 保存当前页上下文信息
        /// </summary>
        /// <param name="context">页面上下文对象</param>
        public virtual void SavePageContext(PageContext<string> context)
        {
            string currentId = CurrentId;
            if (currentId != null && !string.IsNullOrEmpty(currentId.ToSafeString()))
                context.CurrentId = currentId;

            if (contextStore == PageContextStore.Cookie)
            {
                WriteCookie("PageContextKey", JsonConvert.SerializeObject(context));
                return;
            }

        }

        /// <summary>
        /// 恢复当前页上下文信息
        /// </summary>
        /// <returns></returns>
        public virtual PageContext<string> RestorePageContext()
        {
            return NewPageContext();
        }

        /// <summary>
        /// 获取查询条件
        /// </summary>
        /// <returns>返回查询条件的字典对象，</returns>
        protected virtual IDictionary<string, object> GetFilterParameters()
        {
            //获取模板页的内容容器对象
            Control parent = parent = ((Page.Master != null) ? Page.Master.FindControl("contentPlace") : this) ?? this;

            if (parent == null) return null;

            IDictionary<string, object> filterParameters = new Dictionary<string, object>();
            foreach (Control control in parent.Controls)
            {
                if (string.IsNullOrEmpty(control.ID)) continue;

                string controlId = control.ID;
                if (controlId.StartsWith(ApplicationContext.StartFilter))
                {
                    //约定查询控件的ID="filter"+查询对象的属性名
                    //约定smallint类型的属性对应的控件为DropDownList
                    //获取查询的属性名
                    string propertyName = controlId.Substring(ApplicationContext.StartFilter.Length);
                    if (control is DropDownList)
                    {
                        short value = -1;

                        if (short.TryParse(((DropDownList)control).SelectedValue, out value))
                        {
                            if (value != -1)
                                filterParameters.Add(propertyName, value);
                        }
                        else
                        {
                            filterParameters.Add(propertyName, ((DropDownList)control).SelectedValue);
                        }
                    }
                    else if (control is TextBox)
                    {
                        string value = ((TextBox)control).Text.Trim();
                        if (!string.IsNullOrEmpty(value))
                            filterParameters.Add(propertyName, value);
                    }
                    else if (control is HtmlInputText)
                    {
                        string value = ((HtmlInputText)control).Value;
                        if (!string.IsNullOrEmpty(value))
                            filterParameters.Add(propertyName, value);
                    }
                    else if (control is RadioButtonList)
                    {
                        filterParameters.Add(propertyName, ((RadioButtonList)control).SelectedValue.ToShort());
                    }
                }
            }

            return filterParameters;
        }

        protected virtual void SetFilterControlValues(IDictionary<string, object> filter)
        {
            Control parent = ((Page.Master != null) ? Page.Master.FindControl("contentPlace") : this) ?? this;
            foreach (KeyValuePair<string, object> keyValuePair in filter)
            {
                string controlName = "filter" + keyValuePair.Key;
                Control control = parent.FindControl(controlName);
                object value = keyValuePair.Value;
                if (control != null && value != null)
                {
                    if (control is ComboBox)
                    {
                        ((ComboBox)control).Value = value.ToSafeString();
                    }
                    else if (control is DropDownList)
                    {
                        DropDownList ddlControl = ((DropDownList)control);
                        ddlControl.SelectedIndex = ddlControl.IndexOfByValue(value.ToSafeString());
                    }
                    else if (control is TextBox)
                    {
                        ((TextBox)control).Text = value.ToString();
                    }
                    else if (control is HtmlInputText)
                    {
                        ((HtmlInputText)control).Value = value.ToString();
                    }
                    else if (control is RadioButtonList)
                    {
                        RadioButtonList rblControl = ((RadioButtonList)control);
                        rblControl.IndexOfByValue(value.ToString());
                    }
                }
            }

        }


        /// <summary>
        /// 把Json数据赋值给对象
        /// </summary>
        /// <param name="jsonData"></param>
        /// <returns></returns>
        protected T DeserializeObject<T>(string id, string jsonData) where T : DomainObject<string>, new()
        {
            IDictionary<string, object> propertyValues = JsonConvert.DeserializeObject<IDictionary<string, object>>(jsonData);

            T entity = new BaseService<string, T>().GetDomain(id);
            if (entity != null)
            {
                PropertyInfo[] perperties = typeof(T).GetProperties();
                foreach (KeyValuePair<string, object> valuePair in propertyValues)
                {
                    if (!valuePair.Key.Equals("ID", StringComparison.OrdinalIgnoreCase) && valuePair.Value != null)
                    {
                        var pi = perperties.FirstOrDefault(o => o.Name.Equals(valuePair.Key));
                        if (pi != null)
                        {
                            try
                            {
                                pi.SetValue(entity, Convert.ChangeType(valuePair.Value, pi.PropertyType), null);
                            }
                            catch (Exception ex)
                            {
                                log.Error(string.Format("Property {0} set value {1} Error!", pi.Name, valuePair.Value), ex);
                            }
                        }
                    }
                }
            }
            else
            {
                entity = JsonConvert.DeserializeObject<T>(jsonData);
            }

            if (string.IsNullOrEmpty(entity.ID.ToSafeString())) entity.ID = id;

            return entity;
        }


        /// <summary>
        /// 添加用户操作日志
        /// </summary>
        /// <param name="module">模块名称</param>
        /// <param name="entity">业务对象</param>
        /// <param name="actionType">操作类型：增，删，改，查，登陆等</param>
        /// <param name="actionResult">操作结果</param>
        /// <param name="message">操作信息</param>
        public void AddActionLog<T>(string module, T entity, ActionType actionType, ActionResult actionResult, string actionMessage) where T : class, new()
        {
            ActionLog actionLog = new ActionLog();
            //DomainObject<string> value = entity as DomainObject<string> ?? new DomainObject<string>();
            actionLog.Result = (short)actionResult;
            actionLog.LogType = (short)actionType;
            actionLog.ID = IdGenerator.NewComb().ToString();
            actionLog.UserID = User.ID;
            actionLog.UserName = User.LoginName;
            actionLog.Message = actionMessage;
            actionLog.CreateTime = DateTime.Now;
            actionLog.AppModule = module;
            actionLog.ClientIP = WebUtil.GetClientIP();
            try
            {
                new ActionLogService().Add(actionLog);
            }
            catch (Exception ex)
            {
                log.Error("添加日志出错", ex);
            }
        }

        /// <summary>
        /// 添加用户操作日志
        /// </summary>
        /// <param name="entity">业务对象</param>
        /// <param name="actionType">操作类型：增，删，改，查，登陆等</param>
        /// <param name="actionResult">操作结果</param>
        /// <param name="actionMessage">操作信息</param>
        public void AddActionLog<T>(T entity, ActionType actionType, ActionResult actionResult, string actionMessage) where T : class, new()
        {
            AddActionLog(entity.GetType().Assembly.FullName.Split(',')[0], entity, actionType, actionResult, actionMessage);
        }

        /// <summary>
        /// 清除显示界面显示控件的值
        /// </summary>
        protected virtual void ClearValues(Type type)
        {
            //获取模板页的内容容器对象
            Control parent = ((Page.Master != null) ? Page.Master.FindControl("contentPlace") : this) ?? this;

            var pi = (from p in type.GetProperties() where ((p.PropertyType.Equals(typeof(string)) || p.PropertyType.IsValueType) && !p.Name.Equals("TableName")) select p).ToArray<PropertyInfo>();//获取属性集合

            foreach (PropertyInfo p in pi)
            {
                string controlName = getControlName(p.Name, p.PropertyType);

                Control control = parent.FindControl(controlName);

                if (control != null)
                {
                    if (control is TextBox)
                    {
                        ((TextBox)control).Text = string.Empty;
                    }
                    else if (control is HtmlInputText)
                    {
                        ((HtmlInputText)control).Value = string.Empty;
                    }
                }
                else
                {
                    controlName = string.Format("txt{0}", p.Name);
                    control = parent.FindControl(controlName);
                    if (control != null)
                    {
                        if (control is TextBox)
                        {
                            ((TextBox)control).Text = string.Empty;
                        }
                        else if (control is HtmlInputText)
                        {
                            ((HtmlInputText)control).Value = string.Empty;
                        }
                    }
                    else
                    {
                        log.Debug(string.Format("Can't clear control {0}'s value!", controlName));
                    }
                }
            }
        }

        /// <summary>
        /// 网站虚拟根路径
        /// </summary>
        public string RootPath
        {
            get
            {
                return WebUtil.GetRootPath();
            }
        }

        /// <summary>
        /// 获取数据过滤的sql
        /// </summary>
        /// <param name="filterField">数据关联字段</param>
        /// <returns>o（）</returns>
        public string GetFilterString(string filterField)
        {
            if (User.UserType == (short)UserType.Administrator) return string.Empty;

            List<string> dataPriveleges = new OperatorService().GetDataPriveleges(User.ID);

            //组织过滤字符串
            string filterStr = string.Join(" or ", dataPriveleges.Select(dataPrivelege => string.Format("{0} like '{1}%'", filterField, dataPrivelege)).ToArray());

            return string.Format("({0} {1} creator='{2}') ", filterStr, string.IsNullOrEmpty(filterStr) ? string.Empty : "or", User.ID);
        }


        /// <summary>
        /// 获取过滤的sql片段
        /// </summary>
        /// <returns>o（）</returns>
        public string GetFilterString()
        {
            return GetFilterString("OwnerOrg");
        }

        /// <summary>
        /// 获取字典项值
        /// </summary>
        /// <param name="dictItemID"></param>
        /// <returns></returns>
        public DictItem GetDictItem(string dictItemID)
        {
            return new DictItemService().GetDomain(dictItemID) ?? new DictItem();
        }

        /// <summary>
        /// 获取人员所在部门名称
        /// </summary>
        /// <param name="dictItemID"></param>
        /// <returns></returns>
        public Organization GetOrgNameByUserID(string userID)
        {
            IList<Organization> orgs = new OrganizationService().GetOrgNameByUserID(userID);
            if (orgs != null)
            {
                foreach (var org in orgs) //如有多个部门，返回第一个
                {
                    return org;
                }
            }
            return new Organization();
        }
    }
}
