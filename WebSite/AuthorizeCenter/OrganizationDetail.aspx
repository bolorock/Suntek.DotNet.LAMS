
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="OrganizationDetail.aspx.cs" Inherits="WebSite.OrganizationDetail" %>

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
            /*必选项*/
            $("#<%=chbCode.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【机构代码】不能为空" });
            /*必选项*/
            $("#<%=chbParentID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【上级组织】不能为空" });
			/*默认验证字段*/
			$("#<%=txtName.ClientID%>").formValidator().inputValidator({max:64, onerror: "【机构名称】长度不能超过64" });
			/*默认验证字段*/
			$("#<%=txtAddress.ClientID%>").formValidator().inputValidator({max:128, onerror: "【机构地址】长度不能超过128" });
            /*必选项*/
            $("#<%=chbZipCode.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【邮编】不能为空" });
            /*非空字段*/
            $("#<%=txtGovernPosition.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【机构主管岗位】不能为空" });
            /*非空字段*/
            $("#<%=txtGovernor.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【机构主管人员】不能为空" });
            /*非空字段*/
            $("#<%=txtManager.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【机构管理员能够给本机构的人员进行授权，多个机构管理员之间用,分隔】不能为空" });
            /*非空字段*/
            $("#<%=txtContactMan.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【联系人】不能为空" });
            /*手机号码 */
             $("#<%=txtContactPhone.ClientID%>").formValidator().inputValidator().regexValidator({ regexp: "mobile", datatype: "enum", onerror: "【联系电话】格式不正确" });
            /*邮箱*/
            $("#<%=txtEmail.ClientID%>").formValidator().inputValidator({ min: 6, max: 128, onerror: "【电子邮件】格式不正确！" }).regexValidator({ regexp: "^([\\w-.]+)@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.)|(([\\w-]+.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(]?)$", onerror: "你输入的邮箱格式不正确" });
			/*默认验证字段*/
			$("#<%=txtWebURL.ClientID%>").formValidator().inputValidator({max:128, onerror: "【网站地址】长度不能超过128" });
            /*非空字段*/
            $("#<%=txtArea.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【所属地域】不能为空" });
			/*默认验证字段*/
			$("#<%=txtDescription.ClientID%>").formValidator().inputValidator({max:256, onerror: "【描述】长度不能超过256" });
            /*非空字段*/
            $("#<%=txtCreator.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【创建者】不能为空" });
			/*日期*/
            $("#<%=dtpCreateTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【创建时间】格式错误" });
			/*日期*/
            $("#<%=dtpModifier.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【修改者】格式错误" });
			/*日期*/
            $("#<%=dtpModifyTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【修改时间】格式错误" });
            /*必选项*/
            $("#<%=chbSapID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【SapID】不能为空" });
            /*必选项*/
            $("#<%=chbCorpID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【公司ID】不能为空" });
		}
		
		//页面初始化
        $(document).ready(function() {
			//初始化校验脚本
      		initValidator();
		 });
			
    </script>

    <div class="div_block">
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbCode.ClientID%>" class="label">
			<em>*</em>
                机构代码
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbCode" OpenUrl="CodeTree.aspx" DialogTitle="选择机构代码"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbParentID.ClientID%>" class="label">
			                上级组织
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbParentID" OpenUrl="ParentIDTree.aspx" DialogTitle="选择上级组织"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtName.ClientID%>" class="label">
			                机构名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtGrade.ClientID%>" class="label">
			                总行，分行，海外分行...
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtGrade" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=cboType.ClientID%>" class="label">
			                总公司/总部部门/分公司/分公司部门...
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtAddress.ClientID%>" class="label">
			                机构地址
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtAddress" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbZipCode.ClientID%>" class="label">
			                邮编
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbZipCode" OpenUrl="ZipCodeTree.aspx" DialogTitle="选择邮编"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtGovernPosition.ClientID%>" class="label">
			<em>*</em>
                机构主管岗位
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtGovernPosition" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtGovernor.ClientID%>" class="label">
			<em>*</em>
                机构主管人员
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtGovernor" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtManager.ClientID%>" class="label">
			<em>*</em>
                机构管理员能够给本机构的人员进行授权，多个机构管理员之间用,分隔
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtManager" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtContactMan.ClientID%>" class="label">
			<em>*</em>
                联系人
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtContactMan" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtContactPhone.ClientID%>" class="label">
			                联系电话
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtContactPhone" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtEmail.ClientID%>" class="label">
			                电子邮件
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtEmail" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtWebURL.ClientID%>" class="label">
			                网站地址
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtWebURL" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=cboStatus.ClientID%>" class="label">
			                机构状态
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboStatus" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtArea.ClientID%>" class="label">
			<em>*</em>
                所属地域
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtArea" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtSortOrder.ClientID%>" class="label">
			                序号
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtSortOrder" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtDescription.ClientID%>" class="label">
			                描述
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="text"></asp:TextBox>
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
			<label for="<%=dtpModifier.ClientID%>" class="label">
			                修改者
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpModifier" runat="server"></suntek:DatePicker>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpModifyTime.ClientID%>" class="label">
			                修改时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpModifyTime" runat="server"></suntek:DatePicker>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbSapID.ClientID%>" class="label">
			<em>*</em>
                SapID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbSapID" OpenUrl="SapIDTree.aspx" DialogTitle="选择SapID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbCorpID.ClientID%>" class="label">
			<em>*</em>
                公司ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbCorpID" OpenUrl="CorpIDTree.aspx" DialogTitle="选择公司ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
    </div>
</asp:Content>

