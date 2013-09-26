<%@ Page Title="" Language="C#" AutoEventWireup="true"
    CodeBehind="SurveyTodo.aspx.cs" Inherits="WebSite.SurveyTodo" %>
    <html>
<head>
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <script type="text/javascript" language="javascript">




        //删除左右两端的空格
        function trim(str) {
            return str.replace(/(^\s*)|(\s*$)/g, "");
        }

        //检查测评状态
        function checkStatus(action) {
            var status = $("#divContent tbody").find("input[checked]").parent().parent().find("td").last().text();
            status = trim(status)
            if (status == "已发布" || status == "已完成") {
                alert("该测评活动" + status + "，不能再" + action);
                return false;
            }
            return true;
        }

     
        function rowOut(me) {
            if (oldRow != null) {
                if (currentRow != me) {
                    me.className = "rowout";
                }
                oldRow = me;
            }
        }
//        function rowClick(me, id, remember) {

//            openOperateDialog("进行测评", "ExamShow.aspx?CurrentId=" + rad + "&Entry=Preview", 860, 520, true, 1);
//       
//        }

        cacheArray = new Array();
        function rowDbClick(me, id, remember) {
           
        }


      
     

        function testgo(me, argument) {
            var rad = $("#divContent").find(":checked ").first().attr("ExamPaperID");
            if (rad == "") {
                alert("试卷参数有误！");
                return false;
            }
            var surveyID = $("#divContent").find(":checked ").first().val();
            location.href = "ExamShow.aspx?CurrentId=" + rad + "&surveyID=" + surveyID + "&m=" + Math.random();

        }


        //关闭窗口
        function closeDialog(fieldTypeId) {
            $("#actionDialog").dialog("close");
        }


        function testGo(url) {
            openOperateDialog("进行测评", url, 1010, 680, true, 1);
        }

    </script></head>
<body>
  <%--  <div id="divContent" class="div_content">--%>
  <ul>
        <asp:Repeater ID="rptList" runat="server">
        <ItemTemplate>
        <li><a  style="cursor:pointer;" onclick='testGo($(this).attr("url"))' url='ExamShow.aspx?CurrentId=<%#Eval("ExamPaperID")%>&surveyID=<%#Eval("ID") %>' title="点击进入测评" href="javascript:void(0)"> <%#Eval("Title")%></a></li>
        </ItemTemplate>

        </asp:Repeater>
</ul>
<asp:Literal ID="litTips" Text="暂没有任何待测评记录" Visible="false" runat="server"></asp:Literal>
  <%--  </div>--%>

</body>
</html>

