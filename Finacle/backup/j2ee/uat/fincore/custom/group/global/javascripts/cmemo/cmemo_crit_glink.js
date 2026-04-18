function printBlock()
{
	writeCustomHeader("cmemo_crit");
	with (document){
	write('<input type="hidden" name="cmemo.myIPAddress" id="myIPAddress">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td><table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">MEMO PAD MAINTENANCE </td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr class="innertabletop1">');
	write('<td colspan="5" align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right">');
	write('<a href="javascript:showHelpFile(\'cmemo_crit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0"></a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000004") + '<font color="red" size="2"> *</font></td>');
	write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + cmemoProps.get("funcCode_ENABLED") + ' class="textfieldfont" " onchange="javascript:fnDisableFields(this)">');
	write('<option value="">' + jspResArr.get("FLT000005") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT000006") + '</option>');
	write('<option value="M">' + jspResArr.get("FLT000007") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT000008") + '</option>');
	write('<option value="D">' + jspResArr.get("FLT000009") + '</option>');
	write('</select>');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000003") + '<font color="red" size="2"> *</font></td>');
	write('<td><input hotKeyId="search1"  name="' + subGroupName + '.custID" id="custID" ' + cmemoProps.get("custID_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('&nbsp;<a target=_self id="sLnk2"  href="Javascript:showCustId(document.forms[0].custID,\'ctrl\',\'F\',document.forms[0].custName)">');
	write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
	write('<input name="' + subGroupName + '.custName" id="custName" type="text" size="25" maxlength="25" readonly disabled class="label" >');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
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
	write('<input type="button" class="Button" id="Submit" value="SUBMIT" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="CANCEL" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input type="button" name="Accept" value="Go" class="button" id="Accept" onClick="javascript:return cmemo_crit_ONCLICK2(this,this);" hotKeyId="Go">');
	write('<input type="button" name="Clear" value="Clear" class="button" id="Clear" onClick="javascript:return cmemo_crit_ONCLICK3(this);">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];
	
	pre_ONLOAD('cmemo_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	post_ONLOAD('cmemo_crit',this);
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.custID.value = custID;
	ObjForm.funcCode.value = funcCode;
}


function cmemo_crit_ONCHANGE1(obj,p1)
{
	var retVal = "";
	if (pre_ONCHANGE('cmemo_crit',obj) == false) { 
		return false;
	}
	if ((retVal = validateUser(p1)) == false) {
		return false;
	}
	if (post_ONCHANGE('cmemo_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cmemo_crit_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('cmemo_crit',obj) == false) { 
		return false;
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('cmemo_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cmemo_crit_ONCLICK3(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cmemo_crit',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cmemo_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnDisableFields(obj) {
	fncode = document.forms[0].funcCode.value;
	if(fncode == 'D' || fncode == 'V' ){
		//document.forms[0].currency.disabled=true;
		//document.forms[0].roleId.disabled=true;
	}
	return true;
}
function fnValidateData() {
	return true;
}
