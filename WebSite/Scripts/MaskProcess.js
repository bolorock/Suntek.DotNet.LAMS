function openprogress() {
    if (parent.$("#progress").length > 0) {
        parent.$("#progress").show();
    }
    if ($("#progress").length > 0) {
        $("#progress").show();
    }

}

function closeprogress(control) {
    if (parent.$("#progress").length > 0) {
        parent.$("#progress").hide();
    }
    if ($("#progress").length > 0) {
        $("#progress").hide();
    }
    control.className = "commanditem";
}

function disabledControl(control) {
    control.className = "commanditem_disabled";
}

function getPageSize() {
    //检测浏览器的渲染模式
    var body = (document.compatMode && document.compatMode.toLowerCase() == "css1compat") ? document.documentElement : document.body;

    var bodyOffsetWidth = 0;
    var bodyOffsetHeight = 0;
    var bodyScrollWidth = 0;
    var bodyScrollHeight = 0;
    var pageDimensions = [0, 0];

    pageDimensions[0] = body.clientHeight;
    pageDimensions[1] = body.clientWidth;

    bodyOffsetWidth = body.offsetWidth;
    bodyOffsetHeight = body.offsetHeight;
    bodyScrollWidth = body.scrollWidth;
    bodyScrollHeight = body.scrollHeight;

    if (bodyOffsetHeight > pageDimensions[0]) {
        pageDimensions[0] = bodyOffsetHeight;
    }

    if (bodyOffsetWidth > pageDimensions[1]) {
        pageDimensions[1] = bodyOffsetWidth;
    }

    if (bodyScrollHeight > pageDimensions[0]) {
        pageDimensions[0] = bodyScrollHeight;
    }

    if (bodyScrollWidth > pageDimensions[1]) {
        pageDimensions[1] = bodyScrollWidth;
    }

    return pageDimensions;
}

function showPopup(maskDiv, popupBox) {
    var pageArg = getPageSize();
    $("#" + maskDiv).css({ height: pageArg[0], width: pageArg[1] });
    var top = "";
    if (document.body.scrollTop) {
        top = (document.body.scrollTop + 100) + "px";
    }
    else {
        top = (document.documentElement.scrollTop + 100) + "px";
    }
    $("#" + popupBox).css({ top: top });
    $("#" + maskDiv).show();
    $("#" + popupBox).show();

}

function closePopup(maskDiv, popupBox) {
    $("#" + maskDiv).hide();
    $("#" + popupBox).hide();
}