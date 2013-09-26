//====================================================================================================
//----------------------------------------------------------------------------------------------------
// [描    述] 用于放置整个站点的公共js脚本
//            
//
//----------------------------------------------------------------------------------------------------
// [作者] 	    trenhui
// [日期]       2009-07-16
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// [历史记录]
// [作者]  
// [描    述]     
// [更新日期]
// [版 本 号] ver1.0
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//====================================================================================================
/// <reference path="jquery-vsdoc.js" />
/// <reference path="Cookie.js" />


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Author     ：trenhui
//Descripton ：页面窗体相关方法
//Begin      ：
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

var contextStore = "database";
function closeWindow() {
    if (window.parent)
        window.parent.opener = null;
    window.close();
}

function closeRefreshParent() {
    if (window.opener) {
        window.opener.location.reload();
        window.opener = null;
        window.close();
    }

    if (window.parent) {
        window.parent.location.reload();
        window.close();
        return;
    }
}

function refreshParent() {
    if (window.parent) {
        window.parent.location.reload();
        return;
    }

    if (window.opener) {
        window.opener.location.reload();
    }
    //    if (window.parent) {
    //        var url = window.parent.document.URL;
    //        if (url.indexOf("random") < 0) {
    //            var appendSign = url.indexOf("?") > 0 ? "&" : "?";
    //            url = url + appendSign + "random=" + Math.random();
    //        }
    //        window.parent.document.URL = url;
    //        return;
    //    }

    //    if (window.opener) {
    //        var url = window.opener.document.URL;
    //        if (url.indexOf("random") < 0) {
    //            var appendSign = url.indexOf("?") > 0 ? "&" : "?";
    //            url = url + appendSign + "random=" + Math.random();
    //        }
    //        window.opener.document.URL = url;
    //    }
}

function refresh() {
    window.opener = null;

    var url = window.document.URL;
    if (url.indexOf("random") < 0) {
        var appendSign = url.indexOf("?") > 0 ? "&" : "?";
        url = url.replace("#", "") + appendSign + "random=" + Math.random();
    }
    window.document.URL = url;
}

function refreshAll() {
    refreshParent(); //刷新父页面
    refresh(); //刷新当前页面
}

var alertMessage = "";
function messageBox() {
    if (alertMessage && alertMessage != "") {
        alert(alertMessage);
        alertMessage = "";
    }
}

function closeDialog(divDialog, refresh) {
    var isDiv = divDialog || 1;
    var doRefresh = refresh || 0;
    try {
        if (isDiv) {
            if ($("#actionDialog")[0]) {
                $("#actionDialog").dialog("close");
            }
            else if (window.parent) {
                var item = window.parent.document.getElementById("actionDialog");
                if (item)
                    $(item).dialog("close");
            }
        }
        else {
            document.close();
            window.parent.opener = null;
            window.close();
        }

        if (refresh) {
            window.opener = null;
            var url = window.document.URL;
            if (url.indexOf("random") < 0) {
                var appendSign = url.indexOf("?") > 0 ? "&" : "?";
                url = url + appendSign + "random=" + Math.random();
            }

            window.document.URL = url;
        }
    }
    catch (e) {
    }
}

//关闭弹出层窗口
function afterSave(closeDiv) {
    if (closeDiv && window.parent) {
        window.setTimeout("window.parent.closeDialog(true,true);", 500);
    }
    else {
        document.close();
        window.parent.opener = null;
        window.close();
    }
}

function getCurrentUrl() {
    return document.URL.split('#')[0];
}

//弹出操作对话框：container 对话容器，title窗体标题，url页面地址，width弹出窗宽度，height弹出窗框高度,showModal是否模态显示，style弹出样式（0表示弹出div,1表示弹出窗体）
function openDialog(container, title, url, width, height, showModal, style) {

    var dialogWidth = width || 350;
    var dialogHeitht = height || 400;
    var dialogShowModal = showModal || true;
    var dialogStyle = style || 0; //0表示弹出div,1表示弹出窗体
    container = "#" + container;

    if (url.indexOf("random") < 0) {
        var appendSign = url.indexOf("?") > 0 ? "&" : "?";
        url = url + appendSign + "random=" + Math.random();
    }

    if (dialogStyle == 1) {
        if (showModal) {
            var cssDialog = "dialogHeight:" + dialogHeitht + "px; dialogWidth:" + dialogWidth + "px; edge: Raised; center: Yes; resizable: Yes; status: No;scrollbars=no,";
            return window.showModalDialog(url, title, cssDialog);
        }
        else {
            var cssDialog = 'center: Yes,status=yes,menubar=no,scrollbars=no,resizable=yes,width=' + dialogWidth + ',height=' + dialogHeitht;
            window.open(url, title, cssDialog);
        }
    }
    else {
        if ($(container).html() != "")
            $(container).dialog("destroy");
        $(container).html('<iframe id="bg_div_iframe" width="100%" height="98%"  frameborder="0"></iframe>');
        $('#bg_div_iframe').attr('src', url);

        var selects = document.getElementsByTagName("select");
        for (var i = 0; i < selects.length; i++) {
            selects[i].style.display = 'none';

        }
        $(container).dialog({
            bgiframe: true,
            autoOpen: false,
            width: dialogWidth,
            height: dialogHeitht,
            modal: dialogShowModal,
            close: function () {
                var selects = document.getElementsByTagName("select");
                for (var i = 0; i < selects.length; i++) {
                    selects[i].style.display = "";
                }
            }
        });
        $(container).dialog("option", "title", title);
        $(container).dialog("open");
    }
}


