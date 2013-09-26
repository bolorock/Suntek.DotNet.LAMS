
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="DiplomaManager.aspx.cs" Inherits="WebSite.DiplomaManager" %>

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
		        <asp:TemplateField HeaderText="全日制教育">
                    <ItemTemplate>
						<%#Eval("FulltimeEducation")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="全日制教育学校">
                    <ItemTemplate>
						<%#Eval("FulltimeSchool")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="全日制教育专业">
                    <ItemTemplate>
						<%#Eval("FulltimeMajor")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="在职教育">
                    <ItemTemplate>
						<%#Eval("InserviceEducation")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="在职教育学校">
                    <ItemTemplate>
						<%#Eval("InserviceSchool")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="在职教育专业">
                    <ItemTemplate>
						<%#Eval("InserviceMajor")%>
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
				<dt class="rowlable">全日制教育</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterFulltimeEducation" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">全日制教育学校</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterFulltimeSchool" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">全日制教育专业</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterFulltimeMajor" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">在职教育</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterInserviceEducation" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">在职教育学校</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterInserviceSchool" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">在职教育专业</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterInserviceMajor" runat="server" CssClass="text"></asp:TextBox>
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


