
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ProcessDefDetail.aspx.cs" Inherits="WebSite.ProcessDefDetail" ValidateRequest="false"%>

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

   <script type="text/javascript" language="javascript">

        //校验脚本
        function initValidator()
        {
			$.formValidator.initConfig({ formid: "aspnetForm", showallerror: true, onerror: function(msg) { promptMessage(msg); } });
			/*默认验证字段*/
			$("#<%=txtName.ClientID%>").formValidator().inputValidator({ min: 1, max: 32, onerror: "【名称】格式不正确" });
			/*默认验证字段*/
			$("#<%=txtText.ClientID%>").formValidator().inputValidator({ min: 1,max: 64,onerror: "【显示名】格式不正确"});
			/*默认验证字段*/
			$("#<%=txtContent.ClientID%>").formValidator().inputValidator({min:1, onerror: "【流程内容】不能为空" });
			/*必选项*/
			$("#<%=chbCategoryID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【所属分类】不能为空" });
			/*非空字段*/
            $("#<%=txtStartor.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【流程启动者】不能为空" });
			/*默认验证字段*/
			$("#<%=txtVersion.ClientID%>").formValidator().inputValidator({max:16, onerror: "【版本】长度不能超过16" });
			/*默认验证字段*/
			$("#<%=txtDescription.ClientID%>").formValidator().inputValidator({max:256, onerror: "【描述】长度不能超过256" });
			
		
		}
		
		//页面初始化
        $(document).ready(function() {
			//初始化校验脚本
      		initValidator();
		 });

    function save(me, argument) {
        var processDef = getObjectValue();
        processDef.Content = encodeURI(processDef.Content);
        var value = JSON2.stringify(processDef)

        $.post(getCurrentUrl(), { AjaxAction: "Save", AjaxArgument: value}, function (result) {
            var ajaxResult = JSON2.parse(result);
            var message = "操作失败";
            if (ajaxResult) {
                if (ajaxResult.PromptMsg != null)
                    message = ajaxResult.PromptMsg
                if (ajaxResult.ActionResult == 1) {
                    if (message == "")
                        message = "操作成功！";
                }

                $("#hidCurrentId").val(ajaxResult.RetValue);
            }

            alert(message);
        });
    }
    </script>

    <div class="div_block">
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtName.ClientID%>" class="label">
            <em>*</em>
			                名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtText.ClientID%>" class="label">
            <em>*</em>
			                显示名
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtText" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div style="width:100%" >
            <div style="width:20%;text-align: right;float: left;">
			<label for="<%=txtContent.ClientID%>" class="label">
            <em>*</em>
			                流程内容
			</label>
            </div>
            <div style="width:80%; height:150px;text-align: left;float: left;" >
                <asp:TextBox ID="txtContent" runat="server"  Height="95%" Width="86%" textmode="MultiLine"></asp:TextBox>
            </div>
            </div>
            <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbCategoryID.ClientID%>" class="label">
			<em>*</em>
                所属分类
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:Combox ID="chbCategoryID" runat="server" IsSingle="true">
                </suntek:Combox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboCurrentState.ClientID%>" class="label">
			                当前状态
			</label>
            </div>
            <div class="div_row_input">
                <suntek:Combox runat="server" ID="cboCurrentState"></suntek:Combox>
            </div>
            </div>
            <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=cboCurrentFlag.ClientID%>" class="label">
			                是否当前版本
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:Combox ID="cboCurrentFlag" runat="server">
                        </suntek:Combox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtVersion.ClientID%>" class="label">
			                版本
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtVersion" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtStartor.ClientID%>" class="label">
			<em>*</em>
                流程启动者
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtStartor" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboIsActive.ClientID%>" class="label">
			                是否有活动实例
			</label>
            </div>
            <div class="div_row_input">
            <suntek:Combox ID="cboIsActive" runat="server" IsSingle="true">
                        </suntek:Combox>
            </div>
        </div>
        
        <div class="div_row" >       
            <div class="div_row_lable">
			<label for="<%=txtDescription.ClientID%>" class="label">
			                描述
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="text" ></asp:TextBox>
            </div>
        </div>
       
    </div>
</asp:Content>

