var iMemopad = 0;
var MEMOPAD_NONE = 0;
var MEMOPAD_NORMAL = 500;
var MEMOPAD_BG = 501;
var MEMOPAD_NORMAL_BG = 502;
var isMenuInvoked = false;
var header_link_menu = "";
var miscMenu = [["HOME", "U|1||HOME Menu|onsmainblank/onsmainblank_ctrl.jsp| |||B"], ["FABMNU", "M|1||Finacle@Branch Menu|| |||"], ["FAVMNU", "M|1||Favorites !|| |||"]];
var action = null;

function getMenuTreeData()
{
    var b = "../arjspmorph/" + applangcode + "/mtree_fetch.jsp";
    var g = screen.width,
        c = screen.height;
    var a = (g - 120),
        f = (c - 150);
    var e = "dialogWidth=0px;dialogHeight=0px;dialogLeft=" + a + "px;dialogTop=" + f + "px";
    e += ";status=no;toolbar=no;menubar=no;resizable=yes;help=no;center=no";
    if (window.showModalDialog)
    {
        var d = "";
        if ("Microsoft Internet Explorer" == browser_name)
        {
            d = window.showModalDialog(jsUtil.formatUrl(b), document.forms[0], e)
        }
        else
        {
            b = getAbsoluteUrl(b);
            d = window.showModalDialog(jsUtil.formatUrl(b), document.forms[0], "width=10px,height=10px,modal=yes,top=" + f + "px,left=" + a + "px,scrollbars=yes,toolbar=no,menubar=no,help=no")
        }
        if (d == undefined || d == null)
        {
            alert(finbranchResArr.get("FAT001740"));
            return
        }
        else
        {
            userMenuTreeObj.setMenuProps(d[0], d[1], d[2], d[3], d[4], d[5], d[6], d[7], miscMenu);
            userSCMenuTreeObj.setMenuSCProps(d[0], d[8], d[9], d[10], d[11], d[12]);
            menuInfoDownloaded = true
        }
    }
    else
    {
        window.open(jsUtil.formatUrl(b), "title", "width=10px,height=10px,modal=yes,top=" + f + "px,left=" + a + "px,scrollbars=yes,toolbar=no,menubar=no,help=no")
    }
}
var flag = true;

function mKeyPress()
{
    if (flag == true)
    {
        fnHtmlMenu();
        flag = false
    }
    else
    {
        var a = get_lyr_css("menutree");
        if (a.display == "none")
        {
            fnHtmlMenu();
            flag = false
        }
        if (a.display == "")
        {
            HIDE_menutree();
            flag = true;
            return
        }
    }
}

function fnHtmlMenu()
{
    adjustMenuDiv();
    if (eval(isBackGround) != undefined && !isBackGround)
    {
        if (!menuInfoDownloaded)
        {
            getMenuTreeData();
            if (!menuInfoDownloaded)
            {
                return
            }
        }
    }
    getMenuTree()
}

function getMenuTree()
{
    var c = document.getElementById("menutree_div");
    var b = c.style.visibility;
    if (b == "visible")
    {
        var d = get_lyr_css("menutree");
        if (d)
        {
            d.display = ""
        }
        d = get_lyr_css("mtitle_tab");
        if (d)
        {
            d.display = ""
        }
        var a = window.frames[0];
        a.prevEventDate = new Date();
        a.handleTimers()
    }
    if (b == "hidden")
    {
        var d = document.getElementById("menutree");
        if (d)
        {
            d.src = "../arjspmorph/" + applangcode + "/sidepanel.jsp?rtId=" + rtId
        }
    }
    showMenuTreeForNonIE()
}

function fnCallMainMenu()
{
    handleWindowDisplay(finConst.DISPLAYPARENT)
}

function fnGo(a, c)
{
    if ((a != "Go") && (getEvtKeyCode(c) != enterKey))
    {
        return true
    }
    if (isMenuInvoked)
    {
        var b = document.forms[0].menuName.value;
        b = (fnTrim(b)).toUpperCase();
        header_link_menu = (fnTrim(header_link_menu)).toUpperCase();
        if (header_link_menu == b)
        {
            return true
        }
        isMenuInvoked = false;
        header_link_menu = ""
    }
    if ("Microsoft Internet Explorer" != browser_name)
    {
        a = "Go"
    }
    handleMenuDisplay(document.forms[0].menuName.value, true, null, a)
}

