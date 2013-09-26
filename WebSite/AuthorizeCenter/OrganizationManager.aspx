
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="OrganizationManager.aspx.cs" Inherits="WebSite.OrganizationManager" %>

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
		        <asp:TemplateField HeaderText="机构代码">
                    <ItemTemplate>
						<%#Eval("Code")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="上级组织">
                    <ItemTemplate>
						<%#Eval("ParentID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="机构名称">
                    <ItemTemplate>
						<%#Eval("Name")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="总行，分行，海外分行...">
                    <ItemTemplate>
						<%#Eval("Grade")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="总公司/总部部门/分公司/分公司部门...">
                    <ItemTemplate>
						<%#Eval("Type")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="机构地址">
                    <ItemTemplate>
						<%#Eval("Address")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="邮编">
                    <ItemTemplate>
						<%#Eval("ZipCode")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="机构主管岗位">
                    <ItemTemplate>
						<%#Eval("GovernPosition")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="机构主管人员">
                    <ItemTemplate>
						<%#Eval("Governor")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="机构管理员能够给本机构的人员进行授权，多个机构管理员之间用,分隔">
                    <ItemTemplate>
						<%#Eval("Manager")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="联系人">
                    <ItemTemplate>
						<%#Eval("ContactMan")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="联系电话">
                    <ItemTemplate>
						<%#Eval("ContactPhone")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="电子邮件">
                    <ItemTemplate>
						<%#Eval("Email")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="网站地址">
                    <ItemTemplate>
						<%#Eval("WebURL")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="机构状态">
                    <ItemTemplate>
						<%#Eval("Status")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="所属地域">
                    <ItemTemplate>
						<%#Eval("Area")%>
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
		        <asp:TemplateField HeaderText="修改者">
                    <ItemTemplate>
                        <%#((DateTime)Eval("Modifier")).ToShortDateString() %>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="修改时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("ModifyTime")).ToShortDateString() %>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="SapID">
                    <ItemTemplate>
						<%#Eval("SapID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="公司ID">
                    <ItemTemplate>
						<%#Eval("CorpID")%>
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
				<dt class="rowlable">机构代码</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterCode" OpenUrl="CodeTree.aspx" DialogTitle="选择机构代码"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">上级组织</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterParentID" OpenUrl="ParentIDTree.aspx" DialogTitle="选择上级组织"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">机构名称</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">总行，分行，海外分行...</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterGrade" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">总公司/总部部门/分公司/分公司部门...</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">机构地址</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterAddress" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">邮编</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterZipCode" OpenUrl="ZipCodeTree.aspx" DialogTitle="选择邮编"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">机构主管岗位</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterGovernPosition" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">机构主管人员</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterGovernor" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">机构管理员能够给本机构的人员进行授权，多个机构管理员之间用,分隔</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterManager" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">联系人</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterContactMan" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">联系电话</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterContactPhone" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">电子邮件</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterEmail" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">网站地址</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterWebURL" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">机构状态</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterStatus" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">所属地域</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterArea" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">序号</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterSortOrder" runat="server" CssClass="text"></asp:TextBox>
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
				<dt class="rowlable">修改者</dt>
				<dd class="rowinput">
						<suntek:DatePicker ID="filterModifier" runat="server"></suntek:DatePicker>
				</dd>
				<dt class="rowlable">修改时间</dt>
				<dd class="rowinput">
						<suntek:DatePicker ID="filterModifyTime" runat="server"></suntek:DatePicker>
				</dd>
				<dt class="rowlable">SapID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterSapID" OpenUrl="SapIDTree.aspx" DialogTitle="选择SapID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">公司ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterCorpID" OpenUrl="CorpIDTree.aspx" DialogTitle="选择公司ID"
						runat="server"></suntek:ChooseBox>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


