
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="SpecialPrivilegeManager.aspx.cs" Inherits="WebSite.SpecialPrivilegeManager" %>

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

     <script type="text/javascript" language="javascript">

         $(function () {
             $("#tabs").tabs({
                 ajaxOptions: {
                     error: function (xhr, status, index, anchor) {
                         $(anchor.hash).html(
						"无法加载此标签！");
                     }
                 }
             });
            
         });


         function save(me, argument) {
             var $tabs = $('#tabs').tabs();
             var selected = $tabs.tabs('option', 'selected');
             if (selected == 0) {
                 var frm = window.frames["ifrMain-0"].save(me, argument); 
             }
             else {
                 var frm = window.frames["ifrMain-1"].save(me, argument); 
             }


         }

         function openSPAdd() {
             var userID = $.query.get("UserID");
             $("#ifrMain-0").attr("src", "SpecialPrivilegeDetail.aspx?AuthFlag=1&UserID=" + userID+"&r="+Math.random());
         }
         function openSPMinus() {
             var userID = $.query.get("UserID");
             $("#ifrMain-1").attr("src", "SpecialPrivilegeDetail.aspx?AuthFlag=2&UserID=" + userID + "&r=" + Math.random());
         }

         $(function () {
             openSPAdd();
             openSPMinus();
         }
         );

     </script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">

 <div id="tabs" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
        <ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
            <li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active">
            <span id="ui-tab-0"><a href="#tabs-0">
                增加权限</a>
                </span>
                </li>
            <li class="ui-state-default ui-corner-top">
             <span id="ui-tab-1"><a href="#tabs-1">删减权限</a></span></li>
        </ul>
        <div id="tabs-0">
         <iframe id="ifrMain-0" name="ifrMain-0" src="" width="100%" height="300" frameborder="0" scrolling="auto"></iframe>
    </div>
    <div id="tabs-1">
         <iframe id="ifrMain-1" name="ifrMain-1" src="" width="100%" height="300" frameborder="0" scrolling="auto"></iframe>
    </div>
     </div>


</asp:Content>


