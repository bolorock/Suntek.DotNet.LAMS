
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="AgentCandidateManager.aspx.cs" Inherits="WebSite.AgentCandidateManager" %>

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
		        <asp:TemplateField HeaderText="代理人">
                    <ItemTemplate>
						<%#Eval("AgentToID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="代理人名称">
                    <ItemTemplate>
						<%#Eval("AgentToName")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="代理人类型">
                    <ItemTemplate>
						<%#Eval("AgentToType")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="委托人ID">
                    <ItemTemplate>
						<%#Eval("AgentFrom")%>
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
				<dt class="rowlable">代理人</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterAgentToID" OpenUrl="AgentToIDTree.aspx" DialogTitle="选择代理人"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">代理人名称</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterAgentToName" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">代理人类型</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterAgentToType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">委托人ID</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterAgentFrom" runat="server" CssClass="text"></asp:TextBox>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


