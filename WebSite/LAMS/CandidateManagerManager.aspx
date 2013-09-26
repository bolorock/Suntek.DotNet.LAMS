
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="CandidateManagerManager.aspx.cs" Inherits="WebSite.CandidateManagerManager" %>

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

        <script type="text/javascript" language="javascript">
            dialogSetting.detailWidth = 650;
            dialogSetting.detailHeight = 300;
    </script>
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
		        <asp:TemplateField HeaderText="员工ID">
                    <ItemTemplate>
						<%#Eval("EmployeeID")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="目标后备">
                    <ItemTemplate>
						<%#Eval("TargetCandidate")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="任现职时间">
                    <ItemTemplate>
						<%#Eval("InPostDate")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="任现级时间">
                    <ItemTemplate>
						<%#Eval("InGradeDate")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="任现级年限">
                    <ItemTemplate>
						<%#Eval("Tenure")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="后备成熟度">
                    <ItemTemplate>
						<%#Eval("CandidateMaturity")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="后备排名">
                    <ItemTemplate>
						<%#Eval("CandidateOrder")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="民主推荐率">
                    <ItemTemplate>
						<%#Eval("DemocracyPecent")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="是否破格推荐">
                    <ItemTemplate>
						<%#Eval("IsAnomalous")=="0" ? "否":"是"%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="考核结果1">
                    <ItemTemplate>
						<%#Eval("Assessment1")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="考核结果2">
                    <ItemTemplate>
						<%#Eval("Assessment2")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="考核结果3">
                    <ItemTemplate>
						<%#Eval("Assessment3")%>
                    </ItemTemplate>
                </asp:TemplateField>
		      <%--  <asp:TemplateField HeaderText="创建者">
                    <ItemTemplate>
						<%#Eval("Creator")%>
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="创建时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("CreateTime")).ToShortDateString() %>
                    </ItemTemplate>
                </asp:TemplateField>--%>
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
				<dt class="rowlable">目标后备</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterTargetCandidate" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">任现职时间</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterInPostDate" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">任现级时间</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterInGradeDate" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">任现级年限</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterTenure" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">后备成熟度</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterCandidateMaturity" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">后备排名</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterCandidateOrder" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">民主推荐率</dt>
				<dd class="rowinput">
                        <asp:TextBox ID="filterDemocracyPecent" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">是否破格推荐</dt>
				<dd class="rowinput">
					   <suntek:ComboBox ID="filterIsAnomalous" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="否" Value="0" ></asp:ListItem>
							<asp:ListItem Text="是" Value="1" ></asp:ListItem>
                        </suntek:ComboBox>
				</dd>
				<%--<dt class="rowlable">考核结果1</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterAssessment1" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">考核结果2</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterAssessment2" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">考核结果3</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterAssessment3" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">创建者</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterCreator" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">创建时间</dt>
				<dd class="rowinput">
						<suntek:DatePicker ID="filterCreateTime" runat="server"></suntek:DatePicker>
				</dd>--%>
            </dl>
        </fieldset>
    </div>
</asp:Content>


