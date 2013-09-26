
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="OperateManager.aspx.cs" Inherits="WebSite.OperateManager" %>

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
		        <asp:TemplateField HeaderText="操作名称">
                    <ItemTemplate>
						<%#Eval("OperateName")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="操作关键字">
                    <ItemTemplate>
						<%#Eval("OperateKey")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="命令">
                    <ItemTemplate>
						<%#Eval("CommandName")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="命令参数">
                    <ItemTemplate>
						<%#Eval("CommandArgument")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="是否有效">
                    <ItemTemplate>
						<%#Eval("IsValid")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="是否验证">
                    <ItemTemplate>
						<%#Eval("IsVerify")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="序号">
                    <ItemTemplate>
						<%#Eval("SortOrder")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="说明">
                    <ItemTemplate>
						<%#Eval("Description")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="归属组织">
                    <ItemTemplate>
						<%#Eval("OwnerOrg")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="运行方式">
                    <ItemTemplate>
						<%#Eval("Runat")%>
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
				<dt class="rowlable">操作名称</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterOperateName" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">操作关键字</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterOperateKey" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">命令</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterCommandName" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">命令参数</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterCommandArgument" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">是否有效</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterIsValid" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="否" Value="0" ></asp:ListItem>
							<asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">是否验证</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterIsVerify" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="否" Value="0" ></asp:ListItem>
							<asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">序号</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterSortOrder" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">说明</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterDescription" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">归属组织</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterOwnerOrg" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">运行方式</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterRunat" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


