function printBlock()
{
	writeCustomHeader("cobcust_det");
	with (document){
	write('<input type="hidden" name="cobcust.myIPAddress" id="myIPAddress">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td><table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">OVERIDE CUST ID DATA SCREEN</td>');
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
	write('<a href="javascript:showHelpFile(\'cobcust_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0"></a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000004") + '<font color="red" size="2"> *</font></td>');
	write('<td><select name="' + subGroupName + '.funcCode" id="funcCode" ' + cobcustProps.get("funcCode_ENABLED") + ' class="textfieldfont" " onchange="javascript:fnDisableFields(this)">');
	
	write('<option value="S">' + jspResArr.get("FLT000005")+ '</option>');
	write('<option value="A">' + jspResArr.get("FLT000006") + '</option>');
	write('<option value="D">' + jspResArr.get("FLT000007") + '</option>');
	write('</select>');
	write('</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('<td>&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000003") + '<font color="red" size="2"> *</font><script>setMandatory("N");</script></td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" name="' + subGroupName + '.custId" id="custId" ' + cobcustProps.get("custId_ENABLED") + ' size="20" maxlength="20"  class="textfieldfont" >');
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
    if(funcCode !='I'){
    write('<div class="ctable">');
    write('<input name="Submit" type="button" class="button" onClick="javascript:return cobcust_det_ONCLICK2(this,this);" id="Submit" value="Submit" hotKeyId="Submit">'
);
    write('<input name="Clear" type="button" class="button" onClick="javascript:return cobcust_det_ONCLICK3(this);" id="Clear" value="Clear">');
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
	
	pre_ONLOAD('cobcust_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	post_ONLOAD('cobcust_det',this);
}

function fnPopulateControlValues() 
{
	/*var ObjForm = document.forms[0];
	ObjForm.custId.value = custId;
	ObjForm.funcCode.value = funcCode;
	ObjForm.currency.value = currency;*/
}


function cobcust_det_ONCHANGE1(obj,p1)
{
	var retVal = "";
	if (pre_ONCHANGE('cobcust_det',obj) == false) { 
		return false;
	}
	if ((retVal = validateUser(p1)) == false) {
		return false;
	}
	if (post_ONCHANGE('cobcust_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cobcust_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('cobcust_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('cobcust_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cobcust_det_ONCLICK3(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cobcust_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cobcust_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnDisableFields(obj) {
	fncode = document.forms[0].funcCode.value;
	if(fncode == 'D' || fncode == 'V' ){
		//document.forms[0].currency.disabled=true;
		//document.forms[0].custId.disabled=true;
		//alert("testi");
	}
	return true;
}
function fnValidateData() {
	return true;
}
