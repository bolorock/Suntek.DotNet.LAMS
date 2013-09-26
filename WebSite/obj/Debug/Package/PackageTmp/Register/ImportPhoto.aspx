<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ImportPhoto.aspx.cs" Inherits="WebSite.Register.ImportPhoto" %>

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

        <script type="text/javascript" language="javascript">

            $(function () {
                InitUploadify();
            });
            /*初始化上传控件*/
            function InitUploadify() {
                var auth = $("#<%=hfAuth.ClientID %>").val();
                var AspSessID = $("#<%=hfAspSessID.ClientID %>").val();
                $("#uploadify").uploadify({
                    'uploader': '../Scripts/JQuery.uploadify/uploadify.swf?t=' + new Date().getTime(), //加随机数解决在QQ、TT浏览器中，uploadify上传控件不能正常工作，显示出了上传进度条，但是进度不走
                    'script': 'UploadHandler.ashx',
                    'scriptData': {ASPSESSID: AspSessID, AUTHID: auth }, //后面两个参数是解决在非IE浏览器不能上传的问题。
                    'cancelImg': '../Scripts/JQuery.uploadify/cancel.png',
                    'queueID': 'fileQueue',
                    'fileExt': '*.jpg;*.gif;*.png',
                    'fileDesc': '*.jpg;*.gif;*.png',
                    'auto': true,
                    'multi': true,
                    'sizeLimit': '2097152', //2M 
                    'buttonImg': '../Skins/Default/Images/upload.png',
                    'wmode': 'transparent',
                    'removeCompleted': true,
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

                    },
                    'onAllComplete': function (event, data) {

                    }
                });
            }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div id="divContent" class="div_content" style="overflow: auto; height: 100%; width: 100%;
        overflow-x: hidden;">
        <div id="divUpload">
            <input type="file" name="uploadify" id="uploadify" /><label title="选取要导入的照片"
                style="font-size: larger; color: #c0c0c0; font-weight: bold;">批量导入照片</label>
            <div id="msg">
            </div>
        </div>
        <hr />
        <div id="fileQueue">
        </div>
    </div>
    <asp:HiddenField ID="hfAuth" runat="server" />
    <asp:HiddenField ID="hfAspSessID" runat="server" />
</asp:Content>
