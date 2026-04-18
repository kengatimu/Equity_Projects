/*---------------------------------------------------------------------------------------------------------------->
<!--Name                : accm_det_glink.js 
<!--Description         : This is the details page glink file for accm menu
<!--Date                : 04-07-2013
<!--Author              :  
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : ACCM
<!--Modification History:
<!--	Version No.	      	Date		         Author		Description
<!--	-------        		----------        	-----------	------------------
<!--	 0.1														
<!--	 0.2				31-07-2013			Kalvin		Modified for TO:361667
<!--														in line nos:133-139 &310-312
<!--      0.3				29-08-2013			Kalvin		Modified for TO :366774
<!---------------------------------------------------------------------------------------------------------------->*/

function printBlock()
{
	writeCustomHeader("accm_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031316") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FAT000703") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<input type="text" name="' + subGroupName + '.funcCode" id="funcCode" ' + accmProps.get("funcCode_ENABLED") + ' class="label" readonly="readonly">');
	 write('<label align="left"id="compFieldFunc">' + fnGetFunctionCodeDesc(funcCode) + '</label>');
	write('</td>');
	//write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031310") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<input type="text" name="' + subGroupName + '.acctNo" id="acctNo" ' + accmProps.get("acctNo_ENABLED") + ' class="label" readonly="readonly">');
	write('</td>');
	//write('<td class="columnwidth">&nbsp; </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT024006") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<input type="text" name="' + subGroupName + '.contractId" id="contractId" ' + accmProps.get("contractId_ENABLED") + ' class="label" readonly="readonly">');
	write('</td>');
	//write('<td class="columnwidth">&nbsp;  </td>');
	write('<td class="textlabel"></td>');
	write('<td class="textfielddisplaylabel"></td>');
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
	write('<a href="javascript:showHelpFile(\'accm_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT031317") + '</td>');
	write('<td class="textfield">');
	write('<input class="label" type="text" name="' + subGroupName + '.acctname" id="acctname" ' + accmProps.get("acctname_ENABLED") + ' readonly="readonly"  size="80">');
	write('</td>');
	

	write('<td class="textlabel" >' + jspResArr.get("FLT031318") + '</td>');
	write('<td class="textfield">');
	write('<input class="label" type="text" name="' + subGroupName + '.solId" id="solId" ' + accmProps.get("solId_ENABLED") + ' readonly="readonly">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FAT000934") + '</td>');
	write('<td class="textfield">');
	write('<input class="label" type="text" name="' + subGroupName + '.schmCode" id="schmCode" ' + accmProps.get("schmCode_ENABLED") + ' readonly="readonly">');
	write('</td>');
	//write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031323") + '</td>');
	write('<td class="textfield">');
	write('<input class="label" type="text" name="' + subGroupName + '.minAmount" id="minAmount" ' + accmProps.get("minAmount_ENABLED") + ' readonly="readonly">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT031324") + '</td>');
	write('<td class="textfield">');
	write('<input class="label" type="text" name="' + subGroupName + '.maxAmount" id="maxAmount" ' + accmProps.get("maxAmount_ENABLED") + ' readonly="readonly">');
	write('</td>');
	//write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT031340") + '</td>');
	write('<td class="textfield">');
	write('<input class="label" type="text" name="' + subGroupName + '.maxContrctPeriod" id="maxContrctPeriod" ' + accmProps.get("maxContrctPeriod_ENABLED") + ' readonly="readonly">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT031341") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input class="label" hotKeyId="search1" type="text" name="' + subGroupName + '.crncyCode" id="crncyCode" ' + accmProps.get("crncyCode_ENABLED") + ' readonly="readonly"'+' size="3">');
	//write('<a href="#">');
	//write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	//write('</a>');
	write('<input class="textfieldfont" type="text" name="' + subGroupName + '.contrctAmt" id="contrctAmt" ' + accmProps.get("contrctAmt_ENABLED") + ' style="width: 180px" onBlur = "javascript: fnFormatAmt(this.value);"  onChange="javascript: fnFetchCharges(this.value,acctNo.value);"' + ' maxlength="20">');
	write('</td>');
	//write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT031342") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input class="textfieldfont" type="text" name="' + subGroupName + '.contractPeriod" id="contractPeriod" ' + accmProps.get("contractPeriod_ENABLED") +  'onClick= "javascript: fnIsNumber(this.value);"'+' maxlength="2">');
	write('</td>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FTT000416") + '</td>');
	write('<td class="textfield">');
	write('<input class="textfieldfont" type="text" name="' + subGroupName + '.charges" id="charges" ' + accmProps.get("charges_ENABLED") + ' readonly="readonly">');
	write('</td>');
	//write('<td class="columnwidth">&nbsp; </td>');

	/*--------CHANGE MADE FOR TO:361667----------------------------*/
	write('<td class="textlabel" id ="creDate" >' + "Created Date" + '</td>');
	write('<td class="textfield">');
	write('<input class="textfieldfont" type="text" name="' + subGroupName + '.creDateValue" id="creDateValue" ' + accmProps.get("creDateValue_ENABLED") +' readonly="readonly">');
	
	write('</td>')
	/*----------END OF CHANGE MADE FOR TO:361667--------------------*/

	write('</tr>');

	write('<tr id="terminateResRow">');
	write('<td class="textlabel">' + jspResArr.get("FAT001227") + '</td>');
	write('<td class="textfield">');
	write('<input class="textfieldfont" hotKeyId="search2" type="text" name="' + subGroupName + '.remarks" id="remarks" ' + accmProps.get("remarks_ENABLED") + ' readonly="readonly">');
	write('<a href= "javascript: fnFetchReasonCode()" id="search2" >');
	write('<img border="0" height="17" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>')
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('</tr>');
	//write('<tr></tr>');
	//write('</tr>');
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
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return accm_det_ONCLICK1(this,this);"" value="Submit" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="Validate"	onClick="javascript:return accm_det_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="Cancel"	onClick="javascript:return accm_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
	}else{
	write('<div class="ctable">');
	write('<input class="button" type="button" id="Back" value="OK" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('accm_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('accm_det',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];
	if (fnIsNull(ObjForm.contrctAmt.value))
	{
		alert("Enter Contract Amount");
		ObjForm.contrctAmt.focus();
		return false;
	}
	else
	{
		if(isNaN(ObjForm.contrctAmt.value))
		{
			alert("Only Number allowed for Contract Amount");
			ObjForm.contrctAmt.focus();
			return false;
		}
		else
		{
			if ((ObjForm.funcCode.value != "T") && (ObjForm.funcCode.value != "V"))
			{
				if(parseInt(ObjForm.contrctAmt.value) > parseInt(ObjForm.maxAmount.value))
				{
					   alert("Contract availment amount cannot be greater than contract amount");
							   ObjForm.contrctAmt.select();
							   return false;
				}
			}
		}
	}
	if (fnIsNull(ObjForm.contractPeriod.value))
	{
		alert("Enter Contract Period");
		ObjForm.contractPeriod.focus();
		return false;
	}
	else
	{
		 if(isNaN(ObjForm.contractPeriod.value))
		{
			alert("Only Number allowed for Contract period");
			ObjForm.contractPeriod.focus();
			return false;
		}
		else
                {
                        if(parseInt(ObjForm.contractPeriod.value) > parseInt(ObjForm.maxContrctPeriod.value))
                        {
                               alert("Contract period cannot be greater than maximum contract period");
				ObjForm.contractPeriod.focus();
                               return false;
                        }
                }

		
	}
	if (ObjForm.funcCode.value == "T")
	{
		if(fnIsNull(ObjForm.remarks.value))
		{
		 alert("Terminate Reason Required");
		document.forms[0].remarks.focus();
		return false;
		}

	}
	
	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.funcCode.value = funcCode;
	ObjForm.acctNo.value = acctNo;
	ObjForm.contractId.value = contractId;
	ObjForm.acctname.value = acctname;
	ObjForm.solId.value = solId;
	ObjForm.schmCode.value = schmCode;
	ObjForm.minAmount.value = minAmount;
	ObjForm.maxAmount.value = maxAmount;
	ObjForm.maxContrctPeriod.value = maxContrctPeriod;
	ObjForm.crncyCode.value = crncyCode;
	ObjForm.contrctAmt.value = contrctAmt;
	ObjForm.contractPeriod.value = contractPeriod;
	ObjForm.charges.value = charges;
	/*--------CHANGE MADE FOR TO:361667----------------------------*/
	ObjForm.creDateValue.value=creDateValue;
	/*-------- END OF CHANGE MADE FOR TO:361667----------------------------*/
	ObjForm.remarks.value = remarks;
	
	hideImage("search2");
	
	if (funcCode == "T")
	{
		//ObjForm.remarks.readOnly=false;
		showImage("search2");
		
	}
}
	


function accm_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('accm_det',obj) == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('accm_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function accm_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('accm_det',obj) == false) { 
		return false;
	}
	if ((retVal =  fnValidateData(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('accm_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function accm_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('accm_det',obj) == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('accm_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
