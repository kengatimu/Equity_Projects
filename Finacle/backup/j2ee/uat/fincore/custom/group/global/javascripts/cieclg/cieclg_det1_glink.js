function printBlock()
{
	writeCustomHeader("cieclg_det1");
	with (document){
	write('<input type="hidden" id="instrumentDate" fdt="fdate" vFldId="instrumentDate_ui" name="' + subGroupName + '.instrumentDate">');
	write('<input type="hidden" id="targetZoneDate" fdt="fdate" vFldId="targetZoneDate_ui" name="' + subGroupName + '.targetZoneDate">');
	write('<input type="hidden" id="valueDate" fdt="fdate" vFldId="valueDate_ui" name="' + subGroupName + '.valueDate">');
	write('<input type="hidden" id="zoneCode" name="' + subGroupName + '.zoneCode">');
	write('<input type="hidden" id="zoneDate" name="' + subGroupName + '.zoneDate">');
	write('<input type="hidden" id="setNum" name="' + subGroupName + '.setNum">');
	write('<input type="hidden" name="tmpAmtField" id="tmpAmtField">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Inter Entity Clearing Maintenance</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" colspan="5" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000700") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label align="left"id="compFieldFunc">' + fnGetFunctionCodeDesc(funcCode) + '</label>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000716") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compFieldTxnType">' + zoneCode + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000717") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldFunc">' + zoneDate + '</label>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000718") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compFieldTxnType">' + zoneCcy + '</label>');
        write('</td>');
        write('</tr>');
        //added ubp-start
        write('<tr id="UbpBillerRow">');
	write('<td class="textlabel">' + jspResArr.get("FLT007530") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label align="left"id="compFieldFunc">' + billerId + '</label>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031859") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compFieldTxnType">' + typOfServ + '</label>');
	write('</td>');
        write('</tr>');
        //added ubp-end
	write('<tr id="setNumRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000701") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldFunc">' + setNum + '</label>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000730") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldFunc">' + fnGetStatusCodeDesc(status) + '</label>');
        write('</td>');
        write('</tr>');
	write('<tr id="tranIdRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000731") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldFunc">' + entity1TranId + ' / ' + entity1TranDate +'</label>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000732") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldFunc">' + entity2TranId + ' / ' + entity2TranDate + '</label>');
        write('</td>');
        write('</tr>');
	write('<tr id="chargeTranIdRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000733") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldFunc">' + chargeTranId + ' / ' + chargeTranDate + '</label>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldFunc"></label>');
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

	write('<tr id="creditEntity">');
        write('<td class="textlabel">' + jspResArr.get("FLT000721") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.creditEntity" id="creditEntity" ' + cieclgProps.get("creditEntity_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="2" onBlur="javascript:return cieclg_det1_ONBLUR9(this);">&nbsp;');
        write('<a id="creditEntityImg" href="javascript:showEntityList()">');
        write('<img border="0" alt="Search List" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>&nbsp;');
        write('</td>');
        write('<td class="textlabel">');
        write('<input name="' + subGroupName + '.creditEntityDesc" id="creditEntityDesc" ' + cieclgProps.get("creditEntityDesc_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="50" maxlength="50" >&nbsp;');
        write('</td>');
        write('<td class="textfield">');
        write('</td>');
        write('</tr>');

	write('<tr id="crAcctNumRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000702") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.crAcctNum" id="crAcctNum" ' + cieclgProps.get("crAcctNum_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="16" onChange="javascript:return cieclg_det1_ONCHANGE2(this);">&nbsp;');
        write('<a id="crAcctNumImg" href="javascript:getAcctIdList()">');
        write('<img border="0" alt="Search List" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>&nbsp;');
	write('<a id="customExplode1"  target="_self" href="JavaScript:fnExplodeBalanceDetails(document.forms[0].crAcctNum)">');
        write('<img class="img" onmouseover="this.style.cursor=\'hand\';"  onmouseout=" this.style.cursor=\'default\';" src="../Renderer/images/'+applangcode+'/explode.gif" width="16" height="16" border="0" alt="Balance Details" width="24" height="20" onClick=""></img>');
        write('</a>');
        write('</td>');
        write('<td class="textlabel">');
	write('<input name="' + subGroupName + '.crAcctNumEntityId" id="crAcctNumEntityId" ' + cieclgProps.get("crAcctNumEntityId_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="4" maxlength="8" >&nbsp;');
	write('<input name="' + subGroupName + '.crAcctNumSolId" id="crAcctNumSolId" ' + cieclgProps.get("crAcctNumSolId_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="4" maxlength="8" >&nbsp;');
	write('<input name="' + subGroupName + '.crAcctNumCcy" id="crAcctNumCcy" ' + cieclgProps.get("crAcctNumCcy_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="2" maxlength="3" >');
	write('</td>');
	write('<td class="textfield">');
	write('<input name="' + subGroupName + '.crAcctName" id="crAcctName" ' + cieclgProps.get("crAcctName_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="40" maxlength="80" >');
        write('</td>');
        write('</tr>');

	write('<tr id="instrumentEntity">');
        write('<td class="textlabel">' + jspResArr.get("FLT000724") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.instrumentEntity" id="instrumentEntity" ' + cieclgProps.get("instrumentEntity_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="2" onBlur="javascript:return cieclg_det1_ONBLUR10(this);" onChange="javascript:return cieclg_det1_ONCHANGE3(this);">&nbsp;');
        write('<a id="instrumentEntityImg" href="javascript:showEntityListForInstrument()">');
        write('<img border="0" alt="Search List" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>&nbsp;');
        write('</td>');
        write('<td class="textlabel">');
        write('<input name="' + subGroupName + '.instrumentEntityDesc" id="instrumentEntityDesc" ' + cieclgProps.get("instrumentEntityDesc_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="50" maxlength="50" >&nbsp;');
        write('</td>');
        write('<td class="textfield">');
        write('</td>');
        write('</tr>');

	write('<tr id="refCrncyRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000705") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<input name="' + subGroupName + '.instrumentAmt" id="instrumentAmt" ' + cieclgProps.get("instrumentAmt_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldamount" align="right" size="23" maxlength="23" fdt="fpcnt" onBlur="javascript:return cieclg_det1_ONBLUR6(this);">');
        write('&nbsp;&nbsp;<input name="' + subGroupName + '.instrumentAmtCcy" id="instrumentAmtCcy" ' + cieclgProps.get("instrumentAmtCcy_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="2" maxlength="3" >');
        write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000706") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<input name="' + subGroupName + '.chargeAmt" id="chargeAmt" ' + cieclgProps.get("chargeAmt_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="23" maxlength="23" fdt="amount">&nbsp;');
	write('<input name="' + subGroupName + '.chargeAmtCcy" id="chargeAmtCcy" ' + cieclgProps.get("chargeAmtCcy_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="2" maxlength="3" >');
	write('<input name="' + subGroupName + '.chargeEventId" id="chargeEventId" ' + cieclgProps.get("chargeEventId_ENABLED") + ' type="hidden">');
        write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000715") + '</td>');
        write('<td>');
        write('<input  type="text" class="textfieldfont" name="' + subGroupName + '.instrumentDate_ui" id="instrumentDate_ui"  class="textfieldfont" size="21" maxlength="10" onChange="javascript:return cieclg_det1_ONCHANGE4(this,this,this);" fdt="uidate">&nbsp;');
        write('<a id="instrumentDateImg" href="javascript:openDate(document.forms[0].instrumentDate_ui,BODDate)"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
        write('</a>');
        write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000712") + '');
        write('<td class="textfield"><input id="instrumentAlpha" name="' + subGroupName + '.instrumentAlpha" ' + cieclgProps.get("instrumentAlpha_ENABLED") + ' type="text" size="6" maxlength="6">');
        write('&nbsp;&nbsp;<input id="instrumentNum" name="' + subGroupName + '.instrumentNum" ' + cieclgProps.get("instrumentNum_ENABLED") + ' type="text" size="18" maxlength="16" fdt="fpint">');
        write('</td>');
	write('</tr>');

	write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000719") + '</td>');
        write('<td>');
        write('<input  type="text" class="textfieldfont" name="' + subGroupName + '.valueDate_ui" id="valueDate_ui"  class="textfieldfont" size="21" maxlength="10" onChange="javascript:return cieclg_det1_ONCHANGE5(this,this,this);" fdt="uidate">&nbsp;');
        write('<a id="valueDateImg" href="javascript:openDate(document.forms[0].valueDate_ui,BODDate)"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
        write('</a>');
        write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000709") + '');
        write('<td class="textfield"><input id="instrumentSortCode" name="' + subGroupName + '.instrumentSortCode" hotKeyId="search5" ' + cieclgProps.get("instrumentSortCode_ENABLED") + 'type="text" class="textfieldfont" onBlur="javascript:return cieclg_det1_ONBLUR13(this);" size="25" maxlength="9">');
        write('&nbsp;<a id="instrumentSortCodeImg" href="JavaScript:showSortCodeList()">');
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search5"></a>');
        write('</td>');
        write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000722") + '</td>');
	write('<td class="textfield"><input id="instrumentBankCode" name="' + subGroupName + '.instrumentBankCode" hotKeyId="search5" ' + cieclgProps.get("instrumentBankCode_ENABLED") + 'type="text" class="textfieldfont" onChange="javascript:return cieclg_det1_ONCHANGE6(this);" onBlur="javascript:return cieclg_det1_ONBLUR11(this);" size="25" maxlength="6">');
	write('&nbsp;<a id="instrumentBankCodeImg" href="JavaScript:showBankCodeList()">');
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search5"></a>');
        write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000723") + '</td>');
        write('<td class="textfield"><input id="instrumentBranchCode" name="' + subGroupName + '.instrumentBranchCode" hotKeyId="search5" ' + cieclgProps.get("instrumentBranchCode_ENABLED") + 'type="text" class="textfieldfont" onBlur="javascript:return cieclg_det1_ONBLUR12(this);" size="25" maxlength="6">');
        write('&nbsp;<a id="instrumentBranchCodeImg" href="JavaScript:showBranchCodeList()">');
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search5"></a>');
        write('</td>');
	write('</tr>');

	write('<tr>');
        write('<td class="textlabel"></td>');
        write('<td class="textfield"><input id="instrumentBankName" name="' + subGroupName + '.instrumentBankName" hotKeyId="search5" ' + cieclgProps.get("instrumentBankName_ENABLED") + 'type="text" class="label" size="40" maxlength="50">');
        write('</td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfield"><input id="instrumentBranchName" name="' + subGroupName + '.instrumentBranchName" hotKeyId="search5" ' + cieclgProps.get("instrumentBranchName_ENABLED") + 'type="text" class="label" size="40" maxlength="50">');
        write('</td>');
        write('</tr>');

	write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000725") + '</td>');
        write('<td class="textfield"><input id="targetZoneCode" name="' + subGroupName + '.targetZoneCode" hotKeyId="search5" ' + cieclgProps.get("targetZoneCode_ENABLED") + 'type="text" class="textfieldfont" size="25" maxlength="10">');
        write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000726") + '</td>');
        write('<td class="textfield"><input id="targetSolId" name="' + subGroupName + '.targetSolId" hotKeyId="search5" ' + cieclgProps.get("targetSolId_ENABLED") + 'type="text" class="textfieldfont" size="25" maxlength="8">');
        write('</td>');
        write('</tr>');

	write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000727") + '</td>');
        write('<td>');
        write('<input  type="text" class="textfieldfont" name="' + subGroupName + '.targetZoneDate_ui" id="targetZoneDate_ui"  class="textfieldfont" size="21" maxlength="10" onChange="javascript:return cieclg_det1_ONCHANGE7(this,this,this);" fdt="uidate">&nbsp;');
        write('<a id="targetZoneDateImg" href="javascript:openDate(document.forms[0].targetZoneDate_ui,BODDate)"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
        write('</a>');
        write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000728") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<input name="' + subGroupName + '.targetSetNum" id="targetSetNum" ' + cieclgProps.get("targetSetNum_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="23" maxlength="6">&nbsp;');
        write('</td>');
        write('</tr>');
	
	write('<tr id="refCrncyRow">');
	write('<td class="textlabel">' + jspResArr.get("FLT000708") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<input name="' + subGroupName + '.nostroAcct" id="nostroAcct" ' + cieclgProps.get("nostroAcct_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="23" maxlength="23">&nbsp;');
        write('</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000729") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<input name="' + subGroupName + '.vostroAcct" id="vostroAcct" ' + cieclgProps.get("vostroAcct_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="23" maxlength="23">&nbsp;');
        write('</td>');
        write('</tr>');

	write('<tr id="refCrncyRow">');
	write('<td class="textlabel">' + jspResArr.get("FLT000720") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<input name="' + subGroupName + '.payingAcct" id="payingAcct" ' + cieclgProps.get("payingAcct_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="23" maxlength="16">&nbsp;');
	write('<a id="payingAcctSigImg" href="javascript:showFinacleSignature();">');
        write('<img src="../Renderer/images/' + applangcode + '/sig_new1.gif" alt="' + jspResArr.get("FLT000716") + '" width="16" height="16" border="0"></a>');
        write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000713") + '');
        write('<td class="textfield"><input id="tranParticular" name="' + subGroupName + '.tranParticular" ' + cieclgProps.get("tranParticular_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="50">');
        write('</td>');
        write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000714") + '');
        write('<td class="textfield"><input id="tranRmks" name="' + subGroupName + '.tranRmks" ' + cieclgProps.get("tranRmks_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="30">');
        write('</td>');
        write('<td class="textlabel">');
        write('<td class="textfield">');
        write('</td>');
        write('</tr>');

	write('<tr id="rejectReasonCodeRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000734") + '</td>');
        write('<td class="textfield"><input id="rejectReasonCode" name="' + subGroupName + '.rejectReasonCode" hotKeyId="search5" ' + cieclgProps.get("rejectReasonCode_ENABLED") + 'type="text" class="textfieldfont" onChange="javascript:return cieclg_det1_ONCHANGE8(this);" size="25" maxlength="6">');
        write('&nbsp;<a id="rejectReasonCodeImg" href="JavaScript:showRejectReasonCodeList()">');
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search5"></a>');
        write('</td>');
        write('<td class="textfield"><input id="rejectReasonCodeDesc" name="' + subGroupName + '.rejectReasonCodeDesc" hotKeyId="search5" ' + cieclgProps.get("rejectReasonCodeDesc_ENABLED") + 'type="text" class="label" size="50" maxlength="50">');
        write('</td>');
	write('<td class="textlabel"></td>');
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
	//Added for UBP-start
	
	if(billPayYes=="Y")
	{
		getBillDetailSectionIECLG();
	}
	//Added for UBP-end
	
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
	write('<input id="Submit" name="Submit" type="button" class="button" value="Submit"	onClick="javascript:return cieclg_det1_ONCLICK4(this,this);"" hotKeyId="Submit">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="Cancel"	onClick="javascript:return cieclg_det1_ONCLICK5(this,this.id);"" hotKeyId="Cancel">');
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
	
	pre_ONLOAD('cieclg_det1',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();
	
	fnAssignDateOnLoad(ObjForm);

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='R' || funcCode == 'O' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnCustDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cieclg_det1',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.zoneCode.value = zoneCode;
	ObjForm.zoneDate.value = zoneDate;
	ObjForm.setNum.value = setNum;
	ObjForm.creditEntity.value = creditEntity;
        ObjForm.creditEntityDesc.value = creditEntityDesc;
	ObjForm.crAcctNum.value = crAcctNum;
	ObjForm.crAcctNumEntityId.value = crAcctNumEntityId;
	ObjForm.crAcctNumSolId.value = crAcctNumSolId;
	ObjForm.crAcctNumCcy.value = crAcctNumCcy;
        ObjForm.crAcctName.value = crAcctName;
	ObjForm.chargeEventId.value = chargeEventId;
        ObjForm.chargeAmt.value = chargeAmt;
        ObjForm.chargeAmtCcy.value = chargeAmtCcy;
	ObjForm.nostroAcct.value = nostroAcct;
	ObjForm.vostroAcct.value = vostroAcct;
	ObjForm.valueDate.value = valueDate;
	ObjForm.payingAcct.value = payingAcct;
	ObjForm.targetZoneCode.value = targetZoneCode;
	ObjForm.targetSolId.value = targetSolId;
	ObjForm.targetZoneDate.value = targetZoneDate;
	ObjForm.targetSetNum.value = targetSetNum;
	ObjForm.tranParticular.value = tranParticular;
	ObjForm.tranRmks.value = tranRmks;
	ObjForm.instrumentEntity.value = instrumentEntity;
	ObjForm.instrumentEntityDesc.value = instrumentEntityDesc;
        ObjForm.instrumentAlpha.value = instrumentAlpha;
	ObjForm.instrumentDate.value = instrumentDate;
        ObjForm.instrumentNum.value = instrumentNum;
	ObjForm.instrumentAmt.value = instrumentAmt;
	ObjForm.instrumentAmtCcy.value = zoneCcy;
	ObjForm.instrumentBankCode.value = instrumentBankCode;
        ObjForm.instrumentBranchCode.value = instrumentBranchCode;
	ObjForm.instrumentSortCode.value = instrumentSortCode;
	ObjForm.instrumentBankName.value = instrumentBankName;
	ObjForm.instrumentBranchName.value = instrumentBranchName;
	ObjForm.rejectReasonCode.value = rejectReasonCode;
	//Added for UBP changes--start
		if(billPayYes=="Y")
		{
			ObjForm.billRefNum.value = billRefNum;
			ObjForm.name.value = name;
			//ObjForm.tranPart.value = tranPart;
			//ObjForm.tranRem.value = tranRem;
			ObjForm.refNumHidden.value = refNumHidden;
			ObjForm.retStrngValHid.value =retStrngValHid;
			
			if(billerId=="IPO")
			{
			ObjForm.appCatgry.value =appCatgry;
			}
			if(billerId=="KRA")
			{
				ObjForm.freetext1.value =freetext1;
				ObjForm.freetext2.value =freetext2;
				ObjForm.freetext3.value =freetext3;
				ObjForm.freetext4.value =freetext4;
				ObjForm.freetext5.value =freetext5;
				ObjForm.freetext6.value =freetext6;
				ObjForm.freetext7.value =freetext7;
		
			}
			if(billerId=="KASNEB")
			{
				ObjForm.freetext1.value =freetext1;
				ObjForm.freetext2.value =freetext2;
				ObjForm.refDesc.value = refDesc;
			}
			if(billerId=="TURNQUEST")
			{
				ObjForm.riskNote.value = riskNote;
				//fnCheckControls();
				var ObjForm = document.forms[0];
				checkRadio(ObjForm.riskNote,riskNote);
			}		
		}
		
	//Added for UBP changes-end
	fnCheckControls();

}

function fnCheckControls()
{
	var ObjForm = document.forms[0];
	//checkRadio(ObjForm.riskNote,riskNote);

}

function cieclg_det1_ONCHANGE2(obj)
{
        var retVal = "";
        if (preEventCall('cieclg_det1',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = fnGetCrAcctDetails()) == false) {
                return false;
        }
        if (postEventCall('cieclg_det1',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cieclg_det1_ONCHANGE3(obj)
{
        var retVal = "";
        if (preEventCall('cieclg_det1',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = fnClearBankBranchCode()) == false) {
                return false;
        }
        if (postEventCall('cieclg_det1',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cieclg_det1_ONBLUR6(obj)
{
        var retVal = "";
        if (preEventCall('cieclg_det1',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnFormatAmountField(obj)) == false) {
                return false;
        }
        if (postEventCall('cieclg_det1',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}


function cieclg_det1_ONBLUR9(obj)
{
        var retVal = "";
        if (preEventCall('cieclg_det1',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnGetEntityDesc(obj)) == false) {
                return false;
        }
        if (postEventCall('cieclg_det1',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cieclg_det1_ONBLUR10(obj)
{
        var retVal = "";
        if (preEventCall('cieclg_det1',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnGetEntityDescForInstrument(obj)) == false) {
                return false;
        }
        if (postEventCall('cieclg_det1',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cieclg_det1_ONBLUR11(obj)
{
        var retVal = "";
        if (preEventCall('cieclg_det1',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = showBankCode(obj)) == false) {
                return false;
        }
        if (postEventCall('cieclg_det1',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cieclg_det1_ONBLUR12(obj)
{
        var retVal = "";
        if (preEventCall('cieclg_det1',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = showBranchCode(obj)) == false) {
                return false;
        }
        if (postEventCall('cieclg_det1',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cieclg_det1_ONBLUR13(obj)
{
        var retVal = "";
        if (preEventCall('cieclg_det1',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = showSortCode(obj)) == false) {
                return false;
        }
        if (postEventCall('cieclg_det1',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cieclg_det1_ONCLICK4(obj,p1)
{
	var retVal = "";
	if (preEventCall('cieclg_det1',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cieclg_det1',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cieclg_det1_ONCLICK5(obj,p1)
{
	var retVal = "";
	if (preEventCall('cieclg_det1',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCall('cieclg_det1',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cieclg_det1_ONCHANGE4(obj,p1,p2)
{
        var retVal = "";
        if (preEventCall('cieclg_det1',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = onBlurFormatDate(p1)) == false) {
                return false;
        }
        if ((retVal = fnAssignDateOnEnter(p2)) == false) {
                return false;
        }
        if (postEventCall('cieclg_det1',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cieclg_det1_ONCHANGE5(obj,p1,p2)
{
        var retVal = "";
        if (preEventCall('cieclg_det1',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = onBlurFormatDate(p1)) == false) {
                return false;
        }
        if ((retVal = fnAssignDateOnEnter(p2)) == false) {
                return false;
        }
        if (postEventCall('cieclg_det1',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cieclg_det1_ONCHANGE6(obj,p1,p2)
{
        var retVal = "";
        if (preEventCall('cieclg_det1',obj,'ONCHANGE') == false) {
                return false;
        }
	if ((retVal = fnClearBranchSortCode()) == false) {
                return false;
        }
        if (postEventCall('cieclg_det1',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cieclg_det1_ONCHANGE7(obj,p1,p2)
{
        var retVal = "";
        if (preEventCall('cieclg_det1',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = onBlurFormatDate(p1)) == false) {
                return false;
        }
        if ((retVal = fnAssignDateOnEnter(p2)) == false) {
                return false;
        }
        if (postEventCall('cieclg_det1',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cieclg_det1_ONCHANGE8(obj,p1,p2)
{
        var retVal = "";
        if (preEventCall('cieclg_det1',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = fnGetRejectReasonCodeDesc(p2)) == false) {
                return false;
        }
        if (postEventCall('cieclg_det1',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