function handleMenuDisplay(menuName, isHdrMenu, params, sAction)
{
    action = sAction;
    if (action == true)
    {
        getMenuTree()
    }
    else
    {
        var frm = document.forms[0];
        if (isHdrMenu == undefined || isHdrMenu == null)
        {
            isHdrMenu = false
        }
        menuName = fnTrim(menuName);
        if (fnIsNull(menuName))
        {
            if (isHdrMenu)
            {
                frm.menuName.focus()
            }
            return false
        }
        menuName = menuName.toUpperCase();
        if (isHdrMenu && eval(isBackGround) != undefined && !isBackGround)
        {
            if (!menuInfoDownloaded)
            {
                getMenuTreeData();
                if (!menuInfoDownloaded)
                {
                    return false
                }
            }
        }
        var menuObj = userMenuTreeObj;
        var menuSCObj = userSCMenuTreeObj;
        var retArr = new Array();
        if (!validateMenuOption(menuSCObj, menuName, isHdrMenu, retArr))
        {
            return false
        }
        var locParams = "";
        if (params != undefined && !fnIsNull(params))
        {
            locParams = params;
            if (retArr.authtok != undefined)
            {
                locParams = locParams + "&authtok=" + retArr.authtok + "&authuser=" + retArr.authuser + "&ssosessionid=" + retArr.ssosessionid
            }
        }
        else
        {
            if (retArr.authtok != undefined)
            {
                locParams = "authtok=" + retArr.authtok + "&authuser=" + retArr.authuser + "&ssosessionid=" + retArr.ssosessionid
            }
        }
        menuName = menuName.toUpperCase();
        displayMenu(menuSCObj, menuName, locParams)
    }
}

function validateMenu(menuObj, menuName, isHdrMenu, retArr)
{
    var frm = document.forms[0];
    var invalidChars = /[^A-Z0-9]/;
    var invalidCharsFound = invalidChars.test(menuName);
    if (invalidCharsFound)
    {
        alert(finbranchResArr.get("FAT000484"));
        if (isHdrMenu)
        {
            frm.menuName.focus()
        }
        return (false)
    }
    if (eval("this.cust_convertMenuOption") != undefined)
    {
        menuName = cust_convertMenuOption(menuName)
    }
    document.forms[0].men
    uName.value = menuName.toUpperCase();
    if (menuObj.isBgMode())
    {
        if (menuName == finConst.HOME_MENU)
        {
            alert(finbranchResArr.get("FAT002367"));
            if (isHdrMenu)
            {
                frm.menuName.focus()
            }
            return (false)
        }
    }
    var ctrlArr = menuObj.getMenuInfo(menuName);
    if (ctrlArr == null)
    {
        alert(finbranchResArr.get("FAT002367"));
        if (isHdrMenu)
        {
            frm.menuName.focus()
        }
        return (false)
    }
    if (ctrlArr[0] == finConst.MOD_MENU)
    {
        alert(finbranchResArr.get("FAT002367"));
        if (isHdrMenu)
        {
            frm.menuName.focus()
        }
        return (false)
    }
    var ret = ctrlArr[8];
    var isFinMenu = false;
    var isFabMenu = false;
    var isBothMenu = false;
    var ret = ctrlArr[8];
    if (ret == finConst.BOTH_PREC)
    {
        isBothMenu = true
    }
    else
    {
        if (ret == finConst.FAB_PREC)
        {
            isFabMenu = true
        }
        else
        {
            isFinMenu = true
        }
    }
    if (isBothMenu && !isLoggedInFin)
    {
        if (!isLoggedInFab)
        {
            alert(finbranchResArr.get("FAT000248"));
            if (isHdrMenu)
            {
                frm.menuName.focus()
            }
            return (false)
        }
    }
    if (isFinMenu && !isLoggedInFin)
    {
        alert(finbranchResArr.get("FAT000670"));
        if (isHdrMenu)
        {
            frm.menuName.focus()
        }
        return (false)
    }
    if (isFabMenu && !isLoggedInFab)
    {
        alert(finbranchResArr.get("FAT000249"));
        if (isHdrMenu)
        {
            frm.menuName.focus()
        }
        return (false)
    }
    var passWordFlg = ctrlArr[9];
    if (passWordFlg == finConst.YES && !validatePassword(retArr))
    {
        return
    }
    if (modifiableFldExists())
    {
        if (!confirm(finbranchResArr.get("FAT002028")))
        {
            if (isHdrMenu)
            {
                frm.menuName.focus()
            }
            return false
        }
    }
    return true
}

