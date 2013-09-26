
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ExpertProcess.aspx.cs" Inherits="WebSite.ExpertProcess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<%= WebExtensions.CombresLink(Skin+"SiteCss") %>
	<%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("ManagerJs") %>
	<%if (false)
      { %>
		<script   src="../Scripts/jquery-vsdoc.js" 
        type="text/javascript"></script> 
    <%}%>	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
<script type="text/javascript" language="javascript">
    function back(me, argument) {
        history.back();
    }

    function rowDbClick(me) {
        openOperateDialog("查看专家评分详细", "ExpertScore.aspx?CurrentID=" + $(me).attr("id") + "&Entry=View", 900, 600, true, 1);
    }

    function ViewResultClick(me) {
        openOperateDialog("查看评分详细", "ExpertResult.aspx?UserID=" + $(me).attr("UserID") + "&SurveyID=" + $(me).attr("SurveyID"), 900, 600, true, 1);
    }

</script>

<style>
table .th {
background: url(../Skins/Default/Images/th1.gif);
border: 1px solid #8DB2E3;
color: #2C59AA;
font-size: 12px;
font-weight: bold;
height: 22px;
padding: 0px;
text-align: center;
text-indent: 4px;
}
</style>

    <div id="divContent" class="div_content">

        <div style="vertical-align: top; overflow: auto; height: 100%;">
        <asp:Literal ID="litTable" runat="server"></asp:Literal>
      </div>
    </div>
  
</asp:Content>


