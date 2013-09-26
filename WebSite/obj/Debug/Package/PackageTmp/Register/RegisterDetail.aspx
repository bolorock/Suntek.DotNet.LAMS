<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="RegisterDetail.aspx.cs" Inherits="WebSite.Register.RegisterDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <%--jquery.uploadify --%>
    <link rel="Stylesheet" href="../Scripts/JQuery.uploadify/uploadify.css" />
    <script type="text/javascript" src="../Scripts/JQuery.uploadify/swfobject.js"></script>
    <script type="text/javascript" src="../Scripts/JQuery.uploadify/jquery.uploadify.min.js"></script>
    <style type="text/css">
        table
        {
            font-size: 12px;
            border: 1px solid #DEDEDE;
            border-collapse: collapse;
            width: 100%;
            padding: 2px;
        }
        table th
        {
            background-color: #3E6197;
            color: #E6FFFF;
            text-align: left;
            border: 1px solid #DEDEDE;
        }
        table td
        {
            empty-cells: show;
            border: 1px solid #DEDEDE;
            white-space: nowrap;
        }
    </style>
    <script type="text/javascript" language="javascript">

        function PreviewImg(me) {
            $("#<%=imgRegister.ClientID%>").attr("src", $(me).val());
            //            $.post(getCurrentUrl(), { AjaxAction: "UploadPic", AjaxArgument: "" }, function (value) {});
        }

        $(function () {
            InitUploadify();
            if (($.browser.msie && $.browser.version == '8.0') || (!$.browser.msie)) {
                $("#divTable").css({ "height": "100%", "overflow-x": "hidden", "overflow-y": "auto" });
                $(" html, body, form").css({ "margin": "0px", "height": "100%" });
            }

            if ($.browser.msie && $.browser.version == '6.0') {
                $("#<%= txtPostGradeExperience.ClientID %>").css({ "width": "98%", "height": "100%", "overflow-y": "visible" })
            }

        });

        /*初始化上传控件*/
        function InitUploadify() {
            var code = $("#<%= hfCode.ClientID %>").val();
            $("#uploadify").uploadify({
                'uploader': '../Scripts/JQuery.uploadify/uploadify.swf',
                'script': 'UploadHandler.ashx',
                'scriptData': { 'code': code },
                'cancelImg': '../Scripts/JQuery.uploadify/cancel.png',
                //'queueID': 'fileQueue',
                'fileDesc': '*.jpg;*.gif;*.png',
                'fileExt': '*.jpg;*.gif;*.png',
                'auto': true,
                'multi': true,
                'sizeLimit': '2097152', //2M  
                'buttonImg': '../Skins/Default/Images/uploadPic.jpg',
                'wmode': 'transparent',
                'removeCompleted': true,
                'width': 82,
                'height': 25,
                'onError': function (event, ID, fileObj, errorObj) {
                    alert(errorObj.type + ' Error: ' + errorObj.info)
                },
                'onSelect': function (event, ID, fileObj) {

                },
                'onComplete': function (event, ID, fileObj, response, data) {
                    if (response == "1") {
                        $("#<%= imgRegister.ClientID %>").attr("src", "../FileEmployeePic/" + code + ".jpg?radom=" + Math.random());
                    }
                },
                'onAllComplete': function (event, data) {

                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div id="divTable">
        <table id="tbInfo" style="background-color: White;">
            <tr>
                <td class="toptitle5" colspan="7" height="20">
                    <div class="toptitle">
                        名册详细信息</div>
                </td>
            </tr>
            <tr>
                <td>
                    单位/部门
                </td>
                <td style="width: 126px;">
                    <asp:TextBox ID="txtDepartment" runat="server" Width="98%"></asp:TextBox>
                    <asp:HiddenField ID="hfCode" runat="server" />
                </td>
                <td>
                    姓名
                </td>
                <td style="width: 126px;">
                    <asp:TextBox ID="txtName" runat="server" Width="98%"></asp:TextBox>
                </td>
                <td>
                    性别
                </td>
                <td style="width: 126px;">
                    <suntek:ComboBox ID="cboGender" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server" Width="98%">
                        <asp:ListItem Text="男" Value="男">
                        </asp:ListItem>
                        <asp:ListItem Text="女" Value="女">
                        </asp:ListItem>
                        <asp:ListItem Text="" Value="-1" Selected="True">
                        </asp:ListItem>
                    </suntek:ComboBox>
                </td>
                <td width="130" rowspan="5">
                    <asp:Image ID="imgRegister" runat="server" Width="100px" />
                    <div>
                        <input type="file" name="uploadify" id="uploadify" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    出生年月
                </td>
                <td>
                    <asp:TextBox ID="txtBirthday" runat="server" Width="98%"></asp:TextBox>
                </td>
                <td>
                    籍贯
                </td>
                <td>
                    <asp:TextBox ID="txtBirthplace" runat="server" Width="98%"></asp:TextBox>
                </td>
                <td>
                    参加工作时间
                </td>
                <td>
                    <asp:TextBox ID="txtWorkTime" runat="server" Width="98%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    入本系统时间
                </td>
                <td>
                    <asp:TextBox ID="txtSystemTime" runat="server" Width="98%"></asp:TextBox>
                </td>
                <td>
                    政治面貌
                </td>
                <td>
                    <asp:TextBox ID="txtPoliticalFace" runat="server" Width="98%"></asp:TextBox>
                </td>
                <td>
                    入党时间
                </td>
                <td>
                    <asp:TextBox ID="txtPartyTime" runat="server" Width="98%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    正副职
                </td>
                <td>
                    <suntek:ComboBox ID="cboIsChief" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server" Width="98%">
                        <asp:ListItem Text="正职" Value="正职">
                        </asp:ListItem>
                        <asp:ListItem Text="副职" Value="副职">
                        </asp:ListItem>
                        <asp:ListItem Text="" Value="-1" Selected="True">
                        </asp:ListItem>
                    </suntek:ComboBox>
                </td>
                <td>
                    任现职时间
                </td>
                <td>
                    <asp:TextBox ID="txtCurrentPostTime" runat="server" Width="98%"></asp:TextBox>
                </td>
                <td>
                    任现级时间
                </td>
                <td>
                    <asp:TextBox ID="txtCurrentGradeTime" runat="server" Width="98%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    职务
                </td>
                <td colspan="5">
                    <asp:TextBox ID="txtPosition" runat="server" Width="98%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td rowspan="6">
                    学历学位
                </td>
                <td rowspan="3">
                    全日制教育
                </td>
                <td colspan="2" rowspan="3">
                    <table>
                        <tr>
                            <td>
                                学历
                            </td>
                            <td colspan="2" style="width: 100px;">
                                <suntek:ComboBox ID="cboFulltimeEducation" DropDownStyle="DropDownList" Width="98%"
                                    runat="server">
                                </suntek:ComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                学位
                            </td>
                            <td colspan="2" style="width: 100px;">
                                <asp:TextBox ID="txtFulltimeDegree" runat="server" Width="98%"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    毕业学校
                </td>
                <td colspan="2">
                    <asp:TextBox ID="txtFulltimeSchool" runat="server" Width="98%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    系及专业
                </td>
                <td colspan="2">
                    <asp:TextBox ID="txtFulltimeProfessional" runat="server" Width="98%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    毕业时间
                </td>
                <td colspan="2">
                    <asp:TextBox ID="txtFulltimeGraduationTime" runat="server" Width="98%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td rowspan="3">
                    在职教育
                </td>
                <td colspan="2" rowspan="3">
                    <table>
                        <tr>
                            <td>
                                学历
                            </td>
                            <td colspan="2" style="width: 100px;">
                                <suntek:ComboBox ID="cboParttimeEducation" DropDownStyle="DropDownList" Width="98%"
                                    runat="server">
                                </suntek:ComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                学位
                            </td>
                            <td colspan="2" style="width: 100px;">
                                <asp:TextBox ID="txtParttimeDegree" runat="server" Width="98%"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    毕业学校
                </td>
                <td colspan="2">
                    <asp:TextBox ID="txtParttimeSchool" runat="server" Width="98%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    系及专业
                </td>
                <td colspan="2">
                    <asp:TextBox ID="txtParttimeProfessional" runat="server" Width="98%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    毕业时间
                </td>
                <td colspan="2">
                    <asp:TextBox ID="txtParttimeGraduationTime" runat="server" Width="98%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    分管工作
                </td>
                <td colspan="6">
                    <asp:TextBox ID="txtChargeWork" runat="server" TextMode="MultiLine" Width="98%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    任职级经历
                </td>
                <td colspan="6">
                    <asp:TextBox ID="txtPostGradeExperience" runat="server" Width="98%" TextMode="MultiLine"
                        Height="180px"></asp:TextBox>
                </td>
            </tr>
            <tr style="height: 110px">
                <td>
                    任级经历
                </td>
                <td colspan="6">
                    <asp:TextBox ID="txtGradeExperience" runat="server" Width="98%" TextMode="MultiLine"
                        Height="100px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
