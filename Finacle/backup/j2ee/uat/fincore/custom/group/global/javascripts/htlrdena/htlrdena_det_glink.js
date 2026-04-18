function printBlock()
{
	writeCustomHeader("htlrdena_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT027769") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel" style="width: 201px">' + jspResArr.get("FLT027770") + '</td>');
	write('<td class="textfielddisplaylabel" >');
	write('<INPUT type="hidden" class="text" name="' + subGroupName + '.totRec" id="totRec"  size="15"   style="TEXT-ALIGN:center">');
	//write('<input type="text" class="label" name="' + subGroupName + '.funcCode" id="funcCode" ' + htlrdenaProps.get("funcCode_ENABLED") + '>');
	if (funcCode =="M")
		{
		write('M - Modify');
		}
		else if (funcCode =="I")
		{
		write('I - Inquire');
		}
		else if (funcCode =="V")
		{
		write('V - Verify');
		}
		else if (funcCode =="X")
		{
		write('X - Cancel');
	}
	write('</td>');
	write('<td class="columnwidth" style="width: 48px">&nbsp; </td>');
	write('<td class="textlabel" style="width: 201px">' + jspResArr.get("FLT027771") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<input type="text" class="label" name="' + subGroupName + '.currency" id="currency" ' + htlrdenaProps.get("currency_ENABLED") + ' readOnly>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel" style="width: 201px">' + jspResArr.get("FLT027772") + '</td>');
	write('<td class="textfielddisplaylabel" >');
	write('<input type="text" class="label" name="' + subGroupName + '.telId" id="telId" ' + htlrdenaProps.get("telId_ENABLED") + ' readOnly>');
	write('</td>');
	write('<td class="columnwidth" style="width: 48px">&nbsp; </td>');
	write('<td class="textlabel" style="width: 201px">' + jspResArr.get("FLT027773") + '</td>');
	write('<td class="textfielddisplaylabel" >');
	write('<input type="text" class="label" name="' + subGroupName + '.sol" id="sol" ' + htlrdenaProps.get("sol_ENABLED") + ' readOnly>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel" style="width: 198px">' + jspResArr.get("FLT027774") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<input type="text" class="label" name="' + subGroupName + '.cash" id="cash" ' + htlrdenaProps.get("cash_ENABLED") + ' readOnly>');
	write('</td>');
	write('<td class="columnwidth" style="width: 50px">&nbsp; </td>');
	write('<td class="textlabel" style="width: 201px">' + jspResArr.get("FLT027764") + '</td>');
	write('<td class="textfielddisplaylabel" >');
	write('<input type="text" class="label" name="' + subGroupName + '.tranId" id="tranId" ' + htlrdenaProps.get("tranId_ENABLED") + ' readOnly>');
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
	write('<a href="javascript:showHelpFile(\'htlrdena_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<div>');
	write('<tr>');
	write('<td colspan="5">');
	write('<table width="100%">');
	write('<tr>');
	write('<td class="searcheader1a" style="TEXT-ALIGN:center">' + jspResArr.get("FLT027760") + '</td>');
	write('<td class="searcheader" style="TEXT-ALIGN:center">' + jspResArr.get("FLT027761") + '</td>');
	write('<td class="searcheader" style="TEXT-ALIGN:center">' + jspResArr.get("FLT027762") + '</td>');
	write('<td class="searcheader" >' + jspResArr.get("FLT027763") + '</td>');
	write('</tr>');

	for(recNo=1; recNo<totalRecords;recNo++)
	{
	write('<tr>');
	write('<td>');
	write('<input style="width: 135px" type="label" class="label" style="TEXT-ALIGN:right" value="0" name="' + subGroupName + '.txtfld1name'+recNo+'" id="txtfld1name'+recNo+'" ' + htlrdenaProps.get("txtfld1name"+recNo+"_ENABLED") + ' readOnly>');
	write('</td>');
	write('<td>');
	write('<input style="width: 135px" type="label" class="label" style="TEXT-ALIGN:right" value="0" name="' + subGroupName + '.txtfld2name'+recNo+'" id="txtfld2name'+recNo+'" ' + htlrdenaProps.get("txtfld2name"+recNo+"_ENABLED") + ' readOnly>');
	write('</td>');
	write('<td>');
	write('<input style="width: 135px" type="label" class="label" style="TEXT-ALIGN:right" value="0" name="' + subGroupName + '.txtfld3name'+recNo+'" id="txtfld3name'+recNo+'" ' + htlrdenaProps.get("txtfld3name"+recNo+"_ENABLED") + ' readOnly>');
	write('</td>');
	write('<td>');
	write('<input style="width: 185px" type="text" class="textfieldfont" style="TEXT-ALIGN:center" value="0.00" name="' + subGroupName + '.txtfld4name'+recNo+'" id="txtfld4name'+recNo+'" ' + htlrdenaProps.get("txtfld4name"+recNo+"_ENABLED") + ' onBlur="return fnCalcTotalAmount(this);">');
	write('</td>');
	write('<td>');
	write('<INPUT type="hidden" class="text" name="' + subGroupName + '.txtfld5name'+recNo+'" id="txtfld5name'+recNo+'"  size="15"   style="TEXT-ALIGN:center">');
	write('</td>');
	write('</tr>');
	}

	write('<tr>');
	write('<td class="textlabel"> </td>');
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
	write('<table class="ctable" width="100%" border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT027765") + '</td>');
	write('<td class="textfield" align="left">');
	write('<input type="label"  class="label"  size="14" name="' + subGroupName + '.totCash" id="totCash" ' + htlrdenaProps.get("totCash_ENABLED") + ' readOnly>');
	//write('<INPUT type="label" class="label" name="totalCash" id="totalCash" ' + htlrdenmProps.get("totalCash_ENABLED") + ' size="14" readOnly>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('&nbsp;');
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
	write('<input id="Submit" name="Submit" type="button" class="button" onClick="javascript:var r=chekCnt(this); if(r==true)doRefSubmit(this);fnCalcTotalAmount(this)" value="Submit" hotKeyId="Submit">');
	//write('<input id="Validate" name="Validate" type="button" class="button" value="Validate"	onClick="javascript:return htlrdena_DET_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="Cancel"	onClick="javascript:return htlrdena_DET_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
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
	pre_ONLOAD('htlrdena_DET',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		//fnDisableFormControls(ObjForm);
		for(recNo=1; recNo<totalRecords;recNo++)
		{
			eval('ObjForm.txtfld4name'+recNo+'.disabled = true');
		}

	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	//alert("after post");
	post_ONLOAD('htlrdena_DET',this);
	fnCalcTotalAmount(ObjForm);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues()
{
	var ObjForm = document.forms[0];

	ObjForm.currency.value = currency;
	ObjForm.telId.value = telId;
	ObjForm.sol.value = sol;
	ObjForm.cash.value = cash;
	ObjForm.tranId.value = tranId;
	ObjForm.totCash.value = totCash;
	ObjForm.totRec.value = totalRecords;
	for(recNo=1; recNo<totalRecords;recNo++)
	{
		eval('ObjForm.txtfld1name'+recNo+'.value = txtfld1name'+recNo);
		eval('ObjForm.txtfld2name'+recNo+'.value = txtfld2name'+recNo);
		eval('ObjForm.txtfld3name'+recNo+'.value = txtfld3name'+recNo);
		eval('ObjForm.txtfld4name'+recNo+'.value = txtfld4name'+recNo);
//		var dntype = eval('ObjForm.txtfld2name'+recNo+'.value');
//		var dncnt  = eval('ObjForm.txtfld3name'+recNo+'.value');
//		var dnamt  = parseFloat(dntype,2)*parseFloat(dncnt,2);
//		eval('ObjForm.txtfld4name'+recNo+'.value = '+dnamt);
	}
}


function htlrdena_DET_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('htlrdena_DET',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('htlrdena_DET',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function htlrdena_DET_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('htlrdena_DET',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal =  fnValidateData(p1)) == false) {
		return false;
	}
	if (postEventCall('htlrdena_DET',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function htlrdena_DET_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('htlrdena_DET',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('htlrdena_DET',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function doSubmit(actionCode){
        var frm = document.forms[0];
        if(frm.submitform != undefined){
                frm.submitform.value = actionCode;
        }
        frm.actionCode.value = actionCode;
        enableFormElements();
        hideAnchors();
        disableButtons();
        frm.submit();
}

function fnCheckForNull(obj)
{
	var ObjForm = document.forms[0];
}

function fnCalcTotalAmount(obj)
{
	objForm = document.forms[0];
	var HiddenDenomCount = 0;
	var totAmt = 0;
	var amt = 0;
	for(var recNo=1;recNo<totalRecords;recNo++)
	{
		eval('objForm.txtfld5name'+recNo+'.value="0"');
	}
	for(var recNo=1;recNo<totalRecords;recNo++)
	{
		var crncyType = eval('objForm.txtfld1name'+recNo+'.value');
		var demonValue = eval('objForm.txtfld2name'+recNo+'.value');
		var demonCnt = eval('objForm.txtfld3name'+recNo+'.value');
		var objAmt = eval('objForm.txtfld4name'+recNo+'.value');
		var amount=fnTrim(objAmt);
		var amt = amount.replace(new RegExp(',','g'),"");
		var amt = parseFloat(amt,2);

		if(fnIsNull(amount))
		{
			alert("Please enter an amount");
			eval('objForm.txtfld4name'+recNo+'.focus()');
			eval('objForm.txtfld4name'+recNo+'.value="0"');
			return false;
		}

		totAmt = totAmt + parseFloat(amt);
		if(amt != 0)
		{
			var HiddenDenomCount = (amt*100)/(demonValue*100);
			if(!fnIsNumeric(HiddenDenomCount))
			{
				alert("Please enter an amount in multiples of the denomination");
				eval('objForm.txtfld4name'+recNo+'.focus()');
				eval('objForm.txtfld4name'+recNo+'.value="0"');
				return false;
			}
			eval('objForm.txtfld5name'+recNo+'.value='+HiddenDenomCount);

			/*if(!fnIsNumeric(HiddenDenomCount))
			{
				alert("Please enter an amount in multiples of the denomination");
				eval('objForm.txtfld4name'+recNo+'.focus()');
				return false;
			}*/
		}
	}

	objForm.totCash.value = parseFloat(totAmt);
	return true;
}
