
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="OperatorDetail.aspx.cs" Inherits="WebSite.OperatorDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
	<%= WebExtensions.CombresLink(Skin+"SiteCss") %>
	<%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("DetailJs") %>
	<%if (false)
      { %>
		<script   src="../Scripts/jquery-vsdoc.js" 
        type="text/javascript"></script> 
    <%}%>	

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">

   <script type="text/javascript" language="javascript">

        //校验脚本
        function initValidator()
        {
			$.formValidator.initConfig({ formid: "aspnetForm", showallerror: true, onerror: function(msg) { promptMessage(msg); } });
            /*非空字段*/
            $("#<%=txtLoginName.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【登录名】不能为空" });
            /*非空字段*/
            $("#<%=txtUserName.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【操作员姓名】不能为空" });
            /*非空字段*/
            $("#<%=txtPassword.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【密码】不能为空" });
			/*日期*/
            $("#<%=dtpExpireTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【密码失效时间】格式错误" });
			/*日期*/
            $("#<%=dtpLastLogin.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【最近登录时间】格式错误" });
			/*日期*/
            $("#<%=dtpStartTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【有效开始日期】格式错误" });
			/*日期*/
            $("#<%=dtpEndTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【有效截止日期】格式错误" });
            /*必选项*/
            $("#<%=chbMACCode.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【允许设置多个MAC】不能为空" });
			/*默认验证字段*/
			$("#<%=txtClientIP.ClientID%>").formValidator().inputValidator({max:512, onerror: "【允许设置多个IP地址】长度不能超过512" });
            /*非空字段*/
            $("#<%=txtOwnerOrg.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【归属组织】不能为空" });
            /*邮箱*/
            $("#<%=txtEmail.ClientID%>").formValidator().inputValidator({ min: 6, max: 128, onerror: "【邮箱地址】格式不正确！" }).regexValidator({ regexp: "^([\\w-.]+)@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.)|(([\\w-]+.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(]?)$", onerror: "你输入的邮箱格式不正确" });
            /*手机号码 */
             $("#<%=txtPhone.ClientID%>").formValidator().inputValidator().regexValidator({ regexp: "mobile", datatype: "enum", onerror: "【联系电话】格式不正确" });
            /*非空字段*/
            $("#<%=txtCreator.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【创建者】不能为空" });
			/*日期*/
            $("#<%=dtpCreateTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【创建时间】格式错误" });
		}
		
		//页面初始化
        $(document).ready(function() {
			//初始化校验脚本
      		initValidator();
		 });


    function save() {
        $.post(getCurrentUrl(), { AjaxAction: "Save"}, function (value) {
            var ajaxResult = JSON2.parse(value);
            if (ajaxResult) {
                if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                    alert(ajaxResult.PromptMsg);
                }
            }
            else {
                alert("系统出错，请与管理员联系！");
            }
        });
    }

    </script>

    <div class="div_block">
        <div class="div_row">

         <div class="div_row_lable">
			<label for="<%=cboUserType.ClientID%>" class="label">
			<em>*</em>
                用户角色
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboRole" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server"></suntek:ComboBox>
            </div>


            <div class="div_row_lable">
			<label for="<%=cboUserType.ClientID%>" class="label">
			<em>*</em>
                用户类型
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboUserType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="超级管理员" Value="0"></asp:ListItem>
                            <asp:ListItem Text="分公司管理员" Value="1"></asp:ListItem>
                            <asp:ListItem Text="一般" Value="2"></asp:ListItem>
                           
                        </suntek:ComboBox>
            </div>
          
        </div>
        <div class="div_row">
          <div class="div_row_lable">
			<label for="<%=txtLoginName.ClientID%>" class="label">
			<em>*</em>
                登录名
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtLoginName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            
            <div class="div_row_lable">
			<label for="<%=txtUserName.ClientID%>" class="label">
			<em>*</em>
                操作员姓名
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtUserName" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
        
            <div class="div_row_lable">
			<label for="<%=txtPassword.ClientID%>" class="label">
			<em>*</em>
                密码
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpExpireTime.ClientID%>" class="label">
			                密码失效时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpExpireTime" runat="server"></suntek:DatePicker>
            </div>
          
        </div>
        <div class="div_row">

          <div class="div_row_lable">
			<label for="<%=cboAuthMode.ClientID%>" class="label">
			             认证方式
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboAuthMode" DropDownStyle="DropDownList" runat="server">
                         <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="本地密码认证" Value="1"></asp:ListItem>
                            <asp:ListItem Text="LDAP认证" Value="2"></asp:ListItem>
                        </suntek:ComboBox>
            </div>

            <div class="div_row_lable">
			<label for="<%=cboStatus.ClientID%>" class="label">
			<em>*</em>用户状态
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboStatus" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="正常" Value="1"></asp:ListItem>
                            <asp:ListItem Text="挂起" Value="2"></asp:ListItem>
                            <asp:ListItem Text="注销" Value="3"></asp:ListItem>
                            <asp:ListItem Text="锁定" Value="4"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
        </div>
        <div class="div_row">
        
            <div class="div_row_lable">
			<label for="<%=cboSkin.ClientID%>" class="label">
			<em>*</em>
                菜单风格
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboSkin" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="默认" Value="1"></asp:ListItem>
                          
                        </suntek:ComboBox>
            </div>

            <div class="div_row_lable">
			<label for="<%=dtpLastLogin.ClientID%>" class="label">
			                最近登录时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpLastLogin" runat="server"></suntek:DatePicker>
            </div>
            
        </div>
        <div class="div_row">
        <div class="div_row_lable">
			<label for="<%=dtpStartTime.ClientID%>" class="label">
			                有效开始日期
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpStartTime" runat="server"></suntek:DatePicker>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpEndTime.ClientID%>" class="label">
			                有效截止日期
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpEndTime" runat="server"></suntek:DatePicker>
            </div>
           
        </div>
        <div class="div_row">
         <div class="div_row_lable">
			<label for="<%=chbMACCode.ClientID%>" class="label">
			                绑定MAC
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbMACCode" OpenUrl="MACCodeTree.aspx" DialogTitle="选择允许设置多个MAC"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtClientIP.ClientID%>" class="label">
			                绑定IP地址
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtClientIP" runat="server" CssClass="text"></asp:TextBox>
            </div>
          
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtEmail.ClientID%>" class="label">
			                邮箱地址
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtEmail" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtPhone.ClientID%>" class="label">
			                联系电话
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtPhone" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtCreator.ClientID%>" class="label">
			<em>*</em>
                创建者
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtCreator" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpCreateTime.ClientID%>" class="label">
			                创建时间
			</label>
            </div>
            <div class="div_row_input">

				<suntek:DatePicker ID="dtpCreateTime" runat="server"></suntek:DatePicker>
            </div>
        </div>

         <div class="div_row">
          <div class="div_row_lable">
			<label for="<%=txtOwnerOrg.ClientID%>" class="label">
			<em>*</em>
                归属组织
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtOwnerOrg" runat="server" CssClass="text"></asp:TextBox>
            </div>
             </div>


    </div>
</asp:Content>

