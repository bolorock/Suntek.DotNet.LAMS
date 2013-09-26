<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
 CodeBehind="AgeStructureReport.aspx.cs" Inherits="WebSite.AgeStructureReport" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("DetailJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <script type="text/javascript" language="javascript">
        //导出Excel
        function exportExcel() {
            var obj = getObjectValue("filterDialog");
            var str = escape(JSON2.stringify(obj));
            window.open("../LAMS/ExportXMLExcel.aspx?corpID=<%= CorpID %>&type=4&filterStr=" + str);
        }
    </script>
    <style type="text/css">
        .table
        {
            margin:0px auto;
        }
        .chart
        {
            margin: 0px auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div class="table">
        <asp:GridView ID="GridView1" CssClass="gridview" runat="server" Width="100%">
        </asp:GridView>
    </div>
    <div class="chart">
        <asp:Chart ID="Chart1" runat="server" Palette="BrightPastel" BackColor="#F3DFC1"
            Width="602px" Height="296px" BorderlineDashStyle="Solid" BackGradientStyle="TopBottom"
            BorderWidth="2" BorderColor="181, 64, 1">
            <Titles>
                <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                    Text="Column Chart" Name="Title1" ForeColor="26, 59, 105">
                </asp:Title>
            </Titles>
            <Legends>
                <asp:Legend TitleFont="Microsoft Sans Serif, 8pt, style=Bold" BackColor="Transparent"
                    Font="Trebuchet MS, 8.25pt, style=Bold" IsTextAutoFit="False" Enabled="False"
                    Name="Default">
                </asp:Legend>
            </Legends>
            <BorderSkin SkinStyle="Emboss"></BorderSkin>
            <Series>
                <asp:Series Name="Series1" BorderColor="180, 26, 59, 105">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BackSecondaryColor="White"
                    BackColor="OldLace" ShadowColor="Transparent" BackGradientStyle="TopBottom">
                    <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False"
                        WallWidth="0" IsClustered="False" />
                    <AxisY LineColor="64, 64, 64, 64" LabelAutoFitMaxFontSize="8">
                        <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                        <MajorGrid LineColor="64, 64, 64, 64" />
                    </AxisY>
                    <AxisX LineColor="64, 64, 64, 64" LabelAutoFitMaxFontSize="12">
                        <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsEndLabelVisible="False" />
                        <MajorGrid LineColor="64, 64, 64, 64" />
                    </AxisX>
                </asp:ChartArea>
            </ChartAreas>
        </asp:Chart>
    </div>
        <div id="filterDialog" title="查询">
        <p id="validateTips">
        </p>
        <fieldset>
            <dl>
                <dt class="rowlable">经理级别</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterCandidateManagerGrade" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="二级经理" Value="二级经理"></asp:ListItem>
                        <asp:ListItem Text="三级经理" Value="三级经理"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
            </dl>
            <dl>
                <dt class="rowlable">是否正职</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterIsChief" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
            </dl>
            <dl>
                <dt class="rowlable">后备类型</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterTargetCandidate" DropDownStyle="DropDownList" runat="server">
                    </suntek:ComboBox>
                </dd>
            </dl>
            <dl>
                <dt class="rowlable">后备成熟度</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterCandidateMaturity" DropDownStyle="DropDownList" runat="server">
                    </suntek:ComboBox>
                </dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>
