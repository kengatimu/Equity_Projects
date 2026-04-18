function printBlock()
{
	writeCustomHeader("cichqi_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">INHOUSE CHEQUE BOOK INQUIRY MENU</td>');
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
	write('<a href="javascript:showHelpFile(\'cichqi_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.solID" id="solID"  type="text" class="textfieldfont" size="25" maxlength="16">');
	write('<a href="javascript:fnCustSearcher(); " id="solIdList">');
	write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
	write('<input name="' + subGroupName + '.solIdDesc" id="solIdDesc"  type="text" class="label" size="25" maxlength="16">');
	write('</td>');
	write('</tr>');		
	
    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT026333") +'<font color=red size=2>*</font></td>');
    write('<td><input name="' + subGroupName + '.foracid" id="foracid" ' + cichqiProps.get("foracid_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" value="" onchange="javascript:fnOnchange();" >');
    write('<a href="javascript:fnshowAccountIdList(document.forms[0].foracid);" id="foracid">');
    write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
    write('</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026334") + '<font color=red size=2>*</font></td>');
	write('<td><select name="' + subGroupName + '.status" id="status" ' + cichqiProps.get("status_ENABLED") + ' type="text" class="textfieldfont" >');
	write('<option value=""selected>' + jspResArr.get("FLT000005") + '</option>');
        write('<option value="E">' + jspResArr.get("FLT000006") + '</option>');
        write('<option value="A">' + jspResArr.get("FLT000007") + '</option>');
        write('<option value="D">' + jspResArr.get("FLT000008") + '</option>');
        write('<option value="S">' + jspResArr.get("FLT000009") + '</option>');
        write('</select>');
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cichqi_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cichqi_det_ONCLICK2(this);" id="Clear" value="Clear">');
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

	pre_ONLOAD('cichqi_det',this);

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
	post_ONLOAD('cichqi_det',this);
}
function fnOnchange() {
        var foracid = document.forms[0].foracid.value.toUpperCase();
        var inputNameValues             = "acctNum|"+foracid
        var outputNames                 = ""
        var scrName                             = "cichqidp002.scr";
        var retVal                              = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret                                 = retVal.split("|");
        var msg                                 = ret[0];
        if(msg == "RESULT_MSG"){
                alert(ret[1]);
                document.forms[0].foracid.focus();
                document.forms[0].foracid.value = ""
                return false;
        }
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
	ObjForm.foracid.value = foracid;
	ObjForm.status.value = status;

}


function cichqi_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('cichqi_det',obj) == false) { 
		return false;
	}
	if(fnIsNull(document.forms[0].solID.value)) {
                alert("Enter the SolID");
                document.forms[0].solID.focus();
                return false;
    }
	if(fnIsNull(document.forms[0].foracid.value)) {
                alert("Enter the Account Number");
                document.forms[0].foracid.focus();
                return false;
    }
    	if(fnIsNull(document.forms[0].status.value)) {
                alert("Enter the status");
                document.forms[0].status.focus();
                return false;
    }
    	var sts = document.forms[0].status.value;
        var forAcid = document.forms[0].foracid.value;
        var inputNameValues = "sts" +"|" +sts + "|" + "forAcid" + "|" + forAcid ;
        var outputNames = "status|reqid|acctNum|numofchb|numofchqlvs|reqdate";
        var scrName     = "cichqidp001.scr";
        var title  = "List of Inhouse Cheque Books";
        var literalNames="STATUS|REQUEST ID|ACCT NUM|NUM OF CHQBK|NUM OF CHQ LVS|REQUEST DATE";
        var hyperLnks   = "7";
        var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
        var retVal = "";
        cichqi_det_ONCLICK2(document.forms[0].Clear);




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
	if (post_ONCLICK('cichqi_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cichqi_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cichqi_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cichqi_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnshowAccountIdList(obj){
    showAccountIdList(obj,null,null,'F');
        fnOnchange();
}


function fnCustSearcher() {
	showSolId(document.forms[0].solID,'ctrl','F',document.forms[0].solIdDesc);
}
