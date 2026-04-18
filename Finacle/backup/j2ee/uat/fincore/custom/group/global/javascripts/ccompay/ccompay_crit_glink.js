function printBlock()
{
	writeCustomHeader("ccompay_crit");
	with (document){
	write('<input type="hidden" id="tranDate" fdt="fdate" mneb1="N" vFldId="tranDate_ui" name="' + subGroupName + '.tranDate">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT033494") + '</td>');
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
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT033107") + ' <script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode"  fdt="String" ' + ccompayProps.get("funcCode_ENABLED") + ' style="width: 151px;" onChange="javascript: fnOnChangeFuncCode();">');
	write('<option value="">' + jspResArr.get("FLT033456") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT014584") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT034011") + '</option>');
	write('<option value="R">' + jspResArr.get("FLT034012") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT033495") + ' <script>setMandatory("Y");</script> </td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.pmntType" id="pmntType"  fdt="String" ' + ccompayProps.get("pmntType_ENABLED") + '  onChange="javascript: fnOnChangePmntType();"  style="width: 160px;">');
	write('<option value="">' + jspResArr.get("FLT033456") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT033497") + '</option>');
	write('<option value="C">' + jspResArr.get("FLT033517") + '</option>');
	write('</select>');
	write('</td>');
	write('</tr>');
	//
	write('<tr id="tranIdRow">');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT033518") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input maxlength="9" type="text" class="textfieldfont" name="' + subGroupName + '.tranId" id="tranId" style="width: 151px;" ' + ccompayProps.get("tranId_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');

	write('<tr id="tranDateRow">');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT033519") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input  maxlength="10" hotKeyId="calender1"  type="text" class="textfieldfont" fdt="uidate"  mnebl="false" onBlur="javascript:return ccompay_crit_ONBLUR1(this,this,this);" name="' + subGroupName + '.tranDate_ui" id="tranDate_ui" style="width: 151px;" >');
	write('&nbsp;<a  href="javascript:openDate(document.forms[0].tranDate_ui,BODDate)"   id="sLnk2"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
	write('</a>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');
	//
	write('<tr>');
	write('<td class="textlabel" style="height: 15px"> </td>');
	write('<td class="textfield"> </td>');
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
	write('<input type="button" class="Button" id="Submit" value="'+jspResArr.get("FLT000193")+ '" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return ccompay_crit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return ccompay_crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	initFocusHandler();

	pre_ONLOAD('ccompay_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('ccompay_crit',this);
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
	ObjForm.pmntType.value = pmntType;
}


function ccompay_crit_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('ccompay_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('ccompay_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ccompay_crit_ONCLICK2(obj)
{
	var retVal = "";
	if (preEventCall('ccompay_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('ccompay_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ccompay_crit_ONBLUR1(obj,p1,p2)
{
        var retVal = "";
        if (preEventCall('ccompay_crit',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = onBlurFormatDate(p1)) == false) {
                return false;
        }
        if ((retVal = fnAssignDateOnEnter(p2)) == false) {
                return false;
        }
        if (postEventCall('ccompay_crit',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}