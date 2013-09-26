<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="MyWorkItem.aspx.cs" Inherits="WebSite.MyWorkItem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
<script type="text/javascript">
    function rowClick(me, id, remember) {
        if (currentRow) {
            currentRow.className = "gridview_row";
        }

        me.className = "rowcurrent";

        currentRow = me;

        var processInstID = $(":hidden", me).eq(0).val();
        var url = 'MyWorkItemDetail.aspx?processInstID=' + processInstID + '&workItemID=' + id;
        openDialog('actionDialog', '流程', url, 980, 700, true, 1);
    }
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
                <asp:TemplateField HeaderText="工作项名称">
                    <ItemTemplate>
                            <%#Eval("Name")%>
                        <asp:HiddenField runat="server" ID="processInstID" Value ='<%#Eval("ProcessInstID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="所属流程">
                    <ItemTemplate>
                        <%#Eval("ProcessName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="当前状态">
                    <ItemTemplate>
                        <%# RemarkAttribute.GetEnumRemark((EAFrame.Workflow.Enums.WorkItemStatus)Enum.Parse(typeof(EAFrame.Workflow.Enums.WorkItemStatus), Eval("CurrentState").ToString()))%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="提交人">
                    <ItemTemplate>
                        <%#Eval("CreatorName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="提交时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("StartTime")).ToShortDateString()%>
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
                <dt class="rowlable">工作项名称</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">所属流程</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterProcessName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">提交人</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterCreatorName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">当前状态</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterCurrentState" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="待执行" Value="1"></asp:ListItem>
                        <asp:ListItem Text="停止" Value="2"></asp:ListItem>
                        <asp:ListItem Text="执行" Value="3"></asp:ListItem>
                        <asp:ListItem Text="挂起" Value="4"></asp:ListItem>
                        <asp:ListItem Text="完成" Value="5"></asp:ListItem>
                        <asp:ListItem Text="终止" Value="6"></asp:ListItem>
                        <asp:ListItem Text="取消" Value="7"></asp:ListItem>
                        <asp:ListItem Text="出错" Value="8"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>
