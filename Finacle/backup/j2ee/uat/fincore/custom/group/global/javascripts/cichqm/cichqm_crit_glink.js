function printBlock()
{
	writeCustomHeader("cichqm_crit");
	with (document){
	write('<input type="hidden" name="cichqm.myIPAddress" id="myIPAddress">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td><table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">In House Cheque Maintenance </td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr class="innertabletop1">');
	write('<td colspan="5" align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right">');
	write('<a href="javascript:showHelpFile(\'cichqmcrit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0"></a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000204") + '<font color="red" size="2"> *</font></td>');
	write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + cichqmProps.get("funcCode_ENABLED") + ' class="textfieldfont" " onchange="javascript:fnDisableFields(this)">');
	write('<option value = "" selected>' + jspResArr.get("FLT000005") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT000009") + '</option>');
	write('<option value="U">' + jspResArr.get("FLT000010") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT000008") + '</option>');
	write('<option value="D">' + jspResArr.get("FLT000007") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT000006") + '</option>');

	write('</select>');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	write('<tr>');

	write('<td class="textlabel">' + jspResArr.get("FLT11000028") + '<font color="red" size="2"> *</font></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" name="' + subGroupName + '.acctNo" id="acctNo" ' + cichqmProps.get("acctNo_ENABLED") + ' size="20" maxlength="20"  class="textfieldfont" onChange="javascript:fnOnchange();">');
	write('&nbsp;<a href="javascript:fnshowAccountIdList(document.forms[0].acctNo);" id="sLnk2" >');
	write('<img hotKeyId="search1" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0"></img>');

        write('</td>');
        write('<td>&nbsp;</td>');
        write('<td>&nbsp;</td>');
        write('<td>&nbsp;</td>');
        write('</tr>');
        write('<tr>');

	write('<td class="textlabel">' + jspResArr.get("FLT11000027") + '<font color="red" size="2"> *</font></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" name="' + subGroupName + '.requestId1" id="requestId1" ' + cichqmProps.get("requestId1_ENABLED") + ' size="20" maxlength="20"  class="textfieldfont" >');
	write('<a target=_self id="sLnk4" href="javascript:fnCustSearcherold(document.forms[0].requestId1)" onClick="javascript:return searchVal(this.id);"><img class="img" id="imgser" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search4"></img></a>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
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
	write('<div class="ctable">');
	write('<input type="button" name="Accept" value="Go" class="button" id="Accept" onClick="javascript:return cichqm_crit_ONCLICK2(this,this);" hotKeyId="Go">');
	write('<input type="button" name="Clear" value="Clear" class="button" id="Clear" onClick="javascript:return cichqm_crit_ONCLICK3(this);">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];
	
	pre_ONLOAD('cichqm_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	post_ONLOAD('cichqm_crit',this);
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.funcCode.value = funcCode;
	ObjForm.requestId1.value = requestId1;
        if(funcCode != ""){
                ObjForm.acctNo.value=acctNo;
        }
	fnDisableFields();
}


function cichqm_crit_ONCHANGE1(obj,p1)
{
	var retVal = "";
	if (pre_ONCHANGE('cichqm_crit',obj) == false) { 
		return false;
	}
/*	if ((retVal = validateUser(p1)) == false) {
		return false;
	}*/
	if (post_ONCHANGE('cichqm_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cichqm_crit_ONCLICK2(obj,p1)
{
	if (document.forms[0].funcCode.value == ""){
	alert("Please select the Function Code");
	document.forms[0].funcCode.focus();
	return false;
	}
if((document.forms[0].funcCode.value=='U') || (document.forms[0].funcCode.value=='A')){
        if (document.forms[0].acctNo.value == ""){
        alert("Please enter the Account No");
        document.forms[0].acctNo.focus();
        return false;
        }
}
	var retVal = "";
	if (pre_ONCLICK('cichqm_crit',obj) == false) { 
		return false;
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('cichqm_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cichqm_crit_ONCLICK3(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cichqm_crit',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cichqm_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function searchVal(obj){
	var funCode	= document.forms[0].funcCode.value;
	//var acctNo	= document.forms[0].acctNo.value;
	if(funCode==""){
		alert("Please select the function Code");
		return false;
	}
	return true;
}

function fnValidateData() {
	return true;
 }

function fnCustSearcherold()
{
	var funCode		= document.forms[0].funcCode.value;
if(funCode != "" ){
	var inputNameValues	= "funCode|"+funCode;
	var outputNames		= "requestId1|acctID|reqStatus";
	var scrName		= "ichqbookmn002.scr";
	var title		= "LIST OF REQUEST ID";
	var literalNames	= "REQUEST ID|ACCOUNT NO|REQUEST STATUS";
	var hyperLnks		= "1";
	var retVal		= fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
}
}

function fnDisableFields() {
        if(document.forms[0].funcCode.value == 'A'){
                document.forms[0].requestId1.disabled = true;
                document.forms[0].acctNo.disabled = false;
                document.forms[0].requestId1.value = "";
                document.getElementById('sLnk4').style.visibility = "hidden";
                document.getElementById('sLnk2').style.visibility = "visible";
        }
        if((document.forms[0].funcCode.value == 'I') || (document.forms[0].funcCode.value == 'D') || (document.forms[0].funcCode.value == 'V') ){
                document.forms[0].requestId1.disabled = false;
                document.forms[0].acctNo.disabled = true;
                document.forms[0].acctNo.value = "";
                document.getElementById('sLnk4').style.visibility = "visible";
                document.getElementById('sLnk2').style.visibility = "hidden";
        }
        if(document.forms[0].funcCode.value == 'U'){
                document.forms[0].requestId1.disabled = true;
                document.forms[0].requestId1.value = "";
                document.forms[0].acctNo.disabled = false;
                document.getElementById('sLnk2').style.visibility = "visible";
                document.getElementById('sLnk4').style.visibility = "hidden";
        }
}

function fnshowAccountIdList(obj){
	showAccountIdList(obj,null,null,'F');
}
function fnOnchange() {
        var foracid 		= document.forms[0].acctNo.value.toUpperCase();
        var inputNameValues	= "acctNum|"+foracid
        var outputNames		= ""
        var scrName		= "cecsmimn01.scr";
        var retVal		= appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret			= retVal.split("|");
        var msg			= ret[0];
        if(msg == "RESULT_MSG"){
                alert(ret[1]);
                document.forms[0].acctNo.focus();
                document.forms[0].acctNo.value = ""
                return false;
        }
}

