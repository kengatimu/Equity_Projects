function printBlock() {
    writeHeader("ictmselcrit");
    with(document) {
        write('<input type="hidden" name="submitform" >');
        write('<input type="hidden" name="pagename" value="ictmselcrit">');
        write('<input type="hidden" id="funcCode" name="' + sGroupName + '.funcCode">');
        write('<input type="hidden" id="ctsEnabledFlg" name="' + sGroupName + '.ctsEnabledFlg">');
        write('<input type="hidden" id="enableOrDisableValFlgs" name="enableOrDisableValFlg" value="Y">');
        write('<table class="ctable" cellspacing="0" cellpadding="0">');
        write("<tr>");
        write('<td class="page-heading" colspan="5">' + jspResArr.get("FLT001674") + " &nbsp;</td>");
        write("</tr>");
        write("</table>");
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">');
        write("<tr>");
        write("<td>");
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT000204") + "");
        write("</td>");
        write('<td class="textfielddisplaylabel">');
        write('<input class="label" id="locFuncCode" size="15" fds="Y" disabled>');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000003") + "");
        write("</td>");
        write('<td class="textfielddisplaylabel">');
        write('<input class="label" id="solId" name="' + sGroupName + '.solId" fds="Y" size="8" maxlength="8" disabled>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT002008") + "");
        write("</td>");
        write('<td class="textfielddisplaylabel">');
        write('<input class="label" id="zoneCode" name="' + sGroupName + '.zoneCode" fds="Y" size="10" maxlength="10" disabled>/</td>');
        PRINTDATELABEL("zoneDate", "Y", "", "", "") / write('<td class="textfielddisplaylabel"><input class="label" id="cZoneSrlNum" name="' + sGroupName + '.cZoneSrlNum" fds="Y" size="6" maxlength="6" disabled>/&nbsp;');
        write('<input class="label" id="crncy" name="' + sGroupName + '.crncy" fds="Y" size="6" maxlength="6" disabled>');
        write("</td>");
        write("</tr>");
        write("</table>");
        write('<table class="ctable" width="100%" border="0" cellspacing="0" cellpadding="0">');
        write('<tr class="rowspacing" >');
        write('<td colspan="5">&nbsp;</td>');
        write("</tr>");
        write("</table>");
        write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
        write("<tr>");
        write('<td valign="top">');
        write("</td> </tr> </table>");
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
        write("<tr>");
        write("<td>");
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
        write("<tr>");
        write("<td>");
        write('<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop1">');
        write("<tr>");
        write("<td>");
        write("<tr>");
        write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
        write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
        write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
        write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
        write('<td align="right"><table border="0" cellspacing="0" cellpadding="0">');
        write("<tr>");
        write("<td> </td>");
        write('<td align="right"><a id="sLnk1" href="javascript:showHelpFile(\'ictmselcrit_help.htm\');"><img border="0" src="../Renderer/images/' + applangcode + '/help.gif" hotKeyId="finHelp"></img></a></td>');
        write("</tr>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT000593") + "");
        write("</td>");
        write('<td class="textfield">');
        write('<input class="textfieldfont" id="cInstNum" name="' + sGroupName + '.cInstNum" fdt="fpint" size="18" maxlength="16">');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT002063") + "");
        write("</td>");
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" class="listboxfont" id="cAcctIdSelInd" name="' + sGroupName + '.cAcctIdSelInd" >');
        write('<script>writeComboFunction("writeICTMselectOptions");<\/script>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT000548") + "");
        write("</td>");
        write('<td class="textfield" colspan="4">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'ictmselcrit\',this);" type="text" class="textfieldfont" id="cStartAcctNum" name="' + sGroupName + ".cStartAcctNum\" size=\"18\" fdt=\"accountid\" maxlength=\"16\" onChange=\"javascript:return ictmselcrit_ONCHANGE4(this,'cStartAcctCrncy','cStartAcctSolId','cStartAcctName',this,'cStartAcctName','cStartAcctSolId','cStartAcctCrncy',true,'VALVRFDACCTID');\" " + ictmProps.get("cStartAcctNum_ENABLED") + ' hotKeyId="search1">');
        write('&nbsp;<a target="_self" id="sLnk1" href="JavaScript:showAccountIdList(document.forms[0].cStartAcctNum,document.forms[0].cStartAcctSolId,document.forms[0].cStartAcctName,\'F\',document.forms[0].cStartAcctCrncy);">');
        write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search1"></a>');
        write("&nbsp;");
        write('<input class="label" id="cStartAcctCrncy" name="' + sGroupName + '.cStartAcctCrncy" size="3" maxlength="3" fds="Y" disabled >');
        write('&nbsp;<input class="label" id="cStartAcctSolId" name="' + sGroupName + '.cStartAcctSolId" size="8" maxlength="8" fds="Y" disabled >');
        write('&nbsp;<input class="label" id="cStartAcctName" name="' + sGroupName + '.cStartAcctName" size="30" maxlength="30" fds="Y" disabled >');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT001374") + "");
        write("</td>");
        write('<td class="textfield" colspan="4" >');
        write('<input onBlur="javascript:return custom_ONBLUR(\'ictmselcrit\',this);" type="text" class="textfieldfont" id="cEndAcctNum" name="' + sGroupName + ".cEndAcctNum\" size=\"18\" fdt=\"accountid\" maxlength=\"16\" onChange=\"javascript:return ictmselcrit_ONCHANGE5(this,'cEndAcctCrncy','cEndAcctSolId','cEndAcctName',this,'cEndAcctName','cEndAcctSolId','cEndAcctCrncy',true,'VALVRFDACCTID');\" " + ictmProps.get("cEndAcctNum_ENABLED") + ' hotKeyId="search2">');
        write('&nbsp;<a target="_self" id="sLnk2" href="JavaScript:showAccountIdList(document.forms[0].cEndAcctNum,document.forms[0].cEndAcctSolId,document.forms[0].cEndAcctName,\'F\',document.forms[0].cEndAcctCrncy);">');
        write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search2"></a>');
        write("&nbsp;");
        write('<input class="label" id="cEndAcctCrncy" name="' + sGroupName + '.cEndAcctCrncy" size="3" maxlength="3" fds="Y" disabled >');
        write('&nbsp;<input class="label" id="cEndAcctSolId" name="' + sGroupName + '.cEndAcctSolId" size="8" maxlength="8" fds="Y" disabled >');
        write('&nbsp;<input class="label" id="cEndAcctName" name="' + sGroupName + '.cEndAcctName" size="30" maxlength="30" fds="Y" disabled >');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT002061") + "");
        write("</td>");
        write('<td class="textfield">');
        write('<input class="textfieldfont" id="cFrmInstAmt" name="' + sGroupName + '.cFrmInstAmt" size="26" maxlength="24" onBlur="javascript:return ictmselcrit_ONBLUR6(this,\'' + format + "',this,'" + crncy + "','N');\" style=\"TEXT-ALIGN:right\">");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT002062") + "");
        write("</td>");
        write('<td class="textfield">');
        write('<input class="textfieldfont" id="cToInstAmt" name="' + sGroupName + '.cToInstAmt" size="26" maxlength="24" onBlur="javascript:return ictmselcrit_ONBLUR7(this,\'' + format + "',this,'" + crncy + "','N');\" style=\"TEXT-ALIGN:right\">");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT002070") + "");
        write('<script>setMandatory("' + ictmProps.get("cAcctSetId_MANDATORY") + '")<\/script>');
        write("</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmselcrit\',this);" type="text" class="textfieldfont" id="cAcctSetId" name="' + sGroupName + '.cAcctSetId" size="8" maxlength="8" ' + ictmProps.get("cAcctSetId_ENABLED") + ' hotKeyId="search3">');
        write('&nbsp;<a target="_self" id="sLnk1" href="JavaScript:showSolId(document.forms[0].cAcctSetId,\'ctrl\',\'F\')">');
        write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search3"></a>');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000017") + "");
        write('<script>setMandatory("' + ictmProps.get("cAcctMgr_MANDATORY") + '")<\/script>');
        write("</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmselcrit\',this);" type="text" class="textfieldfont" id="cAcctMgr" name="' + sGroupName + '.cAcctMgr" size="16" maxlength="15" ' + ictmProps.get("cAcctMgr_ENABLED") + ' hotKeyId="search4">');
        write('&nbsp;<a target="_self" id="sLnk1" href="JavaScript:showUserIdList(document.forms[0].cAcctMgr,null,\'F\')">');
        write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search4"></a>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT002066") + "");
        write("</td>");
        write('<td class="textfield">');
        write('<select class="listboxfont" id="cRejInd" name="' + sGroupName + '.cRejInd" onchange="javascript:return ictmselcrit_ONCHANGE8(this);">');
        write('<script>writeComboFunction("writeIctmSelRejTypes");<\/script>');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT009285") + "");
        write('<script>setMandatory("' + ictmProps.get("cRejectReasonCode_MANDATORY") + '")<\/script>');
        write("</td>");
        write('<td class="textfield">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'ictmselcrit\',this);" type="text" class="textfieldfont" id="cRejectReasonCode" name="' + sGroupName + '.cRejectReasonCode" size="3" maxlength="2" onChange="javascript:return ictmselcrit_ONCHANGE9(this,\'rejectReasonDesc\');" ' + ictmProps.get("cRejectReasonCode_ENABLED") + ' hotKeyId="search5">');
        //write('&nbsp;<a target="_self" id="sLnk1" href="JavaScript:showRejReasonList(document.forms[0].cRejectReasonCode,document.forms[0].rejectReasonDesc,\'F\',\'N\')">');
        write('&nbsp;<a target="_self" id="sLnk1" href="JavaScript:showCustomRejReasonList(document.forms[0].cRejectReasonCode,document.forms[0].rejectReasonDesc,\'F\',\'N\')">');
		write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search5"></a><br>');
        write('<input onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmselcrit\',this);" id="rejectReasonDesc"  disabled fblk="defaultFblk2" name="' + sGroupName + '.rejectReasonDesc" type="text" disabled="true" class="label" size="25" maxlength="25">');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT000597") + "");
        write('<script>setMandatory("' + ictmProps.get("cStartTranCode_MANDATORY") + '")<\/script>');
        write("</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmselcrit\',this);" type="text" class="textfieldfont" id="cStartTranCode" name="' + sGroupName + '.cStartTranCode" size="4" maxlength="3" ' + ictmProps.get("cStartTranCode_ENABLED") + ' hotKeyId="search6">');
        write('&nbsp;<a target="_self" id="sLnk3" href="JavaScript:showTranCode(document.forms[0].cStartTranCode)">');
        write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search6"></a>');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT002069") + "");
        write('<script>setMandatory("' + ictmProps.get("cEndTranCode_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmselcrit\',this);" type="text" class="textfieldfont" id="cEndTranCode" name="' + sGroupName + '.cEndTranCode" size="3" maxlength="3" ' + ictmProps.get("cEndTranCode_ENABLED") + ' hotKeyId="search7">');
        write('&nbsp;<a target="_self" id="sLnk4" href="JavaScript:showTranCode(document.forms[0].cEndTranCode)">');
        write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search7"></a>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT002067") + "");
        write("</td>");
        write('<td class="textfield">');
        write('<input class="textfieldfont" fdt="fpint" id="cFrmZnSrlNum" name="' + sGroupName + '.cFrmZnSrlNum" size="8" maxlength="6">');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT002068") + "");
        write("</td>");
        write('<td class="textfield">');
        write('<input class="textfieldfont" fdt="fpint" id="cToZnSrlNum" name="' + sGroupName + '.cToZnSrlNum" size="8" maxlength="6">');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT002063") + "</td>");
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" class="listboxfont" id="lstRcd" name="' + sGroupName + '.lstRcd">');
        write('<script>writeComboFunction("writeLctRcdSel");<\/script>');
        write("</select>");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT002064") + "</td>");
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" class="textfieldinsidemultirec1" id="cAcctNumSortInd" name="' + sGroupName + '.cAcctNumSortInd">');
        write('<script>writeComboFunction("writeICTMsortingOrder1");<\/script>');
        write("</select>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" class="textfieldinsidemultirec1" id="cTranCodeSortInd" name="' + sGroupName + '.cTranCodeSortInd">');
        write('<script>writeComboFunction("writeICTMsortingOrder2");<\/script>');
        write("</select>");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" class="listboxfont" id="cVerifyFlg" name="' + sGroupName + '.cVerifyFlg">');
        write('<script>writeComboFunction("writeCVerifyFlg");<\/script>');
        write("</select>");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" class="textfieldinsidemultirec1" id="cItemSeqNumSortInd" name="' + sGroupName + '.cItemSeqNumSortInd">');
        write('<script>writeComboFunction("writeICTMsortingOrder3");<\/script>');
        write("</select>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" class="textfieldinsidemultirec1" id="cEntrUserSortInd" name="' + sGroupName + '.cEntrUserSortInd">');
        write('<script>writeComboFunction("writeICTMsortingOrder4");<\/script>');
        write("</select>");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" class="listboxfont" id="cCarveFlg" name="' + sGroupName + '.cCarveFlg">');
        write('<script>writeComboFunction("writeCCarveFlg");<\/script>');
        write("</select>");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        if (funcCode == "I") {
            write('<td class="textlabel">' + jspResArr.get("FLT010130") + '<script>setMandatory("' + ictmProps.get("validationRunFlg_MANDATORY") + '");<\/script></td>');
            write('<td class="textfield">');
            write('<select onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" class="listboxfont" id="validationRunFlg" name="' + sGroupName + '.validationRunFlg" >');
            write('<script>writeComboFunction("writeValidationRunTypes");<\/script>');
            write("</select>");
            write("</td>")
        }
        write("</tr>");
        write("<tr>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" class="listboxfont" id="cSelectAllFlg" name="' + sGroupName + '.cSelectAllFlg">');
        write('<script>writeComboFunction("writeCSelectAllFlg");<\/script>');
        write("</select>");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        if (ctsEnabledFlg == "Y" && funcCode == "I") {
            write('<td class="textlabel">' + jspResArr.get("FLT010131") + '<script>setMandatory("' + ictmProps.get("ctsValStatFlg_MANDATORY") + '");<\/script></td>');
            write('<td class="textfield">');
            write('<select onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" class="listboxfont" id="ctsValStatFlg" name="' + sGroupName + '.ctsValStatFlg" >');
            write('<script>writeComboFunction("writeCtsValidationTypes");<\/script>');
            write("</select>");
            write("</td>")
        }
        write("</tr>");
        write("<tr>");
        write('<td colspan="5" class="rowspacingbottom"></td>');
        write("</tr>");
        write("</td></tr> </table>");
        write("</td></tr> </table>");
        write("</td></tr> </table>");
        write("</td></tr> </table>");
        write("</span>")
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
            write('<input type="button" class="button" id="Accept" name="Accept" value="' + jspResArr.get("FLT000191") + '" onClick="javascript:return ictmselcrit_ONCLICK10(this,document.forms[0].Accept);" hotKeyId="Go" >');
            write('<input type="button" class="button" id="Back" name="Back" value="' + jspResArr.get("FLT003327") + '" onClick="javascript:return ictmselcrit_ONCLICK11(this,document.forms[0].Back);" hotKeyId="Cancel" >');
            writeFooter();
            write("</div>")
        }
    }
}

