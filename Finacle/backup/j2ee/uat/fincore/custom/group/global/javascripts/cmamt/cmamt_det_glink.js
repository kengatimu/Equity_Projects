function printBlock()
{
	writeCustomHeader("cmamt_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031701") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%" style="width: 471px">');
	write('<tr>');
	write('<td class="textlabel" style="width: 52px">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfielddisplaylabel" style="width: 144px">');
	write('<label id="compField">' + funcCode + '</label>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<br />');
	write('<!-- DETAILSBLOCK-BEGIN -->');
	write('<table border="0" cellpadding="0" cellspacing="0" width="50%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td style="height: 250px">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');
	write('<tr>');
	write('<td height="25" colspan="20" align="right">');
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
	write('<tr>');
	write('<td class="textlabel" style="height: 9px">' + jspResArr.get("FLT031732") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.Merchantsname" id="Merchantsname" ' + cmamtProps.get("Merchantsname_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 9px">' + jspResArr.get("FLT031733") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.TerminalPosId" id="TerminalPosId" ' + cmamtProps.get("TerminalPosId_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 9px">' + jspResArr.get("FLT031734") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.Purchasepayable" id="Purchasepayable" ' + cmamtProps.get("Purchasepayable_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 9px">' + jspResArr.get("FLT031735") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.Cashbackpayable" id="Cashbackpayable" ' + cmamtProps.get("Cashbackpayable_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 9px">' + jspResArr.get("FLT031736") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.Cashbackcommac" id="Cashbackcommac" ' + cmamtProps.get("Cashbackcommac_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 9px">' + jspResArr.get("FLT031737") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.Settlement" id="Settlement" ' + cmamtProps.get("Settlement_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 9px">' + jspResArr.get("FLT031738") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.Cashbackcomm" id="Cashbackcomm" ' + cmamtProps.get("Cashbackcomm_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 9px">' + jspResArr.get("FLT031739") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.Purchasecomm" id="Purchasecomm" ' + cmamtProps.get("Purchasecomm_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 9px">' + jspResArr.get("FLT031740") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.Channeld" id="Channeld" ' + cmamtProps.get("Channeld_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 9px">' + jspResArr.get("FLT031741") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.Confirm" id="Confirm" ' + cmamtProps.get("Confirm_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr> </tr>');
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
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return cmamt_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return cmamt_det_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return cmamt_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
	}else{
	write('<div class="ctable">');
	write('<input class="button" type="button" id="Submit" value="'+jspResArr.get("FLT026526")+ '" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('cmamt_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		//fnDisableFormDataControls('V',ObjForm,0);
		document.forms[0].TerminalPosId.enabled=true;
		document.forms[0].Confirm.enabled=true;
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cmamt_det',this);

	
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.Merchantsname.value = Merchantsname;
	ObjForm.TerminalPosId.value = TerminalPosId;
	ObjForm.Purchasepayable.value = Purchasepayable;
	ObjForm.Cashbackpayable.value = Cashbackpayable;
	ObjForm.Cashbackcomm.value = Cashbackcomm;
	ObjForm.Cashbackcommac.value = Cashbackcommac;
	ObjForm.Settlement.value = Settlement;
	ObjForm.Purchasecomm.value = Purchasecomm;
	ObjForm.Channeld.value = Channeld;
	ObjForm.Confirm.value = Confirm;
}


function cmamt_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cmamt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cmamt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cmamt_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('cmamt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValidateData(p1)) == false) {
		return false;
	}
	if (postEventCall('cmamt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cmamt_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cmamt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cmamt_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
