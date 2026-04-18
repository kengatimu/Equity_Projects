/*---------------------------------------------------------------------------------------------------------------->
<!--Name                : accm_det1_glink.js 
<!--Description         : This is the details page glink file for accm menu
<!--Date                : 04-07-2013
<!--Author              :  
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : ACCM
<!--Modification History:
<!--	Version No.	      	Date		         Author		Description
<!--	-------        		----------        	-----------	------------------
<!--	 0.1				22.8.2013			kalvin		created for TO:361667										
<!--	 0.2				04.09.2013			kalvin		removed the scroll arrow function
<!---------------------------------------------------------------------------------------------------------------->*/

function printBlock()
{
	writeCustomHeader("accm_det1");
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
	write('<a href="javascript:showHelpFile(\'accm_det1_help.htm\');" id="sLnk1">');
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
	write('<input class="label" type="text" name="' + subGroupName + '.acctNo" id="acctNo" ' +  accmProps.get("acctNo_ENABLED") + ' style="width: 103px" readonly="readonly">');
	write('</td>');
	write('<td>');
	write('<input class="label" type="text" name="' + subGroupName + '.acctname" id="acctname" ' + accmProps.get("acctname_ENABLED") + ' readonly="readonly">');
	write('</td>');
	write('<td>');
	write('<input class="label" type="text" name="' + subGroupName + '.custid" id="custid" ' + accmProps.get("custid_ENABLED") + ' readonly="readonly">');
	write('</td>');
	write('<td>');
	write('<input class="label" type="text" name="' + subGroupName + '.acctOpnDate" id="acctOpnDate" ' +  accmProps.get("acctOpnDate_ENABLED") + ' style="width: 103px" readonly="readonly">');
	write('</td>');
	write('<td>');
	write('<input class="label" type="text" name="' + subGroupName + '.lastTranDate" id="lastTranDate" ' +  accmProps.get("lastTranDate_ENABLED") + ' style="width: 103px" readonly="readonly">');
	write('</td>');
	write('<td>');
	write('<input class="label" type="text" name="' + subGroupName + '.clrBal" id="clrBal" ' +  accmProps.get("clrBal_ENABLED") + ' style="width: 103px" readonly="readonly">');
	write('</td>');
	write('<td>');
	write('<input class="label" type="text" name="' + subGroupName + '.schmType" id="schmType" ' +  accmProps.get("schmType_ENABLED") + ' style="width: 103px" readonly="readonly">');
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

	
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');

	write('<tr>');
	write('<td colspan="5">');
	write('<table width="100%">');
	write('<tr>');
	write('<td class="searcheader1a" >');
	write('<p align="center">Request ID</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">Account Number</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">Account Name</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">Request Type</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">Status</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">Remarks</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="right">Approved Amount</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">Approved Period</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">Created User</p>');
	write('</td>');
	write('<td class="searcheader">');
	write('<p align="center">Created Date</p>');
	write('</td>');
	write('</tr>');
	
	
	 if(CurrentSetSize>0){
	      for(iIndex=0;iIndex<ListMaxDisplay;iIndex++)
	      {
      	startRecord = startRecord + iIndex;
	write('<tr>');
	write('<td>');
	write('<p align="left">');
//	write('<a href="javascript:fnShowCntrctHist(document.forms[0].reqId[' + iIndex + '])">');
write('<a href="javascript:fnShowCntrctHist('+ iIndex + ')">');
testId = 'reqId'+iIndex;
	write('<input type="text" class="textfieldfont"  name="' + subGroupName + '.reqId" id='+ testId +' ' + accmProps.get("reqId_ENABLED") + ' style="width: 138px;color:#0000FF;text-decoration: underline" readonly="readonly">');
	write('</a>');
	write('</p>');
	write('</td>');
	write('<td>');
	testId = 'acctNum'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.acctNum" id='+ testId +' ' + accmProps.get("acctNum_ENABLED") + ' width: 138px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'acctName'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.acctName" id='+ testId +' ' + accmProps.get("acctName_ENABLED") + ' width: 138px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'reqType'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.reqType" id='+ testId +' ' + accmProps.get("reqType_ENABLED") + ' style="width: 96px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'status'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.status" id='+ testId +' ' + accmProps.get("status_ENABLED") + ' style="width: 103px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'remrks'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.remrks" id='+ testId +' ' + accmProps.get("remrks_ENABLED") + ' style="width: 200px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'apprvdAmt'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.apprvdAmt" id='+ testId +' ' + accmProps.get("apprvdAmt_ENABLED") + ' style="width: 89px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'apprvdPrd'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.apprvdPrd" id='+ testId +' ' + accmProps.get("apprvdPrd_ENABLED") + ' style="width: 89px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'cretUser'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.cretUser" id='+ testId +' ' + accmProps.get("cretUser_ENABLED") + ' style="width: 89px" readonly="readonly">');
	write('</td>');
	write('<td>');
	testId = 'cretDate'+iIndex;
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.cretDate" id='+ testId +' ' + accmProps.get("cretDate_ENABLED") + ' style="width: 89px" readonly="readonly">');
	write('</td>');
	testId = 'rowNum'+iIndex;
	write('<input type="hidden" name="' + subGroupName + '.rowNum" id='+ testId +' ' + accmProps.get("rowNum_ENABLED") + ' style="width: 89px">');
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
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return accm_det1_ONCLICK1(this,this);"" value="Submit" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="Validate"	onClick="javascript:return accm_det1_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="Cancel"	onClick="javascript:return accm_det1_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
 }else{
        write('<div class="ctable">');
        write('<input class="button" type="button" id="Back" value="OK" onClick="javascript:return accm_det1_ONCLICK4(this)" hotKeyId="Ok">');
        }
        writeFooter();
        write('</div>');
        }
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('accm_det1',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('accm_det1',this);
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
	ObjForm.acctNo.value = acctNo;
	ObjForm.acctname.value = acctname;
	ObjForm.clrBal.value = clrBal;
	ObjForm.custid.value = custid;
	ObjForm.acctOpnDate.value = acctOpnDate;
	ObjForm.lastTranDate.value = lastTranDate;
	ObjForm.schmType.value = schmType;
	for(var i=0;i<iListMaxDisplay;i++)
		{
				document.getElementById('reqId'+i).value =reqId[i];
				document.getElementById('acctNum'+i).value =acctNum[i];
				document.getElementById('acctName'+i).value =acctName[i];
				document.getElementById('reqType'+i).value =reqType[i];
				document.getElementById('status'+i).value =status[i];
				document.getElementById('remrks'+i).value =remrks[i];
				document.getElementById('apprvdAmt'+i).value =apprvdAmt[i];
				document.getElementById('apprvdPrd'+i).value =apprvdPrd[i];
				document.getElementById('cretUser'+i).value =cretUser[i];
				document.getElementById('cretDate'+i).value =cretDate[i];
		}
}
	


function accm_det1_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('accm_det1',obj) == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('accm_det1',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function accm_det1_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('accm_det1',obj) == false) { 
		return false;
	}
	if ((retVal =  fnValidateData(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('accm_det1',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function accm_det1_ONCLICK3(obj,p1)
{
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

function accm_det1_ONCLICK4(obj,p1)
{
        document.forms[0].menuName.value = "ACCM";
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
