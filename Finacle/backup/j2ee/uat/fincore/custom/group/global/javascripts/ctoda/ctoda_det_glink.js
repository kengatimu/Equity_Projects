function printBlock()
{
	writeCustomHeader("ctoda_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031590") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT112254") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + fnGetFuncCodeDesc(funcCode) + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT112259") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + accNum + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT031592") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + availReqId + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfielddisplaylabel">  </td>');
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
	//write('<a href="javascript:getHelpFile(\'CTODA_det\');" id="sLnk1">');
	write('<a href="javascript:showHelpFile(\'CTODA_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031597") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.contractId" id="contractId" ' + ctodaProps.get("contractId_ENABLED") + ' size="16" maxlength="16">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031700") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.accCCY" id="accCCY" ' + ctodaProps.get("accCCY_ENABLED") + ' size="3" maxlength="3">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031606") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.accName" id="accName" ' + ctodaProps.get("accName_ENABLED") + ' size="80" maxlength="80">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031702") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.contractPeriodMM" id="contractPeriodMM" ' + ctodaProps.get("contractPeriodMM_ENABLED") + ' size="2" maxlength="2">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT031701") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" style="text-align: right" class="textfieldfont" name="' + subGroupName + '.maxAvailAmt" id="maxAvailAmt" ' + ctodaProps.get("maxAvailAmt_ENABLED") + ' size="23" maxlength="23">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT112263") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.totAvailedAmt" id="totAvailedAmt" ' + ctodaProps.get("totAvailedAmt_ENABLED") + ' size="30" maxlength="30" disabled>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031715") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input type="text" style="text-align: right" class="textfieldfont" name="' + subGroupName + '.availAmt" id="availAmt"  fmnd="' + ctodaProps.get("availAmt_MANDATORY") + '" ' + ctodaProps.get("availAmt_ENABLED") + ' size="23" maxlength="23"	onChange="javascript:return ctoda_det_ONCHANGE1(this);">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031732") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.availPeriodMM" id="availPeriodMM"  fmnd="' + ctodaProps.get("availPeriodMM_MANDATORY") + '" ' + ctodaProps.get("availPeriodMM_ENABLED") + ' size="2" maxlength="2"	onChange="javascript:return ctoda_det_ONCHANGE2(this);">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT031699") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" style="text-align: right" class="textfieldfont" name="' + subGroupName + '.chrgAmt" id="chrgAmt" ' + ctodaProps.get("chrgAmt_ENABLED") + ' size="23" maxlength="23">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031733") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" style="text-align: right" class="textfieldfont" name="' + subGroupName + '.netTodAmount" id="netTodAmount" ' + ctodaProps.get("netTodAmount_ENABLED") + ' size="23" maxlength="23">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT112261") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.remarks" id="remarks" ' + ctodaProps.get("remarks_ENABLED") + ' size="30" maxlength="30">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> ' + jspResArr.get("FLT112262") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.expDate" id="expDate" ' + ctodaProps.get("expDate_ENABLED") + ' size="30" maxlength="30" disabled>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px"> </td>');
	write('<td class="textfield"> </td>');
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
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return ctoda_det_ONCLICK3(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT027575") + '"	onClick="javascript:return ctoda_det_ONCLICK4(this,this.id);"" hotKeyId="Cancel">');
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

	pre_ONLOAD('ctoda_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		//fnDisableFormDataControls('V',ObjForm,0);
		fnDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('ctoda_det',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	if (fnIsNull(ObjForm.availAmt.value))
	{
		alert(jspErrResArr.get("FAT000924"));
		ObjForm.availAmt.focus();
		return false;
	}
	if (fnIsNull(ObjForm.availPeriodMM.value))
	{
		alert(jspErrResArr.get("FAT000924"));
		ObjForm.availPeriodMM.focus();
		return false;
	}
	return true;
}

function fnPopulateControlValues()
{
	var ObjForm = document.forms[0];

	ObjForm.contractId.value = contractId;
	ObjForm.accName.value = accName;
	ObjForm.accCCY.value = accCCY;
	ObjForm.maxAvailAmt.value = maxAvailAmt;
	ObjForm.contractPeriodMM.value = contractPeriodMM;
	ObjForm.availAmt.value = availAmt;
	ObjForm.availPeriodMM.value = availPeriodMM;
	ObjForm.chrgAmt.value = chrgAmt;
	ObjForm.netTodAmount.value = netTodAmount;
	ObjForm.remarks.value = remarks;
	ObjForm.expDate.value = expDate;
	ObjForm.totAvailedAmt.value = totAvailedAmt;
}


function ctoda_det_ONCHANGE1(obj)
{
	var retVal = "";
	if (preEventCall('ctoda_det',obj,'ONCHANGE') == false) {
		return false;
	}
	if ((retVal = fnAvailmentAmtOnchange()) == false) {
		return false;
	}
	if (postEventCall('ctoda_det',obj,'ONCHANGE') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ctoda_det_ONCHANGE2(obj)
{
	var retVal = "";
	if (preEventCall('ctoda_det',obj,'ONCHANGE') == false) {
		return false;
	}
	if ((retVal = fnAvailmentPeriodOnchange()) == false) {
		return false;
	}
	if (postEventCall('ctoda_det',obj,'ONCHANGE') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ctoda_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('ctoda_det',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('ctoda_det',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ctoda_det_ONCLICK4(obj,p1)
{
	var retVal = "";
	if (preEventCall('ctoda_det',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('ctoda_det',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
