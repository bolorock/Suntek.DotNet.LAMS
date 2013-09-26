
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="DutyManager.aspx.cs" Inherits="WebSite.DutyManager" %>

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
		        <asp:TemplateField HeaderText="职务编码">
                    <ItemTemplate>
						<%#Eval("Code")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="职务名称">
                    <ItemTemplate>
						<%#Eval("Name")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="上级职务">
                    <ItemTemplate>
						<%#Eval("ParentID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="例如科技类，审计类等">
                    <ItemTemplate>
						<%#Eval("Type")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="描述">
                    <ItemTemplate>
						<%#Eval("Description")%>
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
				<dt class="rowlable">职务编码</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterCode" OpenUrl="CodeTree.aspx" DialogTitle="选择职务编码"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">职务名称</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">上级职务</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterParentID" OpenUrl="ParentIDTree.aspx" DialogTitle="选择上级职务"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">例如科技类，审计类等</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">描述</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterDescription" runat="server" CssClass="text"></asp:TextBox>
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


