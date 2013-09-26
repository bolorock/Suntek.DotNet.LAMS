<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="FieldSetDetail.aspx.cs" Inherits="WebSite.Register.FieldSetEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <style type="text/css">
        .divPage
        {
            width: 100%;
            height: 100%;
            text-align: center;
            display: block;
            overflow: hidden;
        }
        .divHeadSelf
        {
            float: left;
            height: 30px;
            background-image: url(../../../Skins/Default/Images/gridtop.gif);
            overflow: hidden;
            width: 100%;
        }
        .divHead
        {
            height: 30px;
            float: left;
            font-size: 13px;
            font-family: "微软雅黑" , "黑体" , "宋体";
        }
        .divSearch
        {
            height: 20px;
            float: left;
            margin-left: 20px;
            margin-top: 2px;
            font-size: 13px;
            font-family: "微软雅黑" , "黑体" , "宋体";
        }
        .divHeadLeft
        {
            height: 30px;
            width: 12px;
            background-image: url(../../../Skins/Default/Images/gridtopleft.gif);
            float: left;
        }
        .divHeadRight
        {
            height: 30px;
            width: 17px;
            background-image: url(../../../Skins/Default/Images/gridtopright.gif);
            float: right;
        }
        
        
        /*==中间主体==*/
        .div_container
        {
            width: 100%;
            height: 90%;
            border: 0px;
            overflow: auto;
        }
        
        /*==中间主体左侧==*/
        .div_container_left
        {
            background: url(../../../Skins/Default/Images/gridleft.gif);
            margin: 0px,5px,0px,0px;
            width: 8px;
            padding: 0px;
            text-align: left;
        }
        
        .div_container_center
        {
            text-align: center;
            vertical-align: top;
        }
        
        /*==中间主体右侧==*/
        .div_container_right
        {
            text-align: right;
            background: url(../../../Skins/Default/Images/gridright.gif);
            margin: 0px,0px,0px,8px;
            width: 9px;
            padding: 0px;
        }
        
        /*==底部==*/
        .divContainerFooter
        {
            float: left;
            height: 20px;
            background-image: url(../../../Skins/Default/Images/gridfoot.gif);
            overflow: hidden;
            width: 100%;
        }
        
        /*==底部左侧==*/
        .divContainerFooterLeft
        {
            height: 20px;
            width: 12px;
            background-image: url(../../../Skins/Default/Images/gridfootleft.gif);
            float: left;
        }
        
        /*==底部右侧==*/
        .divContainerFooterRight
        {
            height: 20px;
            width: 16px;
            background-image: url(../../../Skins/Default/Images/gridfootright.gif);
            float: right;
        }
        
        /*==底部实体==*/
        .divFooter
        {
            height: 20px;
            background: url(../../../Skins/Default/Images/gridfootright.gif) no-repeat scroll right center;
            line-height: 10px;
            position: relative;
        }
        
        .div_container_center #selected option
        {
            margin-left: 20px;
            padding-left: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script language="javascript" type="text/javascript">
        //绑定表项数据
        function getFieldSet(isShow) {
            $.post(getCurrentUrl(), { AjaxAction: "GetFieldSet", AjaxArgument: isShow }, function (value) {
                var ajaxResult = JSON2.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                        var retValue = ajaxResult.RetValue
                        if (retValue) {
                            var strHtml = "";
                            for (var i = 0; i < retValue.length; i++) {
                                strHtml += "<option value=\"" + retValue[i].FieldCode + "\">" + retValue[i].FieldShow + "</option>";
                            }
                            var selects = $("#selects");
                            if (isShow == "1") selects = $("#selected");
                            selects.empty();
                            if (strHtml != "") {
                                selects.append(strHtml);
                                selects.height(selects.parent().height());
                                selects.width(selects.parent().width());
                            }
                        }
                    }
                }
                else {
                    alert("系统出错，请与管理员联系！");
                }
            });
        }

        function BindValue() {
            var isShow = "0";
            getFieldSet(isShow);
            isShow = "1";
            getFieldSet(isShow);
        }

        $(document).ready(function () {
            BindValue();
        });


        //选取单个人员
        function chooseItem(me) {
            var $selectedItem = $("option:selected", me);
            var $selected = $("#selected");
            if ($("#chkbefore").attr("checked") == true) {
                var option = $selected.find("option:selected").get(0);
                if (!option) {
                    alert("请先在\“已选表项\"中选择一项 ！");
                    return;
                }
                $selectedItem.insertBefore($(option));
            }
            else {
                $selectedItem.removeAttr("selected").appendTo("#selected");
            }

            $selected.height($selected.parent().height());
            $selected.width($selected.parent().width());
        }

        //删除已选取的单个人员
        function delItem(me) {
            var selectedItem = $("option:selected", me);
            $(selectedItem).removeAttr("selected").prependTo("#selects");
        }

        //选取多个人员
        function chooseItems() {
            var $selected = $("#selected");
            var $selecteds = $("#selects").find("option:selected");

            if ($("#chkbefore").attr("checked") == true) {
                var option = $selected.find("option:selected").get(0);
                if (!option) {
                    alert("请先在\“已选表项\"中选择一项 ！");
                    return;
                }
                $selecteds.each(function () {
                    $(this).insertBefore($(option));
                });
                return;
            }
            else {
                $selecteds.each(function () {
                    $(this).removeAttr("selected").prependTo("#selected");
                });
            }

            $selected.height($selected.parent().height());
            $selected.width($selected.parent().width());
        }

        //选择所有项
        function chooseItemsAll() {
            var $selected = $("#selected");
            $("#selects").find("option").each(function () {
                $(this).removeAttr("selected").prependTo("#selected");
                $selected.height($selected.parent().height());
                $selected.width($selected.parent().width());
            });
        }

        //删除多个已选取的人员
        function delItems() {
            $("#selected").find("option:selected").each(function () {
                $(this).removeAttr("selected").prependTo("#selects");
            });
        }

        //删除所有
        function delItemsAll() {
            $("#selected").find("option").each(function () {
                $(this).removeAttr("selected").prependTo("#selects");
            });
        }

        //保存
        function save(me, argument) {
            var value = "";
            $("#selected").find("option").each(function () {
                value += $(this).val();
                value += ",";
            });
            $.post(getCurrentUrl(), { AjaxAction: "Save", AjaxArgument: value }, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                    if (ajaxResult.ActionResult == 1) {
                        if (message == "")
                            message = "操作成功！";
                    }
                }
                window.returnValue = "1";
                window.close();
            });
        }

    </script>
    <div id="resourceContainer" style="float: left; width: 100%; height: 100%; margin: 0 auto;">
        <div style="width: 40%; float: left; height: 100%;">
            <div class="divHeadSelf">
                <div class="divHeadLeft">
                </div>
                <div class="divHead">
                    <p>
                        待选表项</p>
                </div>
                <div class="divHeadRight">
                </div>
            </div>
            <table cellspacing="0" cellpadding="0" border="0" class="div_container" style="height: 85%;">
                <tbody>
                    <tr>
                        <td class="div_container_left">
                        </td>
                        <td class="div_container_center" style="vertical-align: top; overflow: auto; padding: 5px;
                            height: 100%;">
                            <select id="selects" ondblclick="javascript:chooseItem(this)" multiple="multiple"
                                style="width: 100%; height: 100%; display: block;">
                            </select>
                        </td>
                        <td class="div_container_right">
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="divContainerFooter">
                <div class="divContainerFooterLeft">
                </div>
                <div class="divFooter">
                </div>
                <div class="divContainerFooterRight">
                </div>
            </div>
        </div>
        <div style="width: 10%; overflow: hidden; float: left; margin: 0px; height: 90%;
            margin-right: auto; margin-left: auto; margin-top: auto; margin-bottom: auto;
            text-align: center;">
            <div style="vertical-align: middle; margin-top: 100px; margin-bottom: auto; height: 200px;">
                <ul class="commandbar" style="display: inline; vertical-align: middle;">
                    <li onclick="chooseItems();" onmouseover="CommandItemOver(this)" onmouseout="CommandItemOut(this)"
                        class="commanditem" id="cmdChoose" style="cursor: pointer;">选择-></li>
                    <li onclick="delItems();" onmouseover="CommandItemOver(this)" onmouseout="CommandItemOut(this)"
                        class="commanditem" id="cmdDel" style="cursor: pointer;"><-删除</li>
                    <li onclick="chooseItemsAll();" onmouseover="CommandItemOver(this)" onmouseout="CommandItemOut(this)"
                        class="commanditem" id="cmdChooseAll" style="cursor: pointer;">选择->></li>
                    <li onclick="delItemsAll();" onmouseover="CommandItemOver(this)" onmouseout="CommandItemOut(this)"
                        class="commanditem" id="cmdDelAll" style="cursor: pointer;"><<-删除</li>
                </ul>
            </div>
        </div>
        <div style="width: 40%; float: left; height: 100%;">
            <div class="divHeadSelf">
                <div class="divHeadLeft">
                </div>
                <div class="divHead">
                    <p>
                        已选表项<input id="chkbefore" type="checkbox" />在下表中所选一项前插入</p>
                </div>
                <div class="divHeadRight">
                </div>
            </div>
            <table cellspacing="0" cellpadding="0" border="0" class="div_container" style="height: 85%;">
                <tbody>
                    <tr>
                        <td class="div_container_left">
                        </td>
                        <td class="div_container_center" style="vertical-align: top; overflow: auto; padding: 5px;
                            height: 100%;">
                            <select id="selected" ondblclick="javascript:delItem(this)" multiple="multiple" style="width: 100%;
                                height: 100%; display: block;">
                            </select>
                        </td>
                        <td class="div_container_right">
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="divContainerFooter">
                <div class="divContainerFooterLeft">
                </div>
                <div class="divFooter">
                </div>
                <div class="divContainerFooterRight">
                </div>
            </div>
        </div>
    </div>
</asp:Content>
