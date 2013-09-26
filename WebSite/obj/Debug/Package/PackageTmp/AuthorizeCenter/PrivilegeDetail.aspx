
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="PrivilegeDetail.aspx.cs" Inherits="WebSite.PrivilegeDetail" %>

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
            $("#<%=txtName.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【权限名称】不能为空" });
            /*必选项*/
            $("#<%=chbResourceID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【资源ID】不能为空" });
            /*必选项*/
            $("#<%=chbOperateID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【操作ID】不能为空" });
            /*必选项*/
            $("#<%=chbMetaDataID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【元数据ID】不能为空" });
            /*必选项*/
            $("#<%=chbModuleID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【模块ID】不能为空" });
            /*必选项*/
            $("#<%=chbAppID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【应用ID】不能为空" });
			/*默认验证字段*/
			$("#<%=txtDescription.ClientID%>").formValidator().inputValidator({max:128, onerror: "【描述】长度不能超过128" });
            /*非空字段*/
            $("#<%=txtOwnerOrg.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【归属组织】不能为空" });
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
			
    </script>

    <div class="div_block">
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtName.ClientID%>" class="label">
			<em>*</em>
                权限名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboType.ClientID%>" class="label">
			<em>*</em>
                权限类型
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
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbResourceID.ClientID%>" class="label">
			<em>*</em>
                资源ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbResourceID" OpenUrl="ResourceIDTree.aspx" DialogTitle="选择资源ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbOperateID.ClientID%>" class="label">
			<em>*</em>
                操作ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbOperateID" OpenUrl="OperateIDTree.aspx" DialogTitle="选择操作ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbMetaDataID.ClientID%>" class="label">
			<em>*</em>
                元数据ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbMetaDataID" OpenUrl="MetaDataIDTree.aspx" DialogTitle="选择元数据ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbModuleID.ClientID%>" class="label">
			<em>*</em>
                模块ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbModuleID" OpenUrl="ModuleIDTree.aspx" DialogTitle="选择模块ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbAppID.ClientID%>" class="label">
			<em>*</em>
                应用ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbAppID" OpenUrl="AppIDTree.aspx" DialogTitle="选择应用ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtSortOrder.ClientID%>" class="label">
			<em>*</em>
                序号
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtSortOrder" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtDescription.ClientID%>" class="label">
			                描述
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="text"></asp:TextBox>
            </div>
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
    </div>
</asp:Content>

