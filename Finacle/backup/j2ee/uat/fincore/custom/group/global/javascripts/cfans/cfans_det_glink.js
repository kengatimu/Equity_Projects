function printBlock()
{
	writeCustomHeader("cfans_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">FINACLE ACCOUNT NUMBER SEARCH MAINTENANCE SCREEN</td>');
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
	write('<a href="javascript:showHelpFile(\'cfans_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") +'<font color="red" size="2"> *</font></td>');
	write('<td><input name="' + subGroupName + '.solID" id="solID"  type="text" class="textfieldfont" size="25" maxlength="16">');
	write('<a href="javascript:fnCustSearcher(); " id="solIdList">');
	write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
	write('<input name="' + subGroupName + '.solIdDesc" id="solIdDesc"  type="text" class="label" size="25" maxlength="16">');
	write('</td>');
	write('</tr>');		

	write('<tr>');
write('<td class="textlabel">' + jspResArr.get("FLT026333") + '<font color="red" size="2"> *</font></td>');
write('<td><input name="' + subGroupName + '.OldNumber" id="OldNumber" '+ cfansProps.get("OldNumber_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16">');

//write('<a target=_self id="sLnk4" href="javascript:fnCustSearcherold(document.forms[0].OldNumber)"><img class="img" src="../Renderer/images/' + applangcode + //'/search_icon.gif" width="16" height="17" border="0" hotKeyId="search4"></img></a>');

write('</td>');
write('</tr>');	


	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026334") + '</td>');
	write('<td><input name="' + subGroupName + '.userID" id="userID" ' + cfansProps.get("userID_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" disabled="true">');
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cfans_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cfans_det_ONCLICK2(this);" id="Clear" value="Clear">');
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

	pre_ONLOAD('cfans_det',this);

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
	post_ONLOAD('cfans_det',this);
       document.forms[0].userID.disabled = true;
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.solID.value = headCtxSol;
	ObjForm.OldNumber.value = OldNumber;
	ObjForm.userID.value = USERID;

}


function cfans_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('cfans_det',obj) == false) { 
		return false;
	}
	/*
	if(fnIsNull(document.forms[0].solID.value)) {
                alert("Enter the SolID");
                document.forms[0].solID.focus();
                return false;
    }
	if(fnIsNull(document.forms[0].OldNumber.value)) {
                alert("Enter the OldNumber");
                document.forms[0].OldNumber.focus();
                return false;
    }
	*/

	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('cfans_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cfans_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cfans_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cfans_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnCustSearcher() {
	showSolId(document.forms[0].solID,'ctrl','F',document.forms[0].solIdDesc);
}

function fnCustSearcherold()
{
	var inputNameValues = "";
	var outputNames = "OldNumber|";
	var scrName     = "cfansdp001.scr";
	var title       = "Old Account Number";
	var literalNames= "Old Number";
	var hyperLnks   = "1";
	var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
	var ret = retVal.split("|");
	var msg = ret[1];
	
	if(msg == "OldNumber" )
	{
		document.forms[0].OldNumber.value ="";
		return false;
	}
}
