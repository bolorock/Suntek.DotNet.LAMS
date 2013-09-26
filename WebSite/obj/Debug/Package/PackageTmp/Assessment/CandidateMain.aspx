<%@ Page Language="C#"  MasterPageFile="~/Master/Page.Master" AutoEventWireup="true" CodeBehind="CandidateMain.aspx.cs" Inherits="WebSite.CandidateMain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs") %>
    <%if (false)
      { %>
    <script   src="../Scripts/jquery-vsdoc.js"  type="text/javascript"></script>
    <%}%>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script language="javascript" type="text/javascript">
        function autoHeight() {
//            $("#div3").height($(window.parent.main).height() - 130);
//            $("#div4").height($(window.parent.main).height() - 115);
        }
        $(document).ready(function () {
            autoHeight();

            $(window).resize(function () {
                autoHeight();
            });
        });

        function save(me, argument) {
            var frm = window.frames["ifrMain"].save(me, argument); ;
        }

        function fff() {
            alert("xixi");
        }


        function clearList() {
            $("#hdfAnswerIDs").val("");
            $("#AnswerList").html("");
        }


        function delAnswerItem(me) {
            $(me).parent().remove();
        }

        function chooseConfirm() {

            var answerIDs = $("#ctl00_contentPlace_hdfAnswerIDs", window.parent.document);
            var answerList = $("#AnswerList", window.parent.document);
            answerList.html($("#AnswerList").html());
            answerIDs.val($("#hdfAnswerIDs").val());
           
        }

    </script>
    <div id="tbContainer">
    <input type="button" value="确定" onclick="chooseConfirm()" />

        <table border="1" width="100%" bordercolor="#82A9DF" style="margin-bottom: 0px; border-collapse: collapse;">
            <tr>
                <td width="100%" class="toptitle5">
                    <div class="toptitle">
                        后备经理人</div>
                </td>
            </tr>

            <tr>
            <td>

           <input type="text" id="hdfAnswerIDs" />
          <div id="AnswerList">

            <div id="">
            林阿准 <a href="javascript:void(0)" onclick="delAnswerItem(this)">[删除]</a>
            </div>

            </div>

        </div>
            
            </td>
            </tr>
            <tr>
                <td width="100%" height="*" bgcolor="#FFFFFF" valign="top" class="area02">
                    <!--****************************************区域2****************************************-->
                    <div id="area2">
                        <div id="divFolder" style="width: 100%; height: 100%; overflow: auto;">
                            <table width="100%">
                                <tr>
                                    <td valign="top" width="240px">
                                        <table border="1" width="100%" bordercolor="#82A9DF" style="margin-bottom: 0px; border-collapse: collapse;"
                                            height="100%">
                                            <tr>
                                                <td width="100%" class="toptitle">
                                                    组织树
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="100%" height="*" bgcolor="#FFFFFF" valign="top" class="area02">
                                                    <!--****************************************区域2****************************************-->
                                                    <div id="Div2">
                                                        <div id="div3" style="overflow: auto; height:300px;">
                                                            <iframe id="ifrTree" name="ifrTree" src="CandidateTree.aspx" width="230px" height="100%" height="200px"
                                                                frameborder="0" scrolling="auto"></iframe>
                                                        </div>
                                                    </div>
                                                    <!--****************************************区域2 END****************************************-->
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td valign="top">
                                        <div id="div4" style="overflow: visible; height:400px;">
                                            <iframe id="ifrMain" name="ifrMain" src="CandidateMList.aspx?layer=1&grade=<%= Grade %><%= Grade=="0" ? string.Empty: "&corpID="+User.CorpID %>" width="100%"
                                                height="100%" frameborder="0" scrolling="auto"></iframe>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <!--****************************************区域2 END****************************************-->
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
