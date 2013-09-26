
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="PrivilegeManager.aspx.cs" Inherits="WebSite.PrivilegeManager" %>

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
		        <asp:TemplateField HeaderText="权限名称">
                    <ItemTemplate>
						<%#Eval("Name")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="权限类型">
                    <ItemTemplate>
						<%#Eval("Type")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="资源ID">
                    <ItemTemplate>
						<%#Eval("ResourceID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="操作ID">
                    <ItemTemplate>
						<%#Eval("OperateID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="元数据ID">
                    <ItemTemplate>
						<%#Eval("MetaDataID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="模块ID">
                    <ItemTemplate>
						<%#Eval("ModuleID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="应用ID">
                    <ItemTemplate>
						<%#Eval("AppID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="序号">
                    <ItemTemplate>
						<%#Eval("SortOrder")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="描述">
                    <ItemTemplate>
						<%#Eval("Description")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="归属组织">
                    <ItemTemplate>
						<%#Eval("OwnerOrg")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="创建者">
                    <ItemTemplate>
						<%#Eval("Creator")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="创建时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("CreateTime")).ToShortDateString() %>
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
				<dt class="rowlable">权限名称</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">权限类型</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">资源ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterResourceID" OpenUrl="ResourceIDTree.aspx" DialogTitle="选择资源ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">操作ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterOperateID" OpenUrl="OperateIDTree.aspx" DialogTitle="选择操作ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">元数据ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterMetaDataID" OpenUrl="MetaDataIDTree.aspx" DialogTitle="选择元数据ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">模块ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterModuleID" OpenUrl="ModuleIDTree.aspx" DialogTitle="选择模块ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">应用ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterAppID" OpenUrl="AppIDTree.aspx" DialogTitle="选择应用ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">序号</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterSortOrder" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">描述</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterDescription" runat="server" CssClass="text"></asp:TextBox>
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