function validateMenuOption(g, b, c, f)
{
    var k = document.forms[0];
    var k = document.forms[0];
    var e = /[^A-Z0-9]/;
    var l = e.test(b);
    if (l)
    {
        alert(finbranchResArr.get("FAT000484"));
        if (c)
        {
            k.menuName.focus()
        }
        return (false)
    }
    
    ////////////////////////--code added as part handling the error msgs w.r.t MENU option
    var menu_Name = document.forms[0].b.value;
    menu_Name = (fnTrim(menu_Name)).toUpperCase();
    if (menu_Name != "")
    {
        var inputNameValues = "menu_Name" + "|" + menu_Name;
        var scrName = "menuMsg.scr";
        var outputNames = "paramV1,paramV2";
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret = retVal.split("|");

        if (ret[0] == "err")
        {
            alert("The menu option is invalid");
            return false;
        }
    }
    ////////////////////////--code added as part handling the error msgs w.r.t MENU option

    
    var j = g.getMenuSCInfo(b);
    if (j == null)
    {
        alert("The Menu Option is not available for the user");
        //alert(finbranchResArr.get("FAT002367"));
        if (c)
        {
            k.menuName.focus()
        }
        return (false)
    }
    var m = false;
    var h = false;
    var d = false;
    var i = j[3];
    if (i == finConst.BOTH_PREC)
    {
        d = true
    }
    else
    {
        if (i == finConst.FAB_PREC)
        {
            h = true
        }
        else
        {
            m = true
        }
    }
    if (d && !isLoggedInFin)
    {
        if (!isLoggedInFab)
        {
            alert(finbranchResArr.get("FAT000248"));
            if (c)
            {
                k.menuName.focus()
            }
            return (false)
        }
    }
    if (m && !isLoggedInFin)
    {
        alert(finbranchResArr.get("FAT000670"));
        if (c)
        {
            k.menuName.focus()
        }
        return (false)
    }
    if (h && !isLoggedInFab)
    {
        alert(finbranchResArr.get("FAT000249"));
        if (c)
        {
            k.menuName.focus()
        }
        return (false)
    }
    var a = j[5];
    if (a == finConst.YES && !validatePassword(f))
    {
        return
    }
    if (modifiableFldExists())
    {
        if (!confirm(finbranchResArr.get("FAT002028")))
        {
            if (c)
            {
                k.menuName.focus()
            }
            return false
        }
    }
    return true
}

function modifiableFldExists()
{
    var b = false;
    var e = document.forms[0].elements;
    var a = e.length;
    var g;
    for (var d = 0; d < a; d++)
    {
        g = e[d];
        if (g.name == "menuName")
        {
            continue
        }
        var f = (g.type).toLowerCase();
        if (f != "button" && f != "hidden" && f != "reset" && f != "submit" && f != "image")
        {
            var c = (g.disabled != undefined && !g.disabled) && (g.readOnly != undefined && !g.readOnly);
            if (c)
            {
                b = true;
                break
            }
        }
    }
    return b
}

function displayMenu_Old(e, b, f)
{
    var d = e.getMenuInfo(b);
    var g = (d[8] == finConst.FAB_PREC);
    if (g && fabBaseUrl != "")
    {
        var a = strBaseRef.split("//");
        invokeFAB(FinAvailFlg, d, b, f, a[0]);
        return
    }
    if (e.isBgMode())
    {
        callbgmenu(d[4], b, d[6], d[7], d[8], f);
        return
    }
    var c = getMenuUrl(b, d);
    if (f != undefined && !fnIsNull(f))
    {
        c += "&" + f
    }
    header_link_menu = document.forms[0].menuName.value;
    isMenuInvoked = true;
    document.location.href = jsUtil.formatUrl(c)
}

