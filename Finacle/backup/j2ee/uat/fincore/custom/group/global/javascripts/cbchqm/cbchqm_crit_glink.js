function printBlock()
{
	writeCustomHeader("cbchqm_crit");
	with (document){
	write('<input type="hidden" name="cbchqm.myIPAddress" id="myIPAddress">');
//	write('<input type="hidden" name="cbchqm.acctNo" id="acctNo">');
//	write('<input type="hidden" name="cbchqm.reqStat" id="reqStat">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td><table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">BANKERS CHQ REQUEST MENU</td>');
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
	write('<a href="javascript:showHelpFile(\'cbchqmcrit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0"></a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000204") + '<font color="red" size="2"> *</font></td>');
	write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + cbchqmProps.get("funcCode_ENABLED") + ' class="textfieldfont" " onchange="javascript:fnDisableFields(this)">');
	write('<option selected value = "">--Select--</option>');
    write('<option value="A">A - Add</option>');
    write('<option value="I">I - Inquiry</option>');
    write('<option value="D">D - Delete</option>');
    write('<option value="V">V - Verify</option>');
	write('</select>');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000028") + '<font color="red" size="2"> *</font></td>');	
	write('<td class="textfield">');	
	write('<input type="text" name="' + subGroupName + '.acctNo" id="acctNo" ' + cbchqmProps.get("acctNo_ENABLED") + ' size="20" maxlength="20"  class="textfieldfont" >');	
	write('<a href="javascript:fnshowAccountIdList(document.forms[0].acctNo);" id="sLnk2" >');	
	write('<img hotKeyId="search1" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0"></img>');	
	write('</td>');	
	write('<td>&nbsp;</td>');	
	write('<td>&nbsp;</td>');	
	write('<td>&nbsp;</td>');	
	write('</tr>');	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000027") + '<font color="red" size="2"> *</font></td>');
	write('<td class="textfield">');
	write('<input type="text" name="' + subGroupName + '.requestId" id="requestId" ' + cbchqmProps.get("requestId_ENABLED") + ' size="20" maxlength="20"  class="textfieldfont" >');
	write('<a href="javascript:fnCustSearcherold();" id="slnk10" >');
        write('<img id ="imgser" hotKeyId="search1" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0"></img>');
        write('</a>');
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
	write('<input type="button" name="Accept" value="Go" class="button" id="Accept" onClick="javascript:return cbchqm_crit_ONCLICK2(this,this);" hotKeyId="Go">');
	write('<input type="button" name="Clear" value="Clear" class="button" id="Clear" onClick="javascript:return cbchqm_crit_ONCLICK3(this);">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];
	
	pre_ONLOAD('cbchqm_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	post_ONLOAD('cbchqm_crit',this);
}

function post_ONLOAD(obj1,obj2)
{
	
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
	ObjForm.acctNo.value = acctNo;
	ObjForm.requestId.value = requestId;
}


function cbchqm_crit_ONCHANGE1(obj,p1)
{
	var retVal = "";
	if (pre_ONCHANGE('cbchqm_crit',obj) == false) { 
		return false;
	}
	if ((retVal = validateUser(p1)) == false) {
		return false;
	}
	if (post_ONCHANGE('cbchqm_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cbchqm_crit_ONCLICK2(obj,p1)
{
	var retVal = "";

	
	if(fnIsNull(document.forms[0].funcCode.value)) {
        alert("Enter the Function Code");
        document.forms[0].funcCode.focus();
        return false;
        }
	if((document.forms[0].funcCode.value) != 'I'){
		if(fnIsNull(document.forms[0].acctNo.value)) {
        		alert("Enter the Account Number");        
			document.forms[0].acctNo.focus();
       			return false;     
	   	}
	}
	if((document.forms[0].funcCode.value) != 'A'){
        if(fnIsNull(document.forms[0].requestId.value)) {
        alert("Request ID Should be entered");
        document.forms[0].requestId.focus();
        return false;
        }
	}
	

        if (pre_ONCLICK('cbchqm_crit',obj) == false) { 
		return false;
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
        if (post_ONCLICK('cbchqm_crit',obj) == false) { 
		return false;
	}
	
	return (retVal == undefined) ? true : retVal;
}
function cbchqm_crit_ONCLICK3(obj)
{
      if(obj.id == "Clear")
      {
      	document.forms[0].reset();
	doSubmit(obj.id);
	return true;
      }
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

        function fnCustSearcherold()
        {
        var inputNameValues = "funcCode|"+document.forms[0].funcCode.value +"|acctNo|"+document.forms[0].acctNo.value;
        var outputNames = "requestId|acctNo|reqStat";
        var scrName     = "bcchqmn002.scr";
        var title  = "LIST OF REQUEST ID";
        var literalNames="REQUEST ID|ACCOUNT NO|REQUEST STATUS";
        var hyperLnks   = "1";
        var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
	//	alert(document.getElementById("requestId").value);

}

function fnDisableFields() {
        if(document.forms[0].funcCode.value == 'A'){
				document.getElementsByName("cbchqm.requestId")[0].value="";
				document.forms[0].acctNo.value="";
                document.getElementsByName("cbchqm.requestId")[0].disabled=true;
                document.getElementById('slnk10').style.visibility = "hidden";
        }
        if((document.forms[0].funcCode.value == 'U') || (document.forms[0].funcCode.value == 'I') || (document.forms[0].funcCode.value == 'D') || (document.forms[0].funcCode.value == 'V') ){
                document.getElementsByName("cbchqm.requestId")[0].disabled=false;
                document.getElementById('slnk10').style.visibility = "visible";
        }
}
function fnshowAccountIdList(obj){
        showAccountIdList(obj,null,null,'F');
	fnOnchange();
}

function cbchqm_crit_pre_ONCLICK(obj) {
	if(document.forms[0].funcCode.value != 'A')
	{
		if(document.forms[0].acctNo.value != "")
		{
			var foracid             = document.forms[0].acctNo.value.toUpperCase();
			var inputNameValues     = "acctNum|"+foracid
			var outputNames         = ""
			var scrName             = "cecsmimn01.scr";
			var retVal              = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret                 = retVal.split("|");
			var msg                 = ret[0];
			if(msg == "RESULT_MSG"){
				alert(ret[1]);
				document.forms[0].acctNo.focus();
				document.forms[0].acctNo.value = ""
				return false;
			}
		}
	}
fnOnchange();
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

}


