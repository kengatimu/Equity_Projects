function printBlock()
{
        writeCustomHeader("cierev_det");
        with (document){
        write('<input type="hidden" name="tmpAmtField" id="tmpAmtField">');
	write('<input type="hidden" name="ieTxnRefNo" id="ieTxnRefNo">');
	write('<input type="hidden" name="entity1TranId" id="chargeTranId">');
        write('<input type="hidden" name="entity1TranDate" id="chargeTranDate">');
	write('<input type="hidden" name="entity2TranId" id="chargeTranId">');
        write('<input type="hidden" name="entity2TranDate" id="chargeTranDate">');
	write('<input type="hidden" name="chargeTranId" id="chargeTranId">');
	write('<input type="hidden" name="chargeTranDate" id="chargeTranDate">');
	write('<input type="hidden" id="instrumentDate" fdt="fdate" vFldId="instrumentDate_ui" name="' + subGroupName + '.instrumentDate">');
        write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
        write('<tr>');
        write('<td>');
        write('<table border="0" cellspacing="0" cellpadding="0">');
        write('<tr>');
        write('<td class="page-heading">Inter Entity Transaction Reversal</td>');
        write('</tr>');
        write('</table>');
        write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
        write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000700") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldFunc">' + fnGetFunctionCodeDesc(funcCode) + '</label>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compFieldTxnType"></label>');
        write('</td>');
        write('</tr>');
	write('<tr>');
        write('<td class="textlabel">Transaction Ref No.</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldFunc">'+ieTxnRefNo+'</label>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000701") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compFieldTxnType">' + txnTypeDesc + '</label>');
        write('</td>');
        write('</tr>');
	write('<tr>');
        write('<td class="textlabel">Init Entity Transaction ID</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldFunc">'+entity1TranId+' / '+entity1TranDate+'</label>');
        write('</td>');
        write('<td class="columnwidth"></td>');
	write('<td class="textlabel">Target Entity Transaction ID</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldFunc">'+entity2TranId+' / '+entity2TranDate+'</label>');
        write('</td>');
        write('</tr>');
	write('<tr>');
        write('<td class="textlabel">Charge Event Id</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldFunc">'+chargeEventId+'</label>');
        write('</td>');
        write('<td class="columnwidth"></td>');
        write('<td class="textlabel">Charge Transaction ID</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label align="left"id="compFieldFunc">'+chargeTranId+' / '+chargeTranDate+'</label>');
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

	write('<tr id="debitEntityRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000718") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.debitEntity" id="debitEntity" ' + cierevProps.get("debitEntity_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="2" onBlur="javascript:return cierev_det_ONBLUR8(this);">&nbsp;');
        write('</td>');
        write('<td class="textlabel">');
        write('<input name="' + subGroupName + '.debitEntityDesc" id="debitEntityDesc" ' + cierevProps.get("debitEntityDesc_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="50" maxlength="50" >&nbsp;');
        write('</td>');
        write('<td class="textfield">');
        write('</td>');
        write('</tr>');

	write('<tr id="drAcctNumRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000715") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.drAcctNum" id="drAcctNum" ' + cierevProps.get("drAcctNum_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="16" onChange="javascript:return cierev_det_ONCHANGE1(this);">&nbsp;');
	write('<a id="customExplode1"  target="_self" href="JavaScript:fnExplodeBalanceDetails(document.forms[0].drAcctNum)">');
        write('<img class="img" onmouseover="this.style.cursor=\'hand\';"  onmouseout=" this.style.cursor=\'default\';" src="../Renderer/images/'+applangcode+'/explode.gif" width="16" height="16" border="0" alt="Balance Details" width="24" height="20" onClick=""></img>');
        write('</a>');
	write('&nbsp;<a id="drAcctNumSigImg" href="javascript:showFinacleSignature();">');
        write('<img src="../Renderer/images/' + applangcode + '/sig_new1.gif" alt="' + jspResArr.get("FLT000716") + '" width="16" height="16" border="0"></a>');
        write('</td>');
        write('<td class="textlabel">');
	write('<input name="' + subGroupName + '.drAcctNumEntityId" id="drAcctNumEntityId" ' + cierevProps.get("drAcctNumEntityId_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="4" maxlength="8" >&nbsp;');
	write('<input name="' + subGroupName + '.drAcctNumSolId" id="drAcctNumSolId" ' + cierevProps.get("drAcctNumSolId_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="4" maxlength="8" >&nbsp;');
	write('<input name="' + subGroupName + '.drAcctNumCcy" id="drAcctNumCcy" ' + cierevProps.get("drAcctNumCcy_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="2" maxlength="3" >');
	write('</td>');
	write('<td class="textfield">');
	write('<input name="' + subGroupName + '.drAcctName" id="drAcctName" ' + cierevProps.get("drAcctName_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="40" maxlength="80" >');
        write('</td>');
        write('</tr>');

	write('<tr id="creditEntityRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000719") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.creditEntity" id="creditEntity" ' + cierevProps.get("creditEntity_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="2" onBlur="javascript:return cierev_det_ONBLUR9(this);">&nbsp;');
        write('</td>');
        write('<td class="textlabel">');
        write('<input name="' + subGroupName + '.creditEntityDesc" id="creditEntityDesc" ' + cierevProps.get("creditEntityDesc_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="50" maxlength="50" >&nbsp;');
        write('</td>');
        write('<td class="textfield">');
        write('</td>');
        write('</tr>');

	write('<tr id="crAcctNumRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000702") + '</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.crAcctNum" id="crAcctNum" ' + cierevProps.get("crAcctNum_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="24" maxlength="16" onChange="javascript:return cierev_det_ONCHANGE2(this);">&nbsp;');
	write('<a id="customExplode1"  target="_self" href="JavaScript:fnExplodeBalanceDetails(document.forms[0].crAcctNum)">');
        write('<img class="img" onmouseover="this.style.cursor=\'hand\';"  onmouseout=" this.style.cursor=\'default\';" src="../Renderer/images/'+applangcode+'/explode.gif" width="16" height="16" border="0" alt="Balance Details" width="24" height="20" onClick=""></img>');
        write('</a>');
        write('</td>');
        write('<td class="textlabel">');
        write('<input name="' + subGroupName + '.crAcctNumEntityId" id="crAcctNumEntityId" ' + cierevProps.get("crAcctNumEntityId_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="4" maxlength="8" >&nbsp;');
        write('<input name="' + subGroupName + '.crAcctNumSolId" id="crAcctNumSolId" ' + cierevProps.get("crAcctNumSolId_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="4" maxlength="8" >&nbsp;');
        write('<input name="' + subGroupName + '.crAcctNumCcy" id="crAcctNumCcy" ' + cierevProps.get("crAcctNumCcy_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="2" maxlength="3" >');
        write('</td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.crAcctName" id="crAcctName" ' + cierevProps.get("crAcctName_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="40" maxlength="80" >');
        write('</td>');
        write('</tr>');

	write('<tr id="refCrncyRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000703") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<input name="' + subGroupName + '.refCrncy" id="refCrncy" ' + cierevProps.get("refCrncy_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldcode" size="2" maxlength="3" fdt="currency" onBlur="javascript:return cierev_det_ONBLUR3(this);" onChange="javascript:return cierev_det_ONCHANGE4(this);">&nbsp;');
	write('<input name="' + subGroupName + '.refAmt" id="refAmt" ' + cierevProps.get("refAmt_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldamount" size="23" maxlength="23" fdt="amount" onBlur="javascript:return cierev_det_ONBLUR7(this);">&nbsp;');
        write('</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000704") + '</td>');
	write('<td width="29%" class="textfielddisplaylabel"><input id="rateCode" name="' + subGroupName + '.rateCode" hotKeyId="search1" ' + cierevProps.get("rateCode_ENABLED") + ' type="text" class="twotextfieldsearchicon" size="9" maxlength="5" onBlur="javascript:return cierev_det_ONBLUR6(this);" >');
        write('&nbsp;<input id="rate" name="' + subGroupName + '.rate" ' + cierevProps.get("rate_ENABLED")+ ' type="text" class="twotextfieldsearchicon" size="9" maxlength="20" onBlur="javascript:return cierev_det_ONBLUR5(this);" >');
        write('</td>');
        write('</tr>');

	write('<tr id="refCrncyRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000705") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<input name="' + subGroupName + '.tranAmt" id="tranAmt" ' + cierevProps.get("tranAmt_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="23" maxlength="23" fdt="amount">&nbsp;');
	write('<input name="' + subGroupName + '.tranAmtCcy" id="tranAmtCcy" ' + cierevProps.get("tranAmtCcy_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="2" maxlength="3" >');
        write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000706") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<input name="' + subGroupName + '.chargeAmt" id="chargeAmt" ' + cierevProps.get("chargeAmt_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="23" maxlength="23" fdt="amount">&nbsp;');
	write('<input name="' + subGroupName + '.chargeAmtCcy" id="chargeAmtCcy" ' + cierevProps.get("chargeAmtCcy_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="2" maxlength="3" >');
	write('<input name="' + subGroupName + '.chargeEventId" id="chargeEventId" ' + cierevProps.get("chargeEventId_ENABLED") + ' type="hidden">');
        write('</td>');
	write('</tr>');

	write('<tr id="refCrncyRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000707") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<input name="' + subGroupName + '.refNo" id="refNo" ' + cierevProps.get("refNo_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="23" maxlength="20">&nbsp;');
        write('</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000708") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<input name="' + subGroupName + '.nostroAcct" id="nostroAcct" ' + cierevProps.get("nostroAcct_ENABLED") + ' hotKeyId="search1" type="text" class="textfieldfont" size="23" maxlength="23">&nbsp;');
	write('<input name="' + subGroupName + '.vostroAcct" id="vostroAcct" ' + cierevProps.get("vostroAcct_ENABLED") + ' type="hidden">');
        write('</td>');
        write('</tr>');

	write('<tr id="instrumentTypeRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000711") + '');
        write('<td class="textfield"><input id="instrumentType" name="' + subGroupName + '.instrumentType" ' + cierevProps.get("instrumentType_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="5">');
        write('</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000712") + '');
        write('<td class="textfield"><input id="instrumentAlpha" name="' + subGroupName + '.instrumentAlpha" ' + cierevProps.get("instrumentAlpha_ENABLED") + ' type="text" size="6" maxlength="6">');
        write('&nbsp;&nbsp;<input id="instrumentNum" name="' + subGroupName + '.instrumentNum" ' + cierevProps.get("instrumentNum_ENABLED") + ' type="text" size="18" maxlength="16">');
        write('</td>');
        write('</tr>');

        write('<tr id="instrumentDateRow">');
        write('<td class="textlabel">' + jspResArr.get("FLT000717") + '</td>');
        write('<td>');
        write('<input  type="text" class="textfieldfont"   onChange="javascript:return cierev_det2_ONCHANGE10(this,this,this);" name="' + subGroupName + '.instrumentDate_ui" id="instrumentDate_ui"  class="textfieldfont" size="21" maxlength="10" fdt="uidate">&nbsp;');
        write('</td>');
        write('<td></td>');
        write('<td class="textlabel"></td>');
        write('<td>');
        write('</td>');
        write('</tr>');

	write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000709") + '');
        write('<td class="textfield"><input id="tranParticularsCode" name="' + subGroupName + '.tranParticularsCode" hotKeyId="search5" ' + cierevProps.get("tranParticularsCode_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="5">');
        write('</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000710") + '');
        write('<td class="textfield"><input id="tranParticular" name="' + subGroupName + '.tranParticular" ' + cierevProps.get("tranParticular_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="50">');
        write('</td>');
        write('</tr>');

	write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT000713") + '');
        write('<td class="textfield"><input id="tranRmks" name="' + subGroupName + '.tranRmks" ' + cierevProps.get("tranRmks_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="30">');
        write('</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000714") + '');
        write('<td class="textfield"><input id="tranRmks2" name="' + subGroupName + '.tranRmks2" ' + cierevProps.get("tranRmks2_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="50">');
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
	write('<input id="Submit" name="Submit" type="button" class="button" value="Submit"	onClick="javascript:return cierev_det_ONCLICK4(this,this);"" hotKeyId="Submit">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="Cancel"	onClick="javascript:return cierev_det_ONCLICK5(this,this.id);"" hotKeyId="Cancel">');
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

	pre_ONLOAD('cierev_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnAssignDateOnLoad(ObjForm);

	if(funcCode =='R' || funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnCustDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cierev_det',this);

}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.debitEntity.value = debitEntity;
        ObjForm.debitEntityDesc.value = debitEntityDesc;
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
	ObjForm.tranAmt.value = tranAmt;
        ObjForm.tranAmtCcy.value = tranAmtCcy;
	ObjForm.chargeEventId.value = chargeEventId;
        ObjForm.chargeAmt.value = chargeAmt;
        ObjForm.chargeAmtCcy.value = chargeAmtCcy;
        ObjForm.refNo.value = refNo;
	ObjForm.nostroAcct.value = nostroAcct;
	ObjForm.vostroAcct.value = vostroAcct;
        ObjForm.tranParticularsCode.value = tranParticularsCode;
	ObjForm.tranParticular.value = tranParticular;
	ObjForm.tranRmks.value = tranRmks;
	ObjForm.tranRmks2.value = tranRmks2;

	ObjForm.instrumentType.value = instrumentType;
        ObjForm.instrumentDate.value = instrumentDate;
        ObjForm.instrumentAlpha.value = instrumentAlpha;
        ObjForm.instrumentNum.value = instrumentNum;

	ObjForm.ieTxnRefNo.value = ieTxnRefNo;
	ObjForm.entity1TranId.value = entity1TranId;
        ObjForm.entity1TranDate.value = entity1TranDate;
	ObjForm.entity2TranId.value = entity2TranId;
        ObjForm.entity2TranDate.value = entity2TranDate;
	ObjForm.chargeTranId.value = chargeTranId;
	ObjForm.chargeTranDate.value = chargeTranDate;

	fnCheckControls();

}

function fnCheckControls()
{
	var ObjForm = document.forms[0];

}

function cierev_det_ONCHANGE1(obj)
{
        var retVal = "";
        if (preEventCall('cierev_det',obj,'ONCHANGE') == false) {
                return false;
        }
        if (postEventCall('cierev_det',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cierev_det_ONCHANGE2(obj)
{
	var retVal = "";
	if (preEventCall('cierev_det',obj,'ONBLUR') == false) { 
		return false;
	}
	if (postEventCall('cierev_det',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cierev_det_ONBLUR3(obj)
{
	var retVal = "";
	if (preEventCall('cierev_det',obj,'ONBLUR') == false) { 
		return false;
	}
	if (postEventCall('cierev_det',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cierev_det_ONCHANGE4(obj)
{
        var retVal = "";
        if (preEventCall('cierev_det',obj,'ONCHANGE') == false) {
                return false;
        }
        if (postEventCall('cierev_det',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cierev_det_ONBLUR5(obj)
{
        var retVal = "";
        if (preEventCall('cierev_det',obj,'ONBLUR') == false) {
                return false;
        }
        if (postEventCall('cierev_det',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cierev_det_ONBLUR6(obj)
{
        var retVal = "";
        if (preEventCall('cierev_det',obj,'ONBLUR') == false) {
                return false;
        }
        if (postEventCall('cierev_det',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cierev_det_ONBLUR7(obj)
{
        var retVal = "";
        if (preEventCall('cierev_det',obj,'ONBLUR') == false) {
                return false;
        }
        if (postEventCall('cierev_det',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cierev_det_ONBLUR8(obj)
{
        var retVal = "";
        if (preEventCall('cierev_det',obj,'ONBLUR') == false) {
                return false;
        }
        if (postEventCall('cierev_det',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cierev_det_ONBLUR9(obj)
{
        var retVal = "";
        if (preEventCall('cierev_det',obj,'ONBLUR') == false) {
                return false;
        }
        if (postEventCall('cierev_det',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cierev_det_ONCHANGE10(obj,p1,p2)
{
        var retVal = "";
        if (preEventCall('cierev_det',obj,'ONCHANGE') == false) {
                return false;
        }
        if (postEventCall('cierev_det',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cierev_det_ONCLICK4(obj,p1)
{
	var retVal = "";
	if (preEventCall('cierev_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cierev_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cierev_det_ONCLICK5(obj,p1)
{
	var retVal = "";
	if (preEventCall('cierev_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCall('cierev_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
