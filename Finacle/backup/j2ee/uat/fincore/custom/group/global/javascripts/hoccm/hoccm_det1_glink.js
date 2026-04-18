
function printBlock1()
{
	writeCustomHeader("hoccm_det1");
	with (document){
	write('<input type="hidden" name="' + subGroupName + '.selectedRow" id="selectedRow">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031840") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT112254") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + hoccmFuncDesc + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000637") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + zoneDate + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT007523") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + zoneCode + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT009829") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + zoneCCY + '</label>');
	write('</td>');
	write('</tr>');
	// added for UBP - start //
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT007530") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + billerId + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031859") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + typOfServ + '</label>');
	write('</td>');
	write('</tr>');
	// added for UBP - end //
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
	write('<td colspan="5" align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right">');
	write('<a href="javascript:showHelpFile(\'HOCCM_det1_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">');
	write('<input name="webUrlCall" class="button" value="OUTBOUND CALL" type="button" id="webUrlCall"	onClick="javascript:return hoccm_det1_ONCLICK1(this);"">');
	write('</td>');
	write('<td class="textfield"> </td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');
	write('<tr class="subhdrbg">');
	write('<td align="left" colspan="5" class="textlabel" style="height: 15px;"><h2 class="subhdr">' + jspResArr.get("FLT003971") + '</h2></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px;">' + jspResArr.get("FLT031831") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.d1CrAcctNum" id="d1CrAcctNum" ' + hoccmProps.get("d1CrAcctNum_ENABLED") + ' size="16" maxlength="16">');
	write('&nbsp;&nbsp;&nbsp;<input name="' + subGroupName + '.acctName" id="acctName" size="35" maxlength="80" class="label" readonly="readonly" disabled>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.OutCallFlg" id="OutCallFlg" ' + hoccmProps.get("OutCallFlg_ENABLED") + ' style="visibility: hidden">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">');
	write('<div>');
	write('<tr>');
	write('<td colspan="5">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	/*write('<tr>');
	write('<td class="searcheader1a" type="text">' + jspResArr.get("FLT031847") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031848") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031849") + '</td>');
	write('</tr>');
	*/
	
	} //End with()
} //End function

