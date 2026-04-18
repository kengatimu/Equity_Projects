function printBlock()
{
	
	writeCustomHeader("cbwyorm_det");
	with (document){
	if(funcCode == 'U'){
	writeCustomHeader("cbwyorm_res");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">E-BANKING SWIFT TABLE MAINTENANCE</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	
	write('<table class="ctable1" width="100%" border="0" cellspacing="0" cellpadding="0">');
	write('<tr class="rowspacing">');
	write('<td colspan="5">&nbsp;</td>');
	write('</tr>');
	write('</table>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr class="textfielddisplaylabel1" valign="middle">');
	write('<td colspan="5">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="resultpage">');
	write('<tr>');
	write('<td width="3%">');
	write('<img class="img" src="../Renderer/images/info.gif" width="29" height="29" align="right" border="0">');
	write('</img></td>');
	write('<td width="97%" style="color:black">All files are uploaded successfully </td>');
	write('</tr>');
	write('</table>');
	write('</td></tr>');
	write('</table></td></tr>');
	write('</table></td></tr>');
	write('</table></td></tr>');
	write('</table>');
	} 

	}
	if(funcCode != 'U'){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">DETAILS OF LODGED BILL ID</td>');
	write('</tr>');
	write('</table>');
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
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000017") + '</td>');
	write('<td><input name="' + subGroupName + '.funcCode" id="funcCode" ' + cbwyormProps.get("funcCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >'); 
	write('<br>');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000018") + '</td>');
	write('<td><input name="' + subGroupName + '.srlNum" id="srlNum" ' + cbwyormProps.get("srlNum_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >'); 
	write('<br>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000001") + '</td>');
	write('<td><input name="' + subGroupName + '.ormreqId" id="ormreqId" ' + cbwyormProps.get("ormreqId_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" disabled="true">');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000002") + '</td>');
	write('<td><input name="' + subGroupName + '.operAcct" id="operAcct" ' + cbwyormProps.get("operAcct_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" disabled="true" >');
	write('<br>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000003") + '</td>');
	write('<td><input name="' + subGroupName + '.Currency" id="Currency" ' + cbwyormProps.get("Currency_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >');
	write('<br>');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000004") + '</td>');
	write('<td><input name="' + subGroupName + '.operChrgAcct" id="operChrgAcct" ' + cbwyormProps.get("operChrgAcct_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >');
	write('<br>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000005") + '</td>');
	write('<td><input name="' + subGroupName + '.valueDate" id="valueDate" ' + cbwyormProps.get("valueDate_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000007") + '</td>');
	write('<td><input name="' + subGroupName + '.drCustAddr1" id="drCustAddr1" ' + cbwyormProps.get("drCustAddr1_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000006") + '</td>');
	write('<td><input name="' + subGroupName + '.amount" id="amount" ' + cbwyormProps.get("amount_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000008") + '</td>');
	write('<td><input name="' + subGroupName + '.drCustName" id="drCustName" ' + cbwyormProps.get("drCustName_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000009") + '</td>');
	write('<td><input name="' + subGroupName + '.drCustAddr2" id="drCustAddr2" ' + cbwyormProps.get("drCustAddr2_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000010") + '</td>');
	write('<td><input name="' + subGroupName + '.drCustAddr3" id="drCustAddr3" ' + cbwyormProps.get("drCustAddr3_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000011") + '</td>');
	write('<td><input name="' + subGroupName + '.drCustCntry" id="drCustCntry" ' + cbwyormProps.get("drCustCntry_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >');
	write('</td>');

	write('<td class="textlabel">' + jspResArr.get("FLT000012") + '</td>');
	write('<td><input name="' + subGroupName + '.crCustName" id="crCustName" ' + cbwyormProps.get("crCustName_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000013") + '</td>');
	write('<td><input name="' + subGroupName + '.crCustAddr1" id="crCustAddr1" ' + cbwyormProps.get("crCustAddr1_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >');
	write('</td>');

	write('<td class="textlabel">' + jspResArr.get("FLT000014") + '</td>');
	write('<td><input name="' + subGroupName + '.crCustAddr2" id="crCustAddr2" ' + cbwyormProps.get("crCustAddr2_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000015") + '</td>');
	write('<td><input name="' + subGroupName + '.crCustAddr3" id="crCustAddr3" ' + cbwyormProps.get("crCustAddr3_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000016") + '</td>');
	write('<td><input name="' + subGroupName + '.crCustCntry" id="crCustCntry" ' + cbwyormProps.get("crCustCntry_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >'); 
	write('</td>');
	write('</tr>');
	if(funcCode == 'M'){
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000019") + '</td>');
	write('<td><input name="' + subGroupName + '.beneBankBic" id="beneBankBic" ' + cbwyormProps.get("beneBankBic_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25"  >'); 
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000020") + '</td>');
	write('<td><input name="' + subGroupName + '.payeeCor" id="payeeCor" ' + cbwyormProps.get("payeeCor_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25"  >'); 
	write('</td>');
	write('</tr>');
	}else{
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000019") + '</td>');
	write('<td><input name="' + subGroupName + '.beneBankBic" id="beneBankBic" ' + cbwyormProps.get("beneBankBic_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true"  >'); 
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000020") + '</td>');
	write('<td><input name="' + subGroupName + '.payeeCor" id="payeeCor" ' + cbwyormProps.get("payeeCor_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true"  >'); 
	write('</td>');
	write('</tr>');
	}
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000021") + '</td>');
	write('<td><input name="' + subGroupName + '.lodgeBillId" id="lodgeBillId" ' + cbwyormProps.get("lodgeBillId_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >'); 
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000022") + '</td>');
	write('<td><input name="' + subGroupName + '.billRelDate" id="billRelDate" ' + cbwyormProps.get("billRelDate_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >'); 
	write('</td>');
	write('</tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000023") + '</td>');
	write('<td><input name="' + subGroupName + '.status" id="status" ' + cbwyormProps.get("status_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true" >'); 
	write('</td>');
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
	}
	} 
} 

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
	if(funcCode !='U' && funcCode != 'I'){
	write('<div class="ctable">');
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cbwyorm_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cbwyorm_det_ONCLICK2(this);" id="Clear" value="Cancel">');
	}
	else{
	write('&nbsp;<input class="button" type="button" id="Back" value="OK" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	}
}

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('cbwyorm_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}
	
	fnPopulateControlValues();
	
	//alert(funcCode);

	if(funcCode =='I' || funcCode =='D'){
		fnDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cbwyorm_det',this);
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	if(funcCode=='M'){ funcDis =" - Modify"; }
	if(funcCode=='I'){ funcDis =" - Inquire"; }
	if(funcCode=='D'){ funcDis =" - Delete"; }
	funcCode=funcCode+funcDis;
	if(funcCode != 'U'){
	var ObjForm = document.forms[0];
	ObjForm.funcCode.value=funcCode;
	ObjForm.srlNum.value=tsrlNum;
	ObjForm.ormreqId.value=treqId;
	ObjForm.operAcct.value=toperActId;
	ObjForm.Currency.value=tcrncy;
	ObjForm.operChrgAcct.value=toperChrgActId;
	ObjForm.valueDate.value=tvalueDate;
	ObjForm.amount.value=tamount;
	ObjForm.drCustAddr1.value=tdrCustAddr1;
	ObjForm.drCustName.value=tdrCustName;
	ObjForm.drCustAddr2.value=tdrCustAddr2;
	ObjForm.drCustAddr3.value=tdrCustAddr3;
	ObjForm.drCustCntry.value=tdrCustCntry;
	ObjForm.crCustName.value=tcrCustName;
	ObjForm.crCustAddr1.value=tcrCustAddr1;
	ObjForm.crCustAddr2.value=tcrCustAddr2;
	ObjForm.crCustAddr3.value=tcrCustAddr3;
	ObjForm.crCustCntry.value=tcrCustCntry;
	ObjForm.beneBankBic.value=tbeneBankBic;
	ObjForm.payeeCor.value=tpayeeCor;
	ObjForm.lodgeBillId.value=tlodgeBillId;
	ObjForm.billRelDate.value=tbillRelDate;
	ObjForm.status.value=tstatus;
	}
	return true;
}

function cbwyorm_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('cbwyorm_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('cbwyorm_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cbwyorm_det_ONCLICK2(obj)
{
	var retVal = "";
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
