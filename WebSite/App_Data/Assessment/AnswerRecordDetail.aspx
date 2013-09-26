
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="AnswerRecordDetail.aspx.cs" Inherits="WebSite.AnswerRecordDetail" %>

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
            $("#<%=chbAssessmentResultID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【测评结果ID】不能为空" });
            /*必选项*/
            $("#<%=chbSubjectID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【题目ID】不能为空" });
			/*默认验证字段*/
			$("#<%=txtAnwser.ClientID%>").formValidator().inputValidator({max:256, onerror: "【答案】长度不能超过256" });
            /*非空字段*/
            $("#<%=txtScorer.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【评分人】不能为空" });
			/*日期*/
            $("#<%=dtpScoreTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【评分时间】格式错误" });
			/*默认验证字段*/
			$("#<%=txtOwnerOrg.ClientID%>").formValidator().inputValidator({max:512, onerror: "【归属组织】长度不能超过512" });
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
			<label for="<%=chbAssessmentResultID.ClientID%>" class="label">
			<em>*</em>
                测评结果ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbAssessmentResultID" OpenUrl="AssessmentResultIDTree.aspx" DialogTitle="选择测评结果ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbSubjectID.ClientID%>" class="label">
			<em>*</em>
                题目ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbSubjectID" OpenUrl="SubjectIDTree.aspx" DialogTitle="选择题目ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtAnwser.ClientID%>" class="label">
			                答案
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtAnwser" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtScore.ClientID%>" class="label">
			                得分
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtScore" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtScorer.ClientID%>" class="label">
			<em>*</em>
                评分人
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtScorer" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpScoreTime.ClientID%>" class="label">
			                评分时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpScoreTime" runat="server"></suntek:DatePicker>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtFinalScore.ClientID%>" class="label">
			                综合评分
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtFinalScore" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtOwnerOrg.ClientID%>" class="label">
			                归属组织
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtOwnerOrg" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
    </div>
</asp:Content>

