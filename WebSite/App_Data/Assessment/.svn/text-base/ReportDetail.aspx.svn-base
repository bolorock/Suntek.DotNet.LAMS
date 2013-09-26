
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ReportDetail.aspx.cs" Inherits="WebSite.ReportDetail" %>

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
            $("#<%=chbEmployeeID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【员工编号】不能为空" });
			/*默认验证字段*/
			$("#<%=txtName.ClientID%>").formValidator().inputValidator({max:64, onerror: "【名称】长度不能超过64" });
            /*必选项*/
            $("#<%=chbCode.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【编号】不能为空" });
            /*必选项*/
            $("#<%=chbUploadFileID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【报告文件】不能为空" });
			/*默认验证字段*/
			$("#<%=txtOwnerOrg.ClientID%>").formValidator().inputValidator({max:512, onerror: "【归属组织】长度不能超过512" });
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
			<label for="<%=chbEmployeeID.ClientID%>" class="label">
			<em>*</em>
                员工编号
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbEmployeeID" OpenUrl="EmployeeIDTree.aspx" DialogTitle="选择员工编号"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtName.ClientID%>" class="label">
			                名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbCode.ClientID%>" class="label">
			                编号
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbCode" OpenUrl="CodeTree.aspx" DialogTitle="选择编号"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbUploadFileID.ClientID%>" class="label">
			<em>*</em>
                报告文件
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbUploadFileID" OpenUrl="UploadFileIDTree.aspx" DialogTitle="选择报告文件"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtOwnerOrg.ClientID%>" class="label">
			                归属组织
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtOwnerOrg" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtCreator.ClientID%>" class="label">
			<em>*</em>
                创建者
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtCreator" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=dtpCreateTime.ClientID%>" class="label">
			<em>*</em>
                创建时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpCreateTime" runat="server"></suntek:DatePicker>
            </div>
		</div>
    </div>
</asp:Content>

