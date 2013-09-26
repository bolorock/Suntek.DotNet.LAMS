<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContentMore.aspx.cs" Inherits="WebSite.ContentMore" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("DetailJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <script src="../Scripts/jquery.pagination/jquery.pagination.js" type="text/javascript"></script>
    <link href="../Scripts/jquery.pagination/pagination.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .widget
        {
            margin: 1em;
            border: #C5D7EF solid 1px;
            width: 70%;
            margin: 0 auto;
        }
        .header
        {
            padding: 0.3em;
            background-color: #DAEFF6;
        }
        .header strong
        {
            font-weight: normal;
            font-size: 12px;
            font-weight: bold;
        }
        .content
        {
            border: 1px solid #D9D9D9;
            padding: 0px 50px;
        }
        div ul li
        {
            list-style-type: disc;
            list-style-position: inside;
            padding-left: 15px;
        }
        li .time
        {
            color: gray;
        }
    </style>
    <script type="text/javascript" language="javascript">
        var temp = 0;
        $(function () {
            //getContentByWidetsCode();
            initPagination(1);
        })

        /*初始化分页控件*/
        function initPagination(itemCount) {
            $("#Pagination").pagination(itemCount, {
                callback: getContentByWidetsCode,
                items_per_page: 20,//每页显示条数
                num_display_entries: 10,
                num_edge_entries: 2,
                prev_text: "前一页",
                next_text: "后一页"
            });
        }


        /*获取发布的内容并加入相对应的部件*/
        function getContentByWidetsCode(page_index, jq) {
            $.post(getCurrentUrl(), { AjaxAction: "GetContentByWidetsCode", pageIndex: page_index + 1, pageSize: 20}, function (value) {
                var ajaxResult = JSON2.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                        showAllContent('<%= WidgetsCode %>', ajaxResult.RetValue.rows);
                        if (temp == 0) {
                            temp = 1;
                            initPagination(ajaxResult.RetValue.ItemCount);
                        }
                    }
                }
            });
        }

        /*在部件中加入内容*/
        function showAllContent(code, rows) {
            var strHtml = "<ul>";
            var num = rows.length;
            for (var i = 0; i < num; i++) {
                var title = rows[i].Title; //标题
                if (title.length > 30)
                    title = title.substring(0, 25) + "……";
                title += "<span class=\"time\"> -  " + rows[i].PublishedTime.replace("T", " ").replace(".0000000", "").substring(0, 16) + "</span>";
                if (rows[i].IsMain == "1") { //头条
                    strHtml = "<h3 class=\"mainTitle\"><a target=\"_blank\" href=\"Post.aspx?id=" + rows[i].ID + "\">" + title + "</a></h3>" + strHtml;
                }
                else {
                    strHtml += "<li><a target=\"_blank\" href=\"Post.aspx?id=" + rows[i].ID + "\">" + title + "</a></li>";
                }
            }
            $(".content").empty();
            $(".content").append(strHtml + "</ul>");
            $(".header strong").text('<%= WidgetName %>');
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="widget">
        <div class="header">
            <strong>手机</strong>
        </div>
        <div class="content">
        </div>
        <div id="Pagination">
        </div>
    </div>
    </form>
</body>
</html>
