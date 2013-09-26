
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="CatalogManager.aspx.cs" Inherits="WebSite.CatalogManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<%= WebExtensions.CombresLink(Skin+"SiteCss") %>
	<%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("ManagerJs") %>
	<%if (false)
      { %>
		<script src="<%=string.Format("{0}/Scripts/jquery-vsdoc.js",RootPath)%>"
        type="text/javascript"></script> 
    <%}%>	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script language="javascript" type="text/javascript">
        function autoHeight() {
            try {
                if (window.frameElement) {
                    $(document.body).height($(window.frameElement).height());
                }

                $("#page").height($(document).height() - $("#divNav").height() - 16);
            } catch (e) { }

            var height = $("#main", window.parent.document).height() - 60;
            $("#treeContainer").height(height);
            $("#resourceContainer").height(height);
        }

        function save(me, argument) {
            var frm = window.frames["ifrDict"].save(me, argument);
        }
        function del(me, argument) {
            var frm = window.frames["ifrDict"].del(me, argument);
        }
    </script>
    <div id="treeContainer" style="width: 24%; float: left;">
        <iframe id="ifrTree" name="ifrTree" class="autoHeight" src="CatalogTree.aspx" width="100%"
            height="100%" frameborder="0" scrolling="no"></iframe>
    </div>
    <div id="resourceContainer" style="float: left; width: 76%;">
        <iframe id="ifrDict" class="autoHeight" name="ifrResource" src="UploadFileManager.aspx"
            width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
    </div>
  
</asp:Content>


