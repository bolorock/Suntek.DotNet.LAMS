
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="PostExperienceManager.aspx.cs" Inherits="WebSite.PostExperienceManager" %>

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
		        <asp:TemplateField HeaderText="任职时间">
                    <ItemTemplate>
						<%#Eval("PostDate")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="职务名称">
                    <ItemTemplate>
						<%#Eval("Position")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="职务等级">
                    <ItemTemplate>
						<%#Eval("PostGrade")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="任职文号">
                    <ItemTemplate>
						<%#Eval("AppointDocNumber")%>
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
				<dt class="rowlable">任职时间</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterPostDate" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">职务名称</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterPosition" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">职务等级</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterPostGrade" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">任职文号</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterAppointDocNumber" runat="server" CssClass="text"></asp:TextBox>
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


