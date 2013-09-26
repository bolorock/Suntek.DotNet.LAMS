<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ActivityManager.aspx.cs"
    MasterPageFile="~/Master/Page.Master" Inherits="WebSite.Workflow.ActivityManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
     <script type="text/javascript" language="javascript">
         dialogSetting.detailWidth = 900;
         dialogSetting.detailHeight = 600;
    </script>
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
                <asp:TemplateField HeaderText="活动ID">
                    <ItemTemplate>
                        <%#Eval("ID")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="活动名称">
                    <ItemTemplate>
                        <%#Eval("Name")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="分支模式">
                    <ItemTemplate>
                        <%#Eval("SplitType").ToSafeString().Cast<EAFrame.Workflow.Enums.SplitType>().GetRemark()%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="活动类型">
                    <ItemTemplate>
                        <%#Eval("ActivityType").ToSafeString().Cast<EAFrame.Workflow.Enums.ActivityType>().GetRemark()%>
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
                <dt class="rowlable">显示名</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterText" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">流程内容</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterContent" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">所属分类</dt>
                <dd class="rowinput">
                    <suntek:ChooseBox ID="filterCategoryID" OpenUrl="CategoryIDTree.aspx" DialogTitle="选择所属分类"
                        runat="server"></suntek:ChooseBox>
                </dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>