function fnPopulateControlValues() {
    var a = document.forms[0];
    a.funcCode.value = funcCode;
    a.solId.value = solId;
    a.zoneCode.value = zoneCode;
    a.zoneDate.value = zoneDate;
    a.cZoneSrlNum.value = cZoneSrlNum;
    a.cInstNum.value = cInstNum;
    a.cCarveFlg.value = cCarveFlg;
    a.cVerifyFlg.value = cVerifyFlg;
    a.cSelectAllFlg.value = cSelectAllFlg;
    a.cRejInd.value = cRejInd;
    a.cRejectReasonCode.value = cRejectReasonCode;
    a.cFrmZnSrlNum.value = cFrmZnSrlNum;
    a.cToZnSrlNum.value = cToZnSrlNum;
    a.cStartTranCode.value = cStartTranCode;
    a.cEndTranCode.value = cEndTranCode;
    a.cStartAcctNum.value = cStartAcctNum;
    a.cEndAcctNum.value = cEndAcctNum;
    a.cFrmInstAmt.value = cFrmInstAmt;
    a.cToInstAmt.value = cToInstAmt;
    a.cAcctIdSelInd.value = cAcctIdSelInd;
    a.cAcctSetId.value = cAcctSetId;
    a.cAcctMgr.value = cAcctMgr;
    a.cAcctNumSortInd.value = cAcctNumSortInd;
    a.cTranCodeSortInd.value = cTranCodeSortInd;
    a.cItemSeqNumSortInd.value = cItemSeqNumSortInd;
    a.cEntrUserSortInd.value = cEntrUserSortInd;
    a.crncy.value = crncy;
    a.locFuncCode.value = locFuncCode;
    a.ctsEnabledFlg.value = ctsEnabledFlg;
    if ((sReferralMode == "I") || (sReferralMode == "S")) {
        fnDisableFormDataControls("V", a, 0)
    }
}

