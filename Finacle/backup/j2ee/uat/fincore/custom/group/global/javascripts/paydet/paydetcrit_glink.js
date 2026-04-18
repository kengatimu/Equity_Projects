function printBlock()
{
	writeCustomHeader("paydetcrit");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
//	write('<td class="page-heading">' + jspResArr.get("FLT002640") + '</td>');
	write('<td class="page-heading"> Over The Counter Transaction</td>');
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
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfield" width="30%">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode" class="listboxfont"  fdt="String" ' + paydetProps.get("funcCode_ENABLED") + '>');
	write('<option value="">' + jspResArr.get("FLT031318") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT031822") + '</option>');
//	write('<option value="M">' + jspResArr.get("FLT031585") + '</option>');
	write('<option value="D">' + jspResArr.get("FLT031836") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT031586") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT031826") + '</option>');
	//write('<option value="C">' + jspResArr.get("FLT031837") + '</option>');
	write('</select>');
	write('</td>');
//	write('</tr>')
	
//	write('<td>');
	

//	write('<tr>');
	write('<td class="textlabel" style="height: 15px">Transaction Type</td>');
	write('<td class="textfield">');
	write('<input type="radio" name="' + subGroupName + '.trantype" id="trantype"  fdt="String" ' + paydetProps.get("trantype_ENABLED") + ' value="N" checked> None');
	write('<input type="radio" name="' + subGroupName + '.trantype" id="trantype"  fdt="String" ' + paydetProps.get("trantype_ENABLED") + ' value="C"> Cash' );
	write('<input type="radio" name="' + subGroupName + '.trantype" id="trantype"  fdt="String" ' + paydetProps.get("trantype_ENABLED") + ' value="T"> Transfer');
	write('</td>');

	write('<tr>');

	write('<td class="textlabel" style="height: 15px">Ecs Transaction Ref Num</td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.Ecstranrefnum" id="Ecstranrefnum"  fdt="String" ' + paydetProps.get("Ecstranrefnum_ENABLED") + '>');





//hushed
//	write('&nbsp;<a id="sLnk8" href="javascript:showCurrencyList(document.forms[0].Ecstranrefnum)">');
//        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search3"></a>');


	write('</tr>');
			
//	write('</td>');
//	write('</tr>');

	write('<td class="textlabel" style="height: 15px">SOL ID</td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.solid" id="solid"  fdt="String" ' + paydetProps.get("solid_ENABLED") + '>');
	write('&nbsp;<a id="sLnk8" href="Javascript:showSolId(document.forms[0].solid)">');
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search3"></a>');
	write('</td>');	

	write('<tr>');



	write('<td class="textlabel" style="height: 15px">Payment System ID</td>');
	write('<td class="textfield">');


	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.paysysid" id="paysysid"  fdt="String" ' + paydetProps.get("paysysid_ENABLED") + '>');
	      write("&nbsp;<a id=\"sLnk2\" target=_self href=\"Javascript:showRefCode(document.forms[0].paysysid,'CK','N','F',document.forms[0].paysysiddesc)\">");
      write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search2"></img></a>');
      write('<input type=hidden class="label" name="' + subGroupName + '.paysysiddesc" id="paysysiddesc" size=3 maxlength="3" >');

//	write('<td class="textlabel">' + jspResArr.get("FLT030604") + '</td>');
//	write('<td class="textfield">');
//	write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.currency" id="currency"  fdt="String" ' + paydetProps.get("currency_ENABLED") + '>');
//	write('&nbsp;<a id="sLnk8" href="javascript:showCurrencyList(document.forms[0].currency)">');
//        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search3"></a>');
	    write('<input type=hidden class="text" name="' + subGroupName + '.currency" id="currency" value="CDF" size=3 maxlength="3" >');



	write('</td>');
	write('</tr>');

//	write('<td class="textlabel" style="height: 15px">Payment Ind</td>');
//	write('<td class="textfield">');
//	write('<input type="radio" name="' + subGroupName + '.pymntIndctr" id="pymntIndctr"  fdt="String" ' + paydetProps.get("pymntIndctr_ENABLED") + ' value="A" checked>ACH');
//	write('<input type="radio" name="' + subGroupName + '.pymntIndctr" id="pymntIndctr"  fdt="String" ' + paydetProps.get("pymntIndctr_ENABLED") + ' value="R">RTGS');



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
	write('<input type="button" class="Button" id="Submit" value="'+jspResArr.get("FLT000193")+ '" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return paydetcrit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return paydetcrit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	document.forms[0].funcCode.focus();
	initFocusHandler();

	pre_ONLOAD('paydetcrit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('paydetcrit',this);
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
	ObjForm.currency.value = "CDF";
//	ObjForm.currency.value = currency;
//	ObjForm.InOutIndctr.value = InOutIndctr;
	ObjForm.trantype.value = trantype;
	ObjForm.Ecstranrefnum.value = Ecstranrefnum;
	ObjForm.solid.value = solid;
	ObjForm.paysysid.value = paysysid;


	fnCheckControls();

}

function fnCheckControls()
{
	var ObjForm = document.forms[0];

	checkRadio(ObjForm.trantype,trantype);

}


function paydetcrit_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('paydetcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('paydetcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function paydetcrit_ONCLICK2(obj)
{
	var retVal = "";
	if (preEventCall('paydetcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('paydetcrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