function printBlock2()
{
	with (document){
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td colspan="5">');
	//write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td class="textlabel"></td>');
	write('<td>');
	write('<input type="hidden" class="textfieldfont" style="text-align: right" name="' + subGroupName + '.d1CrAmt" id="d1CrAmt" ' + hoccmProps.get("d1CrAmt_ENABLED") + ' size="23" maxlength="23"	onChange="javascript:return hoccm_det1_ONCHANGE2(this);">');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel"></td>');
	write('<td>');
	write('<input type="hidden" class="textfieldfont" name="' + subGroupName + '.d1AcctFreetext1" id="d1AcctFreetext1" ' + hoccmProps.get("d1AcctFreetext1_ENABLED") + ' size="50" maxlength="50">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel"></td>');
	write('<td>');
	write('<input type="hidden" class="textfieldfont" name="' + subGroupName + '.d1AcctFreetext2" id="d1AcctFreetext2" ' + hoccmProps.get("d1AcctFreetext2_ENABLED") + ' size="50" maxlength="50">');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('</tr>');
	//write('</table>');
	write('</td>');
	write('</tr>');
	write('</div>');
	write('</td>');
	write('<td class="textfield"></td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');

	fnPrintD1MultiRecFields();

	write('<tr class="subhdrbg">');
	write('<td align="left" colspan="5" class="textlabel" style="height: 15px;"><h2 class="subhdr">' + jspResArr.get("FLT000916") + '</h2></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031850") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" style="text-align: right" name="' + subGroupName + '.d1InstAmt" id="d1InstAmt" ' + hoccmProps.get("d1InstAmt_ENABLED") + ' size="23" maxlength="23">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT021766") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.d1InstNum" id="d1InstNum" ' + hoccmProps.get("d1InstNum_ENABLED") + ' size="16" maxlength="16">');
	write('<input name="chqImageButton" class="button" value="IMAGE" type="button" id="chqImageButton"	onClick="javascript:return hoccm_det1_ONCLICK3(this);"">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT007745") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.d1InstDate" id="d1InstDate" ' + hoccmProps.get("d1InstDate_ENABLED") + ' size="10" maxlength="10">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031851") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.d1PayingAcctNum" id="d1PayingAcctNum" ' + hoccmProps.get("d1PayingAcctNum_ENABLED") + ' size="16" maxlength="16">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT007794") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.d1BankCode" id="d1BankCode" ' + hoccmProps.get("d1BankCode_ENABLED") + ' size="6" maxlength="6">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031027") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.d1TranCode" id="d1TranCode" ' + hoccmProps.get("d1TranCode_ENABLED") + ' size="3" maxlength="3">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031835") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.d1BatchNum" id="d1BatchNum" ' + hoccmProps.get("d1BatchNum_ENABLED") + ' size="22" maxlength="22">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031836") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.d1TranId" id="d1TranId" ' + hoccmProps.get("d1TranId_ENABLED") + ' size="16" maxlength="16">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031857") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.d1InstFreetext" id="d1InstFreetext" ' + hoccmProps.get("d1InstFreetext_ENABLED") + ' size="50" maxlength="50">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT009907") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.d1BrCode" id="d1BrCode" ' + hoccmProps.get("d1BrCode_ENABLED") + ' size="6" maxlength="6">');
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
	if(billPayYes=="Y")
	{
	     getBillDetailSection();
	}

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
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return hoccm_det1_ONCLICK4(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	//write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT021284") + '"	onClick="javascript:return hoccm_det1_ONCLICK5(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT027575") + '"	onClick="javascript:return hoccm_det1_ONCLICK6(this,this.id);"" hotKeyId="Cancel">');
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

	pre_ONLOAD('hoccm_det1',this);

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

	post_ONLOAD('hoccm_det1',this);
	fnShowHideD1MultiRecFields();
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	var td1InstAmt = d1InstAmt;

	ObjForm.d1CrAcctNum.value = d1CrAcctNum;
	ObjForm.OutCallFlg.value = OutCallFlg;
	ObjForm.d1CrAmt.value = d1CrAmt;
	ObjForm.d1AcctFreetext1.value = d1AcctFreetext1;
	ObjForm.d1AcctFreetext2.value = d1AcctFreetext2;
	ObjForm.d1InstAmt.value = d1InstAmt;
	ObjForm.d1InstNum.value = d1InstNum;
	ObjForm.d1InstDate.value = d1InstDate;
	ObjForm.d1PayingAcctNum.value = d1PayingAcctNum;
	ObjForm.d1BankCode.value = d1BankCode;
	ObjForm.d1TranCode.value = d1TranCode;
	ObjForm.d1BatchNum.value = d1BatchNum;
	ObjForm.d1TranId.value = d1TranId;
	ObjForm.d1InstFreetext.value = d1InstFreetext;
	ObjForm.d1BrCode.value = d1BrCode;

	
	

	if(billPayYes=="Y")
	{
		ObjForm.billRefNum.value = billRefNum;
		ObjForm.name.value = name;
		ObjForm.tranPart.value = tranPart;
		ObjForm.tranRem.value = tranRem;
		ObjForm.refNumHidden.value = refNumHidden;
		ObjForm.retStrngValHid.value =retStrngValHid;
		if(billerId=="IPO")
		{
			ObjForm.appCatgry.value =appCatgry;
		}
	
		ObjForm.billRefNum.value = billRefNum;
		ObjForm.name.value = name;
		ObjForm.tranPart.value = tranPart;
		ObjForm.tranRem.value = tranRem;
		ObjForm.freetext1.value = freetext1;
		ObjForm.freetext1.disabled=true


		ObjForm.freetext1.value =freetext1;
		ObjForm.freetext2.value =freetext2;
		ObjForm.freetext3.value =freetext3;
		ObjForm.freetext4.value =freetext4;
		ObjForm.freetext5.value =freetext5;
		ObjForm.freetext6.value =freetext6;
		ObjForm.freetext7.value =freetext7;

		if(billerId=="KASNEB")
		{
			ObjForm.freetext1.value =freetext1;
			ObjForm.freetext2.value =freetext2;
			ObjForm.refDesc.value = refDesc;
		}
		if(billerId=="TURNQUEST")
		{
			ObjForm.riskNote.value = riskNote;
			fnCheckControls();
		}		
	}
	ObjForm.d1TotalRecords.value = d1TotalRecords;
	//alert("d1TotalRecords : " + d1TotalRecords);
	//alert("td1InstAmt " + td1InstAmt);
	
	
	//ObjForm.d1MRCrAmt_1.value = d1MRCrAmt_1;
	if(funcCode == 'L')
	{
		ObjForm.d1MRCrAmt_1.value = td1InstAmt;
	}
	else
	{
		ObjForm.d1MRCrAmt_1.value = d1MRCrAmt_1;
	}
	ObjForm.d1MRCrAmt_2.value = d1MRCrAmt_2;
	ObjForm.d1MRCrAmt_3.value = d1MRCrAmt_3;
	ObjForm.d1MRCrAmt_4.value = d1MRCrAmt_4;
	ObjForm.d1MRCrAmt_5.value = d1MRCrAmt_5;

	ObjForm.d1MRFreeText1_1.value = d1MRFreeText1_1;
	ObjForm.d1MRFreeText1_2.value = d1MRFreeText1_2;
	ObjForm.d1MRFreeText1_3.value = d1MRFreeText1_3;
	ObjForm.d1MRFreeText1_4.value = d1MRFreeText1_4;
	ObjForm.d1MRFreeText1_5.value = d1MRFreeText1_5;

	ObjForm.d1MRFreeText2_1.value = d1MRFreeText2_1;
	ObjForm.d1MRFreeText2_2.value = d1MRFreeText2_2;
	ObjForm.d1MRFreeText2_3.value = d1MRFreeText2_3;
	ObjForm.d1MRFreeText2_4.value = d1MRFreeText2_4;
	ObjForm.d1MRFreeText2_5.value = d1MRFreeText2_5;
	

}

function fnCheckControls()
{
	var ObjForm = document.forms[0];

	checkRadio(ObjForm.riskNote,riskNote);
}

function hoccm_det1_ONCLICK1(obj)
{
	var retVal = "";
	if (preEventCall('hoccm_det1',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnWebUrlCall()) == false) {
		return false;
	}
	if (postEventCall('hoccm_det1',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_det1_ONCHANGE2(obj)
{
	var retVal = "";
	if (preEventCall('hoccm_det1',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnd1CrAmtOnChange()) == false) {
		return false;
	}
	if (postEventCall('hoccm_det1',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_det1_ONCLICK3(obj)
{
	var retVal = "";
	if (preEventCall('hoccm_det1',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnChqImageButton()) == false) {
		return false;
	}
	if (postEventCall('hoccm_det1',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_det1_ONCLICK4(obj,p1)
{
	var retVal = "";
	if (preEventCall('hoccm_det1',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('hoccm_det1',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_det1_ONCLICK5(obj,p1)
{
	var retVal = "";
	if (preEventCall('hoccm_det1',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValidateData(p1)) == false) {
		return false;
	}
	if (postEventCall('hoccm_det1',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_det1_ONCLICK6(obj,p1)
{
	var retVal = "";
	if (preEventCall('hoccm_det1',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('hoccm_det1',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnPrintD1MultiRecFields(){

	document.write('<input type="hidden" class="textfieldfont" name="' + subGroupName + '.d1TotalRecords" id="d1TotalRecords" size="6" maxlength="6">');
	document.write('<tr class="subhdrbg" >');
        document.write('<td colspan="2">&nbsp;');
        if(funcCode == 'I'){
                document.write('<input value ="Add New" disabled type="button" name="addNew" id="addNew"  class="button1" onClick="JavaScript:fnCreateNewRow();">');
                }
        else{
                document.write('<input value ="Add New" type="button" name="addNew" id="addNew"  class="button1" onClick="JavaScript:fnCreateNewRow();">');
                }
        document.write('</td>');
	document.write('<td colspan="3"></td>');
        document.write('</tr>');

	with (document){

	write('<tr>');
        write('<td class="searcheader1a" type="text">&nbsp;' + jspResArr.get("FLT031847") + '</td>');
        write('<td colspan="2" class="searcheader" type="text">&nbsp;' + jspResArr.get("FLT031848") + '</td>');
        write('<td colspan="2" class="searcheader" type="text">&nbsp;' + jspResArr.get("FLT031849") + '</td>');
        write('</tr>');

	write('<tr class="searclist1a" id="d1MRRow1">');
        write('<td class="textfield">');
        write('<input type="text" class="textfieldamount" name="' + subGroupName + '.d1MRCrAmt_1" id="d1MRCrAmt_1" size="23" fdt="amount" maxlength="23">');
        write('</td>');
	write('<td colspan="2" class="textfield">');
        write('<input type="text" class="textfieldfont" style="width:400px" name="' + subGroupName + '.d1MRFreeText1_1" id="d1MRFreeText1_1" size="30" maxlength="30">');
        write('</td>');
	write('<td colspan="2" class="textfield">');
        write('<input type="text" class="textfieldfont" style="width:400px" name="' + subGroupName + '.d1MRFreeText2_1" id="d1MRFreeText2_1" size="30" maxlength="30">');
        write('</td>');
        write('</tr>');

	write('<tr class="searclist2a" id="d1MRRow2">');
        write('<td class="textfield">');
	write('<input type="text" class="textfieldamount" name="' + subGroupName + '.d1MRCrAmt_2" id="d1MRCrAmt_2" size="23" fdt="amount" maxlength="23">');
        write('</td>');
        write('<td colspan="2" class="textfield">');
        write('<input type="text" class="textfieldfont" style="width:400px" name="' + subGroupName + '.d1MRFreeText1_2" id="d1MRFreeText1_2" size="30" maxlength="30">');
        write('</td>');
        write('<td colspan="2" class="textfield">');
        write('<input type="text" class="textfieldfont" style="width:400px" name="' + subGroupName + '.d1MRFreeText2_2" id="d1MRFreeText2_2" size="30" maxlength="30">');
        write('</td>');
        write('</tr>');

	write('<tr class="searclist1a" id="d1MRRow3">');
        write('<td class="textfield">');
	write('<input type="text" class="textfieldamount" name="' + subGroupName + '.d1MRCrAmt_3" id="d1MRCrAmt_3" size="23" fdt="amount" maxlength="23">');
        write('</td>');
        write('<td colspan="2" class="textfield">');
        write('<input type="text" class="textfieldfont" style="width:400px" name="' + subGroupName + '.d1MRFreeText1_3" id="d1MRFreeText1_3" size="30" maxlength="30">');
        write('</td>');
        write('<td colspan="2" class="textfield">');
        write('<input type="text" class="textfieldfont" style="width:400px" name="' + subGroupName + '.d1MRFreeText2_3" id="d1MRFreeText2_3" size="30" maxlength="30">');
        write('</td>');
        write('</tr>');

	write('<tr class="searclist2a" id="d1MRRow4">');
        write('<td class="textfield">');
	write('<input type="text" class="textfieldamount" name="' + subGroupName + '.d1MRCrAmt_4" id="d1MRCrAmt_4" size="23" fdt="amount" maxlength="23">');
        write('</td>');
        write('<td colspan="2" class="textfield">');
        write('<input type="text" class="textfieldfont" style="width:400px" name="' + subGroupName + '.d1MRFreeText1_4" id="d1MRFreeText1_4" size="30" maxlength="30">');
        write('</td>');
        write('<td colspan="2" class="textfield">');
        write('<input type="text" class="textfieldfont" style="width:400px" name="' + subGroupName + '.d1MRFreeText2_4" id="d1MRFreeText2_4" size="30" maxlength="30">');
        write('</td>');
        write('</tr>');

	write('<tr class="searclist1a" id="d1MRRow5">');
        write('<td class="textfield">');
	write('<input type="text" class="textfieldamount" name="' + subGroupName + '.d1MRCrAmt_5" id="d1MRCrAmt_5" size="23" fdt="amount" maxlength="23">');
        write('</td>');
        write('<td colspan="2" class="textfield">');
        write('<input type="text" class="textfieldfont" style="width:400px" name="' + subGroupName + '.d1MRFreeText1_5" id="d1MRFreeText1_5" size="30" maxlength="30">');
        write('</td>');
        write('<td colspan="2" class="textfield">');
        write('<input type="text" class="textfieldfont" style="width:400px" name="' + subGroupName + '.d1MRFreeText2_5" id="d1MRFreeText2_5" size="30" maxlength="30">');
        write('</td>');
        write('</tr>');



	write('<tr>');
        write('<td class="textfield">');
        write('&nbsp;</td>');
        write('<td colspan="2" class="textfield">');
        write('</td>');
        write('<td colspan="2" class="textfield">');
        write('</td>');
        write('</tr>');
	} //End with()
}

function fnShowHideD1MultiRecFields(){

	var ObjForm = document.forms[0];
	var d1TotalRecords = ObjForm.d1TotalRecords.value;

	if(parseInt(d1TotalRecords) < 5){
		hideImage("d1MRRow5");
	}else{
		showImage("d1MRRow5");
	}

	if(parseInt(d1TotalRecords) < 4){
                hideImage("d1MRRow4");
        }else{
                showImage("d1MRRow4");
        }

	if(parseInt(d1TotalRecords) < 3){
                hideImage("d1MRRow3");
        }else{
                showImage("d1MRRow3");
        }

	if(parseInt(d1TotalRecords) < 2){
                hideImage("d1MRRow2");
        }else{
                showImage("d1MRRow2");
		ObjForm.d1MRFreeText1_1.disabled = true;
		ObjForm.d1MRFreeText2_1.disabled = true;
        }

}

function fnCreateNewRow(){


if((billPayYes=="Y") && (buttonFlg == "N"))
{
	alert("Enter the bill ref number and get the details");
	return;
}


	var ObjForm = document.forms[0];
	var retVal = "";
	if ((retVal =  fnD1MultiRecFieldsMandatoryCheck()) == true) {
		var d1TotalRecords = ObjForm.d1TotalRecords.value;
		if(parseInt(d1TotalRecords) == 5){
			alert("Reached Maximum Count");
		}else{

			if(parseInt(d1TotalRecords) == 1){
				ObjForm.d1CrAmt.value = ObjForm.d1MRCrAmt_1.value
			}
			if(parseInt(d1TotalRecords) == 2){
				ObjForm.d1CrAmt.value = ObjForm.d1MRCrAmt_2.value
			}
			if(parseInt(d1TotalRecords) == 3){
				ObjForm.d1CrAmt.value = ObjForm.d1MRCrAmt_3.value
			}
			if(parseInt(d1TotalRecords) == 4){
				ObjForm.d1CrAmt.value = ObjForm.d1MRCrAmt_4.value
			}
			if(parseInt(d1TotalRecords) == 5){
				ObjForm.d1CrAmt.value = ObjForm.d1MRCrAmt_5.value
			}
			//alert("d1CrAmt : " + ObjForm.d1CrAmt.value);

			d1TotalRecords = parseInt(d1TotalRecords) + 1;
			ObjForm.d1TotalRecords.value = d1TotalRecords;
			fnShowHideD1MultiRecFields();
			if(billPayYes=="Y")
			{
				temp_insert();

				fnClearBillerRecords();
				
				buttonFlg="N";

			}

		
		}
        }

}

function fnD1MultiRecFieldsMandatoryCheck(){
	var ObjForm = document.forms[0];
	var d1TotalRecords = ObjForm.d1TotalRecords.value;
	var tmpVar = "";

	if(parseInt(d1TotalRecords) > 4){
		tmpVar = ObjForm.d1MRCrAmt_5.value;
		if(fnIsNull(tmpVar)){
			alert("Enter the field");
			ObjForm.d1MRCrAmt_5.focus();
			return false;
		}
        }

	if(parseInt(d1TotalRecords) > 3){
                tmpVar = ObjForm.d1MRCrAmt_4.value;
                if(fnIsNull(tmpVar)){
                        alert("Enter the field");
			ObjForm.d1MRCrAmt_4.focus();
                        return false;
                }
        }

	if(parseInt(d1TotalRecords) > 2){
                tmpVar = ObjForm.d1MRCrAmt_3.value;
                if(fnIsNull(tmpVar)){
                        alert("Enter the field");
			ObjForm.d1MRCrAmt_3.focus();
                        return false;
                }
        }

	if(parseInt(d1TotalRecords) > 1){
                tmpVar = ObjForm.d1MRCrAmt_2.value;
                if(fnIsNull(tmpVar)){
                        alert("Enter the field");
			ObjForm.d1MRCrAmt_2.focus();
                        return false;
                }
        }

	if(parseInt(d1TotalRecords) > 0){
                tmpVar = ObjForm.d1MRCrAmt_1.value;
                if(fnIsNull(tmpVar)){
                        alert("Enter the field");
                        ObjForm.d1MRCrAmt_1.focus();
                        return false;
                }
        }
	
	return true;
}
