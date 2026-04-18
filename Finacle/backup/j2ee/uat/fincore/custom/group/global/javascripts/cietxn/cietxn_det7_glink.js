
function printBlock()
{
        writeCustomHeader("cietxn_det7");
        with (document){
        write('<input name="' + subGroupName + '.varbiotest" id="varbiotest" ' + cietxnProps.get("varbiotest_ENABLED") + ' type="hidden">');
        write('<input name="' + subGroupName + '.returnValue1" id="returnValue1" ' + cietxnProps.get("returnValue1_ENABLED") + ' type="hidden">');
        write('<input type="hidden" name="tmpAmtField" id="tmpAmtField">');
	write('<input name="' + subGroupName + '.cifIdForSig" id="cifIdForSig" ' + cietxnProps.get("cifIdForSig_ENABLED") + ' type="hidden">');
        write('<input name="' + subGroupName + '.disablePrintFlg" id="disablePrintFlg" ' + cietxnProps.get("disablePrntFlg_ENABLED") + ' type="hidden">');
	write('<input type="hidden" name="' + subGroupName + '.svsTranId" id="svsTranId" >');
        write('<input type="hidden" id="instrumentDate" fdt="fdate" vFldId="instrumentDate_ui" name="' + subGroupName + '.instrumentDate">');
        write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
        write('<tr>');
        write('<td>');
        write('<table border="0" cellspacing="0" cellpadding="0">');
        write('<tr>');
        write('<td class="page-heading">Inter Entity Transaction Maintenance</td>');
        write('</tr>');
        write('</table>');
        write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
        write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000700") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldFunc">' + fnGetFunctionCodeDesc(funcCode) + '</label>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000701") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compFieldTxnType">' + txnTypeDesc + '</label>');
        write('</td>');
        write('</tr>');
        write('</table>');
        write('<br/>');
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
        write('<a href="javascript:showHelpFile(\'det_help.htm\');" anchorCount="0" id="sLnk1">');
        write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21" vspace="1" border="0" alt="View Finacle help" />');
        write('</a>');
        write('</td>');
        write('</tr>');
        write('</table>');
        write('</td>');
        write('</tr>');

	write('<tr id="targetEntity">');
        write('<td class="textlabel">' + jspResArr.get("FLT000717") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.targetEntity" id="targetEntity" ' + cietxnProps.get("targetEntity_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="2" onBlur="javascript:return cietxn_det7_ONBLUR6(this);">&nbsp;');
        write('<a id="targetEntityImg" href="javascript:showEntityList()">');
        write('<img border="0" alt="Search List" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>&nbsp;');
        write('</td>');
        write('<td class="textlabel">');
        write('<input name="' + subGroupName + '.targetEntityDesc" id="targetEntityDesc" ' + cietxnProps.get("targetEntityDesc_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="50" maxlength="50" >&nbsp;');
        write('</td>');
        write('<td class="textfield">');
        write('</td>');
        write('</tr>');

	write('<tr id="drAcctNumRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000702") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.drAcctNum" id="drAcctNum" ' + cietxnProps.get("drAcctNum_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="16" onChange="javascript:return cietxn_det7_ONCHANGE1(this);">&nbsp;');
        write('<a id="drAcctNumImg" href="javascript:getAcctIdList()">');
        write('<img border="0" alt="Search List" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>&nbsp;');
        write('<a id="customExplode1" target="_self" href="JavaScript:fnExplodeBalanceDetails(document.forms[0].targetEntity,document.forms[0].drAcctNum)">');
        write('<img class="img" onmouseover="this.style.cursor=\'hand\';"  onmouseout=" this.style.cursor=\'default\';" src="../Renderer/images/'+applangcode+'/explode.gif" width="16" height="16" border="0" alt="Balance Details" width="24" height="20" onClick=""></img>');
        write('</a>');
        write('&nbsp;<a id="drAcctNumSigImg" href="javascript:showFinacleSignature();">');
        write('<img src="../Renderer/images/' + applangcode + '/sig_new1.gif" alt="' + jspResArr.get("FLT000716") + '" width="16" height="16" border="0"></a>');
        write('</td>');
        write('<td class="textlabel">');
        write('<input name="' + subGroupName + '.drAcctNumEntityId" id="drAcctNumEntityId" ' + cietxnProps.get("drAcctNumEntityId_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="4" maxlength="8" >&nbsp;');
        write('<input name="' + subGroupName + '.drAcctNumSolId" id="drAcctNumSolId" ' + cietxnProps.get("drAcctNumSolId_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="4" maxlength="8" >&nbsp;');
        write('<input name="' + subGroupName + '.drAcctNumCcy" id="drAcctNumCcy" ' + cietxnProps.get("drAcctNumCcy_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="2" maxlength="3" >');
        write('</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.drAcctName" id="drAcctName" ' + cietxnProps.get("drAcctName_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="40" maxlength="80" >');
        write('</td>');
        write('</tr>');

	write('<tr id="creditEntity">');
        write('<td class="textlabel">' + jspResArr.get("FLT000719") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.creditEntity" id="creditEntity" ' + cietxnProps.get("creditEntity_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="2" onBlur="javascript:return cietxn_det7_ONBLUR9(this);">&nbsp;');
        write('<a id="creditEntityImg" href="javascript:showEntityList2()">');
        write('<img border="0" alt="Search List" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>&nbsp;');
        write('</td>');
        write('<td class="textlabel">');
        write('<input name="' + subGroupName + '.creditEntityDesc" id="creditEntityDesc" ' + cietxnProps.get("creditEntityDesc_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="50" maxlength="50" >&nbsp;');
        write('</td>');
        write('<td class="textfield">');
        write('</td>');
        write('</tr>');

        write('<tr id="crAcctNumRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000720") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.crAcctNum" id="crAcctNum" ' + cietxnProps.get("crAcctNum_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="16" onChange="javascript:return cietxn_det7_ONCHANGE2(this);">&nbsp;');
        write('<a id="crAcctNumImg" href="javascript:getAcctIdList2()">');
        write('<img border="0" alt="Search List" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>&nbsp;');
        write('<a id="customExplode1" target="_self" href="JavaScript:fnExplodeBalanceDetails(document.forms[0].creditEntity,document.forms[0].crAcctNum)">');
        write('<img class="img" onmouseover="this.style.cursor=\'hand\';"  onmouseout=" this.style.cursor=\'default\';" src="../Renderer/images/'+applangcode+'/explode.gif" width="16" height="16" border="0" alt="Balance Details" width="24" height="20" onClick=""></img>');
        write('</a>');
        write('</td>');
        write('<td class="textlabel">');
        write('<input name="' + subGroupName + '.crAcctNumEntityId" id="crAcctNumEntityId" ' + cietxnProps.get("crAcctNumEntityId_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="4" maxlength="8" >&nbsp;');
        write('<input name="' + subGroupName + '.crAcctNumSolId" id="crAcctNumSolId" ' + cietxnProps.get("crAcctNumSolId_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="4" maxlength="8" >&nbsp;');
        write('<input name="' + subGroupName + '.crAcctNumCcy" id="crAcctNumCcy" ' + cietxnProps.get("crAcctNumCcy_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="2" maxlength="3" >');
        write('</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.crAcctName" id="crAcctName" ' + cietxnProps.get("crAcctName_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="40" maxlength="80" >');
        write('</td>');
        write('</tr>');

	write('<tr id="refCrncyRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000703") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<input name="' + subGroupName + '.refCrncy" id="refCrncy" ' + cietxnProps.get("refCrncy_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldcode" size="2" maxlength="3" fdt="currency" onBlur="javascript:return cietxn_det7_ONBLUR2(this);" onChange="javascript:return cietxn_det7_ONCHANGE6(this);">&nbsp;');
        write('<a id="sLnk7" href="javascript:getRefCrncyList()">');
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search2"></a>');
        write('<input name="' + subGroupName + '.refAmt" id="refAmt" ' + cietxnProps.get("refAmt_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldamount" size="23" maxlength="23" fdt="amount" onBlur="javascript:return cietxn_det7_ONBLUR3(this);" onChange="javascript:return cietxn_det7_ONCHANGE7(this);">&nbsp;');
        write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000705") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<input name="' + subGroupName + '.tranAmtCcy" id="tranAmtCcy" ' + cietxnProps.get("tranAmtCcy_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="2" maxlength="3" >&nbsp;');
        write('<input name="' + subGroupName + '.tranAmt" id="tranAmt" ' + cietxnProps.get("tranAmt_ENABLED") + ' hotKeyId="search1" type="text" class="label"size="23" maxlength="23" fdt="amount">');
        write('</td>');
        write('</tr>');
	write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000718") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.treaRefNum" id="treaRefNum" ' + cietxnProps.get("treaRefNum_ENABLED") + ' hotKeyId="search1" type="text" class="twotextfieldsearchicon" size="9" maxlength="16" fdt="default">');
        write('&nbsp;<a id="treaRefNumImg" href="javascript:cust_callTrRefNoSearcher(this)">');
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search4"></a>');
        write('&nbsp;<input id="treaRate" name="' + subGroupName + '.treaRate" ' + cietxnProps.get("treaRate_ENABLED") + ' type="text" class="twotextfieldsearchicon" size="9" maxlength="20" fdt="default">');
        write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000704") + '</td>');
        write('<td width="29%" class="textfielddisplaylabel"><input id="rateCode" name="' + subGroupName + '.rateCode" hotKeyId="search1" ' + cietxnProps.get("rateCode_ENABLED") + ' type="text" class="twotextfieldsearchicon" size="9" maxlength="5" onBlur="javascript:return cietxn_det7_ONBLUR4(this);" >');
        write('&nbsp;   <a id="rateCodeImg" href="javascript:getRateCodeList()">');
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search3"></a>');
        write('&nbsp;<input id="rate" name="' + subGroupName + '.rate" ' + cietxnProps.get("rate_ENABLED")+ ' type="text" class="twotextfieldsearchicon" size="9" maxlength="20" onBlur="javascript:return cietxn_det7_ONBLUR5(this);" >');
        write('</td>');
        write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000707") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<input name="' + subGroupName + '.refNo" id="refNo" ' + cietxnProps.get("refNo_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="23" maxlength="20">&nbsp;');
        write('</td>');
        //write('<td class="textlabel">' + jspResArr.get("FLT000706") + '</td>');
	write('<td class="textlabel"></td>');
        write('<td class="textfielddisplaylabel">');
	write('<input name="' + subGroupName + '.chargeAmtCcy" id="chargeAmtCcy" ' + cietxnProps.get("chargeAmtCcy_ENABLED") + ' hotKeyId="search1" type="hidden" class="label" size="2" maxlength="3" >&nbsp;');
        write('<input name="' + subGroupName + '.chargeAmt" id="chargeAmt" ' + cietxnProps.get("chargeAmt_ENABLED") + ' hotKeyId="search1" type="hidden" class="label" size="23" maxlength="23" fdt="amount">');
	write('<input name="' + subGroupName + '.chargeEventId" id="chargeEventId" ' + cietxnProps.get("chargeEventId_ENABLED") + ' type="hidden">');
        write('</td>');
        write('</tr>');

	write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000708") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.nostroAcct" id="nostroAcct" ' + cietxnProps.get("nostroAcct_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="23" maxlength="23">&nbsp;');
        write('<input name="' + subGroupName + '.vostroAcct" id="vostroAcct" ' + cietxnProps.get("vostroAcct_ENABLED") + ' type="hidden">');
        write('</td>');
        write('<td class="textlabel">');
        write('<input name="' + subGroupName + '.nostroAcctName" id="nostroAcctName" ' + cietxnProps.get("nostroAcctName_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="50" maxlength="50" >&nbsp;');
        write('</td>');
        write('</td>');
        write('<td class="textfield">');
        write('</td>');
        write('</tr>');

	write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000711") + '');
        write('<td class="textfield"><input id="instrumentType" name="' + subGroupName + '.instrumentType" ' + cietxnProps.get("instrumentType_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="5">');
	write('&nbsp;<a id="sLnk13" href="javascript:getInstrTypeList(document.forms[0].instrumentType,\'\',\'ctrl\',\'F\')">');
	write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search6"></a>');
        write('</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000712") + '');
        write('<td class="textfield"><input id="instrumentAlpha" name="' + subGroupName + '.instrumentAlpha" ' + cietxnProps.get("instrumentAlpha_ENABLED") + ' type="text" size="6" maxlength="6">');
	write('&nbsp;&nbsp;<input id="instrumentNum" name="' + subGroupName + '.instrumentNum" ' + cietxnProps.get("instrumentNum_ENABLED") + ' type="text" size="18" maxlength="16">');
        write('</td>');
        write('</tr>');

        write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000715") + '</td>');
        write('<td>');
        write('<input  type="text" class="textfieldfont"   onChange="javascript:return cietxn_det7_ONCHANGE3(this,this,this);" name="' + subGroupName + '.instrumentDate_ui" id="instrumentDate_ui"  class="textfieldfont" size="21" maxlength="10" fdt="uidate">&nbsp;');
        write('<a id="sLink3" href="javascript:openDate(document.forms[0].instrumentDate_ui,BODDate)"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
        write('</a>');
        write('</td>');
        write('<td></td>');
        write('<td class="textlabel"></td>');
        write('<td>');
        write('</td>');
        write('</tr>');

        write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000709") + '');
        write('<td class="textfield"><input id="tranParticularsCode" name="' + subGroupName + '.tranParticularsCode" hotKeyId="search5" ' + cietxnProps.get("tranParticularsCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="5">');
        write('&nbsp;<a id="sLnk12" href="javascript:fnShowRefCodeTranCode(document.forms[0].tranParticularsCode,\'DD\',\'N\',\'F\')">');
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search5"></a>');
        write('</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000710") + '');
        write('<td class="textfield"><input id="tranParticular" name="' + subGroupName + '.tranParticular" ' + cietxnProps.get("tranParticular_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="50">');
        write('</td>');
        write('</tr>');

        write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000713") + '');
        write('<td class="textfield"><input id="tranRmks" name="' + subGroupName + '.tranRmks" ' + cietxnProps.get("tranRmks_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="30">');
        write('</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000714") + '');
        write('<td class="textfield"><input id="tranRmks2" name="' + subGroupName + '.tranRmks2" ' + cietxnProps.get("tranRmks2_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="50">');
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
	write('<input id="Submit" name="Submit" type="button" class="button" value="Submit"	onClick="javascript:return cietxn_det7_ONCLICK4(this,this);"" hotKeyId="Submit">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="Cancel"	onClick="javascript:return cietxn_det7_ONCLICK5(this,this.id);"" hotKeyId="Cancel">');
		
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

	pre_ONLOAD('cietxn_det7',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnAssignDateOnLoad(ObjForm);

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnCustDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cietxn_det7',this);

}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.targetEntity.value = targetEntity;
	ObjForm.targetEntityDesc.value = targetEntityDesc;
	ObjForm.drAcctNum.value = drAcctNum;
	ObjForm.drAcctNumEntityId.value = drAcctNumEntityId;
	ObjForm.drAcctNumSolId.value = drAcctNumSolId;
	ObjForm.drAcctNumCcy.value = drAcctNumCcy;
        ObjForm.drAcctName.value = drAcctName;
	ObjForm.creditEntity.value = creditEntity;
        ObjForm.creditEntityDesc.value = creditEntityDesc;
        ObjForm.crAcctNum.value = crAcctNum;
        ObjForm.crAcctNumEntityId.value = crAcctNumEntityId;
        ObjForm.crAcctNumSolId.value = crAcctNumSolId;
        ObjForm.crAcctNumCcy.value = crAcctNumCcy;
        ObjForm.crAcctName.value = crAcctName;
        ObjForm.refCrncy.value = refCrncy;
        ObjForm.refAmt.value = refAmt;
        ObjForm.rateCode.value = rateCode;
        ObjForm.rate.value = rate;
	ObjForm.treaRefNum.value = treaRefNum;
        ObjForm.treaRate.value = treaRate;
	ObjForm.tranAmt.value = tranAmt;
        ObjForm.tranAmtCcy.value = tranAmtCcy;
	ObjForm.chargeEventId.value = chargeEventId;
        ObjForm.chargeAmt.value = chargeAmt;
        ObjForm.chargeAmtCcy.value = chargeAmtCcy;
        ObjForm.refNo.value = refNo;
	ObjForm.nostroAcct.value = nostroAcct;
	ObjForm.nostroAcctName.value = nostroAcctName;
	ObjForm.vostroAcct.value = vostroAcct;
        ObjForm.tranParticularsCode.value = tranParticularsCode;
	ObjForm.tranParticular.value = tranParticular;
	ObjForm.tranRmks.value = tranRmks;
	ObjForm.tranRmks2.value = tranRmks2;

	ObjForm.instrumentType.value = instrumentType;
	ObjForm.instrumentDate.value = instrumentDate;
	ObjForm.instrumentAlpha.value = instrumentAlpha;
	ObjForm.instrumentNum.value = instrumentNum;
	//ObjForm.svsTranId.value = svsTranId;
	ObjForm.returnValue1.value = returnValue1;
	ObjForm.cifIdForSig.value = cifIdForSig;
	ObjForm.disablePrintFlg.value = disablePrintFlg;
	//Added for biometric validation - Dileep
	ObjForm.varbiotest.value = varbiotest;


	fnCheckControls();

}

function fnCheckControls()
{
	var ObjForm = document.forms[0];

}

function cietxn_det7_ONCHANGE1(obj)
{
        var retVal = "";
        if (preEventCall('cietxn_det7',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = fnGetDrAcctDetails()) == false) {
                return false;
        }
        if (postEventCall('cietxn_det7',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cietxn_det7_ONBLUR2(obj)
{
	var retVal = "";
	if (preEventCall('cietxn_det7',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = fnComputeTranAmt(obj)) == false) {
		return false;
	}
	if (postEventCall('cietxn_det7',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

/*function cietxn_det7_ONCHANGE2(obj)
{
        var retVal = "";
        if (preEventCall('cietxn_det7',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = fnComputeTranAmt(obj)) == false) {
                return false;
        }
        if (postEventCall('cietxn_det7',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
*/

function cietxn_det7_ONBLUR6(obj)
{
        var retVal = "";
        if (preEventCall('cietxn_det7',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnGetEntityDesc()) == false) {
                return false;
        }
        if (postEventCall('cietxn_det7',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cietxn_det7_ONBLUR3(obj)
{
        var retVal = "";
        if (preEventCall('cietxn_det7',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnFormatAmountField(obj)) == false) {
                return false;
        }
	if ((retVal = fnComputeTranAmt(obj)) == false) {
                return false;
        }
        if (postEventCall('cietxn_det7',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cietxn_det7_ONBLUR4(obj)
{
        var retVal = "";
        if (preEventCall('cietxn_det7',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnComputeTranAmt(obj)) == false) {
                return false;
        }
        if (postEventCall('cietxn_det7',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cietxn_det7_ONBLUR5(obj)
{
        var retVal = "";
        if (preEventCall('cietxn_det7',obj,'ONBLUR') == false) {
                return false;
        }
	if ((retVal = fnComputeTranAmt(obj)) == false) {
                return false;
        }
        if (postEventCall('cietxn_det7',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cietxn_det7_ONCLICK4(obj,p1)
{
	var retVal = "";
	if (preEventCall('cietxn_det7',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cietxn_det7',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cietxn_det7_ONCLICK5(obj,p1)
{
	var retVal = "";
	if (preEventCall('cietxn_det7',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCall('cietxn_det7',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cietxn_det7_ONCHANGE3(obj,p1,p2)
{
        var retVal = "";
        if (preEventCall('cietxn_det7',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = onBlurFormatDate(p1)) == false) {
                return false;
        }
        if ((retVal = fnAssignDateOnEnter(p2)) == false) {
                return false;
        }
        if (postEventCall('cietxn_det7',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cietxn_det7_ONCHANGE6(obj)
{
        var retVal = "";
        if (preEventCall('cietxn_det7',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = fnResetDenomVariable()) == false) {
                return false;
        }
        if (postEventCall('cietxn_det7',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cietxn_det7_ONCHANGE7(obj)
{
        var retVal = "";
        if (preEventCall('cietxn_det7',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = fnResetDenomVariable()) == false) {
                return false;
        }
        if (postEventCall('cietxn_det7',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cietxn_det7_ONBLUR9(obj)
{
        var retVal = "";
        if (preEventCall('cietxn_det7',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnGetEntityDesc2(obj)) == false) {
                return false;
        }
        if (postEventCall('cietxn_det7',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cietxn_det7_ONCHANGE2(obj)
{
        var retVal = "";
        if (preEventCall('cietxn_det7',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = fnGetCrAcctDetails()) == false) {
                return false;
        }
        if (postEventCall('cietxn_det7',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
