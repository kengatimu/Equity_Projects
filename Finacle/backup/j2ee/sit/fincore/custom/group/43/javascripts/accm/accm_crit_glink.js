function printBlock()
{
	writeCustomHeader("accm_crit");
	with (document){
	//-----------Modification for TO 361667-----------//
	write('<input type="hidden" name="nextPage" id="nextPage">');
	//-----------Modification for TO 361667-----------//
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031309") + '</td>');
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
	write('<a href="javascript:showHelpFile(\'accm_crit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif"  border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FAT000703") + '</td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode" ' + accmProps.get("funcCode_ENABLED")  + 'class="listboxfont"  onLoad ="javascript:fnDisableSearcher()" onChange="javascript:fnDisableFields()" ' + ' style="width: 217px" maxlength="16">');
	write('<option value="">' + jspResArr.get("FAT005177") + '</option>');
	write('<option value="A">' + jspResArr.get("FDEMO0005") + '</option>');
	write('<option value="M">' + jspResArr.get("FDEMO0006") + '</option>');
	write('<option value="X">' + jspResArr.get("FLT031311") + '</option>');
	write('<option value="T">' + jspResArr.get("FLT031312") + '</option>');
	write('<option value="V">' + jspResArr.get("FDEMO0002") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT031313") + '</option>');
	write('<option value="E">' + jspResArr.get("FLT031314") + '</option>');
	write('<option value="Z">' + jspResArr.get("FLT031315") + '</option>');
	write('</select>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT031310") + '</td>');
	write('<td class="textfield">');
	write('<input class="textfieldfont" hotKeyId="search1" type="text" name="' + subGroupName + '.acctNum" id="acctNum" ' + accmProps.get("acctNum_ENABLED") + ' maxlength="16" onchange="javascript:return accm_ONCHANGE1(this,this,\'acctName\',\'acctSolId\',\'acctCrncy\',true,\'VALCUSTACCTID\');">');
	write('&nbsp');
	write('<a href="javascript: fnAcctDetFetch()"  id="search1">');
	//write('&nbsp');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('<input type="text" name="acctCrncy" id="acctCrncy" size="3" maxlength="3"  class="label" readonly="readonly" disabled>');
	write('<input type="text" name="acctSolId" id="acctSolId" size="8" maxlength="8"  class="label" readonly="readonly" disabled>');
    write('<input type="text" name="acctName" id="acctName"  size="25" maxlength="25" class="label" readonly="readonly" disabled>');
    write('</td>');
	write('</tr>');
	write('<tr>');
        write('<td class="textlabel"> IBAN Number</td>');
        write('<td class="textfield">');

        write('<input name="' + subGroupName + '.ibanNo" id="ibanNo" ' + accmProps.get("ibanNo_ENABLED") + ' type="text" class="textfieldfont" size="24" maxlength="23" onChange="javascript:fnIbanVal();">&nbsp;');
		write('</td>');
		write('</tr>');	
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT024006") + '</td>');
	write('<td class="textfield">');
	write('<input class="textfieldfont" hotKeyId="search2" type="text" name="' + subGroupName + '.contractId" id="contractId" ' + accmProps.get("contractId_ENABLED") + '  maxlength="16" onBlur="javascript:fnLoadValues();">');
	write('&nbsp');
	write('<a href="javascript: fnFetchContractId()"  id="search2" >');
	write('<img border="0" height="17" hotKeyId="search2"  onLoad ="javascript:fnDisableSearcher()" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');

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
	write('<input type="button" class="Button" id="Submit" value="SUBMIT" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="CANCEL" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return accm_crit_ONCLICK1(this,this);"" value="Go" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="Clear"	onClick="javascript:return accm_crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('accm_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('accm_crit',this);
	ObjForm.funcCode.focus();
}

function fnCheckMandatoryFields()
{

	var ObjForm = document.forms[0];

	if ((ObjForm.funcCode.value == "") && (fnIsNull(ObjForm.acctNum.value)))
	{
		//alert("TADA glink");
		alert("Enter Function Code");
		return false;
	}

	if ((ObjForm.funcCode.value == "A") && (fnIsNull(ObjForm.acctNum.value)))
	{
		alert("Enter Account Number");
		return false;
	}

	if ((ObjForm.funcCode.value != "A") && (ObjForm.funcCode.value != "I") && (fnIsNull(ObjForm.contractId.value)))
	{
		alert("Enter Contract Id");
		return false;
	}
	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.funcCode.value = funcCode;
	ObjForm.acctNum.value = acctNum;
	ObjForm.contractId.value = contractId;
}


function accm_crit_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('accm_crit',obj) == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('accm_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function accm_crit_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('accm_crit',obj) == false) { 
		return false;
	}
	if ((retVal =  fnClearField()) == false) {
		return false;
	}
	if (post_ONCLICK('accm_crit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnIbanVal()
{
document.forms[0].acctNum.value ='';
document.forms[0].acctSolId.value ='';
document.forms[0].acctCrncy.value ='';
document.forms[0].acctName.value ='';
var ibanNo = document.forms[0].ibanNo.value;
 var inputNameValues    = "ibanNo|"+ibanNo;
                         var outputNames        = "errorFlg|errorMsg|acctNum|acctName|solId|crncyCode";
                         var scrName            = "ibanToForacid.scr";
                         var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var result      = retVal.split("|");
        var errorFlg = result[1];
        var errorMsg = result[3];
        var acctNum = result[5];
        var solId = result[9];
        var crncyCode = result[11];
        var acctName = result[7];
         if (errorFlg == "Y") {
                alert(errorMsg);
                document.forms[0].acctNum.value ='';
                        document.forms[0].ibanNo.value = '';
                return false;
            } else {
                    document.forms[0].acctNum.value =acctNum;
                        document.forms[0].acctSolId.value = solId;
        document.forms[0].acctCrncy.value=crncyCode;
                document.forms[0].acctName.value = acctName;
                
        setFieldFocus(document.forms[0].acctNum);
                }
return true;
}

function accm_ONCHANGE1(obj,p1,p2,p3,p4,p5,p6)
{


if ((retVal = fetchAcctDtls(p1,p2,p3,p4,p5,p6)) == false) {
                return false;
        }

}
