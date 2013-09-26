<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="WidgetsManager.aspx.cs" Inherits="WebSite.WidgetsManager" %>

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
    <div id="divContent" class="div_content">
        <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
            DataKeyNames="ID">
            <Columns>
                <asp:TemplateField HeaderText="选择">
                    <ItemTemplate>
                        <input id="radioId" type="radio" value='<%#Eval("ID") %>' text='<%#Eval("name")%>'
                            name="radioId" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="部件名">
                    <ItemTemplate>
                        <%#Eval("Code")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="部件显示名称">
                    <ItemTemplate>
                        <%#Eval("Name")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="部件添加方式 ">
                    <ItemTemplate>
                           <%# RemarkAttribute.GetEnumRemark((WidgetAddType)Enum.Parse(typeof(WidgetAddType), Eval("AddType").ToString()))%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="是否显示">
                    <ItemTemplate>
                        <%#Eval("IsShow").ToString()=="0" ? "否" : "是"%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="是否可移动">
                    <ItemTemplate>
                        <%#Eval("Movable").ToString() == "0" ? "否" : "是"%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="是否可关闭">
                    <ItemTemplate>
                        <%#Eval("Removable").ToString() == "0" ? "否" : "是"%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="是否有关闭提示">
                    <ItemTemplate>
                        <%#Eval("Closeconfirm").ToString() == "0" ? "否" : "是"%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="是否可收缩">
                    <ItemTemplate>
                        <%#Eval("Collapsable").ToString() == "0" ? "否" : "是"%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="是否可以编辑">
                    <ItemTemplate>
                        <%#Eval("Editable").ToString() == "0" ? "否" : "是"%>
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
                <dt class="rowlable">部件名</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterCode" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">部件添加方式</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterAddType" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="主页直接添加" Value="0"></asp:ListItem>
                        <asp:ListItem Text="链接其它页面" Value="1"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">部件显示名称</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>
