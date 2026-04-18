function printBlock()
{
	writeCustomHeader("cimgbv_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">BATCH IMAGE VERIFICATION</td>');
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
	write('<a href="javascript:showHelpFile(\'cimgbv_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026331") + '<font color="red" size="2"> *</font></td>');
    write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + cimgbvProps.get("funcCode_ENABLED") + ' class="textfieldfont" " onchange="javascript:fnDisableFields(this)">');
    write('<option selected value = "">--Select--</option>');
    write('<option value="V">V - Verify</option>');
    write('</select>');
    write('</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('</tr>');
	
	
	write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026332") +'<font color=red size=2>*</font></td>');
    write('<td><input name="' + subGroupName + '.userId" id="userId" ' + cimgbvProps.get("userId_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onChange= "javascript:fnCustValidate();" >');
    write('<a href="javascript:fnshowAccountIdList(document.forms[0].userId);" id="userId">');
  //  write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
    write('</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026333") +'</td>');
	write('<td><input name="' + subGroupName + '.solID" id="solID"  type="text" class="textfieldfont" size="25" maxlength="16">');
	write('<a href="javascript:fnCustSearcher(); " id="solIdList">');
	write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
	write('<input name="' + subGroupName + '.solIdDesc" id="solIdDesc"  type="text" class="label" size="25" maxlength="16">');
	write('</td>');
	write('</tr>');		
	

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026334") +'</td>');
	write('<td><input name="' + subGroupName + '.AcctSol" id="AcctSol"  type="text" class="textfieldfont" size="25" maxlength="16">');
	write('<a href="javascript:fnCustSearcher2(); " id="solIdList">');
	write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
	write('<input name="' + subGroupName + '.solIdDesc" id="solIdDesc"  type="text" class="label" size="25" maxlength="16">');
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cimgbv_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cimgbv_det_ONCLICK2(this);" id="Clear" value="Clear">');
	}else{
	write('&nbsp;<input class="button" type="button" id="Back" value="OK" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnCustSearcher1(){
var inputNameValues = "";
var outputNames = "status|req_id|acctNum|num_of_chb|num_of_chq_lvs|req_date";
var scrName     = "cimgbvdp001.scr";
var title  = "List of Cheque Books";
var literalNames="STATUS|REQUEST ID|ACCT NUM|NUM OF CHQBK|NUM OF CHQ LVS|REQUEST DATE";
var hyperLnks   = "1";
var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
var retVal = "";
}

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('cimgbv_det',this);

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
	post_ONLOAD('cimgbv_det',this);
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.solID.value = solID;
	ObjForm.userId.value = userId;
	ObjForm.AcctSol.value = AcctSol;
	ObjForm.funcCode.value = funcCode

}


function cimgbv_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('cimgbv_det',obj) == false) { 
		return false;
	}
	/*
	if(fnIsNull(document.forms[0].solID.value)) {
                alert("Enter the SolID");
                document.forms[0].solID.focus();
                return false;
    }
	if(fnIsNull(document.forms[0].userId.value)) {
                alert("Enter the Account Number");
                document.forms[0].userId.focus();
                return false;
    }
	*/

	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	/*
	var frm = document.forms[0];
       frm.actionCode.value = "Submit";
       enableFormElements();
       hideAnchors();
       disableButtons();
       frm.submit();
	*/
	if (post_ONCLICK('cimgbv_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cimgbv_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cimgbv_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cimgbv_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnshowAccountIdList(obj){
    showAccountIdList(obj,null,null,'F');
        fnCustValidate();
}


function fnCustSearcher() {
	showSolId(document.forms[0].solID,'ctrl','F',document.forms[0].solIdDesc);
}

function fnCustSearcher2() {
    showSolId(document.forms[0].AcctSol,'ctrl','F',document.forms[0].solIdDesc);
}