function getMenuUrl_Old(c, h)
{
    var i = h.length;
    var j = false;
    var f = false;
    var d = false;
    var g = h[8];
    if (g == finConst.BOTH_PREC)
    {
        d = true
    }
    else
    {
        if (g == finConst.FAB_PREC)
        {
            f = true
        }
        else
        {
            j = true
        }
    }
    var e = strBaseRef.split("//");
    var a = strBaseRef + finContextPath + "/";
    if (finBaseUrl == "")
    {
        var b = a + h[4] + "?sessionid=" + sessionid + "&sectok=" + sectok
    }
    else
    {
        var b = e[0] + "//" + finBaseUrl + "/" + h[4] + "?sessionid=" + sessionid + "&sectok=" + sectok
    }
    if (isLoggedInFin)
    {
        b += "&finsessionid=" + finsessionid
    }
    else
    {
        b += "&finsessionid="
    }
    if (isLoggedInFab)
    {
        b += "&fabsessionid=" + fabsessionid
    }
    else
    {
        b += "&fabsessionid="
    }
    b += "&mo=" + c;
    if (i >= 7 && h[6] != "")
    {
        b += "&mtype=" + h[6]
    }
    if (i >= 8 && h[7] != "")
    {
        b += "&sid=" + h[7]
    }
    if (f || d)
    {
        b += "&mprec=" + h[8]
    }
    if (i >= 11 && h[10] != "")
    {
        b += "&mid=" + h[10]
    }
    return b
}

function displayMenu(f, d, e)
{
    var i = f.getMenuSCInfo(d);
    var g = userMenuTreeObj;
    i = i.split("|");
    var h = i[0];
    var b = h + "/" + h + "_ctrl.jsp";
    if (g.isBgMode())
    {
        callbgmenu(b, d, i[2], i[1], i[3], e);
        return
    }
    var c = null;
    if ((h == "inquiry") || (h == "filemnt") || (h == "batch") || (h == "radfx"))
    {
        c = i[1]
    }
    var a = getMenuUrl(d, i, c);
    if (e != undefined && !fnIsNull(e))
    {
        a += "&" + e
    }
    header_link_menu = document.forms[0].menuName.value;
    isMenuInvok
    ed = true;
    document.forms[0].gotomenu.disabled = true;
    if (prodEnv == "Y")
    {
        submitInPost(jsUtil.formatUrl(a))
    }
    else
    {
        document.location.href = jsUtil.formatUrl(a)
    }
}

function getMenuUrl(d, l, c)
{
    var k = false;
    var h = false;
    var e = false;
    var j = l[0];
    var i = l[3];
    if (i == finConst.BOTH_PREC)
    {
        e = true
    }
    else
    {
        if (i == finConst.FAB_PREC)
        {
            h = true
        }
        else
        {
            k = true
        }
    }
    var f = strBaseRef.split("//");
    var a = strBaseRef + finContextPath + "/";
    if (finBaseUrl == "")
    {
        var g = j + "/" + j + "_ctrl.jsp";
        var b = a + g + "?sessionid=" + sessionid + "&sectok=" + sectok
    }
    else
    {
        var b = f[0] + "//" + finBaseUrl + "/" + g + "?sessionid=" + sessionid + "&sectok=" + sectok
    }
    if (isLoggedInFin)
    {
        b += "&finsessionid=" + finsessionid
    }
    else
    {
        b += "&finsessionid="
    }
    if (isLoggedInFab)
    {
        b += "&fabsessionid=" + fabsessionid
    }
    else
    {
        b += "&fabsessionid="
    }
    b += "&mo=" + d;
    if (c != null)
    {
        b += "&sid=" + c
    }
    if (l[1] != "" && l[6] != "")
    {
        b += "&PLOC=" + l[6]
    }
    if (l[1] != "")
    {
        b += "&mtype=" + l[2]
    }
    if (h || e)
    {
        b += "&mprec=" + l[3]
    }
    if (l[4] != "")
    {
        b += "&mid=" + l[4]
    }
    if (l[7] != "")
    {
        b += "&litContext=" + l[7]
    }
    if (l[8] != "")
    {
        b += "&sSubGrpName=" + l[8]
    }
    return b
}

