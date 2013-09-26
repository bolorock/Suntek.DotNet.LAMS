<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ThirdParty.aspx.cs" Inherits="WebSite.Assessment.ThirdParty" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>

    <script type="text/javascript" language="javascript">
       /*上传文件*/
        function uploadFile() {
            openOperateDialog("上传文档 ", "../Assessment/UploadFile.aspx?m=" + Math.random(), 700, 300);
        }

        /*浏览*/
        function view() {
            var $check = $("#<%= gvList.ClientID %>").find("input:checked");
            var val = $check.parent().parent().find("td:eq(1)").html();
            val = val.substring(0, val.lastIndexOf(".")) + ".swf";
            openOperateDialog("浏览 ", "../Assessment/PdfView.aspx?name=" + $.trim(val) + "&m=" + Math.random(), 700, 400);
        }

        /*删除文件*/
        function delFile() {
            var $check = $("#<%= gvList.ClientID %>").find("input:checked");
            var id = $check.val();

            $.post(getCurrentUrl(), { AjaxAction: "DelFile", AjaxArgument: id }, function (result) {
                var ajaxResult = JSON2.parse(result);
                if (ajaxResult) {
                    if (ajaxResult.ActionResult == 1) {
                        // $check.parent().parent().remove();
                        refresh();
                    }

                }

                alert(ajaxResult.PromptMsg);
            });
        }

        function rowDbClick(me, id, remember, url) {
            if (contextStore == "cookie") {
                if (remember)
                    setCookie("CurrentId", id);
            } else {
                if (remember)
                    $("#hidCurrentId").val(id)
            }

            var val = $(me).find("td:eq(1)").html();
            val = val.substring(0, val.lastIndexOf(".")) + ".swf";
            openOperateDialog("浏览 ", "../Assessment/PdfView.aspx?name=" + $.trim(val) + "&m=" + Math.random(), 700, 400);

            //openActionDialog("actionDialog", "View", "View", "查看", false, 0, 0, url, id);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div id="divContent" class="div_content" style="overflow: auto; height: 100%; width: 100%;
        overflow-x: hidden;">
        <div>
                    <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
                        DataKeyNames="ID" PageSize="15">
                        <Columns>
                            <asp:TemplateField HeaderText="选择">
                                <ItemTemplate>
                                    <input id="radioId" type="radio" value='<%#Eval("ID")%>' name="radioId" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="员工编号">
                                <ItemTemplate>
                                    <%#Eval("EmployeeID")%>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="名称">
                                <ItemTemplate>
                                    <%#Eval("Name")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="归属组织">
                                <ItemTemplate>
                                    <%#Eval("OwnerOrg")%>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <%--<asp:TemplateField HeaderText="创建人">
                                <ItemTemplate>
                                    <%#Eval("Creator")%>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="创建时间">
                                <ItemTemplate>
                                    <%#((DateTime)Eval("CreateTime")).ToShortDateString() %>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </suntek:PagedGridView>
        </div>
    </div>
    <div id="filterDialog" title="查询">
        <p id="validateTips">
        </p>
        <fieldset>
            <dl>
                <%--CountyManager,RegisterManager3列项--%>
                <dt id="lbDepartment" class="rowlable">单位</dt>
                <%-- RegisterManager2,CountyManager,SeniorManager--%>
                <dd id="inputDepartment" class="rowinput">
                    <asp:TextBox ID="filterDepartment" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbOrgName" class="rowlable">机构名称</dt>
                <dd id="inputOrgName" class="rowinput">
                    <asp:TextBox ID="filterOrgName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbOrgType" class="rowlable">机构分类</dt>
                <dd id="inputOrgType" class="rowinput">
                    <asp:TextBox ID="filterOrgType" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbOrgGrade" class="rowlable">机构等级</dt>
                <dd id="inputOrgGrade" class="rowinput">
                    <asp:TextBox ID="filterOrgGrade" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbName" class="rowlable">姓名</dt>
                <%-- RegisterManager2,CountyManager,SeniorManager--%>
                <dd id="inputName" class="rowinput">
                    <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <%-- RegisterManager2,CountyManager--%>
                <dt id="lbPosition" class="rowlable">现职务</dt>
                <dd id="inputPosition" class="rowinput">
                    <asp:TextBox ID="filterPosition" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbCode" class="rowlable">员工编号</dt>
                <dd id="inputCode" class="rowinput">
                    <asp:TextBox ID="filterCode" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <%-- MarketingManager列项--%>
                <dt id="lbCityBranch" class="rowlable">市分公司</dt>
                <dd id="inputCityBranch" class="rowinput">
                    <asp:TextBox ID="filterCityBranch" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbDistrictBranch" class="rowlable">县分公司</dt>
                <dd id="inputDistrictBranch" class="rowinput">
                    <asp:TextBox ID="filterDistrictBranch" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbMarketingService" class="rowlable">营销服务中心</dt>
                <dd id="inputMarketingService" class="rowinput">
                    <asp:TextBox ID="filterMarketingService" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbCategorizedFile" class="rowlable">分类分档</dt>
                <dd id="inputCategorizedFile" class="rowinput">
                    <asp:TextBox ID="filterCategorizedFile" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <%-- RegisterManager2列项--%>
                <dt id="lbPostGrade" class="rowlable">岗位等级</dt>
                <%--SeniorManager--%>
                <dd id="inputPostGrade" class="rowinput">
                    <asp:TextBox ID="filterPostGrade" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbIsChief" class="rowlable">正副职</dt>
                <dd id="inputIsChief" class="rowinput">
                    <asp:TextBox ID="filterIsChief" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbChargeWork" class="rowlable">分管工作</dt>
                <dd id="inputChargeWork" class="rowinput">
                    <asp:TextBox ID="filterChargeWork" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <%--SeniorManager列项--%>
                <dt id="lbPostName" class="rowlable">岗位名称</dt>
                <dd id="inputPostName" class="rowinput">
                    <asp:TextBox ID="filterPostName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbBirthday" class="rowlable">出生年月</dt>
                <dd id="inputBirthday" class="rowinput">
                    <asp:TextBox ID="filterBirthday" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbGender" class="rowlable">性别</dt>
                <dd id="inputGender" class="rowinput">
                    <suntek:ComboBox ID="filterGender" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="男" Value="男">
                        </asp:ListItem>
                        <asp:ListItem Text="女" Value="女">
                        </asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt id="lbOldPosition" class="rowlable">原职务</dt>
                <dd id="inputOldPosition" class="rowinput">
                    <asp:TextBox ID="filterOldPosition" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbOldPostGrade" class="rowlable">原职级</dt>
                <dd id="inputOldPostGrade" class="rowinput">
                    <asp:TextBox ID="filterOldPostGrade" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbOldPostGradeTime" class="rowlable">任原职级时间</dt>
                <dd id="inputOldPostGradeTime" class="rowinput">
                    <asp:TextBox ID="filterOldPostGradeTime" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbChangedTime" class="rowlable">改任时间</dt>
                <dd id="inputChangedTime" class="rowinput">
                    <asp:TextBox ID="filterChangedTime" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbOldPost" class="rowlable">转任前职位</dt>
                <dd id="inputOldPost" class="rowinput">
                    <asp:TextBox ID="filterOldPost" runat="server" CssClass="text"></asp:TextBox>
                </dd>
            </dl>
        </fieldset>
        <div id="loading" style="display: none; position: absolute; top: 18px; left: 200px">
            <img src="../Skins/Default/Images/loading.gif" />
        </div>
    </div>
</asp:Content>
