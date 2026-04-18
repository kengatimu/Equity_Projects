function printBlock()
{
	writeCustomHeader("ebrpt_det2");
	with (document){
	write('<input type="hidden" id="asOnDate" fdt="fdate" mneb1="N" vFldId="asOnDate_ui" name="' + subGroupName + '.asOnDate">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT648024") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + rptModule1 + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT648107") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + rptDiv + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT004630") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + rptName + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT648112") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + rptTitle + '</label>');
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
	write('<a href="javascript:showHelpFile(\'det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="17" height="17" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT648037") + '');
	write('<font color="red" size="3">*');
	write('</font>');
	write('</td>');
	write('<td class="textfield">');
	write('<input  hotKeyId="calender1"  type="text" class="textfieldfont" fdt="uidate"  mnebl="false" onBlur="javascript:return ebrpt_det2_ONBLUR1(this,this,this);" name="' + subGroupName + '.asOnDate_ui" id="asOnDate_ui"  style="width: 186px;">');
	write('<a  href="javascript:openDate(document.forms[0].asOnDate_ui,BODDate)"   id="sLnk2"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
	write('</a>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT648038") + '');
	write('<font color="red" size="3">*');
	write('</font>');
	write('</td>');
	write('<td class="textfield">');

	write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.solId"onChange ="return Validate_sol();"  id="solId" fdt="String" ' + ebrptProps.get("solId_ENABLED") + ' style="width: 186px;">');
	//write('<a href="javascript:showSetList(document.forms[0].solId, \'ctrl\',\'F\',document.forms[0].solIdDesc);">');
	write('<a href="javascript:showSetList(document.forms[0].solId, \'ctrl\',\'F\',\'\');">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="solIdDesc" name="solIdDesc" type="text" disabled=true class="labelwithoutwidth" fdt="String">');
	write('</td>');
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT721001"));
	setMandatory("Y");
	write('</td>');
	write('<td class="textfield">');
	write('<input class="textfieldfont" type="text"  maxlength="16" name="' + subGroupName + '.acid" id="acid" ' + ebrptProps.get("acid_ENABLED") + '>');
	write('<a id="sLnk2" target="_self" href="javascript:showAccountIdList(document.forms[0].acid,\'F\',document.forms[0].crncyCode);fnFetchAcctDtls()">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return ebrpt_det2_ONCLICK2(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return ebrpt_det2_ONCLICK3(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return ebrpt_det2_ONCLICK4(this,this.id);"" hotKeyId="Cancel">');
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

	initFocusHandler();

	pre_ONLOAD('ebrpt_det2',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnAssignDateOnLoad(ObjForm);

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormDataControls('V',ObjForm,0);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('ebrpt_det2',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.asOnDate.value = asOnDate;
	ObjForm.solId.value = solId;
}


function ebrpt_det2_ONBLUR1(obj,p1,p2)
{
	var retVal = "";
	if (pre_ONBLUR('ebrpt_det2',obj) == false) { 
		return false;
	}
	if ((retVal = onBlurFormatDate(p1)) == false) {
		return false;
	}
	if ((retVal = fnAssignDateOnEnter(p2)) == false) {
		return false;
	}
	if (post_ONBLUR('ebrpt_det2',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ebrpt_det2_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('ebrpt_det2',obj) == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('ebrpt_det2',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ebrpt_det2_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('ebrpt_det2',obj) == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('ebrpt_det2',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ebrpt_det2_ONCLICK4(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('ebrpt_det2',obj) == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('ebrpt_det2',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
