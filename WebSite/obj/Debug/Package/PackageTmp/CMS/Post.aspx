<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Post.aspx.cs" Inherits="WebSite.Post" %>

<html>
<head>
    <title></title>
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("DetailJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <style type="text/css">
        body
        {
            text-align: center;
            width: 100%;
        }
        .contentarea
        {
            border: 1px solid #D9D9D9;
            width: 70%;
            background: #F8FAFD;
            padding: 0px 50px;
            margin: 0 auto;
            text-align: center;
        }
        div.contentarea h1
        {
            padding-left: 22px;
        }
        h1
        {
            font: normal normal bold 20px/150% verdana, sans-serif;
            line-height: 60px;
            text-align: center;
        }
        .artInfo
        {
            color: #8A8A8A;
            text-align: center;
        }
        .blkCont
        {
            display: inline;
            text-align: left;
            margin: 20px;
            width: 98%;
        }
    </style>
    <script type="text/javascript" language="javascript">
        $(function () {
            getContentByID();
        })

        function getContentByID() {
            $.post(getCurrentUrl(), { AjaxAction: "GetContentByID" }, function (value) {
                var ajaxResult = JSON2.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                        var con = ajaxResult.RetValue;
                        $(".contentarea h1").append(con.Title);
                        $(".artInfo").append("<p class=\"line\"><span>" + con.PublishedTime.replace("T", " ").replace(".0000000", "").substring(0,16) + "</span> | <span>作者：" + con.author + "</span> | </p>");
                        $(".blkCont").append(con.Content);
                    }
                }
            });
        }
    </script>
</head>
<body>
    <div class="contentarea">
        <h1>
        </h1>
        <div class="artInfo">
        </div>
        <div class="blkCont">
        </div>
    </div>
</body>
</html>
