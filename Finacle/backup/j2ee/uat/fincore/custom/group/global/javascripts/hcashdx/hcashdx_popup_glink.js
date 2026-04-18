function printBlock()
{
	writeCustomHeader("hcashdx_popup");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">  </td>');
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
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FTT000072") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.currncy" id="currncy" ' + hcashdxProps.get("currncy_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031297") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.sysCalA" id="sysCalAmt" ' + hcashdxProps.get("sysCalAmt_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031309") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont"  name="' + subGroupName + '.usrEntAmt" id="usrEntAmt" ' + hcashdxProps.get("usrEntAmt_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031310") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.chrgPart" id="chrgPart" ' + hcashdxProps.get("chrgPart_ENABLED") + '>');
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
	write('<input type="button" class="Button" id="Submit" value="SUBMIT" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="CANCEL" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input id="Submit" type="button" name="Submit" value="Ok" class="button"	onClick="javascript:return hcashdx_popup_ONCLICK1(this,this);"" hotKeyId="Go">');
	write('<input id="Cancel" type="button" name="Cancel" value="Cancel" class="button" onClick="parent.window.close()" hotKeyId="Cancel">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];
	pre_ONLOAD('hcashdx_popup',this);
	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}
	
	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	if(isMod == "N")
	{
	   ObjForm.usrEntAmt.disabled = true;

	}
	
	post_ONLOAD('hcashdx_popup',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.currncy.value = currncy;
	ObjForm.sysCalAmt.value = sysCalAmt;
	ObjForm.usrEntAmt.value = usrEntAmt;
	ObjForm.chrgPart.value = chrgPart;
	ObjForm.currncy.disabled = true;
	ObjForm.sysCalAmt.disabled = true;
	ObjForm.chrgPart.disabled = true;


}


function hcashdx_popup_ONCLICK1(obj,p1)
{
	var retVal = "";

	if (pre_ONCLICK('hcashdx_popup',obj) == false) { 
		return false;
	}
	if ((retVal =  fnSubmitButtonClick(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('hcashdx_popup',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hcashdx_popup_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('hcashdx_popup',obj) == false) { 
		return false;
	}
	if ((retVal =  fnCancelButtonClick(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('hcashdx_popup',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
