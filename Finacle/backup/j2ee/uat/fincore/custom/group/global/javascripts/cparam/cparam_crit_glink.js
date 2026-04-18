function printBlock()
{
	writeCustomHeader("cparam_crit");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td>');
	write('<h1 class="page-heading">Custom Parameter Setup Criteria Page</h1>');
	write('</td>');
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
	write('<tr>');
	write('<tr>');
	write('<td height="25" colspan="5" align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right">');
	write('<a href="javascript:showHelpFile(\'crit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT021242") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode" ' + cparamProps.get("funcCode_ENABLED") + ' class="listboxfont" onChange="javascript: fnOnChangeFuncCode();">');
	write('<option value="">' + jspResArr.get("FLT021247") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT021248") + '</option>');
	write('<option value="M">' + jspResArr.get("FLT021249") + '</option>');
	write('<option value="C">' + jspResArr.get("FLT021250") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT021251") + '</option>');
	write('<option value="MV">' + jspResArr.get("FLT021252") + '</option>');
	write('<option value="VV">' + jspResArr.get("FLT021253") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT021254") + '</option>');
	write('<option value="CV">' + jspResArr.get("FLT021255") + '</option>');
	write('<option value="DV">' + jspResArr.get("FLT021256") + '</option>');
	write('<option value="VDV">' + jspResArr.get("FLT021257") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT021244") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
        write('<input name="' + subGroupName + '.moduleName" id="moduleName" ' + cparamProps.get("moduleName_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="30" maxlength="30">&nbsp;');
        write('<a id="moduleNameImg" href="javascript: showModuleList()">');
        write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>');
        write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT021243") + '<script>setMandatory("Y");</script></td>');
	write('<td>');
        write('<select name="' + subGroupName + '.parameterLevel" id="parameterLevel" ' + cparamProps.get("parameterLevel_ENABLED") + ' onChange="javascript:fnOnChangeParameterLevel();" class="listboxfont">');
        write('<option value="">' + jspResArr.get("FLT021247") + '</option>');
        write('<option value="BNKL">' + jspResArr.get("FLT021258") + '</option>');
        //write('<option value="SOLL">' + jspResArr.get("FLT021259") + '</option>');
        //write('<option value="SCHM">' + jspResArr.get("FLT021260") + '</option>');
        //write('<option value="CURL">' + jspResArr.get("FLT021261") + '</option>');
        //write('<option value="SHCR">' + jspResArr.get("FLT021262") + '</option>');
        //write('<option value="GENL">' + jspResArr.get("FLT021263") + '</option>');
        write('</select>');
        write('</td>');	
	write('<td class="textlabel">' + jspResArr.get("FLT021245") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input name="' + subGroupName + '.parameterId" id="parameterId" ' + cparamProps.get("parameterId_ENABLED") + ' hotKeyId="search2" type="text" class="textfieldfont" size="30" maxlength="30" >&nbsp;');
	write('<a id="parameterIdImg" target=_self href="Javascript:showParameterList();">');
	write('<img border="0" height="17" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
	write('</tr>');

	write('<tr id="schemeCodeRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT021264") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.schemeCode" id="schemeCode" ' + cparamProps.get("schemeCode_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="5">&nbsp;');
        write('<a id="schemeCodeImg" href="javascript: fnShowSchemeCodeList()">');
        write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>');
        write('</td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfield">');
        write('</td>');
        write('</tr>');

	write('<tr id="currencyCodeRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT021265") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.currencyCode" id="currencyCode" ' + cparamProps.get("currencyCode_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="3" maxlength="3">&nbsp;');
        write('<a id="currencyCodeImg" href="javascript: fnShowCurrencyCodeList()">');
        write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>');
        write('</td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfield">');
        write('</td>');
        write('</tr>');

	write('<tr id="genericCodeRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT021266") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.genericCode" id="genericCode" ' + cparamProps.get("genericCode_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="10">&nbsp;');
        write('<a id="genericCodeImg" href="javascript: fnShowModuleName()">');
        write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>');
        write('</td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfield">');
        write('</td>');
        write('</tr>');

	write('<tr id="genericIdRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT021267") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.genericId" id="genericId" ' + cparamProps.get("genericId_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="10">&nbsp;');
        write('<a id="genericIdImg" href="javascript: fnShowModuleName()">');
        write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>');
        write('</td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfield">');
        write('</td>');
        write('</tr>');

	write('<tr id="solIdRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT021268") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.solId" id="solId" ' + cparamProps.get("solId_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="8">&nbsp;');
	write('<a id="solIdImg" href="javascript:showSetList(document.forms[0].solId,\'ctrl\',\'F\',\'\');">');
        write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>');
        write('</td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfield">');
        write('</td>');
        write('</tr>');


	write('</tr>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<table>');
	write('<tr><td></td></tr>');
	write('</table>');
	write('<!-- DETAILSBLOCK-END -->');
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
	write('<div align="left" class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button" onClick="javascript:return cparam_crit_ONCLICK1(this,this);"" value="Go" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="Clear" onClick="javascript:return cparam_crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('cparam_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	post_ONLOAD('cparam_crit',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.funcCode.value = funcCode;
	ObjForm.parameterLevel.value = parameterLevel;
	ObjForm.moduleName.value = moduleName;
	ObjForm.parameterId.value = parameterId;
	ObjForm.schemeCode.value = schemeCode;
	ObjForm.currencyCode.value = currencyCode;
	ObjForm.genericCode.value = genericCode;
	ObjForm.genericId.value = genericId;
	ObjForm.solId.value = solId;
	fnCheckControls();
}
function fnCheckControls()
{
        var ObjForm = document.forms[0];

        fnSetCheckboxCtrl(ObjForm);
}


function cparam_crit_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cparam_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cparam_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cparam_crit_ONCLICK2(obj)
{
	var retVal = "";
	if (preEventCall('cparam_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('cparam_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
