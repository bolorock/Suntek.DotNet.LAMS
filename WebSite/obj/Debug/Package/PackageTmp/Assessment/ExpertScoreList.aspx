<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ExpertScoreList.aspx.cs" Inherits="WebSite.ExpertScoreList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript" language="javascript">


      
        function score(me, argument) {
            var rad = $("#divContent").find(":checked ").first().val();
            if (rad == "") {
                alert("参数有误！");
                return false;
            }
            openOperateDialog("专家评分", "ExpertScore.aspx?CurrentID=" + rad + "", 900, 600, true, 1);
        }


    

        //关闭窗口
        function closeDialog(fieldTypeId) {
            $("#actionDialog").dialog("close");
        }

        function viewResult(me, argument) {
            var rad = $("#divContent").find(":checked ").first().val();
            location.href = "SurveyResultManager.aspx?CurrentId=" + rad + "&m=" + Math.random();
        }


        function viewMyResult(me, argument) {
            //var rad = $("#divContent").find(":checked ").first().attr("ExamPaperID");
            var rad = $("#divContent").find(":checked ").first().val();
            if (rad == "") {
                alert("试卷参数有误！");
                return false;
            }
            openOperateDialog("专家评分", "ExpertScore.aspx?CurrentID=" + rad + "", 900, 600, true, 1);
//            var surveyID = $("#divContent").find(":checked ").first().val();
//            location.href = "ExamShow.aspx?CurrentId=" + rad + "&surveyID=" + surveyID + "&Entry=myResult&m=" + Math.random();

        }


       

        //查看进度
        function viewProcess(me, argument) {
            var rad = $("#divContent").find(":checked ").first().val();
            openOperateDialog("设置专家", "SurveyExpert.aspx?CurrentID=" + rad + "&Entry=ExpertSet", 900, 600, true, 1);

        }

    </script>
    <div id="divContent" class="div_content">
        <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
            DataKeyNames="ID">
            <Columns>
                <asp:TemplateField HeaderText="">
                    <ItemTemplate>
                        <input id="radioId" type="radio" value='<%#Eval("ID") %>'
                            name="radioId" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="测评名称">
                    <ItemTemplate>
                        <%#Eval("Title")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="对象">
                    <ItemTemplate>
                        <%#Eval("Name")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="发布时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("CreateTime")).ToShortDateString()%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="状态" HeaderStyle-Wrap="false">
                    <ItemTemplate>
                        <%#GetStatus(Eval("Status").ToString())%>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </suntek:PagedGridView>
    </div>
    <div id="filterDialog" title="查询">
        <p id="validateTips">
        </p>
        <fieldset>
            <dl>
                <dt class="rowlable">测评名称</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterTitle" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">试卷ID</dt>
                <dd class="rowinput">
                    <suntek:ChooseBox ID="filterExamPaperID" OpenUrl="ExamPaperIDTree.aspx" DialogTitle="选择试卷ID"
                        runat="server"></suntek:ChooseBox>
                </dd>
                <dt class="rowlable">360测评=1; 动机测评=2; 团队效能测评=3; 优势与特点测评=4; Disc测评=5; 情景模拟=21; 案例分析=22;
                    关键事件访谈=23; </dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterCategory" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">归属组织</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterOwnerOrg" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">考试时间</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterLimitTime" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">结束时间</dt>
                <dd class="rowinput">
                    <suntek:DatePicker ID="filterEndTime" runat="server"></suntek:DatePicker>
                </dd>
                <dt class="rowlable">创建者</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterCreator" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">创建时间</dt>
                <dd class="rowinput">
                    <suntek:DatePicker ID="filterCreateTime" runat="server"></suntek:DatePicker>
                </dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>
