function printBlock()
{
	writeCustomHeader("cbcqfix_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">BANKERS CHEQUE UPLOAD FIX</td>');
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
	write('<a href="javascript:showHelpFile(\'cbcqfix_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<input type="hidden" id="mode" fdt="fmode" mneb1="N" vFldId="mode_ui" name="' + subGroupName + '.mode">');
	write('<input type="hidden" id="zoneDate" fdt="fdate" mneb1="N" vFldId="zonDate_ui" name="' + subGroupName + '.zoneDate">');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") + '<font color=red size=2>*</font></td>');
	write('<td class="textfield"><select name="' + subGroupName + '.funcCode" id="funcCode" class="listboxfont">');
	write('<option value="">' + jspResArr.get("FLT026336") + '</option>');
	write('<option value="R" selected>R-Rectify</option>');
	write('</select>');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026333") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.setID" id="setID" ' + cbcqfixProps.get("setID_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" disabled="true" >');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026334") + '&nbsp;<font color="red">*</font></td>');
    write('<td> <input fdt="uidate" class="textfieldfont"  mnebl="false" name="' + subGroupName + '.zoneDate_ui" id="zoneDate_ui"   hotKeyId="calender2"  type="text" class="textfieldfont" maxlength="10" value="" onBlur = "javascript:validateDateOnBlur(this,this,this);">');
    write('<a  href="javascript:openDate(document.forms[0].zoneDate_ui,BODDate)"   id="sLnk3"><img    width="24" height="19"  hotKeyId="calender2" src="../Renderer/images/'+applangcode+'/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand" class="img" ></img></a>');
    write('<div style="position:absolute;"></div></td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<tr>');
	
    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026335") + '</td>');
    write('<td><input name="' + subGroupName + '.zoneCode" id="zoneCode" ' + cbcqfixProps.get("zoneCode_ENABLED") + ' type="text" class="textfieldfont" size="10" maxlength="10" >');
    write('&nbsp;<a target="_self" id="sLnk2" href="javascript:showICTMZoneCodeList(document.forms[0].zoneCode, contextSolId, document.forms[0].zoneDate.value, \'F\')">');
    write('<IMG src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search1"></a>');
    write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cbcqfix_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cbcqfix_det_ONCLICK2(this);" id="Clear" value="Clear">');
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

	pre_ONLOAD('cbcqfix_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	
	//post_ONLOAD('cbcqfix_det',this);
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.funcCode.value = funcCode;
	ObjForm.setID.value = "ALL";
	ObjForm.zoneDate_ui.value = zoneDate;
	ObjForm.zoneDate.value = zoneDate;
	ObjForm.zoneCode.value = zoneCode;

}

function cbcqfix_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	var frm = document.forms[0];
	if(fnIsNull(document.forms[0].funcCode.value)) {
		alert("Enter the Function Code");
		document.forms[0].funcCode.focus();
		return false;
	}
	if(fnIsNull(document.forms[0].zoneDate_ui.value)) {
		alert("Enter the Zone Date");
		document.forms[0].zoneDate_ui.focus();
		return false;
	}

	if(fnIsNull(document.forms[0].zoneCode.value)) {
		alert("Enter the Zone Code");
		document.forms[0].zoneCode.focus();
		return false;
	}
	frm.actionCode.value = "Submit";
	enableFormElements();
	hideAnchors();
	disableButtons();
	frm.submit();
}

function cbcqfix_det_ONCLICK2(obj)
{
	var retVal = "";
	/*
	if (pre_ONCLICK('cbcqfix_det',obj) == false) { 
		return false;
	}
	*/
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	/*
	if (post_ONCLICK('cbcqfix_det',obj) == false) { 
		return false;
	}
	*/
	return (retVal == undefined) ? true : retVal;
}

function localShowClgZoneCode(objZoneCode, objFnCode)
{
        var showDelRecFlg = "";
        switch(objFnCode.value)
        {
                case 'D':
                case 'M':
                showDelRecFlg = "N";
                break;
                case 'U':
                showDelRecFlg = "Y";
                break;
        }
        showClgZoneCode(objZoneCode, 'ctrl', 'F', 'NULL', showDelRecFlg);
}

function validateDateOnBlur(obj,p1,p2)
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
