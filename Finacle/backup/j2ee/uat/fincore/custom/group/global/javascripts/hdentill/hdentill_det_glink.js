function printBlock()
{
	writeCustomHeader("hdentill_det");
	with (document){ write('<span class="cform">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Denomination TILL / VAULT Report</td>');
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
	write('<a href="javascript:showHelpFile(\'hdentill_crit_help.htm\');">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0"></a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspRes.FLS1000009 + '<script>setMandatory("Y");</script></td>');
	write('<td><SELECT name="' + subGroupName + '.report" id="report" ' + hdentillProps.get("report_ENABLED") + 'class="listboxfont" onchange="javascript:return hdentill_det_ONCHANGE1(this);">');
	write('<OPTION value="">---Select---</OPTION>');
	write('<OPTION value="T">Till Position</OPTION>');
	write('<OPTION value="V">Vault Position</OPTION>');
	write('</SELECT>');
	write('</td>');
	write('<td>');
	write('</td>');
	write('<tr>');
	write('</tr>');
	write('<td class="textlabel">' + jspRes.FLT014433 + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield"><input name="' + subGroupName + '.telId" id="telId" ' + hdentillProps.get("telId_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="25" fdt="fpzint" maxlength="16">&nbsp;');
	write('<a href="javascript:showTellerIdList(document.forms[0].telId);" id="sLnk1">');
	write('<img hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16" height="17" border="0"></a>&nbsp;');
	write('</td>');
	write('<td class="textlabel">' + jspRes.FLT1024473 + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield"><input name="' + subGroupName + '.solId" id="solId" ' + hdentillProps.get("solId_ENABLED") + ' hotKeyId="search2" type="text" class="textfieldfont" size="25" fdt="fpzint" maxlength="16">&nbsp;');
	write('<a href="javascript:showSetList(document.forms[0].solId,\'ctrl\',\'F\',\'\');">');
	write('<img id="sLnk2" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16" height="17" border="0"></a>&nbsp;');
	write('</td>');
	write('</tr>');


	write('<tr>');
    write('<td class="textlabel">' + jspRes.FLT015533 + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield"><input name="' + subGroupName + '.CRNCY_CODE" id="CRNCY_CODE" ' + hdentillProps.get("CRNCY_CODE_ENABLED") + ' hotKeyId="search3" type="text" class="textfieldfont" size="25" fdt="fpzint" maxlength="16">&nbsp;');
    write('<a href="javascript:showCRNCY_CODE();" id="sLnk3">');

//	write('<a id="sLnk3" href="javascript:showccy(document.forms[0].ccy,\'ctrl\',\'F\',\'\');">');
//	write('<a id="sLnk3" href="javascript:showccy();">');	
	write('<img id="sLnk3" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16" height="17" border="0"></a>&nbsp;');
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
	write('</span>');
	} //End with()
} //End function

function printFooterBlock()
{
	with (document)
	{
	if ((sReferralMode == 'I')||(sReferralMode == 'S'))
	{
	write('<div align="left" class="ctable">');
	if (sReferralMode == 'S')
	{
	write('<span class="cform">');
	write('<input type="button" class="Button" id="Submit" value="SUBMIT" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="CANCEL" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input name="Submit" type="button" class="button" onClick="javascript:return hdentill_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return hdentill_det_ONCLICK2(this);" id="Clear" value="Clear">');
	}else{
	write('&nbsp;<input class="button" type="button" id="Back" value="OK" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	write('</span>');
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('hdentill_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){ eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){ fnDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('hdentill_det',this);
	ObjForm.report.focus();
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	if (fnIsNull(ObjForm.telId.value))
	{
		alert(jspErr.CTRF100003);
		//ObjForm.telId.focus();
		return false;
	}
	if (fnIsNull(ObjForm.solId.value))
	{
		alert(jspErr.CTRF100003);
		//ObjForm.solId.focus();
		return false;
	}
	if (fnIsNull(ObjForm.CRNCY_CODE.value))
	{
	    alert(jspErr.CTRF100003);
 	    ObjForm.CRNCY_CODE.focus();    
	    return false;
    }

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.telId.value = telId;
	ObjForm.solId.value = solId;
	ObjForm.report.value = report;
	ObjForm.CRNCY_CODE.value = CRNCY_CODE; 
}


function hdentill_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('hdentill_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('hdentill_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hdentill_det_ONCLICK2(obj)
{
	var retVal = "";
	if (preEventCall('hdentill_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('hdentill_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hdentill_det_ONCHANGE1(obj)
{
        var retVal = "";
        if (preEventCall('hdentill_det',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = fnDisbFields(obj)) == false) {
                return false;
        }
        if (postEventCall('hdentill_det',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
function showCRNCY_CODE()
{
    var ObjForm = document.forms[0];
	convertToCaps();
	var inputNameValues = ""; 
	var outputNames = "CRNCY_CODE|CRNCY_NAME"; 
	var literalNames = "CRNCY_CODE|CRNCY_NAME";
	var pageTitle = "Currency List";
	var retVal = fnExecuteScriptForList(inputNameValues,outputNames,"dentillmn003.scr",pageTitle,literalNames,'1',true);
 return;
}
 
