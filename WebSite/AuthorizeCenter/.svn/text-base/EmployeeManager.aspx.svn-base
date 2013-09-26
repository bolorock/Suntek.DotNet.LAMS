<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="EmployeeManager.aspx.cs" Inherits="WebSite.EmployeeManager" %>

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

        //为gridview设置表头多行
        function SetGridViewHead() {
            var year = new Date().getFullYear();
            if ($(".gridview").find("thead").html() == null) { //当没有数据时，gridview会没有thread.
                $(".gridview").find("tbody").empty();
                $(".gridview").find("tbody").append("<tr><th nowrap=\"nowrap\"  rowspan=\"2\">选择</th><th nowrap=\"nowrap\"  rowspan=\"2\">员工编号</th><th nowrap=\"nowrap\"  rowspan=\"2\">单位</th><th nowrap=\"nowrap\"  rowspan=\"2\">姓名</th><th nowrap=\"nowrap\"  rowspan=\"2\">经理类别</th><th nowrap=\"nowrap\"  rowspan=\"2\">所在部门</th><th nowrap=\"nowrap\"  rowspan=\"2\">现任职务</th><th nowrap=\"nowrap\"  rowspan=\"2\">现任职级</th><th nowrap=\"nowrap\"  rowspan=\"2\">性别</th><th nowrap=\"nowrap\"  rowspan=\"2\">出生日期</th><th nowrap=\"nowrap\"  rowspan=\"2\">年龄</th><th nowrap=\"nowrap\"  rowspan=\"2\">任现职时间</th><th nowrap=\"nowrap\"  rowspan=\"2\">任现级时间</th><th nowrap=\"nowrap\"  rowspan=\"2\">任现级年限</th><th nowrap=\"nowrap\" rowspan=\"2\">全日制学历</th><th nowrap=\"nowrap\" rowspan=\"2\">最高学历</th><th nowrap=\"nowrap\" nowrap colspan=\"3\">近三年年度考核结果</th><th nowrap=\"nowrap\"  rowspan=\"2\">是否破格推荐</th><th nowrap=\"nowrap\"  rowspan=\"2\">民主推荐率</th><th nowrap=\"nowrap\"  rowspan=\"2\">后备类型</th><th nowrap=\"nowrap\"  rowspan=\"2\">后备成熟度</th><th nowrap=\"nowrap\"  rowspan=\"2\">后备排名</th><th nowrap=\"nowrap\"  rowspan=\"2\">状态</th><th nowrap=\"nowrap\"  rowspan=\"2\">入库员</th><th nowrap=\"nowrap\"  rowspan=\"2\">入库时间</th></tr><tr><th nowrap=\"nowrap\">" + (year - 3) + "</th><th nowrap=\"nowrap\">" + (year - 2) + "</th><th nowrap=\"nowrap\">" + (year-1) + "</th></tr>");
            }
            else {
                $(".gridview").find("thead").empty();
                $(".gridview").find("thead").append("<tr><th nowrap=\"nowrap\"  rowspan=\"2\">选择</th><th nowrap=\"nowrap\"  rowspan=\"2\">员工编号</th><th nowrap=\"nowrap\"  rowspan=\"2\">单位</th><th nowrap=\"nowrap\"  rowspan=\"2\">姓名</th><th nowrap=\"nowrap\"  rowspan=\"2\">经理类别</th><th nowrap=\"nowrap\"  rowspan=\"2\">所在部门</th><th nowrap=\"nowrap\"  rowspan=\"2\">现任职务</th><th nowrap=\"nowrap\"  rowspan=\"2\">现任职级</th><th nowrap=\"nowrap\"  rowspan=\"2\">性别</th><th nowrap=\"nowrap\"  rowspan=\"2\">出生日期</th><th nowrap=\"nowrap\"  rowspan=\"2\">年龄</th><th nowrap=\"nowrap\"  rowspan=\"2\">任现职时间</th><th nowrap=\"nowrap\"  rowspan=\"2\">任现级时间</th><th nowrap=\"nowrap\"  rowspan=\"2\">任现级年限</th><th nowrap=\"nowrap\" rowspan=\"2\">全日制学历</th><th nowrap=\"nowrap\" rowspan=\"2\">最高学历</th><th nowrap=\"nowrap\" nowrap colspan=\"3\">近三年年度考核结果</th><th nowrap=\"nowrap\"  rowspan=\"2\">是否破格推荐</th><th nowrap=\"nowrap\"  rowspan=\"2\">民主推荐率</th><th nowrap=\"nowrap\"  rowspan=\"2\">后备类型</th><th nowrap=\"nowrap\"  rowspan=\"2\">后备成熟度</th><th nowrap=\"nowrap\"  rowspan=\"2\">后备排名</th><th nowrap=\"nowrap\"  rowspan=\"2\">状态</th><th nowrap=\"nowrap\"  rowspan=\"2\">入库员</th><th nowrap=\"nowrap\"  rowspan=\"2\">入库时间</th></tr><tr><th nowrap=\"nowrap\">" + (year - 3) + "</th><th nowrap=\"nowrap\">" + (year - 2) + "</th><th nowrap=\"nowrap\">" + (year-1) + "</th></tr>");
            }
        }

        $(document).ready(function () {
            SetGridViewHead();
            setDefaultValue();
        });

        dialogSetting.detailWidth = 900;
        dialogSetting.detailHeight = 800;

        var employeeid = '';
        var candidateManagerID = '';

        /*获取首行值*/
        function setDefaultValue() {
            var currentRow = $(".rowcurrent", ".gridview");
            var radio = $("input:radio", currentRow);
            employeeid = radio.attr("employeeid");
            candidateManagerID = radio.attr("value");
        }
        function rowClick(me, id, remember) {
            if (currentRow) {
                currentRow.className = "gridview_row";
            }

            me.className = "rowcurrent";

            currentRow = me;
            var radio = $("input:radio", me);
            radio.attr("checked", true);
            if (id == '' || id.indexOf('UR1') < 0) {
                id = radio.attr("employeeid");
            }
            if (contextStore == "cookie") {
                if (remember)
                    setCookie("CurrentId", id);
            } else {
                if (remember)
                    $("#hidCurrentId").val(id);
            }
            employeeid = id;
            candidateManagerID =radio.attr("value");
            return id;
        }

        function openActionDialog(container, cmdName, argument, actionName, showModal, style, refreshParent) {
            var dialogShowModal = showModal || false;
            var dialogStyle = 1; //0表示弹出div,1表示弹出窗体
            var refresh = refreshParent || 1; //1刷新
            var currentID = cmdName == "Add" ? "" : "&CurrentId=" + employeeid;
            var url = "../LAMS/EmployeeRegister.aspx?Entry="+cmdName;

            if (url.indexOf('?') > 0)
                url += "&Runat=3&ActionFlag=" + cmdName + currentID +"&CandidateManagerID="+candidateManagerID+ "&radom=" + Math.random();
            else
                url += "?Runat=3&ActionFlag=" + cmdName + currentID +"&CandidateManagerID=" + candidateManagerID + "&radom=" + Math.random();

            if (dialogStyle == 1) {
                if (showModal) {
                    var cssDialog = "dialogHeight:" + dialogSetting.detailHeight + "px; dialogWidth:" + dialogSetting.detailWidth + "px; edge: Raised; center: Yes; resizable: Yes; status: No;scrollbars=no,";
                    return window.showModalDialog(url, cmdName, cssDialog);
                }
                else {
                    var cssDialog = 'center: Yes,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=' + dialogSetting.detailWidth + ',height=' + dialogSetting.detailHeight;
                    window.open(url, cmdName, cssDialog);
                }
            }
            else {
                container = "#" + container;
                if ($(container).html() != "")
                    $(container).dialog("destroy");
                $(container).html('<iframe id="bg_div_iframe" scrolling="no"  width="100%" height="98%" allowTransparency="true" frameborder="0"></iframe>');
                $('#bg_div_iframe').attr('src', url);

                $(container).dialog({
                    bgiframe: true,
                    autoOpen: false,
                    width: dialogSetting.detailWidth,
                    height: dialogSetting.detailHeight,
                    maxWidth: dialogSetting.detailWidth,
                    maxHeight: dialogSetting.detailHeight,
                    minWidth: dialogSetting.detailWidth,
                    minHeight: dialogSetting.detailHeight,
                    modal: true,
                    close: function () {
                        if (cmdName != "View" && refresh == 1)
                            __doPostBack('ctl00$commandBar', 'Search$Search');
                    }
                });
                $(container).dialog("option", "title", actionName);
                $(container).dialog("open");
            }
        }

        function exportExcel() {
            var url = getCurrentUrl();
            if (url.indexOf('?') > 0) {
                url = url.substring(url.indexOf('?'));
            }
            var obj = getObjectValue("filterDialog");
            var str = escape(JSON2.stringify(obj));
            window.open("../LAMS/ExportXMLExcel.aspx" + url + "&type=2&content="+str);
        }
    </script>
    <div  id="divContent" class="div_content" style="width: 775px;overflow-x: auto;">
        <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
            DataKeyNames="EmployeeID" Width="1800px" PageSize="15">
            <Columns>
                <asp:TemplateField HeaderText="选择">
                    <ItemTemplate>
                        <input id="radioId" type="radio" employeeid='<%#Eval("EmployeeID")%>' value='<%#Eval("ID")%>'
                            name="radioId" />
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
                <asp:TemplateField HeaderText="出生日期" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%# Eval("Birthday").ToSafeString() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="年龄">
                    <ItemTemplate>
                        <%#Eval("Age")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="任现职时间" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#Eval("InPostDate")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="任现级时间" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#Eval("InGradeDate")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="任现级年限">
                    <ItemTemplate>
                        <%#Eval("Tenure")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="全日制学历" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#Eval("FulltimeEducation")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="最高学历" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#Eval("InserviceEducation")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="2008">
                    <ItemTemplate>
                        <%#Eval("Assessment1")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="2009">
                    <ItemTemplate>
                        <%#Eval("Assessment2")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="2010">
                    <ItemTemplate>
                        <%#Eval("Assessment3")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="是否破格推荐">
                    <ItemTemplate>
                        <%#Eval("IsAnomalous").ToString()=="1" ? "是":"否"%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="民主推荐率">
                    <ItemTemplate>
                        <%#Eval("DemocracyPecent")%>
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
                <asp:TemplateField HeaderText="后备排名">
                    <ItemTemplate>
                        <%#Eval("CandidateOrder")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="状态" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#Eval("Status1") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="入库员" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#Eval("InitorName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="入库时间" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <%#((DateTime)Eval("InitTime")).ToString("yyyy-MM-dd HH:mm")%>
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
                <dt class="rowlable">员工编号</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterEmployeeCode" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">姓名</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterEmployeeName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">后备类型</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterTargetCandidate" DropDownStyle="DropDownList" runat="server">
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">现任职务</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterPositionName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">现任职级</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterPostGrade" runat="server" CssClass="text"></asp:TextBox>
                </dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>
