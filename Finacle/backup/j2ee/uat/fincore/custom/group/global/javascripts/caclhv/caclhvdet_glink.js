function printBlock()
{
	writeCustomHeader("caclhvdet");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT025762") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfielddisplaylabel">' + funcCodeD +'</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel"></td>');
	write('<td class="textfielddisplaylabel"> </td>');
	write('<input type="hidden" class="textfieldfont" name="' + subGroupName + '.totalRecords" id="totalRecords"  fdt="String" style="width: 120px;" readonly>');
	
	write('</tr>');
	write('<tr>');
	//write('<td class="textlabel">' + jspResArr.get("FLT029417") + '</td>');
	//write('<td class="textfielddisplaylabel">'+ paysysId +' </td>');
	//write('<td class="columnwidth">&nbsp; </td>');
	//write('<td class="textlabel">' + jspResArr.get("FLT014834") + '</td>');
	//write('<td class="textfielddisplaylabel"> 103 </td>');

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
	write('<a href="javascript:showHelpFile(\'det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="17" height="17" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">');
	write('<div></div>');
	write('<div>');
	write('<tr>');
	write('<td height="25" colspan="5" align="right">');
	write('<table border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td align="right">');
	write('<a>');
	if(CurrentPage<=1){
	write('<img src="../Renderer/images/'+applangcode+'/arrowgraypre.gif" width="7" height="14" border="0" name="prevpage" id="prevpage">');
	}else	{
	write('<img  hotKeyId="Prev" src="../Renderer/images/'+applangcode+'/arrowpre.gif" width="7" height="14" border="0" align="absmiddle" id="prevpage" name="prevpage" onClick="javascript:fnOnPrevPageCall(this);" onMouseOver="displayHand(this)">');
	}
	write('</a>');
	write('</td>');
	write('<td>Page</td>');
	write('<td>' + CurrentPage + '</td>');
	write('<td>of ' + MaxPage + '</td>');
	write('<td>');
	write('<a>');
	write('<img  hotKeyId="Next" src="../Renderer/images/'+applangcode+'/arrownext.gif" id="nextpage" name="nextpage" width="7" height="14" border="0" align="absmiddle" onClick="javascript:fnCheckForNull(this);" onMouseOver="displayHand(this)">');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('<tr>');
	write('<td colspan="5">');
	write('<table width="100%">');
	write('<tr>');
	write('<td width="1%" class="searcheader1a" title="selectAllMRM"><input type="checkbox" name="chkselectAll" onClick="javascript:return fnSetAllCheckbox(this,getElementsByName(\'chkselname\'));">' + jspResArr.get("FLT008204") + '</td>');
	write('<td class="searcheader">' + jspResArr.get("FLT002012") + '</td>');
	//write('<td class="searcheader">' + jspResArr.get("FLT648085") + '</td>');
	write('<td class="searcheader">' + jspResArr.get("FLT648088") + '</td>');
	write('<td class="searcheader">' + jspResArr.get("FLT648089") + '</td>');
	//write('<td class="searcheader">' + jspResArr.get("FLT648090") + '</td>');
	write('<td class="searcheader">' + jspResArr.get("FLT029549") + '</td>');
	write('<td class="searcheader">' + jspResArr.get("FLT029548") + '</td>');
	//write('<td class="searcheader">' + jspResArr.get("FLT007737") + '</td>');
	write('<td class="searcheader">' + jspResArr.get("FLT007738") + '</td>');
	//write('<td class="searcheader">' + jspResArr.get("FLT648091") + '</td>');
	//write('<td class="searcheader">' + jspResArr.get("FLT001041") + '</td>');
	//write('<td class="searcheader">' + jspResArr.get("FLT009285") + '</td>');
	//write('<td class="searcheader">' + jspResArr.get("FLT648092") + '</td>');
	write('</tr>');
	//alert(CurrentSetSize);
	//alert(ListMaxDisplay);
	//alert(totalRecords);
	if(CurrentSetSize>0){
	for(iIndex=0;iIndex<ListMaxDisplay;iIndex++)
	{
		if(iIndex % 2 == 0)
			bgColorStyle = 'class="searclist1"';
		else 
			bgColorStyle = 'class="searclist2"';
	startRecord = startRecord + iIndex;
	write('<tr '+bgColorStyle+'>');
	write('<td>');
	write('<input type="hidden" name="' + subGroupName + '.selname" id="selname" ><input type="checkbox" name="chkselname" id="chkselname" onClick="javascript:return fnSetCheckbox(this.id);" style="width: 40px;">');
	write('</td>');
	write('<td>');
	write('<input type="hidden" name="' + subGroupName + '.reject" id="reject" ><input type="checkbox" onChange="javascript:return custom_ONCHANGE(this,'+iIndex+');" name="chkreject" id="chkreject" onClick="javascript:return fnSetCheckbox(this.id);" style="width: 40px;">');
	write('</td>');
	//write('<td>');
	//write('<input type="text" class="textfieldfont" name="' + subGroupName + '.poNumber" id="poNumber"  fdt="String" ' + caclhvProps.get("poNumber_ENABLED") + ' style="width: 120px;" readonly>');
	//write('</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.poDate" id="poDate"  fdt="String" ' + caclhvProps.get("poDate_ENABLED") + ' style="width: 80px;" readonly>');
	write('</td>');
	write('<td>');
	write('<input type="text" name="' + subGroupName + '.beneficiaryAccount" id="beneficiaryAccount"   fdt="String" ' + caclhvProps.get("beneficiaryAccount_ENABLED") + ' class="textfieldfont" style="width: 140px;" readonly>');
	write('</td>');
	//write('<td>');
	//write('<input type="text" class="textfieldfont" onChange="javascript:return fnget_rateCode('+iIndex+');"  name="' + subGroupName + '.correctedAccount" id="correctedAccount"  onBlur="javascript:return fngetAccountName('+iIndex+');" fdt="String" ' + caclhvProps.get("correctedAccount_ENABLED") + ' style="width: 240px;">');
	//if((funcCode != "I") &&(funcCode != "V") && (funcCode != "D"))
	//{
	//	if(iListMaxDisplay==1)
	//	{
	//	 write('<a href="javascript:showAccountIdList(document.forms[0].correctedAccount);fnget_rateCode()">');
	//	}
	//	else
	//	{
	//	 write('<a href="javascript:showAccountIdList(document.forms[0].correctedAccount('+iIndex+'));fnget_rateCode('+iIndex+')">');	
	//	}
	//	write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16" id ="corrAcctSearcher">');
	//	write('</a>');

		
	//}

	//write('</td>');
	
	//account name --> start
	write('<td>');
	write('<input type="text" class="textfieldfont"   name="' + subGroupName + '.accountName" id="accountName"  fdt="String" ' + caclhvProps.get("accountName_ENABLED") + ' style="width: 250px;">');
	
	//write('<input type="text" class="textfieldfont" name="' + subGroupName + '.accountName" id="accountName"  onBlur="javascript:return caclhvdetCustomOnBlur(this);" fdt="String" ' + caclhvProps.get("accountName_ENABLED") + ' style="width: 180px;" >');
	write('</td>');
	//account name <--end
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.amountCurrency" id="amountCurrency"  fdt="String" ' + caclhvProps.get("amountCurrency_ENABLED") + ' style="width: 100px;" readonly>');
	write('</td>');
	//write('<td>');
	//write('<input type="text" class="textfieldfont" onChange="javascript:return fnget_rate('+iIndex+');" name="' + subGroupName + '.rateCode" id="rateCode"  fdt="String" ' + caclhvProps.get("rateCode_ENABLED") + ' style="width: 70px;">');
	//if((funcCode != "I") && (funcCode != "V") && (funcCode != "D"))
	//{
	//	if(iListMaxDisplay==1)
	//	{
	//		write('<a href="javascript:showRefCode(document.forms[0].rateCode,\'67\',\'N\',\'B\');fnget_rate()">');
	//	}
	//	else
	//	{
	//		write('<a href="javascript:showRefCode(document.forms[0].rateCode('+iIndex+'),\'67\',\'N\',\'B\');fnget_rate('+iIndex+')">');
	//	}
	//	write('<img border="0" height="17" hotKeyId="search4" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16" id ="rateCodeSearcher">');
	//	write('</a>');

		
	//}

	//write('</td>');
	//write('<td>');
	//write('<input type="text" class="textfieldfont" name="' + subGroupName + '.rate" id="rate"  fdt="String" ' + caclhvProps.get("rate_ENABLED") + ' style="width: 55px;" readonly>');
	//write('</td>');
	//write('<td>');
	//write('<input type="text" class="textfieldfont" name="' + subGroupName + '.reasonForFailure" id="reasonForFailure"  fdt="String" ' + caclhvProps.get("reasonForFailure_ENABLED") + ' style="width: 250px;" readonly>');
	//write('</td>');
	
	//write('<td>');
	//write('<a id="exp_'+iIndex+'" href="javascript:fnDetailsDisplay('+iIndex+');" style="width: 10px;">');
	//write('<img border="0" height="17" explodeId="explode0" src="../Renderer/images/'+applangcode+'/explode.gif" width="16">');
	//write('</a>');
	//write('</td>')
	
	//write('<td>');
	//write('<input type="text" class="textfieldfont" name="' + subGroupName + '.reasonCode" id="reasonCode"  fdt="String" ' + caclhvProps.get("reasonCode_ENABLED") + ' style="width: 80px;">');
	//if((funcCode != "I") &&((funcCode != "V")))
	//{
	//	write('<a id="exp_'+iIndex+'" href="javascript:fnshowRejReasonCode('+iIndex+');">');	
	//	write('<img border="0" id="sLnk2" height="17" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	//	write('</a>');
	//}
	//write('</td>');
	//write('<td>');
	//write('<input type="text" class="textfieldfont" name="' + subGroupName + '.newRate" id="newRate"  fdt="String" ' + caclhvProps.get("newRate_ENABLED") + ' style="width: 80px;">');
	//write('</td>');
	//write('<td>');
	//write('<input type="hidden" class="textfieldfont" name="freetext1">');
	//write('</td>');
	//write('<td>');
	//write('<input type="hidden" class="textfieldfont" name="freetext2">');
	//write('</td>');
	//write('<td>');
	//write('<input type="hidden" class="textfieldfont" name="freetext3">');
	//write('</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.expDate" id="expDate"  fdt="String" ' + caclhvProps.get("expDate_ENABLED") + ' style="width: 150px;" readonly>');
	write('</td>');
	
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.senderBic" id="senderBic" ' + caclhvProps.get("senderBic_ENABLED") + ' readonly="readonly">');
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.receiverBic" id="receiverBic" ' + caclhvProps.get("receiverBic_ENABLED") + ' readonly="readonly">');
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.tag50k" id="tag50k" ' + caclhvProps.get("tag50k_ENABLED") + ' readonly="readonly">');
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.origAcct" id="origAcct" ' + caclhvProps.get("origAcct_ENABLED") + ' readonly="readonly">');
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.suspenseAccount" id="suspenseAccount" ' + caclhvProps.get("suspenseAccount_ENABLED") + ' readonly="readonly">');

	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.tag591" id="tag591" ' + caclhvProps.get("tag591_ENABLED") + ' readonly="readonly">');
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.tag592" id="tag592" ' + caclhvProps.get("tag592_ENABLED") + ' readonly="readonly">');
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.tag593" id="tag593" ' + caclhvProps.get("tag593_ENABLED") + ' readonly="readonly">');
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.tag594" id="tag594" ' + caclhvProps.get("tag594_ENABLED") + ' readonly="readonly">');
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.tag595" id="tag595" ' + caclhvProps.get("tag595_ENABLED") + ' readonly="readonly">');
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.acctName" id="acctName" ' + caclhvProps.get("acctName_ENABLED") + ' readonly="readonly">');
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.custAccStatus" id="custAccStatus" ' + caclhvProps.get("custAccStatus_ENABLED") + ' readonly="readonly">');
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.tag57a1" id="tag57a1" ' + caclhvProps.get("tag57a1_ENABLED") + ' readonly="readonly">');
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.tag57a2" id="tag57a2" ' + caclhvProps.get("tag57a2_ENABLED") + ' readonly="readonly">');
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.delFlg" id="delFlg" ' + caclhvProps.get("delFlg_ENABLED") + '>');
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.msgType" id="msgType" ' + caclhvProps.get("msgType_ENABLED") + '>');
	write('<input type="hidden" class="textfieldfont" style="width: 60px" name="' + subGroupName + '.tag701" id="tag701" ' + caclhvProps.get("tag701_ENABLED") + '>');

	

	

	

	
	write('</tr>');
	}
	}
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</tr>');
	write('</div>');
	write('</td>');
	write('<td class="textfield"> </td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');
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
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return caclhvdet_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return caclhvdet_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return caclhvdet_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
	}else{
	write('<div class="ctable">');
	write('<input class="button" type="button" id="Back" value="'+jspResArr.get("FLT026526")+ '" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnSetCheckbox(objChkCtrl){
	var chkSelectCounter = 0;
	var objChkFld = eval("document.forms[0]."+objChkCtrl.substring(3));
	var objChkboxCtrl = eval("document.forms[0]."+objChkCtrl);
	var isArray = (typeof(objChkboxCtrl.length)=="undefined")?false:true;
	if(isArray){
		for(var i=0;i<objChkboxCtrl.length;i++)
		{
			if(objChkboxCtrl[i].checked){
				objChkFld[i].value = "Y";
				chkSelectCounter = chkSelectCounter + 1;
			}
			else{
				objChkFld[i].value = "N";
			}
		}
		if((objChkCtrl.toString() == "chkselname"))
		{
			if(objChkboxCtrl.length == chkSelectCounter ){
				document.forms[0].chkselectAll.checked = true;
			}
			else{
				document.forms[0].chkselectAll.checked = false;
			}
		}
	}else{
		if(objChkboxCtrl.checked){
			objChkFld.value = "Y";
			if(objChkCtrl.toString() == "chkselname"){
				document.forms[0].chkselectAll.checked = true;
			}
		}else{
			objChkFld.value = "N";
			if(objChkCtrl.toString() == "chkselname"){
				document.forms[0].chkselectAll.checked = false;
			}
		}
	}
}
function fnOnLoad()
{
	var ObjForm = document.forms[0];

	initFocusHandler();

	pre_ONLOAD('caclhvdet',this);

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

	post_ONLOAD('caclhvdet',this);
	ObjForm.totalRecords.value = totalRecords;
	//ObjForm.msgType.value = "103";
	
	
	if (funcCode == "I")
	{
	   if(iListMaxDisplay==1)
	  {
			ObjForm.chkselectAll.disabled = true;
			ObjForm.chkselname.READONLY = true;
			ObjForm.selname.disabled = true;
			
			ObjForm.chkreject.READONLY = true;
			ObjForm.reject.disabled = true;
			
			//ObjForm.poNumber.disabled = true;
			ObjForm.poDate.disabled = true;
			ObjForm.beneficiaryAccount.disabled = true;
			//ObjForm.correctedAccount.disabled = true;
			ObjForm.accountName.disabled = true;
			ObjForm.amountCurrency.disabled = true;
			//ObjForm.rateCode.disabled = true;
			
			//ObjForm.rate.disabled = false;	
			//ObjForm.reasonForFailure.disabled = true;
			//ObjForm.tag701.disabled = true;
			ObjForm.expDate.disabled = true;
			ObjForm.delFlg.disabled = true;
	  }
	  else
	  {
	    for(var i=0;i<iListMaxDisplay;i++)
		 {
		    ObjForm.chkselectAll.disabled = true;
			ObjForm.chkselname[i].READONLY = true;
			ObjForm.selname[i].disabled = true;
			
			ObjForm.chkreject[i].READONLY = true;
			ObjForm.reject[i].disabled = true;
			
			//ObjForm.poNumber[i].disabled = true;
			ObjForm.poDate[i].disabled = true;
			ObjForm.beneficiaryAccount[i].disabled = true;
			//ObjForm.correctedAccount[i].disabled = true;
			ObjForm.accountName[i].disabled = true;

			ObjForm.amountCurrency[i].disabled = true;
			//ObjForm.rateCode[i].disabled = true;
			//ObjForm.rate[i].disabled = true;	
			//ObjForm.reasonForFailure[i].disabled = true;
			//ObjForm.tag701[i].disabled = true;
			ObjForm.expDate[i].disabled = true;
			
			ObjForm.delFlg[i].disabled = true;
		 }
	  }	
   }

	if (funcCode == "M")
	{
	   if(iListMaxDisplay==1)
	  {
		ObjForm.selname.disabled = false;
		
		ObjForm.reject.disabled = false;
		
		//ObjForm.poNumber.disabled = true;
		ObjForm.poDate.disabled = true;
		ObjForm.beneficiaryAccount.disabled = true;
		ObjForm.amountCurrency.disabled = true;
		//ObjForm.rateCode.disabled = true;
		//ObjForm.rate.disabled = true;
		//ObjForm.reasonForFailure.disabled = true;
		//ObjForm.tag701.disabled = true;
		ObjForm.expDate.disabled = true;
		
		ObjForm.delFlg.disabled = true;
	  }
	  else
	  {
	    for(var i=0;i<iListMaxDisplay;i++)
		 {
			
			if(ObjForm.poDate[i].value != "")
			{
			  ObjForm.selname[i].value = selname[i];
			
			  ObjForm.reject[i].value = reject[i];
			  if(ObjForm.reject[i].value == "Y")
			  {
				ObjForm.chkselname[i].disabled= true;
			  }
		      
			  //ObjForm.poNumber[i].disabled = true;
			  ObjForm.poDate[i].disabled = true;
			  ObjForm.beneficiaryAccount[i].disabled = true;
			  ObjForm.amountCurrency[i].disabled = true;
			  //ObjForm.rateCode[i].disabled = true;
			  //ObjForm.rate[i].disabled = true;
			
			  //ObjForm.reasonForFailure[i].disabled = true;
			  //ObjForm.tag701[i].disabled = true;
			  ObjForm.expDate[i].disabled = true;
			
			  ObjForm.delFlg[i].disabled = true;
			}
			else
			{
			  ObjForm.chkselectAll.disabled = true;
			  ObjForm.chkselname[i].disabled = true;
			  ObjForm.chkselname[i].checked = false;
			  ObjForm.selname[i].value = selname[i];
			
			  ObjForm.chkreject[i].disabled = true;
			  ObjForm.chkreject[i].checked = false;
			  ObjForm.reject[i].value = reject[i];
		      
			  //ObjForm.poNumber[i].disabled = true;
			  ObjForm.poDate[i].disabled = true;
			  ObjForm.beneficiaryAccount[i].disabled = true;
			  //ObjForm.correctedAccount[i].disabled = true;
			  			  ObjForm.accountName[i].disabled = true;
				//ObjForm.accountName[i].value = accountName[i];
			  ObjForm.amountCurrency[i].disabled = true;
			  //ObjForm.rateCode[i].disabled = true;	
			  //ObjForm.rate[i].disabled = true;
			 // ObjForm.reasonForFailure[i].disabled = true;
			  //ObjForm.tag701[i].disabled = true;
			  ObjForm.expDate[i].disabled = true;
			
			  ObjForm.delFlg[i].disabled = true;
			}
		 }
	   }
	}	
	if ((funcCode == "V") || (funcCode == "D"))
	{
	  if(iListMaxDisplay==1)
	  {
		  ObjForm.chkselectAll.disabled = false;
		  ObjForm.chkselname.disabled = false;
		  ObjForm.selname.disabled = false;
		  ObjForm.chkselname.checked = (selname=="Y")?true:false;
		  
		  ObjForm.chkreject.disabled = true;
		  ObjForm.reject.disabled = true;
		  ObjForm.chkreject.checked =  (reject=="Y")?true:false;
		  
		  //ObjForm.poNumber.disabled = true;
		  ObjForm.poDate.disabled = true;
		  ObjForm.beneficiaryAccount.disabled = true;
		  //ObjForm.correctedAccount.disabled = true;
		  		  ObjForm.accountName.disabled = true;
		  ObjForm.accountName.value = accountName;
		  ObjForm.amountCurrency.disabled = true;
		  //ObjForm.rateCode.disabled = true;
          	  //ObjForm.rate.disabled = true;	
		  //ObjForm.reasonForFailure.disabled = true;
		  //ObjForm.tag701.disabled = true;
		  ObjForm.expDate.disabled = true;
		  
		  ObjForm.delFlg.disabled = true;
	  }
	  else
		{
	    for(var i=0;i<iListMaxDisplay;i++)
		 {
			ObjForm.chkselectAll.disabled = false;
			ObjForm.chkselname[i].disabled = false;
			ObjForm.selname[i].disabled = false;
			ObjForm.chkselname[i].checked = (selname[i]=="Y")?true:false;
		
			ObjForm.chkreject[i].disabled = true;
		    ObjForm.chkreject[i].checked =  (reject[i]=="Y")?true:false;
		    ObjForm.reject[i].disabled = true;
		
			//ObjForm.poNumber.disabled = true;
		    ObjForm.poDate.disabled = true;
		    ObjForm.beneficiaryAccount.disabled = true;
		   // ObjForm.correctedAccount.disabled = true;
					    ObjForm.accountName.disabled = true;
			ObjForm.accountName[i].value = accountName[i];
		    ObjForm.amountCurrency.disabled = true;
		  //  ObjForm.rateCode.disabled = true;
            //ObjForm.rate.disabled = true;	
		   // ObjForm.reasonForFailure.disabled = true;
		    //ObjForm.tag701.disabled = true;
		    ObjForm.expDate.disabled = true;
		
		    ObjForm.delFlg.disabled = true;
		 }
		}
	}





}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	var ischk = true;
	
	
	if(iListMaxDisplay==1)
	{
		if(selname=="Y" && ischk == true)
		{
			ObjForm.chkselectAll.checked = true;
		}
		else
		{
			ischk = false;
			ObjForm.chkselectAll.checked = false;
		}
	}
	else
	{
		for(var i=0;i<iListMaxDisplay;i++)
		{
			if(selname[i]=="Y" == true && ischk == true)
			{
				ObjForm.chkselectAll.checked = true;
			}
			else
			{
				ischk = false;
				ObjForm.chkselectAll.checked = false;
			}
		}
	}
	
	if(iListMaxDisplay==1)
	{
		ObjForm.chkselname.checked=(selname=="Y")?true:false;
		ObjForm.selname.value=selname;
		ObjForm.chkreject.checked=(reject=="Y")?true:false;
		ObjForm.reject.value=reject;
		//ObjForm.poNumber.value=poNumber;
		ObjForm.poDate.value=poDate;
		ObjForm.beneficiaryAccount.value=beneficiaryAccount;
		//ObjForm.correctedAccount.value=correctedAccount;
				ObjForm.accountName.value=accountName;

		ObjForm.amountCurrency.value=amountCurrency;
		//ObjForm.rateCode.value=rateCode;
		//ObjForm.rate.value=rate;
		//ObjForm.reasonForFailure.value=reasonForFailure;
		//ObjForm.tag701.value=tag701;
		ObjForm.expDate.value=expDate;
		//ObjForm.newRate.value=newRate;
	}
	else
	{
		for(var i=0;i<iListMaxDisplay;i++)
		{
			if(selname[i] != 'null')
			{
				ObjForm.chkselname[i].checked=(selname[i]=="Y")?true:false;
				ObjForm.selname[i].value=selname[i];
				ObjForm.chkreject[i].checked=(reject[i]=="Y")?true:false;
				ObjForm.reject[i].value=reject[i];
				//ObjForm.poNumber[i].value=poNumber[i];
				ObjForm.poDate[i].value=poDate[i];
				ObjForm.beneficiaryAccount[i].value=beneficiaryAccount[i];
				//ObjForm.correctedAccount[i].value=correctedAccount[i];
								ObjForm.accountName[i].value=accountName[i];

				ObjForm.amountCurrency[i].value=amountCurrency[i];
				//ObjForm.rateCode[i].value=rateCode[i];
				//ObjForm.rate[i].value=rate[i];
				//ObjForm.reasonForFailure[i].value=reasonForFailure[i];
				//ObjForm.tag701[i].value=tag701[i];
				ObjForm.expDate[i].value=expDate[i];
				//ObjForm.newRate[i].value=newRate[i];
			}
		}
	}

	fnCheckControls();

}

