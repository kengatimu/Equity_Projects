function printBlock()
{
	writeCustomHeader("allset_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">ALL SET MENU </td>');
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
	write('<a href="javascript:showHelpFile(\'allset_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") + '<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.funcCode" id="funcCode" ' + allsetProps.get("funcCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('<tr>');
        write('<td class="textlabel"> IBAN Number</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.ibanNo" id="ibanNo" ' + allsetProps.get("ibanNo_ENABLED") + ' type="text" class="textfieldfont" size="24" maxlength="23" onChange="javascript:fnIbanVal();">&nbsp;');
		write('</td>');
		write('</tr>');	
	//write('<td>&nbsp;</td>');
	//write('<td>&nbsp;</td>');
	//write('<td>&nbsp;</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026333") +'<font color=red size=2>*</font></td>');
	write('<td><input name="' + subGroupName + '.userId" id="userId" ' + allsetProps.get("userId_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
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
	if ((sReferralMode == 'I')||(sReferralMode == 'S')){
	write('<div align="left" class="ctable">');
	if (sReferralMode == 'S'){
	write('<input type="button" class="Button" id="Submit" value="SUBMIT" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="CANCEL" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input name="Submit" type="button" class="button" onClick="javascript:return allset_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return allset_det_ONCLICK2(this);" id="Clear" value="Clear">');
	}else{
	write('&nbsp;<input class="button" type="button" id="Back" value="OK" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('allset_det',this);

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


	//post_ONLOAD('allset_det',this);
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
	ObjForm.userId.value = userId;
}

function allset_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	var frm = document.forms[0];
	if(fnIsNull(document.forms[0].funcCode.value)) {
		alert("Enter the Account Number");
		document.forms[0].funcCode.focus();
		return false;
	}

	if(fnIsNull(document.forms[0].userId.value)) {
		alert("Enter the Amount");
		document.forms[0].userId.focus();
		return false;
	}

	if (document.forms[0].userId.value>9999999999)
		{
			alert("Enter Valid Amount");
			document.forms[0].userId.focus();
			return false;
		}

	frm.actionCode.value = "Submit";
	enableFormElements();
	hideAnchors();
	disableButtons();
	frm.submit();

	
}


function fnIbanVal()
{
document.forms[0].funcCode.value ='';

var ibanNo = document.forms[0].ibanNo.value;
 var inputNameValues    = "ibanNo|"+ibanNo;
                         var outputNames        = "errorFlg|errorMsg|acctNum";
                         var scrName            = "ibanToForacidp002.scr";
                         var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var result      = retVal.split("|");
        var errorFlg = result[1];
        var errorMsg = result[3];
        var acctNum = result[5];
		
        
         if (errorFlg == "Y") {
                alert(errorMsg);
                document.forms[0].funcCode.value ='';
                        document.forms[0].ibanNo.value = '';
                return false;
            } else {
                    document.forms[0].funcCode.value =acctNum;
					

        setFieldFocus(document.forms[0].funcCode);
                }
return true;
}


function allset_det_ONCLICK2(obj)
{
	var retVal = "";
	/*
	if (pre_ONCLICK('allset_det',obj) == false) {
		return false;
	}
	*/
	
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	/*
	if (post_ONCLICK('allset_det',obj) == false) {
		return false;
	}
	*/
	return (retVal == undefined) ? true : retVal;
}
