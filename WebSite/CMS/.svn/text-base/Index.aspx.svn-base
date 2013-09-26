<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="WebSite.Index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <link href="../Scripts/jquery.easywidgets/jquery.easywidgets.css" rel="stylesheet"
        type="text/css" />
    <script src="../Scripts/jquery.easywidgets/jquery.easywidgets.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.corner.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">

        /*-------------------------部件有关------------------------------------------*/
        /*获取部件配置信息*/
        function getWidgetsConfig() {
            $.post(getCurrentUrl(), { AjaxAction: "GetWidgetsConfig" }, function (value) {
                var ajaxResult = JSON2.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                        createWidgets(ajaxResult.RetValue);
                        $("#widgetAdd").empty(); //清空页面添加的部件的html
                        $(".widget").corner("round top 8px"); //部件圆角
                        initWidgets(); //初始化部件
                    }
                }
            });
        }

        /*创建部件*/
        function createWidgets(config) {
            //部件列数
            var widgetsPlace = config.widgetPlace;
            var widgets = config.rows;
            //创建部件板块
            createWidgetsPlace(widgetsPlace);
            setWidth(".widget-place", widgetsPlace);

            var placeID = "widget-place-";
            var j = 1;
            for (i = 0; i < widgets.length; i++) {
                if (j > widgetsPlace)
                    j = 1;
                if (createWidgetByConfig(widgets[i], placeID + j))
                    j++;
            }
        }

        /*创建部件板块*/
        function createWidgetsPlace(num) {
            //<div class="widget-place" id="widget-place-1">
            var divContent = $("#divContent");
            for (var i = 1; i <= num; i++) {
                $("<div>", {
                    "class": "widget-place",
                    "id": "widget-place-" + i
                }).appendTo(divContent);
            }
        }

        /*设置列数*/
        function setWidth(place, columnNum) {
            var width = "49%";
            switch (columnNum) {
                case 1:
                    width = "98%";
                    break;
                case 2:
                    width = "49%";
                    break;
                case 3:
                    width = "33.3%";
                    break;
                case 4:
                    width = "24.5%";
                    break;
            }
            $(place).css("width", width);
        }

        /*根据配置创建一个部件*/
        function createWidgetByConfig(widget, placeId) {
            //配置class
            var arr = new Array();
            arr.push("widget");
            if (widget.Movable == "1")
                arr.push("movable")
            if (widget.Removable == "1")
                arr.push("removable")
            if (widget.Closeconfirm == "1")
                arr.push("closeconfirm")
            if (widget.Collapsable == "1")
                arr.push("collapsable");
            if (widget.Editable == "1")
                arr.push("editable");
            var widgetClass = arr.join(" ");

            var content = createWidgetContent(widget.AddType, widget.Code, widget.URL);
            if (content == null) return false;

            var divWidget = $("<div>", {
                "class": widgetClass,
                "id": widget.ID
            });
            var divHeader = $("<div>", {
                "class": "widget-header",
                html: "<strong>" + widget.Name + "</strong>"
            });
            var divContent = $("<div>", {
                "class": "widget-content",
                html: content
            });
            divWidget.append(divHeader);
            divWidget.append(divContent);
            $("#" + placeId).append(divWidget);
            return true;
        }

        /*创建部件内容*/
        function createWidgetContent(addType, code, url) {
            if (addType == "0" || addType == "1") {//自动创建或页面直接添加
                var tmp = $("#" + code, $("#widgetAdd"));
                if (tmp.length > 0)
                    return tmp;
                else
                    return null;
            }
            else if (addType == "2") {//链接其它页面
                return createFrame(url, code);
            }
            return null;
        }
        /*创建链接到其它页面的部件内容*/
        function createFrame(url, frm) {
            var s = '<div style="height:100%;overflow: auto;"><iframe name="' + frm + '" scrolling="no" frameborder="0" onload="setCwinHeight(this)"  src="' + url + '" style="width:100%;s"></iframe>';
            return s;
        }

        /*ifremae自适应高度*/
        function setCwinHeight(iframeObj) {
            var ifh = 0;
            if (document.getElementById) {
                if (iframeObj) {
                    if (iframeObj.contentDocument && iframeObj.contentDocument.body.offsetHeight) {
                        ifh = iframeObj.contentDocument.body.offsetHeight;
                    } else if (document.frames[iframeObj.name].document && document.frames[iframeObj.name].document.body.scrollHeight) {
                        ifh = document.frames[iframeObj.name].document.body.scrollHeight;
                    }
                }
            }
            iframeObj.height = (ifh > 480 ? 480 : ifh);
        }

        /*初始化部件*/
        function initWidgets() {
            $.fn.EasyWidgets({
                i18n: {
                    editText: '<img src="../Scripts/jquery.easywidgets/images/edit.png" alt="编辑" width="16" height="16" />',
                    closeText: '<img src="../Scripts/jquery.easywidgets/images/close.png" alt="关闭" width="16" height="16" />',
                    collapseText: '<img src="../Scripts/jquery.easywidgets/images/collapse.png" alt="折叠" width="16" height="16" />',
                    cancelEditText: '<img src="../Scripts/jquery.easywidgets/images/edit.png" alt="取消" width="16" height="16" />',
                    extendText: '<img src="../Scripts/jquery.easywidgets/images/extend.png" alt="展开" width="16" height="16" />',
                    editTitle: '编辑',
                    closeTitle: '关闭',
                    confirmMsg: '关闭这个部件?',
                    cancelEditTitle: '取消编辑 ',
                    extendTitle: '展开',
                    collapseTitle: '折叠'
                },
                behaviour: {
                    useCookies: true
                },
                effects: {
                    effectDuration: 200,
                    widgetShow: 'fade',
                    widgetHide: 'fade',
                    widgetClose: 'fade',
                    widgetExtend: 'fade',
                    widgetCollapse: 'fade',
                    widgetOpenEdit: 'fade',
                    widgetCloseEdit: 'fade',
                    widgetCancelEdit: 'fade'
                }
            });
        }
        /*----------------------------------部件有关 End---------------------------------------------*/

        /*获取发布的内容并加入相对应的部件*/
        function getWidgetsContent() {
            $.post(getCurrentUrl(), { AjaxAction: "GetWidgetsContent" }, function (value) {
                var ajaxResult = JSON2.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                        addContentToWidgets(ajaxResult.RetValue);
                        getWidgetsConfig(); //放在 $(function ()处会时不时出行不执行次函数的错误。
                    }
                }
            });
        }

        /*在部件中加入内容*/
        function addContentToWidgets(rows) {
            var temp = "temp";
            var strHtml = "<ul>";
            //加上"更多"链接
            var divMore = "";
            var num = rows.length;
            for (var i = 0; i < num; i++) {
                if (temp != rows[i].WidgetsCode && temp != "temp") {
                    divMore = "<div class=\"divMore\"><a target=\"_blank\" href=\"ContentMore.aspx?code=" + temp + "\">更多»</a></div>";
                    strHtml = "<div id=\"" + temp + "\">" + strHtml + "</ul>" + divMore + "</div>";
                    $("#widgetAdd").append(strHtml);
                    strHtml = "<ul>";
                }
                var title = rows[i].Title; //标题
                if (title.length > 30)
                    title = title.substring(0, 25) + "……";

                if (rows[i].IsMain == "1") { //头条
                    strHtml = "<h3 class=\"mainTitle\"><a target=\"_blank\" href=\"Post.aspx?id=" + rows[i].ID + "\">" + title + "</a></h3>" + strHtml;
                }
                else {
                    strHtml += "<li><a target=\"_blank\" href=\"Post.aspx?id=" + rows[i].ID + "\">" + title + "</a></li>";
                }
                temp = rows[i].WidgetsCode;
                if (i == num - 1) {//最后一条
                    divMore = "<div class=\"divMore\"><a target=\"_blank\" href=\"ContentMore.aspx?code=" + temp + "\">更多»</a></div>";
                    strHtml = "<div id=\"" + temp + "\">" + strHtml + "</ul>" + divMore + "</div>";
                    $("#widgetAdd").append(strHtml);
                }

            }

        }

        $(function () {
            getWidgetsContent();
        })
    </script>
    <style type="text/css">
        .widget-placeholder
        {
            color: #000;
            margin: 1em;
            background-color: #ebebeb;
        }
        
        .widget
        {
            margin: 1em;
            border: #C5D7EF solid 1px;
        }
        
        .widget-header
        {
            padding-bottom: 0.3em;
            padding-top: 0.3em;
            background-color: #DAEFF6;
            clear: both;
            float: left;
            width: 100%;
        }
        
        .widget-header strong
        {
            font-weight: normal;
            font-size: 12px;
            font-weight: bold;
            float: left;
            clear: both;
            margin-left: 3px;
            margin-top: 3px;
        }
        
        .widget-menu
        {
            position: relative;
            float: right;
            margin-right: 3px;
            margin-top: 3px;
        }
        
        .widget-content
        {
            padding: 0.5em;
            border: 1px solid #C5D7EF;
            clear: both;
        }
        div ul li
        {
            background: url(../Skins/Default/Images/allicon.png) no-repeat -5px -210px;
            padding-left: 15px;
        }
        .mainTitle
        {
            font-size: 14px;
            font-weight: bold;
            height: 22px;
            margin-bottom: 3px;
            overflow: hidden;
        }
        .divMore
        {
            font-size: 12px;
            text-align: right;
            width: 100%;
        }
        .divMore a
        {
            color: #4272DB;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="divContent" style="height: 500px; overflow: auto;">
    </div>
    <%--要在页面添加部件的，请在id为widgetAdd的div中添加--%>
    <div id="widgetAdd">
        <div id="pageAddTo">
        </div>
    </div>
    </form>
</body>
</html>
