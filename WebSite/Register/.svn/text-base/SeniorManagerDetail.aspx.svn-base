<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="SeniorManagerDetail.aspx.cs" Inherits="WebSite.Register.SeniorManagerDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("DetailJs") %>
    <%if (false)
      { %>
    <script src="<%=string.Format("{0}/Scripts/jquery-vsdoc.js",RootPath)%>" type="text/javascript"></script>
    <%}%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript" language="javascript">

        //校验脚本
        function initValidator() {
            $.formValidator.initConfig({ formid: "aspnetForm", showallerror: true, onerror: function (msg) { alert(msg); } });
            /*部门*/
            $("#<%=txtDepartment.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【部门/单位】不能为空" });
             /*非空字段*/
            $("#<%=txtName.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【名称】不能为空" });
            /*创建者不能为空*/
            $("#<%=txtCode.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【员工编号】不能为空" });
        }

        //页面初始化
        $(document).ready(function () {
            //初始化校验脚本
            initValidator();
        });
    </script>
    <div class="div_block">
        <div class="div_row">
            <div class="block_title">
                名册详细信息</div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=txtDepartment.ClientID%>" class="label">
                    <em>*</em> 单位/部门
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDepartment" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
                <label for="<%=txtName.ClientID%>" class="label">
                    <em>*</em>姓名
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=cboGender.ClientID%>" class="label">
                    <em>*</em> 性别
                </label>
            </div>
            <div class="div_row_input">
                <suntek:ComboBox ID="cboGender" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                    runat="server" Width="98%">
                    <asp:ListItem Text="男" Value="0" Selected="True">
                    </asp:ListItem>
                    <asp:ListItem Text="女" Value="1">
                    </asp:ListItem>
                </suntek:ComboBox>
            </div>
            <div class="div_row_lable">
                <label for="<%=txtBirthday.ClientID%>" class="label">
                    出生年月
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtBirthday" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=txtPostName.ClientID%>" class="label">
                    岗位名称
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtPostName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
                <label for="<%=txtPostGrade.ClientID%>" class="label">
                    岗位层级
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtPostGrade" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=txtOldPosition.ClientID%>" class="label">
                    原职务
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtOldPosition" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
                <label for="<%=txtOldPostGrade.ClientID%>" class="label">
                    原职级
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtOldPostGrade" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=txtOldPostGradeTime.ClientID%>" class="label">
                    任原职级时间
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtOldPostGradeTime" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
                <label for="<%=txtChangedTime.ClientID%>" class="label">
                    改任时间
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtChangedTime" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=txtOldPost.ClientID%>" class="label">
                    转任前职位
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtOldPost" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
                <label for="<%=txtRemarks.ClientID%>" class="label">
                    备注
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtRemarks" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=txtCode.ClientID%>" class="label">
                    <em>*</em> 员工编号
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtCode" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
    </div>
</asp:Content>
