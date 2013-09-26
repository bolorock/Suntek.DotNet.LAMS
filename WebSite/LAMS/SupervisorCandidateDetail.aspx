
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="SupervisorCandidateDetail.aspx.cs" Inherits="WebSite.SupervisorCandidateDetail" %>

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
            $("#<%=chbSupervisorID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【导师ID】不能为空" });
            /*必选项*/
            $("#<%=chbCandidateManagerID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【后备经理人ID】不能为空" });
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
			<label for="<%=chbSupervisorID.ClientID%>" class="label">
			<em>*</em>
                导师ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbSupervisorID" OpenUrl="SupervisorIDTree.aspx" DialogTitle="选择导师ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbCandidateManagerID.ClientID%>" class="label">
			<em>*</em>
                后备经理人ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbCandidateManagerID" OpenUrl="CandidateManagerIDTree.aspx" DialogTitle="选择后备经理人ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
    </div>
</asp:Content>

