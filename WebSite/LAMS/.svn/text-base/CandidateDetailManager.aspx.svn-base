
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="CandidateDetailManager.aspx.cs" Inherits="WebSite.CandidateDetailManager" %>

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
		        <asp:TemplateField HeaderText="应到人数">
                    <ItemTemplate>
						<%#Eval("ShouldCount")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="实到人数">
                    <ItemTemplate>
						<%#Eval("AttendCount")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="员工代表人数">
                    <ItemTemplate>
						<%#Eval("EmployeeCount")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="同意票数">
                    <ItemTemplate>
						<%#Eval("ApproveCount")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="占票数百分比">
                    <ItemTemplate>
						<%#Eval("ApprovePercent")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="主要业绩">
                    <ItemTemplate>
						<%#Eval("MajorKPI")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="主要不足">
                    <ItemTemplate>
						<%#Eval("Deficiency")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="培训发展计划">
                    <ItemTemplate>
						<%#Eval("TrainingPlan")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="推荐意见">
                    <ItemTemplate>
						<%#Eval("Recommendation")%>
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
				<dt class="rowlable">应到人数</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterShouldCount" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">实到人数</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterAttendCount" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">员工代表人数</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterEmployeeCount" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">同意票数</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterApproveCount" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">占票数百分比</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterApprovePercent" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">主要业绩</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterMajorKPI" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">主要不足</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterDeficiency" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">培训发展计划</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterTrainingPlan" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">推荐意见</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterRecommendation" runat="server" CssClass="text"></asp:TextBox>
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


