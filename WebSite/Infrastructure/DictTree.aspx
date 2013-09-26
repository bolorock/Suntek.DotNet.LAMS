<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DictTree.aspx.cs" Inherits="WebSite.Infrastructure.DictTree" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink(Skin + "ContextMenuCss")%>
    <%= WebExtensions.CombresLink("ContextMenuJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <style type="text/css">
        body
        {
            -moz-user-select: none;
        }
        .ajaxTree-container
        {
            position: absolute;
            top: 10px;
            left: -10px;
        }
    </style>
    <script type="text/javascript">

        var iconParentDict = "<%=RootPath %>Skins/<%=Skin %>/Images/dictionary.png";
        var iconChildDict = "<%=RootPath %>Skins/<%=Skin %>/Images/accessories_dictionary.png";
        

        function addNewAjaxTreeNode(parentId, nodeId, nodeName, nodeType) {
            if ($("#" + nodeId)[0]) {
                $("#" + nodeId).find("a:first").text(nodeName);
                return;
            }

            var iconImg = ajaxTreeSetting.ajaxTree_node

            switch (nodeType) {
                case "parentDict":
                    iconImg = iconParentDict;
                    break;
                case "childDict":
                    iconImg = iconChildDict;
                    break;
            }

            var item = "<li id=\"" + nodeId + "\" class=\"line-bottom\" title=\"" + nodeName + "\" bindvalue=\"" + nodeId + "\" virtualNodeCount=\"0\" postType=\"NoPost\" tag=\""
                     + nodeType + "\" nodeState=\"toggleNode\" islast=\"true\" >"
                     + "<img src=" + ajaxTreeSetting.ajaxTree_bottom_line + " style=\"border-width: 0px;\" />"
                     + "<img src=" + iconImg + " style=\"border-width: 0px;\" />"
                     + "<a href=\"javascript:void(0)\" target=\"_self\" onclick=\"onNodeClick('"
                     + nodeId + "','" + nodeId + "')\">" + nodeName + "</a>"
                     + "</li>";

            var curNode = $("#" + parentId);
            var children;
            var brother;
            //添加子结点
            if (curNode[0]) {
                children = $("ul:first", curNode);
                brother = $("li:last", children);

                if (brother.attr("id")) {
                    brother = $("li:last", children);
                    if (brother[0]) {
                        brother.find("img:first").attr("src", ajaxTreeSetting.ajaxTree_middle_line);
                    }
                    children.append(item);
                }
                else {
                    curNode.find("img:first").attr("src", ajaxTreeSetting.ajaxTree_minus);
                    curNode.find("img:first").bind("click", function () {
                        onNodeIcoClick(parentId);
                    });

                    var virtualNodeCount = curNode.attr("virtualNodeCount");
                    if (virtualNodeCount != "" && parseInt(virtualNodeCount) > 0) {
                        item = "<ul style=\"background: url(" + ajaxTreeSetting.ajaxTree_vertical_line + ") repeat-y 0px 0px;\">" + item + "</ul>";
                    } else {
                        if (curNode.first().next("li").size() <= 0) {
                            item = "<ul >" + item + "</ul>";

                        } else {
                            item = "<ul style=\"background: url(" + ajaxTreeSetting.ajaxTree_vertical_line + ") repeat-y 0px 0px;\">" + item + "</ul>";
                        }
                    }

                    curNode.append(item);
                }
            }
            else {//添加根结点
                curNode = $("#ajaxTree_Div_Id");
                children = $("ul:first", curNode);
                brother = $("li:last", children);
                if (brother[0]) {
                    var virtualNodeCount = brother.attr("virtualNodeCount");
                    if (virtualNodeCount != "" && parseInt(virtualNodeCount) > 0) {
                        $("ul:first", children).attr("style", "background: url(" + ajaxTreeSetting.ajaxTree_vertical_line + ") repeat-y 0px 0px;");
                    }
                    else {
                        brother.find("img").attr("src", ajaxTreeSetting.ajaxTree_middle_line);
                    }
                }
                children.append(item);
            }

            initContextMenu();

            return nodeId;
        }

        function ajaxTreeNodeAction(id, value) {
            $("#ifrDict", window.parent.document.body).attr("src", "DictDetail.aspx?ActionFlag=Update&CurrentId=" + id);
        }

        document.oncontextmenu = function (e) { return false; }

        function initContextMenu() {
            $("li A").contextMenu({
                menu: 'treeContextMenu'
            }, function (action, el, pos) {

                activeCurrentNode(el.context.parentNode.id);

                if (action == "add") {
                    $("#ifrDict", window.parent.document.body).attr("src", "DictDetail.aspx?ActionFlag=Add&ParentId=" + el.context.parentNode.id);
                }
                if (action == "edit") {
                    $("#ifrDict", window.parent.document.body).attr("src", "DictDetail.aspx?ActionFlag=Update&CurrentId=" + el.context.parentNode.id);
                }
                if (action == "delete") {
                    $.post("DictTree.aspx", { AjaxAction: "DeleteTreeNode", AjaxArgument: el.context.parentNode.id }, function (result) {
                        var ajaxResult = JSON2.parse(result);
                        var message = "操作失败";
                        if (ajaxResult) {
                            if (ajaxResult.PromptMsg != null)
                                message = ajaxResult.PromptMsg
                            if (ajaxResult.ActionResult == 1) {
                                if (message == "")
                                    message = "操作成功！";
                                $("#" + el.context.parentNode.id).remove();
                                if (ajaxResult.RetValue != "")
                                    $("#ifrDict", window.parent.document.body).attr("src", "DictDetail.aspx?ActionFlag=Update&CurrentId=" + ajaxResult.RetValue);
                            }
                        }
                        alert(message);
                    });
                }
            });
        }

        $(document).ready(function () {
            //默认展开一级菜单
            expandNode('0', '1');
            initContextMenu();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <suntek:AjaxTree ID="AjaxTree1" Runat="server" />
    <ul id="treeContextMenu" class="contextMenu" style="font-size: 12px;">
        <li class="copy"><a href="#add">新增字典</a></li>
        <li class="edit"><a href="#edit">编辑字典</a></li>
        <li class="delete"><a href="#delete">删除字典</a></li>
    </ul>
    </form>
</body>
</html>
