function printBlock() {
	writeCustomHeader("ebrpt_crit");
	with (document){
	write('<input type="hidden" name="nextPage" id="nextPage">');
	write('<input type="hidden" name="ebrpt.funcCode" id="funcCode" value="M">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT648023") + '</td>');
	write('</tr>');
	write('</table>');
	write('<!-- DETAILSBLOCK-BEGIN -->');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
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
	write('<a href="javascript:showHelpFile(\'det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="17" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT648024") + '');
	write('<font color="red" size="3">*');
	write('</font>');
	write('</td>');
	write('<td class="textfield">');
write('<select name="' + subGroupName + '.rptModule" id="rptModule"  onchange="javascript:return fnPopulateDivision(this);" fdt="String" ' + ebrptProps.get("rptModule_ENABLED") + ' style="width: 218;">');
	write('<option value="">' + jspResArr.get("FLT648027") + '</option>');
	write('<option value="L">' + jspResArr.get("FLT648108") + '</option>');
	write('<option value="T">' + jspResArr.get("FLT548108") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT648107") + '');
	write('<font color="red" size="3">*');
	write('</font>');
	write('</td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.rptDiv" id="rptDiv"  fdt="String" ' + ebrptProps.get("rptDiv_ENABLED") + ' style="width: 218;">  </select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT004630") + '');
	write('<font color="red" size="3">*');
	write('</font>');
	write('</td>');
	write('<td class="textfield">');

	write('<input hotKeyId="search3" type="text" class="textfieldfont" name="' + subGroupName + '.rptName" id="rptName" onChange="javascript:return ebrpt_crit_ONCHANGE3(this);"  fdt="String" ' + ebrptProps.get("rptName_ENABLED") + '> &nbsp;');
	write('&nbsp;<a href="javascript:fnReportList()">');
	write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('<input id="reportDesc" name="reportDesc" style="width: 200;" type="text" disabled=true class="labelwithoutwidth" fdt="String">');
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

function printFooterBlock() {
	with (document) {
	if ((sReferralMode == 'I')||(sReferralMode == 'S')){
	write('<div align="left" class="ctable">');
	if (sReferralMode == 'S'){
	write('<input type="button" class="Button" id="Submit" value="'+jspResArr.get("FLT000193")+ '" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return ebrpt_crit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return ebrpt_crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad() {
	var ObjForm = document.forms[0];

	initFocusHandler();

	pre_ONLOAD('ebrpt_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('ebrpt_crit',this);
}

function fnCheckMandatoryFields() {
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() {
	var ObjForm = document.forms[0];
	ObjForm.rptModule.value = rptModule;
	ObjForm.rptDiv.value = rptDiv;
	ObjForm.rptName.value = rptName;
}


function ebrpt_crit_ONCLICK1(obj,p1) {
	var retVal = "";
	if (pre_ONCLICK('ebrpt_crit',obj) == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('ebrpt_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ebrpt_crit_ONCLICK2(obj) {
	var retVal = "";
	if (pre_ONCLICK('ebrpt_crit',obj) == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('ebrpt_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

