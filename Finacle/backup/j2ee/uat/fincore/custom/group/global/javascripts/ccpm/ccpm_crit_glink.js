function printBlock()
{
	writeCustomHeader("ccpm_crit");
	with (document){
	write('<input type="hidden" name="ccpm.myIPAddress" id="myIPAddress">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td><table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">CREDIT LIMIT ROLE PROFILE MAINTENANCE </td>');
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
	write('<a href="javascript:showHelpFile(\'ccpmcrit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0"></a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000004") + '<font color="red" size="2"> *</font></td>');
	write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + ccpmProps.get("funcCode_ENABLED") + ' class="textfieldfont" >');
	write('<option value=""selected>' + jspResArr.get("FLT000005") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT000006") + '</option>');
	write('<option value="M">' + jspResArr.get("FLT000009") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT000010") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT000008") + '</option>');
	write('<option value="D">' + jspResArr.get("FLT000007") + '</option>');
	write('</select>');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000003") + '<font color="red" size="2"> *</font></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" name="' + subGroupName + '.roleId" id="roleId" ' + ccpmProps.get("roleId_ENABLED") + ' size="20" maxlength="20"  class="textfieldfont" onchange="javascript:fnCustValidate();">');
	 write('<a target=_self id="sLnk4" href="javascript:fnCustSearcherold(document.forms[0].roleId);"><img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search4"></img></a>');

	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000011") + '<font color="red" size="2"> *</font></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" name="' + subGroupName + '.currency" id="currency" ' + ccpmProps.get("currency_ENABLED") + ' size="20" maxlength="20"  class="textfieldfont" onchange="javascript:return ccpm_crit_ONCHANGE1(this,this);">');
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
	write('<input type="button" name="Accept" value="Go" class="button" id="Accept" onClick="javascript:return ccpm_crit_ONCLICK2(this,this);" hotKeyId="Go">');
	write('<input type="button" name="Clear" value="Clear" class="button" id="Clear" onClick="javascript:return ccpm_crit_ONCLICK3(this);">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];
	
	pre_ONLOAD('ccpm_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	post_ONLOAD('ccpm_crit',this);
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.funcCode.value = funcCode;
	ObjForm.roleId.value = roleId;
	ObjForm.currency.value = currency;
	return true;
}


function ccpm_crit_ONCHANGE1(obj,p1)
{
	var retVal = "";
	if (pre_ONCHANGE('ccpm_crit',obj) == false) { 
		return false;
	}
	if ((retVal = validateUser(p1)) == false) {
		return false;
	}
	if (post_ONCHANGE('ccpm_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ccpm_crit_ONCLICK2(obj,p1)
{
	var retVal = "";
	
	if(fnIsNull(document.forms[0].funcCode.value)) {
        alert("Enter the Function Code");
        document.forms[0].funcCode.focus();
        return false;
        }
        if(fnIsNull(document.forms[0].roleId.value)) {
        alert("Role ID Should be entered");
        document.forms[0].roleId.focus();
        return false;
        }
        if(fnIsNull(document.forms[0].currency.value)) {
        alert("Currency Code Should be entered");
        document.forms[0].currency.focus();
        return false;
        }


	if (pre_ONCLICK('ccpm_crit',obj) == false) { 
		return false;
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('ccpm_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ccpm_crit_ONCLICK3(obj)
{
	var retVal = "";
	if (pre_ONCLICK('ccpm_crit',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('ccpm_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnValidateData() {
	return true;
}
function fnCustValidate(){
        if(fnIsNull(document.forms[0].roleId.value)){
                document.forms[0].currency.value = "";
        }
	if(document.forms[0].funcCode.value != "A" && document.forms[0].roleId.value != "") {
                var inputNameValues    = "roleIdval|"+document.forms[0].roleId.value; 
                var outputNames     = "crncy";
                var scrName         = "roleIdValscript.scr";
                var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
                var ret = retVal.split("|");
               if(ret[0] == "crncy"){
		 document.forms[0].currency.value = ret[1];
        	} else if(ret[0] == "Err"){
			//alert(ret[1]);
		}
	}
	else
	{
		document.forms[0].currency.value = "";
	}
}
function fnCustSearcherold()
        {
	var inputNameValues = ""
        var outputNames = "roleId|currency|rcreID";
        var scrName     = "ccpmdp004.scr";
        var title       = "Role ID searcher";
        var literalNames= "Role ID|Currency|UserID";
        var hyperLnks   = "1";
        var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
	fnCustValidate();
}
