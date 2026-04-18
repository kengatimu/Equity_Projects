function printBlock()
{
	writeCustomHeader("cchqm_crit1");
	with (document){
	write('<input type="hidden" name="nextPage" id="nextPage">');
	write('<input type="hidden" name="cchqm.myIPAddress" id="myIPAddress">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td><table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Cheque Book Maintenance</td>');
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
	write('<a href="javascript:showHelpFile(\'cchqmcrit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0"></a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000204") + '<font color="red" size="2"> *</font></td>');
	write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + cchqmProps.get("funcCode_ENABLED") + ' class="textfieldfont" " onchange="javascript:fnDisableFields(this)">');
	write('<option selected value = "">--Select--</option>');
	write('<option value="A">A - Add</option>');
	write('<option value="V">V - Verify</option>');
	if (profileId == "43")
        {
	write('<option value="S">S - Download And Send To Vendor for Printing</option>');
	write('<option value="R">R - Recieved From Vendor And Upload</option>');
	write('<option value="B">B - Sent TO Destination Branch</option>');
	write('<option value="SB">SB - Sent TO Destination Branch As Bulk</option>');
	write('<option value="K">K - Aknowledgement At Destination Branch</option>');
	}
	write('<option value="U">U - Issue</option>');
	write('<option value="I">I - Inquiry</option>');
	write('<option value="D">D - Delete</option>');
	write('</select>');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');	
	write('<tr>');

	write('<td class="textlabel">' + jspResArr.get("FLT11000028") + '<font color="red" size="2"> *</font></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" name="' + subGroupName + '.acctNo" id="acctNo" ' + cchqmProps.get("acctNo_ENABLED") + ' size="20" maxlength="20"  class="textfieldfont" onChange="javascript:fnOnchangeFacid(this);">');
	write('&nbsp;<a target=_self href="javascript:fnshowAccountIdList(document.forms[0].acctNo);" id="sLnk2" >');
write('<img hotKeyId="search1" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0"></img></a>');
//363819
write('&nbsp;<input onChange="javascript:fnOnchangename(acctNo);" onBlur="javascript:fnOnchangename(acctNo);" id="acctname" name="' + subGroupName + '.acctname" type="text" disabled="true" class="label">');
//363819
write('</td>');
write('<td>&nbsp;</td>');
write('<td>&nbsp;</td>');
write('<td>&nbsp;</td>');
write('</tr>');
write('<tr>');

write('<td class="textlabel">' + jspResArr.get("FLT11000027") + '<font color="red" size="2"> *</font></td>');
write('<td class="textfield">');
write('<input hotKeyId="search2" type="text" name="' + subGroupName + '.requestId" id="requestId" ' + cchqmProps.get("requestId_ENABLED") + ' size="20" maxlength="20"  class="textfieldfont" >');
write('<a target=_self id="sLnk4" href="javascript:fnCustSearcherold(document.forms[0].requestId)" onClick="javascript:return searchVal(this.id);">');
write('<img class="img" hotKeyId="search2" id="imgser" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search4"></img></a>');
	write('</td>');
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
	write('<input type="button" name="Accept" value="Go" class="button" id="Accept" onClick="javascript:return cchqm_crit1_ONCLICK2(this,this);" hotKeyId="Go">');
	write('<input type="button" name="Clear" value="Clear" class="button" id="Clear" onClick="javascript:return cchqm_crit1_ONCLICK3(this);">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];
        //if((funcCode == "I") ||(funcCode == "B") ||(funcCode == "K") ||(funcCode == "V") ||(funcCode == "S") ||(funcCode == "R"))
        if((funcCode == "I") ||(funcCode == "B") ||(funcCode == "K") ||(funcCode == "V") ||(funcCode == "S") ||(funcCode == "R") ||(funcCode == "SB"))
        {
                document.getElementById('sLnk2').style.visibility = "hidden";
        }

	ObjForm.funcCode.focus();	
	pre_ONLOAD('cchqm_crit1',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}
	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	post_ONLOAD('cchqm_crit1',this);
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.requestId.value = requestId;
	ObjForm.funcCode.value = funcCode;
	if(funcCode != ""){
		ObjForm.acctNo.value=acctNo;
		//
		ObjForm.acctname.value=acctname;
		//
	}
	fnDisableFields();
}


function cchqm_crit1_ONCHANGE1(obj,p1)
{
	var retVal = "";
	if (pre_ONCHANGE('cchqm_crit1',obj) == false) { 
		return false;
	}
	if ((retVal = validateUser(p1)) == false) {
		return false;
	}
	if (post_ONCHANGE('cchqm_crit1',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cchqm_crit1_ONCLICK2(obj,p1)
{
	if (document.forms[0].funcCode.value == ""){
		alert("Please select the function Code");
		document.forms[0].funcCode.focus();
		return false;
	}
//if ((document.forms[0].funcCode.value != "D") && (document.forms[0].funcCode.value != "V") && (document.forms[0].funcCode.value != "I") && (document.forms[0].funcCode.value != "S") && (document.forms[0].funcCode.value != "R") && (document.forms[0].funcCode.value != "B") && (document.forms[0].funcCode.value != "K")){
if ((document.forms[0].funcCode.value != "D") && (document.forms[0].funcCode.value != "V") && (document.forms[0].funcCode.value != "I") && (document.forms[0].funcCode.value != "S") && (document.forms[0].funcCode.value != "R") && (document.forms[0].funcCode.value != "B") && (document.forms[0].funcCode.value != "K") &&(document.forms[0].funcCode.value != "SB")){
        if (document.forms[0].acctNo.value == ""){
        	alert("Please enter the account no");
        	document.forms[0].acctNo.focus();
        	return false;
        }
}
	//if((document.forms[0].funcCode.value!="A") && (document.forms[0].funcCode.value!="U") && (document.forms[0].funcCode.value!="S") && (document.forms[0].funcCode.value!="R")){
	if((document.forms[0].funcCode.value!="A") && (document.forms[0].funcCode.value!="U") && (document.forms[0].funcCode.value!="S") && (document.forms[0].funcCode.value!="R") && (document.forms[0].funcCode.value!="SB")){
        	if (document.forms[0].requestId.value == ""){
        		alert("Please enter the Request Id");
        		document.forms[0].requestId.focus();
        		return false;
        	}
	}
	var retVal = "";
	if (pre_ONCLICK('cchqm_crit1',obj) == false) { 
		return false;
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('cchqm_crit1',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cchqm_crit1_ONCLICK3(obj)
{
	var retVal = "";
	document.forms[0].funcCode.value="";
	document.forms[0].requestId.value="";
	document.forms[0].acctNo.value="";
	if (pre_ONCLICK('cchqm_crit1',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cchqm_crit1',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
		
function searchVal(obj){
	var funCode = document.forms[0].funcCode.value;
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
	var funCode = document.forms[0].funcCode.value;
	 if(funCode != "" ){ 
		var inputNameValues	= "funCode|"+funCode;
		var outputNames		= "requestId|acctID|reqStatus";
		var scrName		= "chqbookmn002.scr";
		var title		= "LIST OF REQUEST ID";
		var literalNames	= "REQUEST ID|ACCOUNT NO|REQUEST STATUS";
		var hyperLnks		= "1";
		var retVal		= fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
	}
}
function fnDisableFields() {
        if(document.forms[0].funcCode.value == 'A'){
                document.forms[0].requestId.disabled = true;
		document.forms[0].acctNo.disabled = false;
		document.forms[0].requestId.value = "";
		document.getElementById('sLnk4').style.visibility = "hidden";
		document.getElementById('sLnk2').style.visibility = "visible";
        }
        // if((document.forms[0].funcCode.value == 'I') || (document.forms[0].funcCode.value == 'D') || (document.forms[0].funcCode.value == 'V') || (document.forms[0].funcCode.value == 'S') || (document.forms[0].funcCode.value == 'R') || (document.forms[0].funcCode.value == 'B') || (document.forms[0].funcCode.value == 'K') ){
        if((document.forms[0].funcCode.value == 'I') || (document.forms[0].funcCode.value == 'D') || (document.forms[0].funcCode.value == 'V') || (document.forms[0].funcCode.value == 'B') || (document.forms[0].funcCode.value == 'K') ){
                document.forms[0].requestId.disabled = false;
		document.forms[0].acctNo.disabled = true;
		document.forms[0].acctNo.value = "";
		document.getElementById('sLnk4').style.visibility = "visible";
		document.getElementById('sLnk2').style.visibility = "hidden";
	}
 //       if((document.forms[0].funcCode.value == 'S') || (document.forms[0].funcCode.value == 'R')){
        if((document.forms[0].funcCode.value == 'S') || (document.forms[0].funcCode.value == 'R') || (document.forms[0].funcCode.value == 'SB')){
                document.forms[0].requestId.disabled = true;
		document.forms[0].acctNo.disabled = true;
		document.forms[0].acctNo.value = "";
		document.getElementById('sLnk4').style.visibility = "hidden";
		document.getElementById('sLnk2').style.visibility = "hidden";
	}
	if(document.forms[0].funcCode.value == 'U'){
		document.forms[0].requestId.disabled = true;
		document.forms[0].requestId.value = "";
		document.forms[0].acctNo.disabled = false;
		document.getElementById('sLnk2').style.visibility = "visible";
                document.getElementById('sLnk4').style.visibility = "hidden";
	}
}

function fnshowAccountIdList(obj){
	showAccountIdList(obj,null,null,'F');
	fnOnchange();
	fnOnchangename();
}

//363819
function fnOnchangename(obj)
{
			var dco=document.forms[0].acctNo.value;
			var input      = "dco|"+dco;
			var outputNames    = "output|outVal";
			var scrName     =   "b_acctname.scr";
			var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			//alert(a);

			document.forms[0].acctname.value=a; 
}
//363819

function fnOnchangeFacid(obj) {
        var foracid 		= document.forms[0].acctNo.value.toUpperCase();
        var inputNameValues	= "acctNum|"+foracid
        var outputNames		= ""
        var scrName		= "cecsmimn02.scr";
        var retVal		= appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret			= retVal.split("|");
        var msg			= ret[0];
        if(msg == "RESULT_MSG"){
                alert(ret[1]);
                document.forms[0].acctNo.focus();
                document.forms[0].acctNo.value = ""
                return false;
        }
fnOnchange();
fnOnchangename();

}

function fnOnchange() {
        var inputNameValues = "acctNum|"+document.forms[0].acctNo.value;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" )
        {
                alert(ret1[1]);
        }

    var foracid = document.forms[0].acctNo.value.toUpperCase();
	if(foracid != "") 
    {
    if (profileId=="11")
    {
        // Document Expiration Check --- Anderson
        if (document.forms[0].acctNo.value != "") {
            var inputNameValues = "foracid|" + document.forms[0].acctNo.value;
            var outputNames = "msgFlg";
            var scrName = "checkDocExpDate.scr";
            retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
            retVal = retVal.split("|");
            if (retVal[1]) {
                alert(retVal[1]);
            }
        }
        // End Document Expiration Check --- Anderson
	}
    }
}

function fnValAndSubmit(btnObj)
{
	var ObjForm = document.forms[0];
	if(document.forms[0].funcCode.value == 'S')
	{
		ObjForm.nextPage.value = "cchqm_det3.jsp";
                doSubmit(btnObj.id);
                return;
	}
	else
	{
		if((document.forms[0].funcCode.value == 'R')|| (document.forms[0].funcCode.value == 'SB'))
		{
			ObjForm.nextPage.value = "cchqm_det2.jsp";
                	doSubmit(btnObj.id);
                	return;
		}
		else	
		{
			ObjForm.nextPage.value = "cchqm_det1.jsp";
                	doSubmit(btnObj.id);
                	return;
		}
	}
}

