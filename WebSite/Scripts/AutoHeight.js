/// <reference path="jquery-vsdoc.js" />
function doAutoHeight() {
    var iframes = document.getElementsByTagName('iframe');
    if (iframes && iframes.length > 0) {
        for (i = 0; i < iframes.length; i++) {
            if (/\bautoHeight\b/.test(iframes[i].className)) {
                setHeight(iframes[i]);
                addEvent(iframes[i], 'load', doAutoHeight);
            }
        }
    }
    else {
        var mainFrame = $("#main", window.parent.document);
        if (mainFrame[0]) {
            $(document.body).height($("#main", window.parent.document).height()-20);
            $("#page").height($(document.body).height()-20);
        }
        else {
            $("#page").height($(document).height()-20);
        }
    }
}

function setHeight(e) {
    var mainFrame = $("#main", window.parent.document);
    var height;
    if (mainFrame[0]) {
        height = $("#main", window.parent.document).height() - 60;
    }
    else {
        $("#page").height($(document).height() - $("#divNav").height() - 20);
        var height = $("#page").height();
    }
    if ($(e).parent().attr("tagName") == "DIV")
        $(e).parent().height(height);
    height = height - 20;
    if (e.contentDocument) {
        if (window.frameElement) {
            $(e.contentDocument.body).height($(window.frameElement).height());
        }
        $("#page", e.contentDocument.body).height(height);
    } else {
        if (window.frameElement) {
            $(e.contentWindow.document.body).height($(window.frameElement).height());
        }
        $("#page", e.contentWindow.document.body).height(height);
    }
}

function addEvent(obj, evType, fn) {
    if (obj.addEventListener) {
        obj.addEventListener(evType, fn, false);
        return true;
    } else if (obj.attachEvent) {
        var r = obj.attachEvent("on" + evType, fn);
        return r;
    } else {
        return false;
    }
}
//$(function () {
//    doAutoHeight();
//});

//if (window.parent && document.getElementById && document.createTextNode) {
//    addEvent(window, 'load', doAutoHeight);
//}
