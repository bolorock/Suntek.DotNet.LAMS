
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ActionLogManager.aspx.cs" Inherits="WebSite.ActionLogManager" %>

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
        <SunTek:PagedGridView ID="gvList" runat="server"  PageIndex="1" PageSize="20" CssClass="gridview" DataKeyNames="ID">
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
						<%# RemarkAttribute.GetEnumRemark((ActionType)Enum.Parse(typeof(ActionType), Eval("LogType").ToString()))%>
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
		        <asp:TemplateField HeaderText="操作结果">
                    <ItemTemplate>
                    <%# RemarkAttribute.GetEnumRemark((ActionResult)Enum.Parse(typeof(ActionResult), Eval("Result").ToString()))%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="操作时间">
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
				<dt class="rowlable">操作员名称</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterUserName" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">日志类型</dt>
				<dd class="rowinput">
					  <suntek:ComboBox ID="filterLogType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="新增" Value="0"></asp:ListItem>
                            <asp:ListItem Text="删除" Value="1"></asp:ListItem>
                            <asp:ListItem Text="修改" Value="2"></asp:ListItem>
                            <asp:ListItem Text="查看" Value="3"></asp:ListItem>
                            <asp:ListItem Text="查询" Value="4"></asp:ListItem>
                            <asp:ListItem Text="返回" Value="5"></asp:ListItem>
                            <asp:ListItem Text="刷新" Value="6"></asp:ListItem>
                            <asp:ListItem Text="关闭" Value="7"></asp:ListItem>
                            <asp:ListItem Text="登陆" Value="8"></asp:ListItem>
                            <asp:ListItem Text="退出" Value="9"></asp:ListItem>
                            <asp:ListItem Text="其他" Value="255"></asp:ListItem>
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
				<dt class="rowlable">操作结果</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterResult" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="操作成功" Value="1"></asp:ListItem>
                            <asp:ListItem Text="操作失败" Value="0"></asp:ListItem>
                            <asp:ListItem Text="其他" Value="255"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">操作时间</dt>
				<dd class="rowinput">
						<suntek:DatePicker ID="filterCreateTime" runat="server"></suntek:DatePicker>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


