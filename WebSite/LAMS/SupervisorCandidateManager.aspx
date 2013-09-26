
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="SupervisorCandidateManager.aspx.cs" Inherits="WebSite.SupervisorCandidateManager" %>

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
		        <asp:TemplateField HeaderText="导师ID">
                    <ItemTemplate>
						<%#Eval("SupervisorID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="后备经理人ID">
                    <ItemTemplate>
						<%#Eval("CandidateManagerID")%>
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
				<dt class="rowlable">导师ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterSupervisorID" OpenUrl="SupervisorIDTree.aspx" DialogTitle="选择导师ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">后备经理人ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterCandidateManagerID" OpenUrl="CandidateManagerIDTree.aspx" DialogTitle="选择后备经理人ID"
						runat="server"></suntek:ChooseBox>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


