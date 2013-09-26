<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SpecialPrivilegeDetail.aspx.cs" Inherits="WebSite.SpecialPrivilegeDetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    
	<%= WebExtensions.CombresLink(Skin+"SiteCss") %>
	<%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("DetailJs") %>
	<%if (false)
      { %>
		<script   src="../Scripts/jquery-vsdoc.js" 
        type="text/javascript"></script> 
    <%}%>	

     <script type="text/javascript" language="javascript">

         //校验脚本

         function save(me, argument){
             var resources = getCheckedNodeIds();

             //var resources = getCheckedNodes();

             $.post(getCurrentUrl(), { AjaxAction: "Save", AjaxArgument: resources }, function (value) {
                 var ajaxResult = JSON2.parse(value);
                 if (ajaxResult) {
                     if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                         alert(ajaxResult.PromptMsg);

                         if (window.parent)
                             window.parent.closeDialog();
                     }
                 }
                 else {
                     alert("系统出错，请与管理员联系！");
                 }
             });
         }
    </script>

</head>
<body>

   <form id="form1" runat="server">

   

    <div class="div_block">
              <suntek:AjaxTree ID="AjaxTree1" Runat="server" />
              
    </div>
 </form>
</body>
</html>


