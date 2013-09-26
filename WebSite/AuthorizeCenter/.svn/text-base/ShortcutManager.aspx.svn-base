
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ShortcutManager.aspx.cs" Inherits="WebSite.ShortcutManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<%= WebExtensions.CombresLink(Skin+"SiteCss") %>
	<%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("ManagerJs") %>
	<%if (false)
      { %>
		<script   src="../Scripts/jquery-vsdoc.js" 
        type="text/javascript"></script> 
    <%}%>	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div id="divContent" class="div_content">
        <SunTek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview" DataKeyNames="ID">
            <Columns>
                <asp:TemplateField HeaderText="选择">
                    <ItemTemplate>
                        <input id="radioId" type="radio" value='<%#Eval("ID") %>' name="radioId" />
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="操作员ID">
                    <ItemTemplate>
						<%#Eval("OperatorID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="权限ID">
                    <ItemTemplate>
						<%#Eval("PrivilegeID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="冗余字段">
                    <ItemTemplate>
						<%#Eval("AppID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="序号">
                    <ItemTemplate>
						<%#Eval("SortOrder")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="快捷菜单图标">
                    <ItemTemplate>
						<%#Eval("Icon")%>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </SunTek:PagedGridView>
    </div>
    <div id="filterDialog" title="查询">
        <p id="validateTips">
        </p>
        <fieldset>
            <dl>
				<dt class="rowlable">操作员ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterOperatorID" OpenUrl="OperatorIDTree.aspx" DialogTitle="选择操作员ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">权限ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterPrivilegeID" OpenUrl="PrivilegeIDTree.aspx" DialogTitle="选择权限ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">冗余字段</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterAppID" OpenUrl="AppIDTree.aspx" DialogTitle="选择冗余字段"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">序号</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterSortOrder" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">快捷菜单图标</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterIcon" runat="server" CssClass="text"></asp:TextBox>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


