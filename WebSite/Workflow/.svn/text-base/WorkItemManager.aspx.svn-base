<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="WorkItemManager.aspx.cs" Inherits="WebSite.WorkItemManager" %>

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
    <div id="divContent" class="div_content">
        <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
            DataKeyNames="ID">
            <Columns>
                <asp:TemplateField HeaderText="选择">
                    <ItemTemplate>
                        <input id="radioId" type="radio" value='<%#Eval("ID") %>' name="radioId" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="名称">
                    <ItemTemplate>
                        <%#Eval("Name")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="工作项类型">
                    <ItemTemplate>
                        <%#Eval("Type")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="创建时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("CreateTime")).ToShortDateString() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="创建者">
                    <ItemTemplate>
                        <%#Eval("Creator")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="启动时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("StartTime")).ToShortDateString() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="结束时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("EndTime")).ToShortDateString() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="描述">
                    <ItemTemplate>
                        <%#Eval("Description")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="当前状态">
                    <ItemTemplate>
                        <%#Eval("CurrentState")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="参与者">
                    <ItemTemplate>
                        <%#Eval("Participant")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="是否超时">
                    <ItemTemplate>
                        <%#Eval("IsTimeOut")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="超时时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("TimeOutTime")).ToShortDateString() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="提醒时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("RemindTime")).ToShortDateString() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="响应URL">
                    <ItemTemplate>
                        <%#Eval("ActionURL")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="操作码">
                    <ItemTemplate>
                        <%#Eval("ActionMask")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="所属流程实例">
                    <ItemTemplate>
                        <%#Eval("ProcessInstID")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="所属流程实例名">
                    <ItemTemplate>
                        <%#Eval("ProcessInstName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="所属活动实例">
                    <ItemTemplate>
                        <%#Eval("ActivityInstID")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="所属活动实像名">
                    <ItemTemplate>
                        <%#Eval("ActivityInstName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="所属流程">
                    <ItemTemplate>
                        <%#Eval("ProcessID")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="所属流程显示名">
                    <ItemTemplate>
                        <%#Eval("ProcessText")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="是否允许代理">
                    <ItemTemplate>
                        <%#Eval("AllowAgent")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="业务状态">
                    <ItemTemplate>
                        <%#Eval("BizState")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="工作项当前执行者">
                    <ItemTemplate>
                        <%#Eval("Executor")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="所属根流程实例">
                    <ItemTemplate>
                        <%#Eval("RootProcessInstID")%>
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
                <dt class="rowlable">名称</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">工作项类型</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterType" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">创建时间</dt>
                <dd class="rowinput">
                    <suntek:DatePicker ID="filterCreateTime" runat="server"></suntek:DatePicker>
                </dd>
                <dt class="rowlable">创建者</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterCreator" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">启动时间</dt>
                <dd class="rowinput">
                    <suntek:DatePicker ID="filterStartTime" runat="server"></suntek:DatePicker>
                </dd>
                <dt class="rowlable">结束时间</dt>
                <dd class="rowinput">
                    <suntek:DatePicker ID="filterEndTime" runat="server"></suntek:DatePicker>
                </dd>
                <dt class="rowlable">描述</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterDescription" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">当前状态</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterCurrentState" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">参与者</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterParticipant" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">是否超时</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterIsTimeOut" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">超时时间</dt>
                <dd class="rowinput">
                    <suntek:DatePicker ID="filterTimeOutTime" runat="server"></suntek:DatePicker>
                </dd>
                <dt class="rowlable">提醒时间</dt>
                <dd class="rowinput">
                    <suntek:DatePicker ID="filterRemindTime" runat="server"></suntek:DatePicker>
                </dd>
                <dt class="rowlable">响应URL</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterActionURL" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">操作码</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterActionMask" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">所属流程实例</dt>
                <dd class="rowinput">
                    <suntek:ChooseBox ID="filterProcessInstID" OpenUrl="ProcessInstIDTree.aspx" DialogTitle="选择所属流程实例"
                        runat="server"></suntek:ChooseBox>
                </dd>
                <dt class="rowlable">所属流程实例名</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterProcessInstName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">所属活动实例</dt>
                <dd class="rowinput">
                    <suntek:ChooseBox ID="filterActivityInstID" OpenUrl="ActivityInstIDTree.aspx" DialogTitle="选择所属活动实例"
                        runat="server"></suntek:ChooseBox>
                </dd>
                <dt class="rowlable">所属活动实像名</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterActivityInstName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">所属流程</dt>
                <dd class="rowinput">
                    <suntek:ChooseBox ID="filterProcessID" OpenUrl="ProcessIDTree.aspx" DialogTitle="选择所属流程"
                        runat="server"></suntek:ChooseBox>
                </dd>
                <dt class="rowlable">所属流程显示名</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterProcessText" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">是否允许代理</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterAllowAgent" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">业务状态</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterBizState" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">工作项当前执行者</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterExecutor" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">所属根流程实例</dt>
                <dd class="rowinput">
                    <suntek:ChooseBox ID="filterRootProcessInstID" OpenUrl="RootProcessInstIDTree.aspx"
                        DialogTitle="选择所属根流程实例" runat="server"></suntek:ChooseBox>
                </dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>
