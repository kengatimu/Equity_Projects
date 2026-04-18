function printBlock()
{
	writeCustomHeader("cpenal_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT648046") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + funcCode + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT648001") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + acctId + '</label>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<br />');
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
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="17" height="17" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr id="R1">');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT648049") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.acctName" id="acctName"  fdt="String" ' + cpenalProps.get("acctName_ENABLED") + ' style="width: 175px;">');
	write('</td>');
	write('<td class="columnwidth">  </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT648050") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.acctCrncyCode" id="acctCrncyCode"  fdt="String" ' + cpenalProps.get("acctCrncyCode_ENABLED") + ' style="width: 175px;">');
	write('</td>');
	write('</tr>');
	write('<tr id="R2">');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT648002") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.solId" id="solId"  fdt="String" ' + cpenalProps.get("solId_ENABLED") + ' style="width: 175px;">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT648059") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.pAccrAmtDr" id="pAccrAmtDr"  fdt="String" ' + cpenalProps.get("pAccrAmtDr_ENABLED") + ' style="width: 175px;">');
	write('</td>');
	write('</tr>');
	write('<tr id="R3">');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT648060") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.pAccrUpToDateDr" id="pAccrUpToDateDr"  fdt="String" ' + cpenalProps.get("pAccrUpToDateDr_ENABLED") + ' style="width: 175px;">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT648061") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.pApplUpToDateDr" id="pApplUpToDateDr"  fdt="String" ' + cpenalProps.get("pApplUpToDateDr_ENABLED") + ' style="width: 175px;">');
	write('</td>');
	write('</tr>');
	write('<tr id="R4">');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT648062") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.pApplAmtDr" id="pApplAmtDr"  fdt="String" ' + cpenalProps.get("pApplAmtDr_ENABLED") + ' style="width: 175px;">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT648063") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.totWaivedOffAmt" id="totWaivedOffAmt"  fdt="String" ' + cpenalProps.get("totWaivedOffAmt_ENABLED") + ' style="width: 175px;">');
	write('</td>');
	write('</tr>');
	write('<tr id="R5">');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT648064") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.lastWaivedOffDate" id="lastWaivedOffDate"  fdt="String" ' + cpenalProps.get("lastWaivedOffDate_ENABLED") + ' style="width: 175px;">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td id="L1" class="textlabel"> ' + jspResArr.get("FLT648057") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.addlWavingOffAmt" id="addlWavingOffAmt"  fdt="String" ' + cpenalProps.get("addlWavingOffAmt_ENABLED") + ' style="width: 175px;">');
	write('</td>');
	write('</tr>');
	write('<tr id="R6">');
	write('<td class="textlabel" id = "L2" style="height: 15px">' + jspResArr.get("FLT648058") + '</td>');
	write('<td class="textfield">');
	write('<textarea name="' + subGroupName + '.waivingOffReason" id="waivingOffReason"  fdt="String" ' + cpenalProps.get("waivingOffReason_ENABLED") + ' class="textfieldfont" style="height: 57px; width: 175px"></textarea>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"></td>');
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
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return cpenal_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return cpenal_det_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return cpenal_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
	}else{
	write('<div class="ctable">');
	write('<input class="button" type="button" id="Back" value="'+jspResArr.get("FLT026526")+ '" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	initFocusHandler();

	pre_ONLOAD('cpenal_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormDataControls('V',ObjForm,0);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	functionChange(this);
	post_ONLOAD('cpenal_det',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.acctName.value = acctName;
	ObjForm.acctCrncyCode.value = acctCrncyCode;
	ObjForm.solId.value = solId;
	ObjForm.pAccrAmtDr.value = pAccrAmtDr;
	ObjForm.pAccrUpToDateDr.value = pAccrUpToDateDr;
	ObjForm.pApplUpToDateDr.value = pApplUpToDateDr;
	ObjForm.pApplAmtDr.value = pApplAmtDr;
	ObjForm.totWaivedOffAmt.value = totWaivedOffAmt;
	ObjForm.lastWaivedOffDate.value = lastWaivedOffDate;
	ObjForm.addlWavingOffAmt.value = addlWavingOffAmt;
	ObjForm.waivingOffReason.value = waivingOffReason;
}


function cpenal_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cpenal_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cpenal_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cpenal_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('cpenal_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cpenal_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cpenal_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cpenal_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cpenal_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
