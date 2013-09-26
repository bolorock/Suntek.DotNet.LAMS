
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="PositionDetail.aspx.cs" Inherits="WebSite.PositionDetail" %>

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
            $("#<%=chbCode.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【岗位代码】不能为空" });
            /*非空字段*/
            $("#<%=txtName.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【岗位名称】不能为空" });
            /*必选项*/
            $("#<%=chbDutyID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【职务ID】不能为空" });
            /*必选项*/
            $("#<%=chbAppID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【应用ID】不能为空" });
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
			<label for="<%=chbCode.ClientID%>" class="label">
			                岗位代码
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbCode" OpenUrl="CodeTree.aspx" DialogTitle="选择岗位代码"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtName.ClientID%>" class="label">
			<em>*</em>
                岗位名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbDutyID.ClientID%>" class="label">
			<em>*</em>
                职务ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbDutyID" OpenUrl="DutyIDTree.aspx" DialogTitle="选择职务ID"
                runat="server"></suntek:ChooseBox>
            </div>
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