function writeLayer()
{
    var isBG = eval(isBackGround) != undefined && isBackGround;
    var isFG = !isBG;
    with(document)
    {
        write('<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" class="cbody" onLoad="MM_preloadImages(\'../Renderer/images/' + applangcode + "/toptile.gif','../Renderer/images/" + applangcode + "/logo_new.gif','../Renderer/images/" + applangcode + "/leftcurve.gif','../Renderer/images/" + applangcode + "/rightcurve.gif','../Renderer/images/" + applangcode + "/bottomtile.gif','../Renderer/images/" + applangcode + "/UBSI.gif','../Renderer/images/" + applangcode + "/X.gif','../Renderer/images/" + applangcode + "/search_icon.gif','../Renderer/images/" + applangcode + "/calender.gif','../Renderer/images/" + applangcode + '/bullet.jpg\');" onResize="adjustMenuDiv();" >');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" background="../Renderer/images/' + applangcode + '/toptile.gif">');
        write("<tr>");
        write('<td width="20%" rowspan="2" valign="top" ><img src="../Renderer/images/' + applangcode + '/logo_new.gif"></td>');
        write('<td width="80%" ');
        if (dir == "rtl")
        {
            write('align="left"')
        }
        else
        {
            write('align="right"')
        }
        write('valign="top">');
        write('<table border="0" cellpadding="0" cellspacing="0" >');
        write("<tr>");
        write('<td colspan="12" style="background-image:url(../Renderer/images/' + applangcode + '/dotstile.gif); background-repeat:repeat-x;"><spacer type="block" width="1" height="1"></spacer></td>');
        write("</tr>");
        write("<tr>");
        write('<td><img src="../Renderer/images/' + applangcode + '/arrow.gif" width="18" height="17"></td>');
        write('<td width="1"><img src="../Renderer/images/' + applangcode + '/divider_topnavi.gif" width="1" height="17"></td>');
        if (!isONSLogin)
        {
            showMainMenu()
        }
        if (isFG)
        {
            showMenu()
        }
        if (isLoggedInFin)
        {
            switch (iMemopad)
            {
                case MEMOPAD_NONE:
                    showMemo();
                    showBg();
                    if (!isFG)
                    {
                        exitBg()
                    }
                    break;
                case MEMOPAD_NORMAL:
                    if (isFG)
                    {
                        exitMemo()
                    }
                    else
                    {
                        showMemo();
                        showBg();
                        exitBg()
                    }
                    break;
                case MEMOPAD_BG:
                    if (isBG)
                    {
                        exitMemo()
                    }
                    break
            }
            showCCY()
        }
        write("</tr>");
        write("</table></td>");
        write("</tr>");
        write("<tr>");
        write('<td colspan="2"></td>');
        write("</tr>");
        write("<tr>");
        write('<td colspan="2" background="../Renderer/images/' + applangcode + '/bottomtile.gif"><table width="100%" border="0" cellpadding="0" cellspacing="0">');
        write("<tr>");
        write('<td width="30%"><img src="../Renderer/images/' + applangcode + '/UBSI.gif" width="275" height="23" border="0"></td>');
        write('<td width="70%"');
        if (dir == "rtl")
        {
            write('align="left">')
        }
        else
        {
            write('align="right">')
        }
        write('<table border="0" cellpadding="0" cellspacing="0">');
        write("<tr>");
        write('<td class="titletxt">');
        write('<table border="0" cellpadding="0" cellspacing="0">');
        write("<tr>");
        if (isProdEnv == undefined || isProdEnv != "Y" || isProdEnv == "")
        {
            write("<td>locale&nbsp;&nbsp;" + jsUtil.encodeChar(localeCode) + "</td>");
            write('<td class="textfieldspcms">|</td>')
        }
        write("<td>" + jsUtil.encodeChar(headDate) + "</td>");
        write('<td class="textfieldspcms">|</td>');
        write("<td>" + jshRes.FLT002159 + "&nbsp;&nbsp;" + jsUtil.encodeChar(headUserId) + "</td>");
        write('<td class="textfieldspcms">|</td>');
        write("<td>" + jsUtil.encodeChar(headCtxSol) + "</td>");
        write('<td class="textfieldspcms">|</td>');
        write("</tr>");
        write("</table>");
        write("</td>");
        write
            ('<td class="textlabelms">' + jshRes.FLT009122 + ":</td>");
        write('<td class="textfieldms"><input name="menuName" id="menuName" type=TEXT class="textfieldfontms" ');
        if (isMenuShrtcutProt == "Y" || isPopupWindow())
        {
            write(" disabled ")
        }
        write('size="9" maxlength=8 onKeyDown = "fnGo(\'\',event)">');
        write('<input type="hidden" name="bgMenuUrl">');
        write("</td>");
        write('<td class="textfieldbtnms"><input id="gotomenu" type="button" name="gotomenu" ');
        if (isMenuShrtcutProt == "Y" || isPopupWindow())
        {
            write(" disabled ")
        }
        write('value="' + jshRes.FLT000885 + '" class="buttonms"  onClick = "fnGo(\'Go\')">&nbsp;</td>');
        write("</tr>");
        write("</table>");
        write("</td>");
        write("</tr></table>");
        write("</td>");
        write("</tr>");
        write("</table>");
        write("<div id='menutree_div' style='position:absolute; width:263px; z-index:0; left: 0px; top:62px; visibility: hidden;' border=0>");
        write('<table id="mtitle_tab" width="100%" border="0" cellspacing="0" cellpadding="1">');
        write('<tr><td width="57%" align="right" bgcolor="#9AB4CB">Menu</td>');
        write('<td width="43%" align="right" bgcolor="#9AB4CB"><img src="../Renderer/images/' + applangcode + '/X.gif" alt=' + finbranchResource.FAT001041 + ' width="15" height="14" border="0" onClick="HIDE_menutree()" style="cursor:hand" hspace="0"></td>');
        write("</tr></table>");
        write("<iframe id='menutree' frameborder='0' marginheight='0' marginwidth='0' scrolling='auto' height='100%' width='100%' src='javascript:false;'></iframe></div>");
        write("<div id='cancelwait_div' style='position:absolute; width:100px; height:100px; z-index:0; visibility:hidden;'>");
        write("<iframe name='cancelwait' id='cancelwait' frameborder='0' marginheight='0' marginwidth='0' scrolling='no' height='100%' width='100%' src='javascript:false;'></iframe></div>");
        write("</body>")
    }
}

