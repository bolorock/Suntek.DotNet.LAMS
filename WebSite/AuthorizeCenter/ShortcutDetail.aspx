
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ShortcutDetail.aspx.cs" Inherits="WebSite.ShortcutDetail" %>

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
            $("#<%=chbPrivilegeID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【权限ID】不能为空" });
            /*必选项*/
            $("#<%=chbAppID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【冗余字段】不能为空" });
			/*默认验证字段*/
			$("#<%=txtIcon.ClientID%>").formValidator().inputValidator({max:128, onerror: "【快捷菜单图标】长度不能超过128" });
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
			<label for="<%=chbPrivilegeID.ClientID%>" class="label">
			<em>*</em>
                权限ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbPrivilegeID" OpenUrl="PrivilegeIDTree.aspx" DialogTitle="选择权限ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbAppID.ClientID%>" class="label">
			<em>*</em>
                冗余字段
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbAppID" OpenUrl="AppIDTree.aspx" DialogTitle="选择冗余字段"
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
			<label for="<%=txtIcon.ClientID%>" class="label">
			                快捷菜单图标
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtIcon" runat="server" CssClass="text"></asp:TextBox>
            </div>
		</div>
    </div>
</asp:Content>

