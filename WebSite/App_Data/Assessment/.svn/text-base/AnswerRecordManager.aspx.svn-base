
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="AnswerRecordManager.aspx.cs" Inherits="WebSite.AnswerRecordManager" %>

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
		        <asp:TemplateField HeaderText="测评结果ID">
                    <ItemTemplate>
						<%#Eval("AssessmentResultID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="题目ID">
                    <ItemTemplate>
						<%#Eval("SubjectID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="答案">
                    <ItemTemplate>
						<%#Eval("Anwser")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="得分">
                    <ItemTemplate>
						<%#Eval("Score")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="评分人">
                    <ItemTemplate>
						<%#Eval("Scorer")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="评分时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("ScoreTime")).ToShortDateString() %>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="综合评分">
                    <ItemTemplate>
						<%#Eval("FinalScore")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="归属组织">
                    <ItemTemplate>
						<%#Eval("OwnerOrg")%>
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
				<dt class="rowlable">测评结果ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterAssessmentResultID" OpenUrl="AssessmentResultIDTree.aspx" DialogTitle="选择测评结果ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">题目ID</dt>
				<dd class="rowinput">
						<suntek:ChooseBox ID="filterSubjectID" OpenUrl="SubjectIDTree.aspx" DialogTitle="选择题目ID"
						runat="server"></suntek:ChooseBox>
				</dd>
				<dt class="rowlable">答案</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterAnwser" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">得分</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterScore" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">评分人</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterScorer" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">评分时间</dt>
				<dd class="rowinput">
						<suntek:DatePicker ID="filterScoreTime" runat="server"></suntek:DatePicker>
				</dd>
				<dt class="rowlable">综合评分</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterFinalScore" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">归属组织</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterOwnerOrg" runat="server" CssClass="text"></asp:TextBox>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


