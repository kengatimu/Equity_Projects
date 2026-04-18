function printBlock1() {
    writeHeader("aclcrit");
    with(document) {
        write("<center>");
        write('<input type="hidden" name="submitform" value="">');
        write('<input type="hidden" name="pagename" value="aclcrit">');
        write('<input type="hidden" name="tempAcctId" id="tempAcctId" value="aclcrit">');
        write('<input type="hidden" name="' + group + '.schmType" id="schmType" value="">');
        write('<table class="ctable" width="100%" border="0" cellspacing="0" cellpadding="0">');
        write("<tr>");
        write('<td class="page-heading">');
        if (mopId == "HALHI") {
            write("" + jspResArr.get("FLT017338") + "&nbsp;")
        } else {
            write("" + jspResArr.get("FLT002525") + "&nbsp;")
        }
        write("</td>");
        write("</tr>");
        write("</table>");
        write("</center>")
    }
}

function printBlock2() {
    with(document) {
        write("<center>");
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">');
        write("<tr>");
        write("<td>");
        write('<table width="100%" border="0" cellspacing="0" cellpadding="0">');
        write("<tr >");
        write('<td valign="Top">');
        write("</td>");
        write("</tr>");
        write("</table>");
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
        write("<tr>");
        write("<td>");
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
        write("<tr>");
        write("<td>");
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');
        write("<tr>");
        write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
        write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
        write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
        write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
        write('<td align="right">');
        write('<table border="0" cellspacing="0" cellpadding="0">');
        write("<tr>");
        write("<td> </td>");
        write('<td align="right">');
        write('<a id="sLnk5" href="javascript:showHelpFile(\'aclcrit_help.htm\');">');
        write('<img align="right" class="img" src="../Renderer/images/' + applangcode + '/help.gif" border="0" hotKeyId="finHelp">');
        write("</img></a></td>");
        write("</tr>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write('<tr class="innertabletop">');
        write('<td class="textlabel">' + jspResArr.get("FLT000360") + '<script>setMandatory("Y");<\/script></td>');
        write('<td class="textfield">');
        write('<input type="radio" id="operation" name="' + group + '.operation" value="S" fmnd="Y" onClick="javascript:return aclcrit_ONCLICK4(this);">&nbsp;' + jspResArr.get("FLT000306") + "");
        write('<input type="radio" id="operation" name="' + group + '.operation" value="D" onClick="javascript:return aclcrit_ONCLICK5(this);">');
        write("&nbsp;" + jspResArr.get("FLT000345") + "</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">&nbsp;</td>');
        write('<td class="textfielddisplaylabel">&nbsp;</td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT000204") + '<script>setMandatory("Y");<\/script></td>');
        write('<td class="textfield">');
        write('<select class="listboxfont" id="funcCode" fmnd="Y" name="' + group + '.funcCode" onChange="javascript:return aclcrit_ONCHANGE6(this);">');
        if (mopId == "HALHI"){
        	write('<script>writeInquiryFuncCode();<\/script>');
	      }
	      else{
	        write('<script>writeAclhmFuncCodes();<\/script>');
	      }
        write("</select></td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">&nbsp;</td>');
        write('<td class="textfielddisplaylabel">&nbsp;</td>');
        write("</tr>");
        write('<tr class="innertabletop">');
        write('<td class="textlabel">' + jspResArr.get("FLT000265") + '<script>setMandatory("Y");<\/script></td>');
        write('<td td colspan="4" class="textfield">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'aclcrit\',this);" type="text" id="acctId" name="' + group + '.acctId" fmnd="Y" size="28" maxlength="16" class="textfieldfont" fdt="accountid" onChange="javascript:return aclcrit_ONCHANGE7(this,this,\'acctName\',\'solId\',\'crncyCode\',false,\'VALCUSTACCTID\',document.forms[0].funcCode);" hotKeyId="search1">&nbsp;');
        write('<a target=_self id="sLnk1" href="javascript:fnGetAcctIdList(document.forms[0].funcCode)">');
        write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search1"></img></a>');
        write("&nbsp;");
        write('<input class="label" name="' + group + '.crncyCode" id="crncyCode" value="" maxlength=3 size="3" fds="Y" disabled>');
        write('<input class="label" name="' + group + '.solId" id="solId" value="" maxlength=8 size="8" fds="Y" disabled>');
        write('<input class="label" name="' + group + '.acctName" id="acctName" value="" maxlength=30 size="30" fds="Y" disabled>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT001447") + "");
        write('<script>setMandatory("' + aclhmProps.get("templateId_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'aclcrit\',this);" type="text" class="textfieldfont" id="templateId" name="' + group + '.templateId" fmnd="' + aclhmProps.get("templateId_MANDATORY") + '" size="20" maxlength="25" ' + aclhmProps.get("templateId_ENABLED") + ' onChange="javascript:return aclcrit_ONCHANGE8(this);" hotKeyId="search3">&nbsp;');
        write('<a id="sLnk2" target=_self href="Javascript:showGtmplSearcher()">');
        write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId');
        write('="search3"></img></a>');
        write('<input class="label" name="' + group + '.templateType" id="templateType" fds="Y" size=8 disabled>');
        write("</td>");
        write("<tr>");
        write('<tr class="rowspacingbottom">');
        write('<td colspan="5"><spacer type="block" height="1" width="1"></spacer></td>');
        write("</tr>");
        write("</tr>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write("</table>");
        write("</span>");
        write("</center>")
    }
}

function printFooterBlock() {
    with(document) {
        if ((sReferralMode == "I") || (sReferralMode == "S")) {
            write('<div class="ctable">');
            if (sReferralMode == "S") {
                write('<input type="button" class="Button" id="Submit" value="' + jspResArr.get("FLT000193") + '" onClick="javascript:return doRefSubmit(this);"	hotKeyId="Submit" >')
            }
            writeRefFooter();
            write('<input type="button" class="Button" id="_BackRef_" value="' + jspResArr.get("FLT000192") + '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
            write("</div>")
        } else {
            write('<div class="ctable">');
            write('<input type="button" id="Go" name="Go" value="' + jspResArr.get("FLT004977") + '" class="button" maxlength="10" onClick="javascript:return aclcrit_ONCLICK9(this,this);" hotKeyId="Go" >');
            write('<input type="button" id="Clear" name="Clear" value="' + jspResArr.get("FLT001439") + '" class="button" maxlength="10" onClick="javascript:return aclcrit_ONCLICK10(this,this);">');
            if (eval(isCalledMenu) != undefined && isCalledMenu) {
                write('<input type="button" name="backToParent" class="button" onClick="javascript:return aclcrit_ONCLICK11(this,this);" id="backToParent" value="' + jspResArr.get("FLT010756") + '">')
            }
            writeFooter();
            write("</div>")
        }
    }
}

function fnPopulateControlValues() {
    var a = document.forms[0];
    a.funcCode.value = funcCode;
    a.acctId.value = acctId;
    a.solId.value = solId;
    a.crncyCode.value = crncyCode;
    a.acctName.value = acctName;
    a.templateId.value = templateId;
    if ((sReferralMode == "I") || (sReferralMode == "S")) {
        fnDisableFormDataControls("V", a, 0)
    }
}

function aclcrit_ONKEYDOWN1(b, c) {
    var a = "";
    if (preEventCall("aclcrit", b, "ONKEYDOWN") == false) {
        return false
    }
    if ((a = fnKeyDownProcessor(c)) == false) {
        return false
    }
    if (postEventCall("aclcrit", b, "ONKEYDOWN") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function aclcrit_ONKEYUP2(b, c) {
    var a = "";
    if (preEventCall("aclcrit", b, "ONKEYUP") == false) {
        return false
    }

    if ((a = fnKeyUpProcessor(c)) == false) {
        return false
    }
    if (postEventCall("aclcrit", b, "ONKEYUP") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function aclcrit_ONLOAD3(c) {
    var b = "";
    var a = document.forms[0];
    if (pre_ONLOAD("aclcrit", c) == false) {
        return false
    }
    if ((b = fnLoad()) == false) {
        return false
    }
    fnPopUpExceptionWindow(a.actionCode);
    if (post_ONLOAD("aclcrit", c) == false) {
        return false
    }
    return (b == undefined) ? true : b
}

function aclcrit_ONCLICK4(b) {
    var a = "";
    if (preEventCall("aclcrit", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnProtectFuncCode()) == false) {
        return false
    }
    if (postEventCall("aclcrit", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function aclcrit_ONCLICK5(b) {
    var a = "";
    if (preEventCall("aclcrit", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnProtectFuncCode()) == false) {
        return false
    }
    if (postEventCall("aclcrit", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function aclcrit_ONCHANGE6(b) {
    var a = "";
    if (preEventCall("aclcrit", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = disableFld()) == false) {
        return false
    }
    if (postEventCall("aclcrit", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function aclcrit_ONCHANGE7(b, i, h, g, f, e, d, c) {
    var a = "";
    if (preEventCall("aclcrit", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = fetchAcctDtls(i, h, g, f, e, d, c)) == false) {
        return false
    }
    if (postEventCall("aclcrit", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function aclcrit_ONCHANGE8(b) {
    var a = "";
    if (preEventCall("aclcrit", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = fnGetTemplateData()) == false) {
        return false
    }
    if (postEventCall("aclcrit", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function aclcrit_ONCLICK9(b, c) {
    var a = "";
    if (preEventCall("aclcrit", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnButtonClick(c)) == false) {
        return false
    }
    if (postEventCall("aclcrit", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function aclcrit_ONCLICK10(b, c) {
    var a = "";
    if (preEventCall("aclcrit", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnButtonClick(c)) == false) {
        return false
    }
    if (postEventCall("aclcrit", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function aclcrit_ONCLICK11(b, c) {
    var a = "";
    if (preEventCall("aclcrit", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnButtonClick(c)) == false) {
        return false
    }
    if (postEventCall("aclcrit", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function writeInquiryFuncCode() {
    with(document) {
        write('<OPTION selected Value="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="I">' + jspResArr.get("FLT012159") + "</OPTION>")
    }
}

function writeAclhmFuncCodes() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="D">' + jspResArr.get("FLT013215") + "</OPTION>");
        write('<OPTION VALUE="I">' + jspResArr.get("FLT012159") + "</OPTION>");
        write('<OPTION VALUE="M">' + jspResArr.get("FLT012350") + "</OPTION>");
        write('<OPTION VALUE="V">' + jspResArr.get("FLT013170") + "</OPTION>");
        write('<OPTION VALUE="W">' + jspResArr.get("FLT012385") + "</OPTION>");
        write('<OPTION VALUE="X">' + jspResArr.get("FLT012392") + "</OPTION>");
        write('<OPTION VALUE="T">' + jspResArr.get("FLT020990") + "</OPTION>")
    }
};