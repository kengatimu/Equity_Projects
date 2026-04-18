// Generated from spec file 


function printBlock1()
{
	writeHeader("oifa_accept");
	with (document) {
	write('<table class="ctable" width="100%" border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jsUtil.encodeChar(titleDisp) + ' &nbsp;</td>');
	write('</tr>');
	write('</table>');
	write('<input type="hidden" name="submitform">');
	write('<input type="hidden" name="pagename" value="oifa">');
	write('<input type="hidden" id="svsTranId" name="' + sGroupName + '.svsTranId">');
	write('<input type="hidden" id="SVS_Verify_Status" name="' + sGroupName + '.SVS_Verify_Status">');
	write('<input type="hidden" id="hParentId" name="' + sGroupName + '.hParentId">');

	} 
} //End function

function printBlock2()
{
	with (document) {
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td valign="top">');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop1">');
	write('<tr>');
	write('<td colspan="5" class="rowspacing1"><spacer type="block" height=1 width=1></spacer></td>');
	write('</tr>');
	write('<tr valign="middle" class="subhdrbg">');
	write('<td colspan="2" class="subhdr">' + jsUtil.encodeChar(subTitleDisp) + '</td>');
	write('<td colspan="3" align="right" valign="middle">&nbsp;</td>');
	write('</tr>');
	write('<tr class="rowspacing" >');
	write('<td colspan="4">&nbsp;</td>');
	write('<td align="right">');
	write('<a id="sLnk10" href="javascript:showHelpFile(\'oifacrit_help.htm\');">');
	write('<img src="../Renderer/images/' + applangcode + '/help.gif" border="0" hotKeyId="finHelp">');
	write('</img>');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000204") + '');
	write('<script>setMandatory("true")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<select class="listboxfont" fmnd="Y" id="tempFuncCode" onChange="javascript:return oifa_accept_ONCHANGE4(this);" name="' + sGroupName + '.tempFuncCode" value="' + tempFuncCode + '">');
	write('<script>writeComboFunction("writeTemplateFuncCodeForTDACOP");</script>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT001447") + '</td>');
	write('<td class="columnwidth" class="textfield">');
	write('<input onBlur="javascript:return custom_ONBLUR(\'oifa_accept\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.templateId" id="templateId" value="' + templateId + '" size="24" maxlength="25" onChange="javascript:return oifa_accept_ONCHANGE5(this);" hotKeyId="search7">&nbsp;');
	write('<a id="sLnk12" target=_self href="Javascript:showGtmplSearcher()">');
	write('<img class="img" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0" alt="Search List" hotKeyId="search7"></img></a>');
	write('<input class="label" name="' + sGroupName + '.templateType" id="templateType" fds="Y" size=8 disabled>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT005276") + '<script>setMandatory("true")</script></td>');
	write('<td class="textfield">');
	write('<input type="radio" name="' + sGroupName + '.typeOfAcct" title="Normal A/c Type" id="typeOfAcct" value="N" onClick="javascript:return oifa_accept_ONCLICK6(this,this.value);" checked>' + jspResArr.get("FLT001548") + '');
	write('<input type="radio" name="' + sGroupName + '.typeOfAcct" title="Top Up A/C Type" id="typeOfAcct" value="T" onClick="javascript:return oifa_accept_ONCLICK7(this,this.value);">' + jspResArr.get("FLT010189") + '');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel"><span id="topupParentAcct"></span></td>');
	write('<td class="textfield" ><span id="topupParentAcctId"></span></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textfield">');
	write('<input class="label" name="' + sGroupName + '.parentCrncy" id="parentCrncy" value="' + sParentCrncy + ' " size=4 maxlength=4 fds="Y" disabled>');
	write('<input class="label" name="' + sGroupName + '.parentSolId" id="parentSolId" value="' + sParentSolId + ' " size=7 maxlength=7 fds="Y" disabled>');
	write('<input class="label" name="' + sGroupName + '.acctName" id="acctName" value="' + sAcctName + ' " size=15 maxlength=15 fds="Y" disabled>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000005") + '<script>setMandatory("true")</script>');
	if("null"==sTemplateStatus){
	}
	write('</td>');
	write('<td class="textfield" colspan="4"><input onBlur="javascript:return custom_ONBLUR(\'oifa_accept\',this);" type="text" fdt="cifid" fmnd="N" class="textfieldfont" name="' + sGroupName + '.cifId" id="cifId" value="' + cifId + '" size="31" maxlength="32" onchange="javascript:return oifa_accept_ONCHANGE8(this,\'myframe\',\'CIFID\',\'F\',\'cifId\',\'custName\');" hotKeyId="search1" explodeId="explode1">');
	write('&nbsp;<a target=_self id="sLnk2" href="javascript:showCifId(document.forms[0].cifId,\'ctrl\',\'F\',document.forms[0].custName)">');
	write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search List" hotKeyId="search1"></img></a>&nbsp;');
	write('<a href="Javascript:fnExplodeCifId(document.forms[0].cifId,\'Y\')" id="sLnk11">');
	write('<img explodeId="explode1" src="../Renderer/images/explode.gif" width="16" alt="View the Customer Details" height="17" border="0"></img></a>&nbsp;');
	write('<input class="label" name="' + sGroupName + '.custName" id="custName" fds="Y" value="' + sCustName + '" size=20 maxlength=50 readonly tabindex=-1 disabled></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000003") + '<script>setMandatory("true")</script></td>');
	write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'oifa_accept\',this);" type="text" fmnd="Y" class="textfieldfont" name="' + sGroupName + '.solId" id="solId" value="' + solId + '" size="14" maxlength="8" onchange="javascript:return oifa_accept_ONCHANGE9(this,\'solIdDesc\');" hotKeyId="search2">');
	write('&nbsp;<a target=_self id="sLnk1" href="javascript:showSolId(document.forms[0].solId,\'ctrl\',\'F\',document.forms[0].solIdDesc)">');
	write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search List" hotKeyId="search2"></img></a>');
	write('<input class="label" name="' + sGroupName + '.solIdDesc" id="solIdDesc" fds="Y" value="' + sSolIdDesc + '" size=20 maxlength=50 readonly tabindex=-1 disabled>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT021050") + '</td>');
	write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'oifa_accept\',this);" onBlur="javascript:return custom_ONBLUR(\'oifa_accept\',this);" type="text" fmnd="N" class="textfieldfont" name="' + sGroupName + '.assetId" id="assetId" value="' + assetId + '" size="14" maxlength="12" hotKeyId="search11">');
	write('&nbsp;<a target=_self id="sLnk13" href="javascript:showDynSearcher(\'INQASSET\',\'purchase_ref=:assetId|entity_cre_flg');
	write('=Y\',\':assetId=purchase_ref\')">');
	write('<img class="img" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0" alt="Search List" hotKeyId="search11"></img></a>');
	write('</td>');
	write('</tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000006") + '</td>');
	write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'oifa_accept\',this);" type="text" fmnd="N" class="textfieldfont" name="' + sGroupName + '.crncyCode" id="crncyCode" value="' + crncyCode + '" size="5" maxlength="3" onchange="javascript:return oifa_accept_ONCHANGE10(this,\'crncyDesc\');" hotKeyId="search3">');
	write('&nbsp;<a target=_self id="sLnk3" href="javascript:showCurrency(document.forms[0].crncyCode,\'ctrl\',\'F\',document.forms[0].crncyDesc)">');
	write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search List" hotKeyId="search3"></img></a>');
	write('<br>');
	write('<input class="label" name="' + sGroupName + '.crncyDesc" id="crncyDesc" fds="Y" value="' + sCrncyDesc + '" size=20 maxlength=50 readonly tabindex=-1 disabled>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000008") + '<script>setMandatory("Y")</script></td>');
	write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'oifa_accept\',this);" type="text" fmnd="Y" class="textfieldfont" name="' + sGroupName + '.schmCode" id="schmCode" value="' + schmCode + '" size="9" maxlength="5" onchange="javascript:return oifa_accept_ONCHANGE11(this,\'schmCodeDesc\');" hotKeyId="search4">');
	write('&nbsp;<a target=_self id="sLnk4" href="javascript:showSchmCodes(document.forms[0].schmCode,document.forms[0].glSubHeadCode,document.forms[0].solId.value,\'schmcode\',\'F\',document.forms[0].schmCodeDesc,\'' + sSchmType + '\',document.forms[0].crncyCode)">');
	write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search List" hotKeyId="search4"></img></a>');
	write('<br>');
	write('<input class="label" name="' + sGroupName + '.schmCodeDesc" id="schmCodeDesc" fds="Y" value="' + sSchmCodeDesc + '" size=20 maxlength=50 readonly tabindex=-1s disabled>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000007") + '');
	if("null" !=sTemplateStatus){
	write('<script>setMandatory("true")</script>');
	}
	write('</td>');
	write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'oifa_accept\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.glSubHeadCode" id="glSubHeadCode" value="' + glSubHeadCode + '" size="9" maxlength="5" onchange="javascript:return oifa_accept_ONCHANGE12(this,\'glSubHeadDesc\');" hotKeyId="search5">');
	write('&nbsp;<a target=_self id="sLnk5" href="javascript:showSchmCodes(document.forms[0].schmCode,document.forms[0].glSubHeadCode,document.forms[0].solId.value,\'glshcode\',\'F\',document.forms[0].glSubHeadDesc,\'' + sSchmType + '\',document.forms[0].crncyCode)">');
	write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search List" hotKeyId="search5"></img></a>');
	write('<input class="label" name="' + sGroupName + '.glSubHeadDesc" id="glSubHeadDesc" fds="Y" value="' + sGlSubHeadDesc + ' " size=20 maxlength=50 readonly tabindex=-1 disabled>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000009") + '</td>');
	write('<td class="textfield" colspan="2"><input onChange="javascript:return custom_ONCHANGE(\'oifa_accept\',this);" onBlur="javascript:return custom_ONBLUR(\'oifa_accept\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.permForacid" id="permForacid" value="' + permForacid + '" size="20" maxlength="16"></td>');
	write('<td class="textlabel"> ' + jspResArr.get("FLT008330") + '</td>');
	write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'oifa_accept\',this);" onBlur="javascript:return custom_ONBLUR(\'oifa_accept\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.chnlId" id="chnlId" value="' + chnlId + '" size="7" maxlength="5" hotKeyId="search6">&nbsp;<a target=_self id="sLnk8" href="javascript:showRefCode(document.forms[0].chnlId,\'GB\',\'N\',\'F\',\'\')"><img class="img" src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search List" hotKeyId="search6"></img></a></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel"> ' + jspResArr.get("FLT005198") + '&nbsp;</td>');
	write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'oifa_accept\',this);" onBlur="javascript:return custom_ONBLUR(\'oifa_accept\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.projectId" id="projectId" value="' + projectId + '" size="16" maxlength="20" hotKeyId="search7">');
	write('&nbsp;<a target=_self id="sLnk9" href="javascript:fnSearcherProjectId()"><img class="img" alt="' + jspResArr.get("FLT019645") + '" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search List" hotKeyId="search7"></img></a>');
	write('</td>');
	write('</tr>');
	write('<tr class="rowspacingbottom">');
	write('<td colspan="5"><spacer type="block" width="1" height="1"></spacer></td>');
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

	} 
} //End function

function printBlock3()
{
	with (document) {
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop1">');
	write('<tr>');
	write('<td colspan="5" class="rowspacing1"><spacer type="block" height=1 width=1></spacer></td>');
	write('</tr>');
	write('<tr class="rowspacing" >');
	write('<td colspan="4">&nbsp;</td>');
	write('<td align="right">');
	write('<a id="sLnk10" href="javascript:showHelpFile(\'oifa_accept.htm\');">');
	write('<img src="../Renderer/images/' + applangcode + '/help.gif" border="0" hotKeyId="finHelp">');
	write('</img>');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000204") + '<script>setMandatory("true")</script></td>');
	write('<td class="textfield">');
	write('<select onChange="javascript:return custom_ONCHANGE(\'oifa_accept\',this);" class="listboxfont" fmnd="Y" id="verifyCancel" name="' + sGroupName + '.verifyCancel">');
	write('<script>writeComboFunction("writeVerifyCancel");</script>');
	write('</select></td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">&nbsp;</td>');
	write('<td class="textfield">&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000010") + '<script>setMandatory("true")</script></td>');
	write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'oifa_accept\',this);" type="text" class="textfieldfont" fmnd="Y" name="' + sGroupName + '.tempForacid" id="tempForacid" value="' + tempForacid + '" size="20" fdt="accountid" maxlength="16" onChange="javascript:return oifa_accept_ONCHANGE13(this,this,\'acctDesc\',\'solId\',\'crncyCode\',true,\'VALACCTID\');" hotKeyId="search8">');
	write('&nbsp;<a target=_self id="sLnk6" href="javascript:fnAccountIDList(\'V\')"><img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search List" hotKeyId="search8"></img></a>');
	write('&nbsp;');
	write('<a id="sLnk7" href="javascript:showFinacleSignature()">');
	write('<img class="img" title="' + jspResArr.get("FHP000249") + '" src="../Renderer/images/' + applangcode + '/sig_new1.gif" width="16" height="16" border="0"></img></a>');
	write('&nbsp;');
	write('<input onChange="javascript:return custom_ONCHANGE(\'oifa_accept\',this);" onBlur="javascript:return custom_ONBLUR(\'oifa_accept\',this);" id="crncyCode"  disabled fds="Y" name="' + sGroupName + '.crncyCode" type="text" disabled="true" class="labelwithoutwidth" size="3" maxlength="3">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'oifa_accept\',this);" onBlur="javascript:return custom_ONBLUR(\'oifa_accept\',this);" id="solId"  disabled fds="Y" name="' + sGroupName + '.solId" type="text" disabled="true" class="labelwithoutwidth" size="8" maxlength="8">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'oifa_accept\',this);" onBlur="javascript:return custom_ONBLUR(\'oifa_accept\',this);" id="acctDesc"  disabled fds="Y" name="' + sGroupName + '.acctDesc" type="text" disabled="true" class="label" size="25" maxlength="25">');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">&nbsp;</td>');
	write('<td class="textfield">&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000009") + '</td>');
	write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'oifa_accept\',this);" onBlur="javascript:return custom_ONBLUR(\'oifa_accept\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.permForacid" id="permForacid" value="' + permForacid + '" size="20" maxlength="16"></td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">&nbsp;</td>');
	write('<td class="textfield">&nbsp;</td>');
	write('</tr>');
	write('<tr class="rowspacingbottom">');
	write('<td colspan="5"><spacer type="block" width="1" height="1"></spacer></td>');
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

	} 
} //End function

function printFooterBlock()
{
	with (document) {
	if ((sReferralMode == 'I')||(sReferralMode == 'S')){
	write('<div class="ctable">');
	if (sReferralMode == 'S'){
	write('<input type="button" class="Button" id="Submit" value="' + jspResArr.get("FLT000193") + '" onClick="javascript:return doRefSubmit(this);"	hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="' + jspResArr.get("FLT000192") + '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input type="button" class="Button" id="Submit" value="' + jspResArr.get("FLT004977") + '" onClick="javascript:return oifa_accept_ONCLICK14(this,this);" / hotKeyId="Go" >');
	write('<input type="button" class="Button" id="Cancel" value="' + jspResArr.get("FLT001439") + '" onClick="javascript:return oifa_accept_ONCLICK15(this,this);" />');
	if("null" !=sTemplateStatus){
	write('<input type="button" class="Button" id="Back" value="' + jspResArr.get("FLT003327") + '" onClick="javascript:return oifa_accept_ONCLICK16(this,this);" / hotKeyId="Cancel" >');
		}
	writeFooter();
	write('</div>');
	}
	} //End with()
} //End function

function fnPopulateControlValues()
{
	var frm = document.forms[0];

	frm.cifId.value = cifId;
	frm.solId.value = solId;
	frm.crncyCode.value = crncyCode;
	frm.assetId.value = assetId;
	frm.schmCode.value = schmCode;
	frm.glSubHeadCode.value = glSubHeadCode;
	frm.permForacid.value = permForacid;
	frm.svsTranId.value = svsTranId;
	frm.SVS_Verify_Status.value = SVS_Verify_Status;
	frm.projectId.value = projectId;
	frm.templateId.value = templateId;
	frm.typeOfAcct.value = typeOfAcct;
	frm.tempFuncCode.value = tempFuncCode;
	if ((sReferralMode == 'I') || (sReferralMode == 'S')){
		fnDisableFormDataControls('V',frm,0);
	}
}


function oifa_accept_ONKEYDOWN1(obj,p1)
{
	var retVal = "";
	if (preEventCall('oifa_accept',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	if ((retVal = fnKeyDownProcessor(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	if (postEventCall('oifa_accept',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function oifa_accept_ONKEYUP2(obj,p1)
{
	var retVal = "";
	if (preEventCall('oifa_accept',obj,'ONKEYUP') == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONKEYUP') == false) { 
		return false;
	}
	if ((retVal = fnKeyUpProcessor(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONKEYUP') == false) { 
		return false;
	}
	if (postEventCall('oifa_accept',obj,'ONKEYUP') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function oifa_accept_ONLOAD3(obj)
{
	var retVal = "";
	var frmObj = document.forms[0];
	if (pre_ONLOAD('oifa_accept',obj) == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONLOAD') == false) { 
		return false;
	}
	if ((retVal = fnOnLoad()) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONLOAD') == false) { 
		return false;
	}
	fnPopUpExceptionWindow(frmObj.actionCode);
	if (post_ONLOAD('oifa_accept',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function oifa_accept_ONCHANGE4(obj)
{
	var retVal = "";
	if (preEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = disableTempId()) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function oifa_accept_ONCHANGE5(obj)
{
	var retVal = "";
	if (preEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fetchTemplateData()) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function oifa_accept_ONCLICK6(obj,p1)
{
	var retVal = "";
	if (preEventCall('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = enableFieldsIfTopup(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function oifa_accept_ONCLICK7(obj,p1)
{
	var retVal = "";
	if (preEventCall('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = enableFieldsIfTopup(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function oifa_accept_ONCHANGE8(obj,p1,p2,p3,p4,p5)
{
	var retVal = "";
	if (preEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = sendDataToServer(p1,p2,p3,p4,p5)) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function oifa_accept_ONCHANGE9(obj,p1)
{
	var retVal = "";
	if (preEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = clearDescField(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function oifa_accept_ONCHANGE10(obj,p1)
{
	var retVal = "";
	if (preEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = clearDescField(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function oifa_accept_ONCHANGE11(obj,p1)
{
	var retVal = "";
	if (preEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = clearDescField(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function oifa_accept_ONCHANGE12(obj,p1)
{
	var retVal = "";
	if (preEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = clearDescField(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function oifa_accept_ONCHANGE13(obj,p1,p2,p3,p4,p5,p6)
{
	var retVal = "";
	if (preEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnFetchAccountDetails(p1,p2,p3,p4,p5,p6)) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('oifa_accept',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function oifa_accept_ONCLICK14(obj,p1)
{
	var retVal = "";
	if (preEventCall('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = validateFields(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function oifa_accept_ONCLICK15(obj,p1)
{
	var retVal = "";
	if (preEventCall('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = validateFields(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function oifa_accept_ONCLICK16(obj,p1)
{
	var retVal = "";
	if (preEventCall('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = validateFields(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('oifa_accept',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function writeTemplateFuncCodeForTDACOP()
{
with(document) {
write('<OPTION VALUE="">'+jspResArr.get("FLT012410")+'</OPTION>');
write('<OPTION selected VALUE="O">'+jspResArr.get("FLT020709")+'</OPTION>');
write('<OPTION VALUE="T">'+jspResArr.get("FLT020990")+'</OPTION>');
}
}


function writeVerifyCancel()
{
with(document) {
write('<OPTION VALUE="">'+jspResArr.get("FLT012410")+'</OPTION>');
write('<OPTION VALUE="V">'+jspResArr.get("FLT013170")+'</OPTION>');
write('<OPTION VALUE="X">'+jspResArr.get("FLT012392")+'</OPTION>');
}
}

function fnAccountIDList(){
	//alert("am in");
	var ObjForm = document.forms[0];
	var inputNameValues = "tempForacid|"+ObjForm.tempForacid.value;
    var outputNameValues = "tempForacid|SOLID|TABLEKEY|ENTERERID|DATE";
	var scriptName = "b_aifaacctlist.scr";
	var listHeading = "Account List";
    var colHeader = "ACCT|SOLID|TABLEKEY|ENTERERID|DATE";
    var retVal = appFnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true)
}


