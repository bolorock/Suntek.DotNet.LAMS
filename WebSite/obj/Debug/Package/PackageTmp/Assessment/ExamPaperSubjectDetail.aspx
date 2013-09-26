
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ExamPaperSubjectDetail.aspx.cs" Inherits="WebSite.ExamPaperSubjectDetail" %>

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
            $("#<%=chbSubjectID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【题目ID】不能为空" });
            /*必选项*/
            $("#<%=chbExamPaperID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【试卷ID】不能为空" });
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
			<label for="<%=chbSubjectID.ClientID%>" class="label">
			<em>*</em>
                题目ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbSubjectID" OpenUrl="SubjectIDTree.aspx" DialogTitle="选择题目ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbExamPaperID.ClientID%>" class="label">
			<em>*</em>
                试卷ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbExamPaperID" OpenUrl="ExamPaperIDTree.aspx" DialogTitle="选择试卷ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
    </div>
</asp:Content>

