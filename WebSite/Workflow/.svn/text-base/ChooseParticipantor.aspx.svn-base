<%@ Page Language="C#"  MasterPageFile="~/Master/Page.Master" AutoEventWireup="true" 
CodeBehind="ChooseParticipantor.aspx.cs" Inherits="WebSite.ChooseParticipantor" %>

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
        .gridview th
        {
            font-weight: normal;
            font-size: 12px;
            font-weight: bold;
            color: #2C59AA;
            text-indent: 4px;
            text-align: left;
            background: url(../Skins/Default/Images/th.gif);
            height: 22px;
            padding-left: 29px;
            border-color: #B5D6E6;
            border: 1px solid #8DB2E3;
        }
        
        .gridview td
        {
            font-size: 12px;
            text-indent: 4px;
            text-align:left;
            padding-left: 30px;
            border-color: #B5D6E6;
        }
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
    </style>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentPlace" runat="server">
    <script language="javascript" type="text/javascript">

        //页面初始化
        $(document).ready(function () {
            addChkAllClick("chkAll", "gridview");
        });

        //树节点单击获取部门下的人员
        function onNodeClick(id1, id2) {
            var type = $("#" + id1).attr("tag");
            $.post(getCurrentUrl(), { AjaxAction: "GetOrgOrRoleUsers", AjaxArgument: id1, Type: type }, function (value) {
                var ajaxResult = JSON2.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                        var retValue = ajaxResult.RetValue
                        if (retValue) {
                            var strHtml = "";
                            for (var i = 0; i < retValue.length; i++) {
                                strHtml += "<option value=\"" + retValue[i].ID + "\">" + retValue[i].Name + "</option>";
                            }
                            $("#selects").empty();
                            if (strHtml != "")
                                $("#selects").append(strHtml);
                        }
                        if (window.parent)
                            window.parent.closeDialog();
                    }
                }
                else {
                    alert("系统出错，请与管理员联系！");
                }
            });
        }

        //树节点双击选取部门或角色
        function onNodeDblclick(id1, id2) {
            if (id1 == "role") return;
            var me = $("#" + id1);
            var tag = $(me).attr("tag");
            var typeName = { Person: "人员", Role: "角色", Org: "组织" };
            var type = typeName[tag]; //获取类型名称
            var title = $(me).attr("title"); //名称
            createHtml(id1, title, type);
        }

        //为gridview添加一行
        function createHtml(id, name, type) {
            var tbody = $(".gridview tbody");
            var index = $(tbody).find("tr").length + 1; //序号
            if ($(tbody).find("tr").find("input[value='" + id + "']").length > 0) //存在的即返回
                return false;
            var strHtml = "<tr onmouseover=\"rowOver(this);\" onclick=\"rowClick(this,'" + id + "',true)\" onmouseout=\"rowOut(this);\" style=\"cursor: hand\">"
					        + "<td align=\"left\">"
                                + "<input id=\"radioId\" type=\"checkbox\" value='" + id + "' name=\"radioId\" />"
                            + "</td><td>" + index + "</td>"
                            + "<td>" + name + "</td>"
                            + "<td>" + type + "</td>"
                            + "<td><span ondblclick=\"delItem(this)\" title=\"双击进行操作\">删除</span></td>"
				         + "</tr>";
            $(tbody).prepend(strHtml);
            return true;
        }

        //选取单个人员
        function chooseItem(me) {
            var selectedItem = $("option:selected", me);
            var type = "人员";
            var id = $(selectedItem).val();
            var name = $(selectedItem).text();
            if (createHtml(id,name,type))
                $(selectedItem).remove();
        }

        //删除已选取的单个人员
        function delItem(me) {
            $(me).parent().parent().remove();
            changIndex();
        }

        //改变序号
        function changIndex() {
            var trs = $(".gridview tbody tr");
            var i = $(trs).length;
            if (i == 0) return;
            $(trs).each(function () {
                $("td", this).slice(1, 2).text(i);
                i--;
            });
        }

        //选取多个人员
        function chooseItems() {
            var type = "人员";
            var id = "";
            var name = "";
            $("#selects").find("option:selected").each(function () {
                id = $(this).val();
                name = $(this).text();
                if (createHtml(id, name, type))
                    $(this).remove();
            });
        }

        //删除多个已选取的人员
        function delItems() {
            var tbody = $(".gridview tbody");
            $(tbody).find("input[checked]").each(function () {
                var me = $(this).parent().parent();
                var tds = $("td", me);
                var id = $(this).val();
                var name = $(tds).slice(2, 3).text();
                if ($(tds).slice(3, 4).text() == "人员")
                    $("#selects").append("<option value=\"" + id + "\">" + name + "</option>")
                $(this).parent().parent().remove();
            });
            $("#chkAll").removeAttr("checked");
            changIndex();
        }

        //获取选择的人员的ID
        function getSelectedItems() {
            var participantors = new Array();
            var selectItems = "";
            $(".gridview tbody").find("input").each(function () {
                var me = $(this).parent().parent();
                var tds = $("td", me);
                var id = $(this).val();
                var name = $(tds).slice(2, 3).text();
                var type = $(tds).slice(3, 4).text();
                var item = { id: id, name: name, type: type };

                participantors.push(item);
            });
            return participantors;
        }

        //确定
        function chooseConfirm() {
            var items = getSelectedItems();
            window.returnValue = items;
            window.close();
        }
    </script>
    <div id="treeContainer" class="divPage" style="width: 40%; float: left; height: 100%; overflow: auto;">
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
            <div class="divHeadRight">
            </div>
        </div>
            <table cellspacing="0" cellpadding="0" border="0" class="div_container" style="height:38%;">
                <tbody>
                    <tr>
                        <td class="div_container_left">
                        </td>
                        <td class="div_container_center" style="vertical-align: top; overflow: auto; height: 100%;">
                            <select id="selects" ondblclick="javascript:chooseItem(this)" multiple="multiple"
                                style="width: 100%; height: 100%;">
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

        <div style="width: 100%; height: 5%; overflow: hidden; float:left;">
            <ul class="commandbar">
                <li class="commanditem_first"></li>
                <li onclick="chooseItems();" onmouseover="CommandItemOver(this)" onmouseout="CommandItemOut(this)" class="commanditem"
                    id="cmdChoose" style="cursor: pointer;">选择</li>
                <li onclick="delItems();" onmouseover="CommandItemOver(this)" onmouseout="CommandItemOut(this)" class="commanditem"
                    id="cmdDel" style="cursor: pointer;">删除</li><li class="commanditem_last">
                </li>
            </ul>
        </div>
        <div  class="divHeadSelf">
            <div class="divHeadLeft">
            </div>
            <div class="divHead">
                <p>
                    已选人员</p>
            </div>
            <div class="divHeadRight">
            </div>
        </div>
            <table cellspacing="0" cellpadding="0" border="0" class="div_container" style="height:38%;">
                <tbody>
                    <tr>
                        <td class="div_container_left">
                        </td>
                        <td class="div_container_center" style="vertical-align: top; overflow: auto; height: 100%;">
                            <div class="page_container_gridview" id="gvList" style="height:100%; overflow:auto;">
                                    <table class="gridview" cellspacing="0" rules="all" border="1" id="ctl00_contentPlace_gvList"
                                        style="border-collapse: collapse;">
                                        <thead>
                                            <tr>
                                                <th nowrap="nowrap" scope="col">
                                                    <input id="chkAll" type="checkbox" name="chkAll" style="margin-left: 1px;" />选择
                                                </th>
                                                <th nowrap="nowrap" scope="col">
                                                    序号
                                                </th>
                                                <th nowrap="nowrap" scope="col">
                                                    名称
                                                </th>
                                                <th nowrap="nowrap" scope="col">
                                                    类型
                                                </th>
                                                <th nowrap="nowrap" scope="col">
                                                    操作
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                            </div>
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