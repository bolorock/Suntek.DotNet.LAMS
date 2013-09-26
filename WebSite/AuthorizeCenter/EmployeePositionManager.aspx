
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="EmployeePositionManager.aspx.cs" Inherits="WebSite.EmployeePositionManager" %>

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
		        <asp:TemplateField HeaderText="岗位编号">
                    <ItemTemplate>
						<%#Eval("PositionID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="人员编号">
                    <ItemTemplate>
						<%#Eval("EmployeeID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="是否主岗位">
                    <ItemTemplate>
						<%#Eval("IsMajor")%>
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
				<dt class="rowlable">岗位编号</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterPositionID" OpenUrl="PositionIDTree.aspx" DialogTitle="选择岗位编号"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">人员编号</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterEmployeeID" OpenUrl="EmployeeIDTree.aspx" DialogTitle="选择人员编号"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">是否主岗位</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterIsMajor" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="否" Value="0" ></asp:ListItem>
							<asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


