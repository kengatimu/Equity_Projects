function printBlock()
{
	writeCustomHeader("cmercha_crit");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031812") + '</td>');
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
	write('<td class="textlabel" style="height: 15px; width: 106px">' + jspResArr.get("FLT020166") + '</td>');
	write('<td>');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode" ' + cmerchaProps.get("funcCode_ENABLED") + '   style="width: 157px">');
	write('<option value="">' + jspResArr.get("FLT031340") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT014584") + '</option>');
	write('<option value="M">' + jspResArr.get("FLT012350") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT013170") + '</option>');
	write('</select>');
	write('</td>');
	write('<td></td>');
	write('<td></td>');
	write('<td></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px; width: 106px">' + jspResArr.get("FLT034257") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" onchange="tabchange()"  class="textfieldfont" name="' + subGroupName + '.LoanAccount" id="LoanAccount" ' + cmerchaProps.get("LoanAccount_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031813") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.LoanAccountName" id="LoanAccountName" ' + cmerchaProps.get("LoanAccountName_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px; width: 106px">' + jspResArr.get("FLT031814") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.CustID" id="CustID" ' + cmerchaProps.get("CustID_ENABLED") + '>');
	write('</td>');
	write('<td></td>');
	write('<td class="textlabel" style="height: 15px; width: 106px">' + jspResArr.get("FLT031815") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.LoanAcid" id="LoanAcid" ' + cmerchaProps.get("LoanAcid_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px; width: 106px">' + jspResArr.get("FLT012932") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.SchemeCode" id="SchemeCode" ' + cmerchaProps.get("SchemeCode_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel" style="height: 15px; width: 106px">' + jspResArr.get("FLT031816") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.MISCode" id="MISCode" ' + cmerchaProps.get("MISCode_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px; width: 106px">' + jspResArr.get("FLT031817") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.LoanDate" id="LoanDate" ' + cmerchaProps.get("LoanDate_ENABLED") + '>');
	write('</td>');
	write('<td></td>');
	write('<td class="textlabel" style="height: 15px; width: 106px">' + jspResArr.get("FLT031818") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.OperativeAccount" id="OperativeAccount" ' + cmerchaProps.get("OperativeAccount_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px; width: 106px">' + jspResArr.get("FLT031819") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.LoanAmount" id="LoanAmount" ' + cmerchaProps.get("LoanAmount_ENABLED") + '>');
	write('</td>');
	write('<td></td>');
	write('<td class="textlabel" style="height: 15px; width: 106px">' + jspResArr.get("FLT002671") + '</td>');
	write('<td>');
	write('<select name="' + subGroupName + '.Status" id="Status" ' + cmerchaProps.get("Status_ENABLED") + '   style="width: 215px">');
	write('<option value="">' + jspResArr.get("FLT031340") + '</option>');
	write('<option value="N">' + jspResArr.get("FLT010527") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT024001") + '</option>');
	write('<option value="P">' + jspResArr.get("FLT009834") + '</option>');
	write('</select>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px; width: 106px">' + jspResArr.get("FLT022552") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.OrderNo" id="OrderNo" ' + cmerchaProps.get("OrderNo_ENABLED") + '>');
	write('</td>');
	write('<td></td>');
	write('<td class="textlabel" style="height: 15px; width: 106px">' + jspResArr.get("FLT031820") + '</td>');
	write('<td>');
	write('<input type="text" onchange="CheckNumeric()" class="textfieldfont" name="' + subGroupName + '.OwnContribAmount" id="OwnContribAmount" ' + cmerchaProps.get("OwnContribAmount_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px; width: 106px">' + jspResArr.get("FLT031821") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.ContributionAccount" id="ContributionAccount" ' + cmerchaProps.get("ContributionAccount_ENABLED") + '>');
	write('</td>');
	write('<td></td>');
	write('<td class="textlabel" style="height: 15px; width: 106px">' + jspResArr.get("FLT031822") + '</td>');
	write('<td>');
	write('<select name="' + subGroupName + '.Recoverfrm" id="Recoverfrm" ' + cmerchaProps.get("Recoverfrm_ENABLED") + '   style="width: 217px; height: 22px">');
	write('<option value="">' + jspResArr.get("FLT031340") + '</option>');
	write('<option value="L">' + jspResArr.get("FLT034257") + '</option>');
	write('<option value="O">' + jspResArr.get("FLT031818") + '</option>');
	write('</select>');
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
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return cmercha_crit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return cmercha_crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('cmercha_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cmercha_crit',this);
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
	ObjForm.LoanAccount.value = LoanAccount;
	ObjForm.LoanAccountName.value = LoanAccountName;
	ObjForm.CustID.value = CustID;
	ObjForm.LoanAcid.value = LoanAcid;
	ObjForm.SchemeCode.value = SchemeCode;
	ObjForm.MISCode.value = MISCode;
	ObjForm.LoanDate.value = LoanDate;
	ObjForm.OperativeAccount.value = OperativeAccount;
	ObjForm.LoanAmount.value = LoanAmount;
	ObjForm.Status.value = Status;
	ObjForm.OrderNo.value = OrderNo;
	ObjForm.OwnContribAmount.value = OwnContribAmount;
	ObjForm.ContributionAccount.value = ContributionAccount;
	ObjForm.Recoverfrm.value = Recoverfrm;
}


function cmercha_crit_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cmercha_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cmercha_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cmercha_crit_ONCLICK2(obj)
{
	var retVal = "";
	if (preEventCall('cmercha_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('cmercha_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}



function tabchange(obj)
{

if ((document.forms[0].funcCode.value=="A")  || (document.forms[0].funcCode.value=="V"))
			{
					//alert("CMERCHA IN IN");
					//alert(funcCode);
					
					var dco=document.forms[0].LoanAccount.value;
					//alert(dco);
				
					var input      = "dco|"+dco;
					var outputNames    = "laonacc|outVal";
					var outputNames    = "cifid|outVal";
					var outputNames    = "schmcode|outVal";
					var outputNames    = "acctopndate|outVal";
					var outputNames    = "disamt|outVal";
					var outputNames    = "ordernumber|outVal";
					var outputNames    = "contribacc|outVal";
					var outputNames    = "acctname|outVal";
					var outputNames    = "loanacid|outVal";
					var outputNames    = "miscode|outVal";
					var outputNames    = "operatacc|outVal";
					var outputNames    = "bankid|outVal";
					var scrName     =   "b_cmercha.scr";
	
				var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var laonacc = value;
					//alert(laonacc);

					var retBuff = retVal.split("|");
					var output = retBuff[2];
					var value = retBuff[3];
					var cifid = value;
					//alert(cifid);

					var retBuff = retVal.split("|");
					var output = retBuff[4];
					var value = retBuff[5];
					var schmcode = value;
					//alert(schmcode);

					var retBuff = retVal.split("|");
					var output = retBuff[6];
					var value = retBuff[7];
					var acctopndate = value;
					//alert(acctopndate);

					var retBuff = retVal.split("|");
					var output = retBuff[8];
					var value = retBuff[9];
					var disamt = value;
					//alert(disamt);

					var retBuff = retVal.split("|");
					var output = retBuff[10];
					var value = retBuff[11];
					var ordernumber = value;
					//alert(ordernumber);

					//var retBuff = retVal.split("|");
					//var output = retBuff[12];
					//var value = retBuff[13];
					//var contribacc = value;
					//alert(contribacc);

					var retBuff = retVal.split("|");
					var output = retBuff[14];
					var value = retBuff[15];
					var acctname = value;
					//alert(acctname);

					var retBuff = retVal.split("|");
					var output = retBuff[16];
					var value = retBuff[17];
					var loanacid = value;
					//alert(loanacid);

					var retBuff = retVal.split("|");
					var output = retBuff[18];
					var value = retBuff[19];
					var miscode = value;
					//alert(miscode);

					var retBuff = retVal.split("|");
					var output = retBuff[20];
					var value = retBuff[21];
					var operatacc = value;
					//alert(operatacc);

					var retBuff = retVal.split("|");
					var output = retBuff[22];
					var value = retBuff[23];
					var bankid = value;
					//alert(bankid);

						document.forms[0].LoanAccountName.value = acctname
						document.forms[0].CustID.value = cifid
						document.forms[0].LoanAcid.value = loanacid
						document.forms[0].SchemeCode.value = schmcode
						document.forms[0].MISCode.value = miscode
						document.forms[0].LoanDate.value = acctopndate
						document.forms[0].OperativeAccount.value = operatacc
						document.forms[0].LoanAmount.value = disamt
						document.forms[0].Status.value = "N"
						document.forms[0].OrderNo.value = ordernumber				
						document.forms[0].Recoverfrm.value = "O"
			}
	
				if (document.forms[0].funcCode.value=="V")  
					{
					alert(document.forms[0].LoanAccount.value);
					var dco1=document.forms[0].LoanAccount.value;
						alert(dco1);
					var input      = "dco1|"+dco1;
					var outputNames    = "OwnContribAmount|outVal";
					var outputNames    = "ContributionAccount|outVal";
					var scrName     =   "b_cmerchaverify.scr";
					var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var owncontrbamt = value;
					alert(owncontrbamt);

					var retBuff = retVal.split("|");
					var output = retBuff[2];
					var value = retBuff[3];
					var owncontracc = value;
					alert(owncontracc);

					document.forms[0].OwnContribAmount.value = owncontrbamt
					document.forms[0].ContributionAccount.value = owncontracc

	                 }
//function validateifnull() 

//function isNumeric()


	/*function CheckNumeric()
	{
	if(isNaN(document.forms[0].OwnContribAmount.value))
		{
		alert("Invalid data format !!.\n\nOnly numbers are allowed.");
		document.forms[0].OwnContribAmount.value="";
		//document.forms[0].OwnContribAmount.focus();
		ObjForm.OwnContribAmount.focus();
		return false;
		}
	}*/

		var retVal = ""
				if ((retVal =  CheckNumeric()) == false) 
								
					{
					
					 return false;
					}

		var retVal = ""
				if ((retVal =  checkMandatoryFields()) == false) 
								
					{
					 return false;
					}
	
			
}


function cmercha_crit_pre_ONCLICK(obj)
	{

		if(obj.id == "Accept" )
			{
				var retVal = ""
					if ((retVal =  checkMandatoryFields()) == false) 
								
					{
					 return false;
					}
			}
		var retVal = ""
				if ((retVal =  checkMandatoryFields()) == false) 
								
				{
				 return false;
				}
	}

/*function ONBLUR(obj)
//function lost_focus()
{

		var retVal = ""
			if ((retVal =  CheckNumeric()) == false) 
						
				{
				 return false;
				}

		var retVal = ""
			if ((retVal =  checkMandatoryFields()) == false) 
						
				{
				 return false;
				}
}*/


/**************************************************************************************
Function Name   :   fnCheckNumeric()
Description     :   This function is called to check if inputed data id numeric.
**************************************************************************************/
	function CheckNumeric()
	{		
		var ObjForm = document.forms[0];
			if(isNaN(ObjForm.OwnContribAmount.value))
				{
				alert("Invalid data format !!.\n\nOnly numbers are allowed.");
				ObjForm.OwnContribAmount.value="";
				ObjForm.OwnContribAmount.focus();
				return false;
				}
		return true;
	}

/**************************************************************************************
Function Name   :   fnCheckMandatoryFields()
Description     :   This function is called to check mandatory fields
**************************************************************************************/
	function checkMandatoryFields()
	{
		var ObjForm = document.forms[0];
			
			if(fnIsNull(ObjForm.LoanAccount.value))
			{
			alert("Enter Loan Account");
			ObjForm.LoanAccount.focus();
			return false;
			}

			if(fnIsNull(ObjForm.LoanAccountName.value))
			{
			alert("Enter Loan Account Name");
			ObjForm.LoanAccountName.focus();
			return false;
			}

			if(fnIsNull(ObjForm.CustID.value))
			{
			alert("Enter Cust ID");
			ObjForm.CustID.focus();
			return false;
			}

			if(fnIsNull(ObjForm.LoanAcid.value))
			{
			alert("Enter Loan Acid");
			ObjForm.LoanAcid.focus();
			return false;
			}

			if(fnIsNull(ObjForm.SchemeCode.value))
			{
			alert("Enter Scheme Code");
			ObjForm.SchemeCode.focus();
			return false;
			}

			if(fnIsNull(ObjForm.MISCode.value))
			{
			alert("Enter MIS Code");
			ObjForm.MISCode.focus();
			return false;
			}

			if(fnIsNull(ObjForm.LoanDate.value))
			{
			alert("Enter Loan Date");
			ObjForm.LoanDate.focus();
			return false;
			}

			if(fnIsNull(ObjForm.OperativeAccount.value))
			{
			alert("Enter Operative Account");
			ObjForm.OperativeAccount.focus();
			return false;
			}

			if(fnIsNull(ObjForm.LoanAmount.value))
			{
			alert("Enter Loan Amount");
			ObjForm.LoanAmount.focus();
			return false;
			}

			if(fnIsNull(ObjForm.OrderNo.value))
			{
			alert("Enter Order No");
			ObjForm.OrderNo.focus();
			return false;
			}

			if(fnIsNull(ObjForm.OwnContribAmount.value))
			{
			alert("Enter Own Contrib Amount");
			ObjForm.OwnContribAmount.focus();
			return false;
			}

			if(fnIsNull(ObjForm.ContributionAccount.value))
			{
			alert("Enter Contribution Account");
			ObjForm.ContributionAccount.focus();
			return false;
			}
return true;
}
