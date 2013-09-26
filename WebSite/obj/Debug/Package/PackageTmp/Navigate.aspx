<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Navigate.aspx.cs" Inherits="WebSite.NavigatePage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%= WebExtensions.CombresLink(Skin + "SiteCss")%>
    <%= WebExtensions.CombresLink(Skin + "NavigatePageCss")%>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("MTreesJs")%>
    <style type="text/css">
        html
        {
           /* background-color: #EEF2FB;*/
           /*layout_button_right.gif*/
        }
        body
        {
            font: 12px Arial, Helvetica, sans-serif;
            color: #000;
            margin: 0px;
            padding: 0px;
        }
    </style>
</head>
<body>
    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#EEF2FB" align="center">
        <tr>
            <td width="182" valign="top">
                <div id="container">
                    <%=BuildNavigateBar() %>
                </div>
                <script type="text/javascript">
                    var contents = document.getElementsByClassName('content');
                    var toggles = document.getElementsByClassName('type');

                    var myAccordion = new fx.Accordion(
			toggles, contents, { opacity: true, duration: 400 }
		);
                    myAccordion.showThisHideOpen(contents[0]);
                </script>
            </td>
        </tr>
    </table>
</body>
</html>
