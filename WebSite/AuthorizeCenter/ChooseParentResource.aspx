﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ChooseParentResource.aspx.cs" Inherits="WebSite.ChooseParentResource" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <suntek:AjaxTree ID="AjaxTree1" Runat="server" />
    <script language="javascript" type="text/javascript">

        //返回选择对象
        function chooseConfirm() {
            var item = getCurrentNode();
            var retValue = new Object();
            retValue.text = item.text;
            retValue.value = item.value;
            retValue.tag = item.tag;
            window.returnValue = retValue;
            window.close();
        }
    </script>
</asp:Content>
