<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ResourceManager.aspx.cs" Inherits="WebSite.ResourceManager" %>

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
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script language="javascript" type="text/javascript">
        function save(me, argument) {
            var frm = window.frames["ifrResource"].save(me, argument); ;
        }
    </script>
    <div id="treeContainer" style="width: 24%; float: left;">
        <iframe id="ifrTree" name="ifrTree" class="autoHeight" src="ResourceTree.aspx" width="100%"
            height="100%" frameborder="0" scrolling="no"></iframe>
    </div>
    <div id="resourceContainer" style="float: left; width: 76%;">
        <iframe id="ifrResource" class="autoHeight" name="ifrResource" src="ResourceDetail.aspx?ActionFlag=Update&CurrentId=LAMS"
            width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
    </div>
</asp:Content>
