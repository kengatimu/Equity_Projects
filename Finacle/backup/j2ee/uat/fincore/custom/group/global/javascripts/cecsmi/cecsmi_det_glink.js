function printBlock()
{
	writeCustomHeader("cecsmi_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">ECS MANDATE INQUIRY MENU</td>');
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
	write('<a href="javascript:showHelpFile(\'cecsmi_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026333") +'</td>');
	write('<td><input name="' + subGroupName + '.solId" id="solId" ' + cecsmiProps.get("fileName_ENABLED") + ' value="" type="text" disabled = "disabled" class="textfieldfont" size="25" maxlength="16">');
	var sol = headCtxSol;
	document.forms[0].solId.value = sol;
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">&nbsp;');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026337") + '&nbsp;<font color="red">*</font></td>');
	write('<td> <input  class="textfieldfont"  mnebl="false" " name="' + subGroupName + '.acctNum" id="acctNum" type="text" class="textfieldfont" maxlength="16" value="" onchange="javascript:fnOnchange()">');
	write('<a href="javascript:fnshowAccountIdList(document.forms[0].acctNum);" id="sLnk2" >');
	write('<img hotKeyId="search1" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0"></img></a>');
	write('<div style="position:absolute;"></div></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT026338") + '&nbsp;<font color="red">*</font></td>');
	write('<td> <input  class="textfieldfont"  mnebl="false" " name="' + subGroupName + '.paySysId" disabled = "disabled"id="paySysId" type="text" class="textfieldfont" maxlength="10" value="ECS">');
	write('<div  style="position:absolute;"></div></td>');
	write('</td>');
	write('</tr>');
	write('<tr>');
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
	write('<div class="ctable">');
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cecsmi_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cecsmi_det_ONCLICK2(this);" id="Clear" value="Clear">');
	writeFooter();
	write('</div>');
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];
	pre_ONLOAD('cecsmi_det',this);
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
	fnPostOnLoad()
	post_ONLOAD('ctdsdnld_det',this);
}

function fnOnchange() {
	var foracid = document.forms[0].acctNum.value.toUpperCase();
	var inputNameValues		= "acctNum|"+foracid 
	var outputNames			= ""
	var scrName				= "cecsmimn01.scr";
	var retVal				= appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var ret					= retVal.split("|");
	var msg					= ret[0];
	if(msg == "RESULT_MSG"){
		alert(ret[1]);	
		document.forms[0].acctNum.focus();
		document.forms[0].acctNum.value = ""
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

	//ObjForm.date1.value = date1;
	//ObjForm.date2.value = date2;
}

function fnOnLoad()
{
	var ObjForm = document.forms[0];
	pre_ONLOAD('cecsmi_det',this);
	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}
}

function cecsmi_det_ONCLICK1(obj,p1)
{
	if(document.forms[0].acctNum.value == ""){
		alert("Account Number is mandatory");
		document.forms[0].acctNum.focus();
		return false;
	}
	if(document.forms[0].acctNum.value != ""){
		var forAcid = document.forms[0].acctNum.value;
		var inputNameValues = "forAcid" +"|" +forAcid ;
		var outputNames = "mandNum|strtDate|endDate|refId|amount";
		var scrName     = "cecsmidp002.scr";
		var title  = "LIST OF EMD VALUES";
		var literalNames="SNO|STARTDATE|ENDDATE|REFID|AMOUNT";
		var hyperLnks   = "6";
		var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
		var retVal = "";
	}
	cecsmi_det_ONCLICK2(document.forms[0].Clear);
}

function cecsmi_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cecsmi_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cecsmi_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnshowAccountIdList(obj){
	showAccountIdList(obj,null,null,'F');
}
