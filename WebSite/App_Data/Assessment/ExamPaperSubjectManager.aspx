
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ExamPaperSubjectManager.aspx.cs" Inherits="WebSite.ExamPaperSubjectManager" %>

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
		        <asp:TemplateField HeaderText="题目ID">
                    <ItemTemplate>
						<%#Eval("SubjectID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="试卷ID">
                    <ItemTemplate>
						<%#Eval("ExamPaperID")%>
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
				<dt class="rowlable">题目ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterSubjectID" OpenUrl="SubjectIDTree.aspx" DialogTitle="选择题目ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">试卷ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterExamPaperID" OpenUrl="ExamPaperIDTree.aspx" DialogTitle="选择试卷ID"
						runat="server"></suntek:ChooseBox>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


