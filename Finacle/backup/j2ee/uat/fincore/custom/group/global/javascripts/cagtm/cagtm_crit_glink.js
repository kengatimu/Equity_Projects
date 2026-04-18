function printBlock()
{
	writeCustomHeader("cagtm_crit");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<input type="hidden" id="solid"  mneb1="N" vFldId="solid" name="' + subGroupName + '.solid">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT648026") + '</td>');
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
	write('<a href="javascript:showHelpFile(\'cagtm_crit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT006657") + ' <script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode"  class="listboxfont" fdt="String" ' + cagtmProps.get("funcCode_ENABLED") + '  >');
	write('<option value="">' + jspResArr.get("FLT648027") + '</option>');
	write('<option value="D">' + jspResArr.get("FLT648030") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT648031") + '</option>');
	write('<option value="M">' + jspResArr.get("FLT648032") + '</option>');
	write('<option value="U">' + jspResArr.get("FLT648033") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT648036") + '</option>');


	write('</select>');
	write('<br>');
	write('<br>');
	write('</td>');

	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT648034") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.agentcode" id="agentcode"  fdt="String" maxLength=10 ' +  cagtmProps.get("agentcode_ENABLED") + ' style="width: 218px;">');
        write('&nbsp');
        write('&nbsp');
	write('<a href="javascript:showAgentList(document.forms[0].agentcode,document.forms[0].solid,\'N\',\'F\',\'\')">');
        write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="14">');
        write('</a>');
        write('</td>');
	write('</tr>');

	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT648035") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.crncyCode" id="crncyCode"  fdt="String" maxLength=3 ' + cagtmProps.get("crncyCode_ENABLED") + ' style="width: 218px;">'); 
        write('&nbsp');
        write('&nbsp');
        write('<a href="javascript:showCurrency(document.forms[0].crncyCode,\'ctrl\',\'F\')">');
        write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="14">');
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
	write('<input type="button" class="Button" id="Submit" value="'+jspResArr.get("FLT000193")+ '" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return cagtm_crit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return cagtm_crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
        var ObjForm = document.forms[0];

        initFocusHandler();

        pre_ONLOAD('cagtmcrit',this);

        var funcName = "this."+"locfnOnLoad";
        if(eval(funcName) != undefined){
                eval(funcName).call(this);
        }

        fnPopulateControlValues();

        fnPopUpExceptionWindow(ObjForm.actionCode);
        if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
                checkCustErrExecNextStep(Message);
        }
        ObjForm.funcCode.focus();
        post_ONLOAD('cagtmcrit',this);
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
	ObjForm.solid.value = headCtxSol;
	ObjForm.agentcode.value = agentcode;
	ObjForm.crncyCode.value = crncyCode;
}


function cagtm_crit_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cagtm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cagtm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cagtm_crit_ONCLICK2(obj)
{
	var retVal = "";
	if (preEventCall('cagtm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('cagtm_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
