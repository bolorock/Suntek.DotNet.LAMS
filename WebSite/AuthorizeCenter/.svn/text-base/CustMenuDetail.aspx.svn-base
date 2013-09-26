
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="CustMenuDetail.aspx.cs" Inherits="WebSite.CustMenuDetail" %>

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
            $("#<%=chbOperatorID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【操作员ID】不能为空" });
            /*必选项*/
            $("#<%=chbResourceID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【菜单编号】不能为空" });
            /*非空字段*/
            $("#<%=txtName.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【菜单名称】不能为空" });
            /*非空字段*/
            $("#<%=txtText.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【菜单显示（中文）】不能为空" });
            /*必选项*/
            $("#<%=chbRootID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【根菜单】不能为空" });
            /*必选项*/
            $("#<%=chbParentID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【父菜单】不能为空" });
			/*默认验证字段*/
			$("#<%=txtIcon.ClientID%>").formValidator().inputValidator({max:128, onerror: "【菜单图标】长度不能超过128" });
			/*默认验证字段*/
			$("#<%=txtExpandIcon.ClientID%>").formValidator().inputValidator({max:128, onerror: "【菜单展开图标】长度不能超过128" });
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
			<label for="<%=chbOperatorID.ClientID%>" class="label">
			<em>*</em>
                操作员ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbOperatorID" OpenUrl="OperatorIDTree.aspx" DialogTitle="选择操作员ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbResourceID.ClientID%>" class="label">
			<em>*</em>
                菜单编号
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbResourceID" OpenUrl="ResourceIDTree.aspx" DialogTitle="选择菜单编号"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtName.ClientID%>" class="label">
			<em>*</em>
                菜单名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtText.ClientID%>" class="label">
			<em>*</em>
                菜单显示（中文）
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtText" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbRootID.ClientID%>" class="label">
			<em>*</em>
                根菜单
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbRootID" OpenUrl="RootIDTree.aspx" DialogTitle="选择根菜单"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbParentID.ClientID%>" class="label">
			                父菜单
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbParentID" OpenUrl="ParentIDTree.aspx" DialogTitle="选择父菜单"
                runat="server"></suntek:ChooseBox>
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
			<label for="<%=txtIcon.ClientID%>" class="label">
			                菜单图标
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtIcon" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtExpandIcon.ClientID%>" class="label">
			                菜单展开图标
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtExpandIcon" runat="server" CssClass="text"></asp:TextBox>
            </div>
		</div>
    </div>
</asp:Content>

