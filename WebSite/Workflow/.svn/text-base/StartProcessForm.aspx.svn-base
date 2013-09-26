<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/Page.Master"
 CodeBehind="StartProcessForm.aspx.cs" Inherits="WebSite.Workflow.StartProcessForm" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("DetailJs") %>
   <script src="../Scripts/DatePicker/WdatePicker.js" type="text/javascript"></script>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript">

        function getFormValue(container) {
            var objValue = new Object();
            var inputs = container && container != "" ? $(":input", $("#" + container)) : $(":input");
            inputs.each(function () {
                var values = this.id.split("_");
                var property = values[values.length - 1];

                if (property == "SortOrder") {
                    objValue[property] = parseInt($(this).val());
                }
                else if ($(this).attr("tag") == "choosebox") {
                    if (endWith(property, "data")) {
                        objValue[property.substr(0, property.length - 4)] = $(this).val();
                    }
                }
                else if ($(this).attr("tag") == "combox") {
                    if (endWith(property, "data")) {
                        var enumValue = parseInt($(this).val());
                        if (!enumValue)
                            enumValue = $(this).val();
                        objValue[property.substr(0, property.length - 4)] = enumValue;
                    }
                }
                else if (property != "ParentID") {
                    if ($(this).attr("type") == "checkbox") {
                        objValue[property] = $(this).attr("checked") == true ? 1 : 0;
                    }
                    else {
                        objValue[property] = $(this).val();
                    }
                }
            });
            return objValue;
        }
        function submit() {

            //            $("input[isRequired='True']", "eForm").each(function (i) {
            //                if ($.trim($(this).text()) == "") {
            //                    alert("必填字段不允许为空！");
            //                    return;
            //                }
            //            });

            var value = JSON2.stringify(getFormValue("eForm"))
            $.post(getCurrentUrl(), { AjaxAction: "Save", AjaxArgument: value, CurrentId: $("#hidCurrentId").val() }, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                    if (ajaxResult.ActionResult == 1) {
                        message = "操作成功！";
                    }
                    $("#hidCurrentId").val(ajaxResult.RetValue);
                }
                alert(message);

                if (message == "操作成功！") {
                    if (window.parent) {
                        window.parent.close();
                        return;
                    }
                }
            });

        }
    </script>
    <div id="divContent" class="div_content">
        <asp:PlaceHolder ID="eForm" runat="server"></asp:PlaceHolder>
    <input type="hidden" id="txtDataSource" runat="server" />
    </div>
</asp:Content>
