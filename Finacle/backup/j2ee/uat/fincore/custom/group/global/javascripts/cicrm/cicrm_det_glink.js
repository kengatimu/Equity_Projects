function printBlock()
{
	writeCustomHeader("cicrm_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Inward Clearing Instrument Reject Menu</td>');
	write('</tr>');
	write('</table>');
	write('</br>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">Function :</td>');
	write('<td class="textfielddisplaylabel">'+"R - Reject"+'</td>');	
	write('<td class="textlabel">Account Number :</td>');
	write('<td class="textfielddisplaylabel">'+foracid+'</td>');	
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">Instrument Number :</td>');
	write('<td class="textfielddisplaylabel">'+instNo+'</td>');	
	write('<td class="textlabel">Instrument Amount :</td>');
	write('<td class="textfielddisplaylabel">'+instAmt+'</td>');	
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
	write('<a href="javascript:showHelpFile(\'cicrm_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
 
	write('<tr>');	
	write('<td class="textlabel">' + jspResArr.get("FLT000032") + '</td>');
	write('<td><input name="' + subGroupName + '.solId" id="solId" ' + cicrmProps.get("solId_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000003") + '<font color=red size=2> * </font></td>');
	write('<td><input name="' + subGroupName + '.rejCode" id="rejCode" ' + cicrmProps.get("rejCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" >');
	write('&nbsp;<a target="_self" id="sLnk1" href="JavaScript:showRejReasonList(document.forms[0].rejCode,document.forms[0].rejectReasonDesc,\'F\',\'N\')">');
	write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search5"></a>');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ictmselcrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ictmselcrit\',this);" id="rejectReasonDesc"  disabled fblk="defaultFblk2" name="' + sGroupName + '.rejectReasonDesc" type="text" disabled="true" class="label" size="25" maxlength="25">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000005") + '</td>');
	write('<td><input name="' + subGroupName + '.zoneDate" id="zoneDate" ' + cicrmProps.get("zoneDate_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000006") + '</td>');
	write('<td><input name="' + subGroupName + '.zoneCode" id="zoneCode" ' + cicrmProps.get("zoneCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000007") + '</td>');
	write('<td><input name="' + subGroupName + '.valueDate" id="valueDate" ' + cicrmProps.get("valueDate_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000008") + '</td>');
	write('<td><input name="' + subGroupName + '.draweeBankCode" id="draweeBankCode" ' + cicrmProps.get("draweeBankCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000009") + '</td>');
	write('<td><input name="' + subGroupName + '.draweeBranchCode" id="draweeBranchCode" ' + cicrmProps.get("draweeBranchCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
	write('</td>');
    write('<td class="textlabel">' + jspResArr.get("FLT000010") + '</td>');
    write('<td><input name="' + subGroupName + '.draweeSortCode" id="draweeSortCode" ' + cicrmProps.get("draweeSortCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
    write('</td>');
    write('</tr>');
    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT000011") + '</td>');
    write('<td><input name="' + subGroupName + '.pressbankCode" id="pressbankCode" ' + cicrmProps.get("pressbankCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
    write('</td>');
    write('<td class="textlabel">' + jspResArr.get("FLT000012") + '</td>');
    write('<td><input name="' + subGroupName + '.pressbrCode" id="pressbrCode" ' + cicrmProps.get("pressbrCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
    write('</td>');
    write('</tr>');
    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT000013") + '</td>');
    write('<td><input name="' + subGroupName + '.issBankCode" id="issBankCode" ' + cicrmProps.get("issBankCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
    write('</td>');
    write('<td class="textlabel">' + jspResArr.get("FLT000014") + '</td>');
    write('<td><input name="' + subGroupName + '.issBrCode" id="issBrCode" ' + cicrmProps.get("issBrCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
    write('</td>');
    write('</tr>');
    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT000038") + '</td>');
    write('<td><input name="' + subGroupName + '.presssortCode" id="presssortCode" ' + cicrmProps.get("presssortCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
    write('</td>');
    write('<td class="textlabel">' + jspResArr.get("FLT000015") + '</td>');
    write('<td><input name="' + subGroupName + '.tranrmks" id="tranrmks" ' + cicrmProps.get("tranrmks_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cicrm_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cicrm_det_ONCLICK2(this);" id="Clear" value="Cancel">');
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

	pre_ONLOAD('cicrm_det',this);

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

	post_ONLOAD('cicrm_det',this);
}

function fnValidateData()
{
	var ObjForm = document.forms[0];
	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	return true;
}

function fnPopulateControlValues() 
{
    	var ObjForm = document.forms[0];
		ObjForm.zoneCode.value=zoneCode;
        ObjForm.zoneDate.value=zoneDate;
        ObjForm.valueDate.value=valueDate;
        ObjForm.draweeBankCode.value=draweeBankCode;
        ObjForm.draweeBranchCode.value=draweeBranchCode;
        ObjForm.draweeSortCode.value=draweeSortCode;
        ObjForm.pressbankCode.value=pressbankCode;
        ObjForm.pressbrCode.value=pressbrCode;
        ObjForm.presssortCode.value=presssortCode;
        ObjForm.issBankCode.value=issBankCode;
        ObjForm.issBrCode.value=issBrCode;
        ObjForm.tranrmks.value=tranrmks;
        ObjForm.solId.value=solId;
		ObjForm.rejCode.value=rejCode;
        return true;
}

function cicrm_det_ONCLICK1(obj,p1)
{
    var retVal = "";
	if(fnIsNull(document.forms[0].rejCode.value)) {
	alert("Enter the Rejection  Code");
	document.forms[0].rejCode.focus();
	return false;
	}

 	if (pre_ONCLICK('cicrm_crit',obj) == false) { 
        return false;
    }
    if ((retVal = fnValAndSubmit(p1)) == false) {
        return false;
    }
    if (post_ONCLICK('cicrm_crit',obj) == false) { 
        return false;
    }
    return (retVal == undefined) ? true : retVal;
}

function cicrm_det_ONCLICK2(obj)
{
	var retVal = "";
	
	if (pre_ONCLICK('cicrm_det',obj) == false) { 
		return false;
	}
	
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	
	if (post_ONCLICK('cicrm_det',obj) == false) { 
		return false;
	}
	
	return (retVal == undefined) ? true : retVal;
}
