<%@ Page Title="" Language="C#"  MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
 CodeBehind="CandidateManagerOrgTree.aspx.cs" Inherits="WebSite.CandidateManagerOrgTree" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink(Skin + "ContextMenuCss")%>
    <%= WebExtensions.CombresLink("ContextMenuJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
</asp:Content>
 
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div style="overflow: auto; height: 100%;vertical-align: top;">
         <suntek:AjaxTree ID="AjaxTree1" Runat="server" />
    </div>
</asp:Content>
