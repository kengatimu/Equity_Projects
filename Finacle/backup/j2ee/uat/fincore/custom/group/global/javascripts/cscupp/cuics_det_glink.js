function printBlock()
{
	writeCustomHeader("cuics_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">CREDIT LIMIT ROLE PROFILE MAINTENANCE</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel" > Function</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + funcCode + '</label>');
	write('</td>');
	write('<td class="textlabel" > Role Id</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + roleId + '</label>');
	write('</td>');
	write('<tr>');
	write('<td class="textlabel" > Currency  </td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + currency + '</label>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<br />');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td class="activetab3" width="100%"></td>');
	write('</tr>');
	write('</table>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop">');
	write('<tr>');
	write('<a href="javascript:showHelpFile(\'cuics_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026338") + '<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.trnsfrSolLm" id="trnsfrSolLm" ' + cuicsProps.get("trnsfrSolLm_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT026335") + '</td>');
	write('<td><input name="' + subGroupName + '.TrnsfrCrLm" id="TrnsfrCrLm" ' + cuicsProps.get("TrnsfrCrLm_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026334") + '</td>');
	write('<td><input name="' + subGroupName + '.cashCrLm" id="cashCrLm" ' + cuicsProps.get("cashCrLm_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	
	write('<td class="textlabel">' + jspResArr.get("FLT026337") + '</td>');
	write('<td><input name="' + subGroupName + '.cashSolLm" id="cashSolLm" ' + cuicsProps.get("cashSolLm_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('</tr>');
	
	write('<tr>');
	
	write('<td class="textlabel">' + jspResArr.get("FLT026339") + '</td>');
	write('<td><input name="' + subGroupName + '.clrnSolLm" id="clrnSolLm" ' + cuicsProps.get("clrnSolLm_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026336") + '</td>');
	write('<td><input name="' + subGroupName + '.ClrnCrLm" id="ClrnCrLm" ' + cuicsProps.get("ClrnCrLm_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('</tr>');
	write('</table></td>');
	write('</tr>');
	write('</table></td>');
	write('</tr>');
	write('</table></td>');
	write('</tr>');
	write('</table></td>');
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
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cuics_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	//write('<input name="Clear" type="button" class="button" onClick="javascript:return cuics_det_ONCLICK2(this);" id="Clear" value="Clear">');
	write('<input name="Cancel" type="button" class="button" onClick="javascript:return cuics_det_ONCLICK2(this);" id="Clear" value="Cancel">');
	}else{
	write('&nbsp;<input class="button" type="button" id="Back" value="OK" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('cuics_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}


//	fnPostOnLoad()
	post_ONLOAD('cuics_det',this);
//	document.forms[0].userID.disabled = true;
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.cashCrLm.value = cashCrLm;
	ObjForm.TrnsfrCrLm.value = TrnsfrCrLm;
	ObjForm.ClrnCrLm.value = ClrnCrLm;
	ObjForm.cashSolLm.value = cashSolLm;
	ObjForm.trnsfrSolLm.value = trnsfrSolLm;
	ObjForm.clrnSolLm.value = clrnSolLm;
	return true;
}


function cuics_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('cuics_det',obj) == false) { 
		return false;
	}


	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}

	if (post_ONCLICK('cuics_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;

}

function cuics_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cuics_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cuics_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function cuics_det_ONCLICK3(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cuics_det',obj) == false) { 
		return false;
	}
	if ((retVal = doSubmit()) == false) {
		return false;
	}
	if (post_ONCLICK('cuics_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
