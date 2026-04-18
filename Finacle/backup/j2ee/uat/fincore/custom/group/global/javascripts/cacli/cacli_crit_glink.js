function printBlock()
{
	writeCustomHeader("cacli_crit");
	with (document){
	write('<input type="hidden" name="cacli.funcCode" id="funcCode" value="I">');
	write('<input type="hidden" id="fromDate" fdt="fdate" mneb1="N" vFldId="fromDate_ui" name="' + subGroupName + '.fromDate">');
	write('<input type="hidden" id="toDate" fdt="fdate" mneb1="N" vFldId="toDate_ui" name="' + subGroupName + '.toDate">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td>');
	write('<h1 class="page-heading">' + jspResArr.get("FLT003425") + '</h1>');
	write('</td>');
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
	write('<td  height="25" colspan="5" align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right">');
	write('<a href="javascript:showHelpFile(\'haclicrit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel"> Target Bank <script>setMandatory("Y");</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.targetEntity" id="targetEntity" size="24" maxlength="2" onBlur="javascript:return showEntityDesc();" ' + cacliProps.get("targetEntity_ENABLED") + '>');
	write('&nbsp;<a id="searcher" href="javascript:showEntityList()">');
	write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search1"></img></a>&nbsp;');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">');
	write('<input type="text" class="label" id="targetEntityDesc" name="' + subGroupName + '.targetEntityDesc" size="50" maxlength="50" >&nbsp;');
	write('</td>');
	write('<td class="textlabel">&nbsp;</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel" style="height: 15px; width: 57px">' + jspResArr.get("FLT028446") + '');
	write('<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" onChange="javascript:return cacli_crit_ONCHANGE5(this);" class="textfieldfont" name="' + subGroupName + '.acctID" id="acctID" ' + cacliProps.get("acctID_ENABLED") + '>');
	write('&nbsp;<a href="javascript:fnShowAccNum()" id="sLnk2">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">');
	write('<input id="crncyCode" name="' + subGroupName + '.crncyCode" type="text" disabled="true" class="label" size="3" maxlength="3" fdt="default" fds="Y">');
	write('&nbsp;&nbsp;&nbsp;<input id="solId" name="' + subGroupName + '.solId" type="text" disabled="true" class="label" size="8" maxlength="8" fdt="default" fds="Y">');
	write('</td>');
	write('<td class="textlabel">');
	write('<input id="acctName" name="' + subGroupName + '.acctName" type="text" disabled="true" class="label" size="25" maxlength="25" fdt="default" fds="Y">');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT007733") + '</td>');
	write('<td class="textfield">');
	write('<input  hotKeyId="calender1"  type="text" class="textfieldfont" fdt="uidate"  mnebl="false" onBlur="javascript:return cacli_crit_ONBLUR1(this,this,this);" name="' + subGroupName + '.fromDate_ui" id="fromDate_ui" >');
	write('<a  href="javascript:openDate(document.forms[0].fromDate_ui,BODDate)"   id="sLnk2"><img alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
	write('</a>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel" style="width: 59px">' + jspResArr.get("FLT007734") + '</td>');
	write('<td class="textfield">');
	write('<input  hotKeyId="calender2"  type="text" class="textfieldfont" fdt="uidate"  mnebl="false" onBlur="javascript:return cacli_crit_ONBLUR2(this,this,this);" name="' + subGroupName + '.toDate_ui" id="toDate_ui" >');
	write('<a  href="javascript:openDate(document.forms[0].toDate_ui,BODDate)"   id="sLnk3"><img alt="Date picker" border="0" height="19"  hotKeyId="calender2" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT017515") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont"  style="text-align: right" size="23" maxlength="17" onBlur="javascript:return cacli_crit_ONBLUR6(this);" name="' + subGroupName + '.fromAmt" id="fromAmt" ' + cacliProps.get("fromAmt_ENABLED") + '>');
	write('</td>');
	write('<td style="height: 15px"></td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT017516") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" style="text-align: right" size="23" maxlength="17" onBlur="javascript:return cacli_crit_ONBLUR7(this);" name="' + subGroupName + '.toAmt" id="toAmt" ' + cacliProps.get("toAmt_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px; width: 118px">' + jspResArr.get("FLT025010") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.fromInstrumentNo" id="fromInstrumentNo" ' + cacliProps.get("fromInstrumentNo_ENABLED") + '>');
	write('</td>');
	write('<td></td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT025011") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.toInstrumentNo" id="toInstrumentNo" ' + cacliProps.get("toInstrumentNo_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT014303") + '</td>');
	write('<td style="width: 254px">');
	write('<input type="radio" name="' + subGroupName + '.orderBy" value="T" id="orderBy" ' + cacliProps.get("orderBy_ENABLED") + ' checked>General Ledger Date ');
	write('<input type="radio" name="' + subGroupName + '.orderBy" value="L" id="orderBy" ' + cacliProps.get("orderBy_ENABLED") + '>Value Date');
	write('</td>');
	write('<td></td>');
	write('<td class="textlabel" style="height: 15px; width: 134px">' + jspResArr.get("FLT014287") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.lastNTran" id="lastNTran" ' + cacliProps.get("lastNTran_ENABLED") + '>');
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
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return cacli_crit_ONCLICK3(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return cacli_crit_ONCLICK4(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('cacli_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();
	fnDefaultPopulation();

	fnAssignDateOnLoad(ObjForm);

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	post_ONLOAD('cacli_crit',this);
	ObjForm.targetEntity.focus();
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	
	var ObjForm = document.forms[0];

	ObjForm.acctID.value = acctID;
	ObjForm.fromDate.value = fromDate;
	ObjForm.toDate.value = toDate;
	ObjForm.fromAmt.value = fromAmt;
	ObjForm.toAmt.value = toAmt;
	ObjForm.fromInstrumentNo.value = fromInstrumentNo;
	ObjForm.toInstrumentNo.value = toInstrumentNo;
	ObjForm.orderBy.value = orderBy;
	ObjForm.lastNTran.value = lastNTran;
	ObjForm.targetEntity.value =targetEntity;
	ObjForm.targetEntityDesc.value =targetEntityDesc;
	fnCheckControls();

}

function fnCheckControls()
{
	var ObjForm = document.forms[0];
	checkRadio(ObjForm.orderBy,orderBy);
}


function cacli_crit_ONBLUR1(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('cacli_crit',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = onBlurFormatDate(p1)) == false) {
		return false;
	}
	if ((retVal = fnAssignDateOnEnter(p2)) == false) {
		return false;
	}
	if (postEventCall('cacli_crit',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cacli_crit_ONBLUR2(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('cacli_crit',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = onBlurFormatDate(p1)) == false) {
		return false;
	}
	if ((retVal = fnAssignDateOnEnter(p2)) == false) {
		return false;
	}
	if (postEventCall('cacli_crit',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cacli_crit_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cacli_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cacli_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cacli_crit_ONCLICK4(obj)
{
	var retVal = "";
	if (preEventCall('cacli_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('cacli_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cacli_crit_ONCHANGE5(obj)
{
	var retVal = "";
	if (preEventCall('cacli_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnFetchAcctDtls()) == false) {
		return false;
	}
	if (postEventCall('cacli_crit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cacli_crit_ONBLUR6(obj)
{
	var retVal = "";
	if (preEventCall('cacli_crit',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = fnvalidate_fromAmt()) == false) {
		return false;
	}
	if (postEventCall('cacli_crit',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cacli_crit_ONBLUR7(obj)
{
	var retVal = "";
	if (preEventCall('cacli_crit',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = fnvalidate_toAmt()) == false) {
		return false;
	}
	if (postEventCall('cacli_crit',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