function adjustMenuDiv()
{
    var a = document.getElementById("menutree_div");
    a.style.height = document.body.clientHeight - 79
}

function fnMenuHdr(b, a)
{
    frm = document.forms[0];
    if (frm.screenName != undefined && pre_HDR_SWITCH(frm.screenName.value, b) == false)
    {
        return false
    }
    if (a == "true" && !menuInfoDownloaded)
    {
        getMenuTreeData();
        if (!menuInfoDownloaded)
        {
            return
        }
    }
    doSubmit(b);
    if (frm.screenName != undefined && post_HDR_SWITCH(frm.screenName.value, b) == false)
    {
        return false
    }
}

function exitBgMenu()
{
    doSubmit("showbgparent")
}

function callbgmenu(b, d, e, c, g, f)
{
    var h = b.split("/");
    var i = "";
    if (h.length > 0)
    {
        i = h[0]
    }
    if (bgParentGroup == i)
    {
        alert(finbranchResArr.get("FAT002726"));
        return false
    }
    var a = "/" + b;
    a += "?sessionid=" + sessionid + "&fabsessionid=" + fabsessionid + "&finsessionid=" + finsessionid + "&mo=" + d + "&isBgMenu=Y";
    if (e != "")
    {
        a += "&mtype=" + e
    }
    if (c != "")
    {
        a += "&sid=" + c
    }
    if (g != "")
    {
        a += "&mprec=" + g
    }
    if (f != undefined && !fnIsNull(f))
    {
        a += "&" + f
    }
    document.forms[0].bgMenuUrl.value = a;
    doSubmit("showbgmenu")
}

function MM_preloadImages()
{
    var f = document;
    if (f.images)
    {
        if (!f.MM_p)
        {
            f.MM_p = new Array()
        }
        var e, c = f.MM_p.length,
            b = MM_preloadImages.arguments;
        for (e = 0; e < b.length; e++)
        {
            if (b[e].indexOf("#") != 0)
            {
                f.MM_p[c] = new Image;
                f.MM_p[c++].src = b[e]
            }
        }
    }
}

