function printBlock()
{
	writeCustomHeader("hdenom_crit");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031734") + '</td>');
	write('</tr>');
	write('</table>');
	write('<!-- DETAILSBLOCK-BEGIN -->');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');
	write('<tr>');
	write('<td height="25" colspan="5" align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right">');
	//write('<a href="javascript:getHelpFile(\'hdenom_crit\');" id="sLnk1">');
	write('<a href="javascript:showHelpFile(\'hdenom_crit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT112254") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode"  fmnd="' + hdenomProps.get("funcCode_MANDATORY") + '" ' + hdenomProps.get("funcCode_ENABLED") + ' class="listboxfont">');
	write('<OPTION VALUE="">' + jspResArr.get("FLT700022") + '</OPTION>');
	write('<OPTION VALUE="A">' + jspResArr.get("FLT031595") + '</OPTION>');
	write('<OPTION VALUE="I">' + jspResArr.get("FLT034011") + '</OPTION>');
	write('<OPTION VALUE="M">' + jspResArr.get("FLT031596") + '</OPTION>');
	write('<OPTION VALUE="D">' + jspResArr.get("FLT034012") + '</OPTION>');
	write('<OPTION VALUE="U">' + jspResArr.get("FLT031736") + '</OPTION>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT030604") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.crncyCode" id="crncyCode"  fmnd="' + hdenomProps.get("crncyCode_MANDATORY") + '" ' + hdenomProps.get("crncyCode_ENABLED") + ' size="5" maxlength="5"	onChange="javascript:return hdenom_crit_ONCHANGE1(this);">&nbsp;');
	write('<a href="javascript:fnShowCrncyCodeSearcher()">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px"> </td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.crncyName" id="crncyName" ' + hdenomProps.get("crncyName_ENABLED") + ' style="visibility:hidden">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.decimalPointAllow" id="decimalPointAllow" ' + hdenomProps.get("decimalPointAllow_ENABLED") + ' style="visibility:hidden">');
	write('</td>');
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
	write('<!-- DETAILSBLOCK-END -->');
	write('</td>');
	write('</tr>');
	write('</table>');
	} //End with()
} //End function

function printFooterBlock()
{
	with (document) {
	if ((sReferralMode == 'I')||(sReferralMode == 'S')){
	write('<div align="left" class="ctable">');
	if (sReferralMode == 'S'){
	write('<input type="button" class="Button" id="Submit" value="'+jspResArr.get("FLT000193")+ '" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT027575")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return hdenom_crit_ONCLICK2(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return hdenom_crit_ONCLICK3(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('hdenom_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('hdenom_crit',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	if (fnIsNull(ObjForm.funcCode.value))
	{
		alert(jspErrResArr.get("FAT000924"));
		ObjForm.funcCode.focus();
		return false;
	}
	if (fnIsNull(ObjForm.crncyCode.value))
	{
		alert(jspErrResArr.get("FAT000924"));
		ObjForm.crncyCode.focus();
		return false;
	}
	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.funcCode.value = funcCode;
	ObjForm.crncyCode.value = crncyCode;
	ObjForm.crncyName.value = crncyName;
	ObjForm.decimalPointAllow.value = decimalPointAllow;
}


function hdenom_crit_ONCHANGE1(obj)
{
	var retVal = "";
	if (preEventCall('hdenom_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnCurrencyOnchange()) == false) {
		return false;
	}
	if (postEventCall('hdenom_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hdenom_crit_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('hdenom_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('hdenom_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hdenom_crit_ONCLICK3(obj)
{
	var retVal = "";
	if (preEventCall('hdenom_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('hdenom_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
