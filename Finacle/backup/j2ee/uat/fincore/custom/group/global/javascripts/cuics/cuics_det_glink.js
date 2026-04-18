function printBlock()
{
	writeCustomHeader("cuics_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
    write('<tr>');
    write('<td>');
    write('<table border="0" cellspacing="0" cellpadding="0">');
    write('<tr>');
	write('<td class="page-heading">Update Inhouse Cheque Book Status</td>');
    write('</tr>');
    write('</table>');
    write('</br>');
    write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
    write('<tr>');
    write('<td class="textlabel">Function :</td>');
    if(funcCode=='I'){funcDesc='Inquire'; }
    if(funcCode=='M'){funcDesc='Modify'; }

    write('<td class="textfielddisplaylabel">'+funcCode+ " - " + funcDesc + '</td>');
    write('<td class="textlabel">Account Number :</td>');
    write('<td class="textfielddisplaylabel">'+acctId+'</td>');
    write('</tr>');
    write('<tr>');
    write('<td class="textlabel">Inst Type :</td>');
    write('<td class="textfielddisplaylabel">'+instType+'</td>');
    write('<td class="textlabel">Inst Num :</td>');
    write('<td class="textfielddisplaylabel">'+instNum+'</td>');
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
	write('</br>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026338") + '</td>');
	write('<td><input name="' + subGroupName + '.beginNum" id="beginNum" ' + cuicsProps.get("beginNum_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT026335") + '<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.newStatus" id="newStatus" ' + cuicsProps.get("newStatus_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('</tr>');
	write('<tr>');
	/*write('<td class="textlabel">' + jspResArr.get("FLT026337") + '<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.numLeaves" id="numLeaves" ' + cuicsProps.get("numLeaves_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');*/
	
	write('<td class="textlabel">' + jspResArr.get("FLT026334") + '<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.currStatus" id="currStatus" ' + cuicsProps.get("currStatus_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cuics_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	//write('<input name="Clear" type="button" class="button" onClick="javascript:return cuics_det_ONCLICK2(this);" id="Clear" value="Clear">');
	write('<input name="Cancel" type="button" class="button" onClick="javascript:return cuics_det_ONCLICK2(this);" id="Clear" value="Cancel">');
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

	pre_ONLOAD('cuics_det',this);

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


//	fnPostOnLoad()
	post_ONLOAD('cuics_det',this);
//	document.forms[0].userID.disabled = true;
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.currStatus.value = currStatus;
	ObjForm.newStatus.value = newStatus;
	//ObjForm.numLeaves.value = numLeaves;
	ObjForm.beginNum.value = beginNum;
	return true;
}


function cuics_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	
	/*if(fnIsNull(document.forms[0].beginNum.value)) {
        alert("Enter the Transfer Int Sol Limit");
        document.forms[0].beginNum.focus();
        return false;
        }
        if(fnIsNull(document.forms[0].newStatus.value)) {
        alert("Enter the Transfr Cred Lmt");
        document.forms[0].newStatus.focus();
        return false;
        }
	if(fnIsNull(document.forms[0].currStatus.value)) {
        alert("Enter the Cash Cred Lmt");
        document.forms[0].currStatus.focus();
        return false;
        }
	if(fnIsNull(document.forms[0].numLeaves.value)) {
        alert("Enter the Cash IntSol Lmt");
        document.forms[0].numLeaves.focus();
        return false;
        }
	if(fnIsNull(document.forms[0].clrnSolLm.value)) {
        alert("Enter the Clrg IntSol Lmt ");
        document.forms[0].clrnSolLm.focus();
        return false;
	}
	if(fnIsNull(document.forms[0].ClrnCrLm.value)) {
        alert("Enter the Clearng Cred Lmt ");
        document.forms[0].ClrnCrLm.focus();
        return false;
        }
	*/
	if (pre_ONCLICK('cuics_det',obj) == false) { 
		return false;
	}


	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}

	if (post_ONCLICK('cuics_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;

}

function cuics_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cuics_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cuics_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function cuics_det_ONCLICK3(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cuics_det',obj) == false) { 
		return false;
	}
	if ((retVal = doSubmit()) == false) {
		return false;
	}
	if (post_ONCLICK('cuics_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
