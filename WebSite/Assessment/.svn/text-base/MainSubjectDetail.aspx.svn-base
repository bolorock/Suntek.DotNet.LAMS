
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="MainSubjectDetail.aspx.cs" Inherits="WebSite.MainSubjectDetail" %>

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
            /*非空字段*/
            $("#<%=txt标题.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【标题】不能为空" });
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
			<label for="<%=txt标题.ClientID%>" class="label">
			<em>*</em>
                标题
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txt标题" runat="server" CssClass="text"></asp:TextBox>
            </div>
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
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtScore.ClientID%>" class="label">
			                大题分值
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtScore" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtSortOrder.ClientID%>" class="label">
			                序号
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtSortOrder" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
    </div>
</asp:Content>

