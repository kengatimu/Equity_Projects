function printBlock()
{
	writeCustomHeader("ctoda_crit");
	with (document){
	//-------------CHNAGE FOR TO :361667-----------------------//
	write('<input type="hidden" name="nextPage" id="nextPage">');
	//-------------CHNAGE FOR TO :361667-----------------------//
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031590") + '</td>');
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
	//write('<a href="javascript:getHelpFile(\'CTODA_crit\');" id="sLnk1">');
	write('<a href="javascript:showHelpFile(\'CTODA_crit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT112254") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode"  fmnd="' + ctodaProps.get("funcCode_MANDATORY") + '" ' + ctodaProps.get("funcCode_ENABLED") + ' class="listboxfont"	onChange="javascript:return ctoda_crit_ONCHANGE1(this);">');
	write('<OPTION VALUE="">' + jspResArr.get("FLT700022") + '</OPTION>');
	write('<OPTION VALUE="A">' + jspResArr.get("FLT031595") + '</OPTION>');
	write('<OPTION VALUE="I">' + jspResArr.get("FLT034011") + '</OPTION>');
	write('<OPTION VALUE="M">' + jspResArr.get("FLT031596") + '</OPTION>');
	//-------CHANGES MADE FOR TO 370372 commenting the verify option in drop down-------
	//write('<OPTION VALUE="V">' + jspResArr.get("FLT031297") + '</OPTION>');
	//------------------CHANGES MADE FOR TO 370372 ---------------------------------
	write('<OPTION VALUE="X">' + jspResArr.get("FLT033219") + '</OPTION>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT112259") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.accNum" id="accNum"  fmnd="' + ctodaProps.get("accNum_MANDATORY") + '" ' + ctodaProps.get("accNum_ENABLED") + ' size="16" maxlength="16" onchange="javascript:return ctoda_ONCHANGE1(this,this,\'acctName\',\'acctSolId\',\'acctCrncy\',true,\'VALCUSTACCTID\');">&nbsp;');
	write('<a href="javascript:fnShowAccNum()" id="sLnk2">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16" />');
	write('</a>');
	write('<input type="text" name="acctCrncy" id="acctCrncy" size="3" maxlength="3"  class="label" readonly="readonly" disabled>');
	write('<input type="text" name="acctSolId" id="acctSolId" size="8" maxlength="8"  class="label" readonly="readonly" disabled>');
	write('<input type="text" name="acctName" id="acctName"  size="25" maxlength="25" class="label" readonly="readonly" disabled>');
	write('<br>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031592") + '</td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search2" type="text" class="textfieldfont" name="' + subGroupName + '.availReqId" id="availReqId" ' + ctodaProps.get("availReqId_ENABLED") + ' size="16" maxlength="16"	onChange="javascript:return ctoda_crit_ONCHANGE2(this);">&nbsp;');
	write('<a href="javascript:fnShowAvailmentReqId()" id="sLnk3" >');
	write('<img border="0" height="17" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
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
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return ctoda_crit_ONCLICK3(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return ctoda_crit_ONCLICK4(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];
	
	pre_ONLOAD('ctoda_crit',this);
	
	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}
	
	fnPopulateControlValues();
	
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	
	post_ONLOAD('ctoda_crit',this);
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
	if (fnIsNull(ObjForm.accNum.value))
	{
		alert(jspErrResArr.get("FAT000924"));
		ObjForm.accNum.focus();
		return false;
	}
	return true;
}

function fnPopulateControlValues()
{
	var ObjForm = document.forms[0];
	
	ObjForm.funcCode.value = funcCode;
	ObjForm.accNum.value = accNum;
	ObjForm.availReqId.value = availReqId;
}

function ctoda_crit_ONCHANGE1(obj)
{
	var retVal = "";
	if (preEventCall('ctoda_crit',obj,'ONCHANGE') == false) {
		return false;
	}
	if ((retVal = fnFunctionOnchange()) == false) {
		return false;
	}
	if (postEventCall('ctoda_crit',obj,'ONCHANGE') == false) {
		return false;
	}
	funcOnchange();
	return (retVal == undefined) ? true : retVal;
}

function ctoda_crit_ONCHANGE2(obj)
{
	var retVal = "";
	if (preEventCall('ctoda_crit',obj,'ONCHANGE') == false) {
		return false;
	}
	if ((retVal = fnLoadValues()) == false) {
		return false;
	}
	if (postEventCall('ctoda_crit',obj,'ONCHANGE') == false) {
		return false;
		
	}
		return (retVal == undefined) ? true : retVal;
}

function ctoda_crit_ONCLICK3(obj,p1)
{

	var retVal = "";
	if (preEventCall('ctoda_crit',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('ctoda_crit',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function ctoda_crit_ONCLICK4(obj)
{
	var retVal = "";
	if (preEventCall('ctoda_crit',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('ctoda_crit',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ctoda_ONCHANGE1(obj,p1,p2,p3,p4,p5,p6)
{
		if ((retVal = fetchAcctDtls(p1,p2,p3,p4,p5,p6)) == false)
        {
                return false;
        }
		if ((retVal = fnGetAvailReqId(this))== false)
        
             {
                return false;
        }   

}
