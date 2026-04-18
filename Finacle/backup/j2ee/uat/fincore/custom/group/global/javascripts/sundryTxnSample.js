function fnOnLoad() {	
	fnPopulateControlValues();
	fnPopUpExceptionWindow(frm.actionCode);
	checkRadio(frm.pTranType,frm.pTranType.value);
	fnEnableDisableRadioButtons(frm.pTranType,'D');
}

function locfnPopUpExceptionWindow()
{
	if (sPopUpExceptionWindow.toUpperCase() != 'TRUE') return;
	var retVal =	popModalWindowVar("../arjspmorph/"+applangcode+"/excp_popup_screen.jsp?wReturn=submitform", "excp_popup_screen","50","50","50","23");
	if (retVal != null && retVal != undefined && ((retVal =='Submit')||(retVal == 'Refer')||(retVal == 'RefSubmit')))
	{
		frm.submitform.value = retVal;
		fnAssignDateOnLoad(document.forms[0]);
		if (retVal== 'Submit'){
			frm.callMode.value = 'N';
		}
		var btnObj = frm.Post;
		if (xcpnMode != "") {
			btnObj = eval("frm."+xcpnMode);
		}else if (funcCode == 'A' || funcCode == 'M') {
			btnObj = frm.Save;
		}
		btnObj.click();
	}
}

function locfndoRefSubmit(objButton){
	if (funcCode == 'P')
	doSubmit("Submit");
	else
	doSubmit("Post");
}

function fnOnClick(objButton) {
	frm.IsPageEmpty.value = false;
	frm.actionCode.value = objButton.id;
	frm.submit();
}

