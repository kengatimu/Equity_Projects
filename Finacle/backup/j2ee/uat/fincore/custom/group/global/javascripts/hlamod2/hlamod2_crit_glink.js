function printBlock()
{
	writeCustomHeader("hlamod2_crit");
	with (document){
	write('<input type="hidden" name="hlamod2.myIPAddress" id="myIPAddress">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td><table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Loan Modelling For Resheduling</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr class="innertabletop1">');
	write('<td colspan="5" align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right">');
	write('<a href="javascript:showHelpFile(\'hlamod2crit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0"></a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');

	write('<td class="textlabel">' + jspResArr.get("FLT11000030") + '<font color="red" size="2"> *</font></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" name="' + subGroupName + '.acctId" id="acctId" ' + hlamod2Props.get("acctId_ENABLED") + ' size="20" maxlength="20"  class="textfieldfont" onChange="javascript:fetchAcctDtls(this,\'acctName\',\'acctSolId\',\'acctCrncy\',true,\'VALCUSTACCTID\');">');
	//write('&nbsp;   <a id="sLnk3" target="_self" href="javascript:fnExplodeAcct(document.forms[0].acctId)">');
	//write('<img src="../Renderer/images/' + applangcode + '/explode.gif" width="16" height="16" border="0" explodeId="explode1"></a>');
	write('&nbsp;<a target=_self href="javascript:fnAcctDetFetch();" id="sLnk2" >');
	write('<img hotKeyId="search1" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0"></img></a>');
	write('<input type="text" name="acctCrncy" id="acctCrncy" size="3" maxlength="3"  class="label" readonly="readonly" disabled>');
	write('<input type="text" name="acctSolId" id="acctSolId" size="8" maxlength="8"  class="label" readonly="readonly" disabled>');
    write('<input type="text" name="acctName" id="acctName"  size="50" maxlength="50" class="label" readonly="readonly" disabled>');

write('</td>');
write('<td>&nbsp;</td>');
write('<td>&nbsp;</td>');
write('<td>&nbsp;</td>');
write('</tr>');
write('<tr>');
write('<input type="hidden" id="mode" fdt="fmode" mneb1="N" vFldId="mode_ui" name="' + subGroupName + '.mode">');
write('<input type="hidden" id="resheduleDate" fdt="fdate" mneb1="N" vFldId="resheduleDate_ui" name="' + subGroupName + '.resheduleDate">');

write('<td class="textlabel">' + jspResArr.get("FLT11000031") + '<font color="red" size="2"> *</font></td>');
write('<td class="textfield">');
    write('<input fdt="uidate" class="textfieldfont"  mnebl="false" name="' + subGroupName + '.resheduleDate_ui" id="resheduleDate_ui"   hotKeyId="calender2"  type="text" class="textfieldfont" maxlength="10" value="" onBlur = "javascript:validateReshdlDate(this,this,this);">');
    write('&nbsp; <a  href="javascript:openDate(document.forms[0].resheduleDate_ui,BODDate)"   id="sLnk3"><img    width="24" height="19"  hotKeyId="calender2" src="../Renderer/images/'+applangcode+'/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand" class="img" ></img></a>');
    write('<div style="position:absolute;"></div></td>');
/*	write('<input hotKeyId="search2" type="text" name="' + subGroupName + '.resheduleDate" id="resheduleDate" ' + hlamod2Props.get("resheduleDate_ENABLED") + ' size="20" maxlength="20"  class="textfieldfont" >');
	write('</td>');*/
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000032") + '<font color="red" size="2"> *</font></td>');
	write('<td class="textfield">');
	write('<input type="radio" name="' + subGroupName + '.calcIntForResh" id="calcIntForResh"  ' + hlamod2Props.get("calcIntForResh_ENABLED") + ' value="Y" >Yes');
	write('<input type="radio" name="' + subGroupName + '.calcIntForResh" id="calcIntForResh"  ' + hlamod2Props.get("calcIntForResh_ENABLED") + ' value="N" checked="checked" >No');
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
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<select type="hidden" name="' + subGroupName + '.funcCode" id="funcCode" ' + hlamod2Props.get("funcCode_ENABLED") + ' class="textfieldfont" " onchange="javascript:fnDisableFields(this)">');
	write('<option value = "">--Select--</option>');
	write('<option selected value="A">A - Add</option>');
	write('</select>');
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
	write('<div class="ctable">');
	write('<input type="button" name="Accept" value="Go" class="button" id="Accept" onClick="javascript:return hlamod2_crit_ONCLICK2(this,this);" hotKeyId="Go">');
	write('<input type="button" name="Clear" value="Clear" class="button" id="Clear" onClick="javascript:return hlamod2_crit_ONCLICK3(this);">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];
	ObjForm.funcCode.focus();
	document.getElementById('funcCode').style.visibility = "hidden";
	pre_ONLOAD('hlamod2_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();
	//ObjForm.funcCode.selectedIndex = 1;
	ObjForm.funcCode.value = "A";
	ObjForm.resheduleDate.value = BODDate;
	ObjForm.resheduleDate_ui.value = BODDate;
	ObjForm.acctId.focus();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	post_ONLOAD('hlamod2_crit',this);
}

function fnPopulateControlValues()
{
	var ObjForm = document.forms[0];
	ObjForm.resheduleDate.value = resheduleDate;
	ObjForm.resheduleDate_ui.value = resheduleDate;
	ObjForm.funcCode.value = funcCode;
	ObjForm.calcIntForResh.value = calcIntForResh;
	ObjForm.acctId.value = acctId;
	fnDisableFields();
}


function hlamod2_crit_ONCHANGE1(obj,p1)
{
	var retVal = "";
	if (pre_ONCHANGE('hlamod2_crit',obj) == false) {
		return false;
	}
	if ((retVal = validateUser(p1)) == false) {
		return false;
	}
	if (post_ONCHANGE('hlamod2_crit',obj) == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hlamod2_crit_ONCLICK2(obj,p1)
{
	if (document.forms[0].acctId.value == ""){
		alert("Enter Account Id");
		document.forms[0].acctId.focus();
		return false;
	}

	if (document.forms[0].resheduleDate.value == ""){
		alert("Enter Reshedule Date");
		document.forms[0].funcCode.focus();
		return false;
	}

	if((retVal=fnCommonFetchAcctDtls(document.forms[0].acctId,'acctName','acctSolId','acctCrncy','true',"VALCUSTACCTID"))==false)
	{
			return false;
	}

	var retVal = "";
	if (pre_ONCLICK('hlamod2_crit',obj) == false) {
		return false;
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('hlamod2_crit',obj) == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hlamod2_crit_ONCLICK3(obj)
{
	var retVal = "";
	if (pre_ONCLICK('hlamod2_crit',obj) == false) {
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('hlamod2_crit',obj) == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnValidateData() {
        return true;
}

function fnDisableFields() {
	return true;
}

function fnAcctDetFetch(){
	var ObjForm = document.forms[0];
	showAccountIdList(document.forms[0].acctId,document.forms[0].acctSolId,document.forms[0].acctName,'F',document.forms[0].acctCrncy,'','','LAA');
}

function fetchAcctDtls(acctObj, acctName, acctSol, acctCrncy, isError, fType){
	if(acctObj.value == ""){
			acctName.value = "";
			acctSol.value = "";
			acctCrncy.value = "";
	}

	if((retVal=fnCommonFetchAcctDtls(acctObj,acctName,acctSol,acctCrncy,isError,"VALCUSTACCTID"))==false)
	{
		return false;
	}
}

function validateReshdlDate(obj,p1,p2)
{
    var retVal = "";

    if ((retVal = onBlurFormatDate(p1)) == false) {
        return false;
    }
    if ((retVal = fnAssignDateOnEnter(p2)) == false) {
        return false;
    }

    return (retVal == undefined) ? true : retVal;
}
