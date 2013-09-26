
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ExpertResult.aspx.cs" Inherits="WebSite.ExpertResult" %>

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

.comment{overflow:hidden;
white-space:nowrap;
text-overflow:ellipsis;
width:90px;
}
</style>

    <div id="divContent" class="div_content">

        <div style="vertical-align: top; overflow: auto; height: 100%;">
        <asp:Literal ID="litTable" runat="server"></asp:Literal>
      </div>
    </div>
  
</asp:Content>


