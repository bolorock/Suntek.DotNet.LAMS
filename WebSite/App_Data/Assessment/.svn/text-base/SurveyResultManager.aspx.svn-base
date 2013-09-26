
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="SurveyResultManager.aspx.cs" Inherits="WebSite.SurveyResultManager" %>

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
</script>


    <div id="divContent" class="div_content">

        <asp:GridView ID="GridView1" runat="server" Width="100%">
        </asp:GridView>

      
    </div>
  
</asp:Content>


