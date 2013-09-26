
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="SubjectItemCoreDetail.aspx.cs" Inherits="WebSite.SubjectItemCoreDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
	<%= WebExtensions.CombresLink(Skin+"SiteCss") %>
	<%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("DetailJs") %>
	<%if (false)
      { %>
		<script src="<%=string.Format("{0}/Scripts/jquery-vsdoc.js",RootPath)%>"
        type="text/javascript"></script> 
    <%}%>	

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">

   <script type="text/javascript" language="javascript">

        //校验脚本
        function initValidator()
        {
			$.formValidator.initConfig({ formid: "aspnetForm", showallerror: true, onerror: function(msg) { $("#promptMsg").html(msg); } });
            /*必选项*/
            $("#<%=chbExamPaperID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【试卷ID】不能为空" });
            /*必选项*/
            $("#<%=chbSubjectID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【题目ID】不能为空" });
            /*必选项*/
            $("#<%=chbSubjectItemID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【题目选项ID】不能为空" });
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
			<label for="<%=chbExamPaperID.ClientID%>" class="label">
			<em>*</em>
                试卷ID
			</label>
            </div>
            <div class="div_row_input">
			    <Hiway:ChooseBox ID="chbExamPaperID" OpenUrl="ExamPaperIDTree.aspx" DialogTitle="选择试卷ID"
                runat="server"></Hiway:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbSubjectID.ClientID%>" class="label">
			<em>*</em>
                题目ID
			</label>
            </div>
            <div class="div_row_input">
			    <Hiway:ChooseBox ID="chbSubjectID" OpenUrl="SubjectIDTree.aspx" DialogTitle="选择题目ID"
                runat="server"></Hiway:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbSubjectItemID.ClientID%>" class="label">
			<em>*</em>
                题目选项ID
			</label>
            </div>
            <div class="div_row_input">
			    <Hiway:ChooseBox ID="chbSubjectItemID" OpenUrl="SubjectItemIDTree.aspx" DialogTitle="选择题目选项ID"
                runat="server"></Hiway:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtScore.ClientID%>" class="label">
			                选项分值
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtScore" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
    </div>
</asp:Content>

