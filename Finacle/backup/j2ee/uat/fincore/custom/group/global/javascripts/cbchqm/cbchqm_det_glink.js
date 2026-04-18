function printBlock()
{
	writeCustomHeader("cbchqm_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">BANKERS CHQ REQUEST MENU</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">Function :</td>');
	if(funcCode=='A'){funcDesc="Add"; }
    if(funcCode=='D'){funcDesc='Delete'; }
    if(funcCode=='V'){funcDesc='Verify'; }
    if(funcCode=='I'){funcDesc='Inquire'; }
	write('<td class="textfielddisplaylabel">'+funcCode+ " - " +funcDesc+ '</td>');
    if(funcCode != 'A'){
	write('<td class="textlabel">Request Id :</td>');
    write('<td class="textfielddisplaylabel">'+requestId+'</td>');
	}
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
	write('<a href="javascript:showHelpFile(\'cbchqm_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000228") + '<font color="red" size="2"> *</font></td>');
	write('<td><input name="' + subGroupName + '.acctNum" id="acctNum" ' + cbchqmProps.get("acctNum_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	
	

	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000028") + '<font color="red" size="2"> *</font></td>');
	write('<td><input name="' + subGroupName + '.noOfChqs" id="noOfChqs" ' + cbchqmProps.get("noOfChqs_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000129") + '</td>');
	write('<td><input name="' + subGroupName + '.reqStat" id="reqStat" ' + cbchqmProps.get("reqStat_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT019668") + '</td>');
	write('<td><input name="' + subGroupName + '.startChqNo" id="startChqNo" ' + cbchqmProps.get("startChqNo_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	
	write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000029") + '</td>');
	write('<td><input name="' + subGroupName + '.endChqNo" id="endChqNo" ' + cbchqmProps.get("endChqNo_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cbchqm_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cbchqm_det_ONCLICK2(this);" id="Clear" value="Cancel">');
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

	pre_ONLOAD('cbchqm_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		//fnDisableFormControls(ObjForm);
		ObjForm.acctNum.disabled= true ;
		ObjForm.noOfChqs.disabled= true ;
		ObjForm.startChqNo.disabled= true ;
		ObjForm.endChqNo.disabled= true ;
		ObjForm.reqStat.disabled= true ;

document.getElementById('sLnk2').style.visibility = "hidden";
	}

        ObjForm.acctNum.disabled= true ;
        if(funcCode =='A')
        {
        ObjForm.startChqNo.value = "";
        ObjForm.endChqNo.value = "";
        ObjForm.startChqNo.disabled= true ;
        ObjForm.endChqNo.disabled= true ;
        ObjForm.reqStat.value = "E" ;
        ObjForm.reqStat.disabled= true ;
        }

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cbchqm_det',this);
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	if(funcCode == 'A'){
	ObjForm.acctNum.value=acctNo;
	}
	else
	{
		ObjForm.acctNum.value=acctNum;
	}
	
	ObjForm.noOfChqs.value=noOfChqs;
	ObjForm.startChqNo.value=startChqNo;
	ObjForm.reqStat.value=reqStat;
	ObjForm.endChqNo.value=endChqNo;
	return true;
	
	if(funcCode == 'A'){
		ObjForm.reqStat.value = 'E';
	}
	else{
	ObjForm.reqStat.value=reqStat;
	}
	return true;
}


function cbchqm_det_ONCLICK1(obj,p1)
{
	var retVal = "";

	if(fnIsNull(document.forms[0].acctNum.value)) {
        alert("Enter the Account Number");
        document.forms[0].acctNum.focus();
        return false;
        }
        if(fnIsNull(document.forms[0].noOfChqs.value)) {
        alert("No of Cheque book  Should be entered");
        document.forms[0].noOfChqs.focus();
        return false;
        }
        if(fnIsNull(document.forms[0].reqStat.value)) {
        alert("Request Status Should be entered");
        document.forms[0].reqStat.focus();
        return false;
        }
	                     if(isNaN(document.forms[0].noOfChqs.value) )
                        {
                                alert("Please Enter a valid Number for Cheque book");
                                document.forms[0].noOfChqs.focus();
                                return false;
                        }
        if(funcCode !='A')
        {
        if(fnIsNull(document.forms[0].startChqNo.value)) {
        alert("start cheque No Should be entered");
        document.forms[0].startChqNo.focus();
        return false;
        }
	if(fnIsNull(document.forms[0].endChqNo.value)) {
        alert("End Cheque No Should be entered");
        document.forms[0].endChqNo.focus();
        return false;
        }
	                     if(isNaN(document.forms[0].startChqNo.value) )
                        {
                                alert("Please Enter a valid Number for start cheque No");
                                document.forms[0].startChqNo.focus();
                                return false;
                        }
	                     if(isNaN(document.forms[0].endChqNo.value) )
                        {
                                alert("Please Enter a valid Number for End Cheque No");
                                document.forms[0].endChqNo.focus();

                                return false;
                        }
	}

	if (pre_ONCLICK('cbchqm_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}

	if (post_ONCLICK('cbchqm_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cbchqm_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cbchqm_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cbchqm_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}





