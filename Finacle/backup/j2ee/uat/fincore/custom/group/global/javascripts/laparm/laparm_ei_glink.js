function printBlock1() {
    writeHeader("laparm_ei");
    with(document) {
        write('<input type="hidden" name="submitform" id="submitform" value="">');
        write('<input type="hidden" name="CollectUpFlg" value="">');
        write('<input type="hidden" name="ConfirmChoice" value="">');
        write('<input type="hidden" name="NumInstl" value="">');
        write('<input type="hidden" name="pagename" value="' + jsUtil.encodeChar(groupName) + '">');
        write('<input type="hidden" id="gpStepInd" name="' + groupName + '.gpStepInd" value="">');
        write('<input type="hidden" id="eiSchmFlgVal" name="' + groupName + '.eiSchmFlgVal" value="">');
        write('<input type="hidden" id="eiTypeVal" name="' + groupName + '.eiTypeVal" value="">');
        write('<input type="hidden" name="FocusField" id="FocusField">');
        write('<input type="hidden" id="direction" name="' + groupName + '.direction" value="">');
        write('<input type="hidden" id="multirecname" name="' + groupName + '.multirecname" value="capitalizeChrg">');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
        write("<tr>");
        write("<td>");
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
        write("<tr>");
        write("<td>");
        write('<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop1">');
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
        write('<a target=_self href="javascript:showHelpFile(\'laparm_ei_help.htm\');" id="sLnk10">');
        write('<img src="../Renderer/images/' + applangcode + '/help.gif" border="0" hotKeyId="finHelp">');
        write("</img>");
        write("</a>");
        write("</td>");
        write("</tr>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write('<tr class="innertabletop1">');
        write('<td colspan="5" class="rowspacing1"><spacer type="block" height=1 width=1></spacer>');
        write("</td>");
        write("</tr>");
        write('<tr class="subhdrbg">');
        write('<td colspan="5" class="subhdr">' + jspResArr.get("FLT001915") + "</td>");
        write("</tr>");
        write('<tr class="innertabletop1">');
        write('<td colspan="5" class="rowspacing"><spacer type="block" height=1 width=1></spacer>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT001833") + "</td>");
        write('<td class="label">');
        newformatAmt(format, fnRemoveCrncy(loanAmt), critCrncy, "Y");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT001834") + "</td>");
        write('<td class="label">' + jsUtil.encodeChar(fnConvertToUIDate(shCrDate)) + "</td>");
        write("</tr>");
        write('<tr class="innertabletop1">');
        write('<td colspan="5" class="rowspacing1"><spacer type="block" height=1 width=1></spacer>');
        write("</td>");
        write("</tr>");
        write('<tr class="subhdrbg">');
        write('<td colspan="5" class="subhdr">' + jspResArr.get("FLT000011") + "</td>");
        write("</tr>");
        write('<tr class="innertabletop1">');
        write('<td colspan="5" class="rowspacing"><spacer type="block" height=1 width=1></spacer>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT003892") + "");
        write('<script>setMandatory("' + laparmProps.get("eiSchmFlg_MANDATORY") + '");<\/script>');
        write("</td>");
        write('<td class="textfield">');
        write('<input type="radio" name="' + groupName + '.eiSchmFlg" id="eiSchmFlg" value="Y" onClick="javascript:return laparm_ei_ONCLICK4(this);">' + jspResArr.get("FLT001389") + "");
        write('<input type="radio" name="' + groupName + '.eiSchmFlg" id="eiSchmFlg" value="N" onClick="javascript:return laparm_ei_ONCLICK5(this);">' + jspResArr.get("FLT001941") + "");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT001835") + "");
        write('<script>setMandatory("' + laparmProps.get("eiType_MANDATORY") + '");<\/script>');
        write("</td>");
        write('<td class="textfield">');
        write('<input type="radio" id="eiType" name="' + groupName + '.eiType" value="A">&nbsp;' + jspResArr.get("FLT002741") + "");
        write('&nbsp;<input type="radio" id="eiType" name="' + groupName + '.eiType" value="R">&nbsp;' + jspResArr.get("FLT002740") + "");
        write('&nbsp;<input type="radio" id="eiType" name="' + groupName + '.eiType" value="I">&nbsp;' + jspResArr.get("FLT036491") + "");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT002735") + "");
        write('<script>setMandatory("' + laparmProps.get("eiFormulaFlg_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield" ><select class="listboxfont" id="eiFormulaFlg" name="' + groupName + '.eiFormulaFlg" fmnd="' + laparmProps.get("eiFormulaFlg_MANDATORY") + '" ' + laparmProps.get("eiFormulaFlg_ENABLED") + ' onchange="javascript:return laparm_ei_ONCHANGE6(this);">');
        writeComboFunction("writeEIFormula");
        write("</select>");
        write("</td>");
        write('<td	class="columnwidth">&nbsp;</td>');
        write('<td height="10" class="textlabel">' + jspResArr.get("FLT001836") + '<script>setMandatory("Y");<\/script></td>');
        write('<td height="10" class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" onBlur="javascript:return custom_ONBLUR(\'laparm_ei\',this);" type="text" class="textfieldfont" name="' + groupName + '.noOfInstlmnts" id="noOfInstlmnts" size="5" maxlength="3" fmnd="Y" fdt="fpint" ' + laparmProps.get("noOfInstlmnts_ENABLED ") + ">");
        write("</td>");
        write("</tr>");
        write("<tr>");
        PRINTDATEFLD("instlmntStartDate", "Y", "2", jspResArr.get("FLT001837"), "Y", "N", "N", "", "", "");
        write('<td class="columnwidth"><spacer type="block" width="1" height="1"></td>');
        PRINTDATEFLD("intStartDate", "Y", "2", jspResArr.get("FLT001838"), "Y", "N", "N", "", "", "");
        write("</tr>");
        write("<tr>");
        write('<td height="10" class="textlabel">' + jspResArr.get("FLT001839") + '<script>setMandatory("Y");<\/script></td>');
        write('<td height="10" class="textfield">');
        write('<select class="textfieldfrequency" id="eiFreqType" name="' + groupName + '.eiFreqType" fmnd="Y" ' + laparmProps.get("eiFreqType_ENABLED ") + ' onChange="javascript:return laparm_ei_ONCHANGE7(this);">');
        write('<script>writeComboFunction("writeFreType");<\/script>');
        write("</select>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="textfieldfrequency" id="eiFreqWeek" name="' + groupName + '.eiFreqWeek" ' + laparmProps.get("eiFreqWeek_ENABLED ") + ">");
        write('<script>writeComboFunction("writeWeekNumber");<\/script>');
        write("</select>");
        write("<br>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="textfieldbyday" id="eiFreqWkDay" name="' + groupName + '.eiFreqWkDay" ' + laparmProps.get("eiFreqWkDay_ENABLED ") + ">");
        write('<script>writeComboFunction("writeFreDays");<\/script>');
        write("</select>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="textfieldfreqstaticdate" id="eiFreqStartDate" name="' + groupName + '.eiFreqStartDate" ' + laparmProps.get("eiFreqStartDate_ENABLED ") + ">");
        write('<script>writeComboFunction("writeFreDates");<\/script>');
        write("</select>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="textfieldfrequency" id="eiHldyStatus" name="' + groupName + '.eiHldyStatus" fmnd="Y" ' + laparmProps.get("eiHldyStatus_ENABLED ") + ">");
        write('<script>writeComboFunction("writeFreHoliDayStatus");<\/script>');
        write("</select><br>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="listboxfont" id="eiFreqCalBase" name="' + groupName + '.eiFreqCalBase" fmnd="Y" ' + laparmProps.get("eiFreqType_ENABLED ") + ">");
        write('<script type="text/javascript">');
        write('writeComboFunction("writeFrequencyCalendarBase");');
        write("<\/script>");
        write("</select>");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td height="10" class="textlabel">' + jspResArr.get("FLT001840") + '<script>setMandatory("Y");<\/script></td>');
        write('<td height="10" class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="textfieldfrequency" id="intFreqType" name="' + groupName + '.intFreqType" fmnd="Y" ' + laparmProps.get("intFreqType_ENABLED ") + ">");
        write('<script>writeComboFunction("writeLaIntCalcFreqType");<\/script>');
        write("</select>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="textfieldfrequency" id="intFreqWeek" name="' + groupName + '.intFreqWeek" ' + laparmProps.get("intFreqWeek_ENABLED ") + ">");
        write('<script>writeComboFunction("writeWeekNumber");<\/script>');
        write("</select>");
        write("<br>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="textfieldbyday" id="intFreqWkDay" name="' + groupName + '.intFreqWkDay" ' + laparmProps.get("intFreqWkDay_ENABLED ") + ">");
        write('<script>writeComboFunction("writeFreDays");<\/script>');
        write("</select>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="textfieldfreqstaticdate" id="intFreqStartDate" name="' + groupName + '.intFreqStartDate" ' + laparmProps.get("intFreqStartDate_ENABLED ") + ">");
        write('<script>writeComboFunction("writeFreDates");<\/script>');
        write("</select>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="textfieldfrequency" id="intHldyStatus" name="' + groupName + '.intHldyStatus" fmnd="Y" ' + laparmProps.get("intHldyStatus_ENABLED ") + ">");
        write('<script>writeComboFunction("writeFreHoliDayStatus");<\/script>');
        write("</select><br>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="listboxfont" id="intFreqCalBase" name="' + groupName + '.intFreqCalBase" fmnd="Y" ' + laparmProps.get("intFreqCalBase_ENABLED ") + ">");
        write('<script type="text/javascript">');
        write('writeComboFunction("writeFrequencyCalendarBase");');
        write("<\/script>");
        write("</select>");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT006596") + "</td>");
        write('<td class="textfield">');
        write('<input type="radio" name="' + groupName + '.singEmiDiffFlg" id="singEmiDiffFlg" value="Y" ' + laparmProps.get("singEmiDiffFlg_ENABLED") + " >" + jspResArr.get("FLT001389") + "");
        write('<input type="radio" name="' + groupName + '.singEmiDiffFlg" id="singEmiDiffFlg" value="N" checked ' + laparmProps.get("singEmiDiffFlg_ENABLED") + " >" + jspResArr.get("FLT001941") + "");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT011543") + '<script>setMandatory("' + laparmProps.get("repayCode_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'laparm_ei\',this);" type="text" class="textfieldfont" id="repayCode" name="' + sGroupName + '.repayCode" size="9" maxlength="5" ' + laparmProps.get("repayCode_ENABLED") + ' onchange="javascript:return laparm_ei_ONCHANGE8(this,\'repayCodeDesc\');" hotKeyId="search1">');
        write("&nbsp;<a target=_self id=\"sLnk6\" href=\"javascript:showRefCode(document.forms[0].repayCode,'IW','N','F',document.forms[0].repayCodeDesc)\">");
        write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search1"></img></a>');
        write("<br>");
        write('<input class="label" name="' + sGroupName + '.repayCodeDesc" id="repayCodeDesc" fds="Y" size="20" maxlength="50" disabled>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td height="10" colspan="5" class="rowspacing"><spacer type="block" height="1" width="1"></td>');
        write("</tr>");
        write('<tr class="innertabletop1">');
        write('<td colspan="5" class="rowspacing1"><spacer type="block" height=1 width=1></spacer>');
        write("</td>");
        write('<tr class="subhdrbg">');
        write('<td colspan="5" class="subhdr">' + jspResArr.get("FLT002861") + "</td>");
        write("</tr>");
        write('<tr class="innertabletop1">');
        write('<td colspan="5" class="rowspacing1"><spacer type="block" height=1 width=1></spacer></td>');
        write("</tr>");
        write("<tr>");
        if (localeCode != "DK") {
            write('<td class="textlabel">' + jspResArr.get("FLT014517") + '<script>setMandatory("' + laparmProps.get("hldyPerdMths_MANDATORY") + '")<\/script></td>');
            write('<td class="textfield">');
            write('<input onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" onBlur="javascript:return custom_ONBLUR(\'laparm_ei\',this);" type="text" class="textfieldfont" id="hldyPerdMths" name="' + groupName + '.hldyPerdMths" fdt="fpzint" fmnd="' + laparmProps.get("hldyPerdMths_MANDATORY") + '" size="4" maxlength="3" ' + laparmProps.get("hldyPerdMths_ENABLED") + ">");
            write("</td>")
        }
    }
}

function printBlock2() {
    with(document) {
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td height="10" class="textlabel">' + jspResArr.get("FLT002862") + "</td>");
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="listboxfont" id="autoReshdlFlg" name="' + groupName + '.autoReshdlFlg" fmnd="' + laparmProps.get("autoReshdlFlg_MANDATORY") + '" ' + laparmProps.get("autoReshdlFlg_ENABLED") + ">");
        write('<script>writeComboFunction("fnWriteautoReshdlFlgTypes");<\/script>');
        write("</select>");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT010569") + '<script>setMandatory("' + laparmProps.get("hldyPerdFrmFirstDisbFlg_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<input type="radio" id="hldyPerdFrmFirstDisbFlg" name="' + groupName + '.hldyPerdFrmFirstDisbFlg" ' + laparmProps.get("hldyPerdFrmFirstDisbFlg_ENABLED") + ' value="Y">' + jspResArr.get("FLT001389") + " &nbsp;");
        write('<input type="radio" id="hldyPerdFrmFirstDisbFlg" name="' + groupName + '.hldyPerdFrmFirstDisbFlg" ' + laparmProps.get("hldyPerdFrmFirstDisbFlg_ENABLED") + ' checked value="N">' + jspResArr.get("FLT001941") + "");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel" height="5">' + jspResArr.get("FLT001836") + "</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" onBlur="javascript:return custom_ONBLUR(\'laparm_ei\',this);" type="text" class="textfieldfont" name="' + groupName + '.hldyPerdIntInstlMths" id="hldyPerdIntInstlMths" size="5" maxlength="3" fdt="fpint" ' + laparmProps.get("hldyPerdIntInstlMths_ENABLED ") + ">");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT003902") + '<script>setMandatory("' + laparmProps.get("hldyPerdIntFlg_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield"><select class="listboxfont" id="hldyPerdIntFlg" name="' + groupName + '.hldyPerdIntFlg" fmnd="' + laparmProps.get("hldyPerdIntFlg_MANDATORY") + '" ' + laparmProps.get("hldyPerdIntFlg_ENABLED") + ' onChange="javascript:return laparm_ei_ONCHANGE9(this);" >');
        writeComboFunction("writeHolidayPerdStatus");
        write("</select>");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT003903") + ' <script>setMandatory("' + laparmProps.get("holFreqType_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="textfieldfrequency" id="holFreqType" name="' + groupName + '.holFreqType" fmnd="' + laparmProps.get("holFreqType_MANDATORY") + '" ' + laparmProps.get("holFreqType_ENABLED") + ">");
        writeComboFunction("writeFrequencyType");
        write("</select>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="textfieldfrequency" id="holFreqWeek" name="' + groupName + '.holdFreqWeek" fmnd="' + laparmProps.get("holFreqWeek_MANDATORY") + '" ' + laparmProps.get("holFreqWeek_ENABLED") + ">");
        writeComboFunction("writeWeekNumber");
        write("</select>");
        write("<br>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="textfieldbyday" id="holFreqWkDay" name="' + groupName + '.holFreqWkDay" fmnd="' + laparmProps.get("holFreqWkDay_MANDATORY") + '" ' + laparmProps.get("holFreqWkDay_ENABLED") + ">");
        writeComboFunction("writeFreDays");
        write("</select>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="textfieldfreqstaticdate" id="holFreqStartDate" name="' + groupName + '.holFreqStartDate" fmnd="' + laparmProps.get("holFreqStartDate_MANDATORY") + '" ' + laparmProps.get("holFreqStartDate_ENABLED") + ">");
        writeComboFunction("writeFreDates");
        write("</select>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="textfieldfrequency" id="holHldyStatus" name="' + groupName + '.holHldyStatus" fmnd="' + laparmProps.get("holHldyStatus_MANDATORY") + '" ' + laparmProps.get("holHldyStatus_ENABLED") + ">");
        writeComboFunction("writeFreHoliDayStatus");
        write("</select><br>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="listboxfont" id="holFreqCalBase" name="' + groupName + '.holFreqCalBase" fmnd="' + laparmProps.get("holFreqCalBase_MANDATORY") + '" ' + laparmProps.get("holFreqCalBase_ENABLED") + ">");
        writeFrequencyCalendarBase();
        write("</select>");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT003907") + "</td>");
        write('<td class="textfield">');
        write('<input type="radio" name="' + groupName + '.brknPerdIntFlg" id="brknPerdIntFlg" value="Y" ' + laparmProps.get("brknPerdIntFlg_ENABLED") + " >" + jspResArr.get("FLT001389") + "");
        write('<input type="radio" name="' + groupName + '.brknPerdIntFlg" id="brknPerdIntFlg" value="N" checked ' + laparmProps.get("brknPerdIntFlg_ENABLED") + " >" + jspResArr.get("FLT001941") + "");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td height="10" colspan="5" class="rowspacing"><spacer type="block" height="1" width="1"></td>');
        write("</tr>");
        write('<tr class="subhdrbg">');
        write('<td class="subhdr" colspan="5">' + jspResArr.get("FLT001841") + "</td>");
        write("</tr>");
        write("<tr>");
        write('<td colspan="5" class="rowspacing">&nbsp;</td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT001842") + '<script>setMandatory("' + laparmProps.get("intRestFreq_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="listboxfont" id="intRestFreq" name="' + groupName + '.intRestFreq" ' + laparmProps.get("intRestFreq_ENABLED ") + ">");
        write('<script>writeComboFunction("writeRestFreqType");<\/script>');
        write("</select>");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write("</td>");
        write('<td class="textlabel">' + jspResArr.get("FLT001843") + '<script>setMandatory("' + laparmProps.get("intRestBasis_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="listboxfont" id="intRestBasis" name="' + groupName + '.intRestBasis" ' + laparmProps.get("intRestBasis_ENABLED ") + ">");
        write('<script>writeComboFunction("writeRestBasis");<\/script>');
        write("</select>");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td colspan="5" class="rowspacing"><spacer type="block" width="1" height="1"></spacer></td>');
        write("</tr>");
        write('<tr class="subhdrbg">');
        write('<td class="subhdr" colspan="5">' + jspResArr.get("FLT001844") + "</td>");
        write("</tr>");
        write("<tr>");
        write('<td colspan="5" class="rowspacing"><spacer type="block" width="1" height="1"></spacer></td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT003889") + "</td>");
        write('<td class="textfield">');
        write('<input type="radio" name="' + groupName + '.collectUpFrontFlg" id="collectUpFrontFlg" value="Y" ' + laparmProps.get("collectUpFrontFlg_ENABLED") + ' onClick="javascript:return laparm_ei_ONCLICK10(this);" >' + jspResArr.get("FLT001389") + "");
        write('<input type="radio" name="' + groupName + '.collectUpFrontFlg" id="collectUpFrontFlg" value="N" checked ' + laparmProps.get("collectUpFrontFlg_ENABLED") + ' onClick="javascript:return laparm_ei_ONCLICK11(this);" >' + jspResArr.get("FLT001941") + "");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT001836") + '<script>setMandatory("' + laparmProps.get("numOfAdvInst_MANDATORY ") + '");<\/script>');
        write("</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" onBlur="javascript:return custom_ONBLUR(\'laparm_ei\',this);" type="text" class="textfieldfont" name="' + groupName + '.numOfAdvInst" id="numOfAdvInst" size="5" maxlength="3" fdt="fpint" ' + laparmProps.get("numOfAdvInst_ENABLED ") + ">");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td colspan="5" class="rowspacing">&nbsp;</td>');
        write("</tr>");
        write('<tr class="subhdrbg">');
        write('<td class="subhdr" colspan="5">' + jspResArr.get("FLT024308") + "</td>");
        write("</tr>");
        write("<tr>");
        write('<td colspan="5" class="rowspacing">&nbsp;</td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT024308") + "</td>");
        write('<td class="textfield">');
        write('<input type="radio" name="' + groupName + '.gpAllowed" id="gpAllowed" value="Y" ' + laparmProps.get("gpAllowed_ENABLED") + ' onClick="javascript:return laparm_ei_ONCLICK13(this);" onChange="javascript:return laparm_ei_ONCHANGE12(this);" >' + jspResArr.get("FLT001389") + "");
        write('<input type="radio" name="' + groupName + '.gpAllowed" id="gpAllowed" value="N" checked ' + laparmProps.get("gpAllowed_ENABLED") + ' onClick="javascript:return laparm_ei_ONCLICK15(this);" onChange="javascript:return laparm_ei_ONCHANGE14(this);" >' + jspResArr.get("FLT001941") + "");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT001892") + '<script>setMandatory("' + laparmProps.get("gpAllowed_MANDATORY ") + '");<\/script>');
        write("</td>");
        write('<td valign="top" class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" onBlur="javascript:return custom_ONBLUR(\'laparm_ei\',this);" type="text" class="textfieldfont" name="' + groupName + '.gpNoOfSteps" id="gpNoOfSteps" fdt="fpint" size="5" maxlength="3" ' + laparmProps.get("gpNoOfSteps_ENABLED ") + ">");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT001893") + "</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" onBlur="javascript:return custom_ONBLUR(\'laparm_ei\',this);" type="text" class="textfieldfont" name="' + groupName + '.gpStepPcnt" id="gpStepPcnt" fdt="fpcnt" size="12" maxlength="10" ' + laparmProps.get("gpStepPcnt_ENABLED ") + ">");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT001894") + "</td>");
        write('<td class="textfield">');
        write('<input type="radio" name="' + groupName + '.radiogpStepInd" id="radiogpStepInd" value="U" >' + jspResArr.get("FLT001895") + "&nbsp;&nbsp;");
        write("<br>");
        write('<input type="radio" name="' + groupName + '.radiogpStepInd" id="radiogpStepInd" value="D" >' + jspResArr.get("FLT001896") + "</td>");
        write("</tr>");
        write('<tr class="innertabletop1">');
        write('<td colspan="5" class="rowspacing1"><spacer type="block" height=1 width=1></spacer>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td colspan="5" class="rowspacing"><spacer type="block" height=1 width=1></spacer></td>');
        write("</tr>");
        write('<tr class="subhdrbg">');
        write('<td colspan="5" class="subhdr">' + jspResArr.get("FLT010860") + "</td>");
        write("</tr>");
        write("<tr>");
        write('<td colspan="5" class="rowspacing"><spacer type="block" height=1 width=1></spacer></td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT010814") + "</td>");
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" class="listboxfont" id="defStartMonth" name="' + groupName + '.defStartMonth" fmnd="' + laparmProps.get("numOfMnthsDefer_MANDATORY") + '" ' + laparmProps.get("defStartMonth_ENABLED") + ">");
        if (addlnCalBase != "00") {
            writeComboFunction("writeLocalCalMonthsNumList")
        } else {
            writeComboFunction("writeMonthsNumList")
        }
        write("</select>");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT010813") + "</td>");
        write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'laparm_ei\',this);" onBlur="javascript:return custom_ONBLUR(\'laparm_ei\',this);" type="text" class="textfieldfont" id="numOfMnthsDefer" name="' + groupName + '.numOfMnthsDefer" fdt="fpzint" fmnd="' + laparmProps.get("numOfMnthsDefer_MANDATORY") + '" size="30" maxlength="2" ' + laparmProps.get("numOfMnthsDefer_ENABLED") + "> </td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT033169") + "</td>");
        write('<td class="textfield">');
        write('<input type="radio" class="ctext" id="capEMIFlg" name="' + groupName + '.capEMIFlg" value="Y" ' + laparmProps.get("capEMIFlg_MANDATORY") + " CHECKED>" + jspResArr.get("FLT001389") + "&nbsp;");
        write('<input type="radio" class="ctext" id="capEMIFlg" name="' + groupName + '.capEMIFlg" value="N" ' + laparmProps.get("capEMIFlg_MANDATORY") + ">" + jspResArr.get("FLT001941") + "");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">&nbsp;</td>');
        write('<td class="textfield">&nbsp;</td>');
        write("</tr>")
    }
}

function printBlock3() {
    with(document) {
        write('<tr class="subhdrbg">');
        write('<td colspan="2" class="subhdr">' + jspResArr.get("FLT014093") + "</td>");
        write('<td colspan="3" align="right" valign="middle">');
        write('<table border="0" cellpadding="0" cellspacing="0">');
        write("<tr>");
        write('<td align="right" >');
        write('<img type="image" src="../Renderer/images/' + applangcode + '/arrowpre.gif" alt="' + jspResArr.get("FLT005180") + '" width="7" height="14" border="0" id="prev" onClick="javascript:return laparm_ei_ONCLICK16(this,this);" onMouseOver="displayHand(this)" > &nbsp;&nbsp;</img></td>');
        write("<td>&nbsp;&nbsp;</td>");
        write("<td> &nbsp;&nbsp;");
        write('<img type="image" src="../Renderer/images/' + applangcode + '/arrownext.gif" alt="' + jspResArr.get("FLT005181") + '" width="7" height="14" border="0" align="absmiddle" id="next" onClick="javascript:return laparm_ei_ONCLICK17(this,this);" onMouseOver="displayHand(this)" >');
        write("&nbsp;&nbsp;&nbsp;&nbsp;");
        write("</img>");
        write("</td>");
        write("</tr>");
        write("</table>");
        write("</td>");
        write("<td> </td>");
        write("<td> </td>");
        write("<td></td>");
        write("</tr>");
        write("<tr>");
        write('<td height="1" colspan="7">');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
        write("<tr>");
        write('<td class="searcheader1a">' + jspResArr.get("FLT002063") + "</td>");
        write('<td class="searcheader"> ' + jspResArr.get("FLT000288") + "</td>");
        write('<td class="searcheader" >' + jspResArr.get("FLT000843") + "</td>");
        write('<td class="searcheader" >' + jspResArr.get("FLT000006") + " </td>");
        write('<td class="amountheader" >' + jspResArr.get("FLT000185") + "</td>");
        write('<td class="amountheader" >' + jspResArr.get("FLT000844") + "</td>");
        write('<td class="searcheader">' + jspResArr.get("FLT005855") + " </td>");
        write("</tr>")
    }
}

function printBlock4() {
    with(document) {
        if (llSize == 0) {
            write('<tr><td COLSPAN="7" ALIGN="left">' + jspResArr.get("FLT001563") + "</td></tr>")
        }
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
        write("</td>");
        write("</tr>");
        write("</table>");
        write("</div>");
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
            write('<input type="button" class="Button" id="Validate" value="' + jspResArr.get("FLT000194") + '"  onClick="javascript:return laparm_ei_ONCLICK18(this,this);" hotKeyId="Validate" >');
            write('<input type="button" class="Button" id="Cancel" value="' + jspResArr.get("FLT000192") + '"   onClick="javascript:return laparm_ei_ONCLICK19(this,this);" hotKeyId="Cancel" >');
            writeFooter();
            write("</div>")
        }
    }
}

function fnPopulateControlValues() {
    var a = document.forms[0];
    a.eiSchmFlg.value = eiSchmFlg;
    a.eiType.value = eiType;
    a.eiFormulaFlg.value = eiFormulaFlg;
    a.noOfInstlmnts.value = noOfInstlmnts;
    a.instlmntStartDate.value = instlmntStartDate;
    a.intStartDate.value = intStartDate;
    a.eiFreqType.value = eiFreqType;
    a.eiFreqWeek.value = eiFreqWeek;
    a.eiFreqCalBase.value = eiFreqCalBase;
    a.eiHldyStatus.value = eiHldyStatus;
    a.intFreqType.value = intFreqType;
    a.intFreqWeek.value = intFreqWeek;
    a.intFreqCalBase.value = intFreqCalBase;
    a.intHldyStatus.value = intHldyStatus;
    a.hldyPerdMths.value = hldyPerdMths;
    a.autoReshdlFlg.value = autoReshdlFlg;
    a.hldyPerdIntFlg.value = hldyPerdIntFlg;
    a.holFreqType.value = holFreqType;
    a.holFreqWeek.value = holFreqWeek;
    a.holFreqWkDay.value = holFreqWkDay;
    a.holFreqStartDate.value = holFreqStartDate;
    a.holFreqCalBase.value = holFreqCalBase;
    a.holHldyStatus.value = holHldyStatus;
    a.hldyPerdIntInstlMths.value = hldyPerdIntInstlMths;
    a.hldyPerdFrmFirstDisbFlg.value = hldyPerdFrmFirstDisbFlg;
    a.intRestFreq.value = intRestFreq;
    a.intRestBasis.value = intRestBasis;
    a.collectUpFrontFlg.value = collectUpFrontFlg;
    a.numOfAdvInst.value = numOfAdvInst;
    a.gpAllowed.value = gpAllowed;
    a.gpNoOfSteps.value = gpNoOfSteps;
    a.gpStepPcnt.value = gpStepPcnt;
    a.gpStepInd.value = gpStepInd;
    a.capEMIFlg.value = capEMIFlg;
    a.defStartMonth.value = defStartMonth;
    a.numOfMnthsDefer.value = numOfMnthsDefer;
    a.singEmiDiffFlg.value = singEmiDiffFlg;
    a.repayCode.value = repayCode;
    a.repayCodeDesc.value = repayCodeDesc;
    a.brknPerdIntFlg.value = brknPerdIntFlg;
    if ((sReferralMode == "I") || (sReferralMode == "S")) {
        fnDisableFormDataControls("V", a, 0)
    }
}

function laparm_ei_ONKEYDOWN1(b, c) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONKEYDOWN") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONKEYDOWN") == false) {
        return false
    }
    if ((a = fnKeyDownProcessor(c)) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONKEYDOWN") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONKEYDOWN") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONKEYUP2(b, c) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONKEYUP") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONKEYUP") == false) {
        return false
    }
    if ((a = fnKeyUpProcessor(c)) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONKEYUP") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONKEYUP") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONLOAD3(c, d) {
    var b = "";
    var a = document.forms[0];
    if (pre_ONLOAD("laparm_ei", c) == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", c, "ONLOAD") == false) {
        return false
    }
    if ((b = fnOnLoad()) == false) {
        return false
    }
    if ((b = fnAssignDateOnLoad(d)) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", c, "ONLOAD") == false) {
        return false
    }
    fnPopUpExceptionWindow(a.actionCode);
    if (post_ONLOAD("laparm_ei", c) == false) {
        return false
    }
    return (b == undefined) ? true : b
}

function laparm_ei_ONCLICK4(b) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnEiSchmCheck()) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONCLICK5(b) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnEiSchmCheck()) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONCHANGE6(b) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = fnEnableDisableIntFreq()) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONCHANGE7(b) {
    var a = "";

	if(b.id == "eiFreqType"){
		if(b.value =="B"){
			document.forms[0].eiFreqStartDate.value = "";
		}
    }

    if (preEventCall("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = fnEnableDisableIntFreq()) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONCHANGE8(b, c) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONCHANGE9(b) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = fnEnableDisableFld()) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONCLICK10(b) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnDisableCheckBoxAdvInstal()) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONCLICK11(b) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnDisableCheckBoxAdvInstal()) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONCHANGE12(b) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = fnClearFld()) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONCLICK13(b) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnchkradiogpStepInd()) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONCHANGE14(b) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = fnClearFld()) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONCLICK15(b) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnchkradiogpStepInd()) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONCLICK16(b, c) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONCLICK17(b, c) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONCLICK18(b, c) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function laparm_ei_ONCLICK19(b, c) {
    var a = "";
    if (preEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCallForLocale("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("laparm_ei", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function writeEIFormula() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="F">' + jspResArr.get("FLT012651") + "</OPTION>");
        write('<OPTION VALUE="M">' + jspResArr.get("FLT012326") + "</OPTION>");
        write('<OPTION VALUE="P">' + jspResArr.get("FLT012838") + "</OPTION>");
        write('<OPTION VALUE="R">' + jspResArr.get("FLT012925") + "</OPTION>")
    }
}

function writeFreType() {
    with(document) {
        write('<OPTION selected VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="B">' + jspResArr.get("FLT012024") + "</OPTION>");
        write('<OPTION VALUE="D">' + jspResArr.get("FLT012545") + "</OPTION>");
        write('<OPTION VALUE="F">' + jspResArr.get("FLT012652") + "</OPTION>");
        write('<OPTION VALUE="T">' + jspResArr.get("FLT014047") + "</OPTION>");
        write('<OPTION VALUE="H">' + jspResArr.get("FLT012691") + "</OPTION>");
        write('<OPTION VALUE="M">' + jspResArr.get("FLT012353") + "</OPTION>");
        write('<OPTION VALUE="Q">' + jspResArr.get("FLT012856") + "</OPTION>");
        write('<OPTION VALUE="W">' + jspResArr.get("FLT013183") + "</OPTION>");
        write('<OPTION VALUE="Y">' + jspResArr.get("FLT012404") + "</OPTION>")
    }
}

function writeWeekNumber() {
    with(document) {
        write('<OPTION selected VALUE="">' + jspResArr.get("FLT013174") + "</OPTION>");
        write('<OPTION VALUE="1">' + jspResArr.get("FLT011775") + "</OPTION>");
        write('<OPTION VALUE="2">' + jspResArr.get("FLT011794") + "</OPTION>");
        write('<OPTION VALUE="3">' + jspResArr.get("FLT011812") + "</OPTION>");
        write('<OPTION VALUE="4">' + jspResArr.get("FLT011829") + "</OPTION>");
        write('<OPTION VALUE="L">' + jspResArr.get("FLT012233") + "</OPTION>");
        write('<OPTION VALUE="M">' + jspResArr.get("FLT012345") + "</OPTION>")
    }
}

function writeFreDays() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012488") + "</OPTION>");
        write('<OPTION VALUE="1">' + jspResArr.get("FLT011782") + "</OPTION>");
        write('<OPTION VALUE="2">' + jspResArr.get("FLT011798") + "</OPTION>");
        write('<OPTION VALUE="3">' + jspResArr.get("FLT011817") + "</OPTION>");
        write('<OPTION VALUE="4">' + jspResArr.get("FLT011832") + "</OPTION>");
        write('<OPTION VALUE="5">' + jspResArr.get("FLT011846") + "</OPTION>");
        write('<OPTION VALUE="6">' + jspResArr.get("FLT011858") + "</OPTION>");
        write('<OPTION VALUE="7">' + jspResArr.get("FLT011870") + "</OPTION>")
    }
}

function writeFreDates() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT000205") + "</OPTION>");
        write('<OPTION VALUE="1">' + jspResArr.get("FLT011753") + "</OPTION>");
        write('<OPTION VALUE="2">' + jspResArr.get("FLT011754") + "</OPTION>");
        write('<OPTION VALUE="3">' + jspResArr.get("FLT011756") + "</OPTION>");
        write('<OPTION VALUE="4">' + jspResArr.get("FLT011757") + "</OPTION>");
        write('<OPTION VALUE="5">' + jspResArr.get("FLT011758") + "</OPTION>");
        write('<OPTION VALUE="6">' + jspResArr.get("FLT011759") + "</OPTION>");
        write('<OPTION VALUE="7">' + jspResArr.get("FLT011760") + "</OPTION>");
        write('<OPTION VALUE="8">' + jspResArr.get("FLT011761") + "</OPTION>");
        write('<OPTION VALUE="9">' + jspResArr.get("FLT011762") + "</OPTION>");
        write('<OPTION VALUE="10">' + jspResArr.get("FLT009410") + "</OPTION>");
        write('<OPTION VALUE="11">' + jspResArr.get("FLT009411") + "</OPTION>");
        write('<OPTION VALUE="12">' + jspResArr.get("FLT009412") + "</OPTION>");
        write('<OPTION VALUE="13">' + jspResArr.get("FLT009413") + "</OPTION>");
        write('<OPTION VALUE="14">' + jspResArr.get("FLT009414") + "</OPTION>");
        write('<OPTION VALUE="15">' + jspResArr.get("FLT009415") + "</OPTION>");
        write('<OPTION VALUE="16">' + jspResArr.get("FLT009709") + "</OPTION>");
        write('<OPTION VALUE="17">' + jspResArr.get("FLT009710") + "</OPTION>");
        write('<OPTION VALUE="18">' + jspResArr.get("FLT009711") + "</OPTION>");
        write('<OPTION VALUE="19">' + jspResArr.get("FLT009712") + "</OPTION>");
        write('<OPTION VALUE="20">' + jspResArr.get("FLT004108") + "</OPTION>");
        write('<OPTION VALUE="21">' + jspResArr.get("FLT004114") + "</OPTION>");
        write('<OPTION VALUE="22">' + jspResArr.get("FLT009713") + "</OPTION>");
        write('<OPTION VALUE="23">' + jspResArr.get("FLT009714") + "</OPTION>");
        write('<OPTION VALUE="24">' + jspResArr.get("FLT009715") + "</OPTION>");
        write('<OPTION VALUE="25">' + jspResArr.get("FLT009716") + "</OPTION>");
        write('<OPTION VALUE="26">' + jspResArr.get("FLT009717") + "</OPTION>");
        write('<OPTION VALUE="27">' + jspResArr.get("FLT009718") + "</OPTION>");
        write('<OPTION VALUE="28">' + jspResArr.get("FLT009719") + "</OPTION>");
        write('<OPTION VALUE="29">' + jspResArr.get("FLT009720") + "</OPTION>");
        write('<OPTION VALUE="30">' + jspResArr.get("FLT004115") + "</OPTION>");
        write('<OPTION VALUE="31">' + jspResArr.get("FLT009721") + "</OPTION>")
    }
}

function writeFreHoliDayStatus() {
    with(document) {
        write('<OPTION selected VALUE="">' + jspResArr.get("FLT012689") + "</OPTION>");
        write('<OPTION VALUE="N">' + jspResArr.get("FLT012721") + "</OPTION>");
        write('<OPTION VALUE="P">' + jspResArr.get("FLT012845") + "</OPTION>")
    }
}

function writeFrequencyCalendarBase() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="00">' + jspResArr.get("FLT019695") + "</OPTION>");
        write('<OPTION VALUE="01">' + jspResArr.get("FLT019696") + "</OPTION>")
    }
}

function writeLaIntCalcFreqType() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="D">' + jspResArr.get("FLT012545") + "</OPTION>");
        write('<OPTION VALUE="F">' + jspResArr.get("FLT012652") + "</OPTION>");
        write('<OPTION VALUE="T">' + jspResArr.get("FLT014047") + "</OPTION>");
        write('<OPTION VALUE="H">' + jspResArr.get("FLT012691") + "</OPTION>");
        write('<OPTION VALUE="M">' + jspResArr.get("FLT012353") + "</OPTION>");
        write('<OPTION VALUE="Q">' + jspResArr.get("FLT012856") + "</OPTION>");
        write('<OPTION VALUE="W">' + jspResArr.get("FLT013183") + "</OPTION>");
        write('<OPTION VALUE="Y">' + jspResArr.get("FLT012404") + "</OPTION>")
    }
}

function fnWriteautoReshdlFlgTypes() {
    with(document) {
        write('<OPTION VALUE="F">' + jspResArr.get("FLT012606") + "</OPTION>");
        write('<OPTION VALUE="H">' + jspResArr.get("FLT013271") + "</OPTION>");
        write('<OPTION VALUE="N">' + jspResArr.get("FLT012360") + "</OPTION>")
    }
}

function writeHolidayPerdStatus() {
    with(document) {
        write('<OPTION VALUE="N">' + jspResArr.get("FLT028932") + "</OPTION>");
        write('<OPTION VALUE="A">' + jspResArr.get("FLT011944") + "</OPTION>");
        write('<OPTION VALUE="C">' + jspResArr.get("FLT012111") + "</OPTION>");
        write('<OPTION VALUE="S">' + jspResArr.get("FLT013005") + "</OPTION>");
        write('<OPTION VALUE="I">' + jspResArr.get("FLT013857") + "</OPTION>")
    }
}

function writeFrequencyType() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="D">' + jspResArr.get("FLT012545") + "</OPTION>");
        write('<OPTION VALUE="F">' + jspResArr.get("FLT012652") + "</OPTION>");
        write('<OPTION VALUE="H">' + jspResArr.get("FLT012691") + "</OPTION>");
        write('<OPTION VALUE="M">' + jspResArr.get("FLT012353") + "</OPTION>");
        write('<OPTION VALUE="Q">' + jspResArr.get("FLT012856") + "</OPTION>");
        write('<OPTION VALUE="W">' + jspResArr.get("FLT013183") + "</OPTION>");
        write('<OPTION VALUE="Y">' + jspResArr.get("FLT012404") + "</OPTION>")
    }
}

function writeRestFreqType() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="D">' + jspResArr.get("FLT012545") + "</OPTION>");
        write('<OPTION VALUE="H">' + jspResArr.get("FLT012691") + "</OPTION>");
        write('<OPTION VALUE="M">' + jspResArr.get("FLT012353") + "</OPTION>");
        write('<OPTION VALUE="Q">' + jspResArr.get("FLT012856") + "</OPTION>");
        write('<OPTION VALUE="Y">' + jspResArr.get("FLT012404") + "</OPTION>")
    }
}

function writeRestBasis() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="A">' + jspResArr.get("FLT011942") + "</OPTION>");
        write('<OPTION VALUE="C">' + jspResArr.get("FLT012106") + "</OPTION>");
        write('<OPTION VALUE="F">' + jspResArr.get("FLT012649") + "</OPTION>")
    }
}

function writeLocalCalMonthsNumList() {
    with(document) {
        write('<OPTION VALUE="0">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="1">' + jspResArr.get("FLT020962") + "</OPTION>");
        write('<OPTION VALUE="2">' + jspResArr.get("FLT020963") + "</OPTION>");
        write('<OPTION VALUE="3">' + jspResArr.get("FLT020964") + "</OPTION>");
        write('<OPTION VALUE="4">' + jspResArr.get("FLT020965") + "</OPTION>");
        write('<OPTION VALUE="5">' + jspResArr.get("FLT020966") + "</OPTION>");
        write('<OPTION VALUE="6">' + jspResArr.get("FLT020967") + "</OPTION>");
        write('<OPTION VALUE="7">' + jspResArr.get("FLT020968") + "</OPTION>");
        write('<OPTION VALUE="8">' + jspResArr.get("FLT020969") + "</OPTION>");
        write('<OPTION VALUE="9">' + jspResArr.get("FLT020970") + "</OPTION>");
        write('<OPTION VALUE="10">' + jspResArr.get("FLT020971") + "</OPTION>");
        write('<OPTION VALUE="11">' + jspResArr.get("FLT020973") + "</OPTION>");
        write('<OPTION VALUE="12">' + jspResArr.get("FLT020974") + "</OPTION>")
    }
}

function writeMonthsNumList() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="1">' + jspResArr.get("FLT012181") + "</OPTION>");
        write('<OPTION VALUE="2">' + jspResArr.get("FLT012646") + "</OPTION>");
        write('<OPTION VALUE="3">' + jspResArr.get("FLT012338") + "</OPTION>");
        write('<OPTION VALUE="4">' + jspResArr.get("FLT011946") + "</OPTION>");
        write('<OPTION VALUE="5">' + jspResArr.get("FLT012344") + "</OPTION>");
        write('<OPTION VALUE="6">' + jspResArr.get("FLT012185") + "</OPTION>");
        write('<OPTION VALUE="7">' + jspResArr.get("FLT012184") + "</OPTION>");
        write('<OPTION VALUE="8">' + jspResArr.get("FLT011949") + "</OPTION>");
        write('<OPTION VALUE="9">' + jspResArr.get("FLT013000") + "</OPTION>");
        write('<OPTION VALUE="10">' + jspResArr.get("FLT012775") + "</OPTION>");
        write('<OPTION VALUE="11">' + jspResArr.get("FLT012733") + "</OPTION>");
        write('<OPTION VALUE="12">' + jspResArr.get("FLT012549") + "</OPTION>")
    }
};