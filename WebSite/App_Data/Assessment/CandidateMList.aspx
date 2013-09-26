<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="CandidateMList.aspx.cs" Inherits="WebSite.CandidateMList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>

     <style type="text/css">
        /*==  内容列表(table)头部==*/
        .gridview th
        {
            font-weight: normal;
            font-size: 12px;
            font-weight: bold;
            color: #2C59AA;
            text-indent: 4px;
            text-align: center;
            background: url(../Skins/Default/Images/th1.gif);
            height: 22px;
            padding: 0;
            border-color: #B5D6E6;
            border: 1px solid #8DB2E3;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript" language="javascript">
        function selectCandidate(me) {
          

            var answerIDs = $("#hdfAnswerIDs", window.parent.document);
            var answerList = $("#AnswerList", window.parent.document);
            if ($(me).attr("checked")) {
              
            }
            if ($(me).attr("checked")) {
                if (answerIDs.index($(me).val()) == -1) {
                    var newItem = "<div  class=\"AnswerItem\" id=\"" + $(me).val() + "\">" + $(me).attr("employeeName") + "<img src=\"../Skins/Default/Images/del.gif\" onclick=\"delAnswerItem(this)\" alt=\"删除\"/></div>";
                   answerIDs.val(answerIDs.val() + $(me).val() + ",");
                   answerList.append(newItem);
                }
            }
           else {//移除选中的项 //并将选中的勾去掉
                var itemToRemove = $("#"+$(me).val(), answerList);
                if (itemToRemove[0])
                    itemToRemove.remove();
            

            }
         

        }
       
    </script>
    <div  id="divContent" class="div_content" style="width: 775px;overflow-x: auto;">
        <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
            DataKeyNames="EmployeeID" Width="760px" PageSize="10">
            <Columns>
                <asp:TemplateField HeaderText="选择">
                    <ItemTemplate>
                      <%--  <input id="radioId" type="radio" employeeid='<%#Eval("EmployeeID")%>' value='<%#Eval("ID")%>'
                            name="radioId" />--%>
                            <input type="checkbox" id="chkId" employeeName='<%#Eval("EmployeeName")%>' value='<%#Eval("EmployeeID")%>' onclick='selectCandidate(this)' />

                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="员工编号" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#Eval("Code")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="单位" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#Eval("OrgName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="姓名" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#Eval("EmployeeName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="经理类别" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#Eval("CandidateManagerGrade") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="所在部门" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#Eval("DeptName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="现任职务" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#Eval("PositionName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="现任级别" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#Eval("PostGrade")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="性别">
                    <ItemTemplate>
                        <%#Eval("Gender").ToString()=="0" ? "男":"女"%>
                    </ItemTemplate>
                </asp:TemplateField>
              
                <asp:TemplateField HeaderText="后备类型" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#Eval("TargetCandidate")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="后备成熟度" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#Eval("CandidateMaturity")%>
                    </ItemTemplate>
                </asp:TemplateField>
             
            </Columns>
        </suntek:PagedGridView>
    </div>
    <div id="filterDialog" title="查询">
        <p id="validateTips">
        </p>
        <fieldset>
            <dl>
                <dt class="rowlable">管理岗位</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterCandidatePostGrade" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="管理三岗" Value="管理三岗"></asp:ListItem>
                        <asp:ListItem Text="管理四岗" Value="管理四岗"></asp:ListItem>
                        <asp:ListItem Text="管理五岗" Value="管理五岗"></asp:ListItem>
                        <asp:ListItem Text="管理六岗" Value="管理六岗"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">人员代码</dt>
                <dd class="rowinput">
                    <suntek:ChooseBox ID="filterCode" OpenUrl="CodeTree.aspx" DialogTitle="选择人员代码" runat="server"></suntek:ChooseBox>
                </dd>
                <dt class="rowlable">登陆名</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterLoginName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">人员姓名</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
             <%--   <dt class="rowlable">操作员ID</dt>
                <dd class="rowinput">
                    <suntek:ChooseBox ID="filterOperatorID" OpenUrl="OperatorIDTree.aspx" DialogTitle="选择操作员ID"
                        runat="server"></suntek:ChooseBox>
                </dd>--%>
                <dt class="rowlable">性别</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterGender" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="男" Value="0"></asp:ListItem>
                        <asp:ListItem Text="女" Value="1"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">出生日期</dt>
                <dd class="rowinput">
                    <suntek:DatePicker ID="filterBirthday" runat="server"></suntek:DatePicker>
                </dd>
                <dt class="rowlable">民族</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterNation" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">出生地</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterBirthplace" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">籍贯</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterNativeplace" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">政治面貌</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterPoliticsStatus" runat="server" CssClass="text"></asp:TextBox>
                </dd>
<%--                <dt class="rowlable">参加工作时间</dt>
                <dd class="rowinput">
                    <suntek:DatePicker ID="filterWorkFromDate" runat="server"></suntek:DatePicker>
                </dd>--%>
                <%--<dt class="rowlable">健康状况</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterHealthStatus" runat="server" CssClass="text"></asp:TextBox>
                </dd>--%>
               <%-- <dt class="rowlable">专业技术职务</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterIndustrialGrade" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">特长</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterSpeciality" runat="server" CssClass="text"></asp:TextBox>
                </dd>--%>
                <dt class="rowlable">岗位名称</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterPositionName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">基本岗位</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterPosition" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">岗位等级</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterPostGrade" runat="server" CssClass="text"></asp:TextBox>
                </dd>
<%--                <dt class="rowlable">状态</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterStatus" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>--%>
               <%-- <dt class="rowlable">证件类型</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterCardType" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>--%>
                <%--<dt class="rowlable">证件号码</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterCardNo" runat="server" CssClass="text"></asp:TextBox>
                </dd>--%>
                <dt class="rowlable">入职日期</dt>
                <dd class="rowinput">
                    <suntek:DatePicker ID="filterInDate" runat="server"></suntek:DatePicker>
                </dd>
                <dt class="rowlable">离职日期</dt>
                <dd class="rowinput">
                    <suntek:DatePicker ID="filterOutDate" runat="server"></suntek:DatePicker>
                </dd>
                <dt class="rowlable">邮编</dt>
                <dd class="rowinput">
                    <suntek:ChooseBox ID="filterZipCode" OpenUrl="ZipCodeTree.aspx" DialogTitle="选择邮编"
                        runat="server"></suntek:ChooseBox>
                </dd>
                <dt class="rowlable">Email</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterEmail" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">传真号码</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterFax" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">手机号码</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterMobile" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">MSN号码</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterMSN" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">办公电话</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterOfficePhone" runat="server" CssClass="text"></asp:TextBox>
                </dd>
             <%--   <dt class="rowlable">住址</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterAddress" runat="server" CssClass="text"></asp:TextBox>
                </dd>--%>
                <dt class="rowlable">直接主管</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterDirector" runat="server" CssClass="text"></asp:TextBox>
                </dd>
              <%--  <dt class="rowlable">主机构ID</dt>
                <dd class="rowinput">
                    <suntek:ChooseBox ID="filterMajorOrgID" OpenUrl="MajorOrgIDTree.aspx" DialogTitle="选择主机构ID"
                        runat="server"></suntek:ChooseBox>
                </dd>
                <dt class="rowlable">照片</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterPhoto" runat="server" CssClass="text"></asp:TextBox>
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
