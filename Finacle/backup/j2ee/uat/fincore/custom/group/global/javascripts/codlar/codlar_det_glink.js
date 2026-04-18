function printBlock(){
	writeCustomHeader("codlar_det");
	with (document){
	write('<input type="hidden" id="reshDate" fdt="fdate" mneb1="N" vFldId="reshDate_ui" name="' + subGroupName + '.reshDate">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
        write('<tr>');
        write('<td class="page-heading">'+menuTitle+'</td>');
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
	write('<a href="javascript:showHelpFile(\'codlar_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');


        write('<tr>');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT026332") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<select name="' + subGroupName + '.funcCode" id="funcCode"  fmnd="' + codlarProps.get("funcCode_MANDATORY") + '" ' + codlarProps.get("funcCode_ENABLED") + ' class="listboxfont"   >');
        write('<OPTION VALUE="R">' + jspResArr.get("FLT026342") + '</OPTION>');
        write('<OPTION VALUE="G">' + jspResArr.get("FLT026341") + '</OPTION>');
        write('<OPTION VALUE="D">' + jspResArr.get("FLT026343") + '</OPTION>');
        write('<OPTION VALUE="N">' + jspResArr.get("FLT026344") + '</OPTION>');
        write('</select>');
        write('</td>');
        write('<td class="columnwidth"> </td>');
        write('</tr>');

	write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT026333") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.accNum" id="accNum"  fmnd="' + codlarProps.get("accNum_MANDATORY") + '" ' + codlarProps.get("accNum_ENABLED") + ' size="16" maxlength="16" onchange="javascript:return codlar_ONCHANGE5(this,this,\'acctName\',\'acctSolId\',\'acctCrncy\',true,\'VALCUSTACCTID\');" onclick="javascript:return codlar_ONCHANGE1(this,this,\'acctName\',\'acctSolId\',\'acctCrncy\',true,\'VALCUSTACCTID\');">&nbsp;');
        write('<a href="javascript:fnShowAccNum()" id="sLnk2">');
        write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16" />');
        write('</a>');
        write('<input type="text" name="acctCrncy" id="acctCrncy" size="3" maxlength="3"  class="label" readonly="readonly" disabled>');
        write('<input type="text" name="acctSolId" id="acctSolId" size="8" maxlength="8"  class="label" readonly="readonly" disabled>');
        write('<input type="text" name="acctName" id="acctName"  size="25" maxlength="25" class="label" readonly="readonly" disabled>');
        write('<br>');
        write('</td>');

	write('</tr>');
        write('<tr>');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031859") + '</td>');
        write('<td class="textfield">');
        write('<input  hotKeyId="calender1"  type="text" class="textfieldfont" fdt="uidate"  mnebl="false" onBlur="javascript:return codlar_crit_ONBLUR1(this,this,this);" name="' + subGroupName + '.reshDate_ui" id="reshDate_ui" >');
        write('<a  href="javascript:openDate(document.forms[0].reshDate_ui,BODDate)"   id="sLnk2"><img alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
        write('</a>');
        write('</td>');
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
	//if(funcCode =='C'){
	write('<div class="ctable">');
	write('<input name="Submit" type="button" class="button" onClick="javascript:return codlar_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return codlar_det_ONCLICK2(this);" id="Clear" value="Clear">');
	//}else{
	//write('&nbsp;<input class="button" type="button" id="Back" value="OK" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	//}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function
function fnOnLoad(){
        var ObjForm = document.forms[0];
        pre_ONLOAD('codlar_det',this);
        var funcName = "this."+"locfnOnLoad";
        if(eval(funcName) != undefined){
                eval(funcName).call(this);
        }
        fnPopulateControlValues();
        fnPopUpExceptionWindow(ObjForm.actionCode);
        if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
                checkCustErrExecNextStep(Message);
        }
        post_ONLOAD('codlar_crit',this);
}
function fnCheckMandatoryFields(){
        var ObjForm = document.forms[0];
        if (fnIsNull(ObjForm.funcCode.value)){
                alert("Select the Option");
                ObjForm.funcCode.focus();
                return false;
        }
        if (fnIsNull(ObjForm.accNum.value)){
                alert("Enter Account Number");
                ObjForm.accNum.focus();
                return false;
        }
	if(document.forms[0].funcCode.value=="R"){
		if(document.forms[0].accNum.value != "") {
			if (fnIsNull(ObjForm.reshDate.value)){
				alert("Enter Rescheduling Date ");
				ObjForm.reshDate.focus();
				return false;
			}
		}
	}
        return true;
}
function fnPopulateControlValues(){
	var ObjForm = document.forms[0];
	ObjForm.accNum.value = accNum;
	ObjForm.funcCode.value = funcCode;
	ObjForm.reshDate.value = reshDate;
}
function fnValidateData(){
	var ObjForm = document.forms[0];
	return true;
}
function codlar_det_ONCLICK1(obj,p1){
	var retVal = "";
	if (pre_ONCLICK('codlar_det',obj) == false) { 
		return false;
	}
	fnCheckMandatoryFields();
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('codlar_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function codlar_det_ONCLICK2(obj){
        var retVal = "";
	document.forms[0].accNum.value = null;
	document.forms[0].funcCode.value = null;
	document.forms[0].reshDate.value = null;
        if (preEventCall('codlar_det',obj,'ONCLICK') == false) {
                return false;
        }
        if ((retVal =  fnClearFields()) == false) {
                return false;
        }
        if (postEventCall('codlar_det',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
function fnshowAccountIdList(obj){
    showAccountIdList(obj,null,null,'F');
}

function codlar_ONCHANGE1(obj,p1,p2,p3,p4,p5,p6){
       if ((retVal = fetchAcctDtls(p1,p2,p3,p4,p5,p6)) == false){
                return false;
        }
}
function codlar_ONCHANGE5(obj,p1,p2,p3,p4,p5,p6){
       if ((retVal = fetchAcctDtls(p1,p2,p3,p4,p5,p6)) == false){
                return false;
        }
}
function fetchAcctDtls(acctObj, acctName, acctSol, acctCrncy, isError, fType){
        if((retVal=fnCommonFetchAcctDtls(acctObj,acctName,acctSol,acctCrncy,isError,"VALCUSTACCTID"))==false)
        {
                return false;
        }
}
function fnShowAccNum(){
        var objForm = document.forms[0];
        showAccountIdList(objForm.accNum,objForm.acctSolId,objForm.acctName,'F',objForm.acctCrncy,'','','');
}
function codlar_det_ONCLICK28(obj){
        var retVal = "";
        if (preEventCall('codlar_det',obj,'ONCLICK') == false) {
                return false;
        }
        if (preEventCallForLocale('codlar_det',obj,'ONCLICK') == false) {
                return false;
        }
        if (postEventCallForLocale('codlar_det',obj,'ONCLICK') == false) {
                return false;
        }
        if (postEventCall('codlar_det',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
function codlar_det_ONCLICK29(obj){
        var retVal = "";
        if (preEventCall('codlar_det',obj,'ONCLICK') == false) {
                return false;
        }
        if (preEventCallForLocale('codlar_det',obj,'ONCLICK') == false) {
                return false;
        }
        if (postEventCallForLocale('codlar_det',obj,'ONCLICK') == false) {
                return false;
        }
        if (postEventCall('codlar_det',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
function codlar_det_ONBLUR1(obj,p1,p2){
        var retVal = "";
        if (preEventCall('codlar_det',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = onBlurFormatDate(p1)) == false) {
                return false;
        }
        if ((retVal = fnAssignDateOnEnter(p2)) == false) {
                return false;
        }
        if (postEventCall('codlar_det',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

