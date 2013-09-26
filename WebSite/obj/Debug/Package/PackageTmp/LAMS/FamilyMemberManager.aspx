
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="FamilyMemberManager.aspx.cs" Inherits="WebSite.FamilyMemberManager" %>

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
		        <asp:TemplateField HeaderText="员工编号">
                    <ItemTemplate>
						<%#Eval("EmployeeID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="称谓">
                    <ItemTemplate>
						<%#Eval("MemberRelation")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="姓名">
                    <ItemTemplate>
						<%#Eval("Name")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="性别">
                    <ItemTemplate>
						<%#Eval("Gender")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="出生年月">
                    <ItemTemplate>
						<%#Eval("BirthDay")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="工作单位及职位">
                    <ItemTemplate>
						<%#Eval("CompanyAndPosition")%>
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
				<dt class="rowlable">员工编号</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterEmployeeID" OpenUrl="EmployeeIDTree.aspx" DialogTitle="选择员工编号"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">称谓</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterMemberRelation" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">姓名</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">性别</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterGender" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">出生年月</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterBirthDay" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">工作单位及职位</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterCompanyAndPosition" runat="server" CssClass="text"></asp:TextBox>
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


