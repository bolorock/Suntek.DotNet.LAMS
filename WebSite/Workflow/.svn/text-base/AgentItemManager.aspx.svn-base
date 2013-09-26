
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="AgentItemManager.aspx.cs" Inherits="WebSite.AgentItemManager" %>

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
		        <asp:TemplateField HeaderText="代理项类型">
                    <ItemTemplate>
						<%#Eval("Type")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="代理业务ID">
                    <ItemTemplate>
						<%#Eval("RelatedBizID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="是否生效">
                    <ItemTemplate>
						<%#Eval("IsValid")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="代理权限">
                    <ItemTemplate>
						<%#Eval("AgentPrivilege")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="所属代理">
                    <ItemTemplate>
						<%#Eval("AgentID")%>
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
				<dt class="rowlable">代理项类型</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">代理业务ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterRelatedBizID" OpenUrl="RelatedBizIDTree.aspx" DialogTitle="选择代理业务ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">是否生效</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterIsValid" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="否" Value="0" ></asp:ListItem>
							<asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">代理权限</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterAgentPrivilege" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">所属代理</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterAgentID" OpenUrl="AgentIDTree.aspx" DialogTitle="选择所属代理"
						runat="server"></suntek:ChooseBox>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