function fnCheckControls()
{
	var ObjForm = document.forms[0];

}

function fnCheckForNull(obj)
{
	var fieldValue =iListMaxDisplay;
	var ObjForm = document.forms[0];
	if(iListMaxDisplay == 1){
		if(!(ObjForm.chkselname.checked)&&!(ObjForm.chkreject.checked)&&!(ObjForm.poDate.value)&&!(ObjForm.beneficiaryAccount.value)&&!(ObjForm.accountName.value)&&!(ObjForm.amountCurrency.value)&&!(ObjForm.rate.expDate))
		{
			fieldValue--;
		}
	}else{
		for(var i=0;i<iListMaxDisplay;i++)
		{
			if(!(ObjForm.chkselname[i].checked)&&!(ObjForm.chkreject[i].checked)&&!(ObjForm.poDate[i].value)&&!(ObjForm.beneficiaryAccount[i].value)&&!(ObjForm.accountName[i].value)&&!(ObjForm.amountCurrency[i].value)&&!(ObjForm.expDate[i].value))
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
		
		if(fnValidateData())
		{

			doSubmit(obj.id);
		}		

	}
}

function caclhvdet_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('caclhvdet',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('caclhvdet',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function caclhvdet_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('caclhvdet',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('caclhvdet',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function caclhvdet_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('caclhvdet',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('caclhvdet',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function fnSetAllCheckbox(objChkCtrl,checknameArr)
{
	objForm = document.forms[0];
	var chk = objChkCtrl.checked; 
	for(var i=0;i<iListMaxDisplay;i++)
		{
			checknameArr[i].checked = chk;
			fnSetCheckbox(checknameArr[i].id);
		}
}
