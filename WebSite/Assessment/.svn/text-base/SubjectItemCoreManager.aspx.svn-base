
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="SubjectItemCoreManager.aspx.cs" Inherits="WebSite.SubjectItemCoreManager" %>

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
		        <asp:TemplateField HeaderText="试卷ID">
                    <ItemTemplate>
						<%#Eval("ExamPaperID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="题目ID">
                    <ItemTemplate>
						<%#Eval("SubjectID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="题目选项ID">
                    <ItemTemplate>
						<%#Eval("SubjectItemID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="选项分值">
                    <ItemTemplate>
						<%#Eval("Score")%>
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
				<dt class="rowlable">试卷ID</dt>
				<dd class="rowinput">
						<Hiway:ChooseBox ID="filterExamPaperID" OpenUrl="ExamPaperIDTree.aspx" DialogTitle="选择试卷ID"
						runat="server"></Hiway:ChooseBox>
				</dd>
				<dt class="rowlable">题目ID</dt>
				<dd class="rowinput">
						<Hiway:ChooseBox ID="filterSubjectID" OpenUrl="SubjectIDTree.aspx" DialogTitle="选择题目ID"
						runat="server"></Hiway:ChooseBox>
				</dd>
				<dt class="rowlable">题目选项ID</dt>
				<dd class="rowinput">
						<Hiway:ChooseBox ID="filterSubjectItemID" OpenUrl="SubjectItemIDTree.aspx" DialogTitle="选择题目选项ID"
						runat="server"></Hiway:ChooseBox>
				</dd>
				<dt class="rowlable">选项分值</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterScore" runat="server" CssClass="text"></asp:TextBox>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


