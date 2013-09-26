
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ActivityInstManager.aspx.cs" Inherits="WebSite.ActivityInstManager" %>

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
		        <asp:TemplateField HeaderText="名称">
                    <ItemTemplate>
						<%#Eval("Name")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="活动类型">
                    <ItemTemplate>
						<%#Eval("Type")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="当前状态">
                    <ItemTemplate>
						<%#Eval("CurrentState")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="启动时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("StartTime")).ToShortDateString() %>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="结束时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("EndTime")).ToShortDateString() %>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="子流程实例ID">
                    <ItemTemplate>
						<%#Eval("SubProcessInstID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="活动定义ID">
                    <ItemTemplate>
						<%#Eval("ActivityDefID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="所属流程实例">
                    <ItemTemplate>
						<%#Eval("ProcessInstID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="回退标志">
                    <ItemTemplate>
						<%#Eval("RollbackFlag")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="描述">
                    <ItemTemplate>
						<%#Eval("Description")%>
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
				<dt class="rowlable">名称</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">活动类型</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">当前状态</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterCurrentState" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">启动时间</dt>
				<dd class="rowinput">
						<suntek:DatePicker ID="filterStartTime" runat="server"></suntek:DatePicker>
				</dd>
				<dt class="rowlable">结束时间</dt>
				<dd class="rowinput">
						<suntek:DatePicker ID="filterEndTime" runat="server"></suntek:DatePicker>
				</dd>
				<dt class="rowlable">子流程实例ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterSubProcessInstID" OpenUrl="SubProcessInstIDTree.aspx" DialogTitle="选择子流程实例ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">活动定义ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterActivityDefID" OpenUrl="ActivityDefIDTree.aspx" DialogTitle="选择活动定义ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">所属流程实例</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterProcessInstID" OpenUrl="ProcessInstIDTree.aspx" DialogTitle="选择所属流程实例"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">回退标志</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterRollbackFlag" DropDownStyle="DropDownList" 
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
				<dt class="rowlable">创建时间</dt>
				<dd class="rowinput">
						<suntek:DatePicker ID="filterCreateTime" runat="server"></suntek:DatePicker>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


