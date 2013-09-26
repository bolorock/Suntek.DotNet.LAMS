
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="PositionManager.aspx.cs" Inherits="WebSite.PositionManager" %>

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
		        <asp:TemplateField HeaderText="岗位代码">
                    <ItemTemplate>
						<%#Eval("Code")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="岗位名称">
                    <ItemTemplate>
						<%#Eval("Name")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="职务ID">
                    <ItemTemplate>
						<%#Eval("DutyID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="应用ID">
                    <ItemTemplate>
						<%#Eval("AppID")%>
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
				<dt class="rowlable">岗位代码</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterCode" OpenUrl="CodeTree.aspx" DialogTitle="选择岗位代码"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">岗位名称</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">职务ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterDutyID" OpenUrl="DutyIDTree.aspx" DialogTitle="选择职务ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">应用ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterAppID" OpenUrl="AppIDTree.aspx" DialogTitle="选择应用ID"
						runat="server"></suntek:ChooseBox>
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


