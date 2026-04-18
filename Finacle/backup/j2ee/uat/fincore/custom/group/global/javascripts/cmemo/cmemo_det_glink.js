function printBlock()
{
	writeCustomHeader("cmemo_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">MEMO PAD MAINTENANCE</td>');
	write('</tr>');
	if(funcCode=="A"){ funcDes="Add"; } 
	if(funcCode=="M"){ funcDes="Modify"; } 
	if(funcCode=="I"){ funcDes="Inquire"; } 
	if(funcCode=="D"){ funcDes="Delete"; } 
	write('<tr>');
	write('<td class="textlabel">Function </td>');
	//write('<td class="textfielddisplaylabel">'+funcCode+' - '+funcDes+'</td>');
	write('<td class="textfielddisplaylabel">'+funcDes+'</td>');
	write('</tr>')
	write('<tr>');
	write('<td class="textlabel">Cust ID</td>');
	write('<td class="textfielddisplaylabel">'+ custID+ " " + accntName+'</td>');
	write('</tr>');
	if(funcCode=="I"){
	write('<tr>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<td class="textlabel">Last Modified by:</td>');
	write('<td class="textfielddisplaylabel">'+enterer+'</td>');
	write('<td class="textlabel">Last Modified on:</td>');
	write('<td class="textfielddisplaylabel">'+auditDate+'</td>');
	write('</table>');
	write('</tr>');
	}
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
	write('<a href="javascript:showHelpFile(\'cmemo_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026334") + '</td>');
	write('<td><input name="' + subGroupName + '.msg1" id="msg1" ' + cmemoProps.get("msg1_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="50" onChange="checkValidName(this);" >');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT026335") + '</td>');
	write('<td><input name="' + subGroupName + '.msg2" id="msg2" ' + cmemoProps.get("msg2_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="50" onChange="checkValidName(this);" >');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026336") + '</td>');
	write('<td><input name="' + subGroupName + '.msg3" id="msg3" ' + cmemoProps.get("msg3_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="50" onChange="checkValidName(this);">');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT026337") + '</td>');
	write('<td><input name="' + subGroupName + '.msg4" id="msg4" ' + cmemoProps.get("msg4_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="50" onChange="checkValidName(this);" >');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026338") + '</td>');
	write('<td><input name="' + subGroupName + '.msg5" id="msg5" ' + cmemoProps.get("msg5_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="50" onChange="checkValidName(this);">');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT026339") + '</td>');
	write('<td><input name="' + subGroupName + '.msg6" id="msg6" ' + cmemoProps.get("msg6_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="50" onChange="checkValidName(this);">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026340") + '</td>');
	write('<td><input name="' + subGroupName + '.msg7" id="msg7" ' + cmemoProps.get("msg7_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="50" onChange="checkValidName(this);">');
	write('</td>');
	if (funcCode=="I"){
		write('<td class="textlabel">' + jspResArr.get("FLT026341") + '<font color=red size=2>*</font></td>');
		write('<td><input name="' + subGroupName + '.commChange" id="commChange" ' + cmemoProps.get("commChange_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" disabled >'); 
	}
	else{
	write('<td class="textlabel">' + jspResArr.get("FLT026341") + '<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.commChange" id="commChange" ' + cmemoProps.get("commChange_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	}
	write('</td>');
	write('</tr>');
	write('<tr>');
	//write('<td> Press <Submit> to download the Cheque Book Request for the day </td>');
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
		
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cmemo_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cmemo_det_ONCLICK2(this);" id="Clear" value="Cancel">');
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
	pre_ONLOAD('cmemo_det',this);
	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}
	fnPopulateControlValues();
	if( funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormControls(ObjForm);
		document.forms[0].menuName.readOnly=false;
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	document.forms[0].commChange.readOnly = false;
//	fnPostOnLoad()
	post_ONLOAD('cmemo_det',this);
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
	ObjForm.msg1.value = msg1;
	ObjForm.msg2.value = msg2;
	ObjForm.msg3.value = msg3;
	ObjForm.msg4.value = msg4;
	ObjForm.msg5.value = msg5;
	ObjForm.msg6.value = msg6;
	ObjForm.msg7.value = msg7;
	ObjForm.commChange.value = commChange;
	return true;
}

function cmemo_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('cmemo_det',obj) == false) { 
		return false;
	}

	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}

	if (post_ONCLICK('cmemo_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cmemo_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cmemo_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cmemo_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function checkValidName(obj)
{
    //var invalidChars = "1234567890~`!@#$%^&*()+=\\|/?;:'\"[]{}";
    //var invalidChars = "1234567890~`!@#$%^*+=|?;:'\"{},-_[]{}";
    var invalidChars = "~`!@#$%^*+=|?;:'\"{}_[]{}";
    var str = obj.value;
    for (i = 0; i < str.length; i++)
    {
        if (invalidChars.indexOf(str.charAt(i)) != -1)
        {
			alert("Please enter only characters");
            alert(custJsRes.CUSTATMREQ004);
            document.forms[0].msg1.focus();
            document.forms[0].msg1.value = "";
            document.forms[0].msg2.focus();
            document.forms[0].msg2.value = "";
            document.forms[0].msg3.focus();
            document.forms[0].msg3.value = "";
            document.forms[0].msg4.focus();
            document.forms[0].msg4.value = "";
            document.forms[0].msg5.focus();
            document.forms[0].msg5.value = "";
            document.forms[0].msg6.focus();
            document.forms[0].msg6.value = "";
            document.forms[0].msg7.focus();
            document.forms[0].msg7.value = "";
            return false;
        }
    }
    return true;
}



