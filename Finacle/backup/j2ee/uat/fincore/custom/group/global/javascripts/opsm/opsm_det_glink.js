function printBlock()
{
	writeCustomHeader("opsm_det");
	document.write('<input type="hidden" id="frmDate" fdt="fdate" fmnd="Y"  mneb1="N" vFldId="frmdate_ui" name="' + subGroupName + '.frmDate" onchange="javascript:fnOnchange()">');
       document.write('<input type="hidden" id="toDate" fdt="fdate" fmnd="Y"  mneb1="N" vFldId="todate_ui" name="' + subGroupName + '.toDate">');
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">OPSM</td>');
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
	write('<a href="javascript:showHelpFile(\'opsm_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">&nbsp;');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") + '&nbsp;<font color="red">*</font></td>');
	write('<td> <input class="textfieldfont"  mnebl="false" " name="' + subGroupName + '.acctNum" id="acctNum" type="text" class="textfieldfont" maxlength="16" value="" onchange="javascript:fnOnchange()">');
	write('<a href="javascript:fnshowAccountIdList(document.forms[0].acctNum);" id="sLnk2" >');
	write('<img hotKeyId="search1" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0"></img></a>');
	write('<div style="position:absolute;"></div></td>');
	write('</tr>');
	write('<tr>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026336") + '&nbsp;<font color="red">*</font></td>');
	//write('<td><input name="' + subGroupName + '.frmdate_ui" id="frmdate_ui" ' + opsmProps.get("frmdate_ui_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" >');
        write('<td><input type="text" class="textfieldfont" id="frmdate_ui"" name="' + subGroupName + '.frmdate_ui" fdt="frmdate_ui" mnebl="false" fmnd="Y" fblk="defaultFblk1" hotKeyId="calender1" onchange = "javascript:fnOnchange(this,this,this)">');
        write('<a id="frmDateImg" href="javascript:openDate(document.forms[0].frmdate_ui,BODDate)">');
        write('<img width="24" height="19" src="../images/INFENG/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand"></a>');
        write('<div style="position:absolute;"></div>');
	write('</td>');
	
	write('<td class="textlabel">' + jspResArr.get("FLT026337") + '&nbsp;<font color="red">*</font></td>');
	//write('<td><input name="' + subGroupName + '.todate_ui" id="todate_ui" ' + opsmProps.get("todate_ui_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" >');
	write('<td><input type="text" class="textfieldfont" id="todate_ui"" name="' + subGroupName + '.todate_ui" fdt="todate_ui" mnebl="false" fmnd="Y" fblk="defaultFblk1" hotKeyId="calender1" >');
        write('<a id="frmDateImg" href="javascript:openDate(document.forms[0].todate_ui,BODDate)">');
        write('<img width="24" height="19" src="../images/INFENG/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand"></a>');
        write('<div style="position:absolute;"></div>');
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return opsm_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return  opsm_det_ONCLICK2(this);" id="Clear" value="Clear">');
	writeFooter();
	write('</div>');
	} //End with()
}//End function
	function pre_ONLOAD(){
	document.forms[0].todate_ui.value = BODDate;
	}
function fnOnLoad()
{
	
	var ObjForm = document.forms[0];
	pre_ONLOAD('opsm_det',this);
	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	fnPostOnLoad()
	post_ONLOAD('opsm_det',this);
}

function fnOnchange() {
	var foracid 			= document.forms[0].acctNum.value.toUpperCase();
	var frmdate_ui		= document.forms[0].frmdate_ui.value;
	var todate_ui			= document.forms[0].todate_ui.value;
	var inputNameValues		= "acctNum|"+foracid +"|frmdate_ui|"+frmdate_ui +"|todate_ui|"+todate_ui  
	var outputNames			= ""
	var scrName			= "opsmmn01.scr";
	var retVal			= appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var ret				= retVal.split("|");
	var msg				= ret[0];
	var msg1			= ret[2];
       if(msg == "RESULT_MSG"){
		alert(ret[1]);	
		document.forms[0].acctNum.value = "";
		document.forms[0].acctNum.focus(); 
		return false;
	}

     		if(msg1 == "DATE"){
		alert(ret[3]);
		document.forms[0].frmdate_ui.focus();
		document.forms[0].frmdate_ui.value = "";
		return false;
	}
		if(msg1 == "BAL"){
		alert(ret[3]);
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
	pre_ONLOAD('opsm_det',this);
	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}
}

function opsm_det_ONCLICK1(obj,p1)
{
	if(document.forms[0].acctNum.value == ""){
		alert("Account Number is mandatory");
		document.forms[0].acctNum.focus();
		return false;
	}
	if(document.forms[0].frmdate_ui.value == ""){
		alert("From Date is mandatory");
		document.forms[0].frmdate_ui.focus();
		return false;
	}	
	if(document.forms[0].todate_ui.value == ""){
		alert("To Date is mandatory");
		document.forms[0].todate_ui.focus();
		return false;
	}
	
	if((document.forms[0].acctNum.value != "") && (document.forms[0].frmdate_ui.value != "") && (document.forms[0].todate_ui.value != "")){
		//alert("inside");
		var foracid = document.forms[0].acctNum.value;
		var frmdate_ui = document.forms[0].frmdate_ui.value;
		var todate_ui  = document.forms[0].todate_ui.value;
		var inputNameValues		= "acctNum|"+foracid +"|frmdate_ui|"+frmdate_ui +"|todate_ui|"+todate_ui
		var outputNames = "";
		var scrName     = "opsmmn002.scr";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		var msg = ret[0];	
		if(msg == "RESULT_MSG"){
		alert(ret[1]);	
		return false;
		}
	}
	opsm_det_ONCLICK2(document.forms[0].Clear);
}

function opsm_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('opsm_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('opsm_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnshowAccountIdList(obj){
	showAccountIdList(obj,null,null,'F');
}