function startWith(value, searchValue) {

    if (value.length < searchValue) return false;

    if (searchValue.length > 0) {
        for (var i = 0; i < searchValue.length; i++) {
            if (value.charAt(i) != searchValue.charAt(i))
                return false;
        }

        return true;
    }

    return false;
}

function endWith(value, searchValue) {

    if (value.length < searchValue) return false;

    if (searchValue.length > 0) {
        for (var i = searchValue.length - 1; i > 0; i--) {
            if (value.charAt(value.length - (searchValue.length - i)) != searchValue.charAt(i))
                return false;
        }

        return true;
    }

    return false;
}

function getEvent() {
    if (document.all) {
        return window.event; //如果是ie
    }

    func = getEvent.caller;
    while (func != null) {
        var arg0 = func.arguments[0];
        if (arg0) {
            if ((arg0.constructor == Event || arg0.constructor == MouseEvent) || (typeof (arg0) == "object" && arg0.preventDefault && arg0.stopPropagation)) {
                return arg0;
            }
        }
        func = func.caller;
    }
    return null;
}

///滑动显示与隐藏图层
function ShowAndHide(id) {
    $("#" + id).toggle();

    var ev = getEvent();
    var srcElement = ev.srcElement || ev.target; // src 就是事件的触发源

    if (srcElement.src) {
        var iconSrc = srcElement.src;
        if (iconSrc.indexOf("layout_button_up.gif") > 0) {
            srcElement.src = iconSrc.substring(0, iconSrc.indexOf("layout_button_up.gif")) + "arrow4.gif";
        }
        else {
            srcElement.src = iconSrc.substring(0, iconSrc.indexOf("arrow4.gif")) + "layout_button_up.gif";
        }
    }
}

function getObjectValue(container) {
    var objValue = new Object();
    var inputs = container && container != "" ? $(":input", $("#" + container)) : $(":input");
    inputs.each(function () {
        var values = this.id.split("_");
        var fullName = values[values.length - 1];
        var property = startWith(fullName, "filter") ? fullName.substr(6) : fullName.substr(3);

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


//返回选择对象
function chooseConfirm() {
    var item = $(":checked ").first();
    var retValue = new Object();
    retValue.text = item.attr("text");
    retValue.value = item.attr("value");
    retValue.tag = item.attr("tag");
    window.returnValue = retValue;
    window.close();
}

//自动设置页面高度
function autoHeight() {
    try {
        // $("#page").height($(document).height() - $("#divNav").height());
    } catch (e) { }
}

function getCurrentDate() {
    var today = new Date();
    var day = today.getDate();
    var month = today.getMonth() + 1;
    var year = today.getFullYear();
    return date = year + "-" + month + "-" + day;
}

function setCookie(name, value) {
    var Days = 30;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
    document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString() + ";path=/";
    //document.cookie = name + "=" + escape(value);
}

//gridview全选 add by 【hgq】
function addChkAllClick(chkID, gridviewClass) {
    $("#" + chkID).click(function () {
        if ($("#chkAll").is(":checked")) {
            $("." + gridviewClass + " input[type=checkbox]").attr("checked", true);
        }
        else {
            $("." + gridviewClass + " input[type=checkbox]").attr("checked", false);
        }
    });
}

function getUrlPara(paras) {
    var url = location.href;
    var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");
    var paraObj = {}
    for (i = 0; j = paraString[i]; i++) {
        paraObj[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=") + 1, j.length);
    }
    var returnValue = paraObj[paras.toLowerCase()];
    if (typeof (returnValue) == "undefined") {
        return "";
    } else {
        return returnValue;
    }
}