function printBlock()
{
	writeCustomHeader("hoccm_crit");
	with (document){
	write('<input type="hidden" name="nextPage" id="nextPage">');
	write('<input type="hidden" id="zoneDate" fdt="fdate" mneb1="N" vFldId="zoneDate_ui" name="' + subGroupName + '.zoneDate">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT013122") + '</td>');
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
	write('<a href="javascript:showHelpFile(\'HOCCM_crit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT112254") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode"  fmnd="' + hoccmProps.get("funcCode_MANDATORY") + '" ' + hoccmProps.get("funcCode_ENABLED") + ' class="listboxfont"	onChange="javascript:return hoccm_crit_ONCHANGE1(this);">');
	write('<OPTION VALUE="">' + jspResArr.get("FLT700022") + '</OPTION>');
	write('<OPTION VALUE="L">' + jspResArr.get("FLT031837") + '</OPTION>');
	write('<OPTION VALUE="D">' + jspResArr.get("FLT034012") + '</OPTION>');
	write('<OPTION VALUE="R">' + jspResArr.get("FLT031838") + '</OPTION>');
	write('<OPTION VALUE="P">' + jspResArr.get("FLT031839") + '</OPTION>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031831") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.critCrAcctNum" id="critCrAcctNum"  fmnd="' + hoccmProps.get("critCrAcctNum_MANDATORY") + '" ' + hoccmProps.get("critCrAcctNum_ENABLED") + ' size="16" maxlength="16" onChange="javascript:fnFetchAcctName(document.forms[0].critCrAcctNum.value)" >&nbsp;');
	write('<a href="javascript:fnShowAccNumCrit()">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('<br><input name="' + subGroupName + '.critSolId" id="critSolId" type="text" class="label" size="10" maxlength="8" readonly="readonly" disabled />');
	write('<input name="' + subGroupName + '.critAcctName" id="critAcctName" type="text" class="label" size="50" maxlength="80" readonly="readonly" disabled/>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT007523") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search2" type="text" class="textfieldfont" name="' + subGroupName + '.zoneCode" id="zoneCode"  fmnd="' + hoccmProps.get("zoneCode_MANDATORY") + '" ' + hoccmProps.get("zoneCode_ENABLED") + ' size="10" maxlength="10"	onChange="javascript:return hoccm_crit_ONCHANGE2(this);">&nbsp;');
	write('<a href="javascript:fnZoneCodeSearcher()">');
	write('<img border="0" height="17" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000637") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input  hotKeyId="calender1"  type="text" class="textfieldfont" fdt="uidate"  mnebl="false" onBlur="javascript:return hoccm_crit_ONBLUR3(this,this,this);" name="' + subGroupName + '.zoneDate_ui" id="zoneDate_ui"  size="10" maxlength="10">&nbsp;');
	write('<a  href="javascript:openDate(document.forms[0].zoneDate_ui,BODDate)"   id="sLnk2"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT009829") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.zoneCCY" id="zoneCCY"  fmnd="' + hoccmProps.get("zoneCCY_MANDATORY") + '" ' + hoccmProps.get("zoneCCY_ENABLED") + ' size="3" maxlength="3">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031832") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input type="radio" name="' + subGroupName + '.smInstrument" id="smInstrument"  fmnd="' + hoccmProps.get("smInstrument_MANDATORY") + '" ' + hoccmProps.get("smInstrument_ENABLED") + ' value="S">Single');
	write('<input type="radio" name="' + subGroupName + '.smInstrument" id="smInstrument"  fmnd="' + hoccmProps.get("smInstrument_MANDATORY") + '" ' + hoccmProps.get("smInstrument_ENABLED") + ' value="M">Multiple');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031833") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noOfChq" id="noOfChq" ' + hoccmProps.get("noOfChq_ENABLED") + ' size="10" maxlength="10">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031834") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" style="text-align: right" name="' + subGroupName + '.totalCrAmt" id="totalCrAmt" ' + hoccmProps.get("totalCrAmt_ENABLED") + ' size="23" maxlength="23"	onChange="javascript:return hoccm_crit_ONCHANGE4(this);">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT000611") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.setNum" id="setNum" ' + hoccmProps.get("setNum_ENABLED") + ' size="6" maxlength="6"	onChange="javascript:return hoccm_crit_ONCHANGE5(this);">&nbsp;');
	write('<a id="setNumImg" href="javascript:showSetNumList()">');
        write('<img border="0" alt="Search List" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>&nbsp;');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT007661") + '</td>');
	write('<td class="textfield">');
	write('<input type="radio" name="' + subGroupName + '.billPayYes" id="billPayYes" ' + hoccmProps.get("billPayYes_ENABLED") + ' value="Y" onclick="javascript:return hoccm_crit_ONCLICK6(this);">Yes');
	write('<input type="radio" name="' + subGroupName + '.billPayYes" id="billPayYes" ' + hoccmProps.get("billPayYes_ENABLED") + ' value="N" checked="checked" onclick="javascript:return hoccm_crit_ONCLICK7(this);">No');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.hoccmFuncDesc" id="hoccmFuncDesc" ' + hoccmProps.get("hoccmFuncDesc_ENABLED") + ' style="visibility: hidden; width: 0px">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.valType" id="valType" ' + hoccmProps.get("valType_ENABLED") + ' readonly="readonly" style="visibility: hidden; width: 0px">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031835") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.critBatchNum" id="critBatchNum" ' + hoccmProps.get("critBatchNum_ENABLED") + ' size="22" maxlength="22">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031836") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.critTranId" id="critTranId" ' + hoccmProps.get("critTranId_ENABLED") + ' size="16" maxlength="16"	onChange="javascript:return hoccm_crit_ONCHANGE8(this);">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.billerCode" id="billerCode" ' + hoccmProps.get("billerCode_ENABLED") + ' readonly="readonly" style="visibility: hidden; width: 0px" />');	
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT007530") + '</td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search3" type="text" class="textfieldfont" name="' + subGroupName + '.billerId" id="billerId" ' + hoccmProps.get("billerId_ENABLED") + '	onBlur="javascript:return hoccm_crit_ONBLUR9(this);"" maxlength="10">&nbsp;');
	write('<a href="javascript:fnBillerId()" id="billerIdSerch">');
	write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.zoneIdentifier" id="zoneIdentifier" ' + hoccmProps.get("zoneIdentifier_ENABLED") + ' style="visibility: hidden; width: 0px">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.responseValue" id="responseValue" ' + hoccmProps.get("responseValue_ENABLED") + ' style="visibility: hidden; width: 0px">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031859") + '</td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search4" type="text" class="textfieldfont" name="' + subGroupName + '.typOfServ" id="typOfServ" ' + hoccmProps.get("typOfServ_ENABLED") + '>&nbsp;');
	write('<a href="javascript:fnTypOfServ()" id="typOfServiceSerchr">');
	write('<img border="0" height="17" hotKeyId="search4" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.hoccmBankId" id="hoccmBankId" ' + hoccmProps.get("hoccmBankId_ENABLED") + ' style="visibility: hidden; width: 0px">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.hoccmUserId" id="hoccmUserId" ' + hoccmProps.get("hoccmUserId_ENABLED") + ' style="visibility: hidden; width: 0px">');
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
	write('<div class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return hoccm_crit_ONCLICK10(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return hoccm_crit_ONCLICK11(this);"">');
	write('<input id="Accept" name="Go" type="button" class="button" value="' + jspResArr.get("FLT011439") + '"	onClick="javascript:return hoccm_crit_ONCLICKVPH(this,this);" hotKeyId="Go"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('hoccm_crit',this);

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
	
	post_ONLOAD('hoccm_crit',this);

	if(SzoneCode != "null")
	{
		//alert("Inside");
		ObjForm.zoneCode.value = SzoneCode;
		ObjForm.funcCode.value = SfuncCode;

		fnFunctionOnchange();
		fnZoneCodeOnchange();
		ObjForm.critCrAcctNum.focus();
	}

	
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	if (fnIsNull(ObjForm.funcCode.value))
	{
		alert(jspErrResArr.get("FAT000924"));
		ObjForm.funcCode.focus();
		return false;
	}
	if (fnIsNull(ObjForm.critCrAcctNum.value))
	{
		alert(jspErrResArr.get("FAT000924"));
		ObjForm.critCrAcctNum.focus();
		return false;
	}
	if (fnIsNull(ObjForm.zoneCode.value))
	{
		alert(jspErrResArr.get("FAT000924"));
		ObjForm.zoneCode.focus();
		return false;
	}
	if (fnIsNull(ObjForm.zoneDate_ui.value))
	{
		alert(jspErrResArr.get("FAT000924"));
		ObjForm.zoneDate_ui.focus();
		return false;
	}
	if (fnIsNull(ObjForm.zoneCCY.value))
	{
		alert(jspErrResArr.get("FAT000924"));
		ObjForm.zoneCCY.focus();
		return false;
	}
	if (fnIsNull(getRadioValue(ObjForm.smInstrument)))
	{
		checkAndFocusRadio(ObjForm.smInstrument,0);
		return false;
	}
	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.funcCode.value = funcCode;
	ObjForm.critCrAcctNum.value = critCrAcctNum;
	ObjForm.zoneCode.value = zoneCode;
	ObjForm.zoneDate.value = zoneDate;
	ObjForm.zoneCCY.value = zoneCCY;
	ObjForm.smInstrument.value = smInstrument;
	ObjForm.noOfChq.value = noOfChq;
	ObjForm.totalCrAmt.value = totalCrAmt;
	ObjForm.setNum.value = setNum;
	ObjForm.billPayYes.value = billPayYes;
	ObjForm.hoccmFuncDesc.value = hoccmFuncDesc;
	ObjForm.valType.value = valType;
	ObjForm.critBatchNum.value = critBatchNum;
	ObjForm.critTranId.value = critTranId;
	ObjForm.billerCode.value = billerCode;
	ObjForm.billerId.value = billerId;
	ObjForm.zoneIdentifier.value = zoneIdentifier;
	ObjForm.responseValue.value = responseValue;
	ObjForm.typOfServ.value = typOfServ;
	ObjForm.hoccmBankId.value = hoccmBankId;
	ObjForm.hoccmUserId.value = hoccmUserId;
	fnCheckControls();

}

function fnCheckControls()
{
	var ObjForm = document.forms[0];

	checkRadio(ObjForm.smInstrument,smInstrument);
	checkRadio(ObjForm.billPayYes,billPayYes);
}


function hoccm_crit_ONCHANGE1(obj)
{
	var retVal = "";
	if (preEventCall('hoccm_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnFunctionOnchange()) == false) {
		return false;
	}
	if (postEventCall('hoccm_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_crit_ONCHANGE2(obj)
{
	var retVal = "";
	if (preEventCall('hoccm_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnZoneCodeOnchange()) == false) {
		return false;
	}
	if (postEventCall('hoccm_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_crit_ONBLUR3(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('hoccm_crit',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = onBlurFormatDate(p1)) == false) {
		return false;
	}
	if ((retVal = fnAssignDateOnEnter(p2)) == false) {
		return false;
	}
	if (postEventCall('hoccm_crit',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_crit_ONCHANGE4(obj)
{
	var retVal = "";
	if (preEventCall('hoccm_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnTotalCrAmtOnChange()) == false) {
		return false;
	}
	if (postEventCall('hoccm_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_crit_ONCHANGE5(obj)
{
	var retVal = "";
	if (preEventCall('hoccm_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnSetNumOnChange()) == false) {
		return false;
	}
	if (postEventCall('hoccm_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_crit_ONCLICK6(obj)
{
	var retVal = "";
	if (preEventCall('hoccm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnClickBillPay()) == false) {
		return false;
	}
	if (postEventCall('hoccm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_crit_ONCLICK7(obj)
{
	var retVal = "";
	if (preEventCall('hoccm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnClickBillPay()) == false) {
		return false;
	}
	if (postEventCall('hoccm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_crit_ONCHANGE8(obj)
{
	var retVal = "";
	if (preEventCall('hoccm_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnCritTranIdOnChange()) == false) {
		return false;
	}
	if (postEventCall('hoccm_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_crit_ONBLUR9(obj)
{
	var retVal = "";
	if (preEventCall('hoccm_crit',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = fnOnblurBillerId()) == false) {
		return false;
	}
	if (postEventCall('hoccm_crit',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hoccm_crit_ONCLICK10(obj,p1)
{
	//alert("vp");
	var retVal = "";
	if (preEventCall('hoccm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnCallVPH(p1)) == false) {
		return false;
	}
	if (postEventCall('hoccm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function hoccm_crit_ONCLICKVPH(obj,p1)
{
        var retVal = "";
        if (preEventCall('hoccm_crit',obj,'ONCLICK') == false) {
                return false;
        }
        if ((retVal =  fnValAndSubmit(p1)) == false) {
                return false;
        }
        if (postEventCall('hoccm_crit',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function hoccm_crit_ONCLICK11(obj)
{
	var retVal = "";
	if (preEventCall('hoccm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('hoccm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

