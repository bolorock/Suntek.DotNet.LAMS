
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="BizOrgManager.aspx.cs" Inherits="WebSite.BizOrgManager" %>

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
		        <asp:TemplateField HeaderText="业务机构名称">
                    <ItemTemplate>
						<%#Eval("Name")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="业务机构等级">
                    <ItemTemplate>
						<%#Eval("Grade")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="上级组织">
                    <ItemTemplate>
						<%#Eval("ParentID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="业务字典ABF_NODETYPE
   虚拟节点，机构节点，如果是机构节点，则对应机构信息表的一个机构">
                    <ItemTemplate>
						<%#Eval("BizType")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="组织机构ID">
                    <ItemTemplate>
						<%#Eval("OrgID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="序号">
                    <ItemTemplate>
						<%#Eval("SortOrder")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="主管岗位">
                    <ItemTemplate>
						<%#Eval("GovernPosition")%>
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
				<dt class="rowlable">业务机构名称</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">业务机构等级</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterGrade" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">上级组织</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterParentID" OpenUrl="ParentIDTree.aspx" DialogTitle="选择上级组织"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">业务字典ABF_NODETYPE
   虚拟节点，机构节点，如果是机构节点，则对应机构信息表的一个机构</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterBizType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<dt class="rowlable">组织机构ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterOrgID" OpenUrl="OrgIDTree.aspx" DialogTitle="选择组织机构ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">序号</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterSortOrder" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">主管岗位</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterGovernPosition" runat="server" CssClass="text"></asp:TextBox>
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


