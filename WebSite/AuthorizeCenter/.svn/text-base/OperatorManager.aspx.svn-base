<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="OperatorManager.aspx.cs" Inherits="WebSite.OperatorManager" %>

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
        function setRole(me, argument) {
            var frm = window.frames["ifrMain"].setRole(me, argument);

        }

        function setSpecialPrivilege(me, argument) {
            var frm = window.frames["ifrMain"].setSpecialPrivilege(me, argument);


        }
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
    </script>
      <div id="treeContainer" style="width: 24%; float: left;">
        <iframe id="ifrTree" name="ifrTree" class="autoHeight" src="orgtree.aspx" width="100%"
            height="100%" frameborder="0" scrolling="no"></iframe>
    </div>
    <div id="resourceContainer" style="float: left; width: 76%;">
        <iframe id="ifrMain" class="autoHeight" name="ifrMain" src="OrgUserList.aspx"
            width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
    </div>
</asp:Content>
