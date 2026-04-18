function printBlock()
{
	writeCustomHeader("hlamod2_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td class="page-heading" >Loan Modelling For Resheduling</td>');
	write('</tr>');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0" width="100%">');
	write('<tr>');
	write('<td> </td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000033") + '</td>');
	write('<td class="textfielddisplaylabel">'+acctId+'</td>');
	write('<td class="textlabel">Reshedule Date</td>');
	write('<td class="textfielddisplaylabel">'+resheduleDate+'</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">Calc Int upto Reshdl Date</td>');
	write('<td class="textfielddisplaylabel">'+calcIntForResh+'</td>');
	write('</td>');
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
	write('<a href="javascript:showHelpFile(\'hlamod2_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000034")  + '<font color="red" size="2"> *</font></td>');
	write('<td><input name="' + subGroupName + '.loanOutstanding" id="loanOutstanding" ' + hlamod2Props.get("loanOutstanding_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onchange="javascript:onchngFormatNum(this)">');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000035")  + '<font color="red" size="2"> *</font></td>');
	write('<td><input name="' + subGroupName + '.instalments" id="instalments" ' + hlamod2Props.get("instalments_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onchange="javascript:onchngFormatNum(this)">');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000036")  + '<font color="red" size="2"> *</font></td>');
	write('<td><input name="' + subGroupName + '.intRate" id="intRate" ' + hlamod2Props.get("intRate_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onchange="javascript:onchngFormatNum(this)">');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000037") + '<font color="red" size="2"> *</font></td>');
	write('<td><input name="' + subGroupName + '.emiAmt" id="emiAmt" ' + hlamod2Props.get("emiAmt_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onchange="javascript:onchngFormatNum(this)">');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000039") + '</td>');
	write('<td><input name="' + subGroupName + '.prepayAmt" id="prepayAmt" ' + hlamod2Props.get("prepayAmt_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onchange="javascript:onchngFormatNum(this)">');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000040") + '</td>');
	write('<td><select name="' + subGroupName + '.eiFreqncy" id="eiFreqncy" ' + hlamod2Props.get("eiFreqncy_ENABLED") + ' class="textfieldfont" " >');
	write('<option selected value = "">--Select--</option>');
	write('<option value="D">D - DAILY</option>');
	write('<option value="W">W - WEEKLY</option>');
	write('<option value="M">M - MONTHLY</option>');
	write('<option value="F">F - FORTNIGHTLY</option>');
	write('<option value="Q">Q - QUARTERLY</option>');
	write('<option value="H">H - HALF-YEARLY</option>');
	write('<option value="Y">Y - YEARLY</option>');
	write('</select>');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000041") + '</td>');
	write('<td><select name="' + subGroupName + '.compFreqncy" id="compFreqncy" ' + hlamod2Props.get("compFreqncy_ENABLED") + ' class="textfieldfont" " >');
	write('<option selected value = "">--Select--</option>');
	write('<option value="D">D - DAILY</option>');
	write('<option value="W">W - WEEKLY</option>');
	write('<option value="M">M - MONTHLY</option>');
	write('<option value="F">F - FORTNIGHTLY</option>');
	write('<option value="Q">Q - QUARTERLY</option>');
	write('<option value="H">H - HALF-YEARLY</option>');
	write('<option value="Y">Y - YEARLY</option>');
	write('</select>');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000042") + '</td>');
	write('<td><select name="' + subGroupName + '.eiFormFlg" id="eiFormFlg" ' + hlamod2Props.get("eiFormFlg_ENABLED") + ' class="textfieldfont" " >');
	write('<option selected value = "">--Select--</option>');
	write('<option value="P">P - PMT Formula</option>');
	write('<option value="M">M - EMI Formula</option>');
	write('<option value="F">F - Flat Rate</option>');
	write('<option value="R">R - Rule of 78</option>');
	write('</select>');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000043") + '</td>');
	write('<td class="textfield">');
	write('<input type="radio" name="' + subGroupName + '.capitaliseInt" id="capitaliseInt"  ' + hlamod2Props.get("capitaliseInt_ENABLED") + ' value="Y" >Yes');
	write('<input type="radio" name="' + subGroupName + '.capitaliseInt" id="capitaliseInt"  ' + hlamod2Props.get("capitaliseInt_ENABLED") + ' value="N" checked="checked" >No');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000044") + '</td>');
	write('<td class="textfield">');
	write('<input type="radio" name="' + subGroupName + '.caryOverdueDmd" id="caryOverdueDmd"  ' + hlamod2Props.get("caryOverdueDmd_ENABLED") + ' value="Y" >Yes');
	write('<input type="radio" name="' + subGroupName + '.caryOverdueDmd" id="caryOverdueDmd"  ' + hlamod2Props.get("caryOverdueDmd_ENABLED") + ' value="N" checked="checked" >No');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000045") + '</td>');
	write('<td><select name="' + subGroupName + '.intBaseMethod" id="intBaseMethod" ' + hlamod2Props.get("intBaseMethod_ENABLED") + ' class="textfieldfont" " >');
	write('<option selected value = "">--Select--</option>');
	write('<option value="D">D - DAILY</option>');
	write('<option value="M">M - MONTHLY</option>');
	write('</select>');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000046")  + '</td>');
	write('<td><input name="' + subGroupName + '.noofDay" id="noofDay" ' + hlamod2Props.get("noofDay_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000047") + '</td>');
	write('<td><input name="' + subGroupName + '.leapYrAdj" id="leapYrAdj" ' + hlamod2Props.get("leapYrAdj_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('</tr>');

	write('<tr>');
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return hlamod2_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return hlamod2_det_ONCLICK2(this);" id="Clear" value="Cancel">');
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
	pre_ONLOAD('hlamod2_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('hlamod2_det',this);
	ObjForm.noofDay.disabled = true;
	ObjForm.leapYrAdj.disabled = true;

	if(calculatedAmt != ""){
		alert(calculatedAmt);
	}
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues()
{
	var ObjForm = document.forms[0];
	//ObjForm.acctId.value=acctId;
	ObjForm.loanOutstanding.value = loanOutstanding;
	formatAmt(ObjForm.loanOutstanding,0);
	ObjForm.instalments.value = instalments;
	formatAmt(ObjForm.instalments,0);
	ObjForm.intRate.value = intRate;
	formatAmt(ObjForm.intRate,2);
	ObjForm.emiAmt.value = emiAmt;
	formatAmt(ObjForm.emiAmt,0);
	ObjForm.prepayAmt.value = prepayAmt;
	formatAmt(ObjForm.prepayAmt,0);
	ObjForm.eiFreqncy.value = eiFreqncy;
	ObjForm.compFreqncy.value = compFreqncy;
	ObjForm.eiFormFlg.value = eiFormFlg;
	if ( capitaliseInt == "Y" )	{
		eleCapitaliseInt = document.getElementsByName("capitaliseInt");
		eleCapitaliseInt[0].checked = true;
	}
	else {
		eleCapitaliseInt = document.getElementsByName("capitaliseInt");
		eleCapitaliseInt[1].checked = true;
	}

	if ( caryOverdueDmd == "O" )	{
		eleCaryOverdueDmd = document.getElementsByName("caryOverdueDmd");
		eleCaryOverdueDmd[0].checked = true;
	}
	else {
		eleCaryOverdueDmd = document.getElementsByName("caryOverdueDmd");
		eleCaryOverdueDmd[1].checked = true;
	}

	ObjForm.intBaseMethod.value = intBaseMethod;
	ObjForm.noofDay.value = noofDay;
	ObjForm.leapYrAdj.value = leapYrAdj;
	return true;
}


function IsNumeric(sText)
{
	var ValidChars = "0123456789.,", IsNumber=true, Char;
	for (i = 0;i < sText.length && IsNumber == true;i++)
	{
			Char = sText.charAt(i);
			if(ValidChars.indexOf(Char) == -1)
			IsNumber = false;
	}
	return IsNumber;
}

function hlamod2_det_ONCLICK1(obj,p1)
{
	var ObjForm = document.forms[0];

	if(!IsNumeric(document.forms[0].loanOutstanding.value) )
	{
		alert("loan outstanding amount field  should contain only Numeric values");
		document.forms[0].loanOutstanding.focus();
		return false;
	}

	if(ObjForm.intRate.value==""){
		alert("Enter loan interest rate");
		ObjForm.intRate.focus();
		return false;
	}

	if(!IsNumeric(document.forms[0].intRate.value) )
	{
		alert("Enter valid interest rate");
		document.forms[0].intRate.focus();
		return false;
	}

	var retVal = "";
	if (pre_ONCLICK('hlamod2_det',obj) == false) {
		return false;
	}

	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}

	if (post_ONCLICK('hlamod2_det',obj) == false) {
	return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hlamod2_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('hlamod2_det',obj) == false) {
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('hlamod2_det',obj) == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function onchngFormatNum(obj)
{
	if( obj.value != "" )
	{
		if(!IsNumeric(obj.value) )
		{
			alert("Enter valid number");
			obj.focus();
			return false;
		}

		var amt = obj.value;
		amt = amt.replace(new RegExp(',','g'),"");
		amt = parseFloat(amt,2);

		obj.value = amt;
		if (obj.id =="intRate" ) {
			obj.value = formatToMillion1(obj.value, 2);
		}
		else {
			obj.value = formatToMillion1(obj.value, 0);
		}
	}
}

function formatAmt(obj)
{
	if (obj.id =="intRate" ) {
		obj.value = formatToMillion1(obj.value, 2);
	}
	else {
		obj.value = formatToMillion1(obj.value, 0);
	}
}
