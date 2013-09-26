
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ActionLogHistoryManager.aspx.cs" Inherits="WebSite.ActionLogHistoryManager" %>

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
		        <asp:TemplateField HeaderText="操作员名称">
                    <ItemTemplate>
						<%#Eval("UserName")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="日志类型">
                    <ItemTemplate>
						<%#Eval("LogType")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="操作机器IP">
                    <ItemTemplate>
						<%#Eval("ClientIP")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="应用名称">
                    <ItemTemplate>
						<%#Eval("AppModule")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="操作信息">
                    <ItemTemplate>
						<%#Eval("Message")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="1－成功，0－失败，2－系统异常，3-事务回滚">
                    <ItemTemplate>
						<%#Eval("Result")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="操作员ID">
                    <ItemTemplate>
						<%#Eval("UserID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="操作时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("CreateTime")).ToShortDateString() %>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="归档时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("ArchiveTime")).ToShortDateString() %>
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
				<dt class="rowlable">操作员名称</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterUserName" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">日志类型</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterLogType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">操作机器IP</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterClientIP" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">应用名称</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterAppModule" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">操作信息</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterMessage" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">1－成功，0－失败，2－系统异常，3-事务回滚</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterResult" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">操作员ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterUserID" OpenUrl="UserIDTree.aspx" DialogTitle="选择操作员ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">操作时间</dt>
				<dd class="rowinput">
						<suntek:DatePicker ID="filterCreateTime" runat="server"></suntek:DatePicker>
				</dd>
				<dt class="rowlable">归档时间</dt>
				<dd class="rowinput">
						<suntek:DatePicker ID="filterArchiveTime" runat="server"></suntek:DatePicker>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


