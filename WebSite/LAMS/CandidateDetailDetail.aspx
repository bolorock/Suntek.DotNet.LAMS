
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="CandidateDetailDetail.aspx.cs" Inherits="WebSite.CandidateDetailDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
	<%= WebExtensions.CombresLink(Skin+"SiteCss") %>
	<%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("DetailJs") %>
	<%if (false)
      { %>
		<script src="../Scripts/jquery-vsdoc.js" 
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
			$("#<%=txtMajorKPI.ClientID%>").formValidator().inputValidator({max:1024, onerror: "【主要业绩】长度不能超过1024" });
			/*默认验证字段*/
			$("#<%=txtDeficiency.ClientID%>").formValidator().inputValidator({max:1024, onerror: "【主要不足】长度不能超过1024" });
			/*默认验证字段*/
			$("#<%=txtTrainingPlan.ClientID%>").formValidator().inputValidator({max:1024, onerror: "【培训发展计划】长度不能超过1024" });
			/*默认验证字段*/
			$("#<%=txtRecommendation.ClientID%>").formValidator().inputValidator({max:1024, onerror: "【推荐意见】长度不能超过1024" });
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
			<label for="<%=txtShouldCount.ClientID%>" class="label">
			                应到人数
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtShouldCount" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtAttendCount.ClientID%>" class="label">
			                实到人数
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtAttendCount" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtEmployeeCount.ClientID%>" class="label">
			                员工代表人数
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtEmployeeCount" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtApproveCount.ClientID%>" class="label">
			                同意票数
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtApproveCount" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtApprovePercent.ClientID%>" class="label">
			                占票数百分比
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtApprovePercent" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtMajorKPI.ClientID%>" class="label">
			                主要业绩
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtMajorKPI" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtDeficiency.ClientID%>" class="label">
			                主要不足
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDeficiency" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtTrainingPlan.ClientID%>" class="label">
			                培训发展计划
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtTrainingPlan" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtRecommendation.ClientID%>" class="label">
			                推荐意见
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtRecommendation" runat="server" CssClass="text"></asp:TextBox>
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

