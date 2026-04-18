function printCritBlock()
{
	writeCustomHeader("cprofilecrit");
	with (document){
    write('<input type="hidden" name="nextPage" id="nextPage">');
    write('<input type="hidden" name="' + subGroupName + '.cmmFetchCallMode" id="cmmFetchCallMode" fdt="String" ' + cprofileProps.get("cmmFetchCallMode_ENABLED") + ' >');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FSC909815") + '</td>');
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

	write('<a href="javascript:showHelpFile(\'cprofilecrit_help.htm\');" id="hlpLnk0">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21" vspace="1" border="0" />');
	write('</a>');

	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');

	
write('<tr>');
write('<tr id="cprofilecritRow1">');
write('<td class="textlabel">' + jspResArr.get("FLT006657") + '<script>setMandatory("Y");</script></td>');
write('<td class="textfield">');
write('<select name="' + subGroupName + '.funcCode" id="funcCode" class="listboxfont"  onChange="javascript:return cprofilecrit_ONCHANGE(this);"  onBlur="javascript:return cprofilecrit_ONBLUR(this);"  fdt="String" ' + cprofileProps.get("funcCode_ENABLED") + ' >');
write('<option value="">' + jspResArr.get("FLT029570") + '</option>');
//write('<option value="R" >' + jspResArr.get("FLT011930") + '</option>');
write('<option value="M" >' + jspResArr.get("FLT012349") + '</option>');
write('<option value="V" >' + jspResArr.get("FLT013169") + '</option>');
write('<option value="I" >' + jspResArr.get("FLT034011") + '</option>');
write('</select>');
write('</td>');
write('<td class="textlabel">' + jspResArr.get("FLT002136") + '<script>setMandatory("Y");</script></td>');
write('<td class="textfield">');
write('<input type="text" name="' + subGroupName + '.cifId" id="cifId" class="textfieldfont"  onChange="javascript:return cprofilecrit_ONCHANGE(this);"  onBlur="javascript:return cprofilecrit_ONBLUR(this);"  fdt="String" ' + cprofileProps.get("paysysId_ENABLED") +  ' maxlength="30" hotKeyId="search1" >&nbsp;');
write('<a id="sLnk_paysysId" href="javascript:locShowToCifId();">');
write('<img border="0" width="16" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" />');
write('</a>');
write('</td>');
write('</tr>');
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
	} //End with()
} //End function

function printCritFooterBlock()
{
	with (document) {
	if ((sReferralMode == 'I')||(sReferralMode == 'S')){
	write('<div align="left" class="ctable">');
	if (sReferralMode == 'S'){
	write('<input type="button" class="button" id="Submit" value="'+jspResArr.get("FLT000193")+ '" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button" onClick="javascript:return cprofilecrit_ONCLICKGO(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return cprofilecrit_ONCLICKCLEAR(this);"">');
	
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	initFocusHandler();

	pre_ONLOAD('cprofilecrit',this);

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
	post_ONLOAD('cprofilecrit',this);

ObjForm.funcCode.focus();
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];
    var fv = ObjForm.funcCode.value;
    if(fnIsNull(fv)){
        alert(finbranchResArr.get("FAT004356"));
        ObjForm.funcCode.focus();
        return false;
    }
    var fv = ObjForm.cifId.value;
    if(fnIsNull(fv)){
        alert(finbranchResArr.get("FAT004356"));
        ObjForm.cifId.focus();
        return false;
    }
    return true;
}

function fnPopulateControlValues()
{
	var ObjForm = document.forms[0];
    ObjForm.funcCode.value = funcCode;
    ObjForm.cifId.value = cifId;
	fnCheckControls();
}

function fnCheckControls()
{
	var ObjForm = document.forms[0];
}
function cprofilecrit_ONBLURDATE(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('cprofilecrit',obj,'ONBLUR') == false) {
		return false;
	}
	if ((retVal = onBlurFormatDate(p1)) == false) {
		return false;
	}
	if ((retVal = fnAssignDateOnEnter(p2)) == false) {
		return false;
	}
	if ((retVal = fnFrontEndEvents_ONBLUR(obj)) == false) {
		return false;
	}
	if (postEventCall('cprofilecrit',obj,'ONBLUR') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cprofilecrit_ONCLICKCHECKBOX(obj,p1)
{
	var retVal = "";
	if (preEventCall('cprofilecrit',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal = fnSetCheckboxFld(p1)) == false) {
		return false;
	}
	if ((retVal = fnFrontEndEvents_ONCLICK(obj)) == false) {
		return false;
	}
	if (postEventCall('cprofilecrit',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cprofilecrit_ONCLICKGO(obj,p1)
{

	var ObjForm = document.forms[0];
		


	var retVal = "";
	if (preEventCall('cprofilecrit',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal = fnFrontEndEvents_ONCLICK(obj)) == false) {
		return false;
	}
	if (!fnValidateData()) { return false; }
	
    if ((retVal =  fnValAndSubmit(p1)) == false) {
        return false;
    }
	if (postEventCall('cprofilecrit',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cprofilecrit_ONCLICKCLEAR(obj)
{
	var retVal = "";
	if (preEventCall('cprofilecrit',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal = fnFrontEndEvents_ONCLICK(obj)) == false) {
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('cprofilecrit',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cprofilecrit_ONCHANGE(obj)
{
	var retVal = "";
	if (preEventCall('cprofilecrit',obj,'ONCHANGE') == false) {
		return false;
	}
	if ((retVal = fnFrontEndEvents_ONCHANGE(obj)) == false) {
		return false;
	}
	if (postEventCall('cprofilecrit',obj,'ONCHANGE') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cprofilecrit_ONBLUR(obj)
{
	var retVal = "";
	if (preEventCall('cprofilecrit',obj,'ONBLUR') == false) {
		return false;
	}
	if ((retVal = fnFrontEndEvents_ONBLUR(obj)) == false) {
		return false;
	}
	if (postEventCall('cprofilecrit',obj,'ONBLUR') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cprofilecrit_ONCLICK(obj)
{
	var retVal = "";
	if (preEventCall('cprofilecrit',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal = fnFrontEndEvents_ONCLICK(obj)) == false) {
		return false;
	}
	if (postEventCall('cprofilecrit',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
