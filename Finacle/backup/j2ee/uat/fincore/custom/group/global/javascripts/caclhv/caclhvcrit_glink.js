function printBlock()
{
	writeCustomHeader("caclhvcrit");
	with (document){
	write('<input type="hidden" id="fromDate" fdt="fdate" mneb1="N" vFldId="fromDate_ui" name="' + subGroupName + '.fromDate">');
	write('<input type="hidden" id="toDate" fdt="fdate" mneb1="N" vFldId="toDate_ui" name="' + subGroupName + '.toDate">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT025762") + '</td>');
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
	write('<a href="javascript:showHelpFile(\'crit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="17" height="17" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT006657") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode"  fdt="String" ' + caclhvProps.get("funcCode_ENABLED") + ' style="width: 218px;"  >');
	write('<option value="">' + jspResArr.get("FLT012929") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT012129") + '</option>');
	//write('<option value="M">' + jspResArr.get("FLT012308") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT011157") + '</option>');
	//write('<option value="D">' + jspResArr.get("FLT028094") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT007733") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input  hotKeyId="calender1"  type="text" class="textfieldfont" fdt="uidate"  mnebl="false" onBlur="javascript:return caclhvcrit_ONBLUR1(this,this,this);" name="' + subGroupName + '.fromDate_ui" id="fromDate_ui"  >');
	write('<a  href="javascript:openDate(document.forms[0].fromDate_ui,BODDate)"   id="sLnk2"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
	write('</a>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT007734") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input  hotKeyId="calender2"  type="text" class="textfieldfont" fdt="uidate"  mnebl="false" onBlur="javascript:return caclhvcrit_ONBLUR2(this,this,this);" name="' + subGroupName + '.toDate_ui" id="toDate_ui" >');
	write('<a  href="javascript:openDate(document.forms[0].toDate_ui,BODDate)"   id="sLnk3"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender2" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT648083") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.fromAmount" id="fromAmount"  fdt="String" ' + caclhvProps.get("fromAmount_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT648084") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.toAmount" id="toAmount"  fdt="String" ' + caclhvProps.get("toAmount_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT648086") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.customerAccount" id="customerAccount"  fdt="String" ' + caclhvProps.get("customerAccount_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT648087") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.lastNRecords" id="lastNRecords"  fdt="String" ' + caclhvProps.get("lastNRecords_ENABLED") + '>');
	write('</td>');
	write('</tr>');
        write('<tr>');
        write('<td class="columnwidth"> </td>');
        write('<td class="columnwidth"> </td>');
        write('<td class="columnwidth"> </td>');
        write('<td class="columnwidth"> </td>');
        write('<td class="textfield">');
        write('<input id="acctCcy" name="' + subGroupName + '.acctCcy" type="text" disabled="true" class="labelwithoutwidth" size="3" maxlength="3" fdt="default" fblk="defaultFblk2" fds="Y">');
        write('<input id="acctSolId" name="' + subGroupName + '.acctSolId" type="text" disabled="true" class="labelwithoutwidth" size="8" maxlength="8" fdt="default" fblk="defaultFblk2" fds="Y">');
        //write('<input id="acctName" name="' + subGroupName + '.acctName" type="text" disabled="true" class="label" size="25" maxlength="25" fdt="default" fblk="defaultFblk2" fds="Y">');
		write('<input id="accountName" name="' + subGroupName + '.accountName" type="text" disabled="true" class="label" size="25" maxlength="25" fdt="default" fblk="defaultFblk2" fds="Y">');
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
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return caclhvcrit_ONCLICK3(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return caclhvcrit_ONCLICK4(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	initFocusHandler();

	pre_ONLOAD('caclhvcrit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnAssignDateOnLoad(ObjForm);

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('caclhvcrit',this);
	ObjForm.paysysId.value = "RTGS1";
	
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.funcCode.value = funcCode;
	ObjForm.fromDate.value = fromDate;
	ObjForm.toDate.value = toDate;
	ObjForm.fromAmount.value = fromAmount;
	ObjForm.toAmount.value = toAmount;
	ObjForm.customerAccount.value = customerAccount;
	ObjForm.lastNRecords.value = lastNRecords;
	fnCheckControls();

}

function fnCheckControls()
{
	var ObjForm = document.forms[0];

	checkRadio(ObjForm.msgType,msgType);
}


function caclhvcrit_ONBLUR1(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('caclhvcrit',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = onBlurFormatDate(p1)) == false) {
		return false;
	}
	if ((retVal = fnAssignDateOnEnter(p2)) == false) {
		return false;
	}
	if (postEventCall('caclhvcrit',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function caclhvcrit_ONBLUR2(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('caclhvcrit',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = onBlurFormatDate(p1)) == false) {
		return false;
	}
	if ((retVal = fnAssignDateOnEnter(p2)) == false) {
		return false;
	}
	if (postEventCall('caclhvcrit',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function caclhvcrit_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('caclhvcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('caclhvcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function caclhvcrit_ONCLICK4(obj)
{
	var retVal = "";
	if (preEventCall('caclhvcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('caclhvcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
