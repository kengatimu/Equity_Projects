function printBlock()
{
	writeCustomHeader("hcashxdet");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031830") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">  </td>');
	write('<td class="textfielddisplaylabel"> </td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">  </td>');
	write('<td class="textfielddisplaylabel"> </td>');
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
	write('<a href="javascript:getHelpFile(\'det\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT030604") + '</td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" size="30" class="textfieldfont" name="' + subGroupName + '.acctCrncy" id="acctCrncy" ' + hcashxProps.get("acctCrncy_ENABLED") + ' maxlength="3"	onChange="javascript:return hcashxdet_ONCHANGE1(this);">&nbsp;');
	write('<a href="javascript:fnShowCrncyCodeSearcher()">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.CashExchange" id="CashExchange" ' + hcashxProps.get("CashExchange_ENABLED") + '   style="Visibility:hidden">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031738") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" size="30" class="textfieldfont" name="' + subGroupName + '.receivedAmt" id="receivedAmt" ' + hcashxProps.get("receivedAmt_ENABLED") + ' maxlength="20"	onBlur="javascript:return hcashxdet_ONBLUR2(this);"" ">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.RetVal" id="RetVal" ' + hcashxProps.get("RetVal_ENABLED") + ' style="Visibility:hidden">');
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
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Accept" type="button" class="button"	onClick="javascript:return hcashxdet_ONCLICK3(this,this);"" value="' + jspResArr.get("FLT023614") + '" hotKeyId="Submit">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return hcashxdet_ONCLICK4(this);"">');
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

	pre_ONLOAD('hcashxdet',this);

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

	post_ONLOAD('hcashxdet',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.acctCrncy.value = acctCrncy;
	ObjForm.CashExchange.value = CashExchange;
	ObjForm.receivedAmt.value = receivedAmt;
	ObjForm.RetVal.value = RetVal;
}


function hcashxdet_ONCHANGE1(obj)
{
	var retVal = "";
	if (preEventCall('hcashxdet',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnvalidate_acctcrncy()) == false) {
		return false;
	}
	if (postEventCall('hcashxdet',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hcashxdet_ONBLUR2(obj)
{
	var retVal = "";
	if (preEventCall('hcashxdet',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = fnvalidate_received()) == false) {
		return false;
	}
	if (postEventCall('hcashxdet',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hcashxdet_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('hcashxdet',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('hcashxdet',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hcashxdet_ONCLICK4(obj)
{
	var retVal = "";
	if (preEventCall('hcashxdet',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('hcashxdet',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
