<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true" CodeBehind="CandidateManagerOrgTreeMain.aspx.cs" Inherits="WebSite.CandidateManagerOrgTreeMain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentPlace" runat="server">
    <script language="javascript" type="text/javascript">
        function save(me, argument) {
            var frm = window.frames["ifrResource"].save(me, argument); ;
        }
    </script>
    <div id="treeContainer" style="width: 24%; float: left;">
        <iframe id="Iframe1" name="ifrTree" class="autoHeight" src="CandidateManagerOrgTree.aspx" width="100%"
            height="100%" frameborder="0" scrolling="no"></iframe>
    </div>
    <div id="resourceContainer" style="float: left; width: 76%;">
        <iframe id="ifrMain" class="autoHeight" name="ifrMain" src="../AuthorizeCenter/EmployeeManager.aspx?layer=1&grade=<%= Grade %><%= Grade=="0" ? string.Empty: "&corpID="+User.CorpID %>" 
            width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
    </div>
</asp:Content>
