<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ChooseOrgEmployee.aspx.cs" Inherits="WebSite.ChooseOrgEmployee" %>

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
<asp:Content ID="Content3" ContentPlaceHolderID="contentPlace" runat="server">
    <script language="javascript" type="text/javascript">

        //获取部门下的人员
        function onNodeClick(id1, id2) {
            $.post(getCurrentUrl(), { AjaxAction: "GetOrgUser", AjaxArgument: id1 }, function (value) {
                var ajaxResult = JSON2.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                        var retValue = ajaxResult.RetValue
                        if (retValue) {
                            var strHtml = "";
                            for (var i = 0; i < retValue.length; i++) {
                                strHtml += "<option value=\"" + retValue[i].ID + "\">" + retValue[i].Name + "</option>";
                            }
                            var selects = $("#selects");
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

        //选取单个人员
        function chooseItem(me) {
            var role = $("#<%=ddlRole.ClientID %>").find("option:selected").eq(0);
            var optgroup = $("#selected").find("optgroup[id='" + role.val() + "']");
            var selectedItem = $("option:selected", me);
            var selected = $("#selected");
            //先判断是否存在再添加,还要去掉selected,
            if (selected.find("option[value='" + $(selectedItem).val() + "']").length == 0) {
                if (optgroup.length == 0) {
                    $(selectedItem).removeAttr("selected").clone().prependTo("#selected");
                }
                else {
                    optgroup.after($(selectedItem).removeAttr("selected").clone().attr("group", optgroup.attr("id")));
                }
                selected.height(selected.parent().height());
                selected.width(selected.parent().width());
                $(selectedItem).remove();
            }
        }

        //删除已选取的单个人员
        function delItem(me) {
            var selectedItem = $("option:selected", me);
            if ($("#selects").find("option[value='" + $(selectedItem).val() + "']").length == 0) {
                $(selectedItem).removeAttr("selected").removeAttr("group").clone().prependTo("#selects");
                $(selectedItem).remove();
            }
        }

        //选取多个人员
        function chooseItems() {
            var role = $("#<%=ddlRole.ClientID %>").find("option:selected").eq(0);
            var optgroup = $("#selected").find("optgroup[id='" + role.val() + "']");
            var selected = $("#selected");
            $("#selects").find("option:selected").each(function () {
                if (selected.find("option[value='" + $(this).val() + "']").length == 0) {
                    if (optgroup.length == 0) {
                        $(this).removeAttr("selected").clone().prependTo("#selected");
                    }
                    else {
                        optgroup.after($(this).removeAttr("selected").clone().attr("group", optgroup.attr("id")));

                    }
                    selected.height(selected.parent().height());
                    selected.width(selected.parent().width());
                    $(this).remove();
                }
            });
        }

        //删除多个已选取的人员
        function delItems() {
            $("#selected").find("option:selected").each(function () {
                if ($("#selects").find("option[value='" + $(this).val() + "']").length == 0) {
                    $(this).removeAttr("selected").removeAttr("group").clone().prependTo("#selects");

                    $(this).remove();
                }
            });
        }

        //获取选择的人员的ID
        function getSelectedItemsIds() {
            var selectItems = "";
            $("#selected").find("option").each(function () {
                selectItems += $(this).val() + "," + $(this).attr("group") + "$";
            });
            return selectItems;
        }

        //获取选择的人员，返回数组
        function getSelectedItems() {
            var rtnValue = new Array();
            $("#selected").find("option").each(function () {
                var txt = $(this).text();
                var index = txt.indexOf("——");
                if (index > 0) {
                    txt = txt.slice(0, index);
                }
                var item = { id: $(this).val(), name: txt };
                rtnValue.push(item);
            });
            return rtnValue;
        }

        //确定
        function chooseConfirm() {
            var para = getUrlPara("rtnType");
            if (para == "1") {
                var items = getSelectedItems();
                var ids = "";
                var names = "";
                for (var i = 0; i < items.length; i++) {
                    ids += items[i].id + ","
                    names += items[i].name + ",";
                }
                var retValue = new Object();
                retValue.text = names.slice(0, names.length - 1);
                retValue.value = ids.slice(0, ids.length - 1);
                window.returnValue = retValue;
            }
            else {
                var ids = getSelectedItemsIds();
                window.returnValue = ids;
            }
            window.close();
        }

        $(document).ready(function () {
            fetchRole();
            bindValue();
        });

        /*绑定已选数据*/
        function bindValue() {
            var para = getUrlPara("bindValue");
            if (para == "1") {
                var obj = window.dialogArguments;
                var names = obj.name.split(',');
                var ids = obj.id.split(',');
                var selected = $("#selected");
                var strHtml = "";
                for (var i = 0; i < ids.length; i++) {
                    strHtml += "<option value=\"" + ids[i] + "\">" + names[i] + "</option>";
                }
                if (strHtml != "") {
                    $(selected).append(strHtml);
                }
            }
        }



        //将角色列表 附加到选中的分组
        function fetchRole() {

            $("#<%=ddlRole.ClientID %>").find("option").each(function () {
                var item = "<optgroup label=" + $(this).text() + " id=" + $(this).val() + "></optgroup>";
                $(item).prependTo("#selected");
            });
        }

        //查找人员
        function search() {
            var para = $("#txtSearch").val();
            para = para.replace(/，/g, ",");
            var len = para.length;

            //去掉多余的逗号
            while (para.indexOf(",") == 0) {
                para = para.slice(1);
                len = len - 1;
            }

            while (para.lastIndexOf(",") == len - 1) {
                para = para.slice(0, len - 1);
                len = len - 1;
            }

            if (para.indexOf(",") > 0) {
                para = para.replace(/,/g, "','");
            }
            $.post(getCurrentUrl(), { AjaxAction: "SearchUser", AjaxArgument: para }, function (value) {
                var ajaxResult = JSON2.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                        var retValue = ajaxResult.RetValue
                        if (retValue) {
                            var strHtml = "";
                            for (var i = 0; i < retValue.length; i++) {
                                strHtml += "<option value=\"" + retValue[i].ID + "\">" + retValue[i].Name + "——(" + retValue[i].Code + ")" + "</option>";
                            }
                            var selects = $("#selects");
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

    </script>
    <div id="treeContainer" class="divPage" style="width: 40%; float: left; height: 100%;
        overflow: auto;">
        <div class="divHeadSelf">
            <div class="divHeadLeft">
            </div>
            <div class="divHead">
                <p>
                    组织机构</p>
            </div>
            <div class="divHeadRight">
            </div>
        </div>
        <table cellspacing="0" cellpadding="0" border="0" class="div_container">
            <tbody>
                <tr>
                    <td class="div_container_left">
                    </td>
                    <td class="div_container_center" style="vertical-align: top; overflow: auto; height: 100%;">
                        <suntek:AjaxTree ID="AjaxTree1" Runat="server" />
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
    <div id="resourceContainer" style="float: left; width: 60%; height: 100%; margin: 0 auto;">
        <div class="divHeadSelf">
            <div class="divHeadLeft">
            </div>
            <div class="divHead">
                <p>
                    待选人员</p>
            </div>
            <div class="divSearch">
                <input type="text" id="txtSearch" title="可以输入人员编号或姓名进行查找" style="width: 200px; height: 100%;" />
                <input type="button" id="cmdSearch" onclick="search()" value="查找" style="width: 60px;" />
            </div>
            <div class="divHeadRight">
            </div>
        </div>
        <table cellspacing="0" cellpadding="0" border="0" class="div_container" style="height: 38%;">
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
        <div style="width: 100%; overflow: hidden; float: left; margin: 0px;">
            <ul class="commandbar" style="display: inline;">
                <li onclick="chooseItems();" onmouseover="CommandItemOver(this)" onmouseout="CommandItemOut(this)"
                    class="commanditem" id="cmdChoose" style="cursor: pointer;">选择</li>
                <li onclick="delItems();" onmouseover="CommandItemOver(this)" onmouseout="CommandItemOut(this)"
                    class="commanditem" id="cmdDel" style="cursor: pointer;">删除</li>
                <li class="commanditem">
                    <asp:DropDownList ID="ddlRole" runat="server" Visible="false">
                    </asp:DropDownList>
                </li>
            </ul>
        </div>
        <div class="divHeadSelf">
            <div class="divHeadLeft">
            </div>
            <div class="divHead">
                <p>
                    已选人员</p>
            </div>
            <div class="divHeadRight">
            </div>
        </div>
        <table cellspacing="0" cellpadding="0" border="0" class="div_container" style="height: 38%;">
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
</asp:Content>
