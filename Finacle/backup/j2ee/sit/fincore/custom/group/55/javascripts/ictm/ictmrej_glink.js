function printBlock() {
    writeHeader("ictmrej");
    with(document) {
        write('<input type="hidden" name="submitform" >');
        write('<input type="hidden" name="pagename" value="ictmrej">');
        write('<input type="hidden" id="funcCode" name="' + sGroupName + '.funcCode">');
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
        write('<td width="20%" class="textlabel">' + jspResArr.get("FLT000204") + "");
        write("</td>");
        write('<td width="29%" class="textfielddisplaylabel">');
        write('<input class="label" id="locFuncCode" size="15" fds="Y" disabled>');
        write("</td>");
        write('<td width="1%" class="columnwidth">&nbsp;</td>');
        write('<td width="20%" class="textlabel">' + jspResArr.get("FLT000003") + "");
        write("</td>");
        write('<td width="30%" class="textfielddisplaylabel">');
        write('<input class="label" id="solId" name="' + sGroupName + '.solId" fds="Y" size="8" maxlength="8" disabled>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT002008") + "");
        write("</td>");
        write('<td class="textfielddisplaylabel">');
        write('<input class="label" id="zoneCode" name="' + sGroupName + '.zoneCode" fds="Y" si ze="10" maxlength="10" disabled>/</td>');
        PRINTDATELABEL("zoneDate", "Y", "", "", "") / write('<td class="textfielddisplaylabel">');
        write('<input class="label" id="cZoneSrlNum" name="' + sGroupName + '.cZoneSrlNum" fds="Y" size="6" maxlength="6" disabled>');
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
        write('<td align="right"><a id="sLnk13" href="javascript:showHelpFile(\'ictmrej_help.htm\');"><img border="0" src="../Renderer/images/' + applangcode + '/help.gif" hotKeyId="finHelp"></img></a></td>');
        write("</tr>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT000265") + "");
        write("</td>");
        write('<td colspan="4" class="textfielddisplaylabel">');
        write('<input class="label" id="acctId" name="' + sGroupName + '.acctId" size="18" maxlength="16" fds="Y" disabled>');
        write('<input class="label" id="acctCrncy" name="' + sGroupName + '.acctCrncy" size="4" maxlength="3" fds="Y" disabled>');
        write('<input class="label" id="acctSolId" name="' + sGroupName + '.acctSolId" size="9" maxlength="8" fds="Y" disabled>');
        write('<input class="label" id="acctName" name="' + sGroupName + '.acctName" size="26" maxlength="26" fds="Y" disabled>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT002007") + "");
        write("</td>");
        write('<td class="textfielddisplaylabel">');
        write('<input class="label" id="payeeName" name="' + sGroupName + '.payeeName" size="32" maxlength="30" fds="Y" disabled>');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000593") + "/" + jspResArr.get("FLT000205") + "");
        write("</td>");
        write('<td class="textfielddisplaylabel">');
        write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
        write("<tr>");
        write("<td>");
        write('<input class="label" id="instrNum" name="' + sGroupName + '.instrNum" size="18" maxlength="16" fds="Y" disabled>/');
        PRINTDATELABEL("instDate", "Y", "", "", "");
        write("</td> </tr>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT002012") + "");
        write("</td>");
        write('<td class="textfielddisplaylabel">');
        write('<input class="label" id="rejType" name="' + sGroupName + '.rejType" size="2" maxlength="2" fds="Y" disabled>');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT024307") + "</td>");
        write('<td class="textfield">');
        write('<input type="radio" name="' + sGroupName + '.drawnOnUsFlg" id="drawnOnUsFlg" value="Y" ' + ictmProps.get("drawnOnUsFlg_ENABLED") + " >" + jspResArr.get("FLT001389") + "");
        write('<input type="radio" name="' + sGroupName + '.drawnOnUsFlg" id="drawnOnUsFlg" value="N" check');
        write("ed " + ictmProps.get("drawnOnUsFlg_ENABLED") + " >" + jspResArr.get("FLT001941") + "");
        write("</td>");
        write("</tr>");
        write("<tr>");
        if (rejType == "E") {
            write('<td class="textlabel">' + jspResArr.get("FLT020014") + "");
            write('<script>setMandatory("Y")<\/script>');
            write("</td>")
        } else {
            write('<td class="textlabel">' + jspResArr.get("FLT020014") + "");
            write('<script>setMandatory("' + ictmProps.get("extnCode_MANDATORY") + '")<\/script>');
            write("</td>")
        }
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'ictmrej\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmrej\',this);" type="text" class="textfieldfont" id="extnCode"name="' + sGroupName + '.extnCode" size="4');
        write('" maxlength="2" ' + ictmProps.get("extnCode_ENABLED") + ' hotKeyId="search11">');
        write('&nbsp;<a target="_self" id="sLnk11"href="JavaScript:showExtnReasonList()">');
        write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search11"></a>');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        if (rejType == "E") {
            write('<td class="textlabel">' + jspResArr.get("FLT020015") + "");
            write('<script>setMandatory("Y")<\/script>');
            write("</td>");
            write('<td class="textfield">');
            write('<input onChange="javascript:return custom_ONCHANGE(\'ictmrej\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmrej\',this);" type="text" class="textfieldfont" fdt="fpint" id="extnNoOfDays" name="' + sGroupName + '.extnNoOfDays" size="4" maxlength="3" fmnd="Y" ' + ictmProps.get("extnNoOfDays_ENABLED") + ">");
            write("</td>")
        } else {
            write('<td class="textlabel">' + jspResArr.get("FLT020015") + "");
            write("</td>");
            write('<td class="textfield">');
            write('<input onChange="javascript:return custom_ONCHANGE(\'ictmrej\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmrej\',this);" type="text" class="textfieldfont" fdt="fpint" id="extnNoOfDays" name="' + sGroupName + '.extnNoOfDays" size="4" maxlength="3" ' + ictmProps.get("extnNoOfDays_ENABLED") + ">");
            write("</td>")
        }
        write("</tr>");
        write("<tr>");
        if (rejType == "E") {
            write('<td class="textlabel">' + jspResArr.get("FLT002031") + "");
            write('<script>setMandatory("' + ictmProps.get("rejCode1_MANDATORY") + '")<\/script>');
            write("</td>")
        } else {
            write('<td class="textlabel">' + jspResArr.get("FLT002031") + "");
            write('<script>setMandatory("Y")<\/script>');
            write("</td>")
        }
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'ictmrej\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmrej\',this);" type="text" class="textfieldfont" id="rejCode1" name="' + sGroupName + '.rejCode1" size="4" maxlength="2" ' + ictmProps.get("rejCode1_ENABLED") + ' hotKeyId="search1">');
        //write('&nbsp;<a target="_self" id="sLnk1" href="JavaScript:showRejReasonList(document.forms[0].rejCode1,document.forms[0].rejCodeName1,\'F\',\'N\')">');
		write('&nbsp;<a target="_self" id="sLnk1" href="JavaScript:showCustomRejReasonList(document.forms[0].rejCode1,document.forms[0].rejCodeName1,\'F\',\'N\')">');
        write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search1"></a>');
        write("<br>");
        write('<input class="label" id="rejCodeName1" name="' + sGroupName + '.rejCodeName1" size="30" maxlength="30" fds="Y" disabled>');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT002032") + "");
        write('<script>setMandatory("' + ictmProps.get("rejCode2_MANDATORY") + '")<\/script>');
        write("</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'ictmrej\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmrej\',this);" type="text" class="textfieldfont" id="rejCode2" name="' + sGroupName + '.rejCode2" size="4" maxlength="2" ' + ictmProps.get("rejCode2_ENABLED") + ' hotKeyId="search2">');
        //write('&nbsp;<a target="_self" id="sLnk2" href="JavaScript:showRejReasonList(document.forms[0].rejCode2,document.forms[0].rejCodeName2,\'F\',\'N\')">');
        write('&nbsp;<a target="_self" id="sLnk2" href="JavaScript:showCustomRejReasonList(document.forms[0].rejCode2,document.forms[0].rejCodeName2,\'F\',\'N\')">');
		write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search2"></a>');
        write("<br>");
        write('<input class="label" id="rejCodeName2" name="' + sGroupName + '.rejCodeName2" size="30" maxlength="30" fds="Y" disabled>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT002033") + "");
        write('<script>setMandatory("' + ictmProps.get("rejCode3_MANDATORY") + '")<\/script>');
        write("</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'ictmrej\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmrej\',this);" type="text" class="textfieldfont" id="rejCode3" name="' + sGroupName + '.rejCode3" size="4" maxlength="2" ' + ictmProps.get("rejCode3_ENABLED") + ' hotKeyId="search3">');
        //write('&nbsp;<a target="_self" id="sLnk3" href="JavaScript:showRejReasonList(document.forms[0].rejCode3,document.forms[0].rejCodeName3,\'F\',\'N\')">');
        write('&nbsp;<a target="_self" id="sLnk3" href="JavaScript:showCustomRejReasonList(document.forms[0].rejCode3,document.forms[0].rejCodeName3,\'F\',\'N\')">'); 
		write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search3"></a>');
        write("<br>");
        write('<input class="label" id="rejCodeName3" name="' + sGroupName + '.rejCodeName3" size="30" maxlength="30" fds="Y" disabled>');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT002034") + "");
        write('<script>setMandatory("' + ictmProps.get("rejCode4_MANDATORY") + '")<\/script>');
        write("</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'ictmrej\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmrej\',this);" type="text" class="textfieldfont" id="rejCode4" name="' + sGroupName + '.rejCode4" size="4" maxlength="2" ' + ictmProps.get("rejCode4_ENABLED") + ' hotKeyId="search4">');
        //write('&nbsp;<a target="_self" id="sLnk4" href="JavaScript:showRejReasonList(document.forms[0].rejCode4,document.forms[0].rejCodeName4,\'F\',\'N\')">');
        write('&nbsp;<a target="_self" id="sLnk4" href="JavaScript:showCustomRejReasonList(document.forms[0].rejCode4,document.forms[0].rejCodeName4,\'F\',\'N\');">');
		write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search4"></a>');
        write("<br>");
        write('<input class="label" id="rejCodeName4" name="' + sGroupName + '.rejCodeName4" size="30" maxlength="30" fds="Y" disabled>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT002035") + "");
        write('<script>setMandatory("' + ictmProps.get("rejCode5_MANDATORY") + '")<\/script>');
        write("</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'ictmrej\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmrej\',this);" type="text" class="textfieldfont" id="rejCode5" name="' + sGroupName + '.rejCode5" size="4" maxlength="2" ' + ictmProps.get("rejCode5_ENABLED") + ' hotKeyId="search5">');
        //write('&nbsp;<a target="_self" id="sLnk5" href="JavaScript:showRejReasonList(document.forms[0].rejCode5,document.forms[0].rejCodeName5,\'F\',\'N\')">');
        write('&nbsp;<a target="_self" id="sLnk5" href="JavaScript:showCustomRejReasonList(document.forms[0].rejCode5,document.forms[0].rejCodeName5,\'F\',\'N\')">');
		write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search5"></a>');
        write("<br>");
        write('<input class="label" id="rejCodeName5" name="' + sGroupName + '.rejCodeName5" size="30" maxlength="30" fds="Y" disabled>');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">&nbsp;</td>');
        write('<td class="textfield">&nbsp;</td>');
        write("</tr>");
        write('<tr class="innertabletop1">');
        write('<td colspan="5" class="rowspacing">&nbsp;</td>');
        write("</tr>");
        write('<tr class="subhdrbg">');
        write('<td colspan="5" class="subhdr">' + jspResArr.get("FLT002263") + "</td>");
        write("</tr>");
        write('<tr class="innertabletop1">');
        write('<td colspan="5" class="rowspacing">&nbsp;</td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT000003") + "");
        write('<script>setMandatory("' + ictmProps.get("outRejSolId_MANDATORY") + '")<\/script>');
        write("</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'ictmrej\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmrej\',this);" type="text" class="textfieldfont" id="outRejSolId" name="' + sGroupName + '.outRejSolId" size="8" maxlength="8" ' + ictmProps.get("outRejSolId_ENABLED") + ' hotKeyId="search6">');
        write('&nbsp;<a target="_self" id="sLnk6" href="JavaScript:showSolId(document.forms[0].outRejSolId,\'ctrl\',\'F\')">');
        write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search6"></a>');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel" width="15%">' + jspResArr.get("FLT000603") + "");
        write('<script>setMandatory("' + ictmProps.get("outRejZoneCode_MANDATORY") + '")<\/script>');
        write("</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'ictmrej\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmrej\',this);" type="text" class="textfieldfont" id="outRejZoneCode" name="' + sGroupName + '.outRejZoneCode" size="12" maxlength="10" ' + ictmProps.get("outRejZoneCode_ENABLED") + ' hotKeyId="search7">');
        write('&nbsp;<a target="_self" id="sLnk7" href="JavaScript:showZoneCode(document.forms[0].outRejZoneDate,document.forms[0].outRejZoneCode,document.forms[0].outRejSolId.value)">');
        write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search7"></a>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        PRINTDATEFLD("outRejZoneDate", "Y", "8", jspResArr.get("FLT000637"), "N", "N", "N", "", "", "");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000594") + "");
        write('<script>setMandatory("' + ictmProps.get("outRejSetNum_MANDATORY") + '")<\/script>');
        write("</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'ictmrej\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmrej\',this);" type="text" class="textfieldfont" id="outRejSetNum" name="' + sGroupName + '.outRejSetNum" size="7" maxlength="6" ' + ictmProps.get("outRejSetNum_ENABLED") + ' hotKeyId="search8">');
        write('&nbsp;<a target="_self" id="sLnk9" href="JavaScript:showOutClgInstList(document.forms[0].outRejSetNum,' + instId + ",'setnum','F')\">");
        write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search8"></a>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT002060") + "");
        write('<script>setMandatory("' + ictmProps.get("outRejInstSrlNum_MANDATORY") + '")<\/script>');
        write("</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'ictmrej\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmrej\',this);" type="text" class="textfieldfont" id="outRejInstSrlNum" name="' + sGroupName + '.outRejInstSrlNum" size="6" maxlength="4" ' + ictmProps.get("outRejInstSrlNum_ENABLED") + ' hotKeyId="search9">');
        write('&nbsp;<a target="_self" id="sLnk10" href="JavaScript:showOutClgInstList(document.forms[0].outRejInstSrlNum,' + instId + ",'srlnum','F')\">");
        write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search9"></a>');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">&nbsp;</td>');
        write('<td class="textfield">&nbsp;</td>');
        write("</tr>");
        write("<tr>");
        write('<td colspan="5" class="searchresultshr1">&nbsp;');
        write('<img src="../Renderer/images/' + applangcode + '/bullet.jpg" width="11" height="11">&nbsp;' + jspResArr.get("FLT002036") + " :" + jsUtil.encodeChar(rejUserId) + "");
        write("&nbsp;&nbsp;&nbsp;&nbsp;");
        write('<img src="../Renderer/images/' + applangcode + '/bullet.jpg" width="11" height="11">&nbsp;' + jspResArr.get("FLT002037") + " :" + jsUtil.encodeChar(fnConvertToUIDate(rejDate)) + "");
        write("</td>");
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
            if (funcCode == "I") {
                write('<input type="button" class="Button" id="Back" value="' + jspResArr.get("FLT001166") + '" onClick="javascript:return ictmrej_ONCLICK4(this,this);" hotKeyId="Go" >');
                write('<input type="button" class="button" id="Charges" name="Charges" value="' + jspResArr.get("FLT001003") + '" onClick="javascript:return ictmrej_ONCLICK5(this,this);">')
            } else {
                write('<input type="button" class="button" id="Accept" name="Accept" value="' + jspResArr.get("FLT000191") + '" onClick="javascript:return ictmrej_ONCLICK6(this,this);" hotKeyId="Go" >');
                write('<input type="button" class="button" id="Charges" name="Charges" value="' + jspResArr.get("FLT001003") + '" onClick="javascript:return ictmrej_ONCLICK7(this,this);">');
                write('<input type="button" class="button" id="Back" name="Back" value="' + jspResArr.get("FLT003327") + '" onClick="javascript:return ictmrej_ONCLICK8(this,this);" hotKeyId="Cancel" >')
            }
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
    a.acctId.value = acctId;
    a.acctCrncy.value = acctCrncy;
    a.acctSolId.value = acctSolId;
    a.acctName.value = acctName;
    a.payeeName.value = payeeName;
    a.instrNum.value = instrNum;
    a.instDate.value = instDate;
    a.rejType.value = rejType;
    a.drawnOnUsFlg.value = drawnOnUsFlg;
    a.extnCode.value = extnCode;
    a.extnNoOfDays.value = extnNoOfDays;
    a.rejCode1.value = rejCode1;
    a.rejCode2.value = rejCode2;
    a.rejCode3.value = rejCode3;
    a.rejCode4.value = rejCode4;
    a.rejCode5.value = rejCode5;
    a.rejCodeName1.value = rejCodeName1;
    a.rejCodeName2.value = rejCodeName2;
    a.rejCodeName3.value = rejCodeName3;
    a.rejCodeName4.value = rejCodeName4;
    a.rejCodeName5.value = rejCodeName5;
    a.outRejSolId.value = outRejSolId;
    a.outRejZoneCode.value = outRejZoneCode;
    a.outRejZoneDate.value = outRejZoneDate;
    a.outRejSetNum.value = outRejSetNum;
    a.outRejInstSrlNum.value = outRejInstSrlNum;
    a.locFuncCode.value = locFuncCode;
    if ((sReferralMode == "I") || (sReferralMode == "S")) {
        fnDisableFormDataControls("V", a, 0)
    }
}

function ictmrej_ONKEYDOWN1(b, c) {
    var a = "";
    if (preEventCall("ictmrej", b, "ONKEYDOWN") == false) {
        return false
    }
    if ((a = fnKeyDownProcessor(c)) == false) {
        return false
    }
    if (postEventCall("ictmrej", b, "ONKEYDOWN") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function ictmrej_ONKEYUP2(b, c) {
    var a = "";
    if (preEventCall("ictmrej", b, "ONKEYUP") == false) {
        return false
    }
    if ((a = fnKeyUpProcessor(c)) == false) {
        return false
    }
    if (postEventCall("ictmrej", b, "ONKEYUP") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function ictmrej_ONLOAD3(c, d) {
    var b = "";
    var a = document.forms[0];
    if (pre_ONLOAD("ictmrej", c) == false) {
        return false
    }
    if ((b = fnOnLoad()) == false) {
        return false
    }
    if ((b = fnAssignDateOnLoad(d)) == false) {
        return false
    }
    fnPopUpExceptionWindow(a.actionCode);
    if (post_ONLOAD("ictmrej", c) == false) {
        return false
    }
    return (b == undefined) ? true : b
}

function ictmrej_ONCLICK4(b, c) {
    var a = "";
    if (preEventCall("ictmrej", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCall("ictmrej", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function ictmrej_ONCLICK5(b, c) {
    var a = "";
    if (preEventCall("ictmrej", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCall("ictmrej", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function ictmrej_ONCLICK6(b, c) {
    var a = "";
    if (preEventCall("ictmrej", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCall("ictmrej", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function ictmrej_ONCLICK7(b, c) {
    var a = "";
    if (preEventCall("ictmrej", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCall("ictmrej", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function ictmrej_ONCLICK8(b, c) {
    var a = "";
    if (preEventCall("ictmrej", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCall("ictmrej", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
};