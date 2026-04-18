/*---------------------------------------------------------------------------------------------------------------->
<!--Name                : ctoda_det1_glink.js 
<!--Description         : This is the details page glink file for ctoda menu
<!--Date                : 26-08-2013
<!--Author              :  
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : ctoda
<!--Modification History:
<!--	Version No.	      	Date		         Author		Description
<!--	-------        		----------        	-----------	------------------
<!--	 0.1				26-08-2103			Kalvin		created for TO :361667									
<!--	 0.2				04.09.2013			kalvin		removed the scroll arrow function
<!---------------------------------------------------------------------------------------------------------------->*/

function printBlock()
{
	writeCustomHeader("ctoda_det1");
	with (document){
	
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031590") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT112254") + '</td>');
//	write('<td class="textfielddisplaylabel">');
//	write('<label id="compField">' + fnGetFuncCodeDesc(funcCode) + '</label>');
	write('<td class="textfielddisplaylabel">');
	write('<input type="text" name="' + subGroupName + '.funcCode" id="funcCode" ' + ctodaProps.get("funcCode_ENABLED") + ' class="label" readonly="readonly">');
	 write('<label align="left"id="compFieldFunc">' + fnGetFunctionCodeDesc(funcCode) + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
//	write('<td class="textlabel">' + jspResArr.get("FLT112259") + '</td>');
//	write('<td class="textfielddisplaylabel">');
//	write('<label id="compField">' + accNum + '</label>');
//	write('</td>');
//	write('</tr>');
//	write('<tr>');
//	write('<td class="textlabel">' + jspResArr.get("FLT031592") + '</td>');
//	write('<td class="textfielddisplaylabel">');
//	write('<label id="compField">' + availReqId + '</label>');
//	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfielddisplaylabel">  </td>');
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
	write('<a href="javascript:showHelpFile(\'ctoda_det1_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td>');
	write('<input class="label" type="text">');
	write('</td>');
	write('<td class="page-heading">ACCOUNT DETAILS</td>');
	write('</tr>');
	
	
	write('<table width="100%" border="2">');
	write('<tr>');
	write('<td class="searcheader1a" style="width: 138px">');
	write('<p align="left">Account Number</p>');
	write('</td>');
	write('<td class="searcheader" style="width: 138px">');
	write('<p align="left">Account Name</p>');
	write('</td>');
	write('<td class="searcheader" style="width: 138px">');
	write('<p align="left">Cust ID</p>');
	write('</td>');
	write('<td class="searcheader" style="width: 138px">');
	write('<p align="right">Acct Open Date</p>');
	write('</td>');
	write('<td class="searcheader" style="width: 138px">');
	write('<p align="right">Last Tran Date</p>');
	write('</td>');
	write('<td class="searcheader" style="width: 138px">');
	write('<p align="right">Clear Bal Amount </p>');
	write('</td>');
	write('<td class="searcheader" style="width: 138px">');
	write('<p align="left">Scheme Type</p>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td>');
	write('<input class="label" type="text" name="' + subGroupName + '.accNo" id="accNo" ' +  ctodaProps.get("accNo_ENABLED") + ' style="width: 103px" readonly="readonly">');
	write('</td>');
	write('<td>');
	write('<input class="label" type="text" name="' + subGroupName + '.acctname" id="acctname" ' + ctodaProps.get("acctname_ENABLED") + ' readonly="readonly">');
	write('</td>');
	write('<td>');
	write('<input class="label" type="text" name="' + subGroupName + '.custid" id="custid" ' + ctodaProps.get("custid_ENABLED") + ' readonly="readonly">');
	write('</td>');
	write('<td>');
	write('<input class="label" type="text" name="' + subGroupName + '.acctOpnDate" id="acctOpnDate" ' +  ctodaProps.get("acctOpnDate_ENABLED") + ' style="width: 103px" readonly="readonly">');
	write('</td>');
	write('<td>');
	write('<input class="label" type="text" name="' + subGroupName + '.lastTranDate" id="lastTranDate" ' +  ctodaProps.get("lastTranDate_ENABLED") + ' style="width: 103px" readonly="readonly">');
	write('</td>');
	write('<td>');
	write('<input class="label" type="text" name="' + subGroupName + '.clrBal" id="clrBal" ' +  ctodaProps.get("clrBal_ENABLED") + ' style="width: 103px" readonly="readonly">');
	write('</td>');
	write('<td>');
	write('<input class="label" type="text" name="' + subGroupName + '.schmType" id="schmType" ' +  ctodaProps.get("schmType_ENABLED") + ' style="width: 103px" readonly="readonly">');
	write('</td>');
	write('</tr>');
	write('</table>');

	//write multirec here 
	write('<table>');
	write('<br />');
	write('<br />');
	write('<br />');
	write('<br />');
	write('</table>');

//----------------------------------------
//write('<tr>');
write('<table>');
write('<tr>');
	write('<td>');
	write('<input class="label" type="text" readonly="readonly">');
	write('<input class="label" type="text" readonly="readonly">');
	write('<input class="label" type="text" readonly="readonly">');
	write('<input class="label" type="text" readonly="readonly">');
	write('<input class="label" type="text" readonly="readonly">');
	write('<input class="label" type="text" readonly="readonly">');
	write('</td>');
	write('<td class="page-heading">REQUESTED DETAILS</td>');
	write('</tr>');
	write('</table>');
	

write('<table border="0" cellpadding="0" cellspacing="0">');

	
	
	write('</tr>');
	write('</table>');
	write('</td>');

	write('<tr>');
	write('<td colspan="5">');
	write('<table width="100%">');
	write('<tr>');
	write('<td class="searcheader1a" >');
	write('<p align="center">REQUEST ID</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">LIMIT ID</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">ACCOUNT NUM</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">ACCOUNT NAME</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">AMOUNT</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">STATUS</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="right">REMARKS</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">GRANT DATE</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">EXPIRY DATE</p>');
	write('</td>');
	write('</tr>');
	
	
	 if(CurrentSetSize>0){
	      for(iIndex=0;iIndex<ListMaxDisplay;iIndex++)
	      {
      	startRecord = startRecord + iIndex;
	write('<tr>');
	write('<td>');
	write('<p align="left">');
	write('<a href="javascript:fnShowTODHist('+ iIndex + ')">');
	testId = 'reqId'+iIndex;
	write('<input type="text" class="textfieldfont"  name="' + subGroupName + '.reqId" id='+ testId +' ' + ctodaProps.get("reqId_ENABLED") + ' style="width: 138px;color:#0000FF;text-decoration: underline" readonly="readonly">');
	write('</a>');
	write('</p>');
	write('</td>');
	write('<td>');
	testId = 'limId'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.limId" id='+ testId +' ' + ctodaProps.get("limId_ENABLED") + ' style="width: 89px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'acctNum'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.acctNum" id='+ testId +' ' + ctodaProps.get("acctNum_ENABLED") + ' style="width: 138px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'acctName'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.acctName" id='+ testId +' ' + ctodaProps.get("acctName_ENABLED") + ' style="width: 138px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'amount'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.amount" id='+ testId +' ' + ctodaProps.get("amount_ENABLED") + ' style="width: 89px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'status'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.status" id='+ testId +' ' + ctodaProps.get("status_ENABLED") + ' style="width: 200px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'remrks'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.remrks" id='+ testId +' ' + ctodaProps.get("remrks_ENABLED") + ' style="width: 103px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'grntDate'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.grntDate" id='+ testId +' ' + ctodaProps.get("grntDate_ENABLED") + ' style="width: 89px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'expDate'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.expDate" id='+ testId +' ' + ctodaProps.get("expDate_ENABLED") + ' style="width: 89px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'rowNum'+iIndex;
	write('<input type="hidden" name="' + subGroupName + '.rowNum" id='+ testId +' ' + ctodaProps.get("rowNum_ENABLED") + ' style="width: 89px" readonly="readonly">');
	write('</td>');
	write('</tr>');
	
	}
        }
	write('</table>');
	//---------------------------


	//end of multirec part 
	write('</table>');
	write('</table>');
	write('</table>');
	write('<tr>');
	write('<td class="columnwidth">&nbsp; </td>');
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
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return ctoda_det1_ONCLICK1(this,this);"" value="Submit" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="Validate"	onClick="javascript:return ctoda_det1_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="Cancel"	onClick="javascript:return ctoda_det1_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
	}else{
	write('<div class="ctable">');
	write('<input class="button" type="button" id="Back" value="OK" onClick="javascript:return ctoda_det1_ONCLICK4(this)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('ctoda_det1',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('ctoda_det1',this);
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
	ObjForm.accNo.value = accNo;
	ObjForm.acctname.value = acctname;
	ObjForm.clrBal.value = clrBal;
	ObjForm.custid.value = custid;
	ObjForm.acctOpnDate.value = acctOpnDate;
	ObjForm.lastTranDate.value = lastTranDate;
	ObjForm.schmType.value = schmType;
		
	for(var i=0;i<iListMaxDisplay;i++)
		{
				
				document.getElementById('reqId'+i).value =reqId[i];
				document.getElementById('limId'+i).value =limId[i];
				document.getElementById('acctNum'+i).value =acctNum[i];
				document.getElementById('acctName'+i).value =acctName[i];
				document.getElementById('amount'+i).value =amount[i];
				document.getElementById('status'+i).value =status[i];
				document.getElementById('remrks'+i).value =remrks[i];
				document.getElementById('grntDate'+i).value =grntDate[i];
				document.getElementById('expDate'+i).value =expDate[i];
				
		}
}
	


function ctoda_det1_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('ctoda_det1',obj) == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('ctoda_det1',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ctoda_det1_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('ctoda_det1',obj) == false) { 
		return false;
	}
	if ((retVal =  fnValidateData(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('ctoda_det1',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ctoda_det1_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('ctoda_det1',obj) == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('ctoda_det1',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ctoda_det1_ONCLICK4(obj,p1)
{
        document.forms[0].menuName.value = "CTODA";
        handleMenuDisplay(document.forms[0].menuName.value, true, null,'Go');
        return;
        var retVal = "";
        if (pre_ONCLICK('accm_det1',obj) == false) {
                return false;
        }
        if ((retVal =  doSubmit(p1)) == false) {
                return false;
        }
        if (post_ONCLICK('accm_det1',obj) == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