function ictmselcrit_ONKEYDOWN1(b, c) {
    var a = "";
    if (preEventCall("ictmselcrit", b, "ONKEYDOWN") == false) {
        return false
    }
    if (preEventCallForLocale("ictmselcrit", b, "ONKEYDOWN") == false) {
        return false
    }
    if ((a = fnKeyDownProcessor(c)) == false) {
        return false
    }
    if (postEventCallForLocale("ictmselcrit", b, "ONKEYDOWN") == false) {
        return false
    }
    if (postEventCall("ictmselcrit", b, "ONKEYDOWN") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function ictmselcrit_ONKEYUP2(b, c) {
    var a = "";
    if (preEventCall("ictmselcrit", b, "ONKEYUP") == false) {
        return false
    }
    if (preEventCallForLocale("ictmselcrit", b, "ONKEYUP") == false) {
        return false
    }
    if ((a = fnKeyUpProcessor(c)) == false) {
        return false
    }
    if (postEventCallForLocale("ictmselcrit", b, "ONKEYUP") == false) {
        return false
    }
    if (postEventCall("ictmselcrit", b, "ONKEYUP") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function ictmselcrit_ONLOAD3(c, d) {
    var b = "";
    var a = document.forms[0];
    if (pre_ONLOAD("ictmselcrit", c) == false) {
        return false
    }
    if (preEventCallForLocale("ictmselcrit", c, "ONLOAD") == false) {
        return false
    }
    if ((b = fnOnLoad()) == false) {
        return false
    }
    if ((b = fnAssignDateOnLoad(d)) == false) {
        return false
    }
    if (postEventCallForLocale("ictmselcrit", c, "ONLOAD") == false) {
        return false
    }
    fnPopUpExceptionWindow(a.actionCode);
    if (post_ONLOAD("ictmselcrit", c) == false) {
        return false
    }
    return (b == undefined) ? true : b
}

function ictmselcrit_ONCHANGE4(b, k, j, i, h, g, f, e, d, c) {
    var a = "";
    if (preEventCall("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(k, j, i)) == false) {
        return false
    }
    if ((a = fnCommonFetchAcctDtls(h, g, f, e, d, c)) == false) {
        return false
    }
    if (postEventCallForLocale("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function ictmselcrit_ONCHANGE5(b, k, j, i, h, g, f, e, d, c) {
    var a = "";
    if (preEventCall("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(k, j, i)) == false) {
        return false
    }
    if ((a = fnCommonFetchAcctDtls(h, g, f, e, d, c)) == false) {
        return false
    }
    if (postEventCallForLocale("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function ictmselcrit_ONBLUR6(e, f, d, b, a) {
    var c = "";
    if (preEventCall("ictmselcrit", e, "ONBLUR") == false) {
        return false
    }
    if (preEventCallForLocale("ictmselcrit", e, "ONBLUR") == false) {
        return false
    }
    if ((c = newformatAmt(f, d, b, a)) == false) {
        return false
    }
    if (postEventCallForLocale("ictmselcrit", e, "ONBLUR") == false) {
        return false
    }
    if (postEventCall("ictmselcrit", e, "ONBLUR") == false) {
        return false
    }
    return (c == undefined) ? true : c
}

function ictmselcrit_ONBLUR7(e, f, d, b, a) {
    var c = "";
    if (preEventCall("ictmselcrit", e, "ONBLUR") == false) {
        return false
    }
    if (preEventCallForLocale("ictmselcrit", e, "ONBLUR") == false) {
        return false
    }
    if ((c = newformatAmt(f, d, b, a)) == false) {
        return false
    }
    if (postEventCallForLocale("ictmselcrit", e, "ONBLUR") == false) {
        return false
    }
    if (postEventCall("ictmselcrit", e, "ONBLUR") == false) {
        return false
    }
    return (c == undefined) ? true : c
}

function ictmselcrit_ONCHANGE8(b) {
    var a = "";
    if (preEventCall("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = rejectTypeChoice()) == false) {
        return false
    }
    if (postEventCallForLocale("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function ictmselcrit_ONCHANGE9(b, c) {
    var a = "";
    if (preEventCall("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCallForLocale("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("ictmselcrit", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function ictmselcrit_ONCLICK10(b, c) {
    var a = "";
    if (preEventCall("ictmselcrit", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("ictmselcrit", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCallForLocale("ictmselcrit", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("ictmselcrit", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function ictmselcrit_ONCLICK11(b, c) {
    var a = "";
    if (preEventCall("ictmselcrit", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("ictmselcrit", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCallForLocale("ictmselcrit", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("ictmselcrit", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function writeICTMselectOptions() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="1">' + jspResArr.get("FLT011776") + "</OPTION>");
        write('<OPTION VALUE="2">' + jspResArr.get("FLT011796") + "</OPTION>");
        write('<OPTION VALUE="3">' + jspResArr.get("FLT011813") + "</OPTION>")
    }
}

function writeIctmSelRejTypes() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="1">' + jspResArr.get("FLT011778") + "</OPTION>");
        write('<OPTION VALUE="2">' + jspResArr.get("FLT011795") + "</OPTION>");
        write('<OPTION VALUE="3">' + jspResArr.get("FLT011815") + "</OPTION>");
        write('<OPTION VALUE="4">' + jspResArr.get("FLT011831") + "</OPTION>");
        write('<OPTION VALUE="5">' + jspResArr.get("FLT011844") + "</OPTION>")
    }
}

function writeLctRcdSel() {
    with(document) {
        write('<OPTION VALUE="1">' + jspResArr.get("FLT003056") + "</option>");
        write('<OPTION VALUE="2">' + jspResArr.get("FLT003057") + "</option>");
        write('<OPTION VALUE="3" selected>' + jspResArr.get("FLT002172") + "</option>")
    }
}

function writeICTMsortingOrder1() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT000304") + "</OPTION>");
        write('<OPTION VALUE="1">' + jspResArr.get("FLT006993") + "</OPTION>");
        write('<OPTION VALUE="2">' + jspResArr.get("FLT006994") + "</OPTION>");
        write('<OPTION VALUE="3">' + jspResArr.get("FLT006995") + "</OPTION>");
        write('<OPTION VALUE="4">' + jspResArr.get("FLT009404") + "</OPTION>")
    }
}

function writeICTMsortingOrder2() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT000930") + "</OPTION>");
        write('<OPTION VALUE="1">' + jspResArr.get("FLT006993") + "</OPTION>");
        write('<OPTION VALUE="2">' + jspResArr.get("FLT006994") + "</OPTION>");
        write('<OPTION VALUE="3">' + jspResArr.get("FLT006995") + "</OPTION>");
        write('<OPTION VALUE="4">' + jspResArr.get("FLT009404") + "</OPTION>")
    }
}

function writeCVerifyFlg() {
    with(document) {
        write('<OPTION VALUE="Y">' + jspResArr.get("FLT003058") + "</option>");
        write('<OPTION VALUE="N" selected>' + jspResArr.get("FLT003059") + "</option>");
        write('<OPTION VALUE="">' + jspResArr.get("FLT002172") + "</option>")
    }
}

function writeICTMsortingOrder3() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012142") + "</OPTION>");
        write('<OPTION VALUE="1">' + jspResArr.get("FLT006993") + "</OPTION>");
        write('<OPTION VALUE="2">' + jspResArr.get("FLT006994") + "</OPTION>");
        write('<OPTION VALUE="3">' + jspResArr.get("FLT006995") + "</OPTION>");
        write('<OPTION VALUE="4">' + jspResArr.get("FLT009404") + "</OPTION>")
    }
}

function writeICTMsortingOrder4() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT001265") + "</OPTION>");
        write('<OPTION VALUE="1">' + jspResArr.get("FLT006993") + "</OPTION>");
        write('<OPTION VALUE="2">' + jspResArr.get("FLT006994") + "</OPTION>");
        write('<OPTION VALUE="3">' + jspResArr.get("FLT006995") + "</OPTION>");
        write('<OPTION VALUE="4">' + jspResArr.get("FLT009404") + "</OPTION>")
    }
}

function writeCCarveFlg() {
    with(document) {
        write('<OPTION VALUE="Y">' + jspResArr.get("FLT003060") + "</option>");
        write('<OPTION VALUE="N">' + jspResArr.get("FLT003061") + "</option>");
        write('<OPTION VALUE="" selected >' + jspResArr.get("FLT002172") + "</option>")
    }
}

function writeValidationRunTypes() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="Y">' + jspResArr.get("FLT014070") + "</OPTION>");
        write('<OPTION VALUE="F">' + jspResArr.get("FLT013817") + "</OPTION>");
        write('<OPTION VALUE="N">' + jspResArr.get("FLT013895") + "</OPTION>")
    }
}

function writeCSelectAllFlg() {
    with(document) {
        write('<OPTION VALUE="X">' + jspResArr.get("FLT003062") + "</option>");
        write('<OPTION VALUE="E">' + jspResArr.get("FLT003063") + "</option>");
        write('<OPTION VALUE="Y" selected >' + jspResArr.get("FLT002172") + "</option>")
    }
}

function writeCtsValidationTypes() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="Y">' + jspResArr.get("FLT014070") + "</OPTION>");
        write('<OPTION VALUE="R">' + jspResArr.get("FLT013985") + "</OPTION>");
        write('<OPTION VALUE="N">' + jspResArr.get("FLT013892") + "</OPTION>")
    }
};