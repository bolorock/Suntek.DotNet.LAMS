﻿
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="DictManager.aspx.cs" Inherits="WebSite.DictManager" %>

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
        function autoHeight() {
            $("#div3").height($(window.parent.main).height() - 140);
            $("#div4").height($(window.parent.main).height() - 125);
        }
        $(document).ready(function () {
            autoHeight();

            $(window).resize(function () {
                autoHeight();
            });
        });

        function save(me, argument) {
            var frm = window.frames["ifrDict"].save(me, argument);
        }
    </script>
    <table border="1" width="100%" bordercolor="#82A9DF" style="margin-bottom: 0px; border-collapse: collapse;">
            <tr>
                <td width="100%" class="toptitle5">
                    <div class="toptitle">
                        字典配置</div>
                </td>
            </tr>
            <tr>
                <td width="100%" height="*" bgcolor="#FFFFFF" valign="top" class="area02">
                    <!--****************************************区域2****************************************-->
                    <div id="area2">
                        <div id="divFolder" style="width: 100%; height: 100%; overflow: auto;">
                            <table width="100%">
                                <tr>
                                    <td valign="top" width="240px">
                                        <table border="1" width="100%" bordercolor="#82A9DF" style="margin-bottom: 0px; border-collapse: collapse;"
                                            height="100%">
                                            <tr>
                                                <td width="100%" class="toptitle">
                                                    字典树
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="100%" height="*" bgcolor="#FFFFFF" valign="top" class="area02">
                                                    <!--****************************************区域2****************************************-->
                                                    <div id="Div2">
                                                        <div id="div3" style="overflow: auto;">
                                                            <iframe id="ifrTree" name="ifrTree" src="DictTree.aspx" width="230px" height="100%"
                                                                frameborder="0" scrolling="auto"></iframe>
                                                        </div>
                                                    </div>
                                                    <!--****************************************区域2 END****************************************-->
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td valign="top">
                                        <div id="div4" style="overflow: visible;">
                                            <iframe id="ifrDict" name="ifrDict" src="DictDetail.aspx" width="100%"
                                            height="100%" frameborder="0" scrolling="auto"></iframe>
                                        </div>                                      
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <!--****************************************区域2 END****************************************-->
                </td>
            </tr>
        </table>
</asp:Content>


