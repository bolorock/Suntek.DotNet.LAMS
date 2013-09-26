<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="SubjectManager.aspx.cs" Inherits="WebSite.SubjectManager" %>

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


        function edit(me, argument) {
            var rad = $("#divContent").find(":checked ").first().val();
            if ($.trim(rad) == "") {
                alert("请先选择要编辑的记录");
                return false;
            }
            openOperateDialog("编辑试题", "SubjectDetail.aspx?CurrentId=" + rad + "&m=" + Math.random(), 800, 780,true,1);
            refresh(); //刷新当前页面
        }

        function add(me, argument) {
            openOperateDialog("新增试题", "SubjectDetail.aspx", 800, 500, true, 1);
            refresh(); //刷新当前页面
        }


        function del(me, argument) {
            if (!confirm("是否确定删除记录？")) {
                return false;
            }
            var rad = $("#divContent").find(":checked ").first(); //.val();
            var id = rad.val();
            if ($.trim(id) == "") {

                alert("操作失败");
                return;
            }

            $.post(getCurrentUrl(), { AjaxAction: "Delete", AjaxArgument: id }, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                    if (ajaxResult.ActionResult == 1) {
                        if (message == "")
                            message = "操作成功！";
                        rad.parent().parent().remove();
                        $("#gvList_ItemCount").text(parseInt($("#gvList_ItemCount").text()) - 1);
                    }
                }
                alert(message);

               
            });
           
        }


        function rowDbClick(me, id, remember) {
            var rad = $("#divContent").find(":checked ").first().val();
            openOperateDialog("查看", "SubjectDetail.aspx?ActionFlag=View&Entry=View&CurrentId=" + rad + "&m=" + Math.random(), 800, 780, true, 1);
                }



        //重写打开窗口以实现刷新页面
   


    </script>
    <div id="divContent" class="div_content">
        <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
            DataKeyNames="ID">
            <Columns>
                <asp:TemplateField HeaderText="选择">
                    <ItemTemplate>
                        <input id="radioId" type="radio" value='<%#Eval("ID") %>' name="radioId" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="题目标题">
                    <ItemTemplate>
                        <%#DealLength(Eval("SubjectTitle"))%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="题型">
                    <ItemTemplate>
                        <%# RemarkAttribute.GetEnumRemark((SubjectType)Enum.Parse(typeof(SubjectType), Eval("SubjectType").ToString()))%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="所属分类">
                    <ItemTemplate>
                        <%# RemarkAttribute.GetEnumRemark((SubjectCategory)Enum.Parse(typeof(SubjectCategory), Eval("Category").ToString()))%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="参考答案">
                    <ItemTemplate>
                        <%#Eval("Answer")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="默认分值">
                    <ItemTemplate>
                        <%#Eval("DefaultScore")%>
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
                <dt class="rowlable">题目标题</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterSubjectTitle" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">单选=1; 多选=2; 填空=3; 问答=4;</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterSubjectType" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                    </suntek:ComboBox>
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
                <dt class="rowlable">参考答案</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterAnswer" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">默认分值</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterDefaultScore" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">归属组织</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterOwnerOrg" runat="server" CssClass="text"></asp:TextBox>
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
