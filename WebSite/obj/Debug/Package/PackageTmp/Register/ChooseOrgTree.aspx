<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ChooseOrgTree.aspx.cs" Inherits="WebSite.Register.ChooseOrgTree" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%= WebExtensions.CombresLink(Skin + "ContextMenuCss")%>
    <%= WebExtensions.CombresLink("ContextMenuJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <script type="text/javascript">

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div style="overflow: auto; height: 100%;">
        <suntek:AjaxTree ID="AjaxTree1" Runat="server" />
        <ul id="treeContextMenu" class="contextMenu" style="font-size: 12px;">
            <li class="copy"><a href="#addDept">新增部门</a></li>
            <li class="edit"><a href="#editDept">编辑部门</a></li>
            <li class="delete"><a href="#delDept">删除部门</a></li>
            <li class="copy"><a href="#addUser">新增人员</a></li>
        </ul>
    </div>
    <script language="javascript" type="text/javascript">
        //返回选择对象
        function chooseConfirm() {
            var items = getCheckedNodes();
            if ($(items).length == 0) {
                alert("请选择组织机构！");
                return;
            }
            var retValue = new Array();
            for (var i = 0; i < items.length; i++) {
                var item = new Object();
                item["CorpID"] = items[i].value;
                item["CorpName"] = items[i].text;
                item["ID"] = items[i].value;
                retValue[i] = item;
            }

            jsonData = JSON2.stringify(retValue);
            $.post(getCurrentUrl(), { AjaxAction: "AddCorp", AjaxArgument: jsonData }, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                    if (ajaxResult.ActionResult == 1) {
                        if (message == "")
                            message = "操作成功！";
                    }
                    else if (ajaxResult.ActionResult == 0) {
                        retValue = null;
                    }
                    else {
                        message = "已存在相同的组织机构！";
                        retValue = null;
                    }
                }
                alert(message);
                window.returnValue = retValue;
                window.close();
            });
        }

        function onAjaxLoad(id) {
            var isLast = $("#" + id).attr("isLast");
            var onloadMessage = "<img src=\"" + ajaxTreeSetting.ajaxTree_onLoad + "\" />正在加载…";
            $("#ajaxTreePromptMessage").append(onloadMessage);
            $("#ajaxTreePromptMessage").show();
            ajaxTreeSetting.ajaxLoading = true;

            $.post(getCurrentUrl(), { AjaxAction: "AjaxExpand", AjaxArgument: id, IsLastNode: isLast }, function (value) {
                $("#" + id).append(value);
                $("#" + id).attr("nodeState", "toggleNode");
                $("#ajaxTreePromptMessage").html("");
                $("#ajaxTreePromptMessage").hide();
                ajaxTreeSetting.ajaxLoading = false;

                var me = $("#" + id);
                var children = $("ul:first", me);
                if (children[0]) {
                    var ico = $("img", me).eq(0)
                    var icoSrc = ico.attr("src");

                    if (icoSrc == ajaxTreeSetting.ajaxTree_minus) {
                        ico.attr("src", ajaxTreeSetting.ajaxTree_plus);
                    }
                    else {
                        ico.attr("src", ajaxTreeSetting.ajaxTree_minus);
                    }
                }
            });
        }
    </script>
</asp:Content>
