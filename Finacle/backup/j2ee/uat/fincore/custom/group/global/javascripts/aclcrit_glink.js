// Generated from spec file 


function printBlock1()
{
	writeHeader("aclcrit");
	with (document) {
	write('<center>');
	write('<input type="hidden" name="submitform" value="">');
	write('<input type="hidden" name="pagename" value="aclcrit">');
	write('<input type="hidden" name="tempAcctId" id="tempAcctId" value="aclcrit">');
	write('<input type="hidden" name="' + group + '.schmType" id="schmType" value="">');
	write('<table class="ctable" width="100%" border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">');
	if (menuType==INQUIRY)
	write('' + jspResArr.get("FLT017338") + '&nbsp;');
	else
	write('' + jspResArr.get("FLT002525") + '&nbsp;');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</center>');

	} 
} //End function

function printBlock2()
{
	with (document) {
	write('<center>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellspacing="0" cellpadding="0">');
	write('<tr >');
	write('<td valign="Top">');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');
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
	write('<a id="sLnk5" href="javascript:showHelpFile(\'aclcrit_help.htm\');">');
	write('<img align="right" class="img" src="../Renderer/images/' + applangcode + '/help.gif" border="0" hotKeyId="finHelp">');
	write('</img></a></td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr class="innertabletop">');
	write('<td class="textlabel">' + jspResArr.get("FLT000360") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input type="radio" id="operation" name="' + group + '.operation" value="S" fmnd="Y" onClick="javascript:return aclcrit_ONCLICK4(this);">&nbsp;' + jspResArr.get("FLT000306") + '');
	write('<input type="radio" id="operation" name="' + group + '.operation" value="D" onClick="javascript:return aclcrit_ONCLICK5(this);">');
	write('&nbsp;' + jspResArr.get("FLT000345") + '</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">&nbsp;</td>');
	write('<td class="textfielddisplaylabel">&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000204") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<select class="listboxfont" id="funcCode" fmnd="Y" name="' + group + '.funcCode" onChange="javascript:return aclcrit_ONCHANGE6(this);">');
	if (menuType==INQUIRY)
	writeComboFunction("writeInquiryFuncCode");
	else
	write('<script>writeComboFunction("writeAclhmFuncCodes");</script>');
	write('</select></td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">&nbsp;</td>');
	write('<td class="textfielddisplaylabel">&nbsp;</td>');
	write('</tr>');
	write('<tr class="innertabletop">');
	write('<td class="textlabel">' + jspResArr.get("FLT000265") + '<script>setMandatory("Y");</script></td>');
	write('<td td colspan="4" class="textfield">');
	write('<input onBlur="javascript:return custom_ONBLUR(\'aclcrit\',this);" type="text" id="acctId" name="' + group + '.acctId" fmnd="Y" size="28" maxlength="16" class="textfieldfont" fdt="accountid" onChange="javascript:return aclcrit_ONCHANGE7(this,this,\'acctName\',\'solId\',\'crncyCode\',false,\'VALCUSTACCTID\',document.forms[0].funcCode);" hotKeyId="search1">&nbsp;');
	write('<a target=_self id="sLnk1" href="javascript:fnGetAcctIdList(document.forms[0].funcCode)">');
	write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search1"></img></a>');
	write('&nbsp;');
	write('<input class="label" name="' + group + '.crncyCode" id="crncyCode" value="" maxlength=3 size="3" fds="Y" disabled>');
	write('<input class="label" name="' + group + '.solId" id="solId" value="" maxlength=8 size="8" fds="Y" disabled>');
	write('<input class="label" name="' + group + '.acctName" id="acctName" value="" maxlength=30 size="30" fds="Y" disabled>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT001447") + '');
	write('<script>setMandatory("' + aclhmProps.get("templateId_MANDATORY") + '");</script></td>');
	write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'aclcrit\',this);" type="text" class="textfieldfont" id="templateId" name="' + group + '.templateId" fmnd="' + aclhmProps.get("templateId_MANDATORY") + '" size="20" maxlength="25" ' + aclhmProps.get("templateId_ENABLED") + ' onChange="javascript:return aclcrit_ONCHANGE8(this);" hotKeyId="search3">&nbsp;');
	write('<a id="sLnk2" target=_self href="Javascript:showGtmplSearcher()">');
	write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId');
	write('="search3"></img></a>');
	write('<input class="label" name="' + group + '.templateType" id="templateType" fds="Y" size=8 disabled>');
	write('</td>');
	write('<tr>');
	write('<tr class="rowspacingbottom">');
	write('<td colspan="5"><spacer type="block" height="1" width="1"></spacer></td>');
	write('</tr>');
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
	write('</span>');
	write('</center>');

	} 
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
	write('<input type="button" id="Go" name="Go" value="' + jspResArr.get("FLT004977") + '" class="button" maxlength="10" onClick="javascript:return aclcrit_ONCLICK9(this,this);" hotKeyId="Go" >');
	write('<input type="button" id="Clear" name="Clear" value="' + jspResArr.get("FLT001439") + '" class="button" maxlength="10" onClick="javascript:return aclcrit_ONCLICK10(this,this);">');
	if (eval(isCalledMenu) !=undefined && isCalledMenu)
	{
	write('<input type="button" name="backToParent" class="button" onClick="javascript:return aclcrit_ONCLICK11(this,this);" id="backToParent" value="' + jspResArr.get("FLT010756") + '">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
} //End function

function fnPopulateControlValues()
{
	var frm = document.forms[0];

	frm.funcCode.value = funcCode;
	frm.acctId.value = acctId;
	frm.solId.value = solId;
	frm.crncyCode.value = crncyCode;
	frm.acctName.value = acctName;
	frm.templateId.value = templateId;
	if ((sReferralMode == 'I') || (sReferralMode == 'S')){
		fnDisableFormDataControls('V',frm,0);
	}
}


function aclcrit_ONKEYDOWN1(obj,p1)
{
	var retVal = "";
	if (preEventCall('aclcrit',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	if (preEventCallForLocale('aclcrit',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	if ((retVal = fnKeyDownProcessor(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('aclcrit',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	if (postEventCall('aclcrit',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function aclcrit_ONKEYUP2(obj,p1)
{
	var retVal = "";
	if (preEventCall('aclcrit',obj,'ONKEYUP') == false) { 
		return false;
	}
	if (preEventCallForLocale('aclcrit',obj,'ONKEYUP') == false) { 
		return false;
	}
	if ((retVal = fnKeyUpProcessor(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('aclcrit',obj,'ONKEYUP') == false) { 
		return false;
	}
	if (postEventCall('aclcrit',obj,'ONKEYUP') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function aclcrit_ONLOAD3(obj)
{
	var retVal = "";
	var frmObj = document.forms[0];
	if (pre_ONLOAD('aclcrit',obj) == false) { 
		return false;
	}
	if (preEventCallForLocale('aclcrit',obj,'ONLOAD') == false) { 
		return false;
	}
	if ((retVal = fnOnLoad()) == false) {
		return false;
	}
	if (postEventCallForLocale('aclcrit',obj,'ONLOAD') == false) { 
		return false;
	}
	fnPopUpExceptionWindow(frmObj.actionCode);
	if (post_ONLOAD('aclcrit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function aclcrit_ONCLICK4(obj)
{
	var retVal = "";
	if (preEventCall('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnProtectFuncCode()) == false) {
		return false;
	}
	if (postEventCallForLocale('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function aclcrit_ONCLICK5(obj)
{
	var retVal = "";
	if (preEventCall('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnProtectFuncCode()) == false) {
		return false;
	}
	if (postEventCallForLocale('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function aclcrit_ONCHANGE6(obj)
{
	var retVal = "";
	if (preEventCall('aclcrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('aclcrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = disableFld()) == false) {
		return false;
	}
	if (postEventCallForLocale('aclcrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('aclcrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function aclcrit_ONCHANGE7(obj,p1,p2,p3,p4,p5,p6,p7)
{
	var retVal = "";
	if (preEventCall('aclcrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('aclcrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fetchAcctDtls(p1,p2,p3,p4,p5,p6,p7)) == false) {
		return false;
	}
	if (postEventCallForLocale('aclcrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('aclcrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function aclcrit_ONCHANGE8(obj)
{
	var retVal = "";
	if (preEventCall('aclcrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('aclcrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnGetTemplateData()) == false) {
		return false;
	}
	if (postEventCallForLocale('aclcrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('aclcrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function aclcrit_ONCLICK9(obj,p1)
{
	var retVal = "";
	if (preEventCall('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function aclcrit_ONCLICK10(obj,p1)
{
	var retVal = "";
	if (preEventCall('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function aclcrit_ONCLICK11(obj,p1)
{
	var retVal = "";
	if (preEventCall('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('aclcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function writeInquiryFuncCode()
{
with(document){
write('<OPTION selected Value="">'+jspResArr.get("FLT012410")+'</OPTION>');
write('<OPTION VALUE="I">'+jspResArr.get("FLT012159")+'</OPTION>');
}
}


function writeAclhmFuncCodes()
{
with(document) {
write('<OPTION VALUE="">'+jspResArr.get("FLT012410")+'</OPTION>');
write('<OPTION VALUE="D">'+jspResArr.get("FLT013215")+'</OPTION>');
write('<OPTION VALUE="I">'+jspResArr.get("FLT012159")+'</OPTION>');
write('<OPTION VALUE="M">'+jspResArr.get("FLT012350")+'</OPTION>');
write('<OPTION VALUE="V">'+jspResArr.get("FLT013170")+'</OPTION>');
write('<OPTION VALUE="W">'+jspResArr.get("FLT012385")+'</OPTION>');
write('<OPTION VALUE="X">'+jspResArr.get("FLT012392")+'</OPTION>');
write('<OPTION VALUE="T">'+jspResArr.get("FLT020990")+'</OPTION>');
}
}


