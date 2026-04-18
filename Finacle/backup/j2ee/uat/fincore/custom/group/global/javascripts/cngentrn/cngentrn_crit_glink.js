function printBlock()
{
	writeCustomHeader("cngentrn_crit");
	with (document){
	write('<input type="hidden" id="effectiveDate" fdt="fdate" mneb1="N" vFldId="effectiveDate_ui" name="' + subGroupName + '.effectiveDate">');
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
	write('<select name="' + subGroupName + '.funcCode" id="funcCode" style="width: 218px" onchange="javascript:return funcCodeOnchange();" fdt="String" ' + cngentrnProps.get("funcCode_ENABLED") + '>');
	write('<option value="">' + jspResArr.get("FLT031311") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT012350") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT013170") + '</option>');
	write('<option value="X">' + jspResArr.get("FLT033219") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT034011") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');
	
	//rec1


	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031874") + '</td>');
	write('<td class="textfield">');
	write('<input explodeId="explode1" type="text" class="textfieldfont" name="' + subGroupName + '.drAccount" onChange="javascript:fnFetchAcctDtls(this,\'acctName\',\'solId\',\'crncyCode\',true,\'VALCUSTACCTID\');" id="drAccount" ' + cngentrnProps.get("drAccount_ENABLED") + '>&nbsp;');
	write('<a href="javascript:fnShwAcctList()" id="sLnk2">');
	write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>&nbsp;');
	//write('<a href="JavaScript:fnExplodeBalanceDetails(document.forms[0].drAccount)" id="customExplodeButton">');
	//write('<img border="0" height="17" explodeId="explode1" src="../Renderer/images/'+applangcode+'/explode.gif" width="16">');
	//write('</a>');
	//write('&nbsp;<a id="drAccountSigImg" href="javascript:showFinacleSignature();">');
        //write('<img src="../Renderer/images/' + applangcode + '/sig_new1.gif" alt="' + jspResArr.get("FLT031808") + '" width="16" height="16" border="0"></a>');
	write('</td>');
	
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031875") + '</td>');
	
	write('<td class="textfield">');
	write('<input explodeId="explode1" type="text" class="textfieldfont" name="' + subGroupName + '.crAccount" onChange="javascript:crfnFetchAcctDtls(this,\'crAcctName\',\'crSolId\',\'crCrncyCode\',true,\'VALCUSTACCTID\');" id="crAccount" ' + cngentrnProps.get("crAccount_ENABLED") + '>&nbsp;');
	write('<a href="javascript:fnShwAcctList()" id="sLnk2">');
	write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>&nbsp;');
	//write('<a href="JavaScript:fnExplodeBalanceDetails(document.forms[0].crAccount)" id="customExplodeButton">');
	//write('<img border="0" height="17" explodeId="explode1" src="../Renderer/images/'+applangcode+'/explode.gif" width="16">');
	//write('</a>');
	//write('&nbsp;<a id="drAccountSigImg" href="javascript:showFinacleSignature();">');
        //write('<img src="../Renderer/images/' + applangcode + '/sig_new1.gif" alt="' + jspResArr.get("FLT031808") + '" width="16" height="16" border="0"></a>');
	write('</td>');
	
	write('</tr>');
	
	write('<tr>');
	write('<td></td>');
	write('<td>');
	write('<input name="' + subGroupName + '.solId" id="solId" ' + cngentrnProps.get("solId_ENABLED") + ' type="text" class="label" size="6"   readonly="readonly" style="width: 36px" />');
	write('<input name="' + subGroupName + '.crncyCode" id="crncyCode" ' + cngentrnProps.get("crncyCode_ENABLED") + ' type="text" class="label"   size="2" maxlength="3" readonly="readonly" style="width: 30px" />');
	write('<input name="' + subGroupName + '.acctName" id="acctName" ' + cngentrnProps.get("acctName_ENABLED") + ' type="text" class="label"   size="50" maxlength="80" readonly="readonly" />');
	write('</td>');
	
	///
	write('<td></td>');
		write('<td></td>');
			//write('<td></td>');
	write('<td>');
	write('<input name="' + subGroupName + '.crSolId" id="crSolId" ' + cngentrnProps.get("crSolId_ENABLED") + ' type="text" class="label" size="6"   readonly="readonly" style="width: 36px" />');
	write('<input name="' + subGroupName + '.crCrncyCode" id="crCrncyCode" ' + cngentrnProps.get("crCrncyCode_ENABLED") + ' type="text" class="label"   size="2" maxlength="3" readonly="readonly" style="width: 30px" />');
	write('<input name="' + subGroupName + '.crAcctName" id="crAcctName" ' + cngentrnProps.get("crAcctName_ENABLED") + ' type="text" class="label"   size="50" maxlength="80" readonly="readonly" />');
	write('</td>');
	
	
	write('</tr>');
	
//rec1
	//write('<tr id ="refnu">');
   //   
   //   write('<td class="textlabel">' + jspResArr.get("FLT031874") + '</td>');
   //   write('<td class="textfield">');
   //   write('<input  class="textfieldfont" type="text" name="' + subGroupName + '.drAccount" id="drAccount" ' + cngentrnProps.get("drAccount_ENABLED") + ' maxlength="16" size="25" >');
   //   write('&nbsp;<a href="javascript:showAcctId();" id="sLnk7" >');
   //   write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	//write('</a>');
   //   write('</td>');
		
 
		
		//write('<td class="textlabel">' + jspResArr.get("FLT031875") + '</td>');
        //write('<td class="textfield">');
        //write('<input  class="textfieldfont" type="text" name="' + subGroupName + '.crAccount" id="crAccount" ' + cngentrnProps.get("crAccount_ENABLED") + ' maxlength="16" size="25">');
        //write('<a id="sLnk6" href="javascript: showCurrcy1(this)">');
        //write('<img border="0" height="17" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	    //write('</a>');
        //write('</td>');
		
		
        //write('</tr>');


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
	write('<input id="Accept" name="Go" type="button" class="button" onClick="javascript:return cngentrn_crit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return cngentrn_crit_ONCLICK2(this);"">');
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
	document.forms[0].effectiveDate.value = BODDate;

	pre_ONLOAD('cngentrn_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	post_ONLOAD('cngentrn_crit',this);
}
function fnCheckMandatoryFields(){
	var ObjForm = document.forms[0];
	return true;
}
function fnPopulateControlValues(){
	var ObjForm = document.forms[0];
	ObjForm.funcCode.value = funcCode;
	ObjForm.drAccount.value = drAccount;
	ObjForm.crAccount.value = crAccount;
	ObjForm.effectiveDate.value = effectiveDate;
	ObjForm.acctName.value = acctName; 
	ObjForm.solId.value = solId;
 	ObjForm.crncyCode.value = crncyCode; 
	
	
	return true;
}
function cngentrn_crit_ONCLICK1(obj,p1){
	//alert(document.forms[0].effectiveDate.value);
	//alert(document.forms[0].effectiveDate_ui.value);
	var retVal = "";
	if (preEventCall('cngentrn_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cngentrn_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function cngentrn_crit_ONCLICK2(obj){
	var retVal = "";
	if (preEventCall('cngentrn_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('cngentrn_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function showAcctId(){
	var ObjForm = document.forms[0];
	var FuncCode = ObjForm.funcCode.value;
    var inputNameValues = "funcCode|"+FuncCode;
    var outputNames  = "drAccount|crAccount|effectiveDate";
    var pageTitle    = "List of Accounts";
    var literalNames = "Debit Account|Credit Account|Effective Date";
	var isPopulationReq = "true";
    var scrName      = "ebcngentrnGetdrAccount.scr";
    var hyperLnkCols = "1";
    var retVal       = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,hyperLnkCols,true);
	var   effectiveDate=ObjForm.effectiveDate.value;
	
}

function showCurrcyCode(){
	var ObjForm = document.forms[0];
	var RoleId = ObjForm.drAccount.value;
    var inputNameValues = "drAccount|"+RoleId;
    var outputNames  = "crAccount";
    var pageTitle    = "Credit Account List for Approver Limit";
    var literalNames = "Credit Account";
	var isPopulationReq = "true";
    var scrName      = "ebcngentrnPopuleteCCY.scr";
    var hyperLnkCols = "1";
    var retVal       = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,hyperLnkCols,true);
	
}


function cngentrn_crit_ONBLUR1(obj,p1,p2){
	
	if(funcCode=="U"){
	alert(BODDate)
	//ObjForm.effectiveDate_ui.value = BODDate;
	}
	alert(BODDate);
	//alert(effectiveDate_ui);
        var retVal = "";
        if (preEventCall('cngentrn_crit',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = onBlurFormatDate(p1)) == false) {
                return false;
        }
        if ((retVal = fnAssignDateOnEnter(p2)) == false) {
                return false;
        }
        if (postEventCall('cngentrn_crit',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function showCurrcy1(obj)
{
        var frm = document.forms[0];
        showCurrency(frm.acctCrncy,'ctrl','F','','N');
        fnDfltRC(obj);
}

function fnshowAccountIdList(obj){
    showAccountIdList(obj,null,null,'F');
//      fnCustValidate();
}