function MM_swapImgRestore()
{
    var d, b, c = document.MM_sr;
    for (d = 0; c && d < c.length && (b = c[d]) && b.oSrc; d++)
    {
        b.src = b.oSrc
    }
}

function MM_findObj(f, e)
{
    var c, b, a;
    if (!e)
    {
        e = document
    }
    if ((c = f.indexOf("?")) > 0 && parent.frames.length)
    {
        e = parent.frames[f.substring(c + 1)].document;
        f = f.substring(0, c)
    }
    if (!(a = e[f]) && e.all)
    {
        a = e.all[f]
    }
    for (b = 0; !a && b < e.forms.length; b++)
    {
        a = e.forms[b][f]
    }
    for (b = 0; !a && e.layers && b < e.layers.length; b++)
    {
        a = MM_findObj(f, e.layers[b].document)
    }
    if (!a && e.getElementById)
    {
        a = e.getElementById(f)
    }
    return a
}

function MM_swapImage()
{
    var e, d = 0,
        b, c = MM_swapImage.arguments;
    document.MM_sr = new Array;
    for (e = 0; e < (c.length - 2); e += 3)
    {
        if ((b = MM_findObj(c[e])) != null)
        {
            document.MM_sr[d++] = b;
            if (!b.oSrc)
            {
                b.oSrc = b.src
            }
            b.src = c[e + 2]
        }
    }
}

function HIDE_menutree()
{
    var a = get_lyr_css("menutree");
    if (a)
    {
        a.display = "none"
    }
    a = get_lyr_css("mtitle_tab");
    if (a)
    {
        a.display = "none"
    }
    hideMenuTreeForNonIE()
}

function hideMenuTreeForNonIE()
{
    document.getElementById("mtitle_tab").style.zIndex = -1;
    document.getElementById("menutree").style.zIndex = -1;
    document.getElementById("menutree_div").style.zIndex = -1;
    document.getElementById("mtitle_tab").style.visibility = "hidden";
    document.getElementById("menutree").style.visibility = "hidd
    en ";document.getElementById("
    menutree_div ").style.visibility="
    hidden "}function showMenuTreeForNonIE(){document.getElementById("
    mtitle_tab ").style.visibility="
    visible ";document.getElementById("
    menutree ").style.visibility="
    visible ";document.getElementById("
    menutree_div ").style.visibility="
    visible ";document.getElementById("
    mtitle_tab ").style.zIndex=1;document.getElementById("
    menutree ").style.zIndex=1;document.getElementById("
    menutree_div ").style.zIndex=1}function exitMemopad(){doSubmit("
    exitMP ")}function doLogout(){handleWindowDisplay(finConst.DOLOGOUT)}function showMainMenu(){document.write('<td class="
    topnavi_bottom " onmouseover="
    this.className = \' bgTd \' " onMouseOut="this.className=\' topnavi_bottom \' "><a id="anc_main" href="javascript:fnCallMainMenu();" class="topnavi" >' + jshRes.FLT003487 + "</a></td>")
}

function showMenu()
{
    with(document)
    {
        write('<td width="1"><img src="../Renderer/images/' + applangcode + '/divider_topnavi.gif" width="1" height="17"></td>');
        write('<td class="topnavi_bottom" onmouseover="this.className=\' bgTd \' " onMouseOut="this.className=\' topnavi_bottom \' "><a id="anc_html" href="javascript:fnHtmlMenu();" class="topnavi" >' + jshRes.FLT013652 + "</a></td>")
    }
}

function showMemo()
{
    with(document)
    {
        write('<td width="1"><img src="../Renderer/images/' + applangcode + '/divider_topnavi.gif" width="1" height="17"></td>');
        write('<td id="showmemoleftcurve" class="topnavi_bottom" onmouseover="this.className=\' bgTd \' " onMouseOut="this.className=\' topnavi_bottom \' " ><a  id="anc_hdrm" href="javascript:fnMenuHdr(\'showmemopad\',\'false\');" class="topnavi">' + jshRes.FLT020843 + "</a></td>")
    }
}