function printBlock()
{
	writeHeader("tmdet");
	with (document) {
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">'+menuTitle+'');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td class="textlabel2">Function');
	write('</td>');
	write('<td class="textfielddisplaylabel">');
	write('' + fnGetFuncCodeDesc(funcCode) + '');
	write('</td>');
	write('<td class="textlabel2">Initiating SOL ID');
	write('</td>');
	write('<td class="textfielddisplaylabel">');
	write('' + initSolId + ' ' + initSolDesc + '');
	write('</td>');
	write('<td class="textlabel2">Tran. Type/Sub Type');
	write('</td>');
	write('<td class="textfielddisplaylabel2">');
	write('' + tranType + '/' + tranSubType + ' - ' + fnGetTranTypeSubTypeDesc(tranType,tranSubType) + '');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel2">Tran. ID');
	write('</td>');
	write('<td class="textfielddisplaylabel2">');
	write('' + tranId + '' + tmplId + '');
	write('</td>');
	write('<td class="textlabel2">Tran. Date');
	write('</td>');
	write('<td class="textfielddisplaylabel2">');
	write('' + tranDate + '');
	write('</td>');
	write('<td class="textlabel2">Tran. Remarks');
	write('</td>');
	write('<td class="textfielddisplaylabel2">');
	write('' + remarks + '');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0"class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr class="innertabletop1">');
	write('<td colspan="5" align="right">');
	write('<table width="100%" border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td>Tran. Status : ' + getStatus(tranStatus) + '</td>');
	write('<td align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right"><a href="javascript:showHelpFile(\'tmdet_help.htm\');" id="sLnk1">');
	write('<img hotKeyId="finHelp" src="../Renderer/images/help.gif" width="47" height="21" vspace="1" border="0">');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr class="subhdrbg">');
	write('<td width="28%" class="textlabel">');
	write('Part Tran. Type');
	write('</td>');
	write('<td width="22%" class="textfielddisplaylabel">');
	write('<input type="radio" id="pTranType" fmb="N" fdt="default" fblk="pTranBlk" name="tm.pTranType" value="D" >');
	write('Dr.');
	write('<input id="pTranType"  fmb="N" fdt="default" fblk="pTranBlk" name="tm.pTranType" type="radio" value="C" selected>');
	write('Cr.');
	write('<input id="pTranType"  fmb="N" fdt="default" fblk="pTranBlk" name="tm.pTranType" type="radio" value="O" selected>');
	write('Contra');
	write('</td>');
	write('<td colspan="4">&nbsp;');
	write('</td>');
	write('</tr>');
	write('<tr class="rowspacing">');
	write('<td colspan="5">');
	write('<spacer type="block" height="1" width="1"></spacer>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">');
	write('A/c. ID');
	write('</td>');
	write('<td colspan="4" class="textfield">');
	write('<input id="acctId"  fmnd="Y" fmb="N" fdt="default" disabled fblk="pTranBlk" name="tm.acctId" hotKeyId="search1" explodeId="explode1" type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('&nbsp;');
	write('<a href="javascript:getAcctIdList();" id="sLnk4">');
	write('<img hotKeyId="search1" src="../images/search_icon.gif" width="16" height="17" border="0"></a>');
	write('&nbsp;&nbsp;');
	write('<a href="javascript:showAcctDetails();" id="sLnk5">');
	write('<img explodeId="explode1" src="../images/explode.gif" width="16" height="16" border="0"></a>');
	write('&nbsp;&nbsp;');
	write('<input id="acctLabelCrncy"  fds="N" fblk="pTranBlk" name="tm.acctLabelCrncy" type="text" disabled="true" class="labelwithoutwidth" value="" size="3" maxlength="3">');
	write('<input id="acctSolId"  fds="N" fblk="pTranBlk" name="tm.acctSolId" type="text" disabled="true" class="labelwithoutwidth" value="" size="8" maxlength="8">');
	write('<input id="acctName"  fds="N" fblk="pTranBlk" name="tm.acctName" type="text" disabled="true" class="label" value="" size="25" maxlength="25">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">');
	write('Ref. CCY/Amt.');
	write('</td>');
	write('<td class="textfielddisplaylabel">');
	write('<input id="refCrncy" readonly fmnd="Y" fmb="N" fdt="currency" fblk="pTranBlk" name="tm.refCrncy" hotKeyId="search2" type="TEXT" class="textfieldcode" size="2" maxlength="3" >');
	write('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
	write('<input id="refAmt" fmb="N" fdt="amount" fblk="pTranBlk" name="tm.refAmt" type="TEXT" class="textfieldamount" size="22" maxlength="17" >');
	write('</td>');
	write('<td class="coloumnwidth">&nbsp;');
	write('</td>');
	write('<td width="20%" class="textlabel">');
	write('Rate Code/Rate');
	write('</td>');
	write('<td width="29%" class="textfielddisplaylabel">');
	write('<input id="rateCode" fmb="N" fdt="default" disabled fblk="pTranBlk" name="tm.rateCode" hotKeyId="search3" type="TEXT" class="twotextfieldsearchicon" size="9" maxlength="5" >');
	write('&nbsp;');
	write('<a href="javascript:getRateCodeList();" id="sLnk10">');
	write('<img hotKeyId="search3" src="../images/search_icon.gif" width="16" height="17" border="0"></a>');
	write('&nbsp;');
	write('<input id="rate" fmb="N" fdt="default" fblk="ptranBlk" disabled name="tm.rate" type="TEXT" class="twotextfieldsearchicon" size="9" maxlength="20" >');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">');
	write('Value Date/GL Date');
	write('</td>');
	write('<td class="textfield">');
	write('<input  type="TEXT"  size="10" maxlength="10" id="valueDate" hotKeyId="calender1" fdt="uidate" mnebl="false" name="tm.valueDate" class="twotextfielddatepickericon" fmnd="Y" >');
	write('&nbsp;');
	write('<img  id="daysOfMonthPos" name="tm.daysOfMonthPos" width="24" height="19" src="../images/calender.gif" align="absmiddle" border="0" style="cursor:hand" class="img" hotKeyId="calender1"></a>');
	write('<input id="glDate"  fmnd="Y" disabled fmb="N" fdt="date" fblk="pTranBlk" name="tm.glDate" type="TEXT" class="twotextfielddatepickericon" size="9" maxlength="5" >');
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
	} 
}

function printFooterBlock()
{
    with (document) {
    if ((sReferralMode == 'I')||(sReferralMode == 'S')){
    	if (sReferralMode == 'S'){
    	write('<input type="button" class="Button" id="Submit" value="Submit" onClick="javascript:return doRefSubmit(this);"  hotKeyId="Submit" >');
    	}
    writeRefFooter();
    write('<input type="button" class="Button" id="_BackRef_" value="Back" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
    }else{
    	write('<input type="button" name="Post" class="button" onClick="fnOnClick(this)" hotKeyId="post" id="Post" value="Post">');
    	write('<input type="button" name="Cancel"  class="button" onClick="fnOnClick(this)" hotKeyId="Cancel" id="Cancel" value="Cancel">');
    }
  }
} 

