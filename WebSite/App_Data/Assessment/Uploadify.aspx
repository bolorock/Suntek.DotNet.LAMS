<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true" CodeBehind="Uploadify.aspx.cs" Inherits="WebSite.Uploadify" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>

     <%--jquery.uploadify --%>
    <link rel="Stylesheet" href="../Scripts/JQuery.uploadify/uploadify.css" />
    <script type="text/javascript" src="../Scripts/JQuery.uploadify/swfobject.js"></script>
    <script type="text/javascript" src="../Scripts/JQuery.uploadify/jquery.uploadify.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

            $("#uploadify").uploadify({
                'uploader': '../Scripts/JQuery.uploadify/uploadify.swf',
                'script': 'Uploadify.aspx',
                'scriptData': { 'type': '1', 'surveyID': '<%= SurveyID %>' },
                'cancelImg': '../Scripts/JQuery.uploadify/cancel.png',
                //'folder': 'upload',
                'queueID': 'fileQueue',
                'fileExt': '*.xls',
                'fileDesc': 'Excel Files (.xls)',
                'auto': false,
                'multi': false,
                'buttonImg': '../Skins/Default/Images/upload.png',
                'wmode': 'transparent',
                'width': 25,
                'height': 25,
                'onError': function (event, ID, fileObj, errorObj) {
                    alert(errorObj.type + ' Error: ' + errorObj.info)
                },
                'onSelect': function (event, ID, fileObj) {
                    $("#msg").empty();
                    $("#msg").removeAttr("style");
                },
                'onComplete': function (event, ID, fileObj, response, data) {
                    $("#msg").empty();
                    if (response != "") {
                        //style="height:40px;overflow-y:auto;border:1px solid;"
                        $("#msg").css({ "overflow-y": "auto", "height": "80px", "border": "1px solid" });
                        var arr = response.split('&');
                        var code = arr[0];
                        var msg = arr[1];
                        switch (code) {
                            case "0":
                                $("#msg").append("【" + fileObj.name + "】：<br>")
                                $("#msg").append(msg.substring(0, msg.indexOf("<ErrorEnd>")) + "<br>");
                                break;
                            case "1":
                                $("#msg").removeAttr("style");
                                if (window.parent)
                                    window.parent.closeDialog();
                                break;
                        }
                        //刷新父页面
                        if (window.parent) {
                            window.parent.refreshGrid();
                        }
                    }
                }
            });
        });
    </script>
    <div>
        <a href="../FileTemplate/答题人导入表.xls" style="margin-left: 20px; text-align: left">下载模版</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="file" name="uploadify" id="uploadify" />
        <label style="font-size: larger; color: #c0c0c0; font-weight: bold;">
            浏览</label>&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:$('#uploadify').uploadifyUpload()">
                导入</a>| <a href="javascript:$('#uploadify').uploadifyClearQueue();">取消导入</a>
        <div id="fileQueue">
        </div>
    </div>
       <hr />
               <div id="msg">
        </div>
                  
</asp:Content>
