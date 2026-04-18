function printBlock()
{
	writeCustomHeader("cacli_det");
	with (document){
	write('<input type="hidden" name="cacli.accountID" id="accountID">')
	write('<input type="hidden" name="cacli.ccySolID" id="ccySolID">');
	write('<input type="hidden" name="cacli.acctName" id="acctName">');
	write('<input type="hidden" name="cacli.glSubhead" id="glSubhead">');
	write('<input type="hidden" name="cacli.balance" id="balance">');
	write('<input type="hidden" name="cacli.openingBal" id="openingBal">');
	write('<input type="hidden" name="cacli.closingBal" id="closingBal">');
	write('<input type="hidden" name="cacli.floatBal" id="floatBal">');
	write('<input type="hidden" name="cacli.fundsInClearing" id="fundsInClearing">');
	write('<input type="hidden" name="cacli.availAmt" id="availAmt">');
	write('<input type="hidden" name="cacli.effAvailAmt" id="effAvailAmt">');
	write('<input type="hidden" name="cacli.customerStat" id="customerStat">');
	write('<input type="hidden" name="cacli.acctOpenDate" id="acctOpenDate">');
	write('<input type="hidden" name="cacli.acctStatus" id="acctStatus">');
	write('<input type="hidden" name="cacli.acctStatusDate" id="acctStatusDate">');
	write('<input type="hidden" name="cacli.purgeDate" id="purgeDate">');
	write('<input type="hidden" name="cacli.address1" id="address1">');
	write('<input type="hidden" name="cacli.address2" id="address2">');
	write('<input type="hidden" name="cacli.address3" id="address3">');
	write('<input type="hidden" name="cacli.city" id="city">');
	write('<input type="hidden" name="cacli.state" id="state">');
	write('<input type="hidden" name="cacli.country" id="country">');
	write('<input type="hidden" name="cacli.postalCode" id="postalCode">');
	write('<input type="hidden" name="cacli.phoneType" id="phoneType">');
	write('<input type="hidden" name="cacli.telexNo" id="telexNo">');
	write('<input type="hidden" name="cacli.phoneNo" id="phoneNo">');
	write('<input type="hidden" name="cacli.emailType" id="emailType">');
	write('<input type="hidden" name="cacli.emailID" id="emailID">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT003425") + '</td>');
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
	write('<td class="textlabel" style="height: 15px; width: 174px">' + jspResArr.get("FLT031293") + '</td>');
	write('<td class="textfield" style="width: 177px">');
	write('<label id="compField">' + accountID + '</label>');
	write('</td>');
	write('<td class="columnwidth" style="width: 90px"></td>');
	write('<td class="textlabel" style="width: 132px">' + jspResArr.get("FLT023162") + '</td>');
	write('<td class="textfield">');
	write('<label id="compField">' + ccySolID + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031294") + '</td>');
	write('<td class="textfield">');
	write('<label id="compField">' + acctName + '</label>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel"></td>');
	write('<td class="textfield"></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT028540") + '</td>');
	write('<td>');
	write('<label id="compField">' + glSubhead + '</label>');
	write('</td>');
	write('<td style="height: 10px"></td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT023367") + '</td>');
	write('<td>');
	write('<label id="compField">' + balance + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT021458") + '</td>');
	write('<td>');
	write('<label id="compField">' + openingBal + '</label>');
	write('</td>');
	write('<td style="height: 11px"></td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT021455") + '</td>');
	write('<td>');
	write('<label id="compField">' + closingBal + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT019672") + '</td>');
	write('<td>');
	write('<label id="compField">' + floatBal + '</label>');
	write('</td>');
	write('<td style="height: 8px"></td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT011531") + '</td>');
	write('<td>');
	write('<label id="compField">' + fundsInClearing + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT009564") + '</td>');
	write('<td>');
	write('<label id="compField">' + availAmt + '</label>');
	write('</td>');
	write('<td style="height: 12px"></td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT023060") + '</td>');
	write('<td>');
	write('<label id="compField">' + effAvailAmt + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT025099") + '</td>');
	write('<td>');
	write('<label id="compField">' + customerStat + '</label>');
	write('</td>');
	write('<td style="height: 10px"></td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT019062") + '</td>');
	write('<td>');
	write('<label id="compField">' + acctOpenDate + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT014475") + '</td>');
	write('<td>');
	write('<label id="compField">' + acctStatus + '</label>');
	write('</td>');
	write('<td style="height: 11px"></td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT014298") + '</td>');
	write('<td>');
	write('<label id="compField">' + acctStatusDate + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT005157") + '</td>');
	write('<td>');
	write('<label id="compField">' + purgeDate + '</label>');
	write('</td>');
	write('<td style="height: 10px"></td>');
	write('<td></td>');
	write('<td></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT006227") + '</td>');
	write('<td>');
	write('<label id="compField">' + address1 + '</label>');
	write('</td>');
	write('<td style="height: 11px"></td>');
	write('<td></td>');
	write('<td></td>');
	write('</tr>');
	write('<tr>');
	write('<td></td>');
	write('<td>');
	write('<label id="compField">' + address2 + '</label>');
	write('</td>');
	write('<td style="height: 11px"></td>');
	write('<td></td>');
	write('<td></td>');
	write('</tr>');
	write('<tr>');
	write('<td></td>');
	write('<td>');
	write('<label id="compField">' + address3 + '</label>');
	write('</td>');
	write('<td style="height: 12px"></td>');
	write('<td></td>');
	write('<td></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT006216") + '</td>');
	write('<td>');
	write('<label id="compField">' + city + '</label>');
	write('</td>');
	write('<td style="height: 11px"></td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT006217") + '</td>');
	write('<td>');
	write('<label id="compField">' + state + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT006459") + '</td>');
	write('<td>');
	write('<label id="compField">' + country + '</label>');
	write('</td>');
	write('<td style="height: 12px"></td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT018571") + '</td>');
	write('<td>');
	write('<label id="compField">' + postalCode + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT024765") + '</td>');
	write('<td>');
	write('<label id="compField">' + phoneType + '</label>');
	write('</td>');
	write('<td style="height: 12px"></td>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT000165") + '</td>');
	write('<td>');
	write('<label id="compField">' + telexNo + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT008279") + '</td>');
	write('<td>');
	write('<label id="compField">' + phoneNo + '</label>');
	write('</td>');
	write('<td style="height: 13px"></td>');
	write('<td></td>');
	write('<td></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT024764") + '</td>');
	write('<td>');
	write('<label id="compField">' + emailType + '</label>');
	write('</td>');
	write('<td style="height: 14px"></td>');
	write('<td></td>');
	write('<td></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT008417") + '</td>');
	write('<td>');
	write('<label id="compField">' + emailID + '</label>');
	write('</td>');
	write('<td style="height: 15px"></td>');
	write('<td></td>');
	write('<td></td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('<tr>');
	write('<td height="25" colspan="5" align="right">');
	write('<table border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td align="right">');
	write('<a>');
	if(CurrentPage<=1){
	write('<img src="../Renderer/images/'+applangcode+'/arrowgraypre.gif" width="7" height="14" border="0" name="prevpage" id="prevpage">');
	}else	{
	write('<img  hotKeyId="Prev" src="../Renderer/images/'+applangcode+'/arrowpre.gif" width="7" height="14" border="0" id="prevpage" name="prevpage" onClick="javascript:doSubmit(this.id);" onMouseOver="displayHand(this)">');
	}
	write('</a>');
	write('</td>');
	write('<td>Page</td>');
	write('<td>' + CurrentPage + '</td>');
	write('<td>of ' + MaxPage + '</td>');
	write('<td>');
	write('<a>');
	write('<img  hotKeyId="Next" src="../Renderer/images/'+applangcode+'/arrownext.gif" id="nextpage" name="nextpage" width="7" height="14" border="0" onClick="javascript:fnCheckForNull(this);" onMouseOver="displayHand(this)">');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('<tr>');
	write('<td colspan="5">');
	write('<table width="100%">');
	write('<tr>');
	write('<td class="searcheader1a" style="width: 138px">');
	write('<p align="center">General Ledger Date</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">Value Date</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">Instrument No.</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">Withdrawal Amt.</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">Deposit Amt.</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">Balance</p>');
	write('</td>');
	write('<td class="searcheader" style="width: 278px">');
	write('<p align="center">Narrative</p>');
	write('</td>');
	write('</tr>');
	
	
	 if(CurrentSetSize>0){
	      for(iIndex=0;iIndex<ListMaxDisplay;iIndex++)
	      {
      	startRecord = startRecord + iIndex;
	write('<tr>');
	write('<td>');
	write('<p align="left">');
	write('<a href="javascript:fnShowTranDetails(document.forms[0].rowNum[' + iIndex + '])">');

	write('<input type="text" class="textfieldfont"  name="' + subGroupName + '.glDate" id="glDate" ' + cacliProps.get("glDate_ENABLED") + ' style="width: 138px;color:#0000FF;text-decoration: underline">');
	write('</a>');
	write('</p>');
	write('</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.valueDate" id="valueDate" ' + cacliProps.get("valueDate_ENABLED") + ' style="width: 89px">');
	write('</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.instrNo" id="instrNo" ' + cacliProps.get("instrNo_ENABLED") + ' style="width: 77px">');
	write('</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" style="TEXT-ALIGN:right" name="' + subGroupName + '.withdrawalAmt" id="withdrawalAmt" ' + cacliProps.get("withdrawalAmt_ENABLED") + ' style="width: 150px">');
	write('</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" style="TEXT-ALIGN:right" name="' + subGroupName + '.depositAmt" id="depositAmt" ' + cacliProps.get("depositAmt_ENABLED") + ' style="width: 150px">');
	write('</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" style="TEXT-ALIGN:right" name="' + subGroupName + '.balanceAmt" id="balanceAmt" ' + cacliProps.get("balanceAmt_ENABLED") + ' style="width: 150px">');
	write('</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.narrative" id="narrative" ' + cacliProps.get("narrative_ENABLED") + ' style="width: 277px">');
	write('</td>');
	write('<td>');
	write('<input type="hidden" name="' + subGroupName + '.rowNum" id="rowNum" ' + cacliProps.get("rowNum_ENABLED") + ' style="width: 89px">');
	write('</td>');
	write('</tr>');
	
	}
        }
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<tr>');
	write('<tr>');
	write('<tr>   </tr>');
	write('<tr>   </tr>');
	write('</tr>');
	write('</tr>');
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
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Ok" name="Ok" type="button" class="button" value="' + jspResArr.get("FLT030726") + '"	onClick="javascript:return cacli_det_ONCLICK1(this);"" / hotKeyId="Go">');
	}else{
	write('<div class="ctable">');
	write('<input class="button" type="button" id="Back" value="'+jspResArr.get("FLT026526")+ '" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('cacli_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormDataControls('V',ObjForm,0);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cacli_det',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	
	if(iListMaxDisplay==1)
	{
		ObjForm.rowNum.value=rowNum;
		ObjForm.glDate.value=glDate;
		ObjForm.valueDate.value=valueDate;
		ObjForm.instrNo.value=instrNo;
		ObjForm.withdrawalAmt.value=withdrawalAmt;
		ObjForm.depositAmt.value=depositAmt;
		ObjForm.balanceAmt.value=balanceAmt;
		ObjForm.narrative.value=narrative;
	}
	else
	{
		for(var i=0;i<iListMaxDisplay;i++)
		{
			if(valueDate[i] != 'null')
			{
				ObjForm.rowNum[i].value=rowNum[i];
				ObjForm.glDate[i].value=glDate[i];
				ObjForm.valueDate[i].value=valueDate[i];
				ObjForm.instrNo[i].value=instrNo[i];
				ObjForm.withdrawalAmt[i].value=withdrawalAmt[i];
				ObjForm.depositAmt[i].value=depositAmt[i];
				ObjForm.balanceAmt[i].value=balanceAmt[i];
				ObjForm.narrative[i].value=narrative[i];
			}
		}
	}

}

function fnCheckForNull(obj)
{
	var fieldValue =iListMaxDisplay;
	var ObjForm = document.forms[0];
	if(iListMaxDisplay == 1){
		if(!(ObjForm.valueDate.value)&&!(ObjForm.instrNo.value)&&!(ObjForm.withdrawalAmt.value)&&!(ObjForm.depositAmt.value)&&!(ObjForm.balanceAmt.value)&&!(ObjForm.narrative.value))
		{
			fieldValue--;
		}
	}else{
		for(var i=0;i<iListMaxDisplay;i++)
		{
			if(!(ObjForm.valueDate[i].value)&&!(ObjForm.instrNo[i].value)&&!(ObjForm.withdrawalAmt[i].value)&&!(ObjForm.depositAmt[i].value)&&!(ObjForm.balanceAmt[i].value)&&!(ObjForm.narrative[i].value))
			{
				fieldValue--;
			}
		}
	}
	if(fieldValue>=0 && fieldValue<iListMaxDisplay)
	{
		alert("Enter all records in the current screen");
	}
	else
	{
		doSubmit(obj.id);
	}
}

function cacli_det_ONCLICK1(obj)
{
	var retVal = "";
	if (preEventCall('cacli_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnLastButtonClick()) == false) {
		return false;
	}
	if (postEventCall('cacli_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
