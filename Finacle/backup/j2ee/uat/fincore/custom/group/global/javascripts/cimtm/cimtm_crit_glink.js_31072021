function printBlock()
{
	writeCustomHeader("cimtm_crit");
	with (document){
	write('<input type="hidden" id="pymntRefDate" fdt="fdate" mneb1="N" vFldId="pymntRefDate_ui" name="' + subGroupName + '.pymntRefDate">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">'+menuTitle+'</td>');
	write('</tr>');
	write('</table>');
	write('<!-- DETAILSBLOCK-BEGIN -->');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');
	write('<tr>');
	write('<td height="25" colspan="5" align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right">');
	write('<a href="javascript:showHelpFile(\'crit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="17" height="17" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode" style="width: 218px" onchange="javascript:return funcCodeOnchange();" fdt="String" ' + cimtmProps.get("funcCode_ENABLED") + '>');
	write('<option value="">' + jspResArr.get("FLT031311") + '</option>');
	//write('<option value="AP">' + jspResArr.get("FLT012900") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT012350") + '</option>');
	write('<option value="P">' + jspResArr.get("FLT013170") + '</option>');
	write('<option value="X">' + jspResArr.get("FLT033219") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT034011") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');
//rec1
	write('<tr id ="refnu">');
        //write('<td class="textlabel">' + jspResArr.get("FLT031874") + ' </td>');
        //write('<td class="textlabel">' + jspResArr.get("FLT031874") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textlabel">' + jspResArr.get("FLT031874") + '</td>');
        write('<td class="textfield">');
        write('<input  class="textfieldfont" type="text" name="' + subGroupName + '.PymntRefNum" id="PymntRefNum" ' + cimtmProps.get("PymntRefNum_ENABLED") + ' maxlength="16" size="25">');
        write('&nbsp;<a href="javascript:showPaymntRefNum();" id="sLnk7" >');
        write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
        write('</td>');
        write('</tr>');
///rec2
        write('<tr>');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031859") + '</td>');
        write('<td class="textfield">');
        write('<input  hotKeyId="calender1"  type="text" class="textfieldfont" fdt="uidate"  mnebl="false" onBlur="javascript:return cimtm_crit_ONBLUR1(this,this,this);" name="' + subGroupName + '.pymntRefDate_ui" id="pymntRefDate_ui" >');
        write('<a  href="javascript:openDate(document.forms[0].pymntRefDate_ui,BODDate)"   id="sLnk2"><img alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
        write('</a>');
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
	write('<!-- DETAILSBLOCK-END -->');
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
	write('<input type="button" class="Button" id="Submit" value="'+jspResArr.get("FLT000193")+ '" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button" onClick="javascript:return cimtm_crit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return cimtm_crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad(){
	var ObjForm = document.forms[0];
	document.forms[0].funcCode.focus();
	if((document.forms[0].funcCode.value == "R") || (document.forms[0].funcCode.value == "")){
		hideImage("sLnk5");
		showImage("sLnk4");
		hideImage("sLnk6");
		showImage("sLnk2");
	}else{
		hideImage("sLnk4");
		showImage("sLnk5");
		hideImage("sLnk2");
		showImage("sLnk6");
	}

	initFocusHandler();
	document.forms[0].pymntRefDate.value = BODDate;

	pre_ONLOAD('cimtm_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	post_ONLOAD('cimtm_crit',this);
}
function fnCheckMandatoryFields(){
	var ObjForm = document.forms[0];
	return true;
}
function fnPopulateControlValues(){
	var ObjForm = document.forms[0];
	ObjForm.funcCode.value = funcCode;
	ObjForm.PymntRefNum.value = PymntRefNum;
	ObjForm.pymntRefDate.value = pymntRefDate;
}
function cimtm_crit_ONCLICK1(obj,p1){
	//alert(document.forms[0].pymntRefDate.value);
	//alert(document.forms[0].pymntRefDate_ui.value);
	var retVal = "";
	if (preEventCall('cimtm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cimtm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function cimtm_crit_ONCLICK2(obj){
	var retVal = "";
	if (preEventCall('cimtm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('cimtm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function showPaymntRefNum(){
	var ObjForm = document.forms[0];
	var FuncCode = ObjForm.funcCode.value;
    var inputNameValues = "funcCode|"+FuncCode;
    var outputNames  = "PymntRefNum|pymntRefDate";
    var pageTitle    = "Payment Details";
    var literalNames = "Payment Ref Number|Payment Ref Date";
    var scrName      = "ebcimtmPayRefPop.scr";
    var hyperLnkCols = "1";
    var retVal       = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,hyperLnkCols,true);
var ObjForm = document.forms[0];
    ObjForm.pymntRefDate_ui.value = pymntRefDate;
}
function cimtm_crit_ONBLUR1(obj,p1,p2){
        var retVal = "";
        if (preEventCall('cimtm_crit',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = onBlurFormatDate(p1)) == false) {
                return false;
        }
        if ((retVal = fnAssignDateOnEnter(p2)) == false) {
                return false;
        }
        if (postEventCall('cimtm_crit',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

