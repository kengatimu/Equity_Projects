function printBlock()
{
	writeCustomHeader("cbchap_det");
	document.write('<input type="hidden" id="frmDate" fdt="fdate" fmnd="Y"  mneb1="N" vFldId="fromDate_ui" name="' + subGroupName + '.frmDate">');
	document.write('<input type="hidden" id="toDate" fdt="fdate" fmnd="Y"  mneb1="N" vFldId="toDate_ui" name="' + subGroupName + '.toDate">');
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">EB-AP Bankers Cheques Processing </td>');
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
	write('<a href="javascript:showHelpFile(\'cbchap_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") +'<font color=red size=2>*</font></td>');
	write('<td class="textfield"><select name="' + subGroupName + '.funcCode" id="funcCode" class="listboxfont">');
	write('<option value="" selected="selected">' + jspResArr.get("FLT026341") + '</option>');
    write('<option value="P">' + jspResArr.get("FLT026342") + '</option>');
    write('</select>');
    write('</td>');
	write('</tr>');
	write('<tr>');	
	write('<td class="textlabel">' + jspResArr.get("FLT026333") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.solId" id="solId" ' + cbchapProps.get("solId_ENABLED") +' type="text" class="textfieldfont" size="25" maxlength="16" disabled="true">');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026334") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.test" id="test" ' + cbchapProps.get("test_ENABLED") + ' type="radio" value = "Y">Yes<input name="' + subGroupName + '.test" id="test" ' + cbchapProps.get("test_ENABLED") + ' type="radio" value = "N">No');
	write('</td>');
	write('</tr>');
	
	write('<tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026335") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.remrks" id="remrks" ' +cbchapProps.get("remrks_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cbchap_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cbchap_det_ONCLICK2(this);" id="Clear" value="Clear">');
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

	pre_ONLOAD('cbchap_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if( sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

}

function fnPostOnLoad(){
	fnPopulateControlValues();
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
	ObjForm.solId.value = headCtxSol;
	ObjForm.test.value = test;
	ObjForm.remrks.value = remrks;

	element = document.forms[0].test;
    if(test == "Y") {
        element[0].checked=true;
    }
    else {
        element[1].checked=true;
    }

}


function cbchap_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('cbchap_det',obj) == false) { 
		return false;
	}
	
	if(fnIsNull(document.forms[0].funcCode.value)) {
                alert("Enter the Function Code");
                document.forms[0].funcCode.focus();
                return false;
    }

	if(fnIsNull(document.forms[0].solId.value)) {
                alert("Enter the SolID");
                document.forms[0].solId.focus();
                return false;
    }

	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	
	var frm = document.forms[0];
       frm.actionCode.value = "Submit";
       enableFormElements();
       hideAnchors();
       disableButtons();
       frm.submit();
	
	if (post_ONCLICK('cbchap_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cbchap_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cbchap_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cbchap_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
