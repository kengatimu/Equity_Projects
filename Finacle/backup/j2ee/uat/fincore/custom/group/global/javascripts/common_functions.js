var ns4 = document.layers ? 1 : 0;
var ie4 = document.all ? 1 : 0;
var ns6 = document.getElementById && !document.all ? 1 : 0;
var browser_name = navigator.appName;
var gfkmCookie = null;
var MAX_AMOUNT = "9999999999999999";
var MAX_UNIT = "999999999999999";
var EQTYPRICE_PREC = 6;
var FETCH_ERR = "FETCH_ERR=";
var FETCH_ERR_LEN = 10;
var BJS_MODE = "BJS";
var DEF_DECIMAL_SEPARATOR = ".";
var DEF_MANTISSA_SEPARATOR = ",";
var ACCOUNT_EXPLODE = "AccountExplode";
var JSP_PARAMS_AVAILABLE = ".jsp?";
var SEARCHER_INDEX = 100;
var TOGGLE_CALENDAR_BASE = null;
var TOGGLE_TIME_ZONE = null;
var switchCalArr = new Array();
var valSwitch = false;
var aFlag = "Y";
var formAlreadySubmitted = false;
var saveFinacleLiteMode = false;
var MAX_NO_OF_KEY_FIELDS = 9;
var callBackFn = "";
var opFieldsArr = new Array();
var genericCallBackFn = "";
var callBackSearchInd = "";
var isConfirmDialogOpen = "";
var submitAction_CD = "";
var callBackFn_CD = "";
var callBackFn_SDS = "";
var genericCallBackFn_SDS = "";
var dateObj_tmp = "";
var wReturnDescGeneric = "";
var acctFieldGeneric = "";
var custNameGeneric;
var cifFieldGeneric;
var callBackFn_locale = "";
var svsdata = "";
var finConst = {
    ONS_ROOT_MENU: "ONSMNU",
    CRV_ROOT_MENU: "HCRVMU",
    FAB_ROOT_MENU: "FABMNU",
    FAV_ROOT_MENU: "FAVMNU",
    HOME_MENU: "HOME",
    CRV_HOME_MENU: "HOME",
    ONS_PREC: "O",
    FAB_PREC: "F",
    BOTH_PREC: "B",
    CRV_PREC: "C",
    URL_MENU: "U",
    MOD_MENU: "M",
    FINBRANCH: "finbranch",
    DELAYED_TIME: 1000,
    WEB: "WEB",
    ONS: "ONS",
    PUREONS: "PUREONS",
    DISPLAYPARENT: "DISPLAYPARENT",
    DOLOGOUT: "DOLOGOUT",
    CONTEXTSWITCH: "CONTEXTSWITCH",
    WFCRMCONTEXTSWITCH: "WFCRMCONTEXTSWITCH",
    APPLETFRAME: "finappl",
    FINFRAME: "FINW",
    DEVICEFRAME: "DEVICEFRAME",
    COREAPPLET: "coreapplet",
    SHOWAUTH: "SHOWAUTH",
    DORMANCY: "Dormancy",
    FINDTRANHISTORY: "findTransHistory",
    FORCED_LOGOUT: "F",
    NORMAL_LOGOUT: "N",
    ACTION_CANCEL: "cancel",
    LML_LOGIN_EVT: "lml_login",
    LML_LOGOUT_EVT: "lml_logout",
    LML_DCLOGOUT_EVT: "lml_dclogout",
    LML_FABLOGOUT_EVT: "lml_fablogout",
    FIN_SESS_ID: "finsessionid",
    FAB_SESS_ID: "fabsessionid",
    ACTION_CODE: "actionCode",
    FAB_SEC_TOKEN: "fabSecTok",
    FIN_SEC_TOKEN: "finSecTok",
    TOGGLE_CALENDAR: "lml_toggle",
    YES: "Y",
    NO: "N"
}
var svsrule = "";
var modalWin = null;
var std_escape = escape;
escape = function(a) {
    return encodeURIComponent(a)
};

function resetSDS() {
    if (typeof multiSDS != "undefined") {
        multiSDS = "N"
    }
    genericCallBackFn_SDS = "";
    callBackFn_SDS = ""
}

function CommonCallBack_SDS(action) {
    var localSDS = "N";
    if (typeof multiSDS != "undefined") {
        localSDS = multiSDS
    }
    if (genericCallBackFn_SDS) {
        eval(genericCallBackFn_SDS + "('" + action + "')");
        if (localSDS == "N") {
            genericCallBackFn_SDS = ""
        }
        callBackFn_locale = ""
    }
    if (callBackFn_SDS) {
        eval(callBackFn_SDS + "('" + action + "')");
        if (localSDS == "N") {
            callBackFn_SDS = ""
        }
        callBackFn_locale = ""
    }
    if (callBackFn_locale) {
        eval(callBackFn_locale + "('" + action + "')");
        if (localSDS == "N") {}
    }
}

function CommonCallBack(rValue) {
    if (rValue != null && typeof(rValue) == "string" && rValue == "TIMEOUT") {
        var logoutParams = new Array(1);
        logoutParams[0] = finConst.FORCED_LOGOUT;
        handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
        return
    }
    if (rValue != null && rValue != undefined) {
        if (genericCallBackFn) {
            eval(genericCallBackFn + "('" + rValue + "')");
            genericCallBackFn = ""
        } else {
            var liarrBufArray = rValue.split("|");
            var length = opFieldsArr.length;
            for (var i = 0; i < length; i++) {
                if (opFieldsArr[i] != null) {
                    opFieldsArr[i].value = liarrBufArray[i]
                }
            }
        }
        if (callBackFn) {
            eval(callBackFn + "('" + rValue + "')");
            callBackFn = ""
        }
    }
    opFieldsArr = [];
    callBackFn = "";
    genericCallBackFn = ""
}

function CommonCallBack_CD() {
    isConfirmDialogOpen = "N";
    if (callBackFn_CD) {
        eval(callBackFn_CD + "()")
    } else {
        if (submitAction_CD) {
            doSubmit(submitAction_CD)
        }
    }
    callBackFn_CD = "";
    submitAction_CD = ""
}

function CommonCallBack_icfg(rValue) {
    if (rValue != null && typeof(rValue) == "string" && rValue == "TIMEOUT") {
        var logoutParams = new Array(1);
        logoutParams[0] = finConst.FORCED_LOGOUT;
        handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
        return
    }
    if (callBackSearchInd != "") {
        popModalWindowRES(rValue)
    }
    if (callBackFn) {
        eval(callBackFn + "()");
        callBackFn = ""
    }
}

function isSSOLogin() {
    if (!isPopupWin) {
        if ((isProdEnv == "Y") && (window.parent == undefined || window.parent.login == undefined)) {
            return true
        }
    }
}

function fnTrim(a_strString) {
    if (null == a_strString || undefined == a_strString)
        return '';

    var cnt;
    var len = a_strString.length;
    var str = a_strString;
    begin = -1;
    for (cnt = 0; cnt < len; cnt++) {
        if (str.charAt(cnt) == " ") {
            begin = cnt;
        } else
            break;
    }
    str = str.slice(begin + 1, len);
    len = str.length;
    end = len;
    for (cnt = len - 1; cnt >= 0; cnt--) {
        if (str.charAt(cnt) == " ") {
            end = cnt;
        } else
            break;
    }
    str = str.slice(0, end);
    return str;
}

// Checks if the input string is null or blanks
function fnIsNull(a_strString) {
    if (a_strString == null) {
        return true;
    }

    a_strString = fnTrim(a_strString + '');

    if (a_strString == "") {
        return true;
    }

    return false;
}

function fnIsValidDate(f) {
    var x = f.getAttribute("mnebl");
    var d = null;
    var a;
    var r = 1900;
    var l = f.getAttribute("fdt");
    var b = calbase;
    var w = null;
    var e = null;
    var t = null;
    var s = null;
    var c = null;
    var o = null;
    var m = null;
    var h = null;
    var p = false;
    if (f.value == "invalid") {
        return false
    }
    if (l == "fdate") {
        b = "00"
    }
    v = f.value;
    w = f.value;
    if (v == "") {
        return true
    }
    if ((null != x) && (x)) {
        d = f.getAttribute("mneblMode");
        if ((null != d) && (BJS_MODE == d)) {
            if (isValidBjsDateMneumonic(v)) {
                return true
            }
        } else {
            if (isValidDateMneumonic(v)) {
                return true
            }
        }
    }
    if (v.indexOf("/") != -1) {
        var v = v.split("/")
    } else {
        if (v.indexOf("-") != -1) {
            var v = v.split("-")
        } else {
            if (v.indexOf(".") != -1) {
                var v = v.split(".")
            } else {
                return false
            }
        }
    }
    if (calbase == "01" && !isHijDate(w)) {
        if (isGregDate(w)) {
            e = convertGregToHij(w)
        }
        if (e == w) {
            return false
        }
        e = e.split("-");
        t = e[0];
        s = e[1];
        c = e[2];
        if (t.length == 1) {
            t = "0" + t
        }
        if (s.length == 1) {
            s = "0" + s
        }
    } else {
        t = v[0];
        s = v[1];
        c = v[2]
    }
    if (dateFormat == "01") {
        var g = String(f.id);
        var q = g.substring((g.length - 3), g.length);
        var u = null;
        if (q == "_ui") {
            p = true;
            u = v[0];
            v[0] = v[1];
            v[1] = u
        }
    }
    o = v[0];
    m = v[1];
    h = v[2];
    if (o.length == 1) {
        o = "0" + o
    }
    if (m.length == 1) {
        m = "0" + m
    }
    a = f.getAttribute("fdob");
    if (b == "00") {
        if (a != null && a == "Y") {
            r = 1850
        }
        if ((isNaN(h)) || (isNaN(m)) || (isNaN(o)) || o.length <= 1) {
            return false
        } else {
            if ((h < r) || (h > 2099) || (m > 12) || (m < 1) || (o < 1) || (o > 31) || (((m == 4) || (m == 6) || (m == 9) || (m == 11)) && (o > 30))) {
                return false
            } else {
                if ((h % 4 == 0) && ((h % 100 != 0) || (h % 400 == 0))) {
                    if ((m == 2) && ((o > 29) || (o < 1))) {
                        return false
                    }
                } else {
                    if ((m == 2) && ((o > 28) || (o < 1))) {
                        return false
                    }
                }
            }
        }
    }
    if (b == "01") {
        if ((isNaN(c)) || (isNaN(s)) || (isNaN(t)) || t.length <= 1) {
            return false
        } else {
            if ((c <= lowHijYear) || (c >= highHijYear) || (s > 12) || (s < 1) || (t > 30) || (t < 1)) {
                return false
            }
        }
    }
    if (b == "02") {
        if ((isNaN(h)) || (isNaN(m)) || (isNaN(o)) || o.length <= 1) {
            return false
        } else {
            if ((h < 2400) || (h > 2700) || (m > 12) || (m < 1) || (o < 1) || (o > 31) || (((m == 4) || (m == 6) || (m == 9) || (m == 11)) && (o > 30))) {
                return false
            } else {
                if ((h % 4 == 0) && ((h % 100 != 0) || (h % 400 == 0))) {
                    if ((m == 2) && ((o > 29) || (o < 1))) {
                        return false
                    }
                } else {
                    if ((m == 2) && ((o > 28) || (o < 1))) {
                        return false
                    }
                }
            }
        }
    }
    if (dateFormat == "01" && p == true) {
        f.value = m + "-" + o + "-" + h
    } else {
        f.value = o + "-" + m + "-" + h
    }
    return true
}

function fnCompareDates(o, m) {
    var h;
    var b;
    var f;
    var g;
    var a;
    var e;
    var l = true;
    if (o == "" || m == "") {
        return true
    }
    var d = o.split("-");
    var c = m.split("-");
    h = d[1];
    b = d[0];
    f = d[2];
    g = c[1];
    a = c[0];
    e = c[2];
    if (parseInt(f, 10) > parseInt(e, 10)) {
        return false
    } else {
        if ((parseInt(h, 10) > parseInt(g, 10)) && (parseInt(f, 10) == parseInt(e, 10))) {
            return false
        } else {
            if ((parseInt(b, 10) > parseInt(a, 10)) && (parseInt(f, 10) == parseInt(e, 10)) && (parseInt(h, 10) == parseInt(g, 10))) {
                return false
            }
        }
    }
    return true
}

function fnCompareAmounts(b, a) {
    var b = getAmtInStdFormat(b);
    var a = getAmtInStdFormat(a);
    var d = 0;
    var c = 0;
    d = b.indexOf(DEF_DECIMAL_SEPARATOR);
    c = a.indexOf(DEF_DECIMAL_SEPARATOR);
    if (d < c) {
        b = fnAmtLpad(b, (c - d))
    } else {
        a = fnAmtLpad(a, (d - c))
    }
    if (b > a) {
        return false
    } else {
        return true
    }
}

function fnAmtLpad(b, a) {
    for (i = 1; i <= a; i++) {
        b = "0" + b
    }
    return b
}

function fnIsPositiveNumber(b) {
    var a = getValInStdFormat(b);
    if ((isNaN(a)) || (a.indexOf(" ") != -1) || (a.indexOf(DEF_DECIMAL_SEPARATOR) != -1)) {
        return false
    } else {
        if (a < 0) {
            return false
        } else {
            return true
        }
    }
}

function removeCommas(a) {
    sNew = "";
    var b = a.split(",");
    for (i = 0; i < b.length; i++) {
        if (b[i] != null) {
            sNew = sNew + b[i]
        }
    }
    return sNew
}

function formatToLakh(d) {
    if (fnIsNull(d)) {
        return ""
    }
    if (isNaN(removeCommas(d))) {
        alert(finbranchResArr.get("FAT000029"));
        return 0
    }
    if ((d.indexOf(DEF_DECIMAL_SEPARATOR) != -1) && (d.substring(0, d.indexOf(DEF_DECIMAL_SEPARATOR) - 1).length < 3)) {
        return d
    }
    if (d.indexOf(DEF_DECIMAL_SEPARATOR) != -1) {
        sNum = d.substring(0, d.indexOf(DEF_DECIMAL_SEPARATOR))
    } else {
        sNum = d
    }
    if (sNum.length < 4) {
        return d + ".00"
    }
    sNum = removeCommas(sNum);
    var c = "";
    var a = 0;
    if (sNum.length > 4) {
        for (i = sNum.length - 4; i >= 0; i--) {
            c = c + sNum.charAt(i);
            temp = (c.substring(0, a + 1)).length;
            if ((temp % 2) == 0) {
                c = c + ","
            }
            a += 1
        }
        var b = "";
        for (i = c.length - 1; i >= 0; i--) {
            b = b + c.charAt(i)
        }
        b = b + "," + sNum.substring(sNum.length - 3)
    }
    if (sNum.length == 4) {
        b = sNum.charAt(0) + "," + sNum.substring(1)
    }
    if (d.indexOf(DEF_DECIMAL_SEPARATOR) == -1) {
        b = b + ".00"
    } else {
        b = b + d.substring(d.indexOf(DEF_DECIMAL_SEPARATOR))
    }
    if (b.charAt(0) == DEF_MANTISSA_SEPARATOR) {
        b = b.substring(b.indexOf(DEF_MANTISSA_SEPARATOR) + 1)
    }
    return b
}

function formatToMillion(d) {
    if (fnIsNull(d)) {
        return ""
    }
    if (isNaN(removeCommas(d))) {
        alert(finbranchResArr.get("FAT000029"));
        return 0
    }
    if ((d.indexOf(DEF_DECIMAL_SEPARATOR) != -1) && (d.substring(0, d.indexOf(DEF_DECIMAL_SEPARATOR) - 1).length < 3)) {
        return d
    }
    if (d.indexOf(DEF_DECIMAL_SEPARATOR) != -1) {
        sNum = d.substring(0, d.indexOf(DEF_DECIMAL_SEPARATOR))
    } else {
        sNum = d
    }
    if (sNum.length < 4) {
        return d + ".00"
    }
    sNum = removeCommas(sNum);
    var c = "";
    var a = 0;
    for (i = sNum.length - 1; i >= 0; i--) {
        c = c + sNum.charAt(i);
        temp = (c.substring(0, a + 1)).length;
        if ((temp % 3) == 0) {
            c = c + ","
        }
        a += 1
    }
    var b = "";
    for (i = c.length - 1; i >= 0; i--) {
        b = b + c.charAt(i)
    }
    if (d.indexOf(DEF_DECIMAL_SEPARATOR) == -1) {
        b = b + ".00"
    } else {
        b = b + d.substring(d.indexOf(DEF_DECIMAL_SEPARATOR))
    }
    if (b.charAt(0) == ",") {
        b = b.substring(b.indexOf(DEF_MANTISSA_SEPARATOR) + 1)
    }
    return b
}

function fnFormatDate(h, g) {
    var b = "-";
    var c = h.value;
    var f = "";
    var l = h.getAttribute("mnebl");
    if ((null != l) && (l) && ("$" == c.substring(0, 1))) {
        return
    }
    if ((9 == g.keyCode) || (16 == g.keyCode)) {
        h.focus();
        return
    }
    if ((8 == g.keyCode) || (37 == g.keyCode) || (39 == g.keyCode) || (46 == g.keyCode)) {
        return
    }
    var a = c.split(b);
    if (a.length == 3) {
        if (a[2].length > 0 && a[2].length <= 4 && a[1].length > 0 && a[1].length <= 2 && a[0].length > 0 && a[0].length <= 2) {
            return true
        }
    }
    if (a.length == 2) {
        if (a[1].length != 2 || a[0].length != 2) {
            if (a[1].length > 0 && a[1].length <= 2 && a[0].length > 0 && a[0].length <= 2) {
                return true
            }
        }
    }
    for (i = 0; i < c.length; i++) {
        if (c.charAt(i) != b) {
            f += c.charAt(i)
        }
    }
    var d = f.length;
    var e = f;
    if (d > 8) {
        e = f.substring(0, 2) + b + f.substring(2, 4) + b + f.substring(4, 8)
    } else {
        if (d > 4) {
            e = f.substring(0, 2) + b + f.substring(2, 4) + b + f.substr(4)
        } else {
            if (d == 4) {
                e = f.substring(0, 2) + b + f.substring(2) + b
            } else {
                if (d == 3) {
                    e = f.substring(0, 2) + b + f.substr(2)
                } else {
                    if (d == 2) {
                        e = f.substring(0, 2) + b
                    }
                }
            }
        }
    }
    h.value = e
}

function validFields(a, d, c, b) {
    if (a == "Mandatory") {
        if (fnIsNull(d.value)) {
            alert(c);
            d.focus();
            return false
        }
        if ((!(fnIsPositiveNumber(d.value)) || (d.value == 0)) && (b != "")) {
            alert(b);
            d.focus();
            return false
        }
    }
    return true
}

function onSaveVerify(a) {
    var b = document.forms[0];
    if (!fnLocaleValidateForm(a)) {
        return
    }
    if (validatefields()) {
        convertToCaps();
        b.saveVerify.value = a;
        if (a == "Authorize") {
            return true
        }
        b.Save.disabled = true;
        b.Verify.disabled = true;
        b.Cancel.disabled = true;
        b.Authorize.disabled = true;
        b.submit()
    } else {
        return false
    }
}

function openWindow(c, b, d, f) {
    var e;
    if ((d != "optional") && (d == "")) {
        alert(f);
        return
    }
    c = jsUtil.formatUrl(c);
    if (window.showModalDialog) {
        if ("Microsoft Internet Explorer" == browser_name) {
            e = window.showModalDialog(c, "title", "dialogWidth:40;dialogHeight:25;status=no;toolbar=no;menubar=no;resizable=yes")
        } else {
            c = getAbsoluteUrl(c);
            retval = window.showModalDialog(c, wName, "dialogHeight:400;dialogleft:100;dialogWidth:800;dialogtop:150;status=no;toolbar=no;menubar=no;resizable=yes;location=no")
        }
        if (e != null && typeof(e) == "string" && e == "TIMEOUT") {
            var a = new Array(1);
            a[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, a);
            return
        }
        if (b != "") {
            if (e != null) {
                b.value = e
            }
        }
    } else {
        e = window.open(c, "title", "width=500,height=500,modal=yes,top=40,left=150,scrollbars=yes,toolbar=no,menubar=no");
        if (e != null && typeof(e) == "string" && e == "TIMEOUT") {
            var a = new Array(1);
            a[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, a);
            return
        }
    }
}

function openAuthorizeWindow(a) {
    a = jsUtil.formatUrl(a);
    if (onSaveVerify("Authorize")) {
        convertToCaps();
        var c = window.open(a, USERID + "_Authorize", "Width=300,Height=110, Top=230, Left=270");
        if (c != null && typeof(c) == "string" && c == "TIMEOUT") {
            var b = new Array(1);
            b[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, b);
            return
        }
    } else {
        return false
    }
}

function fnDisableControls1() {
    var a = document.forms[0];
    a.SaveTemplate.disabled = true;
    a.Cancel.disabled = true;
    a.Back.disabled = true
}

function fnDisableControls() {
    var a = document.forms[0];
    a.Verify.disabled = true;
    a.Authorize.disabled = true;
    a.Save.disabled = true;
    a.Cancel.disabled = true
}

function fnDisableParentFormControls() {
    var a = window.opener.document.forms[0];
    if (null != a.Verify && undefined != a.Verify) {
        a.Verify.disabled = true
    }
    if (null != a.Authorize && undefined != a.Authorize) {
        a.Authorize.disabled = true
    }
    if (null != a.Save && undefined != a.Save) {
        a.Save.disabled = true
    }
    if (null != a.Cancel && undefined != a.Cancel) {
        a.Cancel.disabled = true
    }
}

function clearFields() {
    var a = document.forms[0];
    a.accInqFlg.value = "False";
    a.saveVerify.value = "1";
    fnClearFields()
}

//This function is to convert all the letters and words in all textfields to CAPS
function convertToCaps() {
    var obj = document.forms[0];
    var len = obj.length;

    for (i = 0; i < len; i++) {
        if (obj[i].type == "text" || obj[i].type == "hidden" || obj[i].type == "textarea") {
            obj[i].value = fnTrim(obj[i].value);
        }
        if (((obj[i].type == "text") || (obj[i].type == "textarea")) && obj[i].getAttribute("fdt") != 'lcase') {
            var inputCase = obj[i].getAttribute("inputCase");
            if (!fnIsNull(inputCase) && (inputCase != 'U')) {
                continue;
            }
            var txtStr = obj[i].value;
            obj[i].value = txtStr.toUpperCase();
        }
    }
}

function getUserInfo() {
    var b = window.open("../arjspmorph/" + applangcode + "/get_user_info.jsp?rtId=" + rtId, USERID + "_userInfo", "width=330, height=240,top=290,left=390");
    if (b != null && typeof(b) == "string" && b == "TIMEOUT") {
        var a = new Array(1);
        a[0] = finConst.FORCED_LOGOUT;
        handleWindowDisplay(finConst.DOLOGOUT, a);
        return
    }
}

function displaySignatureWindow(b, c) {
    var d = window.open("../arjspmorph/" + applangcode + "/signature.jsp?rtId=" + rtId + "&acctId=" + c, USERID + "_Signature", "width=600,height=520,left=20,top=80,resizable=1,status=0,toolbar=0,scrollbars=1");
    if (d != null && typeof(d) == "string" && d == "TIMEOUT") {
        var a = new Array(1);
        a[0] = finConst.FORCED_LOGOUT;
        handleWindowDisplay(finConst.DOLOGOUT, a);
        return
    }
}

function displaySVSWindow(g, h) {
    var c = "";
    var e = "";
    var l = "";
    var b = "";
    var a = "";
    svsdata = "";
    svsrule = "";
    b = g.split("sAcctId=");
    a = b[1].split("&");
    e = a[0].toUpperCase();
    var f = window.parent;
    if (g.indexOf("sAcctType=") == -1) {
        c = "N"
    } else {
        b = g.split("sAcctType=");
        a = b[1].split("&");
        c = a[0]
    }
    if (!window.showModalDialog) {
        svsdata = g;
        svsrule = h;
        callBackFn_SDS = "displaySVSWindow_callBack"
    }
    l = fetchSVSAddnDetails("dummyFrame", "SVSADDNDTLS", "F", e + "|" + c);
    if (window.showModalDialog) {
        if (l != "null") {
            g = g + l
        }
        var d = new Array(3);
        if (h == undefined) {
            h = "applyRule"
        }
        d[0] = svsServer;
        d[1] = g;
        d[2] = h;
        if (f.isFinacleLite()) {
            if (null == isUserAccesAvbl("IES")) {
                alert(finbranchResArr.get("FAT002367"));
                return
            }
            svsUrl = "../SVSPreLoginCtrl?DATA=" + escape(g) + "&MENUOPTION=" + h + "&CALLTYPE=CONTEXT_SWITCH";
            window.open(svsUrl, "SVS", "width=800,height=375,modal=yes,left=150,top=40,scrollbars=yes,toolbar=no,menubar=0,resize=yes,dialog=yes")
        } else {
            handleWindowDisplay(finConst.CONTEXTSWITCH, d)
        }
    }
}

function fetchSVSAddnDetails(frameName, fetchId, precedence, wReturn) {
    var tmpStr = "";

    tmpStr = wReturn;

    var bUrl = getBaseUrl();
    var sUrl = bUrl + finContextPath + "/arjspmorph/" + applangcode + "/frm_fetch.jsp?rtId=" + rtId + "&fetchId=" + fetchId + "&precedence=" + precedence;
    if (wReturn != '')
        sUrl = sUrl + "&wReturn=" + tmpStr;

    var xMax = screen.width,
        yMax = screen.height;
    var xOffset = (xMax - 120),
        yOffset = (yMax - 150);
    var params = "dialogWidth=0px;dialogHeight=0px;dialogLeft=" + xOffset + "px;dialogTop=" + yOffset + "px";
    params += ";status=no;toolbar=no;menubar=no;resizable=no;help=no;center=no";

    if ("Netscape" == browser_name) {
        var retValue = window.open(sUrl, "title", "width=10px,height=10px,modal=yes,top=" + yOffset + "px,left=" + xOffset + "px,scrollbars=yes,toolbar=no,menubar=no,help=no");
        if (retValue != null && typeof(retValue) == "string" && retValue == "TIMEOUT") {
            var logoutParams = new Array(1);
            logoutParams[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
            return;
        }
    } else {
        var outData = window.showModalDialog(sUrl, document.forms[0], params);
        if (outData != null && typeof(outData) == "string" && outData == "TIMEOUT") {
            var logoutParams = new Array(1);
            logoutParams[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
            return;
        }
        return outData;
    }
    return true;
}

function displaySVSWindow_callBack(a) {
    var b = window.parent;
    if (a != "null") {
        svsdata = svsdata + a
    }
    var c = new Array(3);
    if (svsrule == undefined) {
        svsrule = "applyRule"
    }
    c[0] = svsServer;
    c[1] = svsdata;
    c[2] = svsrule;
    if (b.isFinacleLite()) {
        if (null == isUserAccesAvbl("IES")) {
            alert(finbranchResArr.get("FAT002367"));
            return
        }
        svsUrl = "../SVSPreLoginCtrl?DATA=" + escape(svsdata) + "&MENUOPTION=" + svsrule + "&CALLTYPE=CONTEXT_SWITCH";
        window.open(svsUrl, "SVS", "width=800,height=375,modal=yes,left=150,top=40,scrollbars=yes,toolbar=no,menubar=0,resize=yes,dialog=yes")
    } else {
        handleWindowDisplay(finConst.CONTEXTSWITCH, c)
    }
}

function fetchSVSAddnDetails(h, d, a, q) {
    var p = "";
    p = q;
    var m = getBaseUrl();
    var b = m + finContextPath + "/arjspmorph/" + applangcode + "/frm_fetch.jsp?rtId=" + rtId + "&fetchId=" + d + "&precedence=" + a;
    if (q != "") {
        b = b + "&wReturn=" + p
    }
    var l = screen.width,
        c = screen.height;
    var o = (l - 120),
        e = (c - 150);
    var f = "dialogWidth=0px;dialogHeight=0px;dialogLeft=" + o + "px;dialogTop=" + e + "px";
    f += ";status=no;toolbar=no;menubar=no;resizable=no;help=no;center=no";
    var g = popModalWindowForProcessing(b, document.forms[0], f);
    return g
}

function showAuthorizeWindow(b) {
    var c = window.open("../arjspmorph/" + applangcode + "/authorize_user.jsp?rtId=" + rtId + "&groupName=" + b, USERID + "_UserAuthorization", "width=300, height=110,top=230,left=270");
    if (c != null && typeof(c) == "string" && c == "TIMEOUT") {
        var a = new Array(1);
        a[0] = finConst.FORCED_LOGOUT;
        handleWindowDisplay(finConst.DOLOGOUT, a);
        return
    }
}

function showErrorWindow(b) {
    var c = window.open("../arjspmorph/" + applangcode + "/error.jsp?groupName=" + b, USERID + "_ErrorDetails", "width=800,height=400,modal=yes,left=120,top=150,scrollbars=yes,toolbar=no,menubar=0");
    if (c != null && typeof(c) == "string" && c == "TIMEOUT") {
        var a = new Array(1);
        a[0] = finConst.FORCED_LOGOUT;
        handleWindowDisplay(finConst.DOLOGOUT, a);
        return
    }
}

function openAdditionalDetailsWindow(d, a, c, f) {
    if (!fnIsNull(a.value)) {
        if (c == "selected") {
            var e = window.open("../arjspmorph/" + applangcode + "/minor_sub_details.jsp?rtId=" + rtId + "&sCreditOrDebit=null&Amount=" + f, USERID + "_AdditionalDetails", "width=600, height=400,top=20,left=80");
            if (e != null && typeof(e) == "string" && e == "TIMEOUT") {
                var b = new Array(1);
                b[0] = finConst.FORCED_LOGOUT;
                handleWindowDisplay(finConst.DOLOGOUT, b);
                return
            }
        } else {
            if (c == "tobeselected") {
                var e = window.open("../arjspmorph/" + applangcode + "/additional_details_selection.jsp?rtId=" + rtId + "&Amount=" + f + "&AcctId=" + d + "&TranAmount=" + a.value, USERID + "_AdditionalDetails", "width=600, height=400,scrollbars=1,top=20,left=80");
                if (e != null && typeof(e) == "string" && e == "TIMEOUT") {
                    var b = new Array(1);
                    b[0] = finConst.FORCED_LOGOUT;
                    handleWindowDisplay(finConst.DOLOGOUT, b);
                    return
                }
            }
        }
    } else {
        alert(finbranchResArr.get("FAT000104"));
        a.focus()
    }
}

function popModalWindowVarRef(c, a, d, l, h, e) {
    if (SSO) {
        var g = new Array();
        var f = window.parent.parent.getSessionID();
        g.ssoParentWindow = this;
        g.ssoSessionId = f;
        var b = popModalWindowVar(c, g, d, l, h, e);
        return (b)
    } else {
        var g = new Array();
        g.parentWindow = self;
        g.title = a;
        var b = popModalWindowVar(c, g, d, l, h, e);
        return (b)
    }
}
var jsUtil = (function() {
    var b = {
        NO_ACTION: "0",
        DEFAULT: "1",
        ACTION_CODE: "2",
        SUBMIT_FORM: "3",
        TEXT_ACTION: "4",
        END_TRAN: "5"
    };

    function a(c) {
        enableFormElements();
        convertToCaps();
        hideAnchors();
        disableButtons();
        c.submit()
    }
    return {
        cancelEvent: function(c) {
            if (!c) {
                return
            }
            if (c.preventDefault) {
                c.preventDefault()
            } else {
                c.cancelBubble = true;
                c.returnValue = false
            }
        },
        getType: function() {
            return b
        },
        submit: function(l, e, d) {
            var c = e;
            var f = b;
            var g = document.forms[0];
            if (c != f.NO_ACTION) {
                if (!fnLocaleValidateForm(l)) {
                    return
                }
            }
            if (fnIsNullOrUndefined(e)) {
                c = b.DEFAULT
            }
            switch (c) {
                case f.NO_ACTION:
                    break;
                case f.DEFAULT:
                    g.actionCode.value = l;
                    if (g.submitform != undefined) {
                        g.submitform.value = l
                    }
                    break;
                case f.ACTION_CODE:
                    g.actionCode.value = l;
                    break;
                case f.SUBMIT_FORM:
                    g.submitform.value = l;
                    break;
                case f.TEXT_ACTION:
                    g.txtaction.value = l;
                    break;
                case f.END_TRAN:
                    var h = null;
                    if (!fnIsNull(d)) {
                        h = "../" + d + "/" + d + "_ctrl.jsp"
                    } else {
                        h = document.forms[0].action;
                        if (fnIsNull(h)) {
                            h = "../" + CURR_GROUP_NAME + "/" + CURR_GROUP_NAME + "_ctrl.jsp"
                        }
                    }
                    if (g.submitform != undefined) {
                        document.location.href = h + "?rtId=" + rtId + "&actionCode=" + l + "&submitform=" + l
                    } else {
                        document.location.href = h + "?rtId=" + rtId + "&actionCode=" + l
                    }
                    return true;
                default:
                    alert("Invalid Submit Field Type Passed.");
                    return false
            }
            a(g);
            return true
        },
        replaceLocation: function(c) {
            document.location.href = jsUtil.formatUrl(c);
            return true
        },
        formatUrl: function(f) {
            var g = f;
            var c = f;
            var e, d;
            e = g.indexOf(".jsp?");
            if (e != -1) {
                if (typeof(reqId) == "undefined") {
                    c = f + "&rtId=" + rtId
                } else {
                    c = f + "&rtId=" + rtId + "&reqId=" + reqId
                }
                g = c
            } else {
                if (typeof(reqId) == "undefined") {
                    c = f + "?rtId=" + rtId
                } else {
                    c = f + "?rtId=" + rtId + "&reqId=" + reqId
                }
                g = c
            }
            d = g.indexOf(".jsp%3F");
            if (d != -1) {
                c = g.substring(0, (d + 7)) + "rtId=" + rtId + "%26" + g.substring(d + 7)
            }
            return c
        },
        encodeChar: function(g) {
            if (g == null || !isNaN(g)) {
                return g
            }
            if (fnTrim(g) == "") {
                return g
            }
            var d = "";
            for (var e = 0; e < g.length; e++) {
                var f = g.charAt(e);
                if (f == "&") {
                    var c = g.substring(e);
                    if (c.indexOf("&nbsp;") == 0) {
                        d = d + "&nbsp;";
                        e = e + 5;
                        continue
                    } else {
                        if (c.indexOf("&amp;nbsp;") == 0) {
                            d = d + "&nbsp;";
                            e = e + 9;
                            continue
                        }
                    }
                }
                if ((f >= "[" && f <= "`") || (f >= ";" && f <= "@") || (f >= "!" && f <= "/")) {
                    f = "&#" + f.charCodeAt() + ";"
                }
                d += f
            }
            return d
        },
        htmlEncode: function(c) {
            document.write(jsUtil.encodeChar(c))
        },
        noEncode: function(c) {
            return c
        }
    }
})();
var WinUtil = (function() {
    var f = [{
            type: "0",
            width: "0px",
            height: "0px"
        },
        {
            type: "1",
            width: "860px",
            height: "600px"
        },
        {
            type: "2",
            width: "860px",
            height: "400px"
        },
        {
            type: "3",
            width: "575px",
            height: "600px"
        },
        {
            type: "4",
            width: "575px",
            height: "400px"
        },
        {
            type: "5",
            width: "250px",
            height: "250px"
        }
    ];
    var d;
    var e;

    function b(h, g, m) {
        if (fnIsNull(h) || (typeof(g) == "string" && fnIsNull(g)) || fnIsNull(m)) {
            alert("Invalid Window Arguments.");
            return false
        }
        if (m == undefined || m.type == undefined || m.height == undefined || m.width == undefined) {
            alert("Invalid Window Arguments.");
            return false
        }
        var p = false;
        for (var l = 0; l < f.length; l++) {
            var o = f[l];
            if ((o.type == m.type) && (o.width == m.width) && (o.height == m.height)) {
                p = true;
                break
            }
        }
        if (!p) {
            alert("Window Sizes not Standard.");
            return false
        }
        return true
    }

    function a(h) {
        var l = null;
        for (var g = 0; g < f.length; g++) {
            l = f[g];
            if (l.type == h) {
                break
            }
        }
        return l
    }

    function c(l, h) {
        if (l.type == 0) {
            var o = (screen.width - 120) + "px";
            var p = (screen.height - 150) + "px";
            if (window.showModalDialog && h == "windialog") {
                e = "dialogWidth:" + l.width + ";dialogHeight:" + l.height + ";dialogLeft:" + o + ";dialogTop:" + p + ";status=no;toolbar=no;menubar=no;resizable=no;help=no;center=no"
            } else {
                e = "width=10px,height=10px,modal=yes,left=" + o + ",top=" + p + ",scrollbars=yes,toolbar=no,menubar=no,help=no"
            }
        } else {
            var m = (l.width).split("px");
            var g = (l.height).split("px");
            var o = ((screen.width - m[0]) / 2) + "px";
            var p = ((screen.height - g[0]) / 2) + "px";
            if (window.showModalDialog && h == "windialog") {
                e = "dialogWidth:" + l.width + ";dialogHeight:" + l.height + ";dialogLeft:" + o + ";dialogTop:" + p + ";status=no;toolbar=no;menubar=no;resizable=yes"
            } else {
                e = "width=" + l.width + ",height=" + l.height + ",modal=yes,left=" + o + ",top=" + p + ",scrollbars=yes,toolbar=no,menubar=0,resizable=yes,dialog=yes"
            }
        }
    }
    return {
        openModalWindow: function(l, h, m) {
            if (!b(l, h, m)) {
                return
            }
            c(m, "windialog");
            l = jsUtil.formatUrl(l);
            if (window.showModalDialog) {
                d = window.showModalDialog(l, h, e)
            } else {
                d = window.open(l, h, e);
                modalWin = d
            }
            if (d != null && typeof(d) == "string" && d == "TIMEOUT") {
                var g = new Array(1);
                g[0] = finConst.FORCED_LOGOUT;
                handleWindowDisplay(finConst.DOLOGOUT, g)
            }
            return d
        },
        openWindow: function(l, h, m) {
            if (!b(l, h, m)) {
                return
            }
            c(m, "winopen");
            l = jsUtil.formatUrl(l);
            if (window.open) {
                d = window.open(l, h, e);
                modalWin = d
            }
            if (d != null && typeof(d) == "string" && d == "TIMEOUT") {
                var g = new Array(1);
                g[0] = finConst.FORCED_LOGOUT;
                handleWindowDisplay(finConst.DOLOGOUT, g)
            }
            return d
        },
        isModal: function() {
            return (window.showModalDialog)
        },
        type0: function() {
            return a(0)
        },
        type1: function() {
            return a(1)
        },
        type2: function() {
            return a(2)
        },
        type3: function() {
            return a(3)
        },
        type4: function() {
            return a(4)
        },
        type5: function() {
            return a(5)
        }
    }
})();

function popModalWindowVarRef(sUrl, wName, pWidth, pHeight, dWidth, dHeight) {
    if (SSO) {
        var argArr = new Array();
        var sessionId = window.parent.parent.getSessionID();
        argArr['ssoParentWindow'] = this;
        argArr["ssoSessionId"] = sessionId;
        var retval = popModalWindowVar(sUrl, argArr, pWidth, pHeight, dWidth, dHeight);
        return (retval);
    } else {
        var argArr = new Array();
        argArr["parentWindow"] = self;
        argArr["title"] = wName;
        var retval = popModalWindowVar(sUrl, argArr, pWidth, pHeight, dWidth, dHeight);
        return (retval);
    }
}

function popModalWindowVar(sUrl, wName, pWidth, pHeight, dWidth, dHeight) {
    var retval;
    sUrl = jsUtil.formatUrl(sUrl);
    if ("Microsoft Internet Explorer" == browser_name) {
        retval = window.showModalDialog(sUrl, wName, "dialogWidth:" + dWidth + ";dialogHeight:" + dHeight + ";status=no;toolbar=no;menubar=no;resizable=yes");
        if (retval != null && typeof(retval) == "string" && retval == "TIMEOUT") {
            var logoutParams = new Array(1);
            logoutParams[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
            return;
        }
    } else {
        retval = window.open(sUrl, wName, "width=" + pWidth + ",height=" + pHeight + ",modal=yes,top=400,left=350,scrollbars=yes,toolbar=no,menubar=0,resizable=yes,dialog=yes");
        if (retval != null && typeof(retval) == "string" && retval == "TIMEOUT") {
            var logoutParams = new Array(1);
            logoutParams[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
            return;
        }
        modalWin = retval;
    }
    return (retval);
}

var jsUtil = (function() {

    return {
        formatUrl: function(sUrl) {
            var sTemp = sUrl;
            var sFinal = sUrl;
            var id1, id2;

            id1 = sTemp.indexOf(".jsp?");
            if (id1 != -1) {
                sFinal = sUrl + "&rtId=" + rtId;
                sTemp = sFinal;
            } else {
                sFinal = sUrl + "?rtId=" + rtId; /* When Url has no query String */
                sTemp = sFinal;
            }

            /* In DynUrl the char '?' is escaped and taken as '%3F'. %26 is char '&' */

            id2 = sTemp.indexOf(".jsp%3F");
            if (id2 != -1) {
                sFinal = sTemp.substring(0, (id2 + 7)) + "rtId=" + rtId + "%26" + sTemp.substring(id2 + 7);
            }

	sFinal = sFinal + "&reqId=" + reqId;

            return sFinal
        },
        encodeChar: function(str) {
            if (str == null || !isNaN(str))
                return str;

            if (fnTrim(str) == "")
                return str;

            var newStr = "";
            for (var i = 0; i < str.length; i++) {
                var uniChar = str.charAt(i);

                if (uniChar == "&") {
                    var tmpStr = str.substring(i + 1, i + 6);
                    if (tmpStr == "nbsp;") {
                        newStr = newStr + "&nbsp;";
                        i = i + 5;
                        continue;
                    }
                }
                if ((uniChar >= "[" && uniChar <= "`") ||
                    (uniChar >= ";" && uniChar <= "@") ||
                    (uniChar >= "!" && uniChar <= "/")) {
                    uniChar = "&#" + uniChar.charCodeAt() + ";";
                }
                newStr += uniChar;
            }
            return newStr;
        },
        htmlEncode: function(str) {
            document.write(jsUtil.encodeChar(str));
        },
        noEncode: function(str) {
            return str;
        }
    }
})();

function popCalendarModalWindowVar(f, h, a, g, c, e) {
    var b;
    f = jsUtil.formatUrl(f);
    if (window.showModalDialog) {
        if ("Microsoft Internet Explorer" == browser_name) {
            b = window.showModalDialog(f, h, "dialogWidth:" + c + ";dialogHeight:" + e + ";status=no;toolbar=no;menubar=no;resizable=yes; scroll=no")
        } else {
            f = getAbsoluteUrl(f);
            b = window.showModalDialog(f, h, "dialogHeight:165;dialogleft:400;dialogWidth:235;dialogtop:250;status=no;toolbar=no;menubar=no;resizable=yes;")
        }
        if (b != null && typeof(b) == "string" && b == "TIMEOUT") {
            var d = new Array(1);
            d[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, d);
            return
        }
    } else {
        b = window.open(f, h, "width=" + a + ",height=" + g + ",modal=yes,top=400,left=350,scrollbars=yes,toolbar=no,menubar=0,dialog=yes");
        if (b != null && typeof(b) == "string" && b == "TIMEOUT") {
            var d = new Array(1);
            d[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, d);
            return
        }
        modalWin = b
    }
    return (b)
}

function getAbsoluteUrl(b) {
    var a = document.location.href;
    a = a.substring(0, a.lastIndexOf("/") + 1);
    if ((b.indexOf("http://") == -1) && (b.indexOf("https://") == -1)) {
        b = a + b
    }
    return b
}

function popModalWindowForProcessing(a, l, f) {
    var g = screen.width,
        c = screen.height;
    var m = (g - 120),
        e = (c - 150);
    var h = "";
    if (f == null || f == undefined) {
        h = "dialogWidth=0px;dialogHeight=0px;dialogLeft=" + m + "px;dialogTop=" + e + "px";
        h += ";status=no;toolbar=no;menubar=no;resizable=yes;help=no;center=no"
    } else {
        h = f
    }
    var b = "";
    if ("Microsoft Internet Explorer" == browser_name) {
        b = window.showModalDialog(jsUtil.formatUrl(a), l, h)
    } else {
        a = getAbsoluteUrl(a);
        if (window.showModalDialog) {
            b = window.showModalDialog(jsUtil.formatUrl(a), l, "dialogHeight:100px;dialogleft:843px;dialogWidth:175px;dialogtop:588px;status=no;toolbar=no;menubar=no;resizable=yes;")
        } else {
            b = window.open(jsUtil.formatUrl(a), l, "width=10px,height=10px,modal=yes,top=" + e + "px,left=" + m + "px,scrollbars=yes,toolbar=no,menubar=no,help=no")
        }
        if (b != null && typeof(b) == "string" && b == "TIMEOUT") {
            var d = new Array(1);
            d[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, d);
            return
        }
    }
    return (b)
}

function popModalWindow(sUrl, wName) {

    var retval;
    sUrl = jsUtil.formatUrl(sUrl);
    if ("Microsoft Internet Explorer" == browser_name) {
        retval = window.showModalDialog(sUrl, wName, "dialogWidth:54;dialogHeight:27.25;status=no;toolbar=no;menubar=no;resizable=yes");
        //retval = window.showModalDialog(sUrl, "title", "dialogWidth:54;dialogHeight:27.25;status=no;toolbar=no;menubar=no;resizable=yes");

        if (retval != null && typeof(retval) == "string" && retval == "TIMEOUT") {
            var logoutParams = new Array(1);
            logoutParams[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
            return;
        }
    } else {
        retval = window.open(sUrl, wName, "width=800,height=375,modal=yes,left=150,top=40,scrollbars=yes,toolbar=no,menubar=0,resizable=yes,dialog=yes");
        if (retval != null && typeof(retval) == "string" && retval == "TIMEOUT") {
            var logoutParams = new Array(1);
            logoutParams[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
            return;
        }
        modalWin = retval;
    }
    return (retval);
}

function openModalWindow(c, d) {
    var a;
    c = jsUtil.formatUrl(c);
    if (window.showModalDialog) {
        if ("Microsoft Internet Explorer" == browser_name) {
            a = window.showModalDialog(c, "", "dialogWidth:54;dialogHeight:27.25;status=no;toolbar=no;menubar=no;resizable=yes")
        } else {
            c = getAbsoluteUrl(c);
            a = window.showModalDialog(c, "", "dialogHeight:400;dialogleft:100;dialogWidth:800;dialogtop:150;status=no;toolbar=no;menubar=no;resizable=yes;location=no")
        }
        if (a != null && typeof(a) == "string" && a == "TIMEOUT") {
            var b = new Array(1);
            b[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, b);
            return
        }
        if (null != a) {
            d.value = a
        }
        return (a)
    } else {
        a = window.open(c, "", "width=850,height=375,modal=yes,top=40,left=150,scrollbars=yes,toolbar=no,menubar=no,resizable=yes");
        if (a != null && typeof(a) == "string" && a == "TIMEOUT") {
            var b = new Array(1);
            b[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, b);
            return
        }
    }
}

function openLienListWindow(b) {
    if (b == "") {
        alert(finbranchResArr.get("FAT000519"))
    } else {
        var c = window.open("../arjspmorph/" + applangcode + "/lien_list.jsp?rtId=" + rtId + "&AcctId=" + b, USERID + "_LienList", "width=700, height=400,top=20,left=80,scrollbars=1");
        if (c != null && typeof(c) == "string" && c == "TIMEOUT") {
            var a = new Array(1);
            a[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, a);
            return
        }
    }
}

function checkFieldMandatory(a, b) {
    if (fnIsNull(a)) {
        alert(b);
        return true
    }
}

function openMemoPadEntryWindow(a) {
    var c;
    if (window.showModalDialog) {
        if ("Microsoft Internet Explorer" == browser_name) {
            c = window.showModalDialog("../arjspmorph/" + applangcode + "/memo_pad_inquiry.jsp?rtId=" + rtId + "&AcctId=" + a, "MemoPadInquiry", "dialogWidth:40;dialogHeight:25;status=no;toolbar=no;menubar=no;resizable=yes")
        } else {
            c = window.showModalDialog("../arjspmorph/" + applangcode + "/memo_pad_inquiry.jsp?rtId=" + rtId + "&AcctId=" + a, "MemoPadInquiry", "dialogWidth:40;dialogHeight:400;dialogleft:100;dialogWidth:800;dialogtop:150;status=no;toolbar=no;menubar=no;resizable=yes;location=no")
        }
        if (c != null && typeof(c) == "string" && c == "TIMEOUT") {
            var b = new Array(1);
            b[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, b);
            return
        }
    } else {
        c = window.open("../arjspmorph/" + applangcode + "/memo_pad_inquiry.jsp?rtId=" + rtId + "&AcctId=" + a, "MemoPadInquiry", "MemoPadInquiry", "width=500,height=500,modal=yes");
        if (c != null && typeof(c) == "string" && c == "TIMEOUT") {
            var b = new Array(1);
            b[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, b);
            return
        }
    }
}

function CheckLinkStatus(a) {
    if (a.value == "True") {
        return true
    } else {
        alert(finbranchResArr.get("FAT000054"));
        return false
    }
}

function formatToLakh1(e, d) {
    var b;
    var a;
    d = parseInt(d, 10) + 1;
    var c = d - 1;
    if (fnIsNull(e)) {
        return ""
    }
    if (isNaN(removeCommas(e))) {
        alert(finbranchResArr.get("FAT000029"));
        return 0
    }
    if (e.indexOf(DEF_DECIMAL_SEPARATOR) != -1) {
        b = e.substring(0, e.indexOf(DEF_DECIMAL_SEPARATOR));
        a = e.substring(e.indexOf(DEF_DECIMAL_SEPARATOR) + 1);
        b = removeCommas(b);
        a = removeCommas(a);
        if (a.length < c) {
            var h = c - a.length;
            for (i = 0; i < h; i++) {
                a += "0"
            }
        } else {
            if (a.length > c) {
                a = a.substring(0, d);
                var m = a.charAt(c);
                if (m >= 5) {
                    if (a.charAt(0) == "0") {
                        a = parseInt(a.substring(0, c), 10) + 1;
                        if (a != 10) {
                            a = "0" + a
                        }
                    } else {
                        befOrdinate = a;
                        a = parseInt(a.substring(0, c), 10) + 1;
                        strOrdi = a + "";
                        if (strOrdi.length > (befOrdinate.length - 1)) {
                            imantissa = parseInt(b, 10) + 1;
                            b = imantissa + "";
                            a = strOrdi.substring(1)
                        }
                    }
                } else {
                    a = a.substring(0, c)
                }
            }
        }
    } else {
        b = e;
        a = "";
        var h = c;
        for (i = 0; i < h; i++) {
            a += "0"
        }
    }
    var l = Number(b) < 0 ? true : false;
    var f = "";
    if (l) {
        b = b.substring(1);
        f = "-"
    }
    if (b.length <= 3) {
        if (d == 1) {
            return f + "" + b
        }
        return f + "" + b + "." + a
    }
    if (b.length > 3) {
        var g = "";
        var o = "";
        for (i = b.length - 1; i >= 0; i--) {
            g += b.charAt(i)
        }
        for (j = 0; j < g.length; j++) {
            o += g.charAt(j);
            if ((j != 0) && (j % 2) == 0) {
                o += ","
            }
        }
        b = "";
        for (k = o.length - 1; k >= 0; k--) {
            b += o.charAt(k)
        }
        if (b.charAt(0) == ",") {
            b = b.substring(1)
        }
    }
    if (d == 1) {
        return f + "" + b
    }
    return f + "" + b + "." + a
}

function formatToMillion1(e, d) {
    var b = "";
    var a = "";
    d = parseInt(d, 10) + 1;
    var c = d - 1;
    if (fnIsNull(e)) {
        return ""
    }
    if (isNaN(removeCommas(e))) {
        alert(finbranchResArr.get("FAT000029"));
        return 0
    }
    if (e.indexOf(DEF_DECIMAL_SEPARATOR) != -1) {
        b = e.substring(0, e.indexOf(DEF_DECIMAL_SEPARATOR));
        a = e.substring(e.indexOf(DEF_DECIMAL_SEPARATOR) + 1);
        b = removeCommas(b);
        a = removeCommas(a);
        if (a.length < c) {
            var h = c - a.length;
            for (i = 0; i < h; i++) {
                a += "0"
            }
        }
        if (a.length > c) {
            a = a.substring(0, d);
            var m = a.charAt(c);
            if (m >= 5) {
                if (a.charAt(0) == "0") {
                    a = parseInt(a.substring(0, c), 10) + 1;
                    if (a != 10) {
                        a = "0" + a
                    }
                } else {
                    befOrdinate = a;
                    a = parseInt(a.substring(0, c), 10) + 1;
                    strOrdi = a + "";
                    if (strOrdi.length > (befOrdinate.length - 1)) {
                        imantissa = parseInt(b, 10) + 1;
                        b = imantissa + "";
                        a = strOrdi.substring(1)
                    }
                }
            } else {
                a = a.substring(0, c)
            }
        }
    } else {
        b = e;
        a = "";
        var h = c;
        for (i = 0; i < h; i++) {
            a += "0"
        }
    }
    var l = Number(b) < 0 ? true : false;
    var f = "";
    if (l) {
        b = b.substring(1);
        f = "-"
    }
    if (b.length <= 3) {
        if (d == 1) {
            return f + "" + b
        }
        return f + "" + b + "." + a
    }
    if (b.length > 3) {
        var g = "";
        var o = "";
        for (i = b.length - 1; i >= 0; i--) {
            g += b.charAt(i)
        }
        for (j = 1; j <= g.length; j++) {
            o += g.charAt(j - 1);
            if ((j != 0) && (j % 3) == 0) {
                o += ","
            }
        }
        b = "";
        for (k = o.length - 1; k >= 0; k--) {
            b += o.charAt(k)
        }
        if (b.charAt(0) == ",") {
            b = b.substring(1)
        }
    }
    if (d == 1) {
        return f + "" + b
    }
    return f + "" + b + "." + a
}

function formatAmountToMillionOrLakh(d, c, b, e, a) {
    low_formatAmt(d, c, null, b, e, a)
}

function fnChangePage(a) {
    var b = document.forms[0];
    if (!fnLocaleValidateForm(a)) {
        return
    }
    b.submitform.value = a;
    b.submit()
}

function getAmountCodeValue(b) {
    var a = {
        T: 1000,
        L: 100000,
        M: 1000000,
        C: 10000000,
        B: 1000000000
    };
    return a[b]
}

function templateCheck(a) {
    if (("C" != a) && ("M" != a)) {
        return true
    }
    return false
}

function fnsubmitStopRevPay(a) {
    if (validateForm(a) && fnIsValidChqDate()) {
        return onSaveVerify("Verify")
    }
}

function fnClearFields() {
    var b = document.forms[0];
    var a = b.length;
    for (i = 0; i < a; i++) {
        if (b[i].type == "text") {
            var c = b[i].value;
            b[i].value = ""
        }
    }
    b.submit()
}

function fnsaveStopRevPay(a) {
    if (validateForm(a) && fnIsValidChqDate()) {
        return onSaveVerify("Save")
    }
}

function fnIsacctIdNull(a) {
    if (fnIsNull(a)) {
        alert(finbranchResArr.get("FAT000090"));
        document.forms[0].acctId.focus();
        return 0
    }
    return 1
}

function fnIsValidChqDate() {
    var a = document.forms[0];
    if (!fnIsNull(a.chequeDate.value)) {
        if (!fnIsValidDate(a.chequeDate)) {
            alert(finbranchResArr.get("FAT000101"));
            fnSetFocusForDate(chequeDate);
            return false
        }
    }
    return true
}

function showCurrencyList(b) {
    if (!window.showModalDialog) {
        opFieldsArr = [];
        opFieldsArr[0] = b
    }
    var c = popModalWindow("../arjspmorph/" + applangcode + "/get_currency.jsp?wReturn=" + b.id + "&Currency=" + escape(b.value), "CurrencyList");
    if (window.showModalDialog) {
        if (c != null) {
            var a = c.split("|");
            b.value = a[0]
        }
    }
}

function showSolList(a) {
    if (!window.showModalDialog) {
        opFieldsArr = [];
        opFieldsArr[0] = a
    }
    var b = popModalWindow("../arjspmorph/" + applangcode + "/get_sol_list.jsp?wReturn=" + a.id + "&SolId=" + escape(a.value), "SolIdList");
    if (window.showModalDialog) {
        if (b != null) {
            a.value = b
        }
    }
}

function checkTolerance(a, c, b) {
    b = getValInStdFormat(b);
    if ((a == "" && c == "") || (fnIsNull(b))) {
        return true
    }
    lowFloatTolerance = parseFloat(a);
    highFloatTolerance = parseFloat(c);
    rateFloat = parseFloat(b);
    rateNew = getValInStdFormat(document.forms[0].rate.value);
    if (rateNew == "") {
        return true
    }
    lowLimit = rateFloat - (rateFloat * lowFloatTolerance) / 100;
    highLimit = rateFloat + (rateFloat * highFloatTolerance) / 100;
    if (rateNew <= highLimit && rateNew >= lowLimit) {
        return true
    } else {
        alert(finbranchResArr.get("FAT000039"));
        return true
    }
}

function changeRateCodeFlag(a) {
    var b = document.forms[0];
    if ("selected" != b.flag.value) {
        if ((b.rateCode.value).toUpperCase() != a) {
            b.rate.value = "";
            b.rateCodeFlag.value = "False"
        }
    }
}

function onChangeCurrency() {
    var a = document.forms[0];
    a.Amount.value = "";
    a.rate.value = ""
}

function openPartitionedDtlsWindow(d, b) {
    var c = window.open("../arjspmorph/" + applangcode + "/partitioned_details.jsp?rtId=" + rtId + "&partSelFlg=" + d + "&sConVarSuffix=" + b + "&preceedence=B", USERID + "_PartitionedDetails", "width=300,height=150,top=230,left=270");
    if (c != null && typeof(c) == "string" && c == "TIMEOUT") {
        var a = new Array(1);
        a[0] = finConst.FORCED_LOGOUT;
        handleWindowDisplay(finConst.DOLOGOUT, a);
        return
    }
}

function fnShowAdditionalDetails(c, a, b, d) {
    if (fnIsNull(a.value)) {
        alert(finbranchResArr.get("FAT000041"));
        return
    }
    openAdditionalDetailsWindow(c, a, b, d)
}

function getRateInfoCrossCurrency(a, d, f, b, h, e) {
    var g = document.forms[0];
    var c = g.xCurrency.value;
    if ((null == d) || (d.length <= 0) || (null == c) || (c.length <= 0)) {
        alert(finbranchResArr.get("FAT000032"));
        return
    }
    if ((g.xCurrency.value).toUpperCase() != d) {
        if (!(g.xAmount.value == "" || g.xCurrency.value == "" || g.Currency.value == "")) {
            if ("Rate" == f) {
                if (checkTolerance(b, h, e)) {
                    g.submitform.value = a;
                    convertToCaps();
                    g.submit()
                }
            } else {
                g.submitform.value = a;
                convertToCaps();
                g.submit()
            }
        }
    } else {
        g.rateCode.value = "";
        alert(finbranchResArr.get("FAT000001"))
    }
}

function fnShowListNreturn(a, b) {
    openModalWindow(a, b)
}

function openDocWindow(a) {
    var c = window.open(a, USERID + "_DocumentDetails", "Width=800,Height=400, Top=100, Left=70");
    if (c != null && typeof(c) == "string" && c == "TIMEOUT") {
        var b = new Array(1);
        b[0] = finConst.FORCED_LOGOUT;
        handleWindowDisplay(finConst.DOLOGOUT, b);
        return
    }
}

function openDenomWindow(a) {
    var c = window.open(a, USERID + "_DenominationDetails", "Width=600,Height=400, Top=100, Left=70");
    if (c != null && typeof(c) == "string" && c == "TIMEOUT") {
        var b = new Array(1);
        b[0] = finConst.FORCED_LOGOUT;
        handleWindowDisplay(finConst.DOLOGOUT, b);
        return
    }
}

function getRateInfoCommon(a, c, b) {
    var d = document.forms[0];
    if (c.toUpperCase() != b.toUpperCase()) {
        d.submitform.value = a;
        convertToCaps();
        d.submit()
    } else {
        d.rateCode.value = "";
        alert(finbranchResArr.get("FAT000001"))
    }
}

function getRateInfoCommonTC(a, f, e, d, b, h, c) {
    var g = document.forms[0];
    if (fnIsNull(g.rateCode.value)) {
        return
    }
    if (f.toUpperCase() != e.toUpperCase()) {
        if (!(g.amount.value == "" || f == "" || e == "")) {
            if ("Rate" == d) {
                if (checkTolerance(b, h, c)) {
                    g.submitform.value = a;
                    convertToCaps();
                    g.submit()
                }
            } else {
                g.submitform.value = a;
                convertToCaps();
                g.submit()
            }
        }
    } else {
        g.rateCode.value = "";
        alert(finbranchResArr.get("FAT000001"))
    }
}

function setValue(obj, string) {
    var objCtr = eval("document.forms[0]." + obj);
    objCtr.value = string
}

function writeDenom() {
    var retVal = true;
    var funcName = "this.writeCustDenominations";
    if (eval(funcName) != undefined) {
        retVal = eval(funcName).call(this)
    }
    if (null == retVal) {
        with(document) {
            write('<OPTION selected VALUE=""></OPTION>');
            write('<OPTION VALUE="1000">1000</OPTION>');
            write('<OPTION VALUE="500">500</OPTION>');
            write('<OPTION VALUE="100">100</OPTION>');
            write('<OPTION VALUE="50">50</OPTION>');
            write('<OPTION VALUE="20">20</OPTION>');
            write('<OPTION VALUE="10">10</OPTION>');
            write('<OPTION VALUE="5">5</OPTION>');
            write('<OPTION VALUE="2">2</OPTION>');
            write('<OPTION VALUE="1">1</OPTION>')
        }
    }
}

function writeDoc() {
    var retVal = true;
    var funcName = "this.writeCustDocumentTypes";
    if (eval(funcName) != undefined) {
        retVal = eval(funcName).call(this)
    }
    if (null == retVal) {
        with(document) {
            write('<OPTION selected VALUE="">--Select--</OPTION>');
            write('<OPTION VALUE="PSPRT">Passport</OPTION>');
            write('<OPTION VALUE="SSNUM">Social Security No</OPTION>');
            write('<OPTION VALUE="NATID">Nation Id</OPTION>');
            write('<OPTION VALUE="DRVLC">Drivers Licence</OPTION>');
            write('<OPTION VALUE="OTHER">Other</OPTION>')
        }
    }
}

function formatAmtOnBlur(a, b, d, c) {
    if (null != c) {
        if ("true" != c.value) {
            formatAmountToMillionOrLakh(a, b, d, "N")
        }
        c.value = "false"
    }
    if (isNaN(getAmtInStdFormat(b.value))) {
        b.focus()
    }
}

function fnOpenChargesWindow(chrgFlgObjName, chrgAmtObjName, exchgAmtObjName, grExchgAmtObjName, acctIdObjName, sellPurCrncyObj, evtIdObj, tcCrncyObj, chrgPgVisitedFlg, sGroupName, templateStatus) {
    if (!templateCheck(templateStatus)) {
        return
    }
    var frm = document.forms[0];
    var retValue;
    chrgFlgObj = eval("frm." + chrgFlgObjName);
    chrgAmtObj = eval("frm." + chrgAmtObjName);
    exchgAmtObj = eval("frm." + exchgAmtObjName);
    grExchgAmtObj = eval("frm." + grExchgAmtObjName);
    acctIdObj = eval("frm." + acctIdObjName);
    if (null != acctIdObj) {
        acctIdVal = acctIdObj.value
    } else {
        acctIdVal = ""
    }
    if (fnIsNull(sellPurCrncyObj.value)) {
        alert(finbranchResArr.get("FAT000520"));
        sellPurCrncyObj.focus();
        return
    }
    if (fnIsNull(evtIdObj.value)) {
        alert(finbranchResArr.get("FAT000521"));
        evtIdObj.focus();
        return
    }
    if ((sGroupName == "cpurchase") || (sGroupName == "tcpurchase")) {
        if (fnIsNull(grExchgAmtObj.value)) {
            alert(finbranchResArr.get("FAT000522"));
            grExchgAmtObj.focus();
            return
        }
        retValue = window.open("../arjspmorph/" + applangcode + "/tc_crncy_charges.jsp?rtId=" + rtId + "&flag=" + chrgFlgObj.value + "&chrgTCAmount=" + grExchgAmtObj.value + "&eventID=" + evtIdObj.value + "&acCrncy=" + sellPurCrncyObj.value + "&chrgAmtObjName=" + chrgAmtObjName + "&exchgAmtObjName=" + exchgAmtObjName + "&grExchgAmtObjName=" + grExchgAmtObjName + "&debitAcct=" + acctIdVal + "&tcCrncy=" + tcCrncyObj.value + "&chrgFlgObjName=" + chrgFlgObjName, USERID + "_chargesPage", "width=650,height=300,top=60,left=80");
        if (retValue != null && typeof(retValue) == "string" && retValue == "TIMEOUT") {
            var logoutParams = new Array(1);
            logoutParams[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
            return
        }
    } else {
        if (fnIsNull(exchgAmtObj.value)) {
            alert(finbranchResArr.get("FAT000522"));
            exchgAmtObj.focus();
            return
        }
        retValue = window.open("../arjspmorph/" + applangcode + "/tc_crncy_charges.jsp?rtId=" + rtId + "&flag=" + chrgFlgObj.value + "&chrgTCAmount=" + exchgAmtObj.value + "&eventID=" + evtIdObj.value + "&acCrncy=" + sellPurCrncyObj.value + "&chrgAmtObjName=" + chrgAmtObjName + "&exchgAmtObjName=" + exchgAmtObjName + "&grExchgAmtObjName=" + grExchgAmtObjName + "&debitAcct=" + acctIdVal + "&tcCrncy=" + tcCrncyObj.value + "&chrgFlgObjName=" + chrgFlgObjName, USERID + "_chargesPage", "width=650,height=300,top=60,left=80");
        if (retValue != null && typeof(retValue) == "string" && retValue == "TIMEOUT") {
            var logoutParams = new Array(1);
            logoutParams[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
            return
        }
    }
    chrgPgVisitedFlg.value = "True"
}

function openUserAdditionalDtlWindow() {
    var b = window.open("../arjspmorph/" + applangcode + "/additional_dtl.jsp?rtId=" + rtId, USERID + "_AdditionalDetails", "width=750, height=300,left=25,top=100");
    if (b != null && typeof(b) == "string" && b == "TIMEOUT") {
        var a = new Array(1);
        a[0] = finConst.FORCED_LOGOUT;
        handleWindowDisplay(finConst.DOLOGOUT, a);
        return
    }
}

function checkForEnter(a, b) {
    if (a.keyCode == 13) {
        b.focus();
        return false
    }
}

function clearDescField() {
    for (i = 0; i < arguments.length; i++) {
        eval("document.forms[0]." + arguments[i] + ".value=''")
    }
}

function callBack_getStatus(sTabReqd, sTabName) {
    var frm = document.forms[0];
    var objCB = eval("frm.chk" + sTabName);
    if ((sTabReqd == "Y") && !(objCB.checked)) {
        if ((objCB.getAttribute("fds") == null) || (objCB.getAttribute("fds") == "") || (objCB.getAttribute("fds") != "Y")) {
            objCB.click()
        }
    }
    if (frm.submitform) {
        frm.submitform.value = sTabName
    }
    if (frm.actionCode) {
        frm.actionCode.value = "goToTab"
    }
    frm.tabName.value = sTabName;
    convertToCaps();
    disableButtons();
    enableFormElements();
    fnEnableDescFields(frm);
    if (isConfirmDialogOpen != "Y") {
        frm.submit()
    } else {
        callBackFn_CD = "common_callBack_CD"
    }
    if (frm.screenName != undefined && post_TAB_SWITCH(sTabReqd, sTabName, frm.screenName.value) == false) {
        return false
    }
    return true
}

function getStatus(sTabReqd, sTabName) {
    var frm = document.forms[0];
    if (!fnLocaleValidateForm(sTabName)) {
        return
    }
    var objCB = eval("frm.chk" + sTabName);
    if (frm.screenName != undefined && pre_TAB_SWITCH(sTabReqd, sTabName, frm.screenName.value) == false) {
        return false
    }
    if (fnValidateForm(sTabName, sTabReqd)) {
        if ((sTabReqd == "Y") && !(objCB.checked)) {
            if ((objCB.getAttribute("fds") == null) || (objCB.getAttribute("fds") == "") || (objCB.getAttribute("fds") != "Y")) {
                objCB.click()
            }
        }
        if (frm.submitform) {
            frm.submitform.value = sTabName
        }
        if (frm.actionCode) {
            frm.actionCode.value = "goToTab"
        }
        frm.tabName.value = sTabName;
        convertToCaps();
        disableButtons();
        enableFormElements();
        fnEnableDescFields(frm);
        if (isConfirmDialogOpen != "Y") {
            frm.submit()
        } else {
            callBackFn_CD = "common_callBack_CD"
        }
        if (frm.screenName != undefined && post_TAB_SWITCH(sTabReqd, sTabName, frm.screenName.value) == false) {
            return false
        }
        return true
    } else {
        return false
    }
}

function common_callBack_CD() {
    var a = document.forms[0];
    a.submit()
}

function getTabStatus(sTabReqd, sTabName) {
    var frm = document.forms[0];
    if (!fnLocaleValidateForm(sTabName)) {
        return
    }
    var objCB = eval("frm.chk" + sTabName);
    if (frm.screenName != undefined && pre_TAB_SWITCH(sTabReqd, sTabName, frm.screenName.value) == false) {
        return false
    }
    if (fnValidateForm(sTabName)) {
        if ((sTabReqd == "Y") && !(objCB.checked)) {
            if ((objCB.getAttribute("fds") == null) || (objCB.getAttribute("fds") == "") || (objCB.getAttribute("fds") != "Y")) {
                objCB.click()
            }
        }
        frm.actionCode.value = "gotoTab";
        frm.tabName.value = sTabName;
        convertToCaps();
        disableButtons();
        fnEnableDescFields(frm);
        frm.submit();
        if (frm.screenName != undefined && post_TAB_SWITCH(sTabReqd, sTabName, frm.screenName.value) == false) {
            return false
        }
        return true
    } else {
        return false
    }
}

function displayHand(a) {
    if ("Microsoft Internet Explorer" == browser_name) {
        a.style.cursor = "hand"
    } else {
        a.style.cursor = "pointer"
    }
}

function setMandatory(b) {
    var a = "";
    if ((fnTrim(b) == "true") || (fnTrim(b) == "Y")) {
        a = "<font color='red' size='+0.5'>&nbsp;*</font>"
    }
    document.write(a)
}

function openDate(f, b) {
    var c = "";
    if (b == null) {
        b = ""
    }
    if (!window.showModalDialog) {
        dateObj_tmp = f;
        genericCallBackFn = "openDate_genericCallBack"
    }
    var e = String(f.name);
    e = e.substring(0, (e.length - 3));
    hidObj = document.getElementsByName(e);
    var d = (f.fmult == "Y") ? f.recNum : 0;
    var a = hidObj[d].value;
    if ((calbase == "01") && (a != null) && (a != "") && (a != "undefined")) {
        if (!chkHijriMapping(a)) {
            alert(finbranchResArr.get("FAT002843"));
            return
        }
    }
    a = (!fnIsValidContextDate(hidObj[d])) ? b : a;
    c = popCalendarModalWindowVar("../arjspmorph/" + applangcode + "/date.jsp?txtDate=" + f.id + "&date=" + b + "&dateVal=" + a + "&calbase=" + calbase, "Calendar", 225, 160, 15, 12);
    if (window.showModalDialog) {
        if (c != null) {
            f.value = fnConvertToUIDate(c);
            fnAssignDateOnEnter(f);
            fnSetFocusForDate(f)
        }
    }
}

function openDate_genericCallBack(a) {
    if (a != null) {
        dateObj_tmp.value = fnConvertToUIDate(a);
        fnAssignDateOnEnter(dateObj_tmp);
        fnSetFocusForDate(dateObj_tmp)
    }
}

function isValidAmount(a) {
    amt = getAmtInStdFormat(a);
    if ((amt.length > 17) || (isNaN(amt))) {
        return false
    }
    index = amt.indexOf(DEF_DECIMAL_SEPARATOR);
    if (index > 14) {
        return false
    }
    if ((index == -1) && (amt.length > 14)) {
        return false
    }
    return true
}

function formReset(c) {
    var b = c.elements;
    var a = b.length;
    for (i = 0; i < a; i++) {
        if ((((b[i].readOnly == false) || b[i].readOnly == undefined) && (b[i].disabled == false)) && ((b[i].type == "text") || (b[i].type == "select-one"))) {
            b[i].value = ""
        }
        fieldObj = b[i];
        dateFldAttr = fieldObj.getAttribute("fdt");
        if (dateFldAttr != null && (dateFldAttr == "fdate" || dateFldAttr == "date" || dateFldAttr == "datetime")) {
            b[i].value = ""
        }
        fieldObjAttributeValue = fieldObj.getAttribute("fds");
        if ((fieldObjAttributeValue == null) || (fieldObjAttributeValue == "")) {
            continue
        }
        fieldObjAttributeValue = fieldObjAttributeValue.toUpperCase();
        if (fieldObjAttributeValue == "Y") {
            b[i].value = ""
        }
    }
}

function setNumVal(sField, sVal) {
    if (sVal == "0") {
        eval("document.forms[0]." + sField + ".value=''")
    }
}

function fnValidateNumberFields() {
    var a = 0;
    var b = arguments.length;
    for (; a < b; a++) {
        arguments[a].value = fnTrim(arguments[a].value);
        if (!fnIsNull(arguments[a].value) && !fnIsPositiveNumber(arguments[a].value)) {
            err.setErr(arguments[a], finbranchResArr.get("FAT000189"));
            return false
        }
    }
    return true
}

function showConfirmDialog(c) {
    var a = finbranchResArr.get("FAT000554");
    var h = "Delete";
    var g = "Restore";
    var e = "Modify";
    var d = document.forms[0];
    isConfirmDialogOpen = "N";
    if ("Microsoft Internet Explorer" == browser_name) {
        d.ConfirmChoice.value = window.showModalDialog("../arjspmorph/" + applangcode + "/confirm_dialog.jsp?rtId=" + rtId + "&groupName=" + c + "&Msg=" + a + "&BtnOne=" + h + "&BtnTwo=" + g + "&BtnThree=" + e, "title", "dialogWidth:40;dialogHeight:10;status=no;toolbar=no;menubar=no;resizable=no");
        if (d.ConfirmChoice.value != null && typeof(d.ConfirmChoice.value) == "string" && d.ConfirmChoice.value == "TIMEOUT") {
            var b = new Array(1);
            b[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, b);
            return
        }
    } else {
        isConfirmDialogOpen = "Y";
        var f = window.open("../arjspmorph/" + applangcode + "/confirm_dialog.jsp?rtId=" + rtId + "&groupName=" + c + "&Msg=" + a + "&BtnOne=" + h + "&BtnTwo=" + g + "&BtnThree=" + e, "title", "modal=yes, width=600, height=110,top=230,left=270,scrollbars=yes,toolbar=no,menubar=no");
        if (f != null && typeof(f) == "string" && f == "TIMEOUT") {
            var b = new Array(1);
            b[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, b);
            return
        }
    }
    return d.ConfirmChoice.value
}

function submitFromErr(sGroupName, sErrLLName, sRecNo, sFocusField, sOuterErrLLName, sOuterRecNo, isMRMError) {
    if (fnValidateForm()) {
        var frm = document.forms[0];
        if (window.MULTIREC_NEW_ARCH) {
            if (window.LIST_MRH_FLAG && window.PAGE_MRH_FLAG) {
                var objRec = eval("document.forms[0]." + sErrLLName + "RecNo");
                objRec.value = sRecNo;
                var objDir = eval("document.forms[0]." + sErrLLName + "direction");
                objDir.value = sErrLLName + "::GoToErrField";
                if (sOuterErrLLName != undefined && sOuterRecNo != undefined && !fnIsNull(sOuterErrLLName) && !fnIsNull(sOuterRecNo)) {
                    var objOuterRec = eval("document.forms[0]." + sOuterErrLLName + "RecNo");
                    objOuterRec.value = sOuterRecNo;
                    var objOuterDir = eval("document.forms[0]." + sOuterErrLLName + "direction");
                    objOuterDir.value = sOuterErrLLName + "::GoToErrField";
                    if (frm.submitform) {
                        frm.submitform.value = sOuterErrLLName + "::MultirecAct"
                    }
                    if (frm.actionCode) {
                        frm.actionCode.value = sOuterErrLLName + "::MultirecAct"
                    }
                } else {
                    if (frm.submitform) {
                        frm.submitform.value = sErrLLName + "::MultirecAct"
                    }
                    if (frm.actionCode) {
                        frm.actionCode.value = sErrLLName + "::MultirecAct"
                    }
                }
            } else {
                frm.RecNo.value = sRecNo;
                frm.direction.value = sErrLLName + "::GoToErrField";
                if (frm.submitform) {
                    frm.submitform.value = sErrLLName + "::MultirecAct"
                }
                if (frm.actionCode) {
                    frm.actionCode.value = sErrLLName + "::MultirecAct"
                }
            }
        } else {
            if (frm.submitform) {
                frm.submitform.value = sGroupName
            }
            if (frm.actionCode) {
                frm.actionCode.value = "GoToErrField"
            }
        }
        if (isMRMError == undefined || isMRMError.toUpperCase() == "N") {
            frm.ErrLLName.value = sErrLLName;
            frm.RecNo.value = sRecNo;
            frm.FocusField.value = sFocusField
        } else {
            if (isMRMError.toUpperCase() == "Y") {
                frm.MRMErrLLName.value = sErrLLName;
                frm.MRMRecNo.value = sRecNo;
                frm.MRMFocusField.value = sFocusField
            }
        }
        if (sOuterErrLLName != undefined && sOuterRecNo != undefined && !fnIsNull(sOuterErrLLName) && !fnIsNull(sOuterRecNo)) {
            frm.OuterErrLLName.value = sOuterErrLLName;
            frm.OuterRecNo.value = sOuterRecNo
        }
        convertToCaps();
        disableButtons();
        frm.submit()
    }
}

function fnValidateFreqFields(g, a, c, b, e) {
    var h = g.value;
    var d = a.value;
    var f = c.value;
    var m = b.value;
    var l = e.value;
    if (fnIsNull(h) && fnIsNull(d) && fnIsNull(f) && fnIsNull(m) && fnIsNull(l)) {
        return true
    }
    if (!fnIsNull(h) && fnIsNull(l)) {
        err.setErr(g, finbranchResArr.get("FAT000192"));
        return false
    }
    switch (h) {
        case "D":
        case "W":
        case "F":
        case "B":
        case "N":
            if (fnIsNull(d) && fnIsNull(f) && fnIsNull(m)) {
                return true
            } else {
                err.setErr(g, finbranchResArr.get("FAT000192"));
                return false
            }
            break;
        case "M":
        case "T":
        case "Q":
        case "H":
        case "Y":
        case "I":
            if (!fnIsNull(d) && !fnIsNull(f) && fnIsNull(m)) {
                return true
            } else {
                if (fnIsNull(d) && fnIsNull(f) && !fnIsNull(m)) {
                    if (isNaN(m) || (Number(m) < 1) || (Number(m) > 31)) {
                        err.setErr(b, finbranchResArr.get("FAT000197"));
                        return false
                    }
                    return true
                } else {
                    err.setErr(g, finbranchResArr.get("FAT000192"));
                    return false
                }
            }
            break;
        case "U":
            return true;
            break;
        default:
            err.setErr(g, finbranchResArr.get("FAT000192"));
            return false
    }
}

function fnValidateBpFreqFields(h, e, a, d, b, f) {
    var m = h.value;
    var l = e.value;
    var c = a.value;
    var g = d.value;
    var p = b.value;
    var o = f.value;
    if (fnIsNull(m) && fnIsNull(c) && fnIsNull(g) && fnIsNull(p) && fnIsNull(o)) {
        return true
    }
    if (!fnIsNull(m) && fnIsNull(o)) {
        err.setErr(h, finbranchResArr.get("FAT000192"));
        return false
    }
    switch (m) {
        case "D":
        case "W":
        case "F":
        case "B":
        case "N":
            if (fnIsNull(c) && fnIsNull(g) && fnIsNull(p)) {
                return true
            } else {
                err.setErr(h, finbranchResArr.get("FAT000192"));
                return false
            }
            break;
        case "M":
        case "T":
        case "Q":
        case "H":
        case "Y":
            if (!fnIsNull(c) && !fnIsNull(g) && fnIsNull(p)) {
                return true
            } else {
                if (fnIsNull(c) && fnIsNull(g) && !fnIsNull(p)) {
                    if (isNaN(p) || (Number(p) < 1) || (Number(p) > 31)) {
                        err.setErr(b, finbranchResArr.get("FAT000197"));
                        return false
                    }
                    return true
                } else {
                    err.setErr(h, finbranchResArr.get("FAT000192"));
                    return false
                }
            }
            break;
        case "U":
            if (!fnIsNull(l)) {
                return true
            } else {
                err.setErr(h, finbranchResArr.get("FAT000192"));
                return false
            }
            break;
        default:
            err.setErr(h, finbranchResArr.get("FAT000192"));
            return false
    }
}

function displayErr() {
    if (this.hasErr) {
        if (!(typeof(this.oId.length) != "undefined" && typeof(this.oId.type) == "undefined")) {
            if (this.oId.getAttribute("fdt") == "fdate") {
                fnSetFocusForDate(this.oId)
            } else {
                this.oId.focus()
            }
        } else {
            if (this.oId[0].type == "radio") {
                this.oId[0].focus()
            }
        }
        alert(this.sMsg);
        this.clearErr();
        this.hasErr = false
    }
}

function setErr(b, a) {
    this.hasErr = true;
    this.oId = b;
    this.sMsg = a
}

function clearErr() {
    this.oId = "";
    this.sMsg = ""
}

function ErrObject() {
    this.hasErr = false;
    this.oId = "";
    this.sMsg = "";
    this.setErr = setErr;
    this.clearErr = clearErr;
    this.displayErr = displayErr
}

function fnSelectField(groupName, errField) {
    var ERR_FIELD_SEPARATOR = "_";
    var errFieldId = errField;
    var pgPos = errField.indexOf("pg");
    var dotPos = errField.indexOf(ERR_FIELD_SEPARATOR);
    var fieldObj = null;
    if ((dotPos != -1) && (pgPos != -1)) {
        var fieldPrefix = errField.substr(0, 2);
        if (fieldPrefix == "pg") {
            var errPgNum = errField.substring(2, dotPos);
            if (objForm.pgNum.value == errPgNum) {
                errFieldId = errField.substring(dotPos + 1)
            } else {
                if (fnValidateForm()) {
                    var frm = document.forms[0];
                    if (!fnLocaleValidateForm(errField)) {
                        return
                    }
                    frm.submitform.value = groupName;
                    frm.FocusField.value = errField;
                    frm.actionCode.value = "MultiPageError";
                    convertToCaps();
                    disableButtons();
                    frm.submit()
                }
                return true
            }
        }
    }
    if (eval("document.forms[0]." + errFieldId) != undefined) {
        fieldObj = eval("document.forms[0]." + errFieldId);
        if (fieldObj.id != undefined) {
            var fldDivAttr = fieldObj.getAttribute("divId");
            if (fldDivAttr != null && (!fnIsNull(fldDivAttr))) {
                showCurrentDiv(fldDivAttr)
            }
        }
    }
    setErrFieldFocus(errFieldId)
}

function setErrFieldFocus(errFieldId) {
    var fieldObj = eval("document.forms[0]." + errFieldId);
    var fieldObjLen = null;
    var fieldType = null;
    var fld = null;
    if (!isEmptyObj(fieldObj)) {
        fieldObjLen = fieldObj.length
    }
    if (!isEmptyObj(fieldObj) && !isNaN(fieldObjLen) && ("radio" == fieldObj[0].type || "checkbox" == fieldObj[0].type)) {
        for (var eleCount = 0; eleCount < fieldObjLen; eleCount++) {
            var flag = false;
            if (true == fieldObj[eleCount].checked) {
                fld = fieldObj[eleCount];
                flag = true;
                break
            }
        }
        if (!flag) {
            fld = fieldObj[0]
        }
        setFieldFocus(fld)
    } else {
        if (!isEmptyObj(fieldObj)) {
            fld = fieldObj;
            var visualFldId = fieldObj.getAttribute("vFldId");
            if (!isEmptyObjValue(visualFldId)) {
                var visualFldObj = eval("document.forms[0]." + visualFldId);
                if (!isEmptyObj(visualFldObj)) {
                    fld = visualFldObj
                }
            }
            setFieldFocus(fld)
        }
    }
    return
}

function getFieldForFocus(errFieldId) {
    var fieldObj = eval("document.forms[0]." + errFieldId);
    var fieldObjLen = null;
    var fieldType = null;
    if (!isEmptyObj(fieldObj)) {
        fieldObjLen = fieldObj.length
    }
    if (!isEmptyObj(fieldObj) && !isNaN(fieldObjLen) && ("radio" == fieldObj[0].type || "checkbox" == fieldObj[0].type)) {
        for (var eleCount = 0; eleCount < fieldObjLen; eleCount++) {
            var flag = false;
            if (true == fieldObj[eleCount].checked) {
                fieldObj = eval("document.forms[0]." + fieldObj[eleCount].id);
                flag = true;
                break
            }
        }
        if (!flag) {
            fieldObj = eval("document.forms[0]." + fieldObj[0].id)
        }
    } else {
        if (!isEmptyObj(fieldObj)) {
            var visualFldId = fieldObj.getAttribute("vFldId");
            if (!isEmptyObjValue(visualFldId)) {
                var visualFldObj = eval("document.forms[0]." + visualFldId);
                if (!isEmptyObj(visualFldObj)) {
                    fieldObj = visualFldObj
                }
            }
        }
    }
    return fieldObj
}

function setFieldFocus(a) {
    if (!isEmptyObj(a)) {
        dataType = a.getAttribute("fdt");
        if (!fnIsNull(dataType) && (dataType == "fdate" || dataType == "date" || dataType == "datetime")) {
            fnSetFocusForDate(a)
        } else {
            if (a.disabled == false) {
                if (a.type == "text") {
                    a.focus();
                    a.select()
                } else {
                    if (a.type != "hidden") {
                        a.focus()
                    }
                }
            }
        }
    }
}

function disableButtons() {
    var obj = document.forms[0].elements;
    var len = obj.length;
    for (var i = 0; i < len; i++) {
        switch (obj[i].type) {
            case "button":
            case "submit":
            case "reset":

                obj[i].disabled = true;
                break;
        }
    }
    if (this.WF_IN_PROGRESS == undefined || this.WF_IN_PROGRESS != "PEAS") {
        disableTabs();
    }
}

function refineString(g) {
    var a = ["'", '"', "<", ">"];
    for (var e = 0; e < a.length; e++) {
        var h = 0;
        var f = 0;
        var l = null;
        switch (a[e]) {
            case "'":
                l = "#39";
                break;
            case '"':
                l = "#34";
                break;
            case "<":
                l = "#60";
                break;
            case ">":
                l = "#62";
                break;
            default:
                l = "#34"
        }
        if (g == null || g.length == 0) {
            return g
        }
        var d, c, b;
        while (h < g.length) {
            f = g.indexOf(a[e]);
            if (f == -1) {
                h = g.length;
                continue
            }
            d = g.substring(0, f);
            c = g.substring(f, f + 1);
            b = g.substring(f + 1, g.length);
            c = "&" + l + ";";
            g = d + c + b;
            h++
        }
    }
    return g
}

function addSlash(g) {
    var a = ["&#39;", "&#34;"];
    for (var e = 0; e < a.length; e++) {
        var h = 0;
        var f = 0;
        var l = null;
        if (g == null || g.length == 0) {
            return g
        }
        var d, c, b;
        while (h < g.length) {
            f = g.indexOf(a[e], h);
            if (f == -1) {
                h = g.length;
                continue
            }
            d = g.substring(0, f);
            c = g.substring(f, f + 1);
            b = g.substring(f + 1, g.length);
            c = "\\" + c;
            g = d + c + b;
            h = f + 2
        }
    }
    return g
}

function showSetList(g, e, h, a) {
    var l = "";
    var c = "";
    var f = "B";
    var b = "../arjspmorph/";
    if (arguments.length > 1) {
        if (e == "morph") {
            b = "../"
        }
    }
    g.value = g.value.replace(/\'/, '"');
    if (arguments.length > 2) {
        f = h
    }
    if (g != null) {
        l = g.id
    }
    if (arguments.length < 4) {
        c = b + applangcode + "/get_set_list.jsp?SetId=" + escape(g.value) + "&wReturn=" + l + "&wReturnDesc=NULL&preceedence=" + f
    } else {
        c = b + applangcode + "/get_set_list.jsp?SetId=" + escape(g.value) + "&wReturn=" + l + "&wReturnDesc=" + a.id + "&preceedence=" + f
    }
    if (!window.showModalDialog) {
        opFieldsArr = [];
        opFieldsArr[0] = g;
        opFieldsArr[1] = a
    }
    var d = popModalWindow(c, "SetIdList");
    if (window.showModalDialog) {
        if (d != null && d != undefined) {
            var m = d.split("|");
            g.value = m[0];
            if (a != null) {
                a.value = m[1]
            }
        }
    }
}

function disableFields() {
    for (i = 0; i < arguments.length; i++) {
        obj = eval("document.forms[0]." + arguments[i]);
        if ((undefined != obj) && (null != obj)) {
            if (obj.length == undefined && obj.getAttribute("fdt") == "fdate") {
                fnEnableUIField(obj, "N")
            } else {
                if (!(typeof(obj.length) != "undefined" && typeof(this.obj.type) == "undefined")) {
                    obj.disabled = true
                } else {
                    fnEnableDisableRadioButtons(obj, "D")
                }
            }
        }
    }
}

function enableFields() {
    for (i = 0; i < arguments.length; i++) {
        obj = eval("document.forms[0]." + arguments[i]);
        if ((undefined != obj) && (null != obj)) {
            if (obj.length == undefined && obj.getAttribute("fdt") == "fdate") {
                fnEnableUIField(obj, "Y")
            } else {
                if (!(typeof(obj.length) != "undefined" && typeof(this.obj.type) == "undefined")) {
                    obj.disabled = false
                } else {
                    fnEnableDisableRadioButtons(obj, "")
                }
            }
        }
    }
}

function fnPopUpExceptionWindow(returnObj) {
    funcName = "this.locfnPopUpExceptionWindow";
    if (eval(funcName) != undefined) {
        return eval(funcName).call(this)
    }
    localPrintFired = "this.isLocalPrintFired";
    var isLocalPrintFired = (eval(localPrintFired) != undefined);
    if (sPopUpExceptionWindow.toUpperCase() != "TRUE") {
        return
    }
    var returnObjId = "submitform";
    if ((returnObj != null) && (returnObj != undefined)) {
        returnObjId = returnObj.id
    }
    if (!window.showModalDialog) {
        genericCallBackFn = "genericCallBack_Excp"
    }
    var retVal = popModalWindowVarRef("../arjspmorph/" + applangcode + "/excp_popup_screen.jsp?wReturn=submitform", "excp_popup_screen", "600", "325", "43", "24");
    if (window.showModalDialog) {
        if ((retVal != null) && (retVal != undefined)) {
            eval("document.forms[0]." + returnObjId + ".value = '" + retVal + "'")
        }
        if (isLocalPrintFired) {
            if (this.isLocalPrintFired.toUpperCase() == "Y" && eval("document.forms[0]." + returnObjId + ".value == 'Submit'")) {
                document.forms[0].callMode.value = "N";
                document.forms[0].localPrint.click();
                return
            }
        }
        if (eval("document.forms[0]." + returnObjId + ".value == 'Submit'")) {
            fnAssignDateOnLoad(document.forms[0]);
            document.forms[0].callMode.value = "N";
            if ((document.forms[0].Submit != undefined) && (document.forms[0].Submit != null)) {
                document.forms[0].Submit.click()
            } else {
                if ((document.forms[0].Accept != undefined) && (document.forms[0].Accept != null)) {
                    document.forms[0].Accept.click()
                }
            }
        }
        if (eval("document.forms[0]." + returnObjId + ".value == 'Refer'")) {
            document.forms[0].submitform.value = "REFERDATA";
            document.forms[0].actionCode.value = "REFERDATA";
            document.forms[0].submit()
        }
        if (eval("document.forms[0]." + returnObjId + ".value == 'RefSubmit'")) {
            fnAssignDateOnLoad(document.forms[0]);
            document.forms[0].Submit.click()
        }
    }
}

function genericCallBack_Excp(rValue) {
    localPrintFired = "this.isLocalPrintFired";
    var isLocalPrintFired = (eval(localPrintFired) != undefined);
    var returnObjId = "submitform";
    if ((rValue != null) && (rValue != undefined)) {
        returnObjId = rValue
    }
    if (isLocalPrintFired) {
        if (this.isLocalPrintFired.toUpperCase() == "Y" && returnObjId == "Submit") {
            document.forms[0].callMode.value = "N";
            document.forms[0].localPrint.click();
            return
        }
    }
    if (returnObjId == "Submit") {
        fnAssignDateOnLoad(document.forms[0]);
        document.forms[0].callMode.value = "N";
        if ((document.forms[0].Submit != undefined) && (document.forms[0].Submit != null)) {
            document.forms[0].Submit.click()
        } else {
            if ((document.forms[0].Accept != undefined) && (document.forms[0].Accept != null)) {
                document.forms[0].Accept.click()
            }
        }
    }
    if (returnObjId == "Refer") {
        document.forms[0].submitform.value = "REFERDATA";
        document.forms[0].actionCode.value = "REFERDATA";
        document.forms[0].submit()
    }
    if (returnObjId == "RefSubmit") {
        fnAssignDateOnLoad(document.forms[0]);
        document.forms[0].Submit.click()
    }
}

function validateAsciiData(b) {
    var a = b.getAttribute("fmb");
    if (!(a == "Y") && (!isAsciiVal(b.value))) {
        return false
    }
    return true
}

function isAsciiVal(a) {
    return true;
    if (fnIsNull(a)) {
        return true
    }
    for (i = 0, n = a.length; i < n; i++) {
        if (a.charCodeAt(i) >= 127) {
            return false
        }
    }
    return true
}

function validateTypes(p) {
    var e = p.elements;
    var f, d, o;
    for (var h = 0; h < e.length; h++) {
        f = e[h];
        if (f.type == "application/x-oleobject") {
            continue
        }
        var g = f.getAttribute("fdt");
        if ((f.type != "hidden") && (f.disabled != true) && (f.readOnly != true)) {
            if ((g == null) && (!validateAsciiData(f))) {
                if (valSwitch) {
                    switchCalArr[1] = finbranchResArr.get("FAT000591")
                } else {
                    alert(finbranchResArr.get("FAT000591"))
                }
                f.focus();
                return false
            }
        }
        if ((g != null) && ((g != "")) && ((g.length != 0))) {
            o = String(f.id);
            d = o.substring((o.length - 3), o.length);
            if (d == "_ui") {
                if (!fnEventFormatDate(f)) {
                    return false
                }
            }
            if ((g == "fdate") || (g == "datetime") || (g == "date")) {
                if (!fnIsValidDate(f)) {
                    if (calbase == "00") {
                        if (valSwitch) {
                            switchCalArr[1] = finbranchResArr.get("FAT002593")
                        } else {
                            if (aFlag == "Y") {
                                alert(finbranchResArr.get("FAT002593"))
                            }
                        }
                        fnSetFocusForDate(f);
                        return false
                    }
                    if (calbase == "01") {
                        if (valSwitch) {
                            switchCalArr[1] = finbranchResArr.get("FAT002594")
                        } else {
                            alert(finbranchResArr.get("FAT002594"))
                        }
                        fnSetFocusForDate(f);
                        return false
                    }
                }
            }
            if (g == "ftime") {
                if (!fnIsValidTime(f.value)) {
                    if (valSwitch) {
                        switchCalArr[1] = finbranchResArr.get("FAT000278")
                    } else {
                        alert(finbranchResArr.get("FAT000278"))
                    }
                    f.focus();
                    return false
                }
            }
            if (g == "ftimeHHMM") {
                if (!fnIsValidTimeHHMM(f)) {
                    f.focus();
                    return false
                }
            }
            if (g == "fpcnt" || g == "fnpcnt") {
                if (!fnIsNull(f.value)) {
                    var m = getValInStdFormat(f.value);
                    var q = (isNaN(m) || m.indexOf(" ") != -1 || parseFloat(m) > 100) || (g == "fpcnt" && parseFloat(m) < 0);
                    if (q) {
                        if (valSwitch) {
                            switchCalArr[1] = finbranchResArr.get("FAT000167")
                        } else {
                            alert(finbranchResArr.get("FAT000167"))
                        }
                        f.focus();
                        return false
                    }
                    if (!fnValidatePercent(f.value, 6)) {
                        f.focus();
                        return false
                    }
                }
            }
            if (g == "fint") {
                if (!fnIsNull(f.value)) {
                    var c = getValInStdFormat(f.value);
                    if ((isNaN(c)) || (c.indexOf(DEF_DECIMAL_SEPARATOR) != -1)) {
                        if (valSwitch) {
                            switchCalArr[1] = finbranchResArr.get("FAT000201")
                        } else {
                            alert(finbranchResArr.get("FAT000201"))
                        }
                        f.focus();
                        return false
                    }
                }
            }
            if (g == "fpint") {
                if (!fnIsNull(f.value)) {
                    var c = getValInStdFormat(f.value);
                    if (((isNaN(c)) || (c.indexOf(DEF_DECIMAL_SEPARATOR) != -1) || (parseFloat(c) <= 0))) {
                        if (valSwitch) {
                            switchCalArr[1] = finbranchResArr.get("FAT000202")
                        } else {
                            alert(finbranchResArr.get("FAT000202"))
                        }
                        f.focus();
                        return false
                    }
                    if (!fnValidateSpecialChars(f)) {
                        return false
                    }
                }
            }
            if (g == "frate") {
                var a = getValInStdFormat(f.value);
                if (isNaN(a)) {
                    if (valSwitch) {
                        switchCalArr[1] = finbranchResArr.get("FAT000203")
                    } else {
                        alert(finbranchResArr.get("FAT000203"))
                    }
                    f.focus();
                    return false
                } else {
                    if (!fnIsNull(f.value) && !fnValidateConvRate(f, 10)) {
                        f.focus();
                        return false
                    }
                }
                if (parseFloat(a) < 0) {
                    if (valSwitch) {
                        switchCalArr[1] = finbranchResArr.get("FAT000487")
                    } else {
                        alert(finbranchResArr.get("FAT000487"))
                    }
                    f.focus();
                    return false
                }
            }
            if (g == "fpzint") {
                if (!fnIsNull(f.value)) {
                    var c = getValInStdFormat(f.value);
                    if ((isNaN(c)) || (c.indexOf(DEF_DECIMAL_SEPARATOR) != -1)) {
                        if (valSwitch) {
                            switchCalArr[1] = finbranchResArr.get("FAT000277")
                        } else {
                            alert(finbranchResArr.get("FAT000277"))
                        }
                        f.focus();
                        return false
                    }
                    if (parseFloat(c) < 0) {
                        if (valSwitch) {
                            switchCalArr[1] = finbranchResArr.get("FAT001462")
                        } else {
                            alert(finbranchResArr.get("FAT001462"))
                        }
                        f.focus();
                        return false
                    }
                    if (!fnValidateSpecialChars(f)) {
                        return false
                    }
                }
            }
            if (g == "fgpcnt") {
                var l = getValInStdFormat(removeMantissa(f.value));
                if (!fnIsNull(l)) {
                    var b = (isEmptyObjValue(l) || !isNumber(l) || (-1 != l.indexOf(" ")) || (999 < getValInFloat(l)) || (0 > getValInFloat(l)) || (-1 != l.toUpperCase().indexOf("E")));
                    if (b) {
                        if (valSwitch) {
                            switchCalArr[1] = finbranchResArr.get("FAT000167")
                        } else {
                            alert(finbranchResArr.get("FAT000167"))
                        }
                        f.focus();
                        return false
                    }
                    if (!fnValidatePercent(l, 6)) {
                        f.focus();
                        return false
                    }
                }
            }
        }
    }
    return true
}

function fnValidateConvRate(h, d) {
    var b = 0;
    var a = 0;
    var e = 0;
    var l = false;
    var f = getValInStdFormat(h.value);
    var m = 10;
    var g = 11;
    var c = 21;
    if (isNaN(f)) {
        alert(finbranchResArr.get("FAT000189"))
    } else {
        e = f.indexOf(".");
        if (e == -1) {
            b = f
        } else {
            b = f.substring(0, e);
            a = f.substring(e + 1);
            m = m > d ? d : m
        }
        if (f.length > c) {
            alert(finbranchResArr.get("FAT000523") + c + "" + finbranchResArr.get("FAT000524"))
        } else {
            if (b.length > g) {
                alert(finbranchResArr.get("FAT000529"))
            } else {
                if (a.length > m) {
                    alert(finbranchResArr.get("FAT000523") + m + "" + finbranchResArr.get("FAT000526"))
                } else {
                    l = true
                }
            }
        }
    }
    h.value = getValInCustomFormat(f);
    return l
}

function isPageEmpty(objForm) {
    var FMND_ATTRIB_NAME = "fmnd";
    var frmElem = objForm.elements;
    var fmndVal = "";
    for (var i = 0; i < frmElem.length; i++) {
        fmndVal = frmElem[i].getAttribute(FMND_ATTRIB_NAME);
        if ((fmndVal != null) && (fmndVal != "")) {
            fmndVal = fmndVal.toUpperCase();
            if (((fmndVal == "Y") || (fmndVal == "TRUE")) && !fnIsNull(frmElem[i].value) && frmElem[i].type != "radio") {
                return false
            } else {
                if ((fmndVal == "Y" || fmndVal == "TRUE") && frmElem[i].type == "radio") {
                    var obj = eval("document.forms[0]." + frmElem[i].id);
                    if (!fnIsNull(getRadioValue(obj))) {
                        return false
                    }
                }
            }
        }
    }
    return true
}

function fnEnableDescFields(a) {
    fnEnableFieldsBasedOnAttribute(a, "fds", "Y")
}

function fnEnableFieldsBasedOnAttribute(g, e, a) {
    var d = g.elements;
    var f = d.length;
    var c = "";
    var b = "";
    for (iCount = 0; iCount < f; iCount++) {
        c = d[iCount];
        b = c.getAttribute(e);
        if ((b == null) || (b == "")) {
            continue
        }
        b = b.toUpperCase();
        if (b == a.toUpperCase()) {
            c.disabled = false
        }
    }
}

function fnValidateMandatoryFields() {
    var frmElem = document.forms[0].elements;
    var frmElemLen = frmElem.length;
    var fieldObj = "";
    var mandatoryAttributeValue = "";
    for (iCount = 0; iCount < frmElemLen; iCount++) {
        fieldObj = frmElem[iCount];
        var divIdAttr = fieldObj.getAttribute("divId");
        var blockId = fieldObj.getAttribute("blockId");
        if (divIdAttr != null) {
            var fldPrntDivId = divIdAttr.split("#");
            if (eval(document.forms[0].divId.value.split("#")) != undefined) {
                var frmPrntDivId = document.forms[0].divId.value.split("#");
                if (frmPrntDivId[0] != fldPrntDivId[0]) {
                    continue
                }
            }
        }
        if ((fieldObj.type != "text") && (fieldObj.type != "select-one") && (fieldObj.type != "textarea") && (fieldObj.type != "radio")) {
            continue
        }
        mandatoryAttributeValue = fieldObj.getAttribute("fmnd");
        if ((mandatoryAttributeValue == null) || (mandatoryAttributeValue == "")) {
            continue
        }
        mandatoryAttributeValue = mandatoryAttributeValue.toUpperCase();
        if ((mandatoryAttributeValue == "TRUE") || (mandatoryAttributeValue == "Y")) {
            if ((fieldObj.type == "radio")) {
                var flds = eval("document.forms[0]." + fieldObj.id);
                var len = flds.length;
                if (len != undefined && len != null) {
                    iCount = iCount + (len - 1)
                }
                if (!checkAndFocusRadio(flds, len, divIdAttr, blockId)) {
                    return false
                }
            }
            if (fieldObj.type != "radio") {
                if (fnIsNull(fieldObj.value)) {
                    if (divIdAttr != null) {
                        if (blockId != null) {
                            var fldBlkId = blockId.split("_");
                            if (fldBlkId[1] == "2") {
                                fnShowNextMultPage()
                            } else {
                                if (fldBlkId[1] == "1") {
                                    fnShowPrevMultPage()
                                }
                            }
                        }
                    }
                    fieldObj.focus();
                    alert(finbranchResArr.get("FAT000924"));
                    return false
                }
                fieldType = fieldObj.getAttribute("fdt");
                if ((fieldType != null) && (fieldType != "") && ((fieldType == "fint") || (fieldType == "fpint") || (fieldType == "frate"))) {
                    var tempVal = getValInStdFormat(fieldObj.value);
                    if (isNaN(tempVal) || (Number(tempVal) == 0)) {
                        var fieldDivId = fieldObj.getAttribute("divId");
                        if (fieldDivId != null && (!fnIsNull(fieldDivId))) {
                            showCurrentDiv(fieldDivId)
                        }
                        if (divIdAttr != null) {
                            if (blockId != null) {
                                var fldBlkId = blockId.split("_");
                                if (fldBlkId[1] == "2") {
                                    fnShowNextMultPage()
                                } else {
                                    if (fldBlkId[1] == "1") {
                                        fnShowPrevMultPage()
                                    }
                                }
                            }
                        }
                        fieldObj.focus();
                        alert(finbranchResArr.get("FAT000146"));
                        return false
                    }
                }
            }
        }
    }
    if (!validateSpecialChar()) {
        return false
    }
    return true
}

function checkAndFocusRadio(a, h, l, c) {
    var d = null;
    var e = false;
    if (h == undefined || h == null) {
        d = a
    } else {
        d = a[0]
    }
    for (var f = 1; f < h; f++) {
        if (a[f].checked == true) {
            d = a[f];
            e = true;
            break
        }
    }
    if (!e && d.checked == false) {
        if (l != null) {
            if (c != null) {
                var g = c.split("_");
                if (g[1] == "2") {
                    fnShowNextMultPage()
                } else {
                    if (g[1] == "1") {
                        fnShowPrevMultPage()
                    }
                }
            }
        }
        d.focus();
        alert(finbranchResArr.get("FAT001313"));
        return false
    } else {
        if (fnIsNull(d.value)) {
            var b = d.getAttribute("divId");
            if ((b != null) && (!fnIsNull(b))) {
                showCurrentDiv(b)
            }
            if (l != null) {
                if (c != null) {
                    var g = c.split("_");
                    if (g[1] == "2") {
                        fnShowNextMultPage()
                    } else {
                        if (g[1] == "1") {
                            fnShowPrevMultPage()
                        }
                    }
                }
            }
            d.focus();
            alert(finbranchResArr.get("FAT001313"));
            return false
        }
    }
    return true
}
var theBuffer;

function initialize() {
    theBuffer = new exchanger("myframe")
}

function sendDataToServer(frameName, fetchId, precedence, wReturn, wReturnDesc) {
    var strArray = wReturn.split("|");
    var tmpStr = "";
    if (strArray.length > 0) {
        var newStr = "";
        for (var i = 0; i < strArray.length; i++) {
            newStr = eval("document.forms[0]." + strArray[i] + ".value");
            newStr = fnTrim(newStr);
            tmpStr = tmpStr + "|" + escape(newStr)
        }
        tmpStr = tmpStr.substring(1)
    }
    var bUrl = getBaseUrl();
    var sUrl = bUrl + finContextPath + "/arjspmorph/" + applangcode + "/frm_fetch.jsp?rtId=" + rtId + "&fetchId=" + fetchId + "&precedence=" + precedence;
    if (wReturn != "") {
        sUrl = sUrl + "&wReturn=" + tmpStr
    }
    if (wReturnDesc != "") {
        sUrl = sUrl + "&wReturnDesc=" + wReturnDesc
    }
    var xMax = screen.width,
        yMax = screen.height;
    var xOffset = (xMax - 120),
        yOffset = (yMax - 150);
    var params;
    if (window.showModalDialog) {
        params = "dialogWidth=0px;dialogHeight=0px;dialogLeft=" + xOffset + "px;dialogTop=" + yOffset + "px"
    } else {
        params = "dialogHeight:100px;dialogleft:843px;dialogWidth:175px;dialogtop:588px"
    }
    params += ";status=no;toolbar=no;menubar=no;resizable=no;help=no;center=no";
    if (window.showModalDialog) {
        var inpData = wReturnDesc;
        var obj = document.forms[0];
        var outData = window.showModalDialog(sUrl, document.forms[0], params);
        if (outData != null && typeof(outData) == "string" && outData == "TIMEOUT") {
            var logoutParams = new Array(1);
            logoutParams[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
            return
        }
        if (outData.toLowerCase().indexOf("|") == -1) {
            if (outData != "") {
                alert("" + outData + "")
            }
            return false
        }
        var inBufferArr = inpData.split("|");
        var outBufferArr = outData.split("|");
        var outDataArrLen = outBufferArr.length;
        var checkDoubleSel = "N";
        if (inBufferArr.length > outBufferArr.length) {
            alert("Input fields which needs to be populated are \nnot matching the return values");
            return false
        }
        var inputFld = null;
        var outFldValue = null;
        var i = 0;
        var errIndex = 0;
        for (i = 0; i < inBufferArr.length; i++) {
            inputFld = inBufferArr[i];
            outFldValue = outBufferArr[i];
            if (isEmptyObjValue(inputFld)) {
                continue
            }
            if (inputFld.substring(0, 4) == "sel1") {
                eval("obj." + inputFld.substring(4, inputFld.length) + '.value="' + outFldValue + '"');
                checkDoubleSel = "N"
            } else {
                if (inputFld.substring(0, 4) == "sel2") {
                    var tmpOutBufferArr = outFldValue + "/" + outBufferArr[i + 1];
                    eval("obj." + inputFld.substring(4, inputFld.length) + '.value="' + tmpOutBufferArr + '"');
                    checkDoubleSel = "Y"
                } else {
                    if (inputFld.substring(0, 3) != "chk") {
                        if (checkDoubleSel != "Y") {
                            if (inputFld.substring(0, 3) == "rdo") {
                                setRadioValue(inputFld.substring(3, inputFld.length), outFldValue)
                            } else {
                                eval("obj." + inputFld + '.value="' + outFldValue.replace(/"/gi, '\\"') + '"')
                            }
                        } else {
                            if (inputFld.substring(0, 3) == "rdo") {
                                setRadioValue(inputFld.substring(3, inputFld.length), outBufferArr[i + 1])
                            } else {
                                eval("obj." + inputFld + '.value="' + outBufferArr[i + 1] + '"')
                            }
                        }
                    } else {
                        if (outFldValue == "Y") {
                            eval("obj." + inputFld + ".checked=true")
                        }
                    }
                }
            }
        }
        if ((outDataArrLen - 1) > 0 && inBufferArr.length < outDataArrLen && !isEmptyObjValue(outBufferArr[outDataArrLen - 1])) {
            errIndex = outBufferArr[outDataArrLen - 1].indexOf(FETCH_ERR);
            if (errIndex != -1) {
                alert(outBufferArr[outDataArrLen - 1].substring(errIndex + FETCH_ERR_LEN));
                return false
            }
        }
    } else {
        var retValue = window.open(sUrl, "", "width=10px,height=10px,modal=yes,top=" + yOffset + "px,left=" + xOffset + "px,scrollbars=yes,toolbar=no,menubar=no,help=no");
        if (retValue != null && typeof(retValue) == "string" && retValue == "TIMEOUT") {
            var logoutParams = new Array(1);
            logoutParams[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
            return
        }
    }
    return true
}

function setRadioValue(obj, value) {
    var obj1 = document.forms[0];
    var isArray = (typeof(obj.length) == "undefined") ? false : true;
    if (value == "") {
        return
    }
    if (isArray && (typeof(obj.type) == "undefined")) {
        for (var i = 0; i < obj.length; i++) {
            if (eval("obj1." + obj + "[" + i + "].value") == value) {
                eval("obj1." + obj + "[" + i + "].checked = true");
                break
            }
        }
    }
    return
}
var cur_lyr;

function loadLyr(b) {
    if (cur_lyr) {
        var a = get_lyr_css(cur_lyr);
        if (a) {
            a.display = "none"
        }
    }
    cur_lyr = b;
    var a = get_lyr_css(cur_lyr);
    if (a) {
        a.display = "";
        a.zIndex = 1000
    }
}

function hideLyr(b) {
    if (cur_lyr) {
        var a = get_lyr_css(cur_lyr);
        if (a) {
            a.display = "none"
        }
    }
}

function disableHyperLnks(c) {
    var d = "sLnk";
    for (var b = 1; b <= parseInt(c + 1, 10); b++) {
        var a = d + b;
        hideImage(a)
    }
}

function fnValidateAndFormatAmt(c, b, d, e, a) {
    return (low_formatAmt(c, b, d, null, e, a))
}

function newformatAmt(c, b, d, e, a) {
    return (low_formatAmt(c, b, d, null, e, a))
}

function newformatunit(d, c, e, f, a, b) {
    return (low_formatUnit(d, c, e, null, f, a, b))
}

// Get reference
function get_lyr_css(id) {

    var lyr, lyrcss;
    lyr = document.getElementById(id);
    if (lyr) lyrcss = (lyr.style) ? lyr.style : lyr;
    return lyrcss;
}

//This function disables all the search icons having the id 'sLnk*'
function disableHyperLnks(count) {
    var lnkStr = "sLnk";

    for (var i = 1; i <= parseInt(count + 1, 10); i++) {
        var lnkStrId = lnkStr + i;
        hideImage(lnkStrId);
    }
}


function low_formatUnit(g, c, l, b, o, h, p) {
    var q = (o != "Y");
    var f = !fnIsNull(l);
    var m = !fnIsNull(b);
    var e = 0;
    var d = 0;
    g = (fnTrim(g)).toUpperCase();
    if (g != "MILLION" && g != "LAKH") {
        alert(finbranchResArr.get("FAT001374"));
        low_setAmtFldFocus(q, c, h);
        return false
    }
    var a = (q) ? c.value : c;
    a = fnTrim(a);
    if (fnIsNull(a)) {
        if (!q) {
            return c
        }
        return
    }
    a = removeMantissa(a);
    a = getAmtInStdFormat(a);
    if (!low_isValidUnit(a)) {
        low_setAmtFldFocus(q, c, h);
        return false
    }
    a = low_convertAmt(a);
    if (p == "Y") {
        b = "0";
        e = removeCommas(a);
        d = e.indexOf(DEF_DECIMAL_SEPARATOR);
        if (d != -1) {
            a = e.substring(0, d)
        }
    } else {
        b = "6"
    }
    if (q && !low_validateUnitWithPrec(a, c, b, p)) {
        low_setAmtFldFocus(q, c, h);
        return false
    }
    a = checkZeroes(a, b);
    if (g == "MILLION") {
        a = formatToMillion1(a, b)
    } else {
        a = formatToLakh1(a, b)
    }
    a = getAmtInCustomFormat(a);
    if (q) {
        c.value = a
    } else {
        document.write(a)
    }
    return true
}

function low_isValidUnit(unit) {
    var unitLen = unit.length;
    var lastChar = (unit.charAt(unitLen - 1)).toUpperCase();
    if (isNaN(lastChar) && lastChar != ".") {
        var str = unit.substring(0, unitLen - 1);
        if (isNaN(str)) {
            alert(finbranchResArr.get("FAT003921"));
            return false
        }
        var val = "";
        if (eval("this.custGetAmountCodeValue") != undefined) {
            val = custGetAmountCodeValue(lastChar)
        } else {
            val = getAmountCodeValue(lastChar)
        }
        if (val == undefined) {
            alert(finbranchResArr.get("FAT001374"));
            return false
        } else {
            return true
        }
    }
    if (isNaN(unit)) {
        alert(finbranchResArr.get("FAT003921"));
        return false
    }
    var regExp = /[Ee]/g;
    if (regExp.test(unit)) {
        alert(finbranchResArr.get("FAT003921"));
        return false
    }
    return true
}

function fnValidateAndFormatAmt(format, obj, crncy, prn, idx) {
    return (low_formatAmt(format, obj, crncy, null, prn, idx));
}

function newformatAmt(format, obj, crncy, prn, idx) {
    return (low_formatAmt(format, obj, crncy, null, prn, idx));
}

function getPrec(crncy) {
    var crncyPrec = 2;
    var defaultPrec = 2;
    if (fnIsNull(crncy)) {
        return crncyPrec
    }
    crncy = crncy.replace("'", "\\'");
    var prec = eval("precArray['" + crncy.toUpperCase() + "']");
    if (prec != undefined && prec != "") {
        return prec
    } else {
        return defaultPrec
    }
}

function checkAmtWithCrncy(d, c, b) {
    var f = c.value;
    var e = b.value;
    if (fnIsNull(e)) {
        alert(finbranchResArr.get("FAT000530"));
        if (!b.disabled) {
            b.focus()
        }
        return
    }
    var a = getPrec(e);
    formatAmountToMillionOrLakh(d, c, a, "N")
}

function checkZeroes(a, b) {
    var o = removeCommas(a);
    var q = "";
    var e = 0;
    var d = 0;
    var m = 0;
    var l = 0;
    m = o.indexOf(DEF_DECIMAL_SEPARATOR);
    if (m != -1) {
        e = o.substring(0, m);
        d = o.substring(m + 1)
    } else {
        e = o
    }
    for (m = 0; m < e.length; m++) {
        if (e.charAt(m) != "0") {
            break
        }
        l++
    }
    if (l == e.length) {
        e = "0"
    } else {
        e = e.substring(m)
    }
    if (parseFloat(d) == 0) {
        o = e
    } else {
        o = e + "." + d
    }
    m = o.indexOf(DEF_DECIMAL_SEPARATOR);
    if (m != -1) {
        e = o.substring(0, m);
        d = o.substring(m + 1)
    } else {
        return o
    }
    var g = d.length;
    if (g > b) {
        var h = "0";
        var c = h;
        var p = g - b;
        var r = true;
        for (var f = g; f > b; f--) {
            c = d.charAt(f - 1);
            if (c != h) {
                r = false;
                break
            }
        }
        if (r) {
            if (b == 0) {
                q = e
            } else {
                q = o.slice(0, -(p))
            }
        }
    }
    if (q != "") {
        return q
    }
    return o
}

function submitFromAddrTypeErr(b, a, d) {
    if (fnValidateForm()) {
        var c = document.forms[0];
        c.submitform.value = "addrType";
        c.addrType.value = a;
        c.FocusField.value = d;
        c.submit()
    }
}

function fnIsLeapYear(b) {
    var a = Number(b);
    return ((((a % 4) == 0) && ((a % 100) == 0)) || ((a % 400) == 0))
}

function fnAddYearsToDate(e, d) {
    var g = d.split("-");
    var a = g[0];
    var f = g[1];
    var c = g[2];
    var b = fnIsLeapYear(c);
    c = Number(c) + Number(e);
    if ((b) && (!fnIsLeapYear(c)) && (Number(f) == 2) && (Number(a) > 28)) {
        a = 28
    }
    return a + "-" + f + "-" + c
}

function fnRemoveCrncy(b) {
    var a = b.indexOf("|");
    if (a != -1) {
        return b.substring(0, a)
    } else {
        return b
    }
}

function writeHeader(screenName) {
    with(document) {
        write('<input type="hidden" name="actionCode" id="actionCode">');
        write('<input type="hidden" name="tabName">');
        write('<input type="hidden" name="callMode"   id="callMode"  value="E">');
        write('<input type="hidden" name="screenName" value="' + screenName + '">');
        write('<input type="hidden" name="expldQryStr" id="expldQryStr">');
        write('<input type="hidden" name="reqId" id="reqId" value="' + reqId + '">');
        write('<input type="hidden" name="rtId" id="rtId" value="">');
    }
    document.forms[0].rtId.value = rtId;
}

function arjspmorphFooter() {
    with(document) {
        write('<input type="hidden" name="rtId" id="rtId" value="">');
        write('<input type="hidden" name="reqId" id="reqId" value="">')
    }
    document.forms[0].rtId.value = rtId;
    document.forms[0].reqId.value = reqId
}

function invokeFAB(finAvlFlg, ctrlArr, menuName, params, protName) {
    var ctrlName = ctrlArr[4];
    var arr = strBaseRef.split("//");
    if (fnIsNull(fabBaseUrl)) {
        fabBaseUrl = strBaseRef;
        return;
    }

    if (fnIsNull(ctrlName) || fnIsNull(menuName)) {
        alert(finbranchResArr.get("FAT000484"));
    }

    var fabUrl = getFABUrl(ctrlArr, menuName, protName);

    if (params != undefined && !fnIsNull(params)) {
        fabUrl += "&" + params;
    }

    var inputParam = new Array(1);
    inputParam[0] = fabUrl;
    document.location.href = fabUrl;
}

function showCancelWaitScr() {
    try {
        disableTimers();
        disableMTreeTimer();
        window.scroll(0, 0);
        window.document.body.scroll = "NO";
        var b = get_lyr_css("cancelwait_div");
        var c = null;
        var a = (b.visibility == "visible");
        if (a) {
            c = get_lyr_css("cancelwait");
            if (c) {
                c.display = ""
            }
        } else {
            b.top = "0px";
            b.left = "0px";
            b.height = "690px";
            b.width = "1020px";
            b.visibility = "visible";
            var f = "cancelwait";
            c = document.getElementById(f);
            if (c) {
                c.src = "../arjspmorph/" + applangcode + "/cancelwait.jsp"
            }
        }
    } catch (d) {
        throw d
    }
}

function hideCancelWaitScr() {
    try {
        window.document.body.scroll = "YES";
        var a = get_lyr_css("cancelwait_div");
        a.top = "0px";
        a.left = "0px";
        a.height = "0px";
        a.width = "0px";
        a.visibility = "hidden";
        var c = "cancelwait";
        cwLyr = document.getElementById(c);
        if (cwLyr) {
            cwLyr.src = "../arjspmorph/" + applangcode + "/cancelwait.jsp?stopTimer=Y"
        }
        enableTimers();
        prevEventDate = new Date();
        enableMTreeTimer()
    } catch (b) {
        throw b
    }
}

function addRow(d) {
    var g = d[0];
    var e = d[1];
    var l = "";
    var h = "[" + g + "]";
    var a = "";
    if (e == "Y") {
        l = 'class="searclist1arow"'
    } else {
        if (g % 2 == 0) {
            l = 'class="searclist1"'
        } else {
            l = 'class="searclist2"'
        }
    }
    document.write("<tr " + l + " >");
    for (iInputs = 0; iInputs < inputs.length; iInputs++) {
        document.write('<td class="ctext_small" align="' + inputs[iInputs][1] + '">');
        if (inputs[iInputs][0] == "checkbox") {
            if (d[iInputs + 2] == "Y") {
                a = " checked "
            }
            document.write('<input type="checkbox" id=""chkBox' + h + '" name="chkBox' + h + '" disabled ' + a + "> </td>")
        } else {
            if (inputs[iInputs][0] == "radio") {
                if (d[iInputs + 2] == "Y") {
                    a = " checked "
                }
                document.write('<input type="radio" id="rad' + h + '" name="rad' + h + '" disabled ' + a + "> </td>")
            } else {
                if (inputs[iInputs][2] != null && inputs[iInputs][2] == "amt") {
                    var f = "";
                    var b = "";
                    var c = d[iInputs + 2].indexOf("|");
                    if (c != -1) {
                        f = d[iInputs + 2].substring(0, c);
                        b = d[iInputs + 2].substring(c + 1)
                    }
                    newformatAmt(amtFormat, f, b, "Y");
                    document.write("&nbsp; </td>")
                } else {
                    if (inputs[iInputs][2] != null && inputs[iInputs][2] == "date") {
                        document.write(jsUtil.encodeChar(fnConvertToUIDate(d[iInputs + 2])) + "&nbsp;</td>")
                    } else {
                        document.write(jsUtil.encodeChar(d[iInputs + 2]) + "&nbsp; </td>")
                    }
                }
            }
        }
        a = ""
    }
    document.write("</tr>")
}

function addDayMonthsToDate(a, b, o, d) {
    var c;
    if (fnIsNull(a.value) || !fnIsValidDate(a)) {
        d.value = "";
        return false
    }
    c = a.value;
    var f = a.getAttribute("mnebl");
    if ((null != f) && (f) && isValidDateMneumonic(c)) {
        return true
    }
    var g = c.split("-");
    var e = parseFloat(g[0]);
    var l = parseFloat(g[1]);
    var m = parseFloat(g[2]);
    if (!fnIsNull(b) && fnIsPositiveNumber(b)) {
        l = l + parseInt(b, 10)
    }
    if (!fnIsNull(o) && fnIsPositiveNumber(o)) {
        e = e + parseInt(o, 10)
    }
    var h = new Date();
    h.setFullYear(m, --l, e);
    e = h.getDate();
    l = h.getMonth() + 1;
    m = h.getFullYear();
    e = e < 10 ? "0" + e : e;
    l = l < 10 ? "0" + l : l;
    d.value = e + "-" + l + "-" + m
}

function fnDisableFormDataControls(b, f, d) {
    ADD = "A";
    COPY = "C";
    MODIFY = "M";
    VERIFY = "V";
    INQUIRY = "I";
    DELETE = "D";
    UNDELETE = "U";
    CANCEL = "X";
    REVERSAL = "E";
    CLOSE = "O";
    if (b == VERIFY || b == INQUIRY || b == DELETE || b == UNDELETE || b == CANCEL || b == REVERSAL || b == CLOSE) {
        var c = f.elements;
        var a = c.length;
        var e = arguments.length;
        if (Number(d) > 0) {
            disableHyperLnks(Number(d))
        } else {
            if (Number(d) == 0) {
                hideAnchors()
            }
        }
        for (i = 0; i < a; i++) {
            if ((c[i].type == "text") || (c[i].type == "textarea")) {
                c[i].readOnly = true;
                if (c[i].getAttribute("hotKeyId") == "LowLimit") {
                    c[i].readOnly = false
                }
            } else {
                if (c[i].type == "select-one") {
                    c[i].disabled = true
                } else {
                    if (c[i].type == "checkbox") {
                        c[i].disabled = true;
                        c[i].setAttribute("fds", "Y")
                    } else {
                        if (c[i].type == "radio") {
                            c[i].disabled = true
                        }
                    }
                }
            }
            if (f.menuName != null && f.menuName != undefined) {
                f.menuName.readOnly = false
            }
        }
        if ((f.Validate != undefined) && (f.Validate != null)) {
            f.Validate.disabled = true
        }
        if ((f.Cancel != undefined) && (f.Cancel != null)) {
            f.Cancel.disabled = true
        }
    }
    if (b != ADD && b != MODIFY && b != COPY) {
        if ((f.AddNew != undefined) && (f.AddNew != null)) {
            f.AddNew.disabled = true
        }
        if ((f.AddNewPage != undefined) && (f.AddNewPage != null)) {
            f.AddNewPage.disabled = true
        }
    }
}

function fnEnableFormDataControls(d) {
    var b = d.elements;
    var a = b.length;
    var c = arguments.length;
    for (i = 0; i < a; i++) {
        if (b[i].type == "select-one") {
            b[i].disabled = false
        } else {
            if (b[i].type == "checkbox" || b[i].type == "radio") {
                b[i].disabled = false
            }
        }
    }
    if ((d.Clear != undefined) && (d.Clear != null)) {
        d.Clear.disabled = false
    }
}

function fnLpad(c, a) {
    var b = "";
    for (i = 0; i < (a - c.length); i++) {
        b = b + "0"
    }
    b = b + c;
    return b
}

function fnRpad(c, a) {
    var b = c.length;
    for (i = 0; i < (a - b); i++) {
        c = c + "0"
    }
    return c
}

function fnAddAmount(m, h) {
    m = getAmtInStdFormat(m);
    h = getAmtInStdFormat(h);
    var a = "0";
    var y = "0";
    var u = "0";
    var s = "0";
    var q = "0";
    var w = 0;
    var v = 0;
    var d = 0;
    var g = 0;
    var f = 0;
    var r = 0;
    var t = 0;
    var p = 0;
    var c = removeCommas(m);
    var b = removeCommas(h);
    w = c.indexOf(DEF_DECIMAL_SEPARATOR);
    v = b.indexOf(DEF_DECIMAL_SEPARATOR);
    if (w == -1) {
        a = c;
        u = "N"
    } else {
        a = c.substring(0, w);
        u = c.substring(w + 1)
    }
    if (v == -1) {
        y = b;
        s = "N"
    } else {
        y = b.substring(0, v);
        s = b.substring(v + 1)
    }
    g = (a.length > y.length) ? a.length : y.length;
    if (u != "N" || s != "N") {
        f = (u.length > s.length) ? u.length : s.length;
        if (isNaN(u)) {
            u = "0"
        }
        if (isNaN(s)) {
            s = "0"
        }
    } else {
        u = "0";
        s = "0"
    }
    a = fnLpad(a, g);
    y = fnLpad(y, g);
    u = fnRpad(u, f);
    s = fnRpad(s, f);
    var x = new Array();
    r = parseInt(u, 10) + parseInt(s, 10);
    q = (r) % (Math.pow(10, f));
    q = q + "";
    q = fnLpad(q, f);
    p = (r / (Math.pow(10, f))) >= 1 ? 1 : 0;
    for (d = g - 1; d >= 0; d--) {
        t = parseInt(a.charAt(d), 10) + parseInt(y.charAt(d), 10) + p;
        x[d + 1] = t % 10;
        p = t > 9 ? 1 : 0
    }
    x[0] = (p == 1) ? p : "";
    var l = 0;
    var o = x.length;
    var e = "";
    for (l = 0; l < o; l++) {
        e = e + x[l]
    }
    if (f != 0) {
        e = e + "." + q
    }
    return e
}

function fnSubtractAmt(b, a) {
    b = getAmtInStdFormat(b);
    a = getAmtInStdFormat(a);
    return low_fnSubtractAmt(b, a)
}

function low_fnSubtractAmt(s, r) {
    var a = "0";
    var z = "0";
    var w = "0";
    var v = "0";
    var u = "0";
    var y = 0;
    var x = 0;
    var g = 0;
    var q = 0;
    var m = 0;
    var b = 0;
    var c = 0;
    var t = 0;
    var d = false;
    var p = false;
    var f = removeCommas(s);
    var e = removeCommas(r);
    var h = "";
    y = f.indexOf(DEF_DECIMAL_SEPARATOR);
    x = e.indexOf(DEF_DECIMAL_SEPARATOR);
    if (y == -1) {
        a = f
    } else {
        a = f.substring(0, y);
        w = f.substring(y + 1)
    }
    if (x == -1) {
        z = e
    } else {
        z = e.substring(0, x);
        v = e.substring(x + 1)
    }
    q = (a.length > z.length) ? a.length : z.length;
    m = (w.length > v.length) ? w.length : v.length;
    a = fnLpad(a, q);
    z = fnLpad(z, q);
    w = fnRpad(w, m);
    v = fnRpad(v, m);
    if (parseInt(z, 10) > parseInt(a, 10)) {
        var o = a;
        var l = w;
        a = z;
        z = o;
        w = v;
        v = l;
        p = true
    } else {
        if (parseInt(a, 10) == parseInt(z, 10)) {
            if (parseInt(v, 10) > parseInt(w, 10)) {
                var l = w;
                w = v;
                v = l;
                p = true
            }
        }
    }
    b = parseInt(w, 10) - parseInt(v, 10);
    if (b < 0) {
        u = Math.pow(10, m) + b;
        d = true
    } else {
        u = b
    }
    u = u + "";
    u = fnLpad(u, m);
    c = parseInt(a, 10) - parseInt(z, 10);
    if (d) {
        c -= 1
    }
    h = c + "." + u;
    if (p) {
        h = "-" + h
    }
    return h
}

//This function disables all the tabs
function disableTabs() {
    var sTabcss = get_lyr_css('sTab');
    var hTabcss = get_lyr_css('hTab');

    if ((hTabcss != undefined && hTabcss != null) && (sTabcss != undefined && sTabcss != null)) {
        hTabcss.cssText = "position:absolute; visibility:visible;"
        sTabcss.cssText = "position:absolute; visibility:hidden;"
    }
}

function showCookies() {
    var d = screen.width,
        b = screen.height;
    var a = (d - 360),
        c = (b - 205);
	alert(gfkmCookie);
    if (gfkmCookie != null && gfkmCookie != "") {
        window.open("../arjspmorph/showCookies.jsp?rtId=" + rtId + "&cookie=" + gfkmCookie + "&isPopUp=Y", "msgWin", "status=yes,width=300,height=150,left=" + a + ",top=" + c + "")
    }
}

function setObjAndDescValuesForIE(d, c, a) {
    if (window.showModalDialog) {
        if (d != null && d != undefined) {
            var b = d.split("|");
            c.value = b[0];
            if (a != null) {
                a.value = b[1]
            }
        }
    }
}

function fnSetFocusOnFirstField(c) {
    if (c != null || undefined) {
        c.focus();
        return
    }
    var b = document.forms[0].elements;
    var a = b.length;
    for (i = 0; i < a; i++) {
        if ((b[i].type == "text") || (b[i].type == "textarea")) {
            if (b[i].readOnly == false && b[i].disabled == false) {
                if ((b[i].name != "menuName") && (-1 == (b[i].name.search("_LowLimit")))) {
                    b[i].focus();
                    break
                }
            }
        }
        if ((b[i].type == "select-one") || (b[i].type == "checkbox")) {
            if (b[i].disabled == false) {
                b[i].focus();
                break
            }
        }
    }
}

function getRadioValue(c) {
    var a = (typeof(c.length) == "undefined") ? false : true;
    if (!a) {
        return c.value
    }
    var d = "";
    if (a && (typeof(c.type) == "undefined")) {
        for (var b = 0; b < c.length; b++) {
            if (c[b].checked) {
                d = c[b].value;
                break
            }
        }
    }
    return d
}

function getRadioObj(c) {
    var a = (typeof(c.length) == "undefined") ? false : true;
    if (!a) {
        return c.value
    }
    var d = "";
    if (a && (typeof(c.type) == "undefined")) {
        for (var b = 0; b < c.length; b++) {
            if (c[b].checked) {
                d = c[b];
                break
            }
        }
    }
    return d
}

function showTemplateIdList(a) {
    if (!window.showModalDialog) {
        opFieldsArr = [];
        opFieldsArr[0] = arguments[1];
        opFieldsArr[1] = arguments[2]
    }
    var b = popModalWindow(a, "TemplateIdList");
    if (window.showModalDialog) {
        if (null != b) {
            var c = b.split("|");
            arguments[1].value = c[0];
            arguments[2].value = c[1]
        }
    }
}

function fnSetCheckboxFld(objChkCtrl) {
    var objChkCtrlId = objChkCtrl.id;
    var objChkFld = eval("document.forms[0]." + objChkCtrlId.substring(3));
    if (objChkCtrl.checked) {
        objChkFld.value = "Y"
    } else {
        objChkFld.value = "N"
    }
}

function fnSetCheckboxCtrl(objForm) {
    var objChkCtrl = null;
    var objChkCtrlId = "";
    var objChkFldCtr = null;
    var objChkFldVal = "";
    var iCtr = 0;
    for (iCtr = 0; iCtr < objForm.elements.length; iCtr++) {
        if (objForm.elements[iCtr].type == "checkbox") {
            objChkCtrl = objForm.elements[iCtr];
            objChkCtrlId = objChkCtrl.id;
            objChkFldCtr = eval("objForm." + objChkCtrlId.substring(3));
            if ((objChkFldCtr != null && objChkFldCtr != undefined)) {
                objChkFldVal = objChkFldCtr.value;
                if (objChkFldVal == "Y") {
                    objChkCtrl.checked = true
                } else {
                    objChkCtrl.checked = false;
                    objChkFldCtr.value = "N"
                }
            }
        }
    }
}

function fnIsValidTime(b) {
    var e = /[^0-9:]/g;
    if (fnIsNull(b)) {
        return true
    }
    if (e.test(b)) {
        return false
    }
    if (b.length != 8) {
        return false
    }
    var g = b.substr(0, 2);
    var a = b.substr(3, 2);
    var f = b.substr(6, 2);
    if (isNaN(g) || isNaN(a) || isNaN(f)) {
        return false
    }
    var d = Number(g);
    var h = Number(a);
    var c = Number(f);
    if (d < 0 || d > 23 || h < 0 || h > 59 || c < 0 || c > 59) {
        return false
    }
    return true
}

function fnDisableFormControls(m, c, p) {
    var b = "A";
    var q = "C";
    var g = "M";
    var f = "V";
    var h = "I";
    var e = "D";
    var o = "U";
    var d = "X";
    if (m == f || m == h || m == e || m == o || m == d) {
        var a = c.elements;
        var l = a.length;
        if (Number(p) > 0) {
            disableHyperLnks(Number(p))
        }
        for (i = 0; i < l; i++) {
            if ((a[i].type == "text") || (a[i].type == "textarea")) {
                a[i].readOnly = true;
                if (a[i].getAttribute("hotKeyId") == "LowLimit") {
                    a[i].readOnly = false
                }
            } else {
                if (a[i].type == "select-one") {
                    a[i].disabled = true
                } else {
                    if (a[i].type == "checkbox" || a[i].type == "radio") {
                        a[i].disabled = true;
                        a[i].setAttribute("fds", "Y")
                    }
                }
            }
            if (c.menuName != undefined) {
                c.menuName.readOnly = false
            }
        }
        if ((c.Validate != undefined) && (c.Validate != null)) {
            c.Validate.disabled = true
        }
        if ((c.Clear != undefined) && (c.Clear != null)) {
            c.Clear.disabled = true
        }
    }
    if (m == h) {
        if ((c.Submit != undefined) && (c.Submit != null)) {
            c.Submit.disabled = true
        }
    }
    if (m != b && m != g && m != q) {
        if ((c.AddNew != undefined) && (c.AddNew != null)) {
            c.AddNew.disabled = true
        }
        if ((c.AddNewPage != undefined) && (c.AddNewPage != null)) {
            c.AddNewPage.disabled = true
        }
    }
}

function checkRadio(c, d) {
    var a = (typeof(c.length) == "undefined") ? false : true;
    if (!a) {
        if (c.value == d) {
            c.checked = true;
            return
        }
    }
    if (a && (typeof(c.type) == "undefined")) {
        for (var b = 0; b < c.length; b++) {
            if (c[b].value == d) {
                c[b].checked = true;
                break
            }
        }
    }
    return
}

function fnShowCancelDialog(h) {
    var d = "V";
    var g = "I";
    var b = "D";
    var l = "U";
    var c = "X";
    var f = "P";
    var a = "R";
    var e = "G";
    if (h == d || h == g || h == b || h == l || h == c || h == f || h == a || h == e) {
        document.forms[0].submitform.value = "Cancel";
        document.forms[0].submit()
    } else {
        if (confirm(finbranchResArr.get("FAT000925"))) {
            document.forms[0].submitform.value = "Cancel";
            document.forms[0].submit()
        }
    }
}

function submitFormError(b) {
    var a = document.forms[0];
    a.submitform.value = b;
    convertToCaps();
    disableButtons();
    a.submit()
}

function fnToggleCheckbox(chkObj) {
    var chkObjId = chkObj.id;
    var hdnFldObj = eval("document.forms[0]." + chkObjId.substring(3));
    if (chkObj.checked) {
        hdnFldObj.value = "Y"
    } else {
        hdnFldObj.value = "N"
    }
}

function fnEnableAllParentFormControls(e) {
    var a = window.opener.document.forms[0].elements.length;
    var g = window.opener.document.forms[0];
    if (Number(e) > 0) {
        var f = "sLnk";
        var b = parseInt(e, 10);
        for (var d = 1; d <= b; d++) {
            var c = f + d;
            fnEnableLink(c)
        }
    }
    for (var d = 0; d < a; d++) {
        if (g.elements[d].type == "button") {
            g.elements[d].disabled = false
        }
    }
}

function fnDisableAllParentFormControls(e) {
    var a = window.opener.document.forms[0].elements.length;
    var g = window.opener.document.forms[0];
    if (Number(e) > 0) {
        var f = "sLnk";
        var b = parseInt(e, 10);
        for (var d = 1; d <= b; d++) {
            var c = f + d;
            fnDisableLink(c)
        }
    }
    for (var d = 0; d < a; d++) {
        if (g.elements[d].type == "button") {
            g.elements[d].disabled = true
        }
    }
}

function get_parent_lyr_css(c) {
    var a, b;
    a = window.opener.document.getElementById(c);
    if (a) {
        b = (a.style) ? a.style : a
    }
    return b
}

function fnEnableLink(b) {
    var a = get_parent_lyr_css(b);
    if (a) {
        a.display = "";
        a.zIndex = 1000
    }
}

function fnDisableLink(b) {
    var a = get_parent_lyr_css(b);
    if (a) {
        a.visibility = "hidden";
        a.zIndex = 1000
    }
}

function fnTmplBack(a) {
    if (("A" == a) || ("C" == a) || ("F" == a) || ("M" == a)) {
        if (!confirm(finbranchResArr.get("FAT000925"))) {
            return false
        }
    }
    return true
}

function fnTmplDelete() {
    if (!confirm(finbranchResArr.get("FAT000357"))) {
        return false
    }
    return true
}

function fnGetFuncCodeDesc(a) {
    switch (a) {
        case "A":
            return finbranchResArr.get("FAT002242");
        case "M":
            return finbranchResArr.get("FAT002243");
        case "C":
            return finbranchResArr.get("FAT002244");
        case "D":
            return finbranchResArr.get("FAT001505");
        case "F":
        case "I":
            return finbranchResArr.get("FAT000826");
        case "U":
            return finbranchResArr.get("FAT002245");
        case "X":
            return finbranchResArr.get("FAT001423");
        case "V":
            return finbranchResArr.get("FAT001731");
        case "P":
            return finbranchResArr.get("FAT002246");
        case "T":
            return finbranchResArr.get("FAT002247");
        case "E":
            return finbranchResArr.get("FAT002485");
        case "W":
            return finbranchResArr.get("FAT004795");
        case "O":
            return finbranchResArr.get("FAT000773");
        default:
            return a
    }
}

function getApplFlagDesc(a, b) {
    switch (a) {
        case "O":
            return finbranchResArr.get("FAT003851");
        case "S":
            return finbranchResArr.get("FAT003852");
        case "B":
            return finbranchResArr.get("FAT003853");
        default:
            return b
    }
}

function fnGetFuncCodeCodeAndDesc(a) {
    switch (a) {
        case "A":
            return finbranchResArr.get("FAT002565");
        case "M":
            return finbranchResArr.get("FAT002564");
        case "C":
            return finbranchResArr.get("FAT002566");
        case "D":
            return finbranchResArr.get("FAT002567");
        case "F":
        case "I":
            return finbranchResArr.get("FAT002568");
        case "U":
            return finbranchResArr.get("FAT002569");
        case "X":
            return finbranchResArr.get("FAT002570");
        case "V":
            return finbranchResArr.get("FAT002571");
        case "P":
            return finbranchResArr.get("FAT002572");
        case "T":
            return finbranchResArr.get("FAT002573");
        case "E":
            return finbranchResArr.get("FAT002574");
        default:
            return a
    }
}

function MnemonicsClass(a, b) {
    this.mnemonicsList = a;
    this.mnemonicsDesc = b
}

function getMnemonics() {
    var b = new Array("$BOD$", "$BOD-1$", "$BOD+1$", "$MEND$", "$QEND$", "$HEND$", "$YEND$");
    var c = new Array("Begin of Day", "Date Previous to Begin Of Day", "Date Next To Begin Of Day", "Month End", "Quarter End", "Half Year End", "Year End");
    var a = c.length;
    var e = new Array(a);
    for (var d = 0; d < a; d++) {
        e[d] = new MnemonicsClass(b[d], c[d])
    }
    return e
}

function showMnemonics(a) {
    if (!window.showModalDialog) {
        dateObj_tmp = a;
        genericCallBackFn = "showMnemonics_callback"
    }
    var b = popModalWindowVar("../arjspmorph/" + applangcode + "/get_mnemonics_list.jsp?wReturn=" + a.id, "Mnemonics List", 400, 200, 50, 30);
    if (window.showModalDialog) {
        if (null != b) {
            a.value = b
        }
        fnAssignDateOnEnter(a)
    }
}

function showMnemonics_callback(a) {
    if (null != a) {
        dateObj_tmp.value = a
    }
    fnAssignDateOnEnter(dateObj_tmp)
}

function bjsMnemonicsClass(b, a) {
    this.bjsMnemonicsList = b;
    this.bjsMnemonicsDesc = a
}

function getBjsMnemonics() {
    var e = new Array("$BOM$", "$EOM$", "$BOLM$", "$EOLM$");
    var b = new Array("Begin of Month", "End of Month", "Begin of Last Month", "End of Last Month");
    var a = b.length;
    var d = new Array(a);
    for (var c = 0; c < a; c++) {
        d[c] = new bjsMnemonicsClass(e[c], b[c])
    }
    return d
}

function showBjsMnemonics(a) {
    if (!window.showModalDialog) {
        dateObj_tmp = a;
        genericCallBackFn = "showBjsMnemonics_callback"
    }
    var b = popModalWindowVar("../arjspmorph/" + applangcode + "/bjsmnemonicslist.jsp?wReturn=" + a.id, "BJS Mnemonics List", 400, 200, 50, 30);
    if (window.showModalDialog) {
        if (null != b) {
            a.value = b
        }
        fnAssignDateOnEnter(a)
    }
}

function showBjsMnemonics_callback(a) {
    if (null != a) {
        dateObji_tmp.value = a
    }
    fnAssignDateOnEnter(dateObj_tmp)
}

function isValidDateMneumonic(b) {
    var d = getMnemonics();
    var a = d.length;
    for (var c = 0; c < a; c++) {
        if (d[c].mnemonicsList == b) {
            return true
        }
    }
    return false
}

function isValidBjsDateMneumonic(b) {
    var d = getBjsMnemonics();
    var a = d.length;
    for (var c = 0; c < a; c++) {
        if (d[c].bjsMnemonicsList == b) {
            return true
        }
    }
    return false
}

function disableMnicsHyperLnks(c) {
    var d = "msLnk";
    for (var b = 1; b <= parseInt(c + 1, 10); b++) {
        var a = d + b;
        loadLyr(a)
    }
}

/*function fnBack() {
    if (noConfirm || confirm(finbranchResArr.get("FAT000925"))) {
        document.forms[0].submitform.value = "Back";
        document.forms[0].submit()
    }
}*/

function getCrncyFromAmt(b) {
    var a = b.indexOf("|");
    if (a != -1) {
        return b.substring(a + 1)
    } else {
        return ""
    }
}

function isMneblAndValidMnem(a) {
    if ((a.getAttribute("mnebl") && isValidDateMneumonic(a.value))) {
        return true
    }
    return false
}

function fnIsNullOrUndefined(a) {
    if ((a == null) || (a == undefined)) {
        return true
    } else {
        return false
    }
}

function fnAppendOption(c, b, a) {
    if (fnIsNullOrUndefined(c) || fnIsNullOrUndefined(b) || fnIsNullOrUndefined(a) || (-1 != getOptionIndex(c, a))) {
        return false
    } else {
        c.options[c.options.length] = new Option(b, a);
        return true
    }
}

function fnRemoveOption(c, a) {
    var b = getOptionIndex(c, a);
    if (b != -1) {
        c.options[b] = null;
        return true
    }
    return false
}

function getOptionIndex(c, b) {
    if (fnIsNullOrUndefined(c)) {
        return -2
    }
    for (var a = 0; a < c.options.length; a++) {
        if (c.options[a].value == b) {
            return a
        }
    }
    return -1
}

function fnValidateTextArea(b, a) {
    if (b.value.length > a) {
        alert(finbranchResArr.get("FAT004428") + " " + finbranchResArr.get("FAT000532") + " " + a);
        b.focus();
        return false
    }
    return true
}

function fnValidateIPAddresses() {
    var objIPAddress = null;
    for (var i = 0; i < arguments.length; i++) {
        objIPAddress = eval(arguments[i]);
        if ((objIPAddress.value != "") && (false == fnIsValidIPAddress(objIPAddress.value))) {
            objIPAddress.focus();
            alert(finbranchResArr.get("FAT000394"));
            return false
        }
    }
    return true
}

function fnIsValidIPAddress(f) {
    var e = ".";
    var d = 4;
    var h = 0;
    var g = 255;
    var b = /[^0-9.]/g;
    if (b.test(f)) {
        return false
    }
    if (f.indexOf(e) == -1) {
        return false
    }
    var a = f.split(e);
    if (a.length != d) {
        return false
    }
    for (var c = 0; c < d; c++) {
        if (isNaN(a[c])) {
            return false
        }
        if ((Number(a[c]) < h) || (Number(a[c]) > g)) {
            return false
        }
    }
    return true
}

function validateCrncy(e, b, d, a) {
    if (fnIsNull(b.value)) {
        return
    }
    var f = "";
    var c = "";
    if (d != null) {
        f = d.id
    }
    if (a != null) {
        c = a.id;
        a.value = "N"
    }
    sendDataToServer(e, "CRNCY", "F", b.id, f + "|" + c)
}

function validateSol(e, d, c, a) {
    if (fnIsNull(d.value)) {
        return
    }
    var f = "";
    var b = "";
    if (c != null) {
        f = c.id
    }
    if (a != null) {
        b = a.id;
        a.value = "N"
    }
    sendDataToServer(e, "SOLID", "F", d.id, f + "|" + b)
}

function fnEnableDisableRadioButtons(c, d) {
    var a = (typeof(c.length) == "undefined") ? false : true;
    if (!a) {
        if (d == "D") {
            c.disabled = true;
            return
        } else {
            c.disabled = false;
            return
        }
    }
    if (a && (typeof(c.type) == "undefined")) {
        for (var b = 0; b < c.length; b++) {
            if (d == "D") {
                c[b].disabled = true
            } else {
                c[b].disabled = false
            }
        }
    }
    return
}

function isNavigationRequired(a, b, c, d) {
    b = parseInt(b, 10);
    c = parseInt(c, 10);
    if ((a == "prev" && b == 0) || (a == "next" && (b + 1 >= c))) {
        alert(finbranchResArr.get("FAT000426"));
        if ((d != null) && (d != undefined)) {
            d.focus()
        }
        return false
    }
    return true
}

function disableFormElements(e) {
    var f = document.forms[0].elements;
    var d = f.length;
    var c = "";
    disableHyperLnks(e);
    for (var a = 0; a < d; a++) {
        c = f[a].type;
        if (c == "checkbox" || c == "radio" || c == "select-one") {
            f[a].disabled = true
        } else {
            if (c == "text") {
                f[a].disabled = true;
                if (f[a].getAttribute("hotKeyId") == "LowLimit") {
                    f[a].disabled = false
                }
            }
        }
    }
    var b = document.forms[0].menuName;
    if (b != null && b != undefined) {
        b.disabled = false
    }
}

function enableFormElements() {
    var frmElem = document.forms[0].elements;
    var totElem = frmElem.length;
    var type = "";

    for (var i = 0; i < totElem; i++) {
        type = frmElem[i].type;
        if (type == 'checkbox' || type == 'radio' || type == 'select-one') {
            frmElem[i].disabled = false;
        } else if (type == 'text' || type == 'textarea') {
            frmElem[i].disabled = false;
        }
    }
}


function showImage(a) {
    var b = get_lyr_css(a);
    if (b) {
        b.display = "";
        b.zIndex = 1000
    }
}

function hideImage(ancId) {
    var curcss = get_lyr_css(ancId);
    if (curcss) curcss.display = "none";
}

function showCrncyConverter() {
    var bUrl = getBaseUrl();
    popModalWindow(bUrl + finContextPath + "/arjspmorph/" + applangcode + "/crncyconv.jsp", "crncyconv");
}

function validateDate(a) {
    if (!(fnIsValidDate(a))) {
        if (calbase == "00") {
            if (aFlag == "Y") {
                alert(finbranchResArr.get("FAT002593"))
            }
            fnSetFocusForDate(a);
            return false
        }
        if (calbase == "01") {
            if (aFlag == "Y") {
                alert(finbranchResArr.get("FAT002594"))
            }
            fnSetFocusForDate(a);
            return false
        }
    }
    return true
}

function showVerfyPendList(a, e, m, v, r, d, b, g, h, c) {
    var p = "";
    var l = "";
    var q = "";
    var s = "";
    var o = "B";
    var f = "";
    if (d != "") {
        o = d
    }
    if (e == null || e == undefined) {
        e = ""
    }
    if (b != "") {
        l = b.id
    }
    if (g != "") {
        q = g.id
    }
    if (h != "") {
        s = h.id
    }
    if (!fnIsNull(c)) {
        f = c.value
    }
    p = "../arjspmorph/" + applangcode + "/get_pend_verify_list.jsp?wReturn1=" + l + "&wReturn2=" + q + "&wReturn3=" + s + "&tableName=" + a + "&funcCode=" + e + "&preceedence=" + o + "&mode=" + m + "&schmType=" + v + "&listType=" + r + "&adtadnlparams=" + f;
    if (!window.showModalDialog) {
        opFieldsArr = [];
        opFieldsArr[0] = b;
        opFieldsArr[1] = g;
        opFieldsArr[2] = h
    }
    var u = popModalWindow(p, "VerfyPendList");
    if (window.showModalDialog) {
        if (u != null && u != undefined) {
            var t = u.split("|");
            b.value = t[0];
            if (g != "") {
                g.value = t[1]
            }
            if (h != "") {
                h.value = t[2]
            }
        }
    }
}

function chkSpace(b) {
    var a = /[ ]/;
    b = fnTrim(b);
    if (a.test(b)) {
        alert(finbranchResArr.get("FAT000483"));
        return false
    }
    return true
}

function fnValidateSpecialChars(a) {
    var b = /[^0-9]/;
    if (b.test(a.value)) {
        alert(finbranchResArr.get("FAT000485"));
        a.focus();
        return false
    }
    return true
}

function fnShowTCCharges(c, b) {
    var a = openModalWindow(c, b);
    if (null != a || b.value != "") {
        document.forms[0].ChargeFlag.value = "False"
    }
}

function SetVisitFlg(b, a) {
    if ((!fnIsNull(b.value))) {
        a.value = "False"
    }
}

function fnCheckNegativeAmt(b) {
    var a = getAmtInStdFormat(b.value);
    if (parseFloat(a) < 0) {
        alert(finbranchResArr.get("FAT000223"));
        b.focus();
        return false
    }
    return true
}

function showAcctDtls(b) {
    if (fnIsNull(b.value)) {
        alert(finbranchResArr.get("FAT000200"));
        b.focus();
        return
    }
    var a = "../arjspmorph/" + applangcode + "/acctdtls.jsp?acctId=" + b.value + "&isAcctDtlsAvbl=N";
    popModalWindow(a, "Acct Details")
}

function PRINTDATEFLD(objName, grpNameReqd, linkNum, literalDesc, isMandatoryFlg, isReadOnlyFlg, isMnecEnbld, mneLink, onChangeFn, strEvent, tdNotReqd, altDateSearcher, propNotAvailable, isDOBFlg, altClassReqd) {
    var strTdNotReqd = "";
    var strAltDateSearcher = "";
    var strPropNotAvailable = "";
    var lstrDobFlg = "N";
    var strAltClassReqd = "";
    SEARCHER_INDEX = SEARCHER_INDEX + 1;
    if (arguments.length > 10) {
        strTdNotReqd = tdNotReqd;
        strAltDateSearcher = altDateSearcher;
        strPropNotAvailable = propNotAvailable
    }
    if (arguments.length > 13) {
        lstrDobFlg = isDOBFlg
    }
    if (arguments.length > 14) {
        strAltClassReqd = altClassReqd
    }
    if (grpNameReqd != null && grpNameReqd == "Y") {
        eleName = sPrntDtGroupName + "." + objName
    } else {
        eleName = objName
    }
    if (isMandatoryFlg == "N" && strPropNotAvailable != "Y") {
        mandatString = eval(sPrntDtGroupName + 'Props.get("' + objName + '_MANDATORY")')
    } else {
        mandatString = isMandatoryFlg
    }
    if (isReadOnlyFlg != null && isReadOnlyFlg == "Y") {
        isReadOnly = "ReadOnly"
    } else {
        isReadOnly = ""
    }
    if (isMnecEnbld != null && isMnecEnbld == "Y") {
        isMnemonicEnbld = bMnemonic
    } else {
        isMnemonicEnbld = "false";
        bMnemonic = "false"
    }
    if (onChangeFn != null && onChangeFn != "") {
        strOnChangeFn = ";" + onChangeFn
    } else {
        strOnChangeFn = ""
    }
    if (strEvent == null) {
        strEvent = ""
    }
    if (strPropNotAvailable != "Y") {
        strEnabledFlg = eval(sPrntDtGroupName + 'Props.get("' + objName + '_ENABLED")')
    } else {
        strEnabledFlg = "enabled"
    }
    with(document) {
        if (literalDesc != null && literalDesc != "") {
            write('<td class="textlabel">' + jsUtil.encodeChar(literalDesc) + " ");
            write('<script>setMandatory("' + mandatString + '")<\/script></td>')
        }
        if (strTdNotReqd != "Y") {
            write('<td class="textfield">')
        }
        write("<input ");
        if (strPropNotAvailable != "Y") {
            write(eval(sPrntDtGroupName + 'Props.get("' + objName + '_ENABLED")') + " ")
        }
        write(isReadOnly + ' id ="' + objName + '_ui" hotKeyId="calendar' + SEARCHER_INDEX + '" type="text" fdt= "uidate" ');
        write("mnebl=" + isMnemonicEnbld + ' name="' + eleName + '_ui" size="10" ');
        if (strAltClassReqd != "Y") {
            write('maxlength="10" class="textfieldfont" fmnd = "' + mandatString + '" ')
        } else {
            write('maxlength="10" class="textfieldinsidemultirec" fmnd = "' + mandatString + '" ')
        }
        write('onChange="fnEventFormatDate(this)' + strOnChangeFn + '" ' + strEvent + ">");
        if (linkNum != null && linkNum != "" && strEnabledFlg == "enabled" && isReadOnly == "") {
            if (strAltDateSearcher == "Y") {
                write('<a target=_self id ="sLnk' + linkNum + '" ');
                write("href=javascript:fnOpenDate(document.forms[0]." + objName + '_ui,"' + BODDate + '"');
                write(")>");
                write('<img class="img"  src="../Renderer/images/' + applangcode + '/calender.gif" width="24" height="19" border="0" style="cursor:hand" alt="' + finbranchResArr.get("FTT000501") + '" align=absmiddle hotKeyId="calendar' + SEARCHER_INDEX + '">');
                write("</img></a>")
            } else {
                write('<a target=_self id ="sLnk' + linkNum + '" ');
                write("href=javascript:openDate(document.forms[0]." + objName + '_ui,"' + BODDate + '"');
                write(")>");
                write('<img class="img"  src="../Renderer/images/' + applangcode + '/calender.gif" width="24" height="19" border="0" style="cursor:hand" alt="' + finbranchResArr.get("FTT000501") + '" align=absmiddle hotKeyId="calendar' + SEARCHER_INDEX + '">');
                write("</img></a>")
            }
        }
        if (bMnemonic == "true" && strEnabledFlg == "enabled" && isReadOnly == "") {
            write('<a target=_self id="msLnk' + mneLink + '" ');
            write("href=javascript:showMnemonics(document.forms[0]." + objName + "_ui)>");
            write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" ');
            write('width="16" height="17" border="0"></img> </a>')
        }
        if (strTdNotReqd != "Y") {
            write("</td>")
        }
        write('<input type="hidden" id="' + objName + '" ');
        write('fmnd = "' + mandatString + '" ');
        if (lstrDobFlg == "Y") {
            write('fdob = "' + lstrDobFlg + '"')
        }
        write('fdt="fdate" mneb1=' + isMnemonicEnbld + " vFldId=" + objName + '_ui name="' + eleName + '">')
    }
}

function fnConvertToStdDate(b) {
    var d = "";
    var g = "";
    var f = "";
    var e = b;
    if (b == "") {
        return b
    }
    if (isValidBjsDateMneumonic(b)) {
        e = b;
        return e
    } else {
        if (isValidDateMneumonic(b)) {
            e = b;
            return e
        }
    }
    if (!isGregDate(b)) {
        b = convertDateToGreg(b);
        if (!isGregDate(b) && calbase != "00") {
            e = "invalid";
            return e
        }
        e = b
    }
    if (b.indexOf("/") != -1) {
        var a = b.split("/")
    }
    if (b.indexOf("-") != -1) {
        var a = b.split("-")
    }
    if (b.indexOf(".") != -1) {
        var a = b.split(".")
    }
    if (isValidDateMneumonic(b)) {
        e = b;
        return e
    }
    if (a != null) {
        if (calbase == "02") {
            var c = "";
            f = parseInt(a[2]);
            c = parseInt(NumLocYears);
            f = f - c;
            a[2] = f.toString();
            e = a[0] + "-" + a[1] + "-" + a[2]
        }
        if (dateFormat == "01") {
            e = a[1] + "-" + a[0] + "-" + a[2];
            return e
        }
        return e
    }
    return e
}

function fnConvertToUIDate(b) {
    var c = "";
    var f = "";
    var e = "";
    var d = b;
    if (d == "" || fnIsNull(d)) {
        return d
    }
    d = convertBetweenDate(d);
    if (isValidDateMneumonic(d)) {
        return d
    }
    if (d.indexOf("/") != -1) {
        var a = d.split("/")
    }
    if (d.indexOf("-") != -1) {
        var a = d.split("-")
    }
    if (d.indexOf(".") != -1) {
        var a = d.split(".")
    }
    if (calbase == "02") {
        e = parseInt(a[2]);
        e = e + parseInt(NumLocYears);
        a[2] = e.toString();
        d = a[0] + "-" + a[1] + "-" + a[2]
    }
    if (dateFormat == "01") {
        d = a[1] + "-" + a[0] + "-" + a[2];
        return d
    }
    return d
}

function fnAssignDateOnEnter(d) {
    var c;
    objForm = document.forms[0];
    c = String(d.name);
    var b = d.getAttribute("fmult");
    var e = d.getAttribute("recNum");
    var f = c.substring((c.length - 3), c.length);
    if (f == "_ui") {
        c = c.substring(0, (c.length - 3))
    } else {
        c = c.substring(0, c.length)
    }
    element = document.getElementsByName(c);
    if (b == "Y") {
        var a = e;
        if (element[a] == null) {
            return
        } else {
            element[a].value = fnConvertToStdDate(d.value)
        }
    } else {
        if (element[0] == null) {
            return
        } else {
            element[0].value = fnConvertToStdDate(d.value)
        }
    }
}

function fnAssignDateOnLoad(c) {
    i = 0;
    var b;
    while (c.elements[i] != null) {
        b = c.elements[i].name + "_ui";
        element = document.getElementsByName(b);
        if (element[0] != undefined) {
            if (c.elements[i] != null && c.elements[i].getAttribute("fdt") == "fdate" && c.elements[i] != "") {
                if (c.elements[i].getAttribute("fmult") == "Y") {
                    var a = c.elements[i].getAttribute("recNum");
                    element[a].value = fnConvertToUIDate(c.elements[i].value)
                } else {
                    element[0].value = fnConvertToUIDate(c.elements[i].value)
                }
            }
        }
        i++
    }
}

function fnSetFocusForDate(b) {
    var a = b.name;
    element = document.getElementsByName(a + "_ui");
    if (element[0] == null) {
        if (b.disabled == false) {
            b.focus();
            b.select()
        }
        return
    }
    if (element[0].disabled == false) {
        element[0].focus();
        element[0].select()
    }
}

function fnAssignUIDate(a) {
    itemName = a.name + "_ui";
    element = document.getElementsByName(itemName);
    if (element[0] == null) {
        return
    }
    element[0].value = fnConvertToUIDate(a.value)
}

function fnEnableUIField(b, a) {
    itemName = b.name + "_ui";
    element = document.getElementsByName(itemName);
    if (element[0] == null) {
        return
    }
    if (a != null && a != "") {
        if (a == "Y") {
            element[0].disabled = false
        } else {
            element[0].disabled = true
        }
    }
    fnAssignUIDate(b)
}

function fnSetPropertyValue(obj, property, value) {
    var itemName = obj.name + "_ui";
    element = document.getElementsByName(itemName);
    if (obj.fmult == "Y") {
        var i = obj.recNum;
        if (element[i].name == undefined) {
            element[i] = obj
        }
        if (property != null && property != "") {
            if ((typeof value) == "string") {
                eval("document.forms[0]." + element[i].id + "[" + i + "]." + property + "='" + value + "'")
            } else {
                eval("document.forms[0]." + element[i].id + "[" + i + "]." + property + "=" + value)
            }
        }
    } else {
        if (element.length == 0) {
            element = obj
        } else {
            element = element[0]
        }
        if (property != null && property != "") {
            if ((typeof value) == "string") {
                eval("document.forms[0]." + element.id + "." + property + "='" + value + "'")
            } else {
                eval("document.forms[0]." + element.id + "." + property + "=" + value)
            }
        }
    }
}

function PRINTDATELABEL(objName, grpNameReqd, literalDesc, stdDateFormatValue, strEvent, tdNotRqd) {
    var strTdNotRqd = "";
    if (arguments.length > 5) {
        strTdNotRqd = tdNotRqd
    }
    if (grpNameReqd != null && grpNameReqd == "Y") {
        eleName = sPrntDtGroupName + "." + objName
    } else {
        eleName = objName
    }
    if (strEvent == null) {
        strEvent = ""
    }
    with(document) {
        if (literalDesc != null && literalDesc != "") {
            write('<td class="textlabel" >' + jsUtil.encodeChar(literalDesc) + " </td>")
        }
        if (strTdNotRqd != "Y") {
            write('<td class="textfield">')
        }
        write('<input class="textfielddisplaylabel1" ');
        write('name="' + eleName + '_ui" id="' + objName + '_ui" ');
        write("size=10 maxlength=10 ");
        write('fdt="uidate" disabled ' + strEvent + " >");
        if (strTdNotRqd != "Y") {
            write("</td>")
        }
        write('<input type="hidden" id="' + objName + '" ');
        write('fdt="fdate" name="' + eleName + '" ');
        write('value="' + stdDateFormatValue + '" >')
    }
}

function fnClearDateFields(a) {
    a.value = "";
    fnAssignUIDate(a)
}

function fnGetPropertyValue(obj, property) {
    itemName = obj.name + "_ui";
    element = document.getElementsByName(itemName);
    if (element[0].name == undefined) {
        element[0] = obj
    }
    if (property != null && property != "") {
        return eval("document.forms[0]." + String(element[0].id) + "." + property)
    }
}

function fnSetAttributeValue(obj, attribName, attribVal) {
    itemName = obj.name + "_ui";
    element = document.getElementsByName(itemName);
    if (element.length == 0) {
        element = obj
    } else {
        element = element[0]
    }
    if (attribName != null && attribName != "" && attribVal != null) {
        eval("document.forms[0]." + String(element.id) + '.setAttribute("' + attribName + '","' + attribVal + '")')
    }
}

function fnGetAttributeValue(obj, attribName) {
    itemName = obj.name + "_ui";
    element = document.getElementsByName(itemName);
    if (element[0].name == undefined) {
        element[0] = obj
    }
    if (attribName != null && attribName != "" && attribVal != null) {
        return eval("document.forms[0]." + String(element[0].id) + '.getAttribute("' + attribName + '")')
    }
}

function PRINTDATEMRC(objName, grpNameReqd, recNum, linkNum, literalDesc, stdDateFormatValue, isMandatoryFlg, isReadOnlyFlg, isMnecEnbld, mneLink, onChangeFn, strEvent, tdNotReqd, altDateSearcher, propNotAvailable) {
    var strTdNotReqd = "";
    var strAltDateSearcher = "";
    var strPropNotAvailable = "";
    SEARCHER_INDEX = SEARCHER_INDEX + 1;
    if (arguments.length > 12) {
        strTdNotReqd = tdNotReqd;
        strAltDateSearcher = altDateSearcher;
        strPropNotAvailable = propNotAvailable
    }
    if (grpNameReqd != null && grpNameReqd == "Y") {
        eleName = sPrntDtGroupName + "." + objName
    } else {
        eleName = objName
    }
    if (isMandatoryFlg == "N" && strPropNotAvailable != "Y") {
        mandatString = eval(sPrntDtGroupName + 'Props.get("' + objName + '_MANDATORY")')
    } else {
        mandatString = isMandatoryFlg
    }
    if (isReadOnlyFlg != null && isReadOnlyFlg == "Y") {
        isReadOnly = "ReadOnly"
    } else {
        isReadOnly = ""
    }
    if (isMnecEnbld != null && isMnecEnbld == "Y") {
        isMnemonicEnbld = bMnemonic
    } else {
        isMnemonicEnbld = "false";
        bMnemonic = "false"
    }
    if (onChangeFn != null && onChangeFn != "") {
        strOnChangeFn = ";" + onChangeFn
    } else {
        strOnChangeFn = ""
    }
    if (strEvent == null) {
        strEvent = ""
    }
    if (strPropNotAvailable != "Y") {
        strEnabledFlg = eval(sPrntDtGroupName + 'Props.get("' + objName + '_ENABLED")')
    } else {
        strEnabledFlg = "enabled"
    }
    with(document) {
        if (literalDesc != null && literalDesc != "") {
            write('<td class="textlabel">' + jsUtil.encodeChar(literalDesc) + " ");
            write('<script>setMandatory("' + mandatString + '")<\/script></td>')
        }
        if (strTdNotReqd != "Y") {
            write('<td class="textfield">')
        }
        write("<input ");
        if (strPropNotAvailable != "Y") {
            write(eval(sPrntDtGroupName + 'Props.get("' + objName + '_ENABLED")') + " ")
        }
        write(isReadOnly + ' id ="' + objName + '_ui" hotKeyId="calendar' + SEARCHER_INDEX + '" type="text" fdt= "uidate" fmult= "Y" recNum="' + recNum + '" ');
        write("mnebl=" + isMnemonicEnbld + ' name="' + eleName + '_ui" size="10" ');
        write('maxlength="10" class="textfieldfont" fmnd = "' + mandatString + '" ');
        write('onChange="fnEventFormatDate(this)' + strOnChangeFn + '" ' + strEvent + ">");
        if (linkNum != null && linkNum != "" && strEnabledFlg == "enabled" && isReadOnly == "") {
            if (strAltDateSearcher == "Y") {
                write('<a target=_self id ="sLnk' + linkNum + '" ');
                write("href=javascript:fnOpenDate(document.forms[0]." + objName + "_ui[" + recNum + '],"' + BODDate + '"');
                write(")>");
                write('<img class="img"  src="../Renderer/images/' + applangcode + '/calender.gif" width="24" height="19" border="0" style="cursor:hand" align=absmiddle hotKeyId="calendar' + SEARCHER_INDEX + '">');
                write("</img></a>")
            } else {
                write('<a target=_self id ="sLnk' + linkNum + '" ');
                write("href=javascript:openDate(document.forms[0]." + objName + "_ui[" + recNum + '],"' + BODDate + '"');
                write(")>");
                write('<img class="img"  src="../Renderer/images/' + applangcode + '/calender.gif" width="24" height="19" border="0" style="cursor:hand" align=absmiddle hotKeyId="calendar' + SEARCHER_INDEX + '">');
                write("</img></a>")
            }
        }
        if (bMnemonic == "true" && strEnabledFlg == "enabled" && isReadOnly == "") {
            write('<a target=_self id="msLnk' + mneLink + '" ');
            write("href=javascript:showMnemonics(document.forms[0]." + objName + "_ui[" + recNum + "])>");
            write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" ');
            write('width="16" height="17" border="0"></img> </a>')
        }
        if (strTdNotReqd != "Y") {
            write("</td>")
        }
        write('<input type="hidden" id="' + objName + '" ');
        write('fmnd = "' + mandatString + '" ');
        write('recNum = "' + recNum + '" ');
        write('fdt="fdate" fmult = "Y" mneb1=' + isMnemonicEnbld + " vFldId=" + objName + '_ui name="' + eleName + '" ');
        write('value="' + stdDateFormatValue + '" >')
    }
}

function dateDiff(e, c) {
    var f = new Date(e.substring(6, 10), parseInt(e.substring(3, 5) - 1, 10), e.substring(0, 2));
    var d = new Date(c.substring(6, 10), parseInt(c.substring(3, 5) - 1, 10), c.substring(0, 2));
    var b = f - d;
    var a = Math.round(b / (24 * 3600 * 1000));
    return a
}

function depPeriodDiff(o, h, l, e) {
    var c = 0;
    var b = 0;
    var m = 0;
    var d = 0;
    var g = 0;
    var a = 0;
    var f = 0;
    a = 12 * (h.substring(6, 10) - o.substring(6, 10)) + (h.substring(3, 5) - o.substring(3, 5));
    c = daysInMonth(o.substring(3, 5), o.substring(6, 10));
    b = daysInMonth(h.substring(3, 5), h.substring(6, 10));
    if ((o.substring(0, 2) != c) || (h.substring(0, 2) != b) || (o.substring(0, 2) < h.substring(0, 2))) {
        if (h.substring(0, 2) >= o.substring(0, 2)) {
            f = h.substring(0, 2) - o.substring(0, 2)
        } else {
            (a) --;
            if (h.substring(3, 5) == 1) {
                m = 12;
                d = h.substring(6, 10) - 1
            } else {
                m = h.substring(3, 5) - 1;
                d = h.substring(6, 10)
            }
            if (fnIsLeapYear(d)) {
                g = daysInMonth(m, d)
            } else {
                g = parseInt(daysInMonth(m, d), 10) + parseInt(h.substring(0, 2), 10)
            }
            if (g < o.substring(0, 2)) {
                (a) --;
                h.substring(3, 5) --;
                if (h.substring(4, 2) == 1) {
                    m = 12;
                    d = h.substring(6, 10) - 1
                } else {
                    m = h.substring(3, 5) - 1;
                    d = h.substring(6, 10)
                }
                if (fnIsLeapYear(d)) {
                    f = g + daysInMonth(m, d)
                } else {
                    f = daysInMonth(m, d) - o.substring(0, 2)
                }
            } else {
                f = g - o.substring(0, 2)
            }
        }
    } else {
        f = 0
    }
    l.value = a;
    e.value = f;
    return
}

function daysInMonth(b, a) {
    var d;
    var c = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    if ((b == 2) && (a % 4 == 0 && (a % 100 != 0 || a % 400 == 0))) {
        c[1] = 29
    }
    return c[b - 1]
}

function onBlurFormatDate(s) {
    var h = "-";
    var a = "/";
    var p = ".";
    var m = s.value;
    var r = "";
    var q = "";
    var t = s.getAttribute("mnebl");
    BODDate = convertBetweenDate(BODDate);
    var c = BODDate.substring(0, 2);
    var g = BODDate.substring(3, 5);
    var d = BODDate.substring(6, 10);
    var b = "";
    var f = "";
    var o = "";
    var l = 0;
    BODDate = convertDateToGreg(BODDate);
    if ((null != t) && (t) && ("$" == m.substring(0, 1))) {
        return
    }
    if (!fnIsNull(m)) {
        if ((!isNaN(m)) && (m.length == 8)) {
            if (((calbase == "00") && (dateFormat == "00")) || ((calbase == "00") && (dateFormat == "01")) || ((calbase == "02") && (dateFormat == "00"))) {
                q = m.substring(0, 2) + h + m.substring(2, 4) + h + m.substring(4, 8);
                if (!isHijDate(q) && !isGregDate(q) && !isBuddhaDate(q)) {
                    setDateFieldFocusOnError(s);
                    return false
                }
                s.value = q;
                return
            }
        }
        for (i = 0; i < m.length; i++) {
            if ((m.charAt(i) != h) && (m.charAt(i) != a) && (m.charAt(i) != p)) {
                r += m.charAt(i)
            }
            if ((m.charAt(i) == h) || (m.charAt(i) == a) || (m.charAt(i) == p)) {
                l++;
                if (parseInt(l, 10) == 1) {
                    b = r
                }
                if (parseInt(l, 10) == 2) {
                    f = r
                }
                r = ""
            }
        }
        if (parseInt(l, 10) == 0) {
            b = r
        } else {
            if (parseInt(l, 10) == 1) {
                f = r
            } else {
                o = r
            }
        }
        if (fnIsNull(f)) {
            f = g
        }
        if (fnIsNull(o)) {
            if ((calbase == "00") && (dateFormat == "01")) {
                temp = b;
                b = f;
                f = temp;
                o = d
            } else {
                if ((calbase == "02") && (dateFormat == "00")) {
                    var e = parseInt(NumLocYears);
                    o = new String(parseInt(d) + e)
                } else {
                    o = d
                }
            }
        }
        if (((calbase == "00") && (dateFormat == "00")) || ((calbase == "00") && (dateFormat == "01")) || ((calbase == "02") && (dateFormat == "00"))) {
            if (isNaN(b) || isNaN(f) || isNaN(o)) {
                setDateFieldFocusOnError(s);
                return false
            }
            b = Math.abs(b);
            if ((b.length == 1) || (b < 10)) {
                b = "0" + b
            }
            if (b.length > 2) {
                setDateFieldFocusOnError(s);
                return false
            }
            if (((b < 1) || (b > 31)) && ((calbase == "00") && (dateFormat == "00"))) {
                setDateFieldFocusOnError(s);
                return false
            }
            if (((b < 1) || (b > 12)) && ((calbase == "00") && (dateFormat == "01"))) {
                setDateFieldFocusOnError(s);
                return false
            }
            if (f.length == 1) {
                f = "0" + f
            }
            if (f.length > 2) {
                setDateFieldFocusOnError(s);
                return false
            }
            if (((f < 1) || (f > 12)) && ((calbase == "00") && (dateFormat == "00"))) {
                setDateFieldFocusOnError(s);
                return false
            }
            if (((f < 1) || (f > 31)) && ((calbase == "00") && (dateFormat == "01"))) {
                setDateFieldFocusOnError(s);
                return false
            }
            if (o.length == 1) {
                setDateFieldFocusOnError(s);
                return false
            }
            if (o.length == 2) {
                hYrLimit = parseInt(d, 10) + 30;
                intYear = parseInt(o, 10);
                if (intYear >= (hYrLimit % 100)) {
                    strYear = (hYrLimit - (hYrLimit % 100)) - 100
                } else {
                    strYear = hYrLimit - (hYrLimit % 100)
                }
                o = strYear + intYear
            }
            if (o.length == 3) {
                setDateFieldFocusOnError(s);
                return false
            }
            if (o.length > 4) {
                setDateFieldFocusOnError(s);
                return false
            }
        }
        q = b + h + f + h + o;
        q = convertBetweenDate(q);
        if (!isHijDate(q) && !isGregDate(q) && !isBuddhaDate(q)) {
            setDateFieldFocusOnError(s);
            return false
        }
        s.value = q
    }
}

function setDateFieldFocusOnError(a) {
    alert(finbranchResArr.get("FAT000081"));
    fnSetFocusForDate(a);
    return false
}

function fnEventFormatDate(a) {
    var b = "";
    if ((b = onBlurFormatDate(a)) == false) {
        return false
    }
    if ((b = fnAssignDateOnEnter(a)) == false) {
        return false
    }
    return (b == undefined) ? true : b
}

function writeMaximumAmount(amtObj) {
    if (this.AmountCrncyMap != undefined) {
        var temp = AmountCrncyMap[amtObj.id];
        if (temp != undefined) {
            var pipeIndex = temp.indexOf("|");
            var crncy = temp.substring(0, pipeIndex);
            var isObj = temp.substring(pipeIndex + 1);
            if (isObj == "Y") {
                crncy = eval("document.forms[0]." + crncy + ".value")
            } else {
                crncy = eval("this." + crncy)
            }
            var prec = getPrec(crncy);
            if (prec == 0) {
                var actualAmt = MAX_AMOUNT.substring(0, (MAX_AMOUNT.length - prec))
            } else {
                var actualAmt = MAX_AMOUNT.substring(0, (MAX_AMOUNT.length - prec)) + "." + MAX_AMOUNT.substring((MAX_AMOUNT.length - prec))
            }
            amtObj.value = getAmtInCustomFormat(actualAmt)
        }
    }
}

function writeMaximumUnit(a) {
    var b = MAX_UNIT.substring(0, (MAX_UNIT.length - 6)) + "." + MAX_UNIT.substring((MAX_UNIT.length - 6));
    a.value = getAmtInCustomFormat(b)
}

function getBacidAcctList(c, a) {
    var b = (a == "morph") ? "../" : "../arjspmorph/";
    b += applangcode + "/get_bacid_accts.jsp?bacid=" + escape(c) + "&precedence=F";
    popModalWindow(b, "bacidacctlist")
}

function setFieldsToCustomData() {
    setInHiddenData(document.forms[0].screenName, arguments);
    if (this.WF_IN_PROGRESS == "Y" || this.WF_IN_PROGRESS == "PEAS") {
        if (eval(document.forms[0].customFieldNames) != undefined) {
            setCustomFieldNamesInHiddenField(document.forms[0].screenName, arguments)
        }
    }
}

function getFieldsFromCustomData() {
    getFromHiddenData(document.forms[0].screenName, arguments)
}

function setCustomFieldValue() {
    setInHiddenData(document.forms[0].pagename, arguments)
}

function getCustomFieldValue() {
    getFromHiddenData(document.forms[0].pagename, arguments)
}

function setInHiddenData() {
    var sFieldValues = "";
    var strValue = document.forms[0].customData.value;
    var name = arguments[0].value;
    if (strValue.indexOf(name) != -1) {
        strFirst = strValue.substring(0, (strValue.indexOf(name)));
        intlen = strFirst.length - 1;
        strFirst = strFirst.substring(0, intlen);
        strTemp = strValue.substring((strValue.indexOf(name) + 1), strValue.length);
        if (strTemp.indexOf("~") != -1) {
            strLast = strTemp.substring(strTemp.indexOf("~"), strTemp.length)
        } else {
            strLast = ""
        }
        strValue = strFirst + strLast
    }
    for (i = 0; i < arguments[1].length; i++) {
        if (eval("document.forms[0]." + arguments[1][i]) != undefined) {
            var fieldObj = eval("document.forms[0]." + arguments[1][i]);
            var fieldVal = "";
            if (fieldObj.type == "radio") {
                fieldVal = getRadioValue(fieldObj)
            } else {
                fieldVal = fieldObj.value
            }
            if (i == 0) {
                sFieldValues = sFieldValues + fieldVal + "|"
            } else {
                sFieldValues = sFieldValues + fieldVal + "|"
            }
        }
    }
    if (sFieldValues.length > 0) {
        strValue = strValue + "~" + name + "|";
        strValue = strValue + sFieldValues
    }
    document.forms[0].customData.value = strValue
}

function setCustomFieldNamesInHiddenField() {
    var customNames = "";
    var name = arguments[0].value;
    for (i = 0; i < arguments[1].length; i++) {
        if (eval("document.forms[0]." + arguments[1][i]) != undefined) {
            customNames = customNames + arguments[1][i] + "|"
        }
    }
    document.forms[0].customFieldNames.value = (name + "|" + customNames)
}

function getFromHiddenData() {
    var strValue = document.forms[0].customData.value;
    var name = arguments[0].value;
    if (strValue.indexOf(name) != -1) {
        strFirst = strValue.substring(0, (strValue.indexOf(name)));
        intlen = strFirst.length - name.length;
        strFirst = strFirst.substring(0, intlen);
        strTemp = strValue.substring((strValue.indexOf(name) + (name.length + 1)), strValue.length);
        if (strTemp.indexOf("~") != -1) {
            strLast = strTemp.substring(0, strTemp.indexOf("~"))
        } else {
            strLast = strTemp
        }
        strValue = strLast
    } else {
        strValue = ""
    }
    for (i = 0; i < arguments[1].length; i++) {
        if (eval("document.forms[0]." + arguments[1][i]) != undefined) {
            var fieldObj = eval("document.forms[0]." + arguments[1][i]);
            var isArray = (typeof(fieldObj.length) == "undefined") ? false : true;
            if (strValue.indexOf("|") != -1) {
                if (isArray) {
                    if (fieldObj.type == "radio") {
                        setRadioValue(arguments[1][i], strValue.substring(0, strValue.indexOf("|")))
                    } else {
                        fieldObj.value = strValue.substring(0, strValue.indexOf("|"))
                    }
                } else {
                    var fldVal = strValue.substring(0, strValue.indexOf("|"));
                    if (fieldObj.type == "checkbox") {
                        if (fldVal == "Y") {
                            fieldObj.checked = true
                        }
                    } else {
                        fieldObj.value = fldVal
                    }
                }
                strValue = strValue.substring((strValue.indexOf("|") + 1), strValue.length)
            } else {
                if (isArray) {
                    if (fieldObj.type == "radio") {
                        setRadioValue(arguments[1][i], strValue)
                    } else {
                        fieldObj.value = strValue
                    }
                } else {
                    var fldVal = strValue;
                    if (fieldObj.type == "checkbox") {
                        if (fldVal == "Y") {
                            fieldObj.checked = true
                        }
                    } else {
                        fieldObj.value = fldVal
                    }
                }
                strValue = ""
            }
        }
    }
}

function fnFormatAmt(d, b, a) {
    b = getAmtInStdFormat(b);
    var c = "";
    b = checkZeroes(b, a);
    if (d == "Million") {
        c = formatToMillion1(b, a)
    } else {
        c = formatToLakh1(b, a)
    }
    c = getAmtInCustomFormat(c);
    return c
}

function customDataProcess(arr, arrCol) {
    outValue = "";
    outName = "";
    k = 1;
    for (i = 0; i < arr.length; i++) {
        for (j = 0; j < arrCol.length; j++) {
            obj = arr[i];
            var expr = "obj." + arrCol[j];
            val = eval(expr);
            outValue = outValue + val + "|";
            outName = outName + arrCol[j] + "_" + k + "|"
        }
        k++
    }
    outName = outName.substring(0, outName.length - 1);
    outValue = outValue.substring(0, outValue.length - 1);
    document.forms[0].custNames.value = outName;
    document.forms[0].custValues.value = outValue
}

function callCRVForPTranDetails(d, b, f, a, e, g) {
    var c = null;
    if (g == "morph") {
        self.close()
    }
    c = "../inquiry/inquiry_ctrl.jsp?mo=TRANINQ&actionCode=SUBMIT&traninq.tranid=" + b + "&traninq.trandate=" + f + "&traninq.part_tran_srl_num=" + a + "&traninq.acct_num=" + e;
    formUrl(c)
}

function hideAnc(b) {
    var a = document.getElementById(b);
    if (a != null && a != undefined) {
        a.disabled = true;
        a.onclick = ""
    }
}

function onClickAssignRtrnPath(a) {
    setActionForWorkflow();
    document.location.href = a
}

function fnValidatePercent(a, b) {
    var g = 0;
    var c = 0;
    var d = 0;
    var h = true;
    var f = getValInStdFormat(a);
    var e = 6;
    e = e > b ? b : e;
    d = f.indexOf(DEF_DECIMAL_SEPARATOR);
    if (d == -1) {
        g = f
    } else {
        g = f.substring(0, d);
        c = f.substring(d + 1)
    }
    if (c.length > e) {
        h = false;
        alert(finbranchResArr.get("FAT000523") + e + finbranchResArr.get("FAT000526"))
    }
    return h
}

function showHelpFile(b) {
    var c = getCustHelpUrl(b);
    var d = window.open(c, USERID + "_HelpScreen", "height=300%, width=575px, left=224, top=120, status=no, toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no");
    if (d != null && typeof(d) == "string" && d == "TIMEOUT") {
        var a = new Array(1);
        a[0] = finConst.FORCED_LOGOUT;
        handleWindowDisplay(finConst.DOLOGOUT, a);
        return
    }
    if (d != null && d != undefined) {
        d.focus()
    }
}

function getCustHelpUrl(file) {
    var retUrl = "";
    var funcName = "this.getExternalHelpUrl";
    var bUrl = getBaseUrl();
    var altlitcode = "";
    if (eval(funcName) != undefined) {
        retUrl = eval(funcName).call(this, file, mopId.toUpperCase());
        if (retUrl != undefined && !fnIsNull(retUrl)) {
            return retUrl
        }
    }
    return bUrl + finContextPath + "/HelpRenderer/" + file + "?localeCode=" + localeCode + "&appLangCode=" + applangcode + "&rtId=" + rtId
}

function validateRefCode(frame, refCodeObj, refRecTypeVal, descObj) {
    var refCode = "";
    var descId = "";
    var isValidFlg = "";
    var tmpStr = "";
    var wReturnDesc = "";
    var refRecType = refRecTypeVal;
    var fetchId = "REFCODE";
    var precedence = "F";
    if (!window.showModalDialog) {
        genericCallBackFn = "validateRefCode_genericCallBack"
    }
    if (!fnIsNull(refCodeObj.value)) {
        refCode = refCodeObj.value
    }
    if (descObj != null) {
        descId = descObj.id
    }
    if (!fnIsNull(refCodeObj.value)) {
        refCode = refCodeObj.value;
        tmpStr = refCode + "|" + refRecType;
        var sUrl = "../arjspmorph/" + applangcode + "/frm_fetch.jsp?fetchId=" + fetchId + "&precedence=" + precedence + "&wReturn=" + tmpStr + "&wReturnDesc=" + descId;
        sUrl = jsUtil.formatUrl(sUrl);
        var xMax = screen.width,
            yMax = screen.height;
        var xOffset = (xMax - 120),
            yOffset = (yMax - 150);
        var params = "dialogWidth=0px;dialogHeight=0px;dialogLeft=" + xOffset + "px;dialogTop=" + yOffset + "px";
        params += ";status=no;toolbar=no;menubar=no;resizable=no;help=no;center=no";
        if (window.showModalDialog) {
            if ("Microsoft Internet Explorer" == browser_name) {
                outData = window.showModalDialog(sUrl, document.forms[0], params)
            } else {
                sUrl = getAbsoluteUrl(sUrl);
                outData = window.showModalDialog(sUrl, document.forms[0], params)
            }
            if (outData != null && typeof(outData) == "string" && outData == "TIMEOUT") {
                var logoutParams = new Array(1);
                logoutParams[0] = finConst.FORCED_LOGOUT;
                handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
                return
            }
            if (outData.toLowerCase().indexOf("|") == -1) {
                if (outData != "") {
                    alert('"' + outData + '"')
                }
                return false
            }
            var retval = outData.split("|");
            eval("document.forms[0]." + descId + '.value ="' + retval[0] + '"')
        } else {
            var retValue = window.open(sUrl, "title", "width=10px,height=10px,modal=yes,top=" + yOffset + "px,left=" + xOffset + "px,scrollbars=yes,toolbar=no,menubar=no,help=no")
        }
    }
}

function validateRefCode_genericCallBack(b) {
    if (b != null && typeof(b) == "string" && b == "TIMEOUT") {
        var a = new Array(1);
        a[0] = finConst.FORCED_LOGOUT;
        handleWindowDisplay(finConst.DOLOGOUT, a);
        return
    }
}

function appFnExecuteScript(inputNameValues, outputNames, scrName, isPopulationReq) {
    var sUrl = "../arjspmorph/" + applangcode + "/stf_frm_fetch.jsp?rtId=" + rtId;
    if (!fnIsNull(inputNameValues)) {
        sUrl += "&inputs=" + encodeURIComponent(inputNameValues)
    }
    if (fnIsNull(scrName)) {
        alert("Script Name is mandatory");
        return
    }
    sUrl += "&scrName=" + scrName;
    if (isPopulationReq && fnIsNull(outputNames)) {
        alert("Output Names are mandatory");
        return
    }
    var xMax = screen.width,
        yMax = screen.height;
    var xOffset = (xMax - 120),
        yOffset = (yMax - 150);
    var params = "dialogWidth=0px;dialogHeight=0px;dialogLeft=" + xOffset + "px;dialogTop=" + yOffset + "px";
    params += ";status=no;toolbar=no;menubar=no;resizable=yes;help=no;center=no";
    var retVal = "";
    if (window.showModalDialog) {
        if ("Microsoft Internet Explorer" == browser_name) {
            retVal = window.showModalDialog(sUrl, document.forms[0], params)
        } else {
            sUrl = getAbsoluteUrl(sUrl);
            retVal = window.showModalDialog(sUrl, document.forms[0], "dialogHeight:100px;dialogleft:843px;dialogWidth:175px;dialogtop:588px;status=no;toolbar=no;menubar=no;resizable=yes;")
        }
        if (retVal != null && typeof(retVal) == "string" && retVal == "TIMEOUT") {
            var logoutParams = new Array(1);
            logoutParams[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
            return
        }
    } else {
        retVal = window.open(sUrl, "title", "width=10px,height=10px,modal=yes,top=" + yOffset + "px,left=" + xOffset + "px,scrollbars=yes,toolbar=no,menubar=no,help=no");
        if (retVal != null && typeof(retVal) == "string" && retVal == "TIMEOUT") {
            var logoutParams = new Array(1);
            logoutParams[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
            return
        }
    }
    if (retVal == null || retVal == undefined) {
        return retVal
    }
    var retBuff = retVal.split("|");
    var retBuffLen = retBuff.length;
    if (retBuff[0] == "Err") {
        var str = "";
        for (var i = 1; i < retBuffLen; i++) {
            str += retBuff[i] + "\n"
        }
        alert(str);
        return
    }
    if (!isPopulationReq) {
        return retVal
    }
    var frm = document.forms[0];
    var outBuff = outputNames.split("|");
    var outBuffLen = outBuff.length;
    for (var i = 0; i < outBuffLen; i++) {
        for (var j = 0; j < retBuffLen; j++) {
            if (outBuff[i] == retBuff[j]) {
                if ((eval("frm." + outBuff[i]) != undefined)) {
                    eval("frm." + outBuff[i] + '.value="' + retBuff[j + 1] + '"');
                    break
                }
            }
        }
    }
}

function printAppTestCase() {
    with(document) {
        write('<input type="button" name="StartCase" class="button" id="StartCase" onClick="appFnExecuteScript(\'action|start|ip|\'+currIp,\'\',\'testCaseLogger.scr\',\'\');" value="Start test case">');
        write('<input type="button" name="StopCase"  class="button" id="StopCase" onClick="appFnExecuteScript(\'action|stop|ip|\'+currIp,\'\',\'testCaseLogger.scr\',\'\');" value="Stop test case">')
    }
    return true
}

function writeFooter() {
    if (("undefined" != typeof(nonSSOLogin)) && (null != typeof(nonSSOLogin)) && (nonSSOLogin)) {
        fnDisableFormDataControls("I", document.forms[0]);
        disableButtons();
        hideHyperLinks()
    }
    var objForm = document.forms[0];
    var frmElements = objForm.elements;
    var totalElements = frmElements.length;
    var ancLen = document.anchors.length;
    var frmArr = document.forms;
    if (typeof text_onBlur == "function") {
        text_onBlur()
    }
    if (frmArr) {
        for (var i = 0; i < frmArr.length; i++) {
            if (frmArr[i].onsubmit == undefined || frmArr[i].onsubmit == null) {
                frmArr[i].onsubmit = function() {
                    return false
                }
            }
            frmArr[i].method = "post"
        }
    }
    var std_reset = document.forms[0].reset;
    document.forms[0].reset = function() {
        formReset(objForm)
    };
    if (document.forms[0].screenName != undefined && document.forms[0].screenName.value != "fdmadet" && document.forms[0].screenName.value != "fdmaexplode" && document.forms[0].screenName.value != "fdmatabdet") {
        if (this.HTMLFormElement) {
            HTMLFormElement.prototype.std_submit = document.forms[0].submit
        } else {
            var std_submit = document.forms[0].submit
        }
        document.forms[0].submit = function() {
            disableFields("menuName", "gotomenu");
            if (!formAlreadySubmitted) {
                if (this.disableButtons != null && this.disableButtons != undefined) {
                    disableButtons();
                    hideAnchors()
                }
                formAlreadySubmitted = true;
                if (eval(this.std_submit) != undefined) {
                    this.std_submit()
                } else {
                    std_submit()
                }
            }
        }
    }
    for (i = 0; i < totalElements; i++) {
        if (frmElements[i].type.toUpperCase() == "BUTTON") {
            frmElements[i].ondblclick = function() {
                return false
            }
        }
    }
    for (i = 0; i < ancLen; i++) {
        document.anchors[i].ondblclick = function() {
            return false
        }
    }
    try {
        if (logTestCase == "Y") {
            printAppTestCase()
        }
        if (eval(isAuditEnabled) != undefined && isAuditEnabled && document.forms[0].name != "resultPage" && document.forms[0].name != "resform") {
            document.write('<input type="button" class="button" value=" ' + finbranchResArr.get("FAT003261") + '"  id="Audit" onClick="doSubmit(\'showaudit\');" hotKeyId="Audit">')
        }
        if (this.WF_IN_PROGRESS == "Y" || this.WF_IN_PROGRESS == "PEAS") {
            with(document) {
                if (document.forms[0].name != "resultPage") {
                    write('<input type="button" class="button" id="Continue" value=' + finbranchResArr.get("FAT001736") + ' onClick="javascript:execNextStep();">');
                    write('<input type="button" class="button" id="Abort" value=' + finbranchResArr.get("FAT001737") + ' onClick="javascript:abortWorkFlow();">')
                }
            }
            if (this.WF_IN_PROGRESS == "Y") {
                document.write('<input type="hidden" name="WF_TEMP_DATA">')
            }
            if (TerminateWF == "true") {
                document.write('<input type="button" class="button" id="TerminateWF" value="TerminateWF" onClick="terminateWF();">');
                document.write('<input type="hidden" name="terminateWFInst" id="terminateWFInst" value="">');
                document.write('<input type="hidden" name="parentProcId" id="parentProcId" value="">')
            }
        }
    } catch (e) {}
}

function terminateWF() {
    var frm = document.forms[0];
    frm.actionCode.value = "abortwf";
    var funcName = "this.getWFProcessId";
    if (eval(funcName) != undefined) {
        retVal = getWFProcessId()
    } else {
        alert(finbranchResArr.get("FAT002336"));
        this.TerminateWF.disabled = true;
        return false
    }
    if (retVal) {
        frm.terminateWFInst.value = "true";
        frm.submit()
    } else {
        return false
    }
}

function abortWorkFlow() {
    var a = document.forms[0];
    a.actionCode.value = "abortwf";
    a.submit()
}

function enableButtons() {
    var c = document.forms[0].elements;
    var a = c.length;
    for (var b = 0; b < a; b++) {
        switch (c[b].type) {
            case "button":
            case "submit":
            case "reset":
                c[b].disabled = false;
                break
        }
    }
    enableTabs()
}

function enableTabs() {
    var a = get_lyr_css("sTab");
    var b = get_lyr_css("hTab");
    if ((b != undefined && b != null) && (a != undefined && a != null)) {
        b.cssText = "position:absolute; visibility:hidden;";
        a.cssText = "position:absolute; visibility:visible;"
    }
}

function showWFButtons() {
    var a = document.forms[0];
    disableButtons();
    if (a.Abort != undefined) {
        a.Abort.disabled = false
    }
    if (a.Continue != undefined) {
        a.Continue.disabled = false;
        a.Continue.focus()
    }
}

function doSubmit(actionCode) {
    var frm = document.forms[0];
    /* Added for localization */
    if (!fnLocaleValidateForm(actionCode)) return;

    if (frm.submitform != undefined) {
        frm.submitform.value = actionCode;
    }
    frm.actionCode.value = actionCode;
    enableFormElements();
    convertToCaps();
    hideAnchors();
    disableButtons();
    frm.submit();
}

function hideAnchors() {
    var ancLen = document.anchors.length;
    var obj;
    for (var i = 0; i < ancLen; i++) {
        obj = document.anchors[i];
        if ((obj.id).substr(0, 4) == "sLnk")
            hideImage(obj.id);
    }
}

function doSubmitForm(a) {
    var c = document.forms[0];
    if (!fnLocaleValidateForm(a)) {
        return
    }
    c.actionCode.value = a;
    convertCase(c);
    if (a != "CANCEL") {
        var b = appendCrncyToAmt();
        if (!b) {
            return
        }
    }
    enableFormElements();
    disablePageLinks();
    hideAnchors();
    disableButtons();
    c.submit()
}

function convertCase(f) {
    var c = f;
    var e = null;
    var a = c.length;
    var d;
    for (i = 0; i < a; i++) {
        e = c[i];
        var b = e.getAttribute("inputCase");
        var d = e.getAttribute("type");
        if (null != b && undefined != b && fnTrim(b).length != 0) {
            if (b == "U") {
                convertToUpperCase(e)
            } else {
                if (b == "L") {
                    convertToLowerCase(e)
                }
            }
        }
    }
}

function convertToUpperCase(b) {
    if (undefined == b || null == b) {
        return
    }
    var a = b.value;
    if (undefined != a && null != a) {
        b.value = a.toUpperCase()
    }
}

function convertToLowerCase(b) {
    if (undefined == b || null == b) {
        return
    }
    var a = b.value;
    if (undefined != a && null != a) {
        b.value = a.toLowerCase()
    }
}

function disablePageLinks() {
    var e = document.links;
    var b = null;
    for (i = 0; i < e.length; i++) {
        b = e[i];
        var d = b.getAttribute("id");
        if (d == null || d == undefined) {
            return
        }
        if (fnTrim(d).length != 0) {
            var a = document.getElementById(d);
            if (a) {
                var c = (a.style) ? a.style : a
            }
            if (c) {
                c.display = "none"
            }
        }
    }
}

function sendDataForRewind(a) {
    var g = screen.width,
        b = screen.height;
    var h = (g - 120),
        d = (b - 150);
    var e = "dialogWidth=0px;dialogHeight=0px;dialogLeft=" + h + "px;dialogTop=" + d + "px";
    e += ";status=no;toolbar=no;menubar=no;resizable=no;help=no;center=no";
    var f = document.forms[0];
    a = jsUtil.formatUrl(a);
    if (window.showModalDialog) {
        var l = window.showModalDialog(a, f, e);
        if (l != null && typeof(l) == "string" && l == "TIMEOUT") {
            var c = new Array(1);
            c[0] = finConst.FORCED_LOGOUT;
            handleWindowDisplay(finConst.DOLOGOUT, c);
            return
        }
    } else {
        popModalWindowVar(a, "TEST", 0, 0, 0, 0)
    }
    return
}

function appendCrncyToAmt() {
    var objForm = document.forms[0];
    var frmElements = objForm.elements;
    var totalElements = frmElements.length;
    var amtFld = null;
    var crncyFld = null;
    var formatAmtFld = null;
    var associatedFld = null;
    var dummyAmtFld = null;
    var fldDataType = null;
    var amtPrec = null;
    var stdAmt = null;
    if (!isEmptyObj(formatAmtFld) && !isEmptyObj(associatedFld)) {
        amtFld = eval("document.forms[0]." + formatAmtFld);
        amtFld.value = dummyAmtFld.value
    }
    for (var j = 0; j < totalElements; j++) {
        dummyAmtFld = frmElements[j];
        fldDataType = dummyAmtFld.getAttribute("fdt");
        if (fldDataType == "amount" || fldDataType == "totamount" || fldDataType == "equityprice") {
            formatAmtFld = dummyAmtFld.getAttribute("formatAmtField");
            associatedFld = dummyAmtFld.getAttribute("associatedField");
            if (!isEmptyObj(formatAmtFld) && !isEmptyObj(associatedFld)) {
                amtFld = eval("document.forms[0]." + formatAmtFld);
                crncyFld = eval("document.forms[0]." + associatedFld);
                if (!isEmptyObjValue(dummyAmtFld.value) && !isEmptyObj(amtFld) && (0 != getAmtInFloat(dummyAmtFld.value))) {
                    if (!isEmptyObj(crncyFld) && !isEmptyObjValue(crncyFld.value)) {
                        stdAmt = getAmtInStdFormat(dummyAmtFld.value);
                        if (!fnIsNull(stdAmt) && low_isValidAmt(stdAmt)) {
                            stdAmt = low_convertAmt(stdAmt);
                            amtFld.value = stdAmt + "|" + crncyFld.value
                        } else {
                            amtFld.value = dummyAmtFld.value + "|" + crncyFld.value
                        }
                        if (fldDataType == "amount") {
                            amtPrec = getPrec(crncyFld.value);
                            if (!fnValidateStdAmount(stdAmt, amtPrec)) {
                                setFieldFocus(dummyAmtFld);
                                return false
                            }
                        } else {
                            if (fldDataType == "totamount") {
                                amtPrec = getPrec(crncyFld.value);
                                if (!low_fnValidateTotAmount(stdAmt, amtPrec)) {
                                    setFieldFocus(dummyAmtFld);
                                    return false
                                }
                            } else {
                                if (fldDataType == "equityprice") {
                                    amtFld.value = amtFld.value + "|" + EQTYPRICE_PREC;
                                    if (!fnValidateStdeqtyprice(stdAmt, EQTYPRICE_PREC)) {
                                        setFieldFocus(dummyAmtFld);
                                        return false
                                    }
                                }
                            }
                        }
                    } else {
                        if (!isEmptyObj(crncyFld) && crncyFld.type != "hidden" && crncyFld.disabled == false) {
                            setFieldFocus(crncyFld)
                        }
                        if (fldDataType == "amount" || fldDataType == "totamount") {
                            alert(finbranchResArr.get("FAT000875") + " [" + dummyAmtFld.value + "]")
                        } else {
                            if (fldDataType == "equityprice") {
                                alert(finbranchResArr.get("FAT004054") + "[" + dummyAmtFld.value + "]")
                            }
                        }
                        return false
                    }
                } else {
                    if (!isEmptyObj(amtFld)) {
                        amtFld.value = dummyAmtFld.value
                    }
                }
            }
        }
    }
    return true
}

function getFormatAmount(f, a, e) {
    var c = null;
    var b = null;
    var d = null;
    if (isEmptyObjValue(a) || isEmptyObjValue(f) || isEmptyObjValue(e)) {
        return
    }
    b = getPrec(e);
    if (f == "Million") {
        c = formatToMillion1(a, b)
    } else {
        c = formatToLakh1(a, b)
    }
    d = getAmtInCustomFormat(c);
    return d
}

function getObjValueInCase(fldName) {
    if (isEmptyObjValue(fldName)) {
        return ""
    }
    var obj;
    if (fldName.indexOf("document.forms[0].") == -1) {
        obj = eval("document.forms[0]." + fldName)
    } else {
        obj = eval(fldName)
    }
    var value = null;
    var inputCase = null;
    if (isEmptyObj(obj)) {
        return ""
    }
    value = escape(getFieldValue(fldName, "N"));
    if (isEmptyObjValue(value)) {
        return ""
    }
    if (!isNaN(obj.length)) {
        inputCase = obj[0].getAttribute("inputCase")
    } else {
        inputCase = obj.getAttribute("inputCase")
    }
    if (!isEmptyObjValue(inputCase)) {
        if (inputCase == "D") {
            return value
        } else {
            if (inputCase == "L") {
                return value.toLowerCase()
            }
        }
    }
    return value.toUpperCase()
}

function isEmptyObj(a) {
    if (undefined == a || null == a) {
        return true
    }
    return false
}

function getYesNoDesc(b, a) {
    switch (b) {
        case "Y":
            return finbranchResArr.get("FAT000761");
        case "N":
            return finbranchResArr.get("FAT000762");
        default:
            return a
    }
}

function getPartTranType(a) {
    switch (a) {
        case "D":
            return finbranchResArr.get("FAT001746");
        case "C":
            return finbranchResArr.get("FAT001747");
        default:
            return ""
    }
}

function getPymtTypeDesc(a) {
    switch (a) {
        case "S":
            return finbranchResArr.get("FAT001440");
        case "U":
            return finbranchResArr.get("FAT001440");
        case "R":
            return finbranchResArr.get("FAT000744");
        case "M":
            return finbranchResArr.get("FAT000745");
        case "V":
            return finbranchResArr.get("FAT000740");
        case "X":
            return finbranchResArr.get("FAT000739");
        default:
            return a
    }
}

function showDocImagePage(d, g, b, h, m, c, e, l, f) {
    var a = "";
    if (fnIsNull(d)) {
        alert(finbranchResource.FAT000139);
        return false
    }
    if (fnIsNull(g)) {
        alert(finbranchResArr.get("FAT000139"));
        return false
    } else {
        if ((fnIsNull(m)) || (fnIsNull(c)) || (fnIsNull(e)) || (fnIsNull(l)) || (fnIsNull(f))) {
            alert(finbranchResArr.get("FAT001079"));
            return false
        } else {
            if (fnIsNull(h)) {
                h = "null"
            }
            if (fnIsNull(b)) {
                b = "null"
            }
            a = m + "://" + c + ":" + l + "/" + e;
            a += "?SessionID=" + self.sessionid + "&SecToken=" + self.sectok;
            a += "&AppName=" + f + "&CIF=" + d + "&AccNumber=" + g;
            a += "&DocCode=" + b + "&ApplNumber=" + h;
            openModalWindow(a, "");
            return true
        }
    }
}

function Properties(propObj) {
    this.props = propObj;
    this.get = getProperty;
}
//This function checks if the customized properties are available for a particular field,
//if they are not found then the default value for the field property, which is  based on the type of property returned.
function getProperty(propName) {
    var propObj = this.props;
    var retVal = eval("propObj." + propName);

    //Case where the property is defined in the finbranchcustom.properties file
    if (retVal != undefined)
        return retVal;

    //Below is the case for different properties when the property is not defined
    if (propName.indexOf("_MANDATORY") != -1)
        return "N";
    else if (propName.indexOf("_ENABLED") != -1)
        return "enabled";
    else if (propName.indexOf("_CHECKED") != -1)
        return "";

    alert("Invalid Property Accessed : " + propName);
    return;
}

function fnLastButtonClick() {
    var frmObj = document.forms[0];
    if (!fnLocaleValidateForm("endMenu")) {
        return
    }
    try {
        frmObj.actionCode.value = "endMenu";
        if (eval(frmObj.submitform) != undefined) {
            frmObj.submitform.value = "endMenu"
        }
        if (undefined != WF_IN_PROGRESS && WF_IN_PROGRESS == "PEAS") {
            frmObj.actionCode.value = "endWorkflow";
            if (undefined != frmObj.submitform) {
                frmObj.submitform.value = "endWorkflow"
            }
        }
    } catch (e) {}
    frmObj.submit();
    return true
}

function setActionForWorkflow() {
    var b = document.forms[0];
    try {
        if (undefined != WF_IN_PROGRESS && (WF_IN_PROGRESS == "PEAS" || WF_IN_PROGRESS == "Y")) {
            b.actionCode.value = "endWorkflow"
        }
    } catch (a) {}
}

function fnCommonValAmount(q, g, a, b, d, p, o) {
    var e = 0;
    var c = 0;
    var l = 0;
    var r = true;
    var h = removeCommas(q);
    var s = 4;
    var m = a;
    var f = b;
    if (isEmptyObjValue(q)) {
        return false
    }
    if (isNaN(h)) {
        r = false;
        alert(finbranchResArr.get("FAT000189"))
    } else {
        if (null != g && !isNaN(g) && 0 < parseInt(g, 10)) {
            s = s > g ? g : s
        }
        h = checkZeroes(h, g);
        l = h.indexOf(DEF_DECIMAL_SEPARATOR);
        if (l == -1) {
            e = h
        } else {
            e = h.substring(0, l);
            c = h.substring(l + 1)
        }
        if (h.length > (f + 1)) {
            r = false;
            alert(finbranchResArr.get("FAT000523") + f + " " + finbranchResArr.get("FAT000524"))
        } else {
            if (e.length > m) {
                r = false;
                alert(d)
            } else {
                if (c.length > s) {
                    r = false;
                    alert(finbranchResArr.get("FAT000523") + s + " " + finbranchResArr.get("FAT000526"))
                } else {
                    switch (parseInt(s, 10)) {
                        case 3:
                            if (e.length > 13) {
                                r = false;
                                alert(p + s)
                            }
                            break;
                        case 4:
                            if (e.length > 12) {
                                r = false;
                                alert(o + s)
                            }
                            break
                    }
                }
            }
        }
    }
    return r
}

function fnValidateTotAmount(b, a) {
    stdAmt = getAmtInStdFormat(b);
    return low_fnValidateTotAmount(stdAmt, a)
}

function low_fnValidateTotAmount(b, a) {
    var g = 19;
    var c = 17;
    var f = finbranchResArr.get("FAT000870");
    var e = finbranchResArr.get("FAT000871");
    var d = finbranchResArr.get("FAT000872");
    var h = false;
    h = fnCommonValAmount(b, a, c, g, f, e, d);
    if (!h) {
        return false
    }
    return true
}

function fnAlphaCheck(FldObj) {
    var validChars = /[^A-Za-z0-9_]/;
    var obj = "document.forms[0]." + FldObj;
    if (validChars.test((eval(obj)).value)) {
        alert(finbranchResArr.get("FAT000485"));
        (eval(obj)).focus();
        return false
    }
    return true
}

function showHPYRGCustSearcher(d, e, c, b, g) {
    var a = document.forms[0].funcCode.value;
    var f = "V";
    if (fnIsNull(document.forms[0].funcCode.value)) {
        alert(finbranchResArr.get("FAT000200"));
        document.forms[0].funcCode.focus()
    } else {
        if (a == f) {
            showDynSearcher(d, e, c, b, g)
        } else {
            showCifId(document.forms[0].cust_id, "ctrl", "F", document.forms[0].cust_name)
        }
    }
}

function setFieldValue(fieldName, fieldValue, isFldDisable) {
    var fldLength = null;
    var fld = null;
    var visualFldId = null;
    var visualFld = null;
    var dataType = null;
    try {
        if (fieldName.indexOf("document.forms[0].") == -1) {
            fld = eval("document.forms[0]." + fieldName)
        } else {
            fld = eval(fieldName)
        }
        if (isEmptyObj(fld)) {
            return true
        } else {
            fldLength = fld.length
        }
        if (isEmptyObjValue(fieldValue)) {
            fieldValue = ""
        }
        if (isEmptyObjValue(isFldDisable)) {
            isFldDisable = "N"
        }
        if (!isNaN(fldLength) && ("radio" == fld[0].type || "checkbox" == fld[0].type)) {
            for (i = 0; i < fldLength; i++) {
                if (fld[i].disabled == true && "Y" != isFldDisable) {
                    return false
                }
                if (fld[i].value == fieldValue) {
                    fld[i].checked = true;
                    break
                }
            }
        } else {
            visualFldId = fld.getAttribute("vFldId");
            if (fld.type == "hidden" && !isEmptyObjValue(visualFldId)) {
                if ((visualFldId.indexOf("document.")) == -1) {
                    visualFld = eval("document.forms[0]." + visualFldId)
                } else {
                    visualFld = eval(visualFldId)
                }
                dataType = visualFld.getAttribute("fdt");
                if (visualFld.disabled == true && "Y" != isFldDisable) {
                    return false
                }
                if ("amount" != dataType && "totamount" != dataType) {
                    if ("checkbox" == visualFld.type) {
                        if (fieldValue == visualFld.getAttribute("vCheck")) {
                            visualFld.checked = true
                        } else {
                            if (fieldValue == visualFld.getAttribute("vUnCheck")) {
                                visualFld.checked = false
                            } else {
                                visualFld.checked = false;
                                fld.value = visualFld.getAttribute("vUnCheck");
                                return false
                            }
                        }
                    } else {
                        dataType = visualFld.getAttribute("datatype");
                        var locDateType = visualFld.getAttribute("fdt");
                        if (dataType == "date" || locDateType == "uidate" || locDateType == "datetime") {
                            visualFld.value = fnConvertToUIDate(fieldValue)
                        } else {
                            visualFld.value = fieldValue
                        }
                    }
                } else {
                    fld = visualFld
                }
            }
            if (fld.disabled == true && "Y" != fld.getAttribute("fds") && "Y" != isFldDisable) {
                return false
            }
            fld.value = fieldValue
        }
    } catch (err) {
        return false
    }
    return true
}

function getFieldValue(fieldName, useVisualFld) {
    var val = null;
    var fldLength = null;
    var fld = null;
    var tmpFld = null;
    var fld = null;
    try {
        if (isEmptyObjValue(useVisualFld)) {
            useVisualFld = "Y"
        }
        if (fieldName.indexOf("document.forms[0].") == -1) {
            fld = eval("document.forms[0]." + fieldName)
        } else {
            fld = eval(fieldName)
        }
        if (isEmptyObj(fld)) {
            return null
        } else {
            fldLength = fld.length
        }
        if (!isNaN(fldLength) && ("radio" == fld[0].type || "checkbox" == fld[0].type)) {
            val = "";
            for (i = 0; i < fldLength; i++) {
                if (fld[i].checked == true) {
                    val = fld[i].value;
                    break
                }
            }
        } else {
            visualFldId = fld.getAttribute("vFldId");
            if (fld.type == "hidden" && !isEmptyObjValue(visualFldId) && useVisualFld != "N") {
                tmpFld = eval("document.forms[0]." + visualFldId);
                if (!isEmptyObj(tmpFld) && "checkbox" != tmpFld.type) {
                    fld = tmpFld
                }
            }
            val = fld.value
        }
    } catch (err) {
        return null
    }
    return val
}

function suppressEnterKey(a) {
    var b = a.which ? a.which : a.keyCode;
    if (b == 13) {
        if ("Netscape" == browser_name) {
            return false
        }
        a.returnValue = false
    }
}

function fnCommonFetchAcctDtls(f, d, c, a, b, e) {
    var g = f.id;
    wReturnDesc = a + "|" + c + "|" + d + "|" + g;
    ret = fnLowCommonFetchAcctDtls(f, wReturnDesc, b, e);
    return (ret)
}

function fnLowCommonFetchAcctDtls(g, a, h, b) {
    var l = false;
    var m = ["VALACCTID", "VALCUSTACCTID", "VALOFFACCTID", "VALVRFDACCTID", "VALCLSDOFFACCT", "VALUNVRFDOFFACCTID", "VALVRFDACCTID1", "ACCTFETCHWITHBAL", "VALACCTIDWITHCLSDFLG"];
    if (!fnIsNull(a) && a != undefined) {
        var d = a.split("|");
        var e = d.length - 1;
        if (e > 0) {
            for (var c = 0; c < e; c++) {
                clearDescField(d[c])
            }
        }
    }
    for (var f = 0; f < m.length; f++) {
        if (b == m[f]) {
            l = true;
            break
        }
    }
    if (!l) {
        b = "VALACCTID"
    }
    if (!fnIsNull(g.value)) {
        retVal = sendDataToServer("dummyFrame", b, "F", g.id, a);
        if (!retVal && h) {
            setFieldFocus(g);
            return false
        }
    }
    return true
}

function mask(objId, hypLnk) {
    str = "";
    if (eval("document.forms[0]." + objId) != undefined) {
        iLength = eval("document.forms[0]." + objId + ".size");
        for (iCnt = 0; iCnt < iLength; iCnt++) {
            str = str + "*"
        }
        obj = eval("document.forms[0]." + objId);
        obj.maxlength = iLength;
        obj.value = str;
        obj.disabled = true;
        hideImage(hypLnk)
    }
}

function unmask(objId, hypLnk) {
    str = "";
    if (eval("document.forms[0]." + objId) != undefined) {
        obj = eval("document.forms[0]." + objId);
        obj.value = "";
        showImage(hypLnk);
        obj.disabled = false
    }
}

function getAmtInCustomFormat(a) {
    if (fnIsNull(a)) {
        return a
    }
    var c = a.indexOf(DEF_DECIMAL_SEPARATOR);
    if (c == -1) {
        return replace(a, DEF_MANTISSA_SEPARATOR, MANTISSA_SEPARATOR)
    }
    var b = a.substring(0, c);
    var d = a.substring(c + 1);
    b = replace(b, DEF_MANTISSA_SEPARATOR, MANTISSA_SEPARATOR);
    return b + DECIMAL_SEPARATOR + d
}

function getUnitsInCustomFormat(a) {
    if (fnIsNull(a)) {
        return a
    }
    a = removeMantissa(a);
    var c = a.indexOf(DEF_DECIMAL_SEPARATOR);
    if (c == -1) {
        return replace(a, DEF_MANTISSA_SEPARATOR, MANTISSA_SEPARATOR)
    }
    var b = a.substring(0, c);
    var d = a.substring(c + 1);
    b = replace(b, DEF_MANTISSA_SEPARATOR, MANTISSA_SEPARATOR);
    return b
}

function getUnitInCustomFormat(a) {
    if (fnIsNull(a)) {
        return a
    }
    a = removeMantissa(a);
    var c = a.indexOf(DEF_DECIMAL_SEPARATOR);
    if (c == -1) {
        return replace(a, DEF_MANTISSA_SEPARATOR, MANTISSA_SEPARATOR)
    }
    var b = a.substring(0, c);
    return b
}

function getAmtInStdFormat(b) {
    if (fnIsNull(b)) {
        return b
    }
    b = removeMantissa(b);
    var a = b.indexOf(DECIMAL_SEPARATOR);
    if (a == -1) {
        return b
    }
    return replace(b, DECIMAL_SEPARATOR, DEF_DECIMAL_SEPARATOR)
}

function removeMantissa(a) {
    sNew = "";
    var b = a.split(MANTISSA_SEPARATOR);
    for (i = 0; i < b.length; i++) {
        if (b[i] != null) {
            sNew = sNew + b[i]
        }
    }
    return sNew
}

function replace(d, b, e) {
    var f = d.split(b);
    var a = "";
    for (var c = 0; c < f.length; c++) {
        a += f[c];
        if ((c + 1) != f.length) {
            a += e
        }
    }
    return a
}

function low_isValidAmt(amt) {
    var amtLen = amt.length;
    var lastChar = (amt.charAt(amtLen - 1)).toUpperCase();
    if (isNaN(lastChar) && lastChar != ".") {
        var str = amt.substring(0, amtLen - 1);
        if (isNaN(str)) {
            alert(finbranchResArr.get("FAT000518"));
            return false
        }
        var val = "";
        if (eval("this.custGetAmountCodeValue") != undefined) {
            val = custGetAmountCodeValue(lastChar)
        } else {
            val = getAmountCodeValue(lastChar)
        }
        if (val == undefined) {
            alert("Enter Valid Amount Code.");
            return false
        } else {
            return true
        }
    }
    if (isNaN(amt)) {
        alert(finbranchResArr.get("FAT000518"));
        return false
    }
    var regExp = /[Ee]/g;
    if (regExp.test(amt)) {
        alert(finbranchResArr.get("FAT000518"));
        return false
    }
    return true
}

function low_convertAmt(amt) {
    var amtLen = amt.length;
    var lastChar = (amt.charAt(amtLen - 1)).toUpperCase();
    var firstChar = (amt.charAt(0)).toUpperCase();
    var str = amt.substring(0, amtLen - 1);
    var val = "";
    if (eval("this.custGetAmountCodeValue") != undefined) {
        val = custGetAmountCodeValue(lastChar)
    } else {
        val = getAmountCodeValue(lastChar)
    }
    if (val != undefined) {
        if (str.length == 0) {
            str = "1"
        }
        amt = Math.round(str * val) + ""
    }
    if (firstChar == "+") {
        amt = amt.replace("+", "")
    }
    return amt
}

function low_validateUnitWithPrec(e, d, a, b) {
    var c = "999999999";
    if (low_fnSubtractAmt(e, c) > 0) {
        alert(finbranchResArr.get("FAT008554"));
        return false
    }
    if (!fnValidateStdUnit(e, d, a, b)) {
        return false
    }
    return true
}

function low_validateAmtWithPrec(e, a, b) {
    var d = (b == "totamount");
    var c = (d) ? "9999999999999999999" : "99999999999999999";
    if (low_fnSubtractAmt(e, c) > 0) {
        alert(finbranchResArr.get("FAT003216"));
        return false
    }
    if (d) {
        if (!low_fnValidateTotAmount(e, a)) {
            return false
        }
        return true
    }
    if (!fnValidateStdAmount(e, a)) {
        return false
    }
    return true
}

function fnValidateAmount(b, a) {
    b = getAmtInStdFormat(b);
    return fnValidateStdAmount(b, a)
}

function low_formatAmt(g, c, l, b, o, h) {
    var p = (o != "Y");
    var e = !fnIsNull(l);
    var m = !fnIsNull(b);
    g = (fnTrim(g)).toUpperCase();
    if (g != "MILLION" && g != "LAKH") {
        alert("Invalid Amount Format.");
        low_setAmtFldFocus(p, c, h);
        return false
    }
    var a = (p) ? c.value : c;
    a = fnTrim(a);
    if (fnIsNull(a)) {
        if (!p) {
            return c
        }
        return
    }
    a = removeMantissa(a);
    a = getAmtInStdFormat(a);
    if (!low_isValidAmt(a)) {
        low_setAmtFldFocus(p, c, h);
        return false
    }
    a = low_convertAmt(a);
    if (e) {
        b = getPrec(l)
    }
    if (!e && !m) {
        var f = 0;
        var d = 0;
        b = "2";
        d = a.indexOf(DEF_DECIMAL_SEPARATOR);
        if (d != -1) {
            f = a.substring(d + 1).length
        }
        if (f > b) {
            b = f
        }
    }
    if (p && !low_validateAmtWithPrec(a, b, c.getAttribute("fdt"))) {
        low_setAmtFldFocus(p, c, h);
        return false
    }
    a = checkZeroes(a, b);
    if (g == "MILLION") {
        a = formatToMillion1(a, b)
    } else {
        a = formatToLakh1(a, b)
    }
    a = getAmtInCustomFormat(a);
    if (p) {
        c.value = a
    } else {
        document.write(a)
    }
    return true
}

function low_setAmtFldFocus(b, c, a) {
    if (b) {
        if (!c.disabled) {
            c.focus();
            if (null == a || a == undefined) {
                setTimeout("document.forms[0]." + c.id + ".focus()", 10)
            } else {
                setTimeout("document.forms[0]." + c.id + "[" + a + "].focus()", 10)
            }
        }
    }
    return
}

function fnValidateStdUnit(o, e, g, s) {
    var r = (s == "Y") ? "0" : "6";
    var d = 0;
    var b = 0;
    var l = 0;
    var q = 0;
    var c = 0;
    var p = true;
    var h = removeMantissa(e.value);
    var m = 9;
    var f = 16;
    var p = true;
    var h = removeCommas(o);
    var a = 16;
    if (isNaN(h)) {
        p = false;
        alert(finbranchResArr.get("FAT000189"))
    } else {
        r = r > g ? g : r;
        h = checkZeroes(h, g);
        l = h.indexOf(DEF_DECIMAL_SEPARATOR);
        if (l == -1) {
            d = h
        } else {
            d = h.substring(0, l);
            b = h.substring(l + 1)
        }
        if (h.length > f && g != 0) {
            p = false;
            alert(finbranchResArr.get("FAT000523") + f + finbranchResArr.get("FAT008555"))
        } else {
            if (g == 0 && h.length > a) {
                p = false;
                alert(finbranchResArr.get("FAT000523") + a + finbranchResArr.get("FAT008555"))
            } else {
                if (d.length > m && g != 0) {
                    p = false;
                    alert(finbranchResArr.get("FAT000525"))
                } else {
                    if (b.length > r) {
                        p = false;
                        alert(finbranchResArr.get("FAT000523") + r + " " + finbranchResArr.get("FAT000526"))
                    } else {
                        switch (parseInt(r, 10)) {
                            case 3:
                                if (d.length > 13) {
                                    p = false;
                                    alert(finbranchResArr.get("FAT000527") + r)
                                }
                                break;
                            case 4:
                                if (d.length > 12) {
                                    p = false;
                                    alert(finbranchResArr.get("FAT000528") + r)
                                }
                                break
                        }
                    }
                }
            }
        }
    }
    return p
}

function fnValidateStdAmount(l, e) {
    var c = 0;
    var b = 0;
    var f = 0;
    var m = true;
    var g = removeCommas(l);
    var o = 4;
    var h = 14;
    var d = 17;
    var a = 16;
    if (isNaN(g)) {
        m = false;
        alert(finbranchResArr.get("FAT000189"))
    } else {
        o = o > e ? e : o;
        g = checkZeroes(g, e);
        f = g.indexOf(DEF_DECIMAL_SEPARATOR);
        if (f == -1) {
            c = g
        } else {
            c = g.substring(0, f);
            b = g.substring(f + 1)
        }
        if (g.length > d && e != 0) {
            m = false;
            alert(finbranchResArr.get("FAT000523") + d + finbranchResArr.get("FAT000524"))
        } else {
            if (e == 0 && g.length > a) {
                m = false;
                alert(finbranchResArr.get("FAT000523") + a + finbranchResArr.get("FAT000524"))
            } else {
                if (c.length > h && e != 0) {
                    m = false;
                    alert(finbranchResArr.get("FAT000525"))
                } else {
                    if (b.length > o) {
                        m = false;
                        alert(finbranchResArr.get("FAT000523") + o + " " + finbranchResArr.get("FAT000526"))
                    } else {
                        switch (parseInt(o, 10)) {
                            case 3:
                                if (c.length > 13) {
                                    m = false;
                                    alert(finbranchResArr.get("FAT000527") + o)
                                }
                                break;
                            case 4:
                                if (c.length > 12) {
                                    m = false;
                                    alert(finbranchResArr.get("FAT000528") + o)
                                }
                                break
                        }
                    }
                }
            }
        }
    }
    return m
}

function getDecIndex(a) {
    if (fnIsNull(a)) {
        return -1
    }
    return a.indexOf(DECIMAL_SEPARATOR)
}

function getAmtInInt(b) {
    var a = getAmtInStdFormat(b);
    return parseInt(a, 10)
}

function getAmtInFloat(b) {
    var a = getAmtInStdFormat(b);
    return parseFloat(a)
}

function fnIsValidContextDate(b) {
    var d;
    var c = 1900;
    a = b.value;
    if (a == "") {
        return false
    }
    if (a.indexOf("/") != -1) {
        var a = a.split("/")
    } else {
        if (a.indexOf("-") != -1) {
            var a = a.split("-")
        } else {
            if (a.indexOf(".") != -1) {
                var a = a.split(".")
            } else {
                return false
            }
        }
    }
    a_strDay = a[0];
    a_strMonth = a[1];
    a_strYear = a[2];
    if (a_strDay.length == 1) {
        a_strDay = "0" + a_strDay
    }
    if (a_strMonth.length == 1) {
        a_strMonth = "0" + a_strMonth
    }
    d = b.getAttribute("fdob");
    if (d != null && d == "Y") {
        c = 1850
    }
    if ((isNaN(a_strYear)) || (isNaN(a_strMonth)) || (isNaN(a_strDay)) || a_strDay.length <= 1) {
        return false
    } else {
        if ((a_strYear < c) || (a_strYear > 2099) || (a_strMonth > 12) || (a_strMonth < 1) || (a_strDay < 1) || (a_strDay > 31) || (((a_strMonth == 4) || (a_strMonth == 6) || (a_strMonth == 9) || (a_strMonth == 11)) && (a_strDay > 30))) {
            return false
        } else {
            if ((a_strYear % 4 == 0) && ((a_strYear % 100 != 0) || (a_strYear % 400 == 0))) {
                if ((a_strMonth == 2) && ((a_strDay > 29) || (a_strDay < 1))) {
                    return false
                }
            } else {
                if ((a_strMonth == 2) && ((a_strDay > 28) || (a_strDay < 1))) {
                    return false
                }
            }
        }
    }
    return true
}

function getValInStdFormat(c) {
    if (fnIsNull(c)) {
        return c
    }
    var d = "";
    var a;
    var e = c;
    for (var b = 0; b < e.length; b++) {
        a = e.charAt(b);
        if (a == MANTISSA_SEPARATOR) {
            a = DEF_MANTISSA_SEPARATOR
        } else {
            if (a == DECIMAL_SEPARATOR) {
                a = DEF_DECIMAL_SEPARATOR
            }
        }
        d += a
    }
    return d
}

function getValInCustomFormat(a) {
    if (fnIsNull(a)) {
        return a
    }
    return replace(a, DEF_DECIMAL_SEPARATOR, DECIMAL_SEPARATOR)
}

function isNumber(b) {
    b = removeMantissa(b);
    var a = getValInStdFormat(b);
    return (!isNaN(a))
}

function getValInInt(b) {
    var a = getValInStdFormat(b);
    return parseInt(a, 10)
}

function getValInFloat(b) {
    var a = getValInStdFormat(b);
    return parseFloat(a)
}

function getValInNumber(b) {
    var a = getValInStdFormat(b);
    return Number(a)
}

function fnExplodeAcct(c, b) {
    var d = document.forms[0];
    var a;
    convertToCaps();
    if (b == "N") {
        a = (!isEmptyObjValue(c)) ? c.toUpperCase() : ""
    } else {
        a = (!isEmptyObj(c)) ? c.value : ""
    }
    if (d.action.indexOf(JSP_PARAMS_AVAILABLE) != -1) {
        d.action = d.action + "&rtId=" + rtId + "&expAcctId=" + escape(a)
    } else {
        d.action = d.action + "?rtId=" + rtId + "&expAcctId=" + escape(a)
    }
    doSubmit(ACCOUNT_EXPLODE)
}

function linkHide(d, b) {
    var c = "";
    if (b) {
        c = "none"
    }
    var a = get_lyr_css(d);
    if (a) {
        a.display = c
    }
}

function focusOnRadio(c) {
    var b = null;
    var d = false;
    if (isEmptyObj(c)) {
        return false
    }
    len = c.length;
    for (var a = 0; a < len; a++) {
        b = c[a];
        if (b.checked == true && b.disabled == false) {
            b.focus();
            return true
        }
    }
    if (len > 0 && c[0].disabled == false) {
        c[0].focus();
        return true
    }
    return true
}

function validateDateOnBlur(dateObject) {
    dateObj = eval("document.forms[0]." + dateObject);
    if (!(fnIsValidDate(dateObj))) {
        alert(finbranchResArr.get("FAT000081"));
        fnSetFocusForDate(dateObj);
        return false
    }
}

function fnIsValidTimeHHMM(g) {
    var d = /[^0-9:]/g;
    var b = g.value;
    var h = b.substr(2, 1);
    if (fnIsNull(b)) {
        return true
    }
    if (d.test(b) || h != ":") {
        alert(finbranchResArr.get("FAT001286"));
        return false
    }
    if (b.length != 5) {
        alert(finbranchResArr.get("FAT001286"));
        return false
    }
    var e = b.substr(0, 2);
    var a = b.substr(3, 2);
    if (isNaN(e) || isNaN(a)) {
        return false
    }
    var c = Number(e);
    var f = Number(a);
    if (c < 0 || c > 23 || f < 0 || f > 59) {
        alert(finbranchResArr.get("FAT001287"));
        return false
    }
    return true
}

function writeRefFooter() {
    funcName = "this.locfnwriteRefFooter";
    if (eval(funcName) != undefined) {
        eval(funcName).call(this)
    }
    writeFooter()
}

function getValueOfArgument(a, m) {
    if (undefined == m || null == m || fnTrim(m).length == 0 || "" == m) {
        return ""
    }
    var l;
    var e = m.split("|");
    var q = null;
    var d = null;
    var o = null;
    var r = -1;
    var c = null;
    var h = null;
    var s = "";
    var p = details.getValues();
    var g = "";
    var b = details.getHeader();
    if (undefined == b && b == null) {
        return
    }
    for (i = 0; i < e.length; i++) {
        s = "";
        o = e[i];
        if (o.indexOf(":") != -1) {
            q = o.split("=");
            for (j = 0; j < q.length; j++) {
                d = q[j];
                if ((r = d.indexOf(":")) != -1) {
                    h = d.substring(r + 1, d.length);
                    l = "N";
                    for (var f = 0; f < b.length; f++) {
                        if (h == b[f].getFieldName()) {
                            c = getValueFromArray(a, details, h);
                            l = "Y"
                        }
                    }
                    if (l == "N") {
                        c = getValueFromSummArray(details, h)
                    }
                    g += c + "|"
                }
            }
        }
    }
    return g
}

function RelaciExplodes(d, c) {
    var b = null;
    var a = getValueOfArgument(d, c);
    tmp = a.split("|");
    table_indicator = tmp[0];
    acct_num = tmp[1];
    srl_num = tmp[2];
    if (table_indicator == "T") {
        fnExplodeAccount(acct_num, "N")
    } else {
        b = "../inquiry/inquiry_ctrl.jsp?mo=RENHIST&actionCode=SUBMIT&renhist.foracid=" + acct_num + "&renhist.ren_srl_no=" + srl_num + "";
        formUrl(b)
    }
}

function LimndiExplodes(d, c) {
    var b = null;
    var a = getValueOfArgument(d, c);
    tmp = a.split("|");
    table_indicator = tmp[0];
    entity_id = tmp[1];
    sol_id = tmp[2];
    entity_ind = tmp[3];
    switch (table_indicator) {
        case "A":
            fnExplodeAccount(entity_id, "N");
            break;
        case "D":
            if (entity_ind == "INWARD DC") {
                b = "../idcm/idcm_ctrl.jsp?mo=IDCM&actionCode=init&idcm.funcCode=I&idcm.idcmNum=" + entity_id + "&idcm.solId=" + sol_id
            } else {
                if (entity_ind == "OUTWARD DC") {
                    b = "../odcm/odcm_ctrl.jsp?mo=ODCM&actionCode=init&odcm.funcCode=I&odcm.odcmNum=" + entity_id + "&odcm.solId=" + sol_id
                }
            }
            document.forms[0].calledMenu.value = b;
            doSubmitForm("INVOKE_GROUP_RECORD");
            break;
        case "G":
            if (entity_ind == "INWARD BANK GUARANTEE") {
                b = "../igm/igm_ctrl.jsp?mo=IGM&actionCode=init&igm.funcCode=I&igm.bgSrlNum=" + entity_id + "&igm.solId=" + sol_id
            } else {
                if (entity_ind == "OUTWARD BANK GUARANTEE") {
                    b = "../ogm/ogm_ctrl.jsp?mo=OGM&actionCode=init&ogm.funcCode=I&ogm.bgSrlNum=" + entity_id + "&ogm.solId=" + sol_id
                }
            }
            document.forms[0].calledMenu.value = b;
            doSubmitForm("INVOKE_GROUP_RECORD");
            break;
        case "B":
            if (entity_ind == "IMPORT BILL") {
                b = "../miib/miib_ctrl.jsp?mo=MIIB&actionCode=init&miib.funcCode=I&miib.billId=" + entity_id + "&miib.solId=" + sol_id
            } else {
                if (entity_ind == "EXPORT BILL") {
                    b = "../fbm/fbm_ctrl.jsp?mo=MEOB&actionCode=init&fbm.funcCode=I&fbm.billId=" + entity_id + "&fbm.solId=" + sol_id
                }
            }
            document.forms[0].calledMenu.value = b;
            doSubmitForm("INVOKE_GROUP_RECORD");
            break;
        case "F":
            b = "../mntfwc/mntfwc_ctrl.jsp?mo=MNTFWC&actionCode=init&mntfwc.funcCode=I&mntfwc.FwdCntrctNo=" + entity_id + "&mntfwc.solId=" + sol_id;
            document.forms[0].calledMenu.value = b;
            doSubmitForm("INVOKE_GROUP_RECORD");
            break;
        case "C":
            b = "../mbco/mbco_ctrl.jsp?mo=MBCO&actionCode=init&mbco.funcCode=I&mbco.buyersCreditNo=" + entity_id + "&mbco.solId=" + sol_id;
            document.forms[0].calledMenu.value = b;
            doSubmitForm("INVOKE_GROUP_RECORD");
            break;
        default:
            alert("Invalid indicator !");
            break
    }
}

function doRefSubmit(objBtn) {
    funcName = "this.locfndoRefSubmit";
    if (eval(funcName) != undefined) {
        eval(funcName).call(this, objBtn)
    } else {
        doSubmit(objBtn.id)
    }
}

function setChkBoxFldArr(fldName, maxRecs) {
    var frm = document.forms[0];
    var cbId = "frm.chk" + fldName;
    var fldId = "frm." + fldName;
    var cbObj;
    var fldObj;
    for (var i = 0; i < maxRecs; i++) {
        cbObj = eval(cbId + "[" + i + "]");
        fldObj = eval(fldId + "[" + i + "]");
        fldObj.value = (cbObj.checked) ? "Y" : "N"
    }
}

function setChkBoxArr(fldName, maxRecs) {
    var frm = document.forms[0];
    var cbId = "frm.chk" + fldName;
    var fldId = "frm." + fldName;
    var cbObj;
    var fldObj;
    for (var i = 0; i < maxRecs; i++) {
        fldObj = eval(fldId + "[" + i + "]");
        cbObj = eval(cbId + "[" + i + "]");
        cbObj.checked = (fldObj.value == "Y")
    }
}

function getFABUrl(ctrlArr, menuName, protocol) {
    var ctrlLen = ctrlArr.length;
    var appRouter = "AppRouter";
    url = self.location.protocol + "//" + fabBaseUrl + "/";
    url += appRouter + "?sessionid=" + sessionid;
    url = protocol + "//" + fabBaseUrl + "/";
    url += ctrlArr[4] + "?sessionid=" + sessionid;
    url += "&sectok=" + sectok + "&finsessionid=" + finsessionid;
    if (this.isLoggedInFab != undefined && isLoggedInFab) {
        url += "&fabsessionid=" + fabsessionid;
    } else {
        url += "&fabsessionid=";
    }
    if (menuName != undefined && menuName != null) {
        url += "&mo=" + menuName;
    }
    url += "&mprec=" + finConst.FAB_PREC;

    if (isONSLogin) {
        url += "&invokeType=PUREONS";
    } else {
        url += "&invokeType=ONS";
    }
    if (ctrlLen >= 8 && ctrlArr[7] != "") {
        url += '&sid=' + ctrlArr[7];
    }
    if (ctrlLen >= 11 && ctrlArr[10] != "") {
        url += '&mid=' + ctrlArr[10];
    }

    url += "&calendarBase=" + calbase;

    return url;
}


function handleWindowDisplay(evtCode, params) {
    try {
        var isSSO = (this.SSO != undefined && SSO);
        if (isSSO) {
            var parentObj = window.parent;
            switch (evtCode) {
                case finConst.DISPLAYPARENT:
                    if (!isONSLogin) {
                        parentObj.frames[finConst.FINFRAME].location.href = finContextPath + "/arjspmorph/onssessioncleanup.jsp?rtId=" + rtId;
                        parentObj.frames[finConst.APPLETFRAME].sendHTMLResp("STDOUT.ErrorCode=5&STDOUT.ErrorDesc=Released");
                    } else if (CURR_GROUP_NAME != undefined && CURR_GROUP_NAME == "arjspmorph") {
                        self.close();
                    }
                    break;
                case finConst.DOLOGOUT:
                    //Return from here if the forced logout got fired already
                    if (params != undefined && params[0] == finConst.FORCED_LOGOUT && logoutFiredAlready)
                        return;

                    if (this.isONSLogin == undefined) {
                        window.returnValue = "TIMEOUT";
                        self.close();
                        return;
                    }
                    if (params != undefined && params[0] == finConst.FORCED_LOGOUT) {
                        alert(finbranchResArr.get("FAT001912"));
                    }
                    if (isONSLogin) {
                        var logoutType = (params != undefined) ? params[0] : finConst.NORMAL_LOGOUT;
                        var logoutAction = finConst.LML_LOGOUT_EVT;
                        if (logoutType == finConst.NORMAL_LOGOUT) {
                            logoutAction = getLogoutAction();

                            if (finConst.ACTION_CANCEL == logoutAction) {
                                break;
                            }
                            parentObj.showHTMLWindow(finConst.FINFRAME);
                        }
                        parentObj.doLogout(logoutAction);
                        logoutFiredAlready = true;
                    } else {
                        parentObj.frames[finConst.FINFRAME].location.href = finContextPath + "/arjspmorph/onssessioncleanup.jsp?rtId=" + rtId;
                        parentObj.frames[finConst.APPLETFRAME].sendHTMLResp("STDOUT.ErrorCode=5&STDOUT.ErrorDesc=Released");
                        parentObj.frames[finConst.APPLETFRAME].BancsApplet.logoutExternal();
                    }
                    break;
                case finConst.CONTEXTSWITCH:
                    var ssoAppServer = params[0];
                    var data = params[1];
                    var rule = params[2];
                    var winObj = parentObj.parent;
                    winObj.invokeApplicationContext(ssoAppServer, data, rule);
                    break;
                case finConst.WFCRMCONTEXTSWITCH:
                    var ssoAppServer = params[0];
                    var data = params[1];
                    var rule = params[2];
                    var winObj = parentObj;
                    if (!isONSLogin) {
                        parentObj.frames[finConst.APPLETFRAME].sendHTMLResp("STDOUT.ErrorCode=5&STDOUT.ErrorDesc=Released");
                        winObj = parentObj.parent;
                    }
                    winObj.parent.invokeApplicationContext(ssoAppServer, data, rule);
                    break;

                case finConst.SHOWAUTH:
                    var retVal = top.loginFrame.validateAuthorizer("Authorizer Login Page");
                    return retVal;
            }
        } else {
            switch (evtCode) {
                case finConst.DISPLAYPARENT:
                    if (CURR_GROUP_NAME != undefined && CURR_GROUP_NAME == "arjspmorph") {
                        self.close();
                    }
                    break;
                case finConst.DOLOGOUT:
                    document.location.href = finContextPath + "/arjspmorph/cleanup.jsp?rtId=" + rtId + "&logout=YES";
                    break;
            }
        }
    } catch (e) {
        var msg = (typeof(e.length) == "undefined") ? e.message : e;
        alert("Error Occured (handleWindowDisplay) : " + msg);
    }
}


function getLogoutAction() {
    var literalList = "FLT015139|FLT000192";
    var actionList = finConst.LML_LOGOUT_EVT + "|" + finConst.ACTION_CANCEL;
    var pW = "20";
    var pH = "10";
    var dW = "17";
    var dH = "9";

    if (isLoggedInFin && isLoggedInFab) {
        literalList = "FLT015137|FLT015138|FLT015139|FLT000192";
        actionList = finConst.LML_DCLOGOUT_EVT + "|" + finConst.LML_FABLOGOUT_EVT + "|" + finConst.LML_LOGOUT_EVT + "|" + finConst.ACTION_CANCEL;
        pW = "20";
        pH = "10";
        dW = "24";
        dH = "10";
    }

    var retVal = showConfirm("FLT015136", literalList, actionList, pW, pH, dW, dH);
    if (!isEmptyObjValue(retVal)) {
        return retVal;
    }
    return finConst.ACTION_CANCEL;
}

function getSSOSessId() {
    return top.loginFrame.getSessionID();
}

function MenuProperties() {
    //'self' variable is needed as few problems arised while accessing the object across the frames.
    this.self = null;
    this.usrMenuId = null;
    this.finMenu = null;
    this.fabMenu = null;
    this.crvMenu = null;
    this.portalTabMenu = null;
    this.portalLhnAMenu = null;
    this.portalLhnBMenu = null;
    this.miscMenu = null;
    this.bgMenu = null;
    this.isBackground = false;

    this.setMenuObj = setMenuPropObj;
    this.setBgMode = setBackgroundMode;
    this.isBgMode = getBackgroundMode;
    this.setUsrMenuId = setUserMenuId;
    this.setFinMenu = setFinMenuArr;
    this.getFinMenu = getFinMenuArr;
    this.setFabMenu = setFabMenuArr;
    this.getFabMenu = getFabMenuArr;
    this.setCrvMenu = setCrvMenuArr;
    this.getCrvMenu = getCrvMenuArr;
    this.setMenuProps = setMenuPropArr;
    this.setBgMenu = setBgMenuArr;
    this.getBgMenu = getBgMenuArr;
    this.setPortalTabMenu = setTabMenuArr;
    this.getPortalTabMenu = getTabMenuArr;
    this.setPortalLhnAMenu = setLhnAMenuArr;
    this.getPortalLhnAMenu = getLhnAMenuArr;
    this.setPortalLhnBMenu = setLhnBMenuArr;
    this.getPortalLhnBMenu = getLhnBMenuArr;
    this.setMiscMenu = setMiscMenuArr;
    this.getMiscMenu = getMiscMenuArr;
    this.getMenuInfo = getMenuData;
}

function setMenuPropObj(obj) {
    this.self = (obj == null || obj == undefined) ? null : obj;
}

function setUserMenuId(id) {
    this.usrMenuId = id;
}

function setBackgroundMode(bool) {
    this.isBackground = (bool == true);
}

function setFinMenuArr(finArr) {
    this.finMenu = (finArr == null || finArr == undefined) ? new Array() : finArr;
}

function setFabMenuArr(fabArr) {
    this.fabMenu = (fabArr == null || fabArr == undefined) ? new Array() : fabArr;
}

function setCrvMenuArr(crvArr) {
    this.crvMenu = (crvArr == null || crvArr == undefined) ? new Array() : crvArr;
}

function setBgMenuArr(bgArr) {
    this.bgMenu = (bgArr == null || bgArr == undefined) ? new Array() : bgArr;
}

function setTabMenuArr(portalTabArr) {
    this.portalTabMenu = (portalTabArr == null || portalTabArr == undefined) ? new Array() : portalTabArr;
}

function setLhnAMenuArr(portalLhnAArr) {
    this.portalLhnAMenu = (portalLhnAArr == null || portalLhnAArr == undefined) ? new Array() : portalLhnAArr;
}

function setLhnBMenuArr(portalLhnBArr) {
    this.portalLhnBMenu = (portalLhnBArr == null || portalLhnBArr == undefined) ? new Array() : portalLhnBArr;
}

function setMiscMenuArr(miscArr) {
    this.miscMenu = (miscArr == null || miscArr == undefined) ? new Array() : miscArr;
}

function getBackgroundMode() {
    return this.isBackground;
}

function getFinMenuArr() {
    return this.finMenu;
}

function getFabMenuArr() {
    return this.fabMenu;
}

function getCrvMenuArr() {
    return this.crvMenu;
}

function getBgMenuArr() {
    return this.bgMenu;
}

function getTabMenuArr() {
    return this.portalTabMenu;
}

function getLhnAMenuArr() {
    return this.portalLhnAMenu;
}

function getLhnBMenuArr() {
    return this.portalLhnBMenu;
}

function getMiscMenuArr() {
    return this.miscMenu;
}

function setMenuPropArr(menuId, finArr, fabArr, crvArr, bgArr, portalTabArr, portalLhnAArr, portalLhnBArr, miscArr) {
    var usrMenuId = this.usrMenuId;
    if (usrMenuId != menuId) {
        alert(finbranchResArr.get("FAT001742"));
        return;
    }
    this.self.setFinMenu(finArr);
    this.self.setFabMenu(fabArr);
    this.self.setCrvMenu(crvArr);
    this.self.setBgMenu(bgArr);
    this.self.setPortalTabMenu(portalTabArr);
    this.self.setPortalLhnAMenu(portalLhnAArr);
    this.self.setPortalLhnBMenu(portalLhnBArr);
    this.self.setMiscMenu(miscArr);
}

function getMenuData(menuName) {
    var finMenuArr = this.self.getFinMenu();
    var fabMenuArr = this.self.getFabMenu();
    var crvMenuArr = this.self.getCrvMenu();
    var bgMenuArr = this.self.getBgMenu();
    var miscMenuArr = this.self.getMiscMenu();
    var isBgMode = this.self.isBgMode();
    var menuInfoArr = null;

    if (!isBgMode && (menuName == finConst.HOME_MENU || menuName == finConst.FAB_ROOT_MENU || menuName == finConst.FAV_ROOT_MENU)) {
        return getMenuArr(menuName, miscMenuArr);
    }

    if (isBgMode) {
        return getMenuArr(menuName, bgMenuArr);
    }

    menuInfoArr = getMenuArr(menuName, finMenuArr);
    if (menuInfoArr != null) {
        return menuInfoArr;
    }
    menuInfoArr = getMenuArr(menuName, fabMenuArr);
    if (menuInfoArr != null) {
        return menuInfoArr;
    }
    menuInfoArr = getMenuArr(menuName, crvMenuArr);

    return menuInfoArr;
}

function getMenuArr(menuName, menuArr) {
    var menuInfo = null;
    var len = (menuArr != null) ? menuArr.length : 0;

    for (var i = 0; i < len; i++) {
        if (menuArr[i][0] == menuName) {
            menuInfo = menuArr[i][1];
            break;
        }
    }

    return (menuInfo != undefined && menuInfo != null) ? menuInfo.split("|") : null;
}

function showConfirm(title, literalList, actionList, pWidth, pHeight, dWidth, dHeight) {
    literalList = fnTrim(literalList);
    actionList = fnTrim(actionList);
    var litBuf = literalList.split("|");
    var evtBuf = actionList.split("|");

    if (fnIsNull(title) || litBuf.length == 0 || evtBuf.length == 0 || litBuf.length != evtBuf.length) {
        alert(finbranchResArr.get("FAT001813"));
        return;
    }

    var retVal;
    var winName = "ConfirmWin";
    var url = "../arjspmorph/" + applangcode + "/print_confirm.jsp";
    url += "?displayMsg=" + title + "&buttonsList=" + literalList + "&actionList=" + actionList;

    if (arguments.length > 3) {
        retVal = popModalWindowVar(url, winName, pWidth, pHeight, dWidth, dHeight);
    } else {
        retVal = popModalWindow(url, winName);
    }

    if (retVal == null || retVal == undefined) {
        retVal = "";
    }
    return retVal;
}

function intRateFillPrecision(intRate) {
    var count;
    var index;
    var begin = 0;
    var decLength;
    var decPoint;
    var interestRate;
    var iRate;
    var len;
    interestRate = eval("document.forms[0]." + intRate);
    if (!isEmptyObjValue(interestRate.value)) {
        iRate = getValInStdFormat(interestRate.value);
        if (!isNaN(iRate)) {
            iRate = fnTrim(iRate);
            len = iRate.length;
            if ((iRate.charAt(0) == "+") || (iRate.charAt(0) == "-")) {
                alert(finbranchResArr.get("FAT001210"));
                interestRate.focus();
                return false
            }
            if (iRate >= 1000) {
                alert(finbranchResArr.get("FAT001211"));
                interestRate.focus();
                return false
            }
            if (eval(iRate) == 0) {
                interestRate.value = getValInCustomFormat("0.000000");
                return
            }
            decPoint = iRate.indexOf(".");
            if (decPoint != -1) {
                decLength = len - (decPoint + 1)
            } else {
                decLength = 0
            }
            if (decLength > 6) {
                alert(finbranchResArr.get("FAT001212"));
                interestRate.focus();
                return false
            }
            count = 6 - decLength;
            if (count <= 6) {
                if (decPoint != -1) {
                    for (index = 0; index < count; index++) {
                        iRate = iRate + "0"
                    }
                } else {
                    iRate = iRate + ".000000"
                }
                if (iRate.charAt(0) == ".") {
                    iRate = "0" + iRate
                }
                interestRate.value = getValInCustomFormat(iRate)
            }
        } else {
            alert(finbranchResArr.get("FAT001213"));
            interestRate.focus();
            return false
        }
    }
}

function isMenuTreeAvl() {
    var mtDiv = document.getElementById("menutree_div");
    var mtLyr = get_lyr_css("menutree");
    var isDivVisible = (mtDiv) ? (mtDiv.style.visibility == 'visible') : false;
    var isLyrDisplayed = (mtLyr) ? (mtLyr.display == "") : false;
    var isMenuTreeShown = isDivVisible && isLyrDisplayed;

    return isMenuTreeShown;
}

function disableMTreeTimer() {
    if (isMenuTreeAvl()) {
        var mtFrame = window.frames["menutree"];
        mtFrame.disableTimers();
    }
}

function enableMTreeTimer() {
    if (isMenuTreeAvl()) {
        var mtFrame = window.frames["menutree"];
        mtFrame.prevEventDate = new Date();
        mtFrame.handleTimers();
    }
}

function fnAssignArrayUIDates(b, c) {
    var a = b + "_ui";
    elements = document.getElementsByName(a);
    for (i = 0; i < elements.length; i++) {
        elements[i].value = c[i]
    }
}

function fnGetMonthDesc(a) {
    var b = parseInt(a, 10);
    switch (b) {
        case 1:
            return finbranchResArr.get("FAT001948");
        case 2:
            return finbranchResArr.get("FAT001949");
        case 3:
            return finbranchResArr.get("FAT001950");
        case 4:
            return finbranchResArr.get("FAT001951");
        case 5:
            return finbranchResArr.get("FAT001952");
        case 6:
            return finbranchResArr.get("FAT001953");
        case 7:
            return finbranchResArr.get("FAT001954");
        case 8:
            return finbranchResArr.get("FAT001955");
        case 9:
            return finbranchResArr.get("FAT001956");
        case 10:
            return finbranchResArr.get("FAT001957");
        case 11:
            return finbranchResArr.get("FAT001958");
        case 12:
            return finbranchResArr.get("FAT001959");
        default:
            return ""
    }
}


function switchCalendar(calBase) {
    valSwitch = true;
    if (!validateTypes(document.forms[0])) {
        switchCalArr[0] = false;
        return switchCalArr;
    }

    if (calBase == 'G') {
        calBase = '00';
    } else if (calBase == 'H') {
        calBase = '01';
    } else if (calBase == 'B') {
        calBase = '02';
    }

    if (!validateDateConvWithNewCalBase(document.forms[0], calBase)) {
        switchCalArr[0] = false;
        return switchCalArr;
    }

    if (lastCalMappedDate == "" || lastCalMappedDate == "undefined" || lastCalMappedDate == null) {
        if (calBase == "01") {
            switchCalArr[0] = false;
            switchCalArr[1] = finbranchResArr.get("FAT002819");
            return switchCalArr;
        }
    }

    for (var cnt = 0; cnt < iCalCount; cnt++) {
        if (calStringArr[cnt] == calBase) {
            TOGGLE_CALENDAR_BASE = calBase;
            switchCalArr[0] = true;
            return switchCalArr;
        }
    }
    switchCalArr[0] = false;
    return switchCalArr;
}

function fnIsValidEmailId(a) {
    if (!fnValidateEmailId(a.custEmailId)) {
        return false
    }
    return true
}

function fnValidateEmailId(h) {
    var o = h.value;
    var d = "@";
    var a = ".";
    var c = ";";
    var e = ",";
    var p = o.indexOf(d);
    var g = o.indexOf(d, p + 1);
    var l = o.length;
    var q = o.indexOf(a);
    var b = o.indexOf(a, q + 1);
    var m = o.length;
    var f = /[!`#$%^&*()?<>~]/;
    if (m > 0) {
        if (f.test(o) == true) {
            return false
        }
        if (o.indexOf(d) == -1) {
            return false
        }
        if (o.indexOf(d) == -1 || o.indexOf(d) == 0 || o.indexOf(d) == l) {
            return false
        }
        if (o.indexOf(a) == -1 || o.indexOf(a) == 0 || o.indexOf(a) == l) {
            return false
        }
        if (o.indexOf(d, (p + 1)) != -1) {
            if ((o.indexOf(e) == -1) && (o.indexOf(c) == -1)) {
                return false
            }
            if ((g > b) || (o.indexOf(a, (g + 2)) == -1) || (o.substring(g - 1, g) == a || o.substring(g + 1, g + 2) == a)) {
                return false
            }
        }
        if (o.substring(p - 1, p) == a || o.substring(p + 1, p + 2) == a) {
            return false
        }
        if (o.indexOf(a, (p + 2)) == -1) {
            return false
        }
        if (o.indexOf(" ") != -1) {
            return false
        }
    }
    return true
}

function fnAddTimeToDate(h, a) {
    var o;
    var b;
    var f;
    var g;
    var c;
    var d;
    var e;
    var m;
    var l;
    h = fnTrim(h);
    a = fnTrim(a);
    if (h.length != 19 || a.length != 6) {
        return h
    } else {
        if ((a.charAt(0) != "+" && a.charAt(0) != "-") || a.charAt(3) != ":") {
            return h
        }
    }
    g = h.substring(6, 10);
    f = h.substring(3, 5) - 1;
    b = h.substring(0, 2);
    c = h.substring(11, 13);
    d = h.substring(14, 16);
    e = h.substring(17, 19);
    l = parseInt(a.substring(1, 3)) * 60 + parseInt(a.substring(4, 6));
    o = new Date(g, f, b, c, d, e, 0);
    if (a.substring(0, 1) == "+") {
        o.setMinutes(o.getMinutes() + l)
    } else {
        o.setMinutes(o.getMinutes() - l)
    }
    b = o.getDate();
    if (b < 10) {
        b = "0" + b
    }
    f = o.getMonth() + 1;
    if (f < 10) {
        f = "0" + f
    }
    g = o.getFullYear();
    c = o.getHours();
    if (c < 10) {
        c = "0" + c
    }
    d = o.getMinutes();
    if (d < 10) {
        d = "0" + d
    }
    e = o.getSeconds();
    if (e < 10) {
        e = "0" + e
    }
    m = b + "-" + f + "-" + g + " " + c + ":" + d + ":" + e;
    return m
}

function getBaseUrl() {
    var tagArr = document.getElementsByTagName('BASE');
    var baseHref = (tagArr.length == 0) ? "" : tagArr[0].href;
    var bUrl = (baseHref != undefined && !fnIsNull(baseHref)) ? baseHref + "../.." : "";

    return bUrl;
}

function displayFinacleVersion() {
    var bUrl = getBaseUrl();
    var obj = window.open(bUrl + finContextPath + "/arjspmorph/" + applangcode + "/fin_version.jsp?rtId=" + rtId, "finversion", "width=500,height=190,menubar=no,scrollbars=no,status=no,left=230,top=270");
    if (obj != null && typeof(obj) == "string" && obj == "TIMEOUT") {
        var logoutParams = new Array(1);
        logoutParams[0] = finConst.FORCED_LOGOUT;
        handleWindowDisplay(finConst.DOLOGOUT, logoutParams);
        return;
    }
    obj.focus();
}

function fnSetFocusOnFirstField_postonload() {
    var b = document.forms[0].elements;
    var c = sGroupName;
    var a = b.length;
    if (currentFocusId != null && currentFocusId != undefined) {
        for (i = 0; i < a; i++) {
            if (((b[i].name).indexOf(c) != -1) && (b[i].id == currentFocusId)) {
                return true
            }
        }
    }
    for (i = 0; i < a; i++) {
        if (((b[i].name).indexOf(c) != -1) && ((b[i].type == "text" && !b[i].readOnly && !b[i].disabled) || (b[i].type == "select-one" && !b[i].disabled) || (b[i].type == "textarea" && !b[i].disabled) || (b[i].type == "radio" && !b[i].disabled))) {
            if (b[i].type == "radio") {
                b[i].id + "[0].focus()";
                return true
            }
            b[i].focus();
            return true
        }
    }
    initFocusHandler()
}

function isLocalCalendarBase(a) {
    if ((!fnIsNull(a)) && (a != "") && (a != "00")) {
        return true
    } else {
        return false
    }
}

function getCalBaseDesc(b) {
    var a = "";
    switch (b) {
        case "01":
            a = "HIJRI";
            break;
        case "02":
            a = "BUDDHA";
            break;
        case "00":
        case "":
            a = "GREGORIAN";
            break;
        default:
            a = b;
            break
    }
    return a
}

function refreshScreen() {
    var a = document.forms[0];
    if (a.groupName != undefined) {
        document.location.href = a.screenName.value + "_ctrl.jsp?rtId=" + rtId
    }
    if (TOGGLE_CALENDAR_BASE != "" && TOGGLE_CALENDAR_BASE != null) {
        if (a.action.indexOf(JSP_PARAMS_AVAILABLE) != -1) {
            a.action = a.action + "&rtId=" + rtId + "&calBase=" + TOGGLE_CALENDAR_BASE
        } else {
            a.action = a.action + "?rtId=" + rtId + "&calBase=" + TOGGLE_CALENDAR_BASE
        }
    }
    if (TOGGLE_TIME_ZONE != "" && TOGGLE_TIME_ZONE != null) {
        if (a.action.indexOf(JSP_PARAMS_AVAILABLE) != -1 || (TOGGLE_CALENDAR_BASE != "" && TOGGLE_CALENDAR_BASE != null)) {
            a.action = a.action + "&rtId=" + rtId + "&timeZone=" + TOGGLE_TIME_ZONE
        } else {
            a.action = a.action + "?rtId=" + rtId + "&timeZone=" + TOGGLE_TIME_ZONE
        }
    }
    if ((TOGGLE_CALENDAR_BASE != "" && TOGGLE_CALENDAR_BASE != null) || (TOGGLE_TIME_ZONE != "" && TOGGLE_TIME_ZONE != null)) {
        doSubmit("refreshFromSSO")
    }
}

function convertBetweenDate(a) {
    if (calbase == "00" && !isGregDate(a) && isHijDate(a) && dateInputCal == "00+01") {
        a = convertHijToGreg(a)
    }
    if (calbase == "01" && !isHijDate(a) && isGregDate(a) && dateInputCal == "00+01") {
        a = convertGregToHij(a)
    }
    if (calbase == "02" && !isBuddhaDate(a) && isGregDate(a) && dateInputCal == "02") {
        a = convertGregToBuddha(a)
    }
    return (a)
}

function isGregDate(b) {
    var c = b;
    var a = new Array();
    if (c.indexOf("/") != -1) {
        a = c.split("/")
    }
    if (c.indexOf("-") != -1) {
        a = c.split("-")
    }
    if (c.indexOf(".") != -1) {
        a = c.split(".")
    }
    if ((a[2] >= 1900) && (a[2] <= 2099)) {
        return true
    } else {
        return false
    }
}

function validateDateConvWithNewCalBase(g, e) {
    var b = g.elements;
    var f;
    var d;
    for (var a = 0; a < b.length; a++) {
        f = b[a];
        if (f.type == "application/x-oleobject") {
            continue
        }
        var c = f.getAttribute("fdt");
        if ((f.type != "hidden") && (f.disabled != true) && (f.readOnly != true)) {
            if ((c == null) && (!validateAsciiData(f))) {
                if (valSwitch) {
                    switchCalArr[1] = finbranchResArr.get("FAT000591")
                } else {
                    alert(finbranchResArr.get("FAT000591"))
                }
                f.focus();
                return false
            }
        }
        if ((c != null) && ((c != "")) && ((c.length != 0))) {
            if ((c == "fdate") || (c == "datetime") || (c == "date")) {
                if (f.value != null && f.value != "" && f.value.length != 0) {
                    d = convertBetweenNewDate(f.value, e);
                    if (e == "01" && d == f.value) {
                        switchCalArr[1] = finbranchResArr.get("FAT002819");
                        fnSetFocusForDate(f);
                        return false
                    }
                }
            }
        }
    }
    return true
}

function convertBetweenNewDate(a, b) {
    if (b == "01" && !isHijDate(a) && isGregDate(a)) {
        a = convertGregToHij(a)
    }
    return (a)
}

function convertBuddhaToGreg(b) {
    var c = b;
    var a = new Array();
    if (c.indexOf("/") != -1) {
        a = c.split("/")
    }
    if (c.indexOf("-") != -1) {
        a = c.split("-")
    }
    if (c.indexOf(".") != -1) {
        a = c.split(".")
    }
    a[2] = parseInt(a[2]) - 543;
    return a[0] + "-" + a[1] + "-" + a[2]
}

function convertDateToGreg(a) {
    if (calbase == "01" && isHijDate(a)) {
        a = convertHijToGreg(a)
    } else {
        if (calbase == "02" && isBuddhaDate(a)) {
            a = convertBuddhaToGreg(a)
        } else {
            if (!isHijDate(a) && !isGregDate(a) && !isBuddhaDate(a)) {
                aFlag = "N";
                alert(finbranchResArr.get("FAT000081"))
            }
        }
    }
    return (a)
}

function convertGregToBuddha(stdDateString) {

    var displayStr = stdDateString;
    var a_strDate = new Array();

    if (displayStr.indexOf("/") != -1)
        a_strDate = displayStr.split("/");
    if (displayStr.indexOf("-") != -1)
        a_strDate = displayStr.split("-");
    if (displayStr.indexOf(".") != -1)
        a_strDate = displayStr.split(".");

    a_strDate[2] = parseInt(a_strDate[2]) + 543;

    return a_strDate[0] + "-" + a_strDate[1] + "-" + a_strDate[2];
}

function switchTimeZone(timezone) {
    TOGGLE_TIME_ZONE = timezone;
}
/*
 * function 		: checkIFramePresent()
 * Description	: This function is used to check the presence of the device frame
 *		  		  and if not present ,creates and call the DeviceServlet in that frame
 *
 */
function checkIFramePresent(devType) {
    if (window.parent.DEVICEFRAME.frames[devType] != undefined)
        return true;
    else
        return false;
}

function switchTimeZone(a) {
    TOGGLE_TIME_ZONE = a
}

function checkIFramePresent(a) {
    if (window.parent.DEVICEFRAME.frames[a] != undefined) {
        return true
    } else {
        return false
    }
}

function closeAllDevice() {
    for (i = 0; i < window.parent.DEVICEFRAME.frames.length; i++) {
        if (window.parent.DEVICEFRAME.frames[i] != undefined && window.parent.DEVICEFRAME.frames[i].closeDevice != undefined) {
            window.parent.DEVICEFRAME.frames[i].closeDevice();
        }
    }
    window.parent.DEVICEFRAME.location.href = "";
}

function printDeviceIFrame(b) {
    if (window.parent.DEVICEFRAME != undefined) {
        if (!checkIFramePresent(b)) {
            var a = getBaseUrl();
            var c = a + finContextPath + "/DeviceServlet?deviceType=" + b;
            printDeviceDiv(b, c)
        }
    }
}

function printDeviceDiv(a, b) {
    var c = window.parent.DEVICEFRAME.document.createElement("div");
    c.setAttribute("id", a + "_div");
    c.innerHTML = "<iframe id='" + a + "' src='" + b + "'/>";
    window.parent.DEVICEFRAME.document.body.appendChild(c)
}

function loadAppletIFrame() {
    if (silentPrntReqd == "Y") {
        if (window.parent.DEVICEFRAME != undefined) {
            var b = getBaseUrl();
            var a = b + finContextPath + "/silentPrint/loadApplet.jsp";
            loadAppletDiv(a)
        }
    }
}

function loadAppletDiv(a) {
    if (window.parent.DEVICEFRAME.frames.length >= 1 && window.parent.DEVICEFRAME.frames.printApp.document.getElementById("PrinterAppl") != undefined) {
        return
    }
    var b = window.parent.DEVICEFRAME.document.createElement("div");
    b.setAttribute("id", "printApp_div");
    b.innerHTML = "<iframe name='printApp' id='printApp' src='" + a + "'/>";
    window.parent.DEVICEFRAME.document.body.appendChild(b)
}

function fireSilentPrint(g, c, e, d, f, h) {
    var b;
    var a;
    c = ((null != c) && ("null" != c) && ("" != c)) ? c : null;
    e = ((null != e) && ("null" != e) && ("" != e)) ? e : -1;
    d = ((null != d) && ("null" != d) && ("" != d)) ? d : -1;
    if (window.parent.DEVICEFRAME != undefined && window.parent.DEVICEFRAME.frames.printApp != undefined && window.parent.DEVICEFRAME.frames.printApp.document.getElementById("PrinterAppl") != undefined) {
        a = 287;
        if (f == undefined || f == null) {
            f = 15
        }
        if (h == undefined || h == null) {
            h = 8;
            a = 277
        }
        b = window.parent.DEVICEFRAME.frames.printApp.document.getElementById("PrinterAppl").print(g, c, e, d, f, h, a)
    } else {
        alert("Background print does not happen");
        b = false
    }
    return b
}

function getClient_ip(e, c) {
    var d = document.forms[0];
    var b = c;
    var e = (b != "") && e;
    if (e) {
        document.domain = b
    }
    if (window.parent.getLoginFrame != undefined) {
        if (window.parent.getLoginFrame() != undefined) {
            var f = window.parent.getLoginFrame().getClientIP();
            d.ipAddress.value = f
        }
    }
    var a = window.location.href;
    a = jsUtil.formatUrl(a);
    d.action = a;
    d.submit()
}

function getPageName(b) {
    var a = b;
    var d = a.split("/");
    var c = d[0];
    return c
}

function CallSSOFunctionForModalDailogue(a) {
    var b = new Array();
    if (window.parent.getLoginFrame != undefined) {
        if (window.parent.getLoginFrame() != undefined) {
            b = window.parent.getLoginFrame().validateAuthorizerWithWnd(a, "Auth_User_Screen")
        }
    }
    return b
}

function fnDisableFormControlsForProduct(a) {
    if ((a.Validate != undefined) && (a.Validate != null)) {
        a.Validate.disabled = true
    }
}

function formUrl(c) {
    if (!window.showModalDialog) {
        genericCallBackFn = "formUrl_genericCallBack"
    }
    pWidth = 60;
    pHeight = 35;
    var b = window.location;
    childURL = "?actionCode=VIEWMOREDETAILS&dynURL=" + escape(c);
    var a = b.href.split("?");
    var d = formUrlForCurrGroup(a[0]);
    if (d == "" || d == undefined) {
        d = a[0]
    }
    url = d + childURL;
    retVal = popModalWindowVar(url, CURR_GROUP_NAME, pWidth, pHeight, pWidth, pHeight);
    if (window.showModalDialog) {
        sendDataForRewind("../inquiry/inquiry_ctrl.jsp?actionCode=CLOSE")
    }
}

function formUrl_genericCallBack(a) {
    sendDataForRewind("../inquiry/inquiry_ctrl.jsp?actionCode=CLOSE")
}

function showIntDtlsDr(c, b) {
    var a = getValueOfArgument(c, b);
    tmp = a.split("|");
    int_tbl_code = tmp[0];
    int_ver_num = tmp[1];
    C_crncy_code = tmp[2];
    tvs_ivs_flag = tmp[3];
    pWidth = 60;
    pHeight = 35;
    if (tvs_ivs_flag == "T") {
        alert(finbranchResArr.get("FAT003907"))
    }
    if (tvs_ivs_flag == "L") {
        sUrl = "../inquiry/inquiry_ctrl.jsp?mo=LAVS&actionCode=SUBMIT&lavs.tbl_code=" + int_tbl_code + "&lavs.crncy_code=" + C_crncy_code + "&lavs.ver_num=" + int_ver_num;
        formUrl(sUrl)
    }
    if (tvs_ivs_flag == "I") {
        sUrl = "../inquiry/inquiry_ctrl.jsp?mo=DIVS&actionCode=SUBMIT&divs.tbl_code=" + int_tbl_code + "&divs.crncy_code=" + C_crncy_code + "&divs.ver_num=" + int_ver_num;
        formUrl(sUrl)
    }
    if (tvs_ivs_flag == "P") {
        sUrl = "../inquiry/inquiry_ctrl.jsp?mo=BIVS&actionCode=SUBMIT&bivs.tbl_code=" + int_tbl_code + "&bivs.crncy_code=" + C_crncy_code + "&bivs.ver_num=" + int_ver_num;
        formUrl(sUrl)
    }
}

function showIntDtlsCr(c, b) {
    var a = getValueOfArgument(c, b);
    tmp = a.split("|");
    int_tbl_code = tmp[0];
    int_ver_num = tmp[1];
    C_crncy_code = tmp[2];
    tvs_ivs_flag = tmp[3];
    pWidth = 60;
    pHeight = 35;
    if (tvs_ivs_flag == "L") {
        alert(finbranchResArr.get("FAT003906"))
    }
    if (tvs_ivs_flag == "P") {
        alert(finbranchResArr.get("FAT003906"))
    }
    if (tvs_ivs_flag == "I") {
        sUrl = "../inquiry/inquiry_ctrl.jsp?mo=CIVS&actionCode=SUBMIT&civs.tbl_code=" + int_tbl_code + "&civs.crncy_code=" + C_crncy_code + "&civs.ver_num=" + int_ver_num;
        formUrl(sUrl)
    }
    if (tvs_ivs_flag == "T") {
        sUrl = "../inquiry/inquiry_ctrl.jsp?mo=HTVS&actionCode=SUBMIT&htvs.tbl_code=" + int_tbl_code + "&htvs.crncy_code=" + C_crncy_code + "&htvs.ver_num=" + int_ver_num;
        formUrl(sUrl)
    }
}

function showAlertForMenuConversio(a) {
    alert("Menu Under Conversion")
}

function showBkdciExplodeDtls(d, c) {
    var a = getValueOfArgument(d, c);
    tmp = a.split("|");
    var b = null;
    var e = "Y";
    inward_outward_ind = tmp[0];
    inland_frng_flg = tmp[1];
    cifId = tmp[2];
    dcNumber = tmp[3];
    solId = tmp[4];
    verifiedFlg = tmp[5];
    if (chkFlgForIcfg(verifiedFlg, e)) {
        if (inward_outward_ind == "O" && inland_frng_flg == "F") {
            b = "../impdci/impdci_ctrl.jsp?rtId=" + rtId + "&mo=IMPDCI&actionCode=EXPLODE&pageName=impdci_general&impdci.dcNo=" + dcNumber + "&impdci.solId=" + solId + "&impdci.cifId=" + cifId + "";
            document.forms[0].calledMenu.value = b;
            doSubmitForm("INVOKE_GROUP_RECORD")
        } else {
            if (inward_outward_ind == "I" && inland_frng_flg == "F") {
                b = "../expdci/expdci_ctrl.jsp?rtId=" + rtId + "&mo=EXPDCI&actionCode=EXPLODE&expdci.dcNo=" + dcNumber + "&expdci.solId=" + solId + "&expdci.cifId=" + cifId + "";
                document.forms[0].calledMenu.value = b;
                doSubmitForm("INVOKE_GROUP_RECORD")
            } else {
                if (inward_outward_ind == "O" && inland_frng_flg == "I") {
                    b = "../owdci/owdci_ctrl.jsp?rtId=" + rtId + "&mo=OWDCI&actionCode=EXPLODE&pageName=owdci_general&owdci.dcNo=" + dcNumber + "&owdci.solId=" + solId + "&owdci.cifId=" + cifId + "";
                    document.forms[0].calledMenu.value = b;
                    doSubmitForm("INVOKE_GROUP_RECORD")
                } else {
                    if (inward_outward_ind == "I" && inland_frng_flg == "I") {
                        b = "../indci/indci_ctrl.jsp?rtId=" + rtId + "&mo=INDCI&actionCode=EXPLODE&pageName=indci_general&indci.dcNo=" + dcNumber + "&indci.solId=" + solId + "&indci.txtcifId=" + cifId + "";
                        document.forms[0].calledMenu.value = b;
                        doSubmitForm("INVOKE_GROUP_RECORD")
                    } else {
                        alert(finbranchResArr.get("FAT003271"))
                    }
                }
            }
        }
    }
}

function showBkfbiExplodeDtls(d, c) {
    var a = getValueOfArgument(d, c);
    tmp = a.split("|");
    var b = null;
    var e = "Y";
    inward_outward_ind = tmp[0];
    cifId = tmp[1];
    billId = tmp[2];
    solId = tmp[3];
    verifiedFlg = tmp[4];
    if (chkFlgForIcfg(verifiedFlg, e)) {
        if (inward_outward_ind == "O") {
            b = "../impbili/impbili_ctrl.jsp?rtId=" + rtId + "&mo=IMPBILI&actionCode=EXPLODE&pageName=impbili_general&impbili.billId=" + billId + "&impbili.solId=" + solId + "&impbili.cifId=" + cifId + "";
            document.forms[0].calledMenu.value = b;
            doSubmitForm("INVOKE_GROUP_RECORD")
        } else {
            if (inward_outward_ind == "I") {
                b = "../expbili/expbili_ctrl.jsp?rtId=" + rtId + "&mo=EXPBILI&actionCode=EXPLODE&pageName=expbili_general&expbili.billId=" + billId + "&expbili.solId=" + solId + "&expbili.cifId=" + cifId + "";
                document.forms[0].calledMenu.value = b;
                doSubmitForm("INVOKE_GROUP_RECORD")
            } else {
                alert(finbranchResArr.get("FAT003271"))
            }
        }
    }
}

function showBkfwciExplodeDtls(d, c) {
    var a = getValueOfArgument(d, c);
    tmp = a.split("|");
    var b = null;
    var e = "Y";
    contractNo = tmp[0];
    cifId = tmp[1];
    solId = tmp[2];
    verifiedFlg = tmp[3];
    if (chkFlgForIcfg(verifiedFlg, e)) {
        b = "../fwcnti/fwcnti_ctrl.jsp?rtId=" + rtId + "&mo=FWCNTI&actionCode=EXPLODE&pageName=fwcnti_general&fwcnti.contractNo=" + contractNo + "&fwcnti.solId=" + solId + "&fwcnti.cifId=" + cifId + "";
        document.forms[0].calledMenu.value = b;
        doSubmitForm("INVOKE_GROUP_RECORD")
    }
}

function showBkibiExplodeDtls(d, c) {
    var a = getValueOfArgument(d, c);
    tmp = a.split("|");
    var e = "V";
    var b = null;
    billId = tmp[0];
    cifId = tmp[1];
    solId = tmp[2];
    verifiedFlg = tmp[3];
    if (chkFlgForIcfg(verifiedFlg, e)) {
        b = "../inbilli/inbilli_ctrl.jsp?rtId=" + rtId + "&mo=INBILLI&actionCode=EXPLODE&pageName=inbilli_general&inbilli.billId=" + billId + "&inbilli.solId=" + solId + "&inbilli.cifId=" + cifId + "";
        document.forms[0].calledMenu.value = b;
        doSubmitForm("INVOKE_GROUP_RECORD")
    }
}

function chkFlgForIcfg(a, b) {
    if (a != b) {
        alert("Record is unverified");
        return false
    }
    return true
}

function showLndiExplodeDetails(a, g) {
    var o = getValueOfArgument(a, g);
    tmp = o.split("|");
    var b = null;
    var f = tmp[0];
    var e = tmp[1];
    var m = tmp[2];
    var p = tmp[3];
    var c = tmp[4];
    var d = tmp[5];
    var l = tmp[6];
    var h = null;
    if ((p == "Sublimit") && (f == null || f == "")) {
        alert("Limit does not belong to any Cif Id.Further explode not possible");
        return
    }
    if (p == "Sublimit") {
        b = "../inquiry/inquiry_ctrl.jsp?mo=LNDI&actionCode=SUBMIT&lndi.cif_id=" + f + "&lndi.lim_prefix=" + e + "&lndi.lim_suffix=" + m;
        formUrl(b)
    } else {
        if (isSearchMode == "true") {
            alert("Further Explode is not possible/avaliable. Please check in HLNDI menu.");
            return
        }
        if (p == "Outward BG") {
            h = "OGM";
            explodeToMenuOption(h, "solId=" + d + "|bgType=|ccy=" + l + "|cifId=" + f + "|bgSrlNum=" + c, "funcCode=I")
        }
        if (p == "Inward BG") {
            h = "IGM";
            explodeToMenuOption(h, "solId=" + d + "|bgType=|ccy=" + l + "|cifId=" + f + "|bgSrlNum=" + c, "funcCode=I")
        }
        if (p == "Outward DC") {
            h = "ODCM";
            explodeToMenuOption(h, "solId=" + d + "|odcmNum=" + c + "|", "funcCode=I")
        }
        if (p == "Inward DC") {
            h = "IDCM";
            explodeToMenuOption(h, "solId=" + d + "|idcmNum=" + c + "|", "funcCode=I")
        }
        if (p == "Savings Account") {
            h = "HACM";
            explodeToMenuOption(h, "acctNo=" + c, "funcCode=I")
        }
        if (p == "Current Account") {
            h = "HACM";
            explodeToMenuOption(h, "acctNo=" + c, "funcCode=I")
        }
        if (p == "Cash Credit Account") {
            h = "HACM";
            explodeToMenuOption(h, "acctNo=" + c, "funcCode=I")
        }
        if (p == "Overdraft Account") {
            h = "HACM";
            explodeToMenuOption(h, "acctNo=" + c, "funcCode=I")
        }
        if (p == "Retail Loan Account") {
            h = "HACMLA";
            explodeToMenuOption(h, "acctNo=" + c, "funcCode=I")
        }
        if (p == "Commercial Lending Account") {
            h = "HACMCL";
            explodeToMenuOption(h, "acctNo=" + c, "funcCode=I")
        }
        if (p == "Packing Credit Account") {
            h = "ACMPS";
            explodeToMenuOption(h, "AcctId=" + c, "funcCode=I")
        }
        if (p == "Bill Account") {
            h = "HACMBP";
            explodeToMenuOption(h, "AcctId=" + c, "funcCode=I")
        }
        if (p == "Foreign Bills") {
            h = "HACMBP";
            explodeToMenuOption(h, "AcctId=" + c, "funcCode=I")
        }
        if (p == "Forward Contract") {
            h = "MNTFWC";
            explodeToMenuOption(h, "solId=" + d + "|FwdCntrctType=|FwdCntrctNo=" + c, "funcCode=I")
        }
        if (p == "Buyers Credit") {
            h = "MBCO";
            explodeToMenuOption(h, "solId=" + d + "|buyersCreditType=|buyersCreditNo=" + c, "funcCode=I")
        }
    }
}

function showSubVerDetails(f, d) {
    var a = getValueOfArgument(f, d);
    tmp = a.split("|");
    var c = tmp[0];
    var b = tmp[1];
    var e = tmp[2];
    if ("I" == e) {
        sUrl = "../inquiry/inquiry_ctrl.jsp?mo=LASDIVER&actionCode=SUBMIT&lasdiver.subsidyCode=" + b + "&lasdiver.acctId=" + c;
        formUrl(sUrl)
    } else {
        alert(finbranchResArr.get("FAT003300"))
    }
}

function showSubsidyDtls(f, d) {
    var a = getValueOfArgument(f, d);
    tmp = a.split("|");
    var b = tmp[0];
    var c = tmp[1];
    var e = tmp[2];
    if ("I" == e) {
        sUrl = "../inquiry/inquiry_ctrl.jsp?mo=SUBSDYDD&actionCode=SUBMIT&subsdydd.subsidy_code=" + b + "&subsdydd.acid=" + c;
        formUrl(sUrl)
    } else {
        alert(finbranchResArr.get("FAT003309"))
    }
}

function changeCursorStyle() {
    var a = document.getElementsByTagName("img");
    var d = a.length;
    for (i = 0; i < d; i++) {
        displayHand(a[i])
    }
    var b = document.getElementsByTagName("a");
    var c = b.length;
    for (j = 0; j < c; j++) {
        displayHand(b[j])
    }
}

/*
 * function 	: getEvtKeyCode()
 * Description	: This function gives the keycode of the event
 *
 */
function getEvtKeyCode(evt) {
    var keyCode;
    if ("Microsoft Internet Explorer" == browser_name) {
        keyCode = window.event.keyCode;
    } else {
        keyCode = evt.which;
    }
    return keyCode;
}

function setValueToField(ctrl, fldval, calledfrmprt) {
    var fld;
    if (calledfrmprt) {
        fld = eval("parent.window.opener.document.forms[0]." + ctrl)
    } else {
        fld = eval("window.opener.document.forms[0]." + ctrl)
    }
    if (null != fld && undefined != fld) {
        fld.value = fldval
    }
}

function popModalWindowMozillaFrame(b, c) {
    modalWin = window.open(b, c, "width=875,height=450,modal=yes,left=150,top=40,scrollbars=yes,toolbar=no,menubar=0,resizable=yes,dialog=yes");
    if (modalWin != null && typeof(modalWin) == "string" && modalWin == "TIMEOUT") {
        var a = new array(1);
        a[0] = finConst.FORCED_LOGOUT;
        handleWindowDisplay(finConst.DOLOGOUT, a);
        return
    }
}

function getInnerTextValue(c, a) {
    var b;
    if ("Microsoft Internet Explorer" == browser_name) {
        b = c[a].innerText
    } else {
        b = c[a].textContent
    }
    return b
}

function setInnerTextValue(b, a) {
    if ("Microsoft Internet Explorer" == browser_name) {
        b.innerText = a
    } else {
        b.textContent = a
    }
}

function commonfetchXBankAcctDtls(acctId, acctName, solId, ccy, targetBankId, isError, fType) {
    var acctField = eval("document.forms[0]." + acctId);
    var wReturnDesc = ccy + "|" + solId + "|" + acctName + "|" + acctId;
    var wReturn = acctId + "|targetBankId";
    var ret;
    if (!(fnIsNull(acctField.value))) {
        if (!window.showModalDialog) {
            acctFieldGeneric = acctField;
            wReturnDescGeneric = wReturnDesc;
            genericCallBackFn_SDS = "commonfetchXBankAcctDtls_callBack"
        }
        ret = sendDataToServer("myframe", fType, isError, wReturn, wReturnDesc);
        if (window.showModalDialog) {
            if (ret == false) {
                if (!fnIsNull(wReturnDesc) && wReturnDesc != undefined) {
                    var descFldArr = wReturnDesc.split("|");
                    if (descFldArr.length > 0) {
                        for (var i = 0; i < descFldArr.length; i++) {
                            if (descFldArr[i].length > 0) {
                                clearDescField(descFldArr[i])
                            }
                        }
                    }
                }
                acctField.focus();
                acctField.select();
                return false
            }
        }
    } else {
        if (fnIsNull(acctField.value)) {
            if (!fnIsNull(wReturnDesc) && wReturnDesc != undefined) {
                var descFldArr = wReturnDesc.split("|");
                if (descFldArr.length > 0) {
                    for (var i = 0; i < descFldArr.length; i++) {
                        if (descFldArr[i].length > 0) {
                            clearDescField(descFldArr[i])
                        }
                    }
                }
            }
            acctField.focus()
        }
    }
}

function commonfetchXBankAcctDtls_callBack(a) {
    if (a == "false") {
        if (!fnIsNull(wReturnDescGeneric) && wReturnDescGeneric != undefined) {
            var c = wReturnDescGeneric.split("|");
            if (c.length > 0) {
                for (var b = 0; b < c.length; b++) {
                    if (c[b].length > 0) {
                        clearDescField(c[b])
                    }
                }
            }
        }
        acctFieldGeneric.focus();
        acctFieldGeneric.select();
        return false
    }
}

function commonfetchXBankCif(cifId, custName, targetBankId, isError, fType) {
    var cifField = eval("document.forms[0]." + cifId);
    var wReturn = cifId + "|targetBankId";
    if (!fnIsNull(cifField.value)) {
        if (!window.showModalDialog) {
            cifFieldGeneric = cifField;
            custNameGeneric = custName;
            callBackFn_SDS = "commonfetchXBankCif_callBack"
        }
        var rtn = sendDataToServer("myframe", fType, isError, wReturn, custName);
        if (window.showModalDialog) {
            if (rtn == false) {
                if (!fnIsNull(custName) && custName != undefined) {
                    if (custName.length > 0) {
                        clearDescField(custName)
                    }
                }
                cifField.focus()
            }
        }
    } else {
        if (fnIsNull(cifField.value)) {
            if (!fnIsNull(custName) && custName != undefined) {
                if (custName.length > 0) {
                    clearDescField(custName)
                }
            }
        }
    }
    cifField.focus()
}

function commonfetchXBankCif_callBack(a) {
    if (a == "false") {
        if (!fnIsNull(custNameGeneric) && custNameGeneric != undefined) {
            if (custNameGeneric.length > 0) {
                clearDescField(custNameGeneric)
            }
        }
        cifFieldGeneric.focus()
    }
}

function RemittanceExplodes(d, c) {
    var b = null;
    var a = getValueOfArgument(d, c);
    tmp = a.split("|");
    in_out_ind = tmp[0];
    remitId = tmp[1];
    solId = tmp[2];
    entity_cre_flg = tmp[3];
    if (entity_cre_flg == "N") {
        alert(finbranchResArr.get("FAT003789"));
        window.parent();
        return false
    }
    if (in_out_ind == "O") {
        b = "../orm/orm_ctrl.jsp?rtId=" + rtId + "&mo=HORM&actionCode=EXPLODE&orm.funcCode=I&pagename=orm&orm.remitId=" + remitId + "&orm.solId=" + solId;
        document.forms[0].calledMenu.value = b;
        doSubmitForm("INVOKE_GROUP_RECORD")
    } else {
        b = "../irm/irm_ctrl.jsp?rtId=" + rtId + "&mo=HIRM&actionCode=EXPLODE&irm.funcCode=I&pagename=irm&irm.remitId=" + remitId + "&irm.solId=" + solId;
        document.forms[0].calledMenu.value = b;
        doSubmitForm("INVOKE_GROUP_RECORD")
    }
}

function showIntRateDtls(f, e) {
    var c = getValueOfArgument(f, e);
    tmp = c.split("|");
    var d = null;
    var a = tmp[0];
    var b = tmp[1];
    var g = tmp[2];
    if ("Y" == a) {
        d = "../inquiry/inquiry_ctrl.jsp?mo=HACLI&actionCode=SUBMIT&acli.tbl_code=" + b + "&acli.tbl_desc=&acli.crncy_code=" + g + "&acli.start_date=&acli.end_date=&acli.as_on_date=&acli.acct_open_date=&tvs_ivs_lavs_flag=";
        formUrl(d)
    } else {
        alert(finbranchResArr.get("FAT003329"))
    }
}

function fnCancelHandler(c) {
    var b = "A";
    var e = "C";
    var d = "M";
    var a = "T";
    if (c == b || c == e || c == d || c == a) {
        if (confirm(finbranchResArr.get("FAT000925")) != true) {
            return false
        }
    }
    return true
}

function formUrlForCurrGroup(f) {
    var e = f.split("/");
    var b = e.length - 1;
    if (e[b - 1] != CURR_GROUP_NAME) {
        var c = "";
        for (var a = 0; a <= b; a++) {
            var d = e[a].replace(e[b - 1], CURR_GROUP_NAME);
            c = c + d;
            if (a != b) {
                c = c + "/"
            }
        }
    }
    return c
}

function fnValidateSplCharacters(a) {
    var b = /[^a-zA-Z0-9]/;
    if (b.test(a.value)) {
        alert(finbranchResArr.get("FAT000485"));
        a.focus();
        return false
    }
    return true
}

function formateqtypriceToLakh(d) {
    if (fnIsNull(d)) {
        return ""
    }
    if (isNaN(removeCommas(d))) {
        alert(finbranchResource.FAT000029);
        return 0
    }
    if ((d.indexOf(DEF_DECIMAL_SEPARATOR) != -1) && (d.substring(0, d.indexOf(DEF_DECIMAL_SEPARATOR) - 1).length < 3)) {
        return d
    }
    if (d.indexOf(DEF_DECIMAL_SEPARATOR) != -1) {
        sNum = d.substring(0, d.indexOf(DEF_DECIMAL_SEPARATOR))
    } else {
        sNum = d
    }
    if (sNum.length < 4) {
        return d + ".000000"
    }
    sNum = removeCommas(sNum);
    var c = "";
    var a = 0;
    if (sNum.length > 4) {
        for (i = sNum.length - 4; i >= 0; i--) {
            c = c + sNum.charAt(i);
            temp = (c.substring(0, a + 1)).length;
            if ((temp % 2) == 0) {
                c = c + ","
            }
            a += 1
        }
        var b = "";
        for (i = c.length - 1; i >= 0; i--) {
            b = b + c.charAt(i)
        }
        b = b + "," + sNum.substring(sNum.length - 3)
    }
    if (sNum.length == 4) {
        b = sNum.charAt(0) + "," + sNum.substring(1)
    }
    if (d.indexOf(DEF_DECIMAL_SEPARATOR) == -1) {
        b = b + ".000000"
    } else {
        b = b + d.substring(d.indexOf(DEF_DECIMAL_SEPARATOR))
    }
    if (b.charAt(0) == DEF_MANTISSA_SEPARATOR) {
        b = b.substring(b.indexOf(DEF_MANTISSA_SEPARATOR) + 1)
    }
    return b
}

function formateqtypriceToMillion(d) {
    if (fnIsNull(d)) {
        return ""
    }
    if (isNaN(removeCommas(d))) {
        alert(finbranchResource.FAT000029);
        return 0
    }
    if ((d.indexOf(DEF_DECIMAL_SEPARATOR) != -1) && (d.substring(0, d.indexOf(DEF_DECIMAL_SEPARATOR) - 1).length < 3)) {
        return d
    }
    if (d.indexOf(DEF_DECIMAL_SEPARATOR) != -1) {
        sNum = d.substring(0, d.indexOf(DEF_DECIMAL_SEPARATOR))
    } else {
        sNum = d
    }
    if (sNum.length < 4) {
        return d + ".000000"
    }
    sNum = removeCommas(sNum);
    var c = "";
    var a = 0;
    for (i = sNum.length - 1; i >= 0; i--) {
        c = c + sNum.charAt(i);
        temp = (c.substring(0, a + 1)).length;
        if ((temp % 3) == 0) {
            c = c + ","
        }
        a += 1
    }
    var b = "";
    for (i = c.length - 1; i >= 0; i--) {
        b = b + c.charAt(i)
    }
    if (d.indexOf(DEF_DECIMAL_SEPARATOR) == -1) {
        b = b + ".000000"
    } else {
        b = b + d.substring(d.indexOf(DEF_DECIMAL_SEPARATOR))
    }
    if (b.charAt(0) == ",") {
        b = b.substring(b.indexOf(DEF_MANTISSA_SEPARATOR) + 1)
    }
    return b
}

function isValideqtyprice(b) {
    var a = true;
    amt = getAmtInStdFormat(b);
    if ((amt.length > 17) || (isNaN(amt))) {
        a = false
    }
    index = amt.indexOf(DEF_DECIMAL_SEPARATOR);
    if (index > 11) {
        a = false
    }
    if ((index == -1) && (amt.length > 11)) {
        a = false
    }
    return a
}

function getCrncyFromeqtyprice(d) {
    var a = "";
    var b = d.indexOf("|");
    if (b != -1) {
        var c = d.indexOf("|", b + 1);
        if (c != -1) {
            a = d.substring(b + 1, c)
        } else {
            a = d.substring(b + 1)
        }
    }
    return a
}

function getPrecFromeqtyprice(d) {
    var b = "";
    var a = d.indexOf("|");
    if (a != -1) {
        var c = d.indexOf("|", a + 1);
        if (c != -1) {
            b = d.substring(c + 1)
        }
    }
    return b
}

function getFormateqtyprice(e, a, d) {
    var b = null;
    var c = null;
    if (isEmptyObjValue(a) || isEmptyObjValue(e) || isEmptyObjValue(d)) {
        return
    }
    if (e == "Million") {
        b = formatToMillion1(a, d)
    } else {
        b = formatToLakh1(a, d)
    }
    c = getAmtInCustomFormat(b);
    return c
}

function fnValidateeqtyprice(b, a) {
    b = getAmtInStdFormat(b);
    return fnValidateStdeqtyprice(b, a)
}

function fnValidateStdeqtyprice(h, d) {
    var b = 0;
    var a = 0;
    var e = 0;
    var l = true;
    var f = removeCommas(h);
    var m = 6;
    var g = 10;
    var c = 17;
    if (isNaN(f)) {
        l = false;
        alert(finbranchResource.FAT003913)
    } else {
        if (parseFloat(f) < 0) {
            l = false;
            alert(finbranchResource.FAT003912)
        } else {
            m = m > d ? d : m;
            f = checkZeroes(f, d);
            e = f.indexOf(DEF_DECIMAL_SEPARATOR);
            if (e == -1) {
                b = f
            } else {
                b = f.substring(0, e);
                a = f.substring(e + 1)
            }
            if (f.length > c) {
                l = false;
                alert(finbranchResource.FAT000523 + c + " " + finbranchResource.FAT003896)
            } else {
                if (b.length > g && d != 0) {
                    l = false;
                    alert(finbranchResource.FAT002973)
                } else {
                    if (a.length > m) {
                        l = false;
                        alert(finbranchResource.FAT000523 + m + " " + finbranchResource.FAT000526)
                    } else {
                        switch (parseInt(m, 10)) {
                            case 6:
                                if (b.length > 10) {
                                    l = false;
                                    alert(finbranchResource.FAT002973 + m)
                                }
                                break;
                            case 5:
                                if (b.length > 11) {
                                    l = false;
                                    alert(finbranchResource.FAT000529 + m)
                                }
                                break;
                            case 4:
                                if (b.length > 12) {
                                    l = false;
                                    alert(finbranchResource.FAT000528 + m)
                                }
                                break
                        }
                    }
                }
            }
        }
    }
    return l
}

function newformateqtyprice(g, c, l, b, o, h) {
    var p = (o != "Y");
    var e = !fnIsNull(l);
    var m = !fnIsNull(b);
    g = (fnTrim(g)).toUpperCase();
    if (g != "MILLION" && g != "LAKH") {
        alert(finbranchResArr.get("FAT003920"));
        low_setAmtFldFocus(p, c, h);
        return false
    }
    var a = (p) ? c.value : c;
    a = fnTrim(a);
    if (fnIsNull(a)) {
        if (!p) {
            return c
        }
        return
    }
    a = removeMantissa(a);
    a = getAmtInStdFormat(a);
    if (!low_isValidPrice(a)) {
        low_setAmtFldFocus(p, c, h);
        return
    }
    a = low_convertAmt(a);
    if (!m) {
        var f = 0;
        var d = 0;
        b = EQTYPRICE_PREC;
        d = a.indexOf(DEF_DECIMAL_SEPARATOR);
        if (d != -1) {
            f = a.substring(d + 1).length;
            if (f < b) {
                b = f
            }
        }
    }
    if (p && !low_validateeqtyprice(a, b)) {
        low_setAmtFldFocus(p, c, h);
        return
    }
    a = checkZeroes(a, b);
    if (g == "MILLION") {
        a = formatToMillion1(a, b)
    } else {
        a = formatToLakh1(a, b)
    }
    a = getAmtInCustomFormat(a);
    if (p) {
        c.value = a
    } else {
        document.write(a)
    }
}

function formateqtypriceToMillionOrLakh(d, c, b, e, a) {
    newformateqtyprice(d, c, null, precision, e, a)
}

function low_validateeqtyprice(c, a) {
    var b = "99999999999999999";
    if (low_fnSubtractAmt(c, b) > 0) {
        alert(finbranchResource.FAT003917);
        return false
    }
    if (!fnValidateStdeqtyprice(c, a)) {
        return false
    }
    return true
}

function formateqtypriceOnBlur(a, b, c) {
    if ("true" != c.value) {
        formateqtypriceToMillionOrLakh(a, b, crncyCode, "N")
    }
    if (isNaN(getAmtInStdFormat(b.value))) {
        b.focus()
    }
    c.value = "false"
}

function RemCrncyandprecfromeqty(b) {
    var a = b.indexOf("|");
    if (a != -1) {
        return b.substring(0, a)
    } else {
        return b
    }
}

function fnCompareEqtyPriceFlds(b, a) {
    var b = getAmtInStdFormat(b);
    var a = getAmtInStdFormat(a);
    var d = 0;
    var c = 0;
    d = b.indexOf(DEF_DECIMAL_SEPARATOR);
    c = a.indexOf(DEF_DECIMAL_SEPARATOR);
    if (d < c) {
        b = fnAmtLpad(b, (c - d))
    } else {
        a = fnAmtLpad(a, (d - c))
    }
    if (b > a) {
        return true
    } else {
        return false
    }
}

function low_isValidPrice(price) {
    var priceLen = price.length;
    var lastChar = (price.charAt(priceLen - 1)).toUpperCase();
    if (isNaN(lastChar) && lastChar != ".") {
        var str = price.substring(0, priceLen - 1);
        if (isNaN(str)) {
            alert(finbranchResArr.get("FAT003921"));
            return false
        }
        var val = "";
        if (eval("this.custGetAmountCodeValue") != undefined) {
            val = custGetAmountCodeValue(lastChar)
        } else {
            val = getAmountCodeValue(lastChar)
        }
        if (val == undefined) {
            alert(finbranchResArr.get("FAT003922"));
            return false
        } else {
            return true
        }
    }
    if (isNaN(price)) {
        alert(finbranchResArr.get("FAT003921"));
        return false
    }
    var regExp = /[Ee]/g;
    if (regExp.test(price)) {
        alert(finbranchResArr.get("FAT003921"));
        return false
    }
    return true
}

function formatNAVToLakh(d) {
    if (fnIsNull(d)) {
        return ""
    }
    if (isNaN(removeCommas(d))) {
        alert(finbranchResArr.get("FAT000029"));
        return 0
    }
    if ((d.indexOf(DEF_DECIMAL_SEPARATOR) != -1) && (d.substring(0, d.indexOf(DEF_DECIMAL_SEPARATOR) - 1).length < 3)) {
        return d
    }
    if (d.indexOf(DEF_DECIMAL_SEPARATOR) != -1) {
        sNum = d.substring(0, d.indexOf(DEF_DECIMAL_SEPARATOR))
    } else {
        sNum = d
    }
    if (sNum.length < 4) {
        return d + ".000000"
    }
    sNum = removeCommas(sNum);
    var c = "";
    var a = 0;
    if (sNum.length > 4) {
        for (i = sNum.length - 4; i >= 0; i--) {
            c = c + sNum.charAt(i);
            temp = (c.substring(0, a + 1)).length;
            if ((temp % 2) == 0) {
                c = c + ","
            }
            a += 1
        }
        var b = "";
        for (i = c.length - 1; i >= 0; i--) {
            b = b + c.charAt(i)
        }
        b = b + "," + sNum.substring(sNum.length - 3)
    }
    if (sNum.length == 4) {
        b = sNum.charAt(0) + "," + sNum.substring(1)
    }
    if (d.indexOf(DEF_DECIMAL_SEPARATOR) == -1) {
        b = b + ".000000"
    } else {
        b = b + d.substring(d.indexOf(DEF_DECIMAL_SEPARATOR))
    }
    if (b.charAt(0) == DEF_MANTISSA_SEPARATOR) {
        b = b.substring(b.indexOf(DEF_MANTISSA_SEPARATOR) + 1)
    }
    return b
}

function formatNAVToMillion(d) {
    if (fnIsNull(d)) {
        return ""
    }
    if (isNaN(removeCommas(d))) {
        alert(finbranchResArr.get("FAT000029"));
        return 0
    }
    if ((d.indexOf(DEF_DECIMAL_SEPARATOR) != -1) && (d.substring(0, d.indexOf(DEF_DECIMAL_SEPARATOR) - 1).length < 3)) {
        return d
    }
    if (d.indexOf(DEF_DECIMAL_SEPARATOR) != -1) {
        sNum = d.substring(0, d.indexOf(DEF_DECIMAL_SEPARATOR))
    } else {
        sNum = d
    }
    if (sNum.length < 4) {
        return d + ".000000"
    }
    sNum = removeCommas(sNum);
    var c = "";
    var a = 0;
    for (i = sNum.length - 1; i >= 0; i--) {
        c = c + sNum.charAt(i);
        temp = (c.substring(0, a + 1)).length;
        if ((temp % 3) == 0) {
            c = c + ","
        }
        a += 1
    }
    var b = "";
    for (i = c.length - 1; i >= 0; i--) {
        b = b + c.charAt(i)
    }
    if (d.indexOf(DEF_DECIMAL_SEPARATOR) == -1) {
        b = b + ".000000"
    } else {
        b = b + d.substring(d.indexOf(DEF_DECIMAL_SEPARATOR))
    }
    if (b.charAt(0) == ",") {
        b = b.substring(b.indexOf(DEF_MANTISSA_SEPARATOR) + 1)
    }
    return b
}

function isValidNAV(b) {
    var a = true;
    amt = getAmtInStdFormat(b);
    if ((amt.length > 19) || (isNaN(amt))) {
        a = false
    }
    index = amt.indexOf(DEF_DECIMAL_SEPARATOR);
    if (index > 14) {
        a = false
    }
    if ((index == -1) && (amt.length > 14)) {
        a = false
    }
    return a
}

function getCrncyFromNAV(d) {
    var a = "";
    var b = d.indexOf("|");
    if (b != -1) {
        var c = d.indexOf("|", b + 1);
        if (c != -1) {
            a = d.substring(b + 1, c)
        } else {
            a = d.substring(b + 1)
        }
    }
    return a
}

function getPrecFromNAV(d) {
    var b = "";
    var a = d.indexOf("|");
    if (a != -1) {
        var c = d.indexOf("|", a + 1);
        if (c != -1) {
            b = d.substring(c + 1)
        }
    }
    return b
}

function getFormatNAV(c, a, e) {
    var b = null;
    var d = null;
    if (isEmptyObjValue(a) || isEmptyObjValue(amountFormat) || isEmptyObjValue(e)) {
        return
    }
    if (c == "Million") {
        b = formatToMillion1(a, precVal)
    } else {
        b = formatToLakh1(a, precVal)
    }
    d = getAmtInCustomFormat(b);
    return d
}

function fnCommonValNAV(r, g, a, b, d, m, p, q) {
    var e = 0;
    var c = 0;
    var l = 0;
    var s = true;
    var h = removeCommas(r);
    var q = finbranchResArr.get("FAT002230");
    var p = finbranchResArr.get("FAT000527");
    var m = finbranchResArr.get("FAT000528");
    var t = 6;
    var o = a;
    var f = b;
    if (isEmptyObjValue(r)) {
        return false
    }
    if (isNaN(h)) {
        s = false;
        alert(finbranchResArr.get("FAT000189"))
    } else {
        if (null != g && !isNaN(g) && 0 < parseInt(g, 10)) {
            t = t > g ? g : t
        }
        h = checkZeroes(h, g);
        l = h.indexOf(DEF_DECIMAL_SEPARATOR);
        if (l == -1) {
            e = h
        } else {
            e = h.substring(0, l);
            c = h.substring(l + 1)
        }
        if (h.length > (f + 1)) {
            s = false;
            alert(finbranchResArr.get("FAT000523") + f + " " + finbranchResArr.get("FAT002074"))
        } else {
            if (e.length > o) {
                s = false;
                alert(d)
            } else {
                if (c.length > t) {
                    s = false;
                    alert(finbranchResArr.get("FAT000523") + t + " " + finbranchResArr.get("FAT000526"))
                } else {
                    switch (parseInt(t, 10)) {
                        case 6:
                            if (e.length > 12) {
                                s = false;
                                alert(m + t)
                            }
                            break;
                        case 5:
                            if (e.length > 13) {
                                s = false;
                                alert(p + t)
                            }
                            break;
                        case 4:
                            if (e.length > 14) {
                                s = false;
                                alert(q + t)
                            }
                            break
                    }
                }
            }
        }
    }
    return s
}

function fnValidateNAV(b, a) {
    b = getAmtInStdFormat(b);
    return fnValidateStdNAV(b, a)
}

function fnValidateStdNAV(h, d) {
    var b = 0;
    var a = 0;
    var e = 0;
    var l = true;
    var f = removeCommas(h);
    var m = 6;
    var g = 16;
    var c = 17;
    if (isNaN(f)) {
        l = false;
        alert(finbranchResArr.get("FAT000189"))
    } else {
        m = m > d ? d : m;
        f = checkZeroes(f, d);
        e = f.indexOf(DEF_DECIMAL_SEPARATOR);
        if (e == -1) {
            b = f
        } else {
            b = f.substring(0, e);
            a = f.substring(e + 1)
        }
        if (f.length > c) {
            l = false;
            alert(finbranchResArr.get("FAT000523") + c + " " + finbranchResArr.get("FAT002074"))
        } else {
            if (b.length > g) {
                l = false;
                alert(finbranchResArr.get("FAT001371"))
            } else {
                if (a.length > m) {
                    l = false;
                    alert(finbranchResArr.get("FAT000523") + m + " " + finbranchResArr.get("FAT000526"))
                } else {
                    switch (parseInt(m, 10)) {
                        case 6:
                            if (b.length > 10) {
                                l = false;
                                alert(finbranchResArr.get("FAT004386") + m)
                            }
                            break;
                        case 5:
                            if (b.length > 11) {
                                l = false;
                                alert(finbranchResArr.get("FAT004385") + m)
                            }
                            break;
                        case 4:
                            if (b.length > 12) {
                                l = false;
                                alert(finbranchResArr.get("FAT000528") + m)
                            }
                            break;
                        case 3:
                            if (b.length > 13) {
                                l = false;
                                alert(finbranchResArr.get("FAT000527") + m)
                            }
                            break;
                        case 2:
                            if (b.length > 14) {
                                l = false;
                                alert(finbranchResArr.get("FAT002230") + m)
                            }
                            break;
                        case 1:
                            if (b.length > 15) {
                                l = false;
                                alert(finbranchResArr.get("FAT000872") + m)
                            }
                            break
                    }
                }
            }
        }
    }
    return l
}

function newformatNAV(g, c, l, b, o, h) {
    var p = (o != "Y");
    var e = !fnIsNull(l);
    var m = !fnIsNull(b);
    g = (fnTrim(g)).toUpperCase();
    if (g != "MILLION" && g != "LAKH") {
        alert("Invalid Amount Format.");
        low_setAmtFldFocus(p, c, h);
        return
    }
    var a = (p) ? c.value : c;
    a = fnTrim(a);
    if (fnIsNull(a)) {
        if (!p) {
            return c
        }
        return
    }
    a = removeMantissa(a);
    a = getAmtInStdFormat(a);
    if (!low_isValidAmt(a)) {
        low_setAmtFldFocus(p, c, h);
        return false
    }
    a = low_convertAmt(a);
    if (!m) {
        var f = 0;
        var d = 0;
        b = "6";
        d = a.indexOf(DEF_DECIMAL_SEPARATOR);
        if (d != -1) {
            f = a.substring(d + 1).length;
            if (f < b) {
                b = f
            }
        }
    }
    if (p && !low_validateNAVWithPrec(a, b)) {
        low_setAmtFldFocus(p, c, h);
        return false
    }
    a = checkZeroes(a, b);
    if (g == "MILLION") {
        a = formatToMillion1(a, b)
    } else {
        a = formatToLakh1(a, b)
    }
    a = getAmtInCustomFormat(a);
    if (p) {
        c.value = a
    } else {
        document.write(a)
    }
    return true
}

function formatNAVToMillionOrLakh(d, c, b, e, a) {
    newformatNAV(d, c, null, precision, e, a)
}

function low_validateNAVWithPrec(c, a) {
    var b = "99999999999999999";
    if (low_fnSubtractAmt(c, b) > 0) {
        alert("Entered Amount exceeds the Max Limit.");
        return false
    }
    if (!fnValidateStdNAV(c, a)) {
        return false
    }
    return true
}

function fnAlphaCheckWithSpace(fldId) {
    var validChars = /[^A-Za-z0-9_ ]/;
    var obj = "document.forms[0]." + fldId;
    if (validChars.test((eval(obj)).value)) {
        alert(finbranchResArr.get("FAT000485"));
        (eval(obj)).focus();
        return false
    }
    return true
}

function formatNAVOnBlur(a, b, d, c) {
    if ("true" != c.value) {
        formatNAVToMillionOrLakh(a, b, d, "N")
    }
    if (isNaN(getAmtInStdFormat(b.value))) {
        b.focus()
    }
    c.value = "false"
}

function validateSpecialChar() {
    var obj = document.forms[0].elements;
    var len = obj.length;
    var funcName = "this.custValidateSpecialChar";
    var isFuncAvl = (eval(funcName) != undefined);
    var retVal = true;
    var invalidChars = /[\|\n]/g;
    for (var i = 0; i < len; i++) {
        switch (obj[i].type) {
            case "text":
            case "textarea":
                var textval = obj[i].value;
                if (!obj[i].readOnly && !obj[i].disabled) {
                    if (invalidChars.test(textval)) {
                        alert(finbranchResArr.get("FAT000485"));
                        obj[i].focus();
                        retVal = false;
                        return retVal;
                        break
                    }
                    if (isFuncAvl) {
                        if (eval(funcName).call(this, textval) == false) {
                            obj[i].focus();
                            retVal = false;
                            return retVal;
                            break
                        }
                    }
                }
                break;
            default:
                break
        }
    }
    return retVal
}

function validateNewLineFeedForTextArea(f) {
    var c = f.elements;
    var e;
    for (var b = 0; b < c.length; b++) {
        e = c[b];
        if (e.type == "textarea" && (e.type != "hidden") && (e.disabled != true) && (e.readOnly != true)) {
            var d = e.value;
            for (var a = 0; a <= d.length; a++) {
                if (d.charAt(a) == "\n") {
                    alert(finbranchResArr.get("FAT003378"));
                    e.focus();
                    return false
                }
            }
        }
    }
    return true
}

function setUnitValueInd(secuType, unitInd, overriddenRec, funcCode, dp) {
    var securityType = eval("document.forms[0]." + secuType);
    var unitIndicator = eval("document.forms[0]." + unitInd);
    var overriddenFlag1 = eval("document.forms[0]." + overriddenRec);
    var func = eval("document.forms[0]." + funcCode);
    var dpFlag = eval("document.forms[0]." + dp);
    var temp1 = getRadioValue(dpFlag);
    if (func.value == "A") {
        if ((securityType.value == "A") || (securityType.value == "W") || (securityType.value == "K") || (securityType.value == "H")) {
            unitIndicator.value = "N";
            fnEnableDisableRadioButtons(dpFlag, "E");
            setRadioValue(overriddenRec, "Y")
        } else {
            unitIndicator.value = "";
            fnEnableDisableRadioButtons(dpFlag, "D");
            setRadioValue(overriddenRec, "")
        }
    } else {
        if (func.value == "M") {
            if ((securityType.value == "A") || (securityType.value == "W") || (securityType.value == "K") || (securityType.value == "H")) {
                unitIndicator.value = "N";
                fnEnableDisableRadioButtons(dpFlag, "E");
                setRadioValue(overriddenRec, "Y");
                fnEnableDisableRadioButtons(overriddenFlag1, "D")
            } else {
                if (temp1 == "Y") {
                    fnEnableDisableRadioButtons(overriddenFlag1, "E")
                }
                unitIndicator.value = "";
                setRadioValue(overriddenRec, "")
            }
        } else {
            if (func.value == "C") {
                if ((securityType.value == "A") || (securityType.value == "W") || (securityType.value == "K") || (securityType.value == "H")) {
                    unitIndicator.value = "N";
                    setRadioValue(overriddenRec, "Y")
                } else {
                    unitIndicator.value = "";
                    setRadioValue(overriddenRec, "")
                }
            } else {
                fnEnableDisableRadioButtons(dpFlag, "D")
            }
        }
    }
    return true
}

function setdpFlag(secuType, overriddenRec, funcCode, dp) {
    var securityType = eval("document.forms[0]." + secuType);
    var overriddenFlag = eval("document.forms[0]." + overriddenRec);
    var func = eval("document.forms[0]." + funcCode);
    var dpFlag = eval("document.forms[0]." + dp);
    if ((securityType.value == "A") || (securityType.value == "W") || (securityType.value == "K") || (securityType.value == "H")) {
        var temp = getRadioValue(dpFlag);
        if (temp == "Y" || temp == "N") {
            fnEnableDisableRadioButtons(overriddenFlag, "D")
        }
    }
}

function setRadioValue(obj, value) {
    var obj1 = document.forms[0];
    if ("Netscape" == navigator.appName) {
        obj1 = parent.window.opener.document.forms[0];

    }
    var isArray = (typeof(obj.length) == "undefined") ? false : true;
    if (isArray && (typeof(obj.type) == "undefined")) {
        for (var i = 0; i < obj.length; i++) {
            if (eval("obj1." + obj + "[" + i + "].value") == value) {
                eval("obj1." + obj + "[" + i + "].checked = true");
                break
            } else {
                if (value == "") {
                    eval("obj1." + obj + "[" + i + "].checked = false");
                    return
                }
            }
        }
    }
    return
}

function fnEnableDisableRadioButtons(c, d) {
    var a = (typeof(c.length) == "undefined") ? false : true;
    if (!a) {
        if (d == "D") {
            c.disabled = true;
            return
        } else {
            c.disabled = false;
            return
        }
    }
    if (a && (typeof(c.type) == "undefined")) {
        for (var b = 0; b < c.length; b++) {
            if (d == "D") {
                c[b].disabled = true
            } else {
                c[b].disabled = false
            }
        }
    }
    return
}

var userInfoUtil = (function() {
    var userEffTenor = "";
    var contextSol = "";
    var tenorConst = {
        FREE: "F",
        CAPTIVE: "C"
    };

    return {
        setEffTenor: function(tmpEffTenor) {
            switch (tmpEffTenor) {
                case tenorConst.FREE:
                case tenorConst.CAPTIVE:
                    break;
                default:
                    alert("Invalid User Tenor");
                    return;
            }
            userEffTenor = tmpEffTenor;
        },

        setContextSol: function(tmpCtxSol) {
            /* Null check can be performed */
            contextSol = tmpCtxSol;
        },

        isFreeTenor: function() {
            return (userEffTenor == tenorConst.FREE);
        },

        getContextSol: function() {
            return contextSol;
        }
    }
})();

function checkDecimalDigitsForAmt(inputAmt) {
    var decLength = 0;
    var decPoint = 0;
    var amtLength = 0;
    var sResult = 0;
    objInputAmt = eval("document.forms[0]." + inputAmt);
    inputAmtFldId = objInputAmt.getAttribute("vFldId");
    inputAmtFld = eval("document.forms[0]." + inputAmtFldId);
    inputAmount = getAmtInStdFormat(inputAmtFld.value);
    amtLength = inputAmount.length;
    decPoint = getDecIndex(inputAmount);
    if (decPoint != -1) {
        decLength = amtLength - (decPoint + 1);
        sResult = inputAmount.substring(decPoint + 1, amtLength);
        if ((decLength > 0) && (sResult > 0)) {
            alert(finbranchResArr.get("FAT004503"));
            return false
        }
    }
}

function splCharChk(currObj) {
    var custInValidSplChar = "this.cust_validateSplChar";
    var isCustInValidSplCharAvl = (eval(custInValidSplChar) != undefined);
    var retVal = true;
    var invalidSplChars = /[\|\n]/g;
    switch (currObj.type) {
        case "text":
        case "textarea":
            var textval = currObj.value;
            if (!currObj.readOnly && !currObj.disabled) {
                if (invalidSplChars.test(textval)) {
                    alert(finbranchResArr.get("FAT000485"));
                    currObj.focus();
                    retVal = false;
                    break
                }
                if (isCustInValidSplCharAvl) {
                    if (eval(custInValidSplChar).test(textval)) {
                        alert(finbranchResArr.get("FAT000485"));
                        currObj.focus();
                        retVal = false;
                        break
                    }
                }
            }
            break;
        default:
            break
    }
    return retVal
}

function getPrimarySecondaryDesc(b, a) {
    switch (b) {
        case "P":
            return finbranchResArr.get("FAT001906");
        case "C":
            return finbranchResArr.get("FAT001907");
        default:
            return a
    }
}

function writeComboFunction() {
    var funcName = arguments[0].replace("()", "");
    arguments[0] = funcName;
    if (localeCode != "DF" && localeCode != "") {
        var locFuncName = "this." + localeCode + "_" + funcName;
        if (eval(locFuncName) != undefined) {
            window[localeCode + "_" + Array.prototype.shift.call(arguments)].apply(null, arguments)
        } else {
            window[Array.prototype.shift.call(arguments)].apply(null, arguments)
        }
    } else {
        window[Array.prototype.shift.call(arguments)].apply(null, arguments)
    }
}

function fnLocaleValidateForm(actionCode) {
    if (localeCode != "DF" && localeCode != "") {
        var locFuncName = "this." + localeCode + "_fnValidateForm";
        if (eval(locFuncName) != undefined) {
            return eval(locFuncName).call(this, actionCode)
        }
    }
    return true
}

function isUserAccesAvbl(a) {
    return userSCMenuTreeObj.getMenuSCInfo(a)
}

function invokeApplAfterCxtSwitch(b) {
    var d = document.forms[0];
    var a = d.ContextSwitchDoneFrom.value;
    if (null == b || undefined == b) {
        b = ""
    }
    if (undefined != a && "" != a) {
        var c = d.ContextSwitchDoneFrom;
        window.parent.invokeApplAfterCxtSwitchToCore(a, b, c);
        return true
    }
    return false
}

function saveFinacleMode() {
    var a = window.parent;
    saveFinacleLiteMode = a.isFinacleLite()
}

function isFinacleLiteMode() {
    var a = window.parent;
    if (undefined != a.isFinacleLite) {
        saveFinacleMode();
        return a.isFinacleLite()
    } else {
        return saveFinacleLiteMode
    }
}

function fnConvertFormToNonMandatory(b) {
    var e = "V";
    var a = "I";
    var c = "X";
    if ((b != e) && (b != a) && (b != c)) {
        return
    }
    var f = document.forms[0].elements;
    var h = f.length;
    var d = "";
    var g = "";
    for (iCount = 0; iCount < h; iCount++) {
        d = f[iCount];
        if ((d.type != "text") && (d.type != "select-one") && (d.type != "textarea") && (d.type != "radio")) {
            continue
        }
        g = d.getAttribute("fmnd");
        if ((g == null) || (g == "")) {
            continue
        }
        g = g.toUpperCase();
        if ((g == "TRUE") || (g == "Y")) {
            fnSetPropertyValue(d, "fmnd", "N")
        }
        if (d.type == "radio") {
            d.fmnd = "N"
        }
    }
}

function valIfAlphaNumeric(objectField) {
    var invalidChars = /[^a-zA-Z0-9]/;
    if (typeof(objectField.id) == "undefined") {
        objectField = eval("document.forms[0]." + objectField)
    }
    if (invalidChars.test(objectField.value)) {
        alert(finbranchResArr.get("FAT000485"));
        objectField.focus();
        return false
    }
    return true
}

function showExplodeDetailsForINTTM(a, d, m, b, l, c, e, q) {
    var p = getValueOfArgument(a, c);
    var o = getValueOfArgument(a, l);
    tmp = p.split("|");
    var g = tmp[0];
    tmp = o.split("|");
    var h = tmp[0];
    var r = tmp[2];
    var f = tmp[1];
    if (g == "I" || g == "TRANSACTION ACCOUNTS & TRADE BILLS") {
        sUrl = "../inquiry/inquiry_ctrl.jsp?mo=CIVSWF&actionCode=SUBMIT&civswf.tbl_code=" + h + "&civswf.crncy_code=" + f + "&civswf.ver_num=" + r;
        formUrl(sUrl)
    } else {
        if (g == "T" || g == "TERM DEPOSITS") {
            sUrl = "../inquiry/inquiry_ctrl.jsp?mo=HTVS&actionCode=SUBMIT&htvs.tbl_code=" + h + "&htvs.crncy_code=" + f + "&htvs.ver_num=" + r;
            formUrl(sUrl)
        } else {
            if (g == "B" || g == "BASE RATE") {
                sUrl = "../inquiry/inquiry_ctrl.jsp?mo=BIVS&actionCode=SUBMIT&bivs.tbl_code=" + h + "&bivs.crncy_code=" + f + "&bivs.ver_num=" + r;
                formUrl(sUrl)
            } else {
                if (g == "L" || g == "RETAIL LENDING") {
                    sUrl = "../inquiry/inquiry_ctrl.jsp?mo=LAVS&actionCode=SUBMIT&lavs.tbl_code=" + h + "&lavs.crncy_code=" + f + "&lavs.ver_num=" + r;
                    formUrl(sUrl)
                } else {
                    if (g == "C" || g == "COMMERCIAL LENDING") {
                        sUrl = "../inquiry/inquiry_ctrl.jsp?mo=CLAVS&actionCode=SUBMIT&clavs.tbl_code=" + h + "&clavs.crncy_code=" + f + "&clavs.ver_num=" + r;
                        formUrl(sUrl)
                    }
                }
            }
        }
    }
}

function hideHyperLinks() {
    var b = document.anchors.length;
    var d;
    for (var c = 0; c < b; c++) {
        d = document.anchors[c];
        var a = document.all(d.id);
        hideMultipleAnchors(d.id);
        hideImage(d.id)
    }
}

function hideMultipleAnchors(a) {
    var d = document.all(a);
    for (var c = 0; c < d.length; c++) {
        var b = d[c];
        b.style.display = "none"
    }
}

function fnGetFactoringFuncCodeDesc(a) {
    switch (a) {
        case "R":
            return finbranchResArr.get("FAT005268");
        case "K":
            return finbranchResArr.get("FAT003254");
        case "N":
            return finbranchResArr.get("FAT003330");
        case "O":
            return finbranchResArr.get("FAT003255");
        case "M":
            return finbranchResArr.get("FAT002243");
        case "V":
            return finbranchResArr.get("FAT001731");
        case "I":
            return finbranchResArr.get("FAT001504");
        case "X":
            return finbranchResArr.get("FAT001423");
        default:
            return a
    }
}

function fnAlphaCheckWithSpace(fldId) {
    var validChars = /[^A-Za-z0-9_ ]/;
    var obj = "document.forms[0]." + fldId;
    if (validChars.test((eval(obj)).value)) {
        alert(finbranchResArr.get("FAT000485"));
        (eval(obj)).focus();
        return false
    }
    return true
}

function VPLTblKeyProperties() {
    this.self = null;
    this.keyArray = new Array(MAX_NO_OF_KEY_FIELDS);
    this.setNameForKey1 = setNameForKey1;
    this.setNameForKey2 = setNameForKey2;
    this.setNameForKey3 = setNameForKey3;
    this.setNameForKey4 = setNameForKey4;
    this.setNameForKey5 = setNameForKey5;
    this.setNameForKey6 = setNameForKey6;
    this.setNameForKey7 = setNameForKey7;
    this.setNameForKey8 = setNameForKey8;
    this.setNameForKey9 = setNameForKey9;
    this.getKeyNameList = getKeyNameList
}

function setNameForKey1(a) {
    this.keyArray[0] = a
}

function setNameForKey2(a) {
    this.keyArray[1] = a
}

function setNameForKey3(a) {
    this.keyArray[2] = a
}

function setNameForKey4(a) {
    this.keyArray[3] = a
}

function setNameForKey5(a) {
    this.keyArray[4] = a
}

function setNameForKey6(a) {
    this.keyArray[5] = a
}

function setNameForKey7(a) {
    this.keyArray[6] = a
}

function setNameForKey8(a) {
    this.keyArray[7] = a
}

function setNameForKey9(a) {
    this.keyArray[8] = a
}

function getKeyNameList() {
    var b = "";
    for (var a = 0; a < MAX_NO_OF_KEY_FIELDS; a++) {
        b = b + this.keyArray[a];
        b = b + "|"
    }
    b = b.slice(0, -1);
    return (b)
}

function showIICSTDTExplodeDetails(f, e) {
    var b = getValueOfArgument(f, e);
    tmp = b.split("|");
    var h = tmp[0];
    var c = tmp[1];
    var d = tmp[2];
    var a = tmp[3];
    var g = tmp[4];
    expldMenuUrl = "inquiry/inquiry_ctrl.jsp";
    expldFields = "be_iicstdt.acct_id=" + h + "&be_iicstdt.from_value_date=" + c + "&be_iicstdt.to_value_date=" + d + "&be_iicstdt.value_date=" + a + "&be_iicstdt.int_tran_type=" + g;
    menuName = "BE_IICSTDT";
    menuType = "IQ";
    explodeToPage(expldMenuUrl, expldFields, menuName, menuType)
}

function showPPFTranDetails(d, c) {
    var a = getValueOfArgument(d, c);
    tmp = a.split("|");
    var b = tmp[0];
    sUrl = "../inquiry/inquiry_ctrl.jsp?mo=IN_SSATRAN&actionCode=SUBMIT&PLOC=Y&in_ssatran.account_No=" + b;
    formUrl(sUrl)
}

function toolWindow(a, b) {
    a = jsUtil.formatUrl(a);
    if ("Microsoft Internet Explorer" == browser_name) {
        window.showModalDialog(a, b, "dialogHeight:694px;dialogWidth:1200px;resizable:yes;scroll:yes;")
    } else {
        a = getAbsoluteUrl(a);
        popModalWindowVar(a, b, "dialogHeight:694px;dialogWidth:1200px;resizable:yes;scroll:yes;")
    }
}
