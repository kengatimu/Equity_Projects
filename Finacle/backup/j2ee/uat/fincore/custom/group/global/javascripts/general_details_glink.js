// Generated from spec file 

function printBlock()
{
	writeHeader("general_details");
	with (document) {
	write('<input type="hidden" name="submitform">');
	write('<input type="hidden" name="check">');
	write('<input type="hidden" name="pagename" value="generaldetails">');
	write('<input type="hidden" name="field">');
	write('<input type="hidden" name="recNo">');
	write('<input type="hidden" id="securedFlg" name="' + sGroupName + '.securedFlg">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td colspan="5"> <table border="0" cellspacing="0" cellpadding="0" class="innertabletop1">');
	write('<tr>');
	write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
	write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
	write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
	write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
	write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
	write('<td align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td> </td>');
	write('<td align="right">');
	write('<a href="javascript:showHelpFile(\'general_details_help.htm\');">');
	write('<img align="right" class="img" border="0" src="../Renderer/images/' + applangcode + '/help.gif" hotKeyId="finHelp">');
	write('</img></a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr class="innertabletop1">');
	write('<td colspan="5" class="rowspacing1"><spacer type="block" height=1 width=1></spacer></td>');
	write('</tr>');
	write('<tr valign="middle" class="subhdrbg">');
	write('<td colspan="5" class="subhdr">' + jspResArr.get("FLT001486") + '</td>');
	write('<td colspan="3" align="right" >');
	write('<div id="dispText0"><img id="expand1" align="right" border="0" src="../Renderer/images/' + applangcode + '/expand.gif" onMouseOver=\'displayHand(this)\' onClick=\'javascript:return general_details_ONCLICK4(this,"1","C");\' ></img></div>');
	write('<div id="hideText0" style="display: none"><img id="collapse1" align="right" border="0" src="../Renderer/images/' + applangcode + '/collapse.gif" onMouseOver=\'displayHand(this)\' onClick=\'javascript:return general_details_ONCLICK5(this,"2","C");\' ></img></div>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td colspan=5>');
	write('<table id="sT1" style="display: none" cellspacing="0" width="100%" cellpadding="0">');
	write('<tr class="innertabletop1">');
	write('<td colspan="5" class="rowspacing">&nbsp;</td>');
	write('</tr>');
	write('<tr class="innertabletop1">');
	write('<td class="textlabel">' + jspResArr.get("FLT000440") + '</td>');
	write('<td class="textfielddisplaylabel" >' + jsUtil.encodeChar(custConst) + '</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000572") + '</td>');
	write('<td class="textfielddisplaylabel" >' + jsUtil.encodeChar(custOccup) + '</td>');
	write('</tr>');
	write('<tr class="innertabletop1">');
	write('<td class="textlabel" >' + jspResArr.get("FLT002523") + '</td>');
	write('<td class="textfielddisplaylabel" >' + jsUtil.encodeChar(custStatus) + '</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000435") + '</td>');
	write('<td class="textfielddisplaylabel" >' + jsUtil.encodeChar(custShortName) + '</td>');
	write('</tr>');
	write('<tr class="innertabletop1">');
	write('<td class="textlabel" >' + jspResArr.get("FLT001464") + '</td>');
	write('<td class="textfielddisplaylabel" >' + jsUtil.encodeChar(introdName) + '</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT001465") + '</td>');
	write('<td class="textfielddisplaylabel" >' + jsUtil.encodeChar(introdStatus) + '</td>');
	write('</tr>');
	write('<tr class="rowspacing">');
	write('<td colspan="5">&nbsp;</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr valign="middle" class="subhdrbg">');
	write('<td colspan="5" class="subhdr">' + jspResArr.get("FLT000011") + '</td>');
	write('<td colspan="3" align="right" valign="middle">&nbsp;&nbsp;</td>');
	write('</tr>');
	write('<tr class="innertabletop1">');
	write('<td colspan="5" class="rowspacing"><spacer type=block height=1 width=1></spacer></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000012") + '<script>setMandatory("Y")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont"  name="' + sGroupName + '.acctName" id="acctName" fmb="Y" SIZE="35" MAXLENGTH="80">');
	write('</td>');
	write('<td class="columnwidth"><spacer type="block" width="1" height="1"></td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000013") + '<script>setMandatory("Y")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.acctShortName" id="acctShortName" fmb="Y" SIZE="18" MAXLENGTH="10">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	PRINTDATEFLD("acctOpenDate","Y","2",jspResArr.get("FLT000014"),"Y","N","Y","1","fnChkAcctOpnAndTopupDate();","");
	if( schemeType=='SBA'){
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT003251") + '</td>');
	write('<td class="textfielddisplaylabel"><input class="label" name="' + sGroupName + '.productType" id="productType" fmb="Y" size=18 maxlength=25 disabled></td>');
	write('</tr>');
	}
	else{
	write('<input type="hidden" name="productType" >');
	}
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT004706") + '<script>setMandatory("' + generaldetailsProps.get("chargeLvlCode_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.chargeLvlCode" id="chargeLvlCode" size=9 maxlength=5 onchange="javascript:return general_details_ONCHANGE6(this,\'chargeLvlDesc\');" hotKeyId="search1">');
	write('&nbsp;');
	write('<a id="sLnk3" target=_self href="javascript:showRefCode(objForm.chargeLvlCode,\'BH\',\'N\',\'F\',objForm.chargeLvlDesc)"><img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search1"> </img>');
	write('</a>');
	write('<br>');
	write('<input class="label" name="' + sGroupName + '.chargeLvlDesc" id="chargeLvlDesc" size=20 maxlength=50 fds="Y" disabled>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000016") + '<script>setMandatory("' + generaldetailsProps.get("locationCode_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.locationCode" id="locationCode" size=9 maxlength=5 onchange="javascript:return general_details_ONCHANGE7(this,\'locationDesc\');" hotKeyId="search2">');
	write('&nbsp;');
	write('<a id="sLnk4" target=_self href="javascript:showRefCode(objForm.locationCode,19,\'N\',\'F\',objForm.locationDesc)">');
	write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search2"></img></a>');
	write('<br>');
	write('<input class="label" name="' + sGroupName + '.locationDesc" id="locationDesc" size=20 maxlength=50 fds="Y" disabled>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >&nbsp;</td>');
	write('<td class="textfield">&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT010374") + '<script>setMandatory("' + generaldetailsProps.get("acctManager_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.acctManager" id="acctManager" size=9 maxlength=15 onchange="javascript:return general_details_ONCHANGE8(this,\'acctMgrName\');" hotKeyId="search3">');
	write('&nbsp;');
	write('<a id="sLnk5" target=_self href=\'javascript:showUserIdList(objForm.acctManager,null,"F",objForm.acctMgrName)\'>');
	write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search3"></img></a>');
	write('<br>');
	write('<input class="label" name="' + sGroupName + '.acctMgrName" id="acctMgrName" size=15 maxlength=15 fds="Y" disabled >');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000017") + '<script>setMandatory("' + generaldetailsProps.get("acctMgrAtAcct_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.acctMgrAtAcct" id="acctMgrAtAcct" size=9 maxlength=15 onchange="javascript:return general_details_ONCHANGE9(this,\'acctMgrAtAcctName\');" hotKeyId="search4">');
	write('&nbsp;');
	
	//ebl 359816 start
	//**************************************************	
	write('<a id="sLnk6" target=_self href="javascript:javascript: showModuleList()">');
	//*****************************************************
	//ebl 359816 end

	write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search4"></img></a>');
	write('<br>');
	write('<input class="label" name="' + sGroupName + '.acctMgrAtAcctName" id="acctMgrAtAcctName" size=15 maxlength=15 fds="Y" disabled >');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000018") + '<script>setMandatory("' + generaldetailsProps.get("cashXpnLimitDr_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" type="text" class="textfieldamount"  name="' + sGroupName + '.cashXpnLimitDr" id="cashXpnLimitDr" fdt="amount" size=24 maxlength=17 onblur=\'javascript:return general_details_ONBLUR10(this,"' + format + '",objForm.cashXpnLimitDr,"' + critCrncy + '","N");\'>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT001458") + '<script>setMandatory("' + generaldetailsProps.get("cashXpnLimitCr_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" type="text" class="textfieldamount" name="' + sGroupName + '.cashXpnLimitCr" id="cashXpnLimitCr" fdt="amount" size=24 maxlength=17 onblur=\'javascript:return general_details_ONBLUR11(this,"' + format + '",objForm.cashXpnLimitCr,"' + critCrncy + '","N");\'>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000020") + '<script>setMandatory("' + generaldetailsProps.get("clgXpnLimitDr_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" type="text" class="textfieldamount" name="' + sGroupName + '.clgXpnLimitDr" id="clgXpnLimitDr" fdt="amount" size=24 maxlength=17 onblur=\'javascript:return general_details_ONBLUR12(this,"' + format + '",objForm.clgXpnLimitDr,"' + critCrncy + '","N");\'>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT001459") + '<script>setMandatory("' + generaldetailsProps.get("clgXpnLimitCr_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" type="text" class="textfieldamount" name="' + sGroupName + '.clgXpnLimitCr" id="clgXpnLimitCr" fdt="amount" size=24 maxlength=17 onblur=\'javascript:return general_details_ONBLUR13(this,"' + format + '",objForm.clgXpnLimitCr,"' + critCrncy + '","N");\'>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000021") + '<script>setMandatory("' + generaldetailsProps.get("xferXpnLimitDr_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" type="text" class="textfieldamount"  name="' + sGroupName + '.xferXpnLimitDr" id="xferXpnLimitDr" fdt="amount" size=24 maxlength=17 onblur=\'javascript:return general_details_ONBLUR14(this,"' + format + '",objForm.xferXpnLimitDr,"' + critCrncy + '","N");\'>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT001460") + '<script>setMandatory("' + generaldetailsProps.get("xferXpnLimitCr_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" type="text" class="textfieldamount"  name="' + sGroupName + '.xferXpnLimitCr" id="xferXpnLimitCr" fdt="amount" size=24 maxlength=17 onblur=\'javascript:return general_details_ONBLUR15(this,"' + format + '",objForm.xferXpnLimitCr,"' + critCrncy + '","N");\'>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT010627") + '<script>setMandatory("' + generaldetailsProps.get("chnlLvlCode_MANDATORY") + '")</script></td>');
	write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont" id="chnlLvlCode" name="' + sGroupName + '.chnlLvlCode" fmnd="' + generaldetailsProps.get("chnlLvlCode_MANDATORY") + '" size="8" maxlength="5" ' + generaldetailsProps.get("chnlLvlCode_ENABLED") + ' hotKeyId="search5">');
	write('&nbsp;');
	write('<a id="sLnk7" target=_self href="Javascript:showRefCode(objForm.chnlLvlCode,\'HX\',\'N\',\'F\',objForm.chnlLvlCodeDesc)"><img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search5"></img></a>');
	write('<br>');
	write('<input class="label" id="chnlLvlCodeDesc" name="' + sGroupName + '.chnlLvlCodeDesc" fds="Y" size="50" maxlength="40" disabled>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000022") + '<script>setMandatory("' + generaldetailsProps.get("acctRptCode_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.acctRptCode" id="acctRptCode"  size=11 maxlength=6>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000023") + '<script>setMandatory("' + generaldetailsProps.get("ledgerNo_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.ledgerNo" id="ledgerNo" size=3 maxlength=3 fdt="fpzint">');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT004729") + '<script>setMandatory("' + generaldetailsProps.get("collectCharges_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input type="radio" id="collectCharges" name="' + sGroupName + '.collectCharges" value="Y">' + jspResArr.get("FLT001389") + '');
	write('<input type="radio" id="collectCharges" name="' + sGroupName + '.collectCharges" value="N" checked>' + jspResArr.get("FLT001941") + '</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000025") + '<script>setMandatory("' + generaldetailsProps.get("turoverDtls_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input type="radio" id="turoverDtls" name="' + sGroupName + '.turoverDtls" value="Y">' + jspResArr.get("FLT001389") + '');
	write('<input type="radio" id="turoverDtls" name="' + sGroupName + '.turoverDtls" value="N" checked>' + jspResArr.get("FLT001941") + '');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000026") + '<script>setMandatory("' + generaldetailsProps.get("remarks_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<textarea type="text" class="textfieldfont" cols="23" rows="2" name="' + sGroupName + '.remarks" id="remarks" fmb="Y" onBlur="javascript:return general_details_ONBLUR16(this,this,240);" onKeyDown="javascript:return general_details_ONKEYDOWN17(this,event);">');
	write('</textarea>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000027") + '</td>');
	write('<td class="textfield">');
	write('<input class="label"  name="' + sGroupName + '.staffId" id="staffId" size=20 maxlength=50 fds="Y" disabled>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000028") + '<script>setMandatory("' + generaldetailsProps.get("relativeToStaff_MANDATORY") + '")</script>');
	write('</td>');
	write('<td width="25%" class="textfield">');
	write('<input type="radio" id="relativeToStaff" name="' + sGroupName + '.relativeToStaff" value="Y">' + jspResArr.get("FLT001389") + '');
	write('<input type="radio" id="relativeToStaff" name="' + sGroupName + '.relativeToStaff" value="N" checked>' + jspResArr.get("FLT001941") + '');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000029") + '<script>setMandatory("' + generaldetailsProps.get("relativeStaffId_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.relativeStaffId" id="relativeStaffId" size=18 maxlength=10 hotKeyId="search6">');
	write('&nbsp;');
	write('<a target=_self id="sLnk8" href="javascript:showEmplList(objForm.relativeStaffId,null,\'ctrl\',\'F\',\'\',\'N\',\'Y\')">');
	write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search6"></img></a>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000030") + '<script>setMandatory("Y")</script></td>');
	write('<td class="textfield">');
	write('<select class="listboxfont" name="' + sGroupName + '.pbPsFlg" fmnd="Y" id="pbPsFlg" onChange="javascript:return general_details_ONCHANGE18(this);" >');
	write('<script type="text/javascript">');
	write('writePassbookStatement();');
	write('</script>');
	write('</select>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT020028") + '</td>');
	write('<td class="textfield">');
	write('<select onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" class="listboxfont" name="' + sGroupName + '.prefCalBase" id="prefCalBase">');
	write('<script type="text/javascript">');
	write('writeprefCalendarBase();');
	write('</script>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT019576") + ' </td>');
	write('<td class="textfield">');
	write('<input type="radio" name="' + sGroupName + '.addtnlCalBase" id="addtnlCalBase" ' + generaldetailsProps.get("addtnlCalBase_ENABLED") + ' value="01">' + jspResArr.get("FLT019276") + '');
	write('<input type="radio" name="' + sGroupName + '.addtnlCalBase" id="addtnlCalBase" ' + generaldetailsProps.get("addtnlCalBase_ENABLED") + ' value="00" checked > ' + jspResArr.get("FLT002803") + ' </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000031") + '<script>setMandatory("' + generaldetailsProps.get("pbPsFreqType_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<select onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" class="textfieldfrequency" name="' + sGroupName + '.pbPsFreqType" id="pbPsFreqType">');
	write('<script type="text/javascript">');
	write('writeFrequencyType();');
	write('</script>');
	write('</select>');
	write('<select onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" class="textfieldfrequency" name="' + sGroupName + '.pbPsFreqWeek" id="pbPsFreqWeek">');
	write('<script type="text/javascript">');
	write('writeWeekNumber();');
	write('</script>');
	write('</select>');
	write('<br>');
	write('<select onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" class="textfieldbyday" name="' + sGroupName + '.pbPsFreqDay" id="pbPsFreqDay">');
	write('<script type="text/javascript">');
	write('writeWeekDay();');
	write('</script>');
	write('</select>');
	write('<select onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" class="textfieldfreqstaticdate" name="' + sGroupName + '.pbPsFreqStartDD" id="pbPsFreqStartDD" >');
	write('<script type="text/javascript">');
	write('writeFreDates();');
	write('</script>');
	write('</select>');
	write('<select onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" class="textfieldfrequency" name="' + sGroupName + '.pbPsFreqHldyStat" id="pbPsFreqHldyStat">');
	write('<script type="text/javascript">');
	write('writeActionHoliday();');
	write('</script>');
	write('</select>');
	write('<br>');
	write('<select onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" class="listboxfont" name="' + sGroupName + '.pbPsFreqCalBase" id="pbPsFreqCalBase">');
	write('<script type="text/javascript">');
	write('writeFrequencyCalendarBase();');
	write('</script>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000032") + '<script>setMandatory("' + generaldetailsProps.get("localCalendar_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input type="radio" id="localCalendar" name="' + sGroupName + '.localCalendar" value="Y">' + jspResArr.get("FLT001389") + '');
	write('<input type="radio" id="localCalendar" name="' + sGroupName + '.localCalendar" value="N" checked>' + jspResArr.get("FLT001941") + '');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000033") + '<script>setMandatory("' + generaldetailsProps.get("despatchMode_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<select onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" class="listboxfont" name="' + sGroupName + '.despatchMode" id="despatchMode">');
	write('<script type="text/javascript">');
	write('writeDespatchMode();');
	write('</script>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000034") + '<script>setMandatory("' + generaldetailsProps.get("modeOfOperCode_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.modeOfOperCode" id="modeOfOperCode" size=9 maxlength=5 onchange="javascript:return general_details_ONCHANGE19(this,\'modeOfOperDesc\');" hotKeyId="search7">');
	write('&nbsp;');
	write('<a target=_self id="sLnk9" href="javascript:showRefCode(objForm.modeOfOperCode,27,\'N\',\'F\',objForm.modeOfOperDesc)">');
	write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search7"></img></a>&nbsp;');
	write('<br>');
	write('<input class="label" name="' + sGroupName + '.modeOfOperDesc" id="modeOfOperDesc" size=20 maxlength=40 fds="Y" disabled >');
	write('</td>');
	write('</tr>');
	write('<tr>');
	PRINTDATEFLD("nextPrntDate","Y","10",jspResArr.get("FLT000035"),"N","N","Y","2","","");
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000036") + '<script>setMandatory("' + generaldetailsProps.get("contactPhNum_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont" id="contactPhNum" name="' + sGroupName + '.contactPhNum" size="35" maxlength="15" ' + generaldetailsProps.get("contactPhNum_ENABLED") + ' >');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT014818") + '</td>');
	write('<td class="textfield" >');
	write('<input type="radio" name="' + sGroupName + '.psAtRelPartyFlg" id="psAtRelPartyFlg" value="Y" ' + generaldetailsProps.get("psAtRelPartyFlg_ENABLED") + ' >' + jspResArr.get("FLT001389") + '');
	write('<input type="radio" name="' + sGroupName + '.psAtRelPartyFlg" id="psAtRelPartyFlg" value="N" CHECKED ' + generaldetailsProps.get("psAtRelPartyFlg_ENABLED") + ' >' + jspResArr.get("FLT001941") + '');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000037") + '<script>setMandatory("' + generaldetailsProps.get("allowSweep_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input type="radio" id="allowSweep" name="' + sGroupName + '.allowSweep" ' + generaldetailsProps.get("allowSweep_ENABLED") + ' value="Y">' + jspResArr.get("FLT001389") + '');
	write('<input type="radio" id="allowSweep" name="' + sGroupName + '.allowSweep" ' + generaldetailsProps.get("allowSweep_ENABLED") + ' value="N" checked>' + jspResArr.get("FLT001941") + '');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT002800") + '<script>setMandatory("false")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input type="radio" name="' + sGroupName + '.ecsEnabled" ' + generaldetailsProps.get("ecsEnabled_ENABLED") + ' id="ecsEnabled" value="Y">' + jspResArr.get("FLT001389") + '');
	write('<input type="radio" name="' + sGroupName + '.ecsEnabled" ' + generaldetailsProps.get("ecsEnabled_ENABLED") + ' id="ecsEnabled" value="N">' + jspResArr.get("FLT001941") + '');
	write('<input type="radio" name="' + sGroupName + '.ecsEnabled" ' + generaldetailsProps.get("ecsEnabled_ENABLED") + ' id="ecsEnabled" value="">' + jspResArr.get("FLT002803") + '');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT004391") + '<script>setMandatory("' + generaldetailsProps.get("applicationRefId_MANDATORY") + '")</script></td>');
	write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.applicationRefId" id="applicationRefId" size=20 maxlength=50></td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	if( schemeType=='ODA' || schemeType=='LAA'){
	write('<td>');
	write('<input type="checkbox" class="check" id="chksecuredFlg" onClick="javascript:return general_details_ONCLICK20(this,this);" ' + generaldetailsProps.get("securedFlg_ENABLED") + '>&nbsp;' + jspResArr.get("FLT005618") + '');
	write('</td>');
	}
	write('</tr>');
	write('<tr>');
	write('<td colspan="5" class="rowspacing"><spacer type=block height=1 width=1></spacer></td>');
	write('</tr>');
	write('<tr valign="middle" class="subhdrbg">');
	write('<td colspan="5" class="subhdr"> ' + jspResArr.get("FLT000038") + '</td>');
	write('<td colspan="3" align="right">');
	write('<div id="dispText1"><img id="expand2" align="right" border="0" class="img" src="../Renderer/images/' + applangcode + '/expand.gif" onMouseOver=\'displayHand(this)\' onClick=\'javascript:return general_details_ONCLICK21(this,"1","N");\' ></img></div>');
	write('<div id="hideText1" style="display: none"><img id="collapse2" align="right" border="0" class="img" src="../Renderer/images/' + applangcode + '/collapse.gif" onMouseOver=\'displayHand(this)\' onClick=\'javascript:return general_details_ONCLICK22(this,"2","N");\' ></img></div>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td colspan=5>');
	write('<table id="sT2" style="display: none" class="ctable" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td colspan="5" class="rowspacing"><spacer type=block height=1 width=1></spacer></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" valign="top">' + jspResArr.get("FLT000039") + '<script>setMandatory("' + generaldetailsProps.get("natLangCode_MANDATORY") + '")</script>');
	write('</td>');
	write('<td valign="top" class="textfield" >');
	write('<input onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.natLangCode" id="natLangCode" size=18 maxlength=10 onchange="javascript:return general_details_ONCHANGE23(this,\'natLangDesc\');" hotKeyId="search8">');
	write('&nbsp;');
	write('<a target=_self id="sLnk11" href="javascript:showAppLangCodes(objForm.natLangCode,\'F\',objForm.natLangDesc)">');
	write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search8"></img></a>');
	write('<br>');
	write('<input class="label" name="' + sGroupName + '.natLangDesc" id="natLangDesc" size=20 maxlength=50 fds="Y" disabled >');
	write('</td>');
	write('<td class="columnwidth"><spacer type="block" width="1" height="1"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000040") + '<script>setMandatory("' + generaldetailsProps.get("natLangTitle_MANDATORY") + '")</script>');
	write('</td>');
	write('<td valign="top">');
	write('<input class="textfieldfont" name="' + sGroupName + '.natLangTitle" id="natLangTitle" fmb="Y" size=9 maxlength=5 hotKeyId="search9">');
	write('&nbsp;');
	write('<a id="sLnk12" target=_self href="javascript:showRefCode(objForm.natLangTitle,45,\'N\',\'F\')">');
	write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search9"></img></a>');
	write('<br>');
	write('<input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.natLangName" id="natLangName" fmb="Y" size=70 maxlength=80>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td colspan="5" class="rowspacing"><spacer type=block height=1 width=1></spacer></td>');
	write('</tr>');
	if(dualFlg=="Y"){
	write('<tr valign="middle" class="subhdrbg">');
	write('<td colspan="5" class="subhdr"> ' + jspResArr.get("FLT021047") + '</td>');
	write('<td colspan="3" align="right" valign="middle">&nbsp;&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td colspan="5" class="rowspacing"><spacer type=block height=1 width=1></spacer></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000012") + '<script>setMandatory("' + generaldetailsProps.get("alt1_acctName_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont"  name="' + sGroupName + '.alt1_acctName" id="alt1_acctName" fmb="Y" SIZE="35" MAXLENGTH="80">');
	write('</td>');
	write('<td class="columnwidth"><spacer type="block" width="1" height="1"></td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000013") + '<script>setMandatory("' + generaldetailsProps.get("alt1_acctShortName_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'general_details\',this);" onBlur="javascript:return custom_ONBLUR(\'general_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.alt1_acctShortName" id="alt1_acctShortName" fmb="Y" SIZE="18" MAXLENGTH="10">');
	write('</td>');
	write('</tr>');
	}
	write('<tr>');
	write('<td colspan="5" class="rowspacingbottom"></td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</div>');

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
	if(bRefInq=="true" || sTmplMode=='I' || sTmplFuncCode=='I'){
	write('<input type="button" class="button" id="Back" name="Back" value="' + jspResArr.get("FLT001166") + '" onclick=\'javascript:return general_details_ONCLICK24(this);\' / hotKeyId="Go" >');
	}else{
	if(bShowSubmit=="true"){
	write('<input type="button" class="button" id="Submit" name="Submit" value="' + jspResArr.get("FLT000193") + '" onclick=\'javascript:return general_details_ONCLICK25(this,"Submit");\' / hotKeyId="Submit" >');
	}if(bShowSaveTemplate=="true"){
	write('<input type="button" style={width:150} class="button" id="SaveTemplate" name="SaveTemplate" value="' + jspResArr.get("FLT003326") + '" onClick=\'javascript:return general_details_ONCLICK26(this,"SaveTemplate");\' />');
	}if(bShowValidate=="true"){
	write('<input type="button" class="button" id="Validate" name="Validate" value="' + jspResArr.get("FLT000194") + '" onclick=\'javascript:return general_details_ONCLICK27(this,"Validate");\' / hotKeyId="Validate" >');
	}if(bShowAccept=="true"){
	write('<input type="button" class="button" id="AcceptTmpl" name="AcceptTmpl" value="' + jspResArr.get("FLT000191") + '" onclick=\'javascript:return general_details_ONCLICK28(this,"AcceptTmpl");\' / hotKeyId="Go" >');
	}if(bShowDelete=="true"){
	write('<input type="button" class="button" id="Delete" name="Delete" value="' + jspResArr.get("FLT000317") + '" onClick=\'javascript:return general_details_ONCLICK29(this,"Delete");\' />');
	}if(bShowBack=="true"){
	write('<input type="button" class="button" name="Back" id="Back" value="' + jspResArr.get("FLT000192") + '" onclick=\'javascript:return general_details_ONCLICK30(this);\' / hotKeyId="Cancel" >');
	}
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
} //End function

function fnPopulateControlValues()
{
	var frm = document.forms[0];

	frm.acctName.value = acctName;
	frm.acctShortName.value = acctShortName;
	frm.acctOpenDate.value = acctOpenDate;
	frm.productType.value = productType;
	frm.chargeLvlCode.value = chargeLvlCode;
	frm.chargeLvlDesc.value = chargeLvlDesc;
	frm.locationCode.value = locationCode;
	frm.locationDesc.value = locationDesc;
	frm.acctManager.value = acctManager;
	frm.acctMgrName.value = acctMgrName;
	frm.cashXpnLimitDr.value = cashXpnLimitDr;
	frm.cashXpnLimitCr.value = cashXpnLimitCr;
	frm.clgXpnLimitDr.value = clgXpnLimitDr;
	frm.clgXpnLimitCr.value = clgXpnLimitCr;
	frm.xferXpnLimitDr.value = xferXpnLimitDr;
	frm.xferXpnLimitCr.value = xferXpnLimitCr;
	frm.acctRptCode.value = acctRptCode;
	frm.ledgerNo.value = ledgerNo;
	frm.remarks.value = remarks;
	frm.staffId.value = staffId;
	frm.relativeStaffId.value = relativeStaffId;
	frm.pbPsFlg.value = pbPsFlg;
	frm.pbPsFreqType.value = pbPsFreqType;
	frm.pbPsFreqWeek.value = pbPsFreqWeek;
	frm.pbPsFreqDay.value = pbPsFreqDay;
	frm.pbPsFreqStartDD.value = pbPsFreqStartDD;
	frm.pbPsFreqHldyStat.value = pbPsFreqHldyStat;
	frm.pbPsFreqCalBase.value = pbPsFreqCalBase;
	frm.prefCalBase.value = prefCalBase;
	frm.addtnlCalBase.value = addtnlCalBase;
	frm.despatchMode.value = despatchMode;
	frm.modeOfOperCode.value = modeOfOperCode;
	frm.modeOfOperDesc.value = modeOfOperDesc;
	frm.nextPrntDate.value = nextPrntDate;
	frm.psAtRelPartyFlg.value = psAtRelPartyFlg;
	frm.contactPhNum.value = contactPhNum;
	frm.natLangCode.value = natLangCode;
	frm.natLangDesc.value = natLangDesc;
	frm.natLangTitle.value = natLangTitle;
	frm.natLangName.value = natLangName;
	frm.collectCharges.value = collectCharges;
	frm.turoverDtls.value = turoverDtls;
	frm.allowSweep.value = allowSweep;
	frm.localCalendar.value = localCalendar;
	frm.relativeToStaff.value = relativeToStaff;
	frm.ecsEnabled.value = ecsEnabled;
	frm.applicationRefId.value = applicationRefId;
	frm.securedFlg.value = securedFlg;
	frm.chnlLvlCode.value = chnlLvlCode;
	frm.chnlLvlCodeDesc.value = chnlLvlCodeDesc;
	frm.acctMgrAtAcct.value = acctMgrAtAcct;
	frm.acctMgrAtAcctName.value = acctMgrAtAcctName;
	if ((sReferralMode == 'I') || (sReferralMode == 'S')){
		fnDisableFormDataControls('V',frm,0);
	}
}


function general_details_ONKEYDOWN1(obj,p1)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	if ((retVal = fnKeyDownProcessor(p1)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONKEYUP2(obj,p1)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONKEYUP') == false) { 
		return false;
	}
	if ((retVal = fnKeyUpProcessor(p1)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONKEYUP') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONLOAD3(obj,p1)
{
	var retVal = "";
	var frmObj = document.forms[0];
	if (pre_ONLOAD('general_details',obj) == false) { 
		return false;
	}
	if ((retVal = fnOnLoad()) == false) {
		return false;
	}
	if ((retVal = fnAssignDateOnLoad(p1)) == false) {
		return false;
	}
	fnPopUpExceptionWindow(frmObj.actionCode);
	if (post_ONLOAD('general_details',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCLICK4(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnToggleTextDisplay(p1,p2)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCLICK5(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnToggleTextDisplay(p1,p2)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCHANGE6(obj,p1)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = clearDescField(p1)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCHANGE7(obj,p1)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = clearDescField(p1)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCHANGE8(obj,p1)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = clearDescField(p1)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCHANGE9(obj,p1)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = clearDescField(p1)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONBLUR10(obj,p1,p2,p3,p4)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = newformatAmt(p1,p2,p3,p4)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONBLUR11(obj,p1,p2,p3,p4)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = newformatAmt(p1,p2,p3,p4)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONBLUR12(obj,p1,p2,p3,p4)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = newformatAmt(p1,p2,p3,p4)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONBLUR13(obj,p1,p2,p3,p4)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = newformatAmt(p1,p2,p3,p4)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONBLUR14(obj,p1,p2,p3,p4)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = newformatAmt(p1,p2,p3,p4)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONBLUR15(obj,p1,p2,p3,p4)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = newformatAmt(p1,p2,p3,p4)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONBLUR16(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = fnValidateTextArea(p1,p2)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONKEYDOWN17(obj,p1)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	if ((retVal = suppressEnterKey(p1)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCHANGE18(obj)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnOnChangeMain()) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCHANGE19(obj,p1)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = clearDescField(p1)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCLICK20(obj,p1)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnSetCheckboxFld(p1)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCLICK21(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnToggleTextDisplay(p1,p2)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCLICK22(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnToggleTextDisplay(p1,p2)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCHANGE23(obj,p1)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = clearDescField(p1)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCLICK24(obj)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnBack()) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCLICK25(obj,p1)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = validateGenDetForm(p1)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCLICK26(obj,p1)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = validateGenDetForm(p1)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCLICK27(obj,p1)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = validateGenDetForm(p1)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCLICK28(obj,p1)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = validateGenDetForm(p1)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCLICK29(obj,p1)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = validateGenDetForm(p1)) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function general_details_ONCLICK30(obj)
{
	var retVal = "";
	if (preEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnBack()) == false) {
		return false;
	}
	if (postEventCall('general_details',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function writePassbookStatement()
{
with(document) {
write('<OPTION selected VALUE="">'+jspResArr.get("FLT012410")+'</OPTION>');
write('<OPTION VALUE="B">'+jspResArr.get("FLT012018")+'</OPTION>');
write('<OPTION VALUE="N">'+jspResArr.get("FLT013288")+'</OPTION>');
write('<OPTION VALUE="P">'+jspResArr.get("FLT013344")+'</OPTION>');
write('<OPTION VALUE="S">'+jspResArr.get("FLT002801")+'</OPTION>');

}
}


function writeprefCalendarBase()
{
with(document) {
write('<OPTION VALUE="">'+jspResArr.get("FLT012410")+'</OPTION>');
write('<OPTION VALUE="00">'+jspResArr.get("FLT019695")+'</OPTION>');
write('<OPTION VALUE="01">'+jspResArr.get("FLT019696")+'</OPTION>');
write('<OPTION VALUE="02">'+jspResArr.get("FLT020077")+'</OPTION>');

}
}

//Functions added for MMPP menu

function writeFrequencyType()
{
with(document) {
write('<OPTION VALUE="">'+jspResArr.get("FLT012410")+'</OPTION>');
write('<OPTION VALUE="D">'+jspResArr.get("FLT012545")+'</OPTION>');
write('<OPTION VALUE="F">'+jspResArr.get("FLT012652")+'</OPTION>');
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


function writeDespatchMode()
{
with(document) {
write('<OPTION selected VALUE="">'+jspResArr.get("FLT012410")+'</OPTION>');
write('<OPTION VALUE="A">'+jspResArr.get("FLT011966")+'</OPTION>');
write('<OPTION VALUE="B">'+jspResArr.get("FLT012035")+'</OPTION>');
write('<OPTION VALUE="C">'+jspResArr.get("FLT013189")+'</OPTION>');
write('<OPTION VALUE="D">'+jspResArr.get("FLT012544")+'</OPTION>');
write('<OPTION VALUE="E">'+jspResArr.get("FLT012600")+'</OPTION>');
write('<OPTION VALUE="N">'+jspResArr.get("FLT012726")+'</OPTION>');
write('<OPTION VALUE="P">'+jspResArr.get("FLT013332")+'</OPTION>');
write('<OPTION VALUE="Q">'+jspResArr.get("FLT012855")+'</OPTION>');
write('<OPTION VALUE="S">'+jspResArr.get("FLT013009")+'</OPTION>');
}
}
//ebl 359816 start

function showModuleList(){
	var ObjForm = document.forms[0];
	var inputNameValues = "acctMgrAtAcct|"+ObjForm.acctMgrAtAcct.value;
    var outputNameValues = "acctMgrAtAcct|salutation|firstname|middlename|lastname|gender";
	var scriptName = "b_acctmngrlst.scr";
	var listHeading = "Account Manager";
    var colHeader = "Login id|Salutation|Firstname|Middlename|Lastname|Gender";
    var retVal = appFnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true)
}


function general_details_pre_ONLOAD(obj)
{


      //alert("hello onload"); 
	  getFieldsFromCustomData("acctMgrAtAcct"); 

        return true;
}

function general_details_pre_ONCLICK(obj)
{


      //alert("hello on click");
      setFieldsToCustomData("acctMgrAtAcct"); 

        return true;
}

//ebl 359816 end