function exitMemo()
{
    with(document)
    {
        write('<td width="1"><img src="../Renderer/images/' + applangcode + '/divider_topnavi.gif" width="1" height="17"></td>');
        write('<td id="exitmemoleftcurve" class="topnavi_bottom" onmouseover="this.className=\' bgTd \' " onMouseOut="this.className=\' topnavi_bottom \' "><a  id="anc_hmemo" href="javascript:exitMemopad();" class="topnavi">' + jshRes.FLT020844 + "</a></td>")
    }
}

function showBg()
{
    with(document)
    {
        write('<td width="1"><img src="../Renderer/images/' + applangcode + '/divider_topnavi.gif" width="1" height="17"></td>');
        write('<td id="bgmenuleftcurve" class="topnavi_bottom" onmouseover="this.className=\' bgTd \' " onMouseOut="this.className=\' topnavi_bottom \' "><a  id="anc_mhdr" href="javascript:fnMenuHdr(\'showbglist\',\'true\');" class="topnavi">' + jshRes.FLT020845 + "</a></td>")
    }
}

function exitBg()
{
    with(document)
    {
        write('<td width="1"><img src="../Renderer/images/' + applangcode + '/divider_topnavi.gif" width="1" height="17"></td>');
        write('<td id="exitbgmenuleftcurve" class="topnavi_bottom" onmouseover="this.className=\' bgTd \' " onMouseOut="this.className=\' topnavi_bottom \' "><a  id="anc_bgmn" href="javascript:exitBgMenu();" class="topnavi">' + jshRes.FLT020846 + "</a></td>")
    }
}

function showCCY()
{
    with(document)
    {
        write('<td width="1"><img src="../Renderer/images/' + applangcode + '/divider_topnavi.gif" width="1" height="17"></td>');
        write('<td class="topnavi_bottom" onmouseover="this.className=\' bgTd \' " onMouseOut="this.className=\' topnavi_bottom \' "><a id="anc_hcrnc" href="javascript:showCrncyConverter();" class="topnavi" >' + jshRes.FLT003104 + "</a></td>")
    }
}

function validatePassword(d)
{
    var a = true;
    if (SSO)
    {
        var c;
        if (window.parent.getLoginFrame != undefined && window.parent.getLoginFrame() != undefined)
        {
            c = window.parent.getLoginFrame().validateAuthorizerWithID(headUserId.toUpperCase(), "Authorizer Login Page")
        }
        var b = (c != undefined) ? c.token : null;
        if (b != undefined && !fnIsNull(b))
        {
            a = true;
            d.authtok = b;
            d.authuser = c.user;
            d.ssosessionid = getSSOSessId()
        }
        else
        {
            a = false
        }
    }
    return a
}

function getDateForDisplay(dateVal, day, month, year)
{
    var hijriMonthDesc = new Array("FLT020962", "FLT020963", "FLT020964", "FLT020965", "FLT020966", "FLT020967", "FLT020968", "FLT020969", "FLT020970", "FLT020971", "FLT020973", "FLT020974");
    var gregMonthDesc = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
    var locHeadDate = dateVal;
    var locDate = day + "-" + month + "-" + year;
    var convDate;
    var monthVal;
    var monthDesc;
    switch (calbase)
    {
        case "01":
            if (!isHijDate(locDate))
            {
                convDate = convertGregToHij(locDate);
                monthVal = parseInt(convDate.substring(3, 5), 10);
                monthDesc = eval("this.jshRes." + hijriMonthDesc[monthVal - 1]);
                locHeadDate = convDate.substring(0, 2) + " " + monthDesc + "," + convDate.substring(6, 10)
            }
            break;
        case "02":
            if (!isBuddhaDate(locDate))
            {
                convDate = convertGregToBuddha(locDate);
                monthVal = parseInt(convDate.substring(3, 5), 10);
                monthDesc = gregMonthDesc[monthVal - 1];
                locHeadDate = convDate.substring(0, 2) + " " + monthDesc + "," + convDate.substring(6, 10)
            }
            break;
        default:
            locHeadDate = dateVal;
            break
    }
    return locHeadDate
}

function getAbsoluteUrl(b)
{
    var a = document.location.href;
    a = a.substring(0, a.lastIndexOf("/") + 1);
    if (b.indexOf("http://") == -1 && b.indexOf("https://") == -1)
    {
        b = a + b
    }
    return b
};
