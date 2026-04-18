// Generated from spec file 

function printBlock1()
{
	writeHeader("larepay_maint");
	with (document) {
	write('<input type="hidden" name="submitform">');
	write('<input type="hidden" name="tabenabled">');
	write('<input type="hidden" name="pagename" value="larepay">');
	write('<input type="hidden" id="IsPageEmpty" name="IsPageEmpty" value="false">');
	write('<input type="hidden" id="check" name="check">');
	write('<input type="hidden" id="ConfirmChoice" name="ConfirmChoice">');
	write('<input type="hidden" id="CalcEiFlg" name="' + sGroupName + '.CalcEiFlg" >');
	write('<input type="hidden" id="direction" name="' + sGroupName + '.direction" >');
	write('<input type="hidden" id="FocusField" name="FocusField" >');
	write('<input type="hidden" id="RecNo" name="' + sGroupName + '.' + multiRecName + '.RecNo" >');
	write('<input type="hidden" id="ErrLLName" name="ErrLLName" >');
	write('<input type="hidden" id="srlNum" name="' + sGroupName + '.srlNum" >');
	write('<input type="hidden" id="delFlg" name="' + sGroupName + '.delFlg" >');
	write('<input type="hidden" id="collUpfrontInstl" name="' + sGroupName + '.collUpfrontInstl" value="' + collUpfrontInstl + '">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop1">');
	write('<tr>');
	write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
	write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
	write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
	write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
	write('<td align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td> </td>');
	write('<td align="right">');
	write('<a id="sLnk2" target=_self href="javascript:showHelpFile(\'larepay_help.htm\');">');
	write('<img border="0" src="../Renderer/images/' + applangcode + '/help.gif" hotKeyId="finHelp">');
	write('</img></a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr class="subhdrbg">');
	write('<td class="subhdr" colspan="5"> ' + jspResArr.get("FLT000305") + '</td>');
	write('</tr>');
	write('<TR>');
	write('<TD class="textlabel">' + jspResArr.get("FLT000304") + '</TD>');
	write('<TD class="textfielddisplaylabel">' + jsUtil.encodeChar(acctId) + '</TD>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<TD class="textlabel">' + jspResArr.get("FLT000306") + '</TD>');
	write('<TD class="textfielddisplaylabel">');
	newformatAmt(amountFormat,sancLimit,crncyCode,"Y")
	write('</TD>');
	write('</TR>');
	write('<TR>');
	write('<TD class="textlabel">' + jspResArr.get("FLT000307") + '</TD>');
	write('<TD class="textfielddisplaylabel">' + jsUtil.encodeChar(scheduleNo) + '</TD>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<TD class="textlabel">' + jspResArr.get("FLT003534") + '</TD>');
	write('<TD class="textfielddisplaylabel">' + jsUtil.encodeChar(fnConvertToUIDate(rephasementDate)) + '</TD>');
	write('</TR>');
	write('<TR>');
	write('<TD class="textlabel">' + jspResArr.get("FLT000003") + '</TD>');
	write('<TD class="textfielddisplaylabel">' + jsUtil.encodeChar(solId) + '</TD>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<TD class="textlabel" >' + jspResArr.get("FLT000309") + '</TD>');
	write('<TD class="textfielddisplaylabel">');
	if(sGroup=="acmla" || sGroup=="acmcl"){
		if(loanLiability=="0.00" || loanLiability=="0.0000" || loanLiability=="0.000"){
			newformatAmt(amountFormat,loanLiability,crncyCode,"Y")
		}else{
	write('-');
			newformatAmt(amountFormat,loanLiability,crncyCode,"Y")}
	}
	write('</TD>');
	write('</TR>');
	write('<TR>');
	write('<TD class="textlabel">' + jspResArr.get("FLT000310") + '</TD>');
	write('<TD class="textfielddisplaylabel">');
	newformatAmt(amountFormat,fnRemoveCrncy(overflowLoanAmt),crncyCode,"Y")
	write('</TD>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<TD class="textlabel">' + jspResArr.get("FLT002189") + '</TD>');
	write('<TD class="textfielddisplaylabel">');
	newformatAmt(amountFormat,fnRemoveCrncy(overdueLoanAmt),crncyCode,"Y")
	write('</TD>');
	write('</TR>');
	write('<TR>');
	write('<TD class="textlabel">' + jspResArr.get("FLT002190") + '</TD>');
	write('<TD class="textfielddisplaylabel">');
	newformatAmt(amountFormat,fnRemoveCrncy(intOverdueAmt),crncyCode,"Y")
	write('</TD>');

	
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">Total Overdue Amt</td>');
	write('<td><input type="text" class = "textfieldfont" id = "sumOvduAmt" name="sumOvduAmt" maxlength="40" readonly="readonly">');
	write('</td>');

	write('</TR>');
	if( !(parentGroup.toUpperCase()=='CLACOP') && !(parentGroup.toUpperCase()=='ACMCL')){
	write('<TR>');
	write('<td class="textlabel">' + jspResArr.get("FLT000313") + '</td>');
	write('<td><input type="checkbox" class="check" id="chkcollUpfrontInstl" name="' + sGroupName + '.chkcollUpfrontInstl" OnClick="javascript:return larepay_maint_ONCLICK4(this,this);";disabled>&nbsp;&nbsp;&nbsp;</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT001911") + '&nbsp;&nbsp;&nbsp;</td>');
	write('<td><input onChange="javascript:return custom_ONCHANGE(\'larepay_maint\',this);" onBlur="javascript:return custom_ONBLUR(\'larepay_maint\',this);" type=text class="textfieldfont" maxLength=2 size=4 name="' + sGroupName + '.numAdvInstl" id="numAdvInstl" fdt="fpint" value="' + numAdvInstl + '">&nbsp;&nbsp;&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT014198") + '&nbsp;&nbsp;&nbsp;</td>');
	write('<td><input onChange="javascript:return custom_ONCHANGE(\'larepay_maint\',this);" onBlur="javascript:return custom_ONBLUR(\'larepay_maint\',this);" type=text class="textfieldfont" maxLength=24 size=24 name="' + sGroupName + '.advInstlAmt" id="advInstlAmt" value="' + advInstlAmt + '" readonly style="TEXT-ALIGN:right">');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT014199") + '&nbsp;&nbsp;&nbsp;</td>');
	write('<td><input onChange="javascript:return custom_ONCHANGE(\'larepay_maint\',this);" onBlur="javascript:return custom_ONBLUR(\'larepay_maint\',this);" type=text class="textfieldfont" maxLength=24 size=24 name="' + sGroupName + '.upfrontInstlIntAmt" id="upfrontInstlIntAmt" value="' + upfrontInstlIntAmt + '" readonly style="TEXT-ALIGN:right">');
	write('</TR>');
	}
	write('<tr class="rowspacing">');
	write('<td colspan="5">&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td colspan="5" class="rowspacing"><table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('</td>');
	write('</tr>');
	write('<tr class="rowspacing">');
	if(sGroup=="acmcl"){
	write('<td colspan="11">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td class="searcheaderleft">' + jspResArr.get("FLT000315") + '<script>setMandatory("Y")</script></td>');
	write('<td class="searcheader">' + jspResArr.get("FLT000172") + '<script>setMandatory("Y")</script></td>');
	write('<td class="searcheader">' + jspResArr.get("FLT000314") + '<script>setMandatory("Y")</script></td>');
	write('<td class="searcheader">' + jspResArr.get("FLT004529") + '<script>setMandatory("Y")</script></td>');
	write('<td class="searcheader">' + jspResArr.get("FLT002145") + '<script>setMandatory("Y")</script></td>');
	write('<td class="amountheader">' + jspResArr.get("FLT000174") + '<script>setMandatory("' + larepayProps.get("flowAmt_MANDATORY") + '")</script></td>');
	write('<td class="searcheader">' + jspResArr.get("FLT003615") + '<script>setMandatory("' + larepayProps.get("flowPcnt_MANDATORY") + '")</script></td>');
	write('<td class="searcheader">' + jspResArr.get("FLT004528") + '<script>setMandatory("Y")</script></td>');
	write('<td class="searcheader">' + jspResArr.get("FLT001840") + '<script>setMandatory("Y")</script></td>');
	write('<td class="searcheader">' + jspResArr.get("FLT001390") + '<script>setMandatory("' + larepayProps.get("delFlg_MANDATORY") + '")</script></td>');
	write('<td class="searcheader1a">&nbsp;</td>');
	write('</tr>');
	}else{
	write('<td colspan="10">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td class="searcheaderleft">' + jspResArr.get("FLT000315") + '<script>setMandatory("Y")</script></td>');
	write('<td class="searcheader">' + jspResArr.get("FLT000172") + '<script>setMandatory("Y")</script></td>');
	write('<td class="searcheader">' + jspResArr.get("FLT000314") + '<script>setMandatory("Y")</script></td>');
	write('<td class="searcheader">' + jspResArr.get("FLT002145") + '<script>setMandatory("Y")</script></td>');
	write('<td class="amountheader">' + jspResArr.get("FLT000174") + '<script>setMandatory("' + larepayProps.get("flowAmt_MANDATORY") + '")</script></td>');
	write('<td class="searcheader">' + jspResArr.get("FLT003615") + '<script>setMandatory("' + larepayProps.get("flowPcnt_MANDATORY") + '")</script></td>');
	write('<td class="searcheader">' + jspResArr.get("FLT004528") + '<script>setMandatory("Y")</script></td>');
	write('<td class="searcheader">' + jspResArr.get("FLT001840") + '<script>setMandatory("Y")</script></td>');
	write('<td class="searcheader">' + jspResArr.get("FLT001390") + '<script>setMandatory("' + larepayProps.get("delFlg_MANDATORY") + '")</script></td>');
	write('<td class="searcheader1a">&nbsp;</td>');
	write('</tr>');
	}

	} //End with()
} //End function

function printBlock2()
{
	with (document) {
	write('<tr>');
	write('<td colspan="12" class="grayline" height="1"><spacer type="block" height=1 width=1></td>');
	write('</tr>');
	write('</table>');
	write('<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="innertabletop">');
	write('<tr class="rowspacing1">');
	write('<td colspan="5" ><spacer type="block" height=1 width=1></spacer></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000315") + '</td>');
	write('<TD class="textfield">');
	write('<input onBlur="javascript:return custom_ONBLUR(\'larepay_maint\',this);" class="textfieldfont" type=text maxLength=5 size=8 name="' + sGroupName + '.flowId" fmnd="Y" onChange="javaScript:return larepay_maint_ONCHANGE5(this);" id="flowId" hotKeyId="search1" >');
	write('&nbsp;<a id="sLnk1" target="_self" href="Javascript:getFlowIdList(document.forms[0].flowId)"><img class="img" src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search1"></img></a>');
	write('</TD>');
	write('<td class="columnwidth">&nbsp;</td>');
	PRINTDATEFLD("flowStartDate","Y","4",jspResArr.get("FLT000172"),"Y","N","N","","","");
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000314") + '</td>');
	write('<TD class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'larepay_maint\',this);" class="textfieldfont" type=text maxLength=3 size=5 name="' + sGroupName + '.numInstl" fmnd="Y" id="numInstl" fdt="fint" onChange="javaScript:return larepay_maint_ONCHANGE6(this);";></TD>');
	write('<td class="columnwidth">&nbsp;</td>');
	if(sGroup=="acmcl"){
	write('<td class="textlabel">' + jspResArr.get("FLT004529") + '</td>');
	write('<TD class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'larepay_maint\',this);" onBlur="javascript:return custom_ONBLUR(\'larepay_maint\',this);" class="textfieldfont" type=text maxLength=3 size=5 name="' + sGroupName + '.numOfDemand" fmnd="Y" id="numOfDemand" fdt="fpint" ></TD>');
	write('</tr>');
	}
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT002145") + '</td>');
	write('<TD class="textfield">');
	write('<select class="textfieldfrequency" name="' + sGroupName + '.eiFreqType" id="eiFreqType" fmnd="Y" onChange="javaScript:return larepay_maint_ONCHANGE7(this);">');
	if(sGroup=="acmcl"){
	write('<script type="text/javascript">');
	write('writeCLFreType();');
	write('</script>');
	}else{
	write('<script type="text/javascript">');
	write('writeFreType();');
	write('</script>');
	}
	write('</select>');
	write('<select class="textfieldfrequency" name="' + sGroupName + '.eiFreqWeek" id="eiFreqWeek" onChange="javaScript:return larepay_maint_ONCHANGE8(this);">');
	write('<script type="text/javascript">');
	write('writeWeekNumber();');
	write('</script>');
	write('</select><br>');
	if(sGroup=="acmcl"){
	write('<select class="textfieldfrequency" name="' + sGroupName + '.eiFreqWkDay" id="eiFreqWkDay" onChange="javaScript:return larepay_maint_ONCHANGE9(this);">');
	write('<script type="text/javascript">');
	write('writeWeekDay();');
	write('</script>');
	write('</select>');
	write('<select class="textfieldfrequency" id="eiFreqStartDate" name="' + sGroupName + '.eiFreqStartDate" onChange="javaScript:return larepay_maint_ONCHANGE10(this);">');
	write('<script type="text/javascript">');
	write('writeFreDates();');
	write('</script>');
	write('</select><br>');
	write('<input onChange="javascript:return custom_ONCHANGE(\'larepay_maint\',this);" onBlur="javascript:return custom_ONBLUR(\'larepay_maint\',this);" type="text" class="textfieldinsidemultirec1" name="' + sGroupName + '.eiFreqMonths" id="eiFreqMonths" size="5" maxlength="3" fdt="fpzint">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'larepay_maint\',this);" onBlur="javascript:return custom_ONBLUR(\'larepay_maint\',this);" type="text" class="textfieldinsidemultirec1" name="' + sGroupName + '.eiFreqDays" id="eiFreqDays" size="5" maxlength="3" fdt="fpzint">');
	write('<br>');
	write('<select class="listboxfont" name="' + sGroupName + '.eiHldyStatus" id="eiHldyStatus" onChange="javaScript:return larepay_maint_ONCHANGE11(this);";>');
	write('<script type="text/javascript">');
	write('writeActionHoliday();');
	write('</script>');
	write('</select><br>');
	write('<select class="listboxfont" name="' + sGroupName + '.eiFreqCalBase" id="eiFreqCalBase" onChange="javaScript:return larepay_maint_ONCHANGE12(this);";>');
	write('<script type="text/javascript">');
	write('writeFrequencyCalendarBase();');
	write('</script>');
	write('</select>');
	}else{
	write('<select class="textfieldbyday" name="' + sGroupName + '.eiFreqWkDay" id="eiFreqWkDay" onChange="javaScript:return larepay_maint_ONCHANGE13(this);">');
	write('<script type="text/javascript">');
	write('writeWeekDay();');
	write('</script>');
	write('</select>');
	write('<select class="textfieldfreqstaticdate" id="eiFreqStartDate" name="' + sGroupName + '.eiFreqStartDate" onChange="javaScript:return larepay_maint_ONCHANGE14(this);">');
	write('<script type="text/javascript">');
	write('writeFreDates();');
	write('</script>');
	write('</select>');
	write('<select class="textfieldfrequency" name="' + sGroupName + '.eiHldyStatus" id="eiHldyStatus" onChange="javaScript:return larepay_maint_ONCHANGE15(this);";>');
	write('<script type="text/javascript">');
	write('writeActionHoliday();');
	write('</script>');
	write('</select>');
	write('<br>');
	write('<select class="listboxfont" name="' + sGroupName + '.eiFreqCalBase" id="eiFreqCalBase" onChange="javaScript:return larepay_maint_ONCHANGE16(this);";>');
	write('<script type="text/javascript">');
	write('writeFrequencyCalendarBase();');
	write('</script>');
	write('</select>');
	}
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000174") + '</td>');
	write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'larepay_maint\',this);" class="textfieldfont" type=text id="flowAmt" name="' + sGroupName + '.flowAmt" onchange="javaScript:return larepay_maint_ONCHANGE17(this,flowAmt);" ' + larepayProps.get("flowAmt_ENABLED") + '	maxLength=24 size=24 style="TEXT-ALIGN:right"></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT003615") + '</td>');
	write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'larepay_maint\',this);" class="textfieldfont" type=text id="flowPcnt" name="' + sGroupName + '.flowPcnt" onchange="javaScript:return larepay_maint_ONCHANGE18(this);" ' + larepayProps.get("flowPcnt_ENABLED") + '	maxLength=24 size=24 style="TEXT-ALIGN:left"></td>');
	write('<td class="columnwidth">&nbsp;</td>');
	if(sGroup=="acmcl"){
	write('<input type="hidden" id="nxtIntDmdDate" name="' + sGroupName + '.nxtIntDmdDate" >');
	PRINTDATEFLD("nxtDmdDate","Y","3",jspResArr.get("FLT004528"),"Y","N","N","","","");
	}else{
	write('<input type="hidden" id="nxtIntDmdDate" name="' + sGroupName + '.nxtIntDmdDate" >');
	PRINTDATEFLD("nxtDmdDate","Y","3",jspResArr.get("FLT004528"),"Y","N","N","","","");
	}
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT001840") + '</td>');
	write('<TD calss="textfield">');
	write('<select class="textfieldfrequency" name="' + sGroupName + '.intFreqType" id="intFreqType" fmnd="Y" onChange="javaScript:return larepay_maint_ONCHANGE19(this);";>');
	if(sGroup=="acmcl"){
	write('<script type="text/javascript">');
	write('writeCLFreType();');
	write('</script>');
	}else{
	write('<script type="text/javascript">');
	write('writeFreType();');
	write('</script>');
	}
	write('</select>');
	write('<select class="textfieldfrequency" name="' + sGroupName + '.intFreqWeek" id="intFreqWeek" onChange="javaScript:return larepay_maint_ONCHANGE20(this);";>');
	write('<script type="text/javascript">');
	write('writeWeekNumber();');
	write('</script>');
	write('</select><br>');
	if(sGroup=="acmcl")
	{
	write('<select class="textfieldfrequency" name="' + sGroupName + '.intFreqWkDay" id="intFreqWkDay" onChange="javaScript:return larepay_maint_ONCHANGE21(this);";>');
	write('<script type="text/javascript">');
	write('writeWeekDay();');
	write('</script>');
	write('</select>');
	write('<select class="textfieldfrequency" id="intFreqStartDate" name="' + sGroupName + '.intFreqStartDate" onChange="javaScript:return larepay_maint_ONCHANGE22(this);">');
	write('<script type="text/javascript">');
	write('writeFreDates();');
	write('</script>');
	write('</select><br>');
	write('<input onChange="javascript:return custom_ONCHANGE(\'larepay_maint\',this);" onBlur="javascript:return custom_ONBLUR(\'larepay_maint\',this);" type="text" class="textfieldinsidemultirec1" name="' + sGroupName + '.intFreqMonths" id="intFreqMonths" size="5" maxlength="3" fdt="fpzint">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'larepay_maint\',this);" onBlur="javascript:return custom_ONBLUR(\'larepay_maint\',this);" type="text" class="textfieldinsidemultirec1" name="' + sGroupName + '.intFreqDays" id="intFreqDays" size="5" maxlength="3" fdt="fpzint">');
	write('<br>');
	write('<select class="listboxfont" name="' + sGroupName + '.intHldyStatus" id="intHldyStatus" onChange="javaScript:return larepay_maint_ONCHANGE23(this);";>');
	write('<script type="text/javascript">');
	write('writeActionHoliday();');
	write('</script>');
	write('</select>');
	write('<br>');
	write('<select class="listboxfont" name="' + sGroupName + '.intFreqCalBase" id="intFreqCalBase" onChange="javaScript:return larepay_maint_ONCHANGE24(this);";>');
	write('<script type="text/javascript">');
	write('writeFrequencyCalendarBase();');
	write('</script>');
	write('</select>');
	}else{
	write('<select class="textfieldbyday" name="' + sGroupName + '.intFreqWkDay" id="intFreqWkDay" onChange="javaScript:return larepay_maint_ONCHANGE25(this);";>');
	write('<script type="text/javascript">');
	write('writeWeekDay();');
	write('</script>');
	write('</select>');
	write('<select class="textfieldfreqstaticdate" id="intFreqStartDate" name="' + sGroupName + '.intFreqStartDate" onChange="javaScript:return larepay_maint_ONCHANGE26(this);">');
	write('<script type="text/javascript">');
	write('writeFreDates();');
	write('</script>');
	write('</select>');
	write('<select class="textfieldfrequency" name="' + sGroupName + '.intHldyStatus" id="intHldyStatus" onChange="javaScript:return larepay_maint_ONCHANGE27(this);";>');
	write('<script type="text/javascript">');
	write('writeActionHoliday();');
	write('</script>');
	write('</select>');
	write('<br>');
	write('<select class="listboxfont" name="' + sGroupName + '.intFreqCalBase" id="intFreqCalBase" onChange="javaScript:return larepay_maint_ONCHANGE28(this);";>');
	write('<script type="text/javascript">');
	write('writeFrequencyCalendarBase();');
	write('</script>');
	write('</select>');
	}
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT001390") + '</td>');
	write('<td class="textfield">');
	write('<input type="checkbox" id="chkdelFlg" name="' + sGroupName + '.chkdelFlg" OnClick="javascript:return larepay_maint_ONCLICK29(this,this);";' + larepayProps.get("delFlg_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td colspan="5" class="rowspacingbottom"></td>');
	write('</tr>');
	write('</TABLE></td></tr>');
	write('</table></td></tr>');
	write('</table></td></tr>');
	write('</table>');
	write('</table>');
	write('</div>');
	write('</span>');

	} //End with()
} //End function

function printFooterBlock()
{
	with (document) {
	if ((sReferralMode == 'I')||(sReferralMode == 'S')){
	write('<div class="ctable">');
	if (sReferralMode == 'S'){
	write('<input type="button" class="Button" id="Submit" value="' + jspResArr.get("FLT000193") + '" onClick="javascript:return doRefSubmit(this);"	hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="' + jspResArr.get("FLT000192") + '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	if(sMode !='I'){
	write('<input type="button" class="button" id="Submit" name="Submit" value="' + jspResArr.get("FLT000193") + '" onClick="javascript:return larepay_maint_ONCLICK30(this,this);" hotKeyId="Submit" >');
	write('<input type="button" class="button" id="CalcEi" name="CalcEi" value="' + jspResArr.get("FLT000323") + '" onClick="javascript:return larepay_maint_ONCLICK31(this,this);">');
	write('<input type="button" class="button" id="Validate" name="Validate" value="' + jspResArr.get("FLT000194") + '" onClick="javascript:return larepay_maint_ONCLICK32(this,this);" hotKeyId="Validate" >');
	write('<input type="button" class="button" id="Cancel" name="Cancel" value="' + jspResArr.get("FLT000192") + '" onClick="javascript:return larepay_maint_ONCLICK33(this,this);" hotKeyId="Cancel" >');
	}else{
	write('<input type="button" class="button" id="CalcEi" name="CalcEi" value="' + jspResArr.get("FLT000323") + '" onClick="javascript:return larepay_maint_ONCLICK34(this,this);">');
	write('<input type="button" class="button" id="Cancel" name="Cancel" value="' + jspResArr.get("FLT001166") + '" onClick="javascript:return larepay_maint_ONCLICK35(this,this);" hotKeyId="Go" >');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
} //End function

function fnPopulateControlValues()
{
	var frm = document.forms[0];

	frm.srlNum.value = srlNum;
	frm.CalcEiFlg.value = CalcEiFlg;
	frm.flowAmt.value = flowAmt;
	frm.delFlg.value = delFlg;
	frm.flowId.value = flowId;
	frm.flowStartDate.value = flowStartDate;
	frm.numInstl.value = numInstl;
	frm.eiFreqType.value = eiFreqType;
	frm.eiFreqWeek.value = eiFreqWeek;
	frm.eiFreqWkDay.value = eiFreqWkDay;
	frm.eiFreqStartDate.value = eiFreqStartDate;
	frm.eiHldyStatus.value = eiHldyStatus;
	frm.nxtIntDmdDate.value = nxtIntDmdDate;
	frm.nxtDmdDate.value = nxtDmdDate;
	frm.intFreqType.value = intFreqType;
	frm.intFreqWeek.value = intFreqWeek;
	frm.intFreqWkDay.value = intFreqWkDay;
	frm.intFreqStartDate.value = intFreqStartDate;
	frm.intHldyStatus.value = intHldyStatus;
	frm.eiFreqCalBase.value = eiFreqCalBase;
	frm.intFreqCalBase.value = intFreqCalBase;
	if ((sReferralMode == 'I') || (sReferralMode == 'S')){
		fnDisableFormDataControls('V',frm,0);
	}
	var intOvdu = "0.00";
	var prinOvdu = "0.00"
	var sumAmt;
	if(!isNaN(parseFloat(intOverdueAmt)))
	{
		intOvdu = parseFloat(intOverdueAmt);
	}
	if(!isNaN(parseFloat(overdueLoanAmt)))
	{
		prinOvdu = parseFloat(overdueLoanAmt);
	}
	frm.sumOvduAmt.value = parseFloat(intOvdu) + parseFloat(prinOvdu);
	newformatAmt("MILLION", frm.sumOvduAmt, crncyCode , 'N');
}

function larepay_maint_ONKEYDOWN1(obj,p1)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	if ((retVal = fnKeyDownProcessor(p1)) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONKEYUP2(obj,p1)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONKEYUP') == false) { 
		return false;
	}
	if ((retVal = fnKeyUpProcessor(p1)) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONKEYUP') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONLOAD3(obj,p1)
{
	var retVal = "";
	var frmObj = document.forms[0];

	if (pre_ONLOAD('larepay_maint',obj) == false) { 
		return false;
	}
	if ((retVal = fnOnLoad()) == false) {
		return false;
	}
	if ((retVal = setDefault()) == false) {
		return false;
	}
	if ((retVal = fnAssignDateOnLoad(p1)) == false) {
		return false;
	}
	fnPopUpExceptionWindow(frmObj.actionCode);
	if (post_ONLOAD('larepay_maint',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCLICK4(obj,p1)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnSetCheckboxFld(p1)) == false) {
		return false;
	}
	if ((retVal = ChangeCollFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE5(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE6(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE7(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE8(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE9(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE10(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE11(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE12(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE13(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE14(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE15(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE16(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE17(obj,p1)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = formatAmt(p1)) == false) {
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE18(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE19(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE20(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE21(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE22(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE23(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE24(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE25(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE26(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE27(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCHANGE28(obj)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCLICK29(obj,p1)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnSetCheckboxFld(p1)) == false) {
		return false;
	}
	if ((retVal = chgCalcEiFlg()) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCLICK30(obj,p1)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCLICK31(obj,p1)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCLICK32(obj,p1)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCLICK33(obj,p1)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCLICK34(obj,p1)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function larepay_maint_ONCLICK35(obj,p1)
{
	var retVal = "";
	if (preEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCall('larepay_maint',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function writeCLFreType()
{
with(document) {
write('<OPTION selected VALUE="">'+jspResArr.get("FLT012410")+'</OPTION>');
write('<OPTION VALUE="B">'+jspResArr.get("FLT012024")+'</OPTION>');
write('<OPTION VALUE="D">'+jspResArr.get("FLT012545")+'</OPTION>');
write('<OPTION VALUE="F">'+jspResArr.get("FLT012652")+'</OPTION>');
write('<OPTION VALUE="T">'+jspResArr.get("FLT014047")+'</OPTION>');
write('<OPTION VALUE="H">'+jspResArr.get("FLT012691")+'</OPTION>');
write('<OPTION VALUE="M">'+jspResArr.get("FLT012353")+'</OPTION>');
write('<OPTION VALUE="Q">'+jspResArr.get("FLT012856")+'</OPTION>');
write('<OPTION VALUE="W">'+jspResArr.get("FLT013183")+'</OPTION>');
write('<OPTION VALUE="Y">'+jspResArr.get("FLT012404")+'</OPTION>');
write('<OPTION VALUE="U">'+jspResArr.get("FLT013156")+'</OPTION>');

}
}


function writeFreType()
{
with(document) {
write('<OPTION selected VALUE="">'+jspResArr.get("FLT012410")+'</OPTION>');
write('<OPTION VALUE="B">'+jspResArr.get("FLT012024")+'</OPTION>');
write('<OPTION VALUE="D">'+jspResArr.get("FLT012545")+'</OPTION>');
write('<OPTION VALUE="F">'+jspResArr.get("FLT012652")+'</OPTION>');
write('<OPTION VALUE="T">'+jspResArr.get("FLT014047")+'</OPTION>');
write('<OPTION VALUE="H">'+jspResArr.get("FLT012691")+'</OPTION>');
write('<OPTION VALUE="M">'+jspResArr.get("FLT012353")+'</OPTION>');
write('<OPTION VALUE="Q">'+jspResArr.get("FLT012856")+'</OPTION>');
write('<OPTION VALUE="W">'+jspResArr.get("FLT013183")+'</OPTION>');
write('<OPTION VALUE="Y">'+jspResArr.get("FLT012404")+'</OPTION>');

}
}




function writeWeekNumber()
{
with(document) {
write('<OPTION selected VALUE="">'+jspResArr.get("FLT013174")+'</OPTION>');
write('<OPTION VALUE="1">'+jspResArr.get("FLT011775")+'</OPTION>');
write('<OPTION VALUE="2">'+jspResArr.get("FLT011794")+'</OPTION>');
write('<OPTION VALUE="3">'+jspResArr.get("FLT011812")+'</OPTION>');
write('<OPTION VALUE="4">'+jspResArr.get("FLT011829")+'</OPTION>');
write('<OPTION VALUE="L">'+jspResArr.get("FLT012233")+'</OPTION>');
write('<OPTION VALUE="M">'+jspResArr.get("FLT012345")+'</OPTION>');
}
}


function writeWeekDay()
{
with(document) {
write('<OPTION selected VALUE="">'+jspResArr.get("FLT012488")+'</OPTION>');
write('<OPTION VALUE="1">'+jspResArr.get("FLT011782")+'</OPTION>');
write('<OPTION VALUE="2">'+jspResArr.get("FLT011798")+'</OPTION>');
write('<OPTION VALUE="3">'+jspResArr.get("FLT011817")+'</OPTION>');
write('<OPTION VALUE="4">'+jspResArr.get("FLT011832")+'</OPTION>');
write('<OPTION VALUE="5">'+jspResArr.get("FLT011845")+'</OPTION>');
write('<OPTION VALUE="6">'+jspResArr.get("FLT011858")+'</OPTION>');
write('<OPTION VALUE="7">'+jspResArr.get("FLT011870")+'</OPTION>');
}
}


function writeFreDates()
{
with(document) {
write('<OPTION VALUE="">'+jspResArr.get("FLT000205")+'</OPTION>');
write('<OPTION VALUE="1">'+jspResArr.get("FLT011753")+'</OPTION>');
write('<OPTION VALUE="2">'+jspResArr.get("FLT011754")+'</OPTION>');
write('<OPTION VALUE="3">'+jspResArr.get("FLT011756")+'</OPTION>');
write('<OPTION VALUE="4">'+jspResArr.get("FLT011757")+'</OPTION>');
write('<OPTION VALUE="5">'+jspResArr.get("FLT011758")+'</OPTION>');
write('<OPTION VALUE="6">'+jspResArr.get("FLT011759")+'</OPTION>');
write('<OPTION VALUE="7">'+jspResArr.get("FLT011760")+'</OPTION>');
write('<OPTION VALUE="8">'+jspResArr.get("FLT011761")+'</OPTION>');
write('<OPTION VALUE="9">'+jspResArr.get("FLT011762")+'</OPTION>');
write('<OPTION VALUE="10">'+jspResArr.get("FLT009410")+'</OPTION>');
write('<OPTION VALUE="11">'+jspResArr.get("FLT009411")+'</OPTION>');
write('<OPTION VALUE="12">'+jspResArr.get("FLT009412")+'</OPTION>');
write('<OPTION VALUE="13">'+jspResArr.get("FLT009413")+'</OPTION>');
write('<OPTION VALUE="14">'+jspResArr.get("FLT009414")+'</OPTION>');
write('<OPTION VALUE="15">'+jspResArr.get("FLT009415")+'</OPTION>');
write('<OPTION VALUE="16">'+jspResArr.get("FLT009709")+'</OPTION>');
write('<OPTION VALUE="17">'+jspResArr.get("FLT009710")+'</OPTION>');
write('<OPTION VALUE="18">'+jspResArr.get("FLT009711")+'</OPTION>');
write('<OPTION VALUE="19">'+jspResArr.get("FLT009712")+'</OPTION>');
write('<OPTION VALUE="20">'+jspResArr.get("FLT004108")+'</OPTION>');
write('<OPTION VALUE="21">'+jspResArr.get("FLT004114")+'</OPTION>');
write('<OPTION VALUE="22">'+jspResArr.get("FLT009713")+'</OPTION>');
write('<OPTION VALUE="23">'+jspResArr.get("FLT009714")+'</OPTION>');
write('<OPTION VALUE="24">'+jspResArr.get("FLT009715")+'</OPTION>');
write('<OPTION VALUE="25">'+jspResArr.get("FLT009716")+'</OPTION>');
write('<OPTION VALUE="26">'+jspResArr.get("FLT009717")+'</OPTION>');
write('<OPTION VALUE="27">'+jspResArr.get("FLT009718")+'</OPTION>');
write('<OPTION VALUE="28">'+jspResArr.get("FLT009719")+'</OPTION>');
write('<OPTION VALUE="29">'+jspResArr.get("FLT009720")+'</OPTION>');
write('<OPTION VALUE="30">'+jspResArr.get("FLT004115")+'</OPTION>');
write('<OPTION VALUE="31">'+jspResArr.get("FLT009721")+'</OPTION>');
}

}

function writeActionHoliday()
{
with(document) {
write('<OPTION VALUE="">'+jspResArr.get("FLT012689")+'</OPTION>');
write('<OPTION VALUE="N">'+jspResArr.get("FLT012721")+'</OPTION>');
write('<OPTION VALUE="P">'+jspResArr.get("FLT012845")+'</OPTION>');
write('<OPTION VALUE="S">'+jspResArr.get("FLT013007")+'</OPTION>');
}
}


function writeFrequencyCalendarBase()
{
with(document) {
write('<OPTION VALUE="">'+jspResArr.get("FLT012410")+'</OPTION>');
write('<OPTION VALUE="00">'+jspResArr.get("FLT019695")+'</OPTION>');
write('<OPTION VALUE="01">'+jspResArr.get("FLT019696")+'</OPTION>');

}
}


