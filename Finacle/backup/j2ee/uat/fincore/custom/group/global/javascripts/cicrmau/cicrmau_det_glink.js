function printBlock()
{
	writeCustomHeader("cicrmau_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Inward Clearing Instrument Reject Verification</td>');
	write('</tr>');
        write('</table>');
        write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
        write('<tr>');
	if(funcCode=="V"){funcDesc="Verify"; }
	if(funcCode=="X"){funcDesc="Cancel"; }
        write('<td class="textlabel">Function :</td>');
        write('<td class="textfielddisplaylabel">'+funcCode+" - "+funcDesc+'</td>');
        write('<td class="textlabel">Set No :</td>');
	write('<td class="textfielddisplaylabel">'+setNo+'</td>');
        write('</tr>')
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
    write('<tr>');
    write('<a href="javascript:showHelpFile(\'cicrmau_det_help.htm\');" id="sLnk1">');
    write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
    write('</tr>');
	write('</tr>');

//        write('<tr>');
//        write('<td class="textlabel">' + jspResArr.get("FLT000017") + '</td>');
//       write('<td><input name="' + subGroupName + '.funcCode" id="funcCode" ' + cicrmauProps.get("funcCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">'); 
//        write('<br>');
//        write('</td>');
//        write('<td class="textlabel">' + jspResArr.get("FLT000018") + '</td>');
//        write('<td><input name="' + subGroupName + '.setNo" id="setNo" ' + cicrmauProps.get("setNo_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">'); 
//       write('<br>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000001") + '</td>');
	write('<td><input name="' + subGroupName + '.foracid" id="foracid" ' + cicrmauProps.get("foracid_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" disabled="true">');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000002") + '</td>');
	write('<td><input name="' + subGroupName + '.instNo" id="instNo" ' + cicrmauProps.get("instNo_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" disabled="true">');
	write('<br>');
//	write('<input name="' + subGroupName + '.acctName" id="acctName" type="text" size="25" maxlength="16" readonly disabled class="label" >');

	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000003") + '</td>');
	write('<td><input name="' + subGroupName + '.rejCode" id="rejCode" ' + cicrmauProps.get("rejCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
	write('<br>');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000004") + '</td>');
	write('<td><input name="' + subGroupName + '.instAmt" id="instAmt" ' + cicrmauProps.get("instAmt_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
        write('<br>');

	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000005") + '</td>');
	write('<td><input name="' + subGroupName + '.zoneDate" id="zoneDate" ' + cicrmauProps.get("zoneDate_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000006") + '</td>');
	write('<td><input name="' + subGroupName + '.zoneCode" id="zoneCode" ' + cicrmauProps.get("zoneCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000007") + '</td>');
	write('<td><input name="' + subGroupName + '.valueDate" id="valueDate" ' + cicrmauProps.get("valueDate_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000008") + '</td>');
	write('<td><input name="' + subGroupName + '.draweeBankCode" id="draweeBankCode" ' + cicrmauProps.get("draweeBankCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000009") + '</td>');
	write('<td><input name="' + subGroupName + '.draweeBrCode" id="draweeBrCode" ' + cicrmauProps.get("draweeBrCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
	write('</td>');
 
       write('<td class="textlabel">' + jspResArr.get("FLT000010") + '</td>');
write('<td><input name="' + subGroupName + '.draweeSortCode" id="draweeSortCode" ' + cicrmauProps.get("draweeSortCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
        write('</td>');
	write('</tr>');

        write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000011") + '</td>');
write('<td><input name="' + subGroupName + '.presBankCode" id="presBankCode" ' + cicrmauProps.get("presBankCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
        write('</td>');

       write('<td class="textlabel">' + jspResArr.get("FLT000012") + '</td>');
write('<td><input name="' + subGroupName + '.presBrCode" id="presBrCode" ' + cicrmauProps.get("presBrCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
        write('</td>');
        write('</tr>');

        write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000013") + '</td>');
write('<td><input name="' + subGroupName + '.issBankCode" id="issBankCode" ' + cicrmauProps.get("issBankCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
        write('</td>');

       write('<td class="textlabel">' + jspResArr.get("FLT000014") + '</td>');
write('<td><input name="' + subGroupName + '.issBrCode" id="issBrCode" ' + cicrmauProps.get("issBrCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
        write('</td>');
        write('</tr>');

write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000015") + '</td>');
write('<td><input name="' + subGroupName + '.tranRmks" id="tranRmks" ' + cicrmauProps.get("tranRmks_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">');
        write('</td>');
       write('<td class="textlabel">' + jspResArr.get("FLT000016") + '</td>');
write('<td><input name="' + subGroupName + '.solId" id="solId" ' + cicrmauProps.get("solId_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" disabled="true">'); 
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cicrmau_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cicrmau_det_ONCLICK2(this);" id="Clear" value="Cancel">');
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

	pre_ONLOAD('cicrmau_det',this);

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

	post_ONLOAD('cicrmau_det',this);
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
//        ObjForm.funcCode.value=funcCode;
//        ObjForm.setNo.value=setNo;
	ObjForm.foracid.value=foracid;
        ObjForm.instNo.value=instNo;
        ObjForm.rejCode.value=rejCode;
       	ObjForm.instAmt.value=instAmt;
        ObjForm.zoneCode.value=zoneCode;
        ObjForm.zoneDate.value=zoneDate;
        ObjForm.valueDate.value=valueDate;
        ObjForm.draweeBankCode.value=draweeBankCode;
        ObjForm.draweeBrCode.value=draweeBrCode;
        ObjForm.draweeSortCode.value=draweeSortCode;
        ObjForm.presBankCode.value=presBankCode;
        ObjForm.presBrCode.value=presBrCode;
        ObjForm.issBankCode.value=issBankCode;
        ObjForm.issBrCode.value=issBrCode;
        ObjForm.tranRmks.value=tranRmks;
	ObjForm.solId.value=solId;

	return true;
}


function cicrmau_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('cicrmau_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('cicrmau_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cicrmau_det_ONCLICK2(obj)
{
	var retVal = "";
	/*
	if (pre_ONCLICK('cicrmau_det',obj) == false) { 
		return false;
	}
	*/
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	/*
	if (post_ONCLICK('cicrmau_det',obj) == false) { 
		return false;
	}
	*/
	return (retVal == undefined) ? true : retVal;
}
