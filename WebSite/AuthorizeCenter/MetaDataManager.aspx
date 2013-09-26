
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="MetaDataManager.aspx.cs" Inherits="WebSite.MetaDataManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<%= WebExtensions.CombresLink(Skin+"SiteCss") %>
	<%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("ManagerJs") %>
	<%if (false)
      { %>
		<script   src="../Scripts/jquery-vsdoc.js" 
        type="text/javascript"></script> 
    <%}%>
    
  
    
    	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript" language="javascript">

  
        function save() {
            var resources = getCheckedNodes();

            var dataIDs = "";
            try {
                $("input:checked", $("#dataContainer")).each(function (i) {
                    dataIDs += $(this).attr("title") + ",";
                });

            } catch (e) { }

            $.post(getCurrentUrl(), { AjaxAction: "Save", AjaxArgument: JSON2.stringify(resources), DataIDs: dataIDs }, function (value) {
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

    <div class="div_block">
       
          
              <suntek:AjaxTree ID="AjaxTree1" Runat="server" />

    </div>
</asp:Content>


