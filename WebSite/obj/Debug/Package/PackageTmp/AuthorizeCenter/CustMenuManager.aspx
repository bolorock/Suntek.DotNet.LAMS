
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="CustMenuManager.aspx.cs" Inherits="WebSite.CustMenuManager" %>

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
		        <asp:TemplateField HeaderText="菜单编号">
                    <ItemTemplate>
						<%#Eval("ResourceID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="菜单名称">
                    <ItemTemplate>
						<%#Eval("Name")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="菜单显示（中文）">
                    <ItemTemplate>
						<%#Eval("Text")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="根菜单">
                    <ItemTemplate>
						<%#Eval("RootID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="父菜单">
                    <ItemTemplate>
						<%#Eval("ParentID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="序号">
                    <ItemTemplate>
						<%#Eval("SortOrder")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="菜单图标">
                    <ItemTemplate>
						<%#Eval("Icon")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="菜单展开图标">
                    <ItemTemplate>
						<%#Eval("ExpandIcon")%>
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
				<dt class="rowlable">菜单编号</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterResourceID" OpenUrl="ResourceIDTree.aspx" DialogTitle="选择菜单编号"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">菜单名称</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">菜单显示（中文）</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterText" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">根菜单</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterRootID" OpenUrl="RootIDTree.aspx" DialogTitle="选择根菜单"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">父菜单</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterParentID" OpenUrl="ParentIDTree.aspx" DialogTitle="选择父菜单"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">序号</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterSortOrder" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">菜单图标</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterIcon" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">菜单展开图标</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterExpandIcon" runat="server" CssClass="text"></asp:TextBox>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


