function printBlock()
{
	writeCustomHeader("cuics_crit");
	with (document){
	write('<input type="hidden" name="cuics.myIPAddress" id="myIPAddress">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td><table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Update Inhouse Cheque Book Status</td>');
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
	write('<a href="javascript:showHelpFile(\'cuicscrit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0"></a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000004") + '<font color="red" size="2"> *</font></td>');
	write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + cuicsProps.get("funcCode_ENABLED") + ' class="textfieldfont">');
	write('<option value = "" selected>' + jspResArr.get("FLT000005") + '</option>');
	write('<option value="M">' + jspResArr.get("FLT000009") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT000010") + '</option>');
//	write('<option value="V">' + jspResArr.get("FLT000008") + '</option>');
//	write('<option value="X">' + jspResArr.get("FLT000007") + '</option>');
	write('</select>');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000003") + '<font color="red" size="2"> *</font></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" name="' + subGroupName + '.acctId" id="acctId" ' + cuicsProps.get("acctId_ENABLED") + ' size="20" maxlength="20"  class="textfieldfont" onChange="javascript:fnCustValidate();">');
	write('&nbsp;<a href="javascript:fnshowAccountIdList(document.forms[0].acctId);" id="sLnk2" >');
	write('<img hotKeyId="search1" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0"></img>');

	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000011") + '<font color="red" size="2"> *</font></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" name="' + subGroupName + '.instType" id="instType" ' + cuicsProps.get("instType_ENABLED") + ' size="20" maxlength="20"  class="textfieldfont" onchange="javascript:return cuics_crit_ONCHANGE1(this,this);">');
	write('&nbsp;<a target="_self" id="sLnk3" href="JavaScript:getInstrTypeList(document.forms[0].instType,document.forms[0].acctId.value,\'ctrl\',\'F\')">');
	write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search3"></IMG></a>');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000012") + '<font color="red" size="2"> *</font></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" name="' + subGroupName + '.instNum" id="instNum" ' + cuicsProps.get("instNum_ENABLED") + ' size="20" maxlength="20"  class="textfieldfont" onchange="javascript:return cuics_crit_ONCHANGE1(this,this);">');
	write('</td>');

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
	write('<input type="button" name="Accept" value="Go" class="button" id="Accept" onClick="javascript:return cuics_crit_ONCLICK2(this,this);" hotKeyId="Go">');
	write('<input type="button" name="Clear" value="Clear" class="button" id="Clear" onClick="javascript:return cuics_crit_ONCLICK3(this);">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];
	
	pre_ONLOAD('cuics_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}
	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	post_ONLOAD('cuics_crit',this);
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.funcCode.value = funcCode;
	ObjForm.acctId.value = acctId;
	ObjForm.instType.value = instType;
	ObjForm.instNum.value = instNum;
	return true;
}


function cuics_crit_ONCHANGE1(obj,p1)
{
	var retVal = "";
	if (pre_ONCHANGE('cuics_crit',obj) == false) { 
		return false;
	}
	/*if ((retVal = validateUser(p1)) == false) {
		return false;
	}*/
	if (post_ONCHANGE('cuics_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cuics_crit_ONCLICK2(obj,p1)
{
	var retVal = "";
	
		if(fnIsNull(document.forms[0].funcCode.value)) {
        alert("Function should be entered");
        document.forms[0].funcCode.focus();
        return false;
        }
        /*if(fnIsNull(document.forms[0].acctId.value)) {
        alert("Account number should be entered");
        document.forms[0].acctId.focus();
        return false;
        }
        if(fnIsNull(document.forms[0].instType.value)) {
        alert("Inst type should be entered");
        document.forms[0].instType.focus();
        return false;
        }
        if(fnIsNull(document.forms[0].instNum.value)) {
        alert("Inst number should be entered");
        document.forms[0].instNum.focus();
        return false;
        }
	*/
	if (pre_ONCLICK('cuics_crit',obj) == false) { 
		return false;
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('cuics_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cuics_crit_ONCLICK3(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cuics_crit',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cuics_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnValidateData() {
	return true;
}
function fnshowAccountIdList(obj){

        showAccountIdList(obj,null,null,'F');
}

