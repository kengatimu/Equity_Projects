function printBlock1()
{
	writeCustomHeader("hoccm_det2");
	with (document){
	write('<input type="hidden" name="' + subGroupName + '.selectedRow" id="selectedRow">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT021036") + '</td>');
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
	write('<a href="javascript:showHelpFile(\'HOCCM_det2_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');

	//write('<tr>');
	//write('<td class="textlabel" style="height: 15px">');
	write('<input name="webUrlCall" class="Button" value="OUTBOUND CALL" type="button" id="webUrlCall"	onClick="javascript:return hoccm_det2_ONCLICK1(this);"">');
	//write('</td>');
	//write('<td class="textfield"> </td>');
	//write('<td class="columnwidth"> </td>');
	//write('<td class="textlabel"> </td>');
	//write('<td class="textfield"> </td>');
	//write('</tr>');

	write('<tr class="subhdrbg">');
        write('<td align="left" colspan="5" class="textlabel" style="height: 15px;"><h2 class="subhdr">' + jspResArr.get("FLT003971") + '</h2></td>');
        write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031846") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.d2CrAcctNum" id="d2CrAcctNum" ' + hoccmProps.get("d2CrAcctNum_ENABLED") + ' size="16" maxlength="16">');
	write('<br><input name="' + subGroupName + '.acctName" id="acctName" size="35" maxlength="80" class="label" readonly="readonly" disabled>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031847") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" style="text-align: right" name="' + subGroupName + '.d2CrAmt" id="d2CrAmt" ' + hoccmProps.get("d2CrAmt_ENABLED") + ' size="23" maxlength="23"	onChange="javascript:return hoccm_det2_ONCHANGE2(this);">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031848") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.d2AcctFreetext1" id="d2AcctFreetext1" ' + hoccmProps.get("d2AcctFreetext1_ENABLED") + ' size="50" maxlength="50">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031849") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.d2AcctFreetext2" id="d2AcctFreetext2" ' + hoccmProps.get("d2AcctFreetext2_ENABLED") + ' size="50" maxlength="50">');
	write('</td>');
	write('</tr>');
	write('<tr class="subhdrbg">');
        write('<td align="left" colspan="5" class="textlabel" style="height: 15px;"><h2 class="subhdr">' + jspResArr.get("FLT000916") + '</h2></td>');
        write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">');
	write('<div>');
	write('<tr>');
	write('<td colspan="5">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td align="right" class="searcheader1a" type="text">' + jspResArr.get("FLT031850") + '&nbsp;</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT021766") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT007745") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031851") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT007794") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031027") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031835") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031836") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031857") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT009907") + '</td>');
	write('</tr>');
	} //End with()
} //End function

function printBlock2()
{
	fnPrintD2MultiRecFields();

	with (document){
	write('</table>');
	//write('</td>');
	//write('</tr>');
	write('<input type="hidden" class="textfieldfont" style="text-align: right" name="' + subGroupName + '.d2InstAmt" id="d2InstAmt" ' + hoccmProps.get("d2InstAmt_ENABLED") + ' size="23" maxlength="23">');
	write('<input type="hidden" class="textfieldfont" name="' + subGroupName + '.d2InstNum" id="d2InstNum" ' + hoccmProps.get("d2InstNum_ENABLED") + ' size="16" maxlength="16">');
	//write('<input name="chqImageButton" class="Button" value="Image" type="button" id="chqImageButton"	onClick="javascript:return hoccm_det2_ONCLICK3(this);"">');
	write('<input type="hidden" class="textfieldfont" name="' + subGroupName + '.d2InstDate" id="d2InstDate" ' + hoccmProps.get("d2InstDate_ENABLED") + ' size="10" maxlength="10">');
	write('<input type="hidden" class="textfieldfont" name="' + subGroupName + '.d2PayingAcctNum" id="d2PayingAcctNum" ' + hoccmProps.get("d2PayingAcctNum_ENABLED") + ' size="16" maxlength="16">');
	write('<input type="hidden" class="textfieldfont" name="' + subGroupName + '.d2BankCode" id="d2BankCode" ' + hoccmProps.get("d2BankCode_ENABLED") + ' size="6" maxlength="6">');
	write('<input type="hidden" class="textfieldfont" name="' + subGroupName + '.d2TranCode" id="d2TranCode" ' + hoccmProps.get("d2TranCode_ENABLED") + ' size="3" maxlength="3">');
	write('<input type="hidden" class="textfieldfont" name="' + subGroupName + '.d2BatchNum" id="d2BatchNum" ' + hoccmProps.get("d2BatchNum_ENABLED") + ' size="22" maxlength="22">');
	write('<input type="hidden" class="textfieldfont" name="' + subGroupName + '.d2TranId" id="d2TranId" ' + hoccmProps.get("d2TranId_ENABLED") + ' size="16" maxlength="16">');
	write('<input type="hidden" class="textfieldfont" name="' + subGroupName + '.d2InstFreetext" id="d2InstFreetext" ' + hoccmProps.get("d2InstFreetext_ENABLED") + ' size="50" maxlength="50">');
	write('<input type="hidden" class="textfieldfont" name="' + subGroupName + '.d2BrCode" id="d2BrCode" ' + hoccmProps.get("d2BrCode_ENABLED") + ' size="6" maxlength="6">');
	//write('</div>');
	//write('</td>');
	//write('</tr>');
	//write('<tr>');
	//write('<td class="textlabel" style="height: 15px"> </td>');
	//write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.OutCallFlg" id="OutCallFlg" ' + hoccmProps.get("OutCallFlg_ENABLED") + ' style="visibility: hidden">');
	//write('</td>');
	//write('<td class="columnwidth"> </td>');
	//write('<td class="textlabel"> </td>');
	//write('<td class="textfield"> </td>');
	//write('</tr>');
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
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return hoccm_det2_ONCLICK4(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	//write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT021284") + '"	onClick="javascript:return hoccm_det2_ONCLICK5(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT027575") + '"	onClick="javascript:return hoccm_det2_ONCLICK6(this,this.id);"" hotKeyId="Cancel">');
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

	pre_ONLOAD('hoccm_det2',this);

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

	post_ONLOAD('hoccm_det2',this);
	fnShowHideD2MultiRecFields();
	fnDisableD2MRFields();
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.d2CrAcctNum.value = d2CrAcctNum;
	ObjForm.d2CrAmt.value = d2CrAmt;
	ObjForm.d2AcctFreetext1.value = d2AcctFreetext1;
	ObjForm.d2AcctFreetext2.value = d2AcctFreetext2;
	ObjForm.d2InstAmt.value = d2InstAmt;
	ObjForm.d2InstNum.value = d2InstNum;
	ObjForm.d2InstDate.value = d2InstDate;
	ObjForm.d2PayingAcctNum.value = d2PayingAcctNum;
	ObjForm.d2BankCode.value = d2BankCode;
	ObjForm.d2TranCode.value = d2TranCode;
	ObjForm.d2BatchNum.value = d2BatchNum;
	ObjForm.d2TranId.value = d2TranId;
	ObjForm.d2InstFreetext.value = d2InstFreetext;
	ObjForm.d2BrCode.value = d2BrCode;
	ObjForm.OutCallFlg.value = OutCallFlg;

	ObjForm.d2TotalRecords.value = d2TotalRecords;

	ObjForm.d2MRInstAmt_1.value = d2MRInstAmt_1;
	ObjForm.d2MRInstNum_1.value = d2MRInstNum_1;
	ObjForm.d2MRInstDate_1.value = d2MRInstDate_1;
	ObjForm.d2MRPayingAcctNum_1.value = d2MRPayingAcctNum_1;
	ObjForm.d2MRBankCode_1.value = d2MRBankCode_1;
	ObjForm.d2MRTranCode_1.value = d2MRTranCode_1;
	ObjForm.d2MRBatchNum_1.value = d2MRBatchNum_1;
	ObjForm.d2MRTranId_1.value = d2MRTranId_1;
	ObjForm.d2MRPayingAcctName_1.value = d2MRPayingAcctName_1;
	ObjForm.d2MRBrCode_1.value = d2MRBrCode_1;

	ObjForm.d2MRInstAmt_2.value = d2MRInstAmt_2;
	ObjForm.d2MRInstNum_2.value = d2MRInstNum_2;
	ObjForm.d2MRInstDate_2.value = d2MRInstDate_2;
	ObjForm.d2MRPayingAcctNum_2.value = d2MRPayingAcctNum_2;
	ObjForm.d2MRBankCode_2.value = d2MRBankCode_2;
	ObjForm.d2MRTranCode_2.value = d2MRTranCode_2;
	ObjForm.d2MRBatchNum_2.value = d2MRBatchNum_2;
	ObjForm.d2MRTranId_2.value = d2MRTranId_2;
	ObjForm.d2MRPayingAcctName_2.value = d2MRPayingAcctName_2;
	ObjForm.d2MRBrCode_2.value = d2MRBrCode_2;

	ObjForm.d2MRInstAmt_3.value = d2MRInstAmt_3;
	ObjForm.d2MRInstNum_3.value = d2MRInstNum_3;
	ObjForm.d2MRInstDate_3.value = d2MRInstDate_3;
	ObjForm.d2MRPayingAcctNum_3.value = d2MRPayingAcctNum_3;
	ObjForm.d2MRBankCode_3.value = d2MRBankCode_3;
	ObjForm.d2MRTranCode_3.value = d2MRTranCode_3;
	ObjForm.d2MRBatchNum_3.value = d2MRBatchNum_3;
	ObjForm.d2MRTranId_3.value = d2MRTranId_3;
	ObjForm.d2MRPayingAcctName_3.value = d2MRPayingAcctName_3;
	ObjForm.d2MRBrCode_3.value = d2MRBrCode_3;

	ObjForm.d2MRInstAmt_4.value = d2MRInstAmt_4;
	ObjForm.d2MRInstNum_4.value = d2MRInstNum_4;
	ObjForm.d2MRInstDate_4.value = d2MRInstDate_4;
	ObjForm.d2MRPayingAcctNum_4.value = d2MRPayingAcctNum_4;
	ObjForm.d2MRBankCode_4.value = d2MRBankCode_4;
	ObjForm.d2MRTranCode_4.value = d2MRTranCode_4;
	ObjForm.d2MRBatchNum_4.value = d2MRBatchNum_4;
	ObjForm.d2MRTranId_4.value = d2MRTranId_4;
	ObjForm.d2MRPayingAcctName_4.value = d2MRPayingAcctName_4;
	ObjForm.d2MRBrCode_4.value = d2MRBrCode_4;

	ObjForm.d2MRInstAmt_5.value = d2MRInstAmt_5;
	ObjForm.d2MRInstNum_5.value = d2MRInstNum_5;
	ObjForm.d2MRInstDate_5.value = d2MRInstDate_5;
	ObjForm.d2MRPayingAcctNum_5.value = d2MRPayingAcctNum_5;
	ObjForm.d2MRBankCode_5.value = d2MRBankCode_5;
	ObjForm.d2MRTranCode_5.value = d2MRTranCode_5;
	ObjForm.d2MRBatchNum_5.value = d2MRBatchNum_5;
	ObjForm.d2MRTranId_5.value = d2MRTranId_5;
	ObjForm.d2MRPayingAcctName_5.value = d2MRPayingAcctName_5;
	ObjForm.d2MRBrCode_5.value = d2MRBrCode_5;

	ObjForm.d2MRInstAmt_6.value = d2MRInstAmt_6;
	ObjForm.d2MRInstNum_6.value = d2MRInstNum_6;
	ObjForm.d2MRInstDate_6.value = d2MRInstDate_6;
	ObjForm.d2MRPayingAcctNum_6.value = d2MRPayingAcctNum_6;
	ObjForm.d2MRBankCode_6.value = d2MRBankCode_6;
	ObjForm.d2MRTranCode_6.value = d2MRTranCode_6;
	ObjForm.d2MRBatchNum_6.value = d2MRBatchNum_6;
	ObjForm.d2MRTranId_6.value = d2MRTranId_6;
	ObjForm.d2MRPayingAcctName_6.value = d2MRPayingAcctName_6;
	ObjForm.d2MRBrCode_6.value = d2MRBrCode_6;

	ObjForm.d2MRInstAmt_7.value = d2MRInstAmt_7;
	ObjForm.d2MRInstNum_7.value = d2MRInstNum_7;
	ObjForm.d2MRInstDate_7.value = d2MRInstDate_7;
	ObjForm.d2MRPayingAcctNum_7.value = d2MRPayingAcctNum_7;
	ObjForm.d2MRBankCode_7.value = d2MRBankCode_7;
	ObjForm.d2MRTranCode_7.value = d2MRTranCode_7;
	ObjForm.d2MRBatchNum_7.value = d2MRBatchNum_7;
	ObjForm.d2MRTranId_7.value = d2MRTranId_7;
	ObjForm.d2MRPayingAcctName_7.value = d2MRPayingAcctName_7;
	ObjForm.d2MRBrCode_7.value = d2MRBrCode_7;

	ObjForm.d2MRInstAmt_8.value = d2MRInstAmt_8;
	ObjForm.d2MRInstNum_8.value = d2MRInstNum_8;
	ObjForm.d2MRInstDate_8.value = d2MRInstDate_8;
	ObjForm.d2MRPayingAcctNum_8.value = d2MRPayingAcctNum_8;
	ObjForm.d2MRBankCode_8.value = d2MRBankCode_8;
	ObjForm.d2MRTranCode_8.value = d2MRTranCode_8;
	ObjForm.d2MRBatchNum_8.value = d2MRBatchNum_8;
	ObjForm.d2MRTranId_8.value = d2MRTranId_8;
	ObjForm.d2MRPayingAcctName_8.value = d2MRPayingAcctName_8;
	ObjForm.d2MRBrCode_8.value = d2MRBrCode_8;

	ObjForm.d2MRInstAmt_9.value = d2MRInstAmt_9;
	ObjForm.d2MRInstNum_9.value = d2MRInstNum_9;
	ObjForm.d2MRInstDate_9.value = d2MRInstDate_9;
	ObjForm.d2MRPayingAcctNum_9.value = d2MRPayingAcctNum_9;
	ObjForm.d2MRBankCode_9.value = d2MRBankCode_9;
	ObjForm.d2MRTranCode_9.value = d2MRTranCode_9;
	ObjForm.d2MRBatchNum_9.value = d2MRBatchNum_9;
	ObjForm.d2MRTranId_9.value = d2MRTranId_9;
	ObjForm.d2MRPayingAcctName_9.value = d2MRPayingAcctName_9;
	ObjForm.d2MRBrCode_9.value = d2MRBrCode_9;

	ObjForm.d2MRInstAmt_10.value = d2MRInstAmt_10;
	ObjForm.d2MRInstNum_10.value = d2MRInstNum_10;
	ObjForm.d2MRInstDate_10.value = d2MRInstDate_10;
	ObjForm.d2MRPayingAcctNum_10.value = d2MRPayingAcctNum_10;
	ObjForm.d2MRBankCode_10.value = d2MRBankCode_10;
	ObjForm.d2MRTranCode_10.value = d2MRTranCode_10;
	ObjForm.d2MRBatchNum_10.value = d2MRBatchNum_10;
	ObjForm.d2MRTranId_10.value = d2MRTranId_10;
	ObjForm.d2MRPayingAcctName_10.value = d2MRPayingAcctName_10;
	ObjForm.d2MRBrCode_10.value = d2MRBrCode_10;

	ObjForm.d2MRInstAmt_11.value = d2MRInstAmt_11;
	ObjForm.d2MRInstNum_11.value = d2MRInstNum_11;
	ObjForm.d2MRInstDate_11.value = d2MRInstDate_11;
	ObjForm.d2MRPayingAcctNum_11.value = d2MRPayingAcctNum_11;
	ObjForm.d2MRBankCode_11.value = d2MRBankCode_11;
	ObjForm.d2MRTranCode_11.value = d2MRTranCode_11;
	ObjForm.d2MRBatchNum_11.value = d2MRBatchNum_11;
	ObjForm.d2MRTranId_11.value = d2MRTranId_11;
	ObjForm.d2MRPayingAcctName_11.value = d2MRPayingAcctName_11;
	ObjForm.d2MRBrCode_11.value = d2MRBrCode_11;

	ObjForm.d2MRInstAmt_12.value = d2MRInstAmt_12;
	ObjForm.d2MRInstNum_12.value = d2MRInstNum_12;
	ObjForm.d2MRInstDate_12.value = d2MRInstDate_12;
	ObjForm.d2MRPayingAcctNum_12.value = d2MRPayingAcctNum_12;
	ObjForm.d2MRBankCode_12.value = d2MRBankCode_12;
	ObjForm.d2MRTranCode_12.value = d2MRTranCode_12;
	ObjForm.d2MRBatchNum_12.value = d2MRBatchNum_12;
	ObjForm.d2MRTranId_12.value = d2MRTranId_12;
	ObjForm.d2MRPayingAcctName_12.value = d2MRPayingAcctName_12;
	ObjForm.d2MRBrCode_12.value = d2MRBrCode_12;

	ObjForm.d2MRInstAmt_13.value = d2MRInstAmt_13;
	ObjForm.d2MRInstNum_13.value = d2MRInstNum_13;
	ObjForm.d2MRInstDate_13.value = d2MRInstDate_13;
	ObjForm.d2MRPayingAcctNum_13.value = d2MRPayingAcctNum_13;
	ObjForm.d2MRBankCode_13.value = d2MRBankCode_13;
	ObjForm.d2MRTranCode_13.value = d2MRTranCode_13;
	ObjForm.d2MRBatchNum_13.value = d2MRBatchNum_13;
	ObjForm.d2MRTranId_13.value = d2MRTranId_13;
	ObjForm.d2MRPayingAcctName_13.value = d2MRPayingAcctName_13;
	ObjForm.d2MRBrCode_13.value = d2MRBrCode_13;

	ObjForm.d2MRInstAmt_14.value = d2MRInstAmt_14;
	ObjForm.d2MRInstNum_14.value = d2MRInstNum_14;
	ObjForm.d2MRInstDate_14.value = d2MRInstDate_14;
	ObjForm.d2MRPayingAcctNum_14.value = d2MRPayingAcctNum_14;
	ObjForm.d2MRBankCode_14.value = d2MRBankCode_14;
	ObjForm.d2MRTranCode_14.value = d2MRTranCode_14;
	ObjForm.d2MRBatchNum_14.value = d2MRBatchNum_14;
	ObjForm.d2MRTranId_14.value = d2MRTranId_14;
	ObjForm.d2MRPayingAcctName_14.value = d2MRPayingAcctName_14;
	ObjForm.d2MRBrCode_14.value = d2MRBrCode_14;

	ObjForm.d2MRInstAmt_15.value = d2MRInstAmt_15;
	ObjForm.d2MRInstNum_15.value = d2MRInstNum_15;
	ObjForm.d2MRInstDate_15.value = d2MRInstDate_15;
	ObjForm.d2MRPayingAcctNum_15.value = d2MRPayingAcctNum_15;
	ObjForm.d2MRBankCode_15.value = d2MRBankCode_15;
	ObjForm.d2MRTranCode_15.value = d2MRTranCode_15;
	ObjForm.d2MRBatchNum_15.value = d2MRBatchNum_15;
	ObjForm.d2MRTranId_15.value = d2MRTranId_15;
	ObjForm.d2MRPayingAcctName_15.value = d2MRPayingAcctName_15;
	ObjForm.d2MRBrCode_15.value = d2MRBrCode_15;


        ObjForm.d2MRInstAmt_16.value = d2MRInstAmt_16;
        ObjForm.d2MRInstNum_16.value = d2MRInstNum_16;
        ObjForm.d2MRInstDate_16.value = d2MRInstDate_16;
        ObjForm.d2MRPayingAcctNum_16.value = d2MRPayingAcctNum_16;
        ObjForm.d2MRBankCode_16.value = d2MRBankCode_16;
        ObjForm.d2MRTranCode_16.value = d2MRTranCode_16;
        ObjForm.d2MRBatchNum_16.value = d2MRBatchNum_16;
        ObjForm.d2MRTranId_16.value = d2MRTranId_16;
        ObjForm.d2MRPayingAcctName_16.value = d2MRPayingAcctName_16;
        ObjForm.d2MRBrCode_16.value = d2MRBrCode_16;

        ObjForm.d2MRInstAmt_17.value = d2MRInstAmt_17;
        ObjForm.d2MRInstNum_17.value = d2MRInstNum_17;
        ObjForm.d2MRInstDate_17.value = d2MRInstDate_17;
        ObjForm.d2MRPayingAcctNum_17.value = d2MRPayingAcctNum_17;
        ObjForm.d2MRBankCode_17.value = d2MRBankCode_17;
        ObjForm.d2MRTranCode_17.value = d2MRTranCode_17;
        ObjForm.d2MRBatchNum_17.value = d2MRBatchNum_17;
        ObjForm.d2MRTranId_17.value = d2MRTranId_17;
        ObjForm.d2MRPayingAcctName_17.value = d2MRPayingAcctName_17;
        ObjForm.d2MRBrCode_17.value = d2MRBrCode_17;

        ObjForm.d2MRInstAmt_18.value = d2MRInstAmt_18;
        ObjForm.d2MRInstNum_18.value = d2MRInstNum_18;
        ObjForm.d2MRInstDate_18.value = d2MRInstDate_18;
        ObjForm.d2MRPayingAcctNum_18.value = d2MRPayingAcctNum_18;
        ObjForm.d2MRBankCode_18.value = d2MRBankCode_18;
        ObjForm.d2MRTranCode_18.value = d2MRTranCode_18;
        ObjForm.d2MRBatchNum_18.value = d2MRBatchNum_18;
        ObjForm.d2MRTranId_18.value = d2MRTranId_18;
        ObjForm.d2MRPayingAcctName_18.value = d2MRPayingAcctName_18;
        ObjForm.d2MRBrCode_18.value = d2MRBrCode_18;

        ObjForm.d2MRInstAmt_19.value = d2MRInstAmt_19;
        ObjForm.d2MRInstNum_19.value = d2MRInstNum_19;
        ObjForm.d2MRInstDate_19.value = d2MRInstDate_19;
        ObjForm.d2MRPayingAcctNum_19.value = d2MRPayingAcctNum_19;
        ObjForm.d2MRBankCode_19.value = d2MRBankCode_19;
        ObjForm.d2MRTranCode_19.value = d2MRTranCode_19;
        ObjForm.d2MRBatchNum_19.value = d2MRBatchNum_19;
        ObjForm.d2MRTranId_19.value = d2MRTranId_19;
        ObjForm.d2MRPayingAcctName_19.value = d2MRPayingAcctName_19;
        ObjForm.d2MRBrCode_19.value = d2MRBrCode_19;


        ObjForm.d2MRInstAmt_20.value = d2MRInstAmt_20;
        ObjForm.d2MRInstNum_20.value = d2MRInstNum_20;
        ObjForm.d2MRInstDate_20.value = d2MRInstDate_20;
        ObjForm.d2MRPayingAcctNum_20.value = d2MRPayingAcctNum_20;
        ObjForm.d2MRBankCode_20.value = d2MRBankCode_20;
        ObjForm.d2MRTranCode_20.value = d2MRTranCode_20;
        ObjForm.d2MRBatchNum_20.value = d2MRBatchNum_20;
        ObjForm.d2MRTranId_20.value = d2MRTranId_20;
        ObjForm.d2MRPayingAcctName_20.value = d2MRPayingAcctName_20;
        ObjForm.d2MRBrCode_20.value = d2MRBrCode_20;

	ObjForm.d2MRInstAmt_21.value = d2MRInstAmt_21;
        ObjForm.d2MRInstNum_21.value = d2MRInstNum_21;
        ObjForm.d2MRInstDate_21.value = d2MRInstDate_21;
        ObjForm.d2MRPayingAcctNum_21.value = d2MRPayingAcctNum_21;
        ObjForm.d2MRBankCode_21.value = d2MRBankCode_21;
        ObjForm.d2MRTranCode_21.value = d2MRTranCode_21;
        ObjForm.d2MRBatchNum_21.value = d2MRBatchNum_21;
        ObjForm.d2MRTranId_21.value = d2MRTranId_21;
        ObjForm.d2MRPayingAcctName_21.value = d2MRPayingAcctName_21;
        ObjForm.d2MRBrCode_21.value = d2MRBrCode_21;

        ObjForm.d2MRInstAmt_22.value = d2MRInstAmt_22;
        ObjForm.d2MRInstNum_22.value = d2MRInstNum_22;
        ObjForm.d2MRInstDate_22.value = d2MRInstDate_22;
        ObjForm.d2MRPayingAcctNum_22.value = d2MRPayingAcctNum_22;
        ObjForm.d2MRBankCode_22.value = d2MRBankCode_22;
        ObjForm.d2MRTranCode_22.value = d2MRTranCode_22;
        ObjForm.d2MRBatchNum_22.value = d2MRBatchNum_22;
        ObjForm.d2MRTranId_22.value = d2MRTranId_22;
        ObjForm.d2MRPayingAcctName_22.value = d2MRPayingAcctName_22;
        ObjForm.d2MRBrCode_22.value = d2MRBrCode_22;

        ObjForm.d2MRInstAmt_23.value = d2MRInstAmt_23;
        ObjForm.d2MRInstNum_23.value = d2MRInstNum_23;
        ObjForm.d2MRInstDate_23.value = d2MRInstDate_23;
        ObjForm.d2MRPayingAcctNum_23.value = d2MRPayingAcctNum_23;
        ObjForm.d2MRBankCode_23.value = d2MRBankCode_23;
        ObjForm.d2MRTranCode_23.value = d2MRTranCode_23;
        ObjForm.d2MRBatchNum_23.value = d2MRBatchNum_23;
        ObjForm.d2MRTranId_23.value = d2MRTranId_23;
        ObjForm.d2MRPayingAcctName_23.value = d2MRPayingAcctName_23;
        ObjForm.d2MRBrCode_23.value = d2MRBrCode_23;

        ObjForm.d2MRInstAmt_24.value = d2MRInstAmt_24;
        ObjForm.d2MRInstNum_24.value = d2MRInstNum_24;
        ObjForm.d2MRInstDate_24.value = d2MRInstDate_24;
        ObjForm.d2MRPayingAcctNum_24.value = d2MRPayingAcctNum_24;
        ObjForm.d2MRBankCode_24.value = d2MRBankCode_24;
        ObjForm.d2MRTranCode_24.value = d2MRTranCode_24;
        ObjForm.d2MRBatchNum_24.value = d2MRBatchNum_24;
        ObjForm.d2MRTranId_24.value = d2MRTranId_24;
        ObjForm.d2MRPayingAcctName_24.value = d2MRPayingAcctName_24;
        ObjForm.d2MRBrCode_24.value = d2MRBrCode_24;

        ObjForm.d2MRInstAmt_25.value = d2MRInstAmt_25;
        ObjForm.d2MRInstNum_25.value = d2MRInstNum_25;
        ObjForm.d2MRInstDate_25.value = d2MRInstDate_25;
        ObjForm.d2MRPayingAcctNum_25.value = d2MRPayingAcctNum_25;
        ObjForm.d2MRBankCode_25.value = d2MRBankCode_25;
        ObjForm.d2MRTranCode_25.value = d2MRTranCode_25;
        ObjForm.d2MRBatchNum_25.value = d2MRBatchNum_25;
        ObjForm.d2MRTranId_25.value = d2MRTranId_25;
        ObjForm.d2MRPayingAcctName_25.value = d2MRPayingAcctName_25;
        ObjForm.d2MRBrCode_25.value = d2MRBrCode_25;

}


function hoccm_det2_ONCLICK1(obj)
{
	var retVal = "";
	if (preEventCall('hoccm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnWebUrlCall()) == false) {
		return false;
	}
	if (postEventCall('hoccm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_det2_ONCHANGE2(obj)
{
	var retVal = "";
	if (preEventCall('hoccm_det2',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnd2CrAmtOnChange()) == false) {
		return false;
	}
	if (postEventCall('hoccm_det2',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_det2_ONCLICK3(obj,rowNum)
{
	var retVal = "";
	if (preEventCall('hoccm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnChqImageButton(rowNum)) == false) {
		return false;
	}
	if (postEventCall('hoccm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_det2_ONCLICK4(obj,p1)
{
	var retVal = "";
	if (preEventCall('hoccm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('hoccm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_det2_ONCLICK5(obj,p1)
{
	var retVal = "";
	if (preEventCall('hoccm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValidateData(p1)) == false) {
		return false;
	}
	if (postEventCall('hoccm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_det2_ONCLICK6(obj,p1)
{
	var retVal = "";
	if (preEventCall('hoccm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('hoccm_det2',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnShowHideD1MultiRecFields(){

        var ObjForm = document.forms[0];
        var loc_d1TotalRecords = ""
        if(ObjForm.d1TotalRecords.value != ""){
                loc_d1TotalRecords = ObjForm.d1TotalRecords.value;
        }else{
                ObjForm.d1TotalRecords.value = d1TotalRecords;
                loc_d1TotalRecords = d1TotalRecords;
        }

        if(parseInt(loc_d1TotalRecords) < 5){
                hideImage("d1MRRow5");
        }else{
                showImage("d1MRRow5");
        }

        if(parseInt(loc_d1TotalRecords) < 4){
                hideImage("d1MRRow4");
        }else{
                showImage("d1MRRow4");
        }

        if(parseInt(loc_d1TotalRecords) < 3){
                hideImage("d1MRRow3");
        }else{
                showImage("d1MRRow3");
        }

        if(parseInt(loc_d1TotalRecords) < 2){
                hideImage("d1MRRow2");
        }else{
                showImage("d1MRRow2");
        }

}

function fnDisableD2MRFields(){
	var ObjForm = document.forms[0];

	for(var iIndex=1; iIndex <= 25; iIndex++){
		var tmpString = "d2MRInstAmt_" + iIndex;
		document.getElementById(tmpString).readOnly = true;
		var tmpString = "d2MRInstNum_" + iIndex;
		document.getElementById(tmpString).readOnly = true;
		var tmpString = "d2MRInstDate_" + iIndex;
		document.getElementById(tmpString).readOnly = true;
		var tmpString = "d2MRPayingAcctNum_" + iIndex;
		document.getElementById(tmpString).readOnly = true;
		var tmpString = "d2MRBankCode_" + iIndex;
		document.getElementById(tmpString).readOnly = true;
		var tmpString = "d2MRTranCode_" + iIndex;
		document.getElementById(tmpString).readOnly = true;
		var tmpString = "d2MRBatchNum_" + iIndex;
		document.getElementById(tmpString).readOnly = true;
		var tmpString = "d2MRTranId_" + iIndex;
		document.getElementById(tmpString).readOnly = true;
		var tmpString = "d2MRPayingAcctName_" + iIndex;
		document.getElementById(tmpString).readOnly = true;
		var tmpString = "d2MRBrCode_" + iIndex;
		document.getElementById(tmpString).readOnly = true;
	}
}

function fnPrintD2MultiRecFields(){
    document.write('<input type="hidden" class="textfieldfont" name="' + subGroupName + '.d2TotalRecords" id="d2TotalRecords" size="6" maxlength="6">');
    for(var iIndex=1; iIndex <= 25; iIndex++){
        with(document){
        write('<tr class="searclist1a" id="d2MRRow' + iIndex + '">');

        var tmpString = "d2MRInstAmt_" + iIndex;
        write('<td class="textfield"><input name="chqImageButton_' + iIndex + '" style="width:50px" class="Button" value="Image" type="button" id="chqImageButton_' + iIndex + '" onClick="javascript:return hoccm_det2_ONCLICK3(this,'+ iIndex + ')";><input type="text" style="width:175px" class="textfieldamount" name="' + subGroupName + '.' + tmpString + '" id="' + tmpString + '" + hoccmProps.get("' + tmpString + '_ENABLED") size="23" fdt="amount" maxlength="23"></td>');

	var tmpString = "d2MRInstNum_" + iIndex;
        write('<td class="textfield"><input type="text" style="width:100px" class="textfieldfont" name="' + subGroupName + '.' + tmpString + '" id="' + tmpString + '" + hoccmProps.get("' + tmpString + '_ENABLED") size="16" maxlength="16"></td>');

	var tmpString = "d2MRInstDate_" + iIndex;
        write('<td class="textfield"><input type="text" style="width:100px" class="textfieldfont" name="' + subGroupName + '.' + tmpString + '" id="' + tmpString + '" + hoccmProps.get("' + tmpString + '_ENABLED") size="10" maxlength="10"></td>');

	var tmpString = "d2MRPayingAcctNum_" + iIndex;
        write('<td class="textfield"><input type="text" style="width:140px" class="textfieldfont" name="' + subGroupName + '.' + tmpString + '" id="' + tmpString + '" + hoccmProps.get("' + tmpString + '_ENABLED") size="16" maxlength="16"></td>');

	var tmpString = "d2MRBankCode_" + iIndex;
        write('<td class="textfield"><input type="text" style="width:080px" class="textfieldfont" name="' + subGroupName + '.' + tmpString + '" id="' + tmpString + '" + hoccmProps.get("' + tmpString + '_ENABLED") size="6" maxlength="6"></td>');

	var tmpString = "d2MRTranCode_" + iIndex;
        write('<td class="textfield"><input type="text" style="width:120px" class="textfieldfont" name="' + subGroupName + '.' + tmpString + '" id="' + tmpString + '" + hoccmProps.get("' + tmpString + '_ENABLED") size="10" maxlength="10"></td>');

	var tmpString = "d2MRBatchNum_" + iIndex;
	write('<td class="textfield"><input type="text" style="width:080px" class="textfieldfont" name="' + subGroupName + '.' + tmpString + '" id="' + tmpString + '" + hoccmProps.get("' + tmpString + '_ENABLED") size="10" maxlength="10"></td>');

	var tmpString = "d2MRTranId_" + iIndex;
	write('<td class="textfield"><input type="text" style="width:080px" class="textfieldfont" name="' + subGroupName + '.' + tmpString + '" id="' + tmpString + '" + hoccmProps.get("' + tmpString + '_ENABLED") size="10" maxlength="10"></td>');
	
	var tmpString = "d2MRPayingAcctName_" + iIndex;
	write('<td class="textfield"><input type="text" style="width:200px" class="textfieldfont" name="' + subGroupName + '.' + tmpString + '" id="' + tmpString + '" + hoccmProps.get("' + tmpString + '_ENABLED") size="30" maxlength="30"></td>');

	var tmpString = "d2MRBrCode_" + iIndex;
	write('<td class="textfield"><input type="text" style="width:200px" class="textfieldfont" name="' + subGroupName + '.' + tmpString + '" id="' + tmpString + '" + hoccmProps.get("' + tmpString + '_ENABLED") size="6" maxlength="6"></td>');

        write('</tr>');
	} //End with()
    }
}

function fnShowHideD2MultiRecFields(){

        var ObjForm = document.forms[0];

	if(funcCode != "R"){
		for(var iIndex=1; iIndex <= 25; iIndex++){
			var tmpString = "chqImageButton_" + iIndex;
			document.getElementById(tmpString).disabled = true;			
			hideImage(tmpString);
		}
	}

        var loc_d2TotalRecords = ""
        if(ObjForm.d2TotalRecords.value != ""){
                loc_d2TotalRecords = ObjForm.d2TotalRecords.value;
        }else{
                loc_d2TotalRecords = "0";
        }

	for(var iIndex=25; iIndex >= 1; iIndex--){
		if(parseInt(loc_d2TotalRecords) <= iIndex){
			var tmpString = "d2MRRow" + iIndex;
	                hideImage(tmpString);
	        }else{
	                showImage(tmpString);
	        }
	}

}

