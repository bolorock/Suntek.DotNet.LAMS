
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="AssessmentRoleManager.aspx.cs" Inherits="WebSite.AssessmentRoleManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<%= WebExtensions.CombresLink(Skin+"SiteCss") %>
	<%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("ManagerJs") %>
	<%if (false)
      { %>
		<script src="<%=string.Format("{0}/Scripts/jquery-vsdoc.js",RootPath)%>"
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
		        <asp:TemplateField HeaderText="角色名称">
                    <ItemTemplate>
						<%#Eval("Name")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="360测评=1;
   动机测评=2;
   团队效能测评=3;
   优势与特点测评=4;
   Disc测评=5;
   情景模拟=21;
   案例分析=22;
   关键事件访谈=23;">
                    <ItemTemplate>
						<%#Eval("Category")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="评测权重">
                    <ItemTemplate>
						<%#Eval("Weight")%>
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
				<dt class="rowlable">角色名称</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">360测评=1;
   动机测评=2;
   团队效能测评=3;
   优势与特点测评=4;
   Disc测评=5;
   情景模拟=21;
   案例分析=22;
   关键事件访谈=23;</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterCategory" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">评测权重</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterWeight" runat="server" CssClass="text"></asp:TextBox>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


