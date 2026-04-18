function printBlock()
{
	//writeCustomHeader("cparam_det");
	writeCustomHeader("Customizedet");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Custom Parameter Setup Detail Page</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" colspan="5" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000700") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label align="left"id="compFieldFunc">' + fnGetFunctionCodeDesc(funcCode) + '</label>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel"></td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compFieldParameterLevel"></label>');
	write('</td>');
	write('</tr>');

	write('<tr id="parameterLevelRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000701") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compFieldParameterLevel">'+parameterLevel+'</label>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compFieldSolId"></label>');
        write('</td>');
        write('</tr>');

	write('<tr id="moduleNameRow">');
	write('<td class="textlabel">' + jspResArr.get("FLT000702") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compFieldModuleName">'+moduleName+'</label>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel"></td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compFieldSolId"></label>');
	write('</td>');
	write('</tr>');

	write('<tr id="solIdRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000703") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compFieldSolId">'+solId+'</label>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compFieldSolId"></label>');
        write('</td>');
        write('</tr>');

	write('<tr id="schemeCodeRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000704") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldSchemeCode">'+schemeCode+'</label>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compFieldCurrencyCode"></label>');
        write('</td>');
        write('</tr>');

	write('<tr id="currencyCodeRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000705") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compFieldCurrencyCode">'+currencyCode+'</label>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compFieldSolId"></label>');
        write('</td>');
        write('</tr>');

	write('<tr id="genericCodeRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000706") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldGenericCode">'+genericCode+'</label>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compFieldGenericId"></label>');
        write('</td>');
        write('</tr>');

	write('<tr id="genericIdRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000707") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compFieldGenericId">'+genericId+'</label>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compFieldSolId"></label>');
        write('</td>');
        write('</tr>');

	write('</table>');
	write('<br />');
	write('<!-- DETAILSBLOCK-BEGIN -->');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
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
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');

	write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000708") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.parameterId" id="parameterId" ' + cparamProps.get("parameterId_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="15">&nbsp;');
        write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000710") + '</td>');
        write('<td class="textfield">');
        write('<select name="' + subGroupName + '.parameterType" id="parameterType" ' + cparamProps.get("parameterType_ENABLED") + ' class="listboxfont" >');
        write('<option value="">' + jspResArr.get("FLT000719") + '</option>');
        write('<option value="NI">' + jspResArr.get("FLT000720") + '</option>');
        write('<option value="NF">' + jspResArr.get("FLT000721") + '</option>');
        write('<option value="CH">' + jspResArr.get("FLT000722") + '</option>');
        write('<option value="AN">' + jspResArr.get("FLT000723") + '</option>');
        write('<option value="AC">' + jspResArr.get("FLT000724") + '</option>');
        write('<option value="PL">' + jspResArr.get("FLT000725") + '</option>');
        write('<option value="GL">' + jspResArr.get("FLT000726") + '</option>');
        write('<option value="CF">' + jspResArr.get("FLT000727") + '</option>');
        write('<option value="SC">' + jspResArr.get("FLT000728") + '</option>');
        write('</select>');
        write('</td>');
        write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000709") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.parameterDesc" id="parameterDesc" ' + cparamProps.get("parameterDesc_ENABLED") + ' hotKeyId="search2" type="text" class="textfieldfont" size="500" maxlength="500" style="width:370px" >&nbsp;');
        write('</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000712") + '</td>');
        write('<td>');
        write('<select name="' + subGroupName + '.listType" id="listType" ' + cparamProps.get("listType_ENABLED") + ' onChange="javascript: fnOnChangeListType();" class="listboxfont">');
        write('<option value="">' + jspResArr.get("FLT000719") + '</option>');
        write('<option value="FT">' + jspResArr.get("FLT000716") + '</option>');
        //write('<option value="LS">' + jspResArr.get("FLT000717") + '</option>');
        //write('<option value="LD">' + jspResArr.get("FLT000718") + '</option>');
        write('</select>');
        write('</td>');
        write('</tr>');

	write('<tr id="queryDetailsRow1">');
        write('<td class="textlabel">' + jspResArr.get("FLT000713") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.queryName" id="queryName" ' + cparamProps.get("queryName_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="10">&nbsp;');
        write('<a id="queryNameImg" href="javascript: fnShowModuleName()">');
        write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>');
        write('</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000714") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.queryId" id="queryId" ' + cparamProps.get("queryId_ENABLED") + ' hotKeyId="search2" type="text" class="textfieldfont" size="24" maxlength="10" >&nbsp;');
        write('<a id="queryIdImg" target=_self href="Javascript:fnShowSchemeCodeList()">');
        write('<img border="0" height="17" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>');
        write('</td>');
        write('</tr>');
	write('<tr id="queryDetailsRow2">');
        write('<td class="textlabel">' + jspResArr.get("FLT000715") + '</td>');
        write('<td class="textfield">');
        write('<textarea maxlength="50" class="textfieldfont" name="' + subGroupName + '.queryDetails" id="queryDetails" ' + cparamProps.get("queryDetails_ENABLED") + ' hotKeyId="search1" rows="4" size="24" ></textarea>');
        write('</td>');
	write('<td class="textlabel"></td>');
        write('<td class="textfield">');
        write('</td>');
        write('</tr>');
	write('<tr id="parameterValueRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000711") + '</td>');
        write('<td class="textfield">');
	write('<input name="' + subGroupName + '.parameterValue" id="parameterValue" ' + cparamProps.get("parameterValue_ENABLED") + ' hotKeyId="search2" type="text" class="textfieldfont" size="500" maxlength="500" style="width:370px" >&nbsp;');
        write('</td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfield">');
        write('</td>');
        write('</tr>');


	write('<tr>');
	write('<td class="textlabel" style="height: 24px; width: 204px"> </td>');
	write('<td class="textfield"> </td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel"></td>');
	write('<td> </td>');
	write('</tr>');
	write('<tr>');
	write('<td></td>');
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
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button" value="Submit"	onClick="javascript:return cparam_det_ONCLICK4(this,this);"" hotKeyId="Submit">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="Cancel"	onClick="javascript:return cparam_det_ONCLICK5(this,this.id);"" hotKeyId="Cancel">');
	}else{
	write('&nbsp;<input class="button" type="button" id="Back" value="OK" onClick="javascript:return doSubmit(this.id)" hotKeyId="Go">');
	}
	if((funcCode == 'A') || (funcCode == 'M')){

	  showImage("sLnk6");
  	}
  	else
  	{
        hideImage("sLnk6");
  	}

	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('cparam_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnCustDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cparam_det',this);

}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.parameterId.value = parameterId;
	ObjForm.parameterDesc.value = parameterDesc;
	ObjForm.parameterType.value = parameterType;
	ObjForm.listType.value = listType;
	ObjForm.queryName.value = queryName;
	ObjForm.queryId.value = queryId;
	ObjForm.parameterValue.value = parameterValue;
	fnCheckControls();

}

function fnCheckControls()
{
	var ObjForm = document.forms[0];

}


function cparam_det_ONBLUR1(obj)
{
	var retVal = "";
	if (preEventCall('cparam_det',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = fnFormatAmountField(obj)) == false) {
		return false;
	}
	if (postEventCall('cparam_det',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cparam_det_ONBLUR2(obj)
{
	var retVal = "";
	if (preEventCall('cparam_det',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = fnCheckInteger()) == false) {
		return false;
	}
	if (postEventCall('cparam_det',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cparam_det_ONBLUR4(obj)
{
        var retVal = "";
        if (preEventCall('cparam_det',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnFormatAmountField()) == false) {
                return false;
        }
        if (postEventCall('cparam_det',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cparam_det_ONCLICK4(obj,p1)
{
	var retVal = "";
	if (preEventCall('cparam_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cparam_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cparam_det_ONCLICK5(obj,p1)
{
	var retVal = "";
	if (preEventCall('cparam_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCall('cparam_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
