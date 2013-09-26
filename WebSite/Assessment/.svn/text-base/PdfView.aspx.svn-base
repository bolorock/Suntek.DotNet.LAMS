<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PdfView.aspx.cs" Inherits="WebSite.Assessment.PdfView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/Jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.query.js" type="text/javascript"></script>
    <script src="../Scripts/FlashView/FlexPaper/js/flexpaper_flash_debug.js" type="text/javascript"></script>
    <script src="../Scripts/FlashView/FlexPaper/js/flexpaper_flash.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
       <div style="position: absolute; left: 20px; top: 20px;">
        <a id="viewerPlaceHolder" style="width: 600px; height: 480px; display: block;"></a>
        <script type="text/javascript">

            var fileURL = $.query.get("name");
            var fp = new FlexPaperViewer(
        '../Scripts/FlashView/FlexPaper/FlexPaperViewer',
        'viewerPlaceHolder',
        { config: {
            SwfFile: escape('../AssessmentFile/' + fileURL),
            Scale: 1,
            ZoomTransition: 'easeOut',
            ZoomTime: 0.5,
            ZoomInterval: 0.2,
            FitPageOnLoad: false,
            FitWidthOnLoad: false,
            PrintEnabled: true,
            FullScreenAsMaxWindow: false,
            ProgressiveLoading: false,
            MinZoomSize: 0.2,
            MaxZoomSize: 5,
            SearchMatchAll: false,
            InitViewMode: 'Portrait',
            ViewModeToolsVisible: true,
            ZoomToolsVisible: true,
            NavToolsVisible: true,
            CursorToolsVisible: true,
            SearchToolsVisible: true,
            localeChain: 'en_US'
        }
        }
        );
        </script>
    </div>
    </form>
</body>
</html>
