<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/Page.Master" CodeBehind="DeptDetail.aspx.cs" 
Inherits="WebSite.AuthorizeCenter.DeptDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
	<%= WebExtensions.CombresLink(Skin+"SiteCss") %>
	<%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("DetailJs") %>
	<%if (false)
      { %>
		<script   src="../Scripts/jquery-vsdoc.js" 
        type="text/javascript"></script> 
    <%}%>	

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
<script type="text/javascript">
    //校验脚本
    function initValidator() {
        $.formValidator.initConfig({ formid: "aspnetForm", showallerror: true, onerror: function (msg) { promptMessage(msg); } });
        /*非空字段*/
        $("#<%=txtName.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【部门名称】不能为空" });
        /*非空字段*/
        $("#<%=txtSortOrder.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【序号】不能为空" });
        }

    //页面初始化
    $(document).ready(function () {
        //初始化校验脚本
        initValidator();
    });
    function save(me, argument) {
       var deptDetail = getObjectValue("deptDetail");
        var value = JSON2.stringify(deptDetail)
        $.post(getCurrentUrl(), { AjaxAction: "Save", AjaxArgument: value }, function (result) {
            var ajaxResult = JSON2.parse(result);
            var message = "操作失败";
            if (ajaxResult) {
                if (ajaxResult.PromptMsg != null)
                    message = ajaxResult.PromptMsg
                if (ajaxResult.ActionResult == 1) {
                    if (message == "")
                        message = "操作成功！";
                }

                $("#hidCurrentId").val(ajaxResult.RetValue.ID);
            }
            alert(message);
        });
    }
</script>
<div class="div_block" id="deptDetail">
    <div class="div_row">
    <div class="div_row_lable">
			<label for="<%=txtName.ClientID%>" class="label">
			                部门名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtSortOrder.ClientID%>" class="label">
			序号
			</label>
            </div>
            <div class="div_row_input">
            <asp:TextBox ID="txtSortOrder" runat="server" CssClass="text"></asp:TextBox>
			 </div>
    </div>
</div>
</asp:Content>

