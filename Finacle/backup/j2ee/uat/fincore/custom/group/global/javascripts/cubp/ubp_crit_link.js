<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}




<!-- This function is added for formatting a particular MRH Row -->

function formatRowValue(Obj, colNumber) {

      return Obj;

       }


<!-- This function is added for formatting a particular MRH Row -->

function fnValidateForm(obj){
	objForm = document.forms[0];

	return true;

}

function app_post_ONLOAD()
{
//        document.forms[0].funcCode.focus();
}

function fnBillerId()
{
	///////// modifications done to show biller's name
	var inputNameValues = "";
	var outputNameValues = "billerId|billAcctId|billAcName|bankId|valType";
	var scriptName = "ubpdp026.scr";
	var listHeading = "Biller ID";
	var colHeader = "BILLER ID|A/c ID|Biller Name|Bank ID|Validation Type";
	var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
	var ObjForm = document.forms[0];
	fnOnblurBillerId();

}
function fnOnBlrBillPayRefNum()
{
	//alert("inside fnOnBlrBillPayRefNum");
	var ObjForm = document.forms[0];
	var billerId=ObjForm.billerId.value;
	var payRefNum=ObjForm.payRefNum.value;
	//alert("pay ref num1");
if((payRefNum!="")&&(billerId==""))
{
	//alert("pay ref num2");
	var inputNameValues = "payRefNum|"+payRefNum;
	var outputNames = "errorFlg|errorMsg|billerId|payAcctId|typOfServ|billAcctId|valType|billerCode";
	var scriptName = "ubpdp023.scr";
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	//alert(retVal);
	if(retVal != undefined)
	{
		var token = retVal.split("|");
		var errorFlg = token[1];
		var errorMsg = token[3];
		var billerId = token[5];
		var payAcctId = token[7];
		var typOfServ = token[9];
		var billAcctId = token[11];
		var valType = token[13];
		var billerCode = token[15];

		if(errorFlg == "Y")
		{
			alert(errorMsg);
			ObjForm.payRefNum.focus();
			return false;

		}
		else
		{

			ObjForm.billerId.value=billerId;
			ObjForm.payAcctId.value=payAcctId;
			ObjForm.typOfServ.value=typOfServ;
			ObjForm.billAcctId.value=billAcctId;
			ObjForm.valType.value=valType;
			ObjForm.billerCode.value=billerCode;
			//code added by Pankaj
			ObjForm.AcctNum.value=billAcctId;
			ObjForm.AcctNum.disabled=true;
			//code ended by Pankaj

		}
	}
}

}

function refNumSercher()
{
	var inputNameValues = "";
	var outputNameValues = "refNum|AcctNum|billerId|payAcctId";
	var scriptName = "CR_ACCNUM_SERCHER.scr";
	var listHeading = "REFERANCE NUMBER LIST";
	var colHeader = "Ref Number|Biller Acct Num|Biller Id|Payer Acct Num";
	var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);

	if(document.forms[0].AcctNum.value != "")
	{
		document.forms[0].billAcctId.value = document.forms[0].AcctNum.value;
		var validAcct=fnFetchAcctName(document.forms[0].AcctNum.value);
		if(validAcct==true)
		{
			var ubpresult = fnFetchUbpCrAcctNum();
		}
	}

	if(document.forms[0].payAcctId.value != "")
	{

		if((document.forms[0].payAcctId.value == "NULL") || (document.forms[0].payAcctId.value == "null"))
		{
			document.forms[0].payAcctId.value = "";
		}
		else
		{
			if((a = fnCommonFetchAcctDtls(document.forms[0].payAcctId,'acctName','solId','crncyCode',true,'VALACCTID')) =="false")
			{
				alert("failed");
				return false;
			}
		}
	}		
}

function fnTypOfServ()
{
	var ObjForm = document.forms[0];
	var billerId=ObjForm.billerId.value;
	var valType=ObjForm.valType.value;
	//alert("valType"+valType);
	//if(fnIsNull(billerId))
	if(billerId=="")
	{
		alert("Please enter Biller ID");
		ObjForm.billerId.focus();
		//return false;
	}
	if(billerId!="")
	{
		if(valType=="L")
		{
			alert("For Local Validation Type of Service will not be selected.");
			ObjForm.billerId.focus();
			//return false;
		}
		else
		{
			var inputNameValues = "billerId|"+billerId+"|valType|"+valType;
			var outputNameValues = "typOfServ";
			var scriptName = "ubpdp022.scr";
			var listHeading = "Types Of Service linked to Biller";
			var colHeader = "Type of Service";
			var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
			var ObjForm = document.forms[0];
		}
	}
}
function fnModeOfPay()
{
	var ObjForm = document.forms[0];
	var modeOfPay=ObjForm.funcCode.value;
	if(modeOfPay =="C")
	{
		ObjForm.payAcctId.disabled = true;
		ObjForm.payAcctId.value="";
		hideImage("sLnk2");
		hideImage("payAcctIdSigImg");
		ObjForm.crncyCode.disabled = true;
		ObjForm.solId.disabled = true;
		ObjForm.acctName.disabled = true;
		ObjForm.crncyCode.value="";
		ObjForm.solId.value="";
		ObjForm.acctName.value="";
		hideImage("customExplodeButton");
		//code added by Pankaj
		ObjForm.AcctNum.value="";
		ObjForm.critAcctName.value="";
		ObjForm.critSolId.value="";
		ObjForm.critAcctCrncy.value="";
		//code ended by Pankaj

	}
	else
	{
		ObjForm.payAcctId.disabled = false;
		ObjForm.payAcctId.value="";
		ObjForm.crncyCode.value="";
		ObjForm.solId.value = "";
		ObjForm.acctName.value = "";
		//code added by Pankaj
		ObjForm.AcctNum.value="";
		ObjForm.critAcctName.value="";
		ObjForm.critSolId.value="";
		ObjForm.critAcctCrncy.value="";
		//code ended by Pankaj
		showImage("sLnk2");
		showImage("payAcctIdSigImg");
		showImage("customExplodeButton");
	}
	if(modeOfPay!="R")
	{
		ObjForm.payRefNum.value="";
		ObjForm.payRefNum.disabled = true;
		hideImage("billPayRefSrch");
		ObjForm.typOfServ.disabled = true;
		showImage("typOfServiceSerchr");
		showImage("billerIdSerch");
		ObjForm.billerId.disabled = false;
		//Added
		ObjForm.billerId.value="";
		ObjForm.payAcctId.value="";
		ObjForm.typOfServ.value="";
		ObjForm.billAcctId.value="";
		ObjForm.valType.value="";
		//code added by Pankaj
		ObjForm.AcctNum.value="";
		ObjForm.critAcctName.value="";
		ObjForm.critSolId.value="";
		ObjForm.critAcctCrncy.value="";
		//code ended by Pankaj
	}
	else
	{
		//code commented and added by Pankaj
		//ObjForm.payRefNum.disabled = true;
		ObjForm.payRefNum.disabled=false;
		//code ended by Pankaj
		showImage("billPayRefSrch");
		ObjForm.payAcctId.disabled = true;
		hideImage("sLnk2");
		hideImage("payAcctIdSigImg");
		hideImage("customExplodeButton");
		ObjForm.typOfServ.value="";
		ObjForm.typOfServ.disabled = true;
		hideImage("typOfServiceSerchr");
		ObjForm.billerId.value="";
		ObjForm.billerId.disabled = true;
		hideImage("billerIdSerch");
		//Added
		ObjForm.billerId.value="";
		ObjForm.payAcctId.value="";
		ObjForm.typOfServ.value="";
		ObjForm.billAcctId.value="";
		ObjForm.valType.value="";
		ObjForm.crncyCode.value="";
		ObjForm.solId.value="";
		ObjForm.acctName.value="";
		//code added by Pankaj
		ObjForm.AcctNum.value="";
		ObjForm.critAcctName.value="";
		ObjForm.critSolId.value="";
		ObjForm.critAcctCrncy.value="";
		//code ended by Pankaj

	}

}
function fnOnblurBillerId()
{
	var ObjForm = document.forms[0];
	var billerId=ObjForm.billerId.value;
	//alert("inside onblur of biller Id");
	if(!fnIsNull(billerId))
	{
		var inputNameValues = "billerId|"+billerId;
		var outputNames = "errorFlg|errorMsg|billAcctId|billerCode|valType";
		var scriptName = "ubpdp025.scr";
		var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
		//alert(retVal);
		if(retVal != undefined)
		{
			var token = retVal.split("|");
			var errorFlg = token[1];
			var errorMsg = token[3];
			//alert(ObjForm.billAcctId.value);

			if(errorFlg == "Y")
			{
				alert(errorMsg);
				ObjForm.AcctNum.value="";
				ObjForm.critAcctName.value="";
				ObjForm.critSolId.value="";
				ObjForm.critAcctCrncy.value="";
				ObjForm.billerId.focus();
				return false;

			}
			else
			{
				//alert(ObjForm.billAcctId.value);
				ObjForm.billAcctId.value=token[5];
				ObjForm.billerCode.value=token[7];
				ObjForm.valType.value=token[9];
				//code added by pankaj
				ObjForm.AcctNum.value=token[5];
				//alert("setting a/c number");
				fnFetchAcctName(ObjForm.AcctNum.value);
				//code ended by pankaj
			}
		}
	}
}

//function preEventCall(page,obj,event)
function ubp_crit_pre_ONCLICK(obj)
{
  //if((obj.id == "Accept") && (event == "ONCLICK"))
  if((obj.id == "Accept"))
  {
	  var ObjForm = document.forms[0];
	  var modeOfPay=ObjForm.funcCode.value;
	  var billerId=ObjForm.billerId.value;
	  var billAcctId = ObjForm.billAcctId.value;
	  var payRefNum=ObjForm.payRefNum.value;
	  var AcctNum=ObjForm.AcctNum.value;
	  
	if((modeOfPay=="C")  && (billerId=="") && (document.forms[0].AcctNum.value==""))
	{

			alert("Please enter Biller ID");
			ObjForm.billerId.focus();
			return false;

	}
	if((modeOfPay=="R") && (payRefNum==""))
	{
		alert("Please enter Bill Payment Reference number");
		ObjForm.payRefNum.focus();
		return false;
	}
	
	if((modeOfPay=="C") || (modeOfPay=="T"))
	{			
		//alert("billAcctId"+billAcctId);
		 if(fnIsNull(billAcctId))
		 {
			//alert("if biller a/c id is null");
				var inputNameValues = "billerId|"+billerId;
			var outputNames = "errorFlg|errorMsg|billAcctId|billerCode|valType";
			var scriptName = "ubpdp025.scr";
			var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
			//alert(retVal);
			if(retVal != undefined)
			{
				var token = retVal.split("|");
				var errorFlg = token[1];
				var errorMsg = token[3];
				//alert(ObjForm.billAcctId.value);

				if(errorFlg == "Y")
				{
					alert(errorMsg);
						ObjForm.AcctNum.value="";
						ObjForm.critAcctName.value="";
						ObjForm.critSolId.value="";
						ObjForm.critAcctCrncy.value="";
					ObjForm.billerId.focus();
					return false;

				}
				else
				{
					//alert(ObjForm.billAcctId.value);
					ObjForm.billAcctId.value=token[5];
					ObjForm.billerCode.value=token[7];
					ObjForm.valType.value=token[9];
						//ObjForm.AcctNum.value=token[5];
				}
			}
		}

		if(ObjForm.billAcctId.value!="")
		{
			ObjForm.AcctNum.value=ObjForm.billAcctId.value;
			var validAcctGo=fnFetchAcctName(document.forms[0].AcctNum.value);
			//alert("result from fnFetchAcctName"+validAcctGo);
			if(validAcctGo==true)
			{
				var ubpresultGo = fnFetchUbpCrAcctNum();
				//alert("result from fnFetchUbpCrAcctNum"+ubpresultGo);
				if(ubpresultGo==false)
				{
					return false;
				}
			}
			else
			{	
				return false;
			}
		}

		//alert("val type"+ObjForm.valType.value);
	 	if((ObjForm.valType.value=="LR")||(ObjForm.valType.value=="R"))
	 	{
	 		if(fnIsNull(ObjForm.typOfServ.value))
	 		{
	 			alert("Please select Type of Service from the searcher");
    			ObjForm.typOfServiceSerchr.focus();
    			return false;
	 		}

	 	}
		
	}

	fnOnchange();
	 
	function fnOnchange() {
        var inputNameValues = "acctNum|"+AcctNum;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" )
        {
                alert(ret1[1]);
        }

	}

  }
  //alert("before final go");
return true;
}

function fnShwAcctList()
{
      showAccountIdList(document.forms[0].payAcctId, document.forms[0].solId,document.forms[0].acctName, 'F' , document.forms[0].crncyCode,'','','');
}
/*************************************************************************************
Function Name   :   fnFetchAcctDtls()
Description     :   This function will provide the listing for the account id on click
					of searcher
Input Values    :   None
Output Values   :   None
**************************************************************************************/
function fnFetchAcctDtls(acctObj, acctName, acctSol, acctCrncy, isError, fType)
{
			alert("hii");
    			var objForm = document.forms[0];
                var funcCode=objForm.funcCode.value;
                if(funcCode=="I")
                {

                  if ((retVal = fnCommonFetchAcctDtls(acctObj,acctName,acctSol,acctCrncy,isError,"VALACCTIDWITHCLSDFLG")) == false)
                  {
                       return false;
                  }
                }
                else
                {
                  if ((retVal = fnCommonFetchAcctDtls(acctObj,acctName,acctSol,acctCrncy,isError,"VALCUSTACCTID")) == false)
                   {
                       return false;
                   }
                }
}
function fnbillPayRefNumSrchr()
{
	var inputNameValues = "";
	var outputNameValues = "payRefNum|initEntityId|initEntityTransaction|chargeTransaction|interEntityId|interEntityTransaction";
	var scriptName = "ubpdp021.scr";
	var listHeading = "BILL PAY REF NUM";
	var colHeader = "Bill Pay Ref Num|Init Entity Id|Init Entity Transaction|Charge Transaction|Inter Entity Id|Inter Entity Transaction";
	var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
	var ObjForm = document.forms[0];
	fnOnBlrBillPayRefNum();

}
//code added by Pankaj
function fnShowAccNumCrit()
{
	showAccountIdList(document.forms[0].AcctNum,'','','F');
	var validAcct=fnFetchAcctName(document.forms[0].AcctNum.value);
	//alert("result from fnFetchAcctName"+validAcct);
	if(validAcct==true)
	{
		var ubpresult = fnFetchUbpCrAcctNum();
		//alert("result from fnFetchUbpCrAcctNum"+ubpresult);
	}
}

function fnFetchAcctBillerInfo(critCrAcctName)
{
	//alert("inside on change function of cr a/c number");
	var validAcct=fnFetchAcctName(document.forms[0].AcctNum.value);
	//alert("result from fnFetchAcctName"+validAcct);
	if(validAcct==true)
	{
		var ubpresult = fnFetchUbpCrAcctNum();
		//alert("result from fnFetchUbpCrAcctNum"+ubpresult);
	}
}

function fnFetchAcctName(critCrAcctName)
{
	//alert("inside fnFetchAcctName");
	if(critCrAcctName != "")
	{
		var input = "critCrAcctNum|"+ critCrAcctName;
		var scrName = "ubpdp081.scr";
		var output = "";
		var retVal = appFnExecuteScript(input,"output",scrName,false);
		var acctDtl = new Array();
		acctDtl  = retVal.split("|");
		//alert("output"+acctDtl);
		if(acctDtl[1]=="N")
		{
			alert(acctDtl[3]);
			//alert("if a/c is not valid");
			document.forms[0].critAcctName.value = "";
			document.forms[0].critSolId.value = "";
			document.forms[0].critAcctCrncy.value = "";
			document.forms[0].AcctNum.focus();
			return false;
		}
		else
		{
			document.forms[0].critAcctName.value = acctDtl[3];
			document.forms[0].critSolId.value = acctDtl[5];
			document.forms[0].critAcctCrncy.value = acctDtl[7];
			//alert("returning true from fnFetchAcctName");
			return true;
		}
	 }
	 else
	 {
		document.forms[0].critAcctName.value = "";
		document.forms[0].critSolId.value = "";
		document.forms[0].critAcctCrncy.value = "";
		return false;
	 }	       
}

function fnFetchUbpCrAcctNum()
{
	//alert("inside fnFetchUbpCrAcctNum function");
	var ObjForm = document.forms[0];
	//ObjForm.typOfServ.value="";
	var inputNameValues = "critCrAcctNumUbp|"+ObjForm.AcctNum.value+"|billerId|"+ObjForm.billerId.value;
	var outputNames = "errorFlg|errorMsg|critCrAcctNum|valType";
	var scriptName = "ubpdp083.scr";
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	//alert(retVal);
	if(retVal != undefined)
	{
		var token = retVal.split("|");
		var errorFlg = token[1];
		var errorMsg = token[3];

		if(errorFlg == "Y")
		{
			alert(errorMsg);
			ObjForm.billerId.value= "";
			ObjForm.AcctNum.value="";
			ObjForm.critAcctName.value = "";
			ObjForm.critSolId.value = "";
			ObjForm.critAcctCrncy.value = "";
			ObjForm.AcctNum.focus();
			//alert("return false from fnFetchUbpCrAcctNum");
			return false;
		}
		else
		{
			if(token[9]=="Y")
			{
				if(document.forms[0].billerId.value=="")
				{
					ObjForm.AcctNum.disabled=false;
					ObjForm.AcctNum.value=token[5];
					//ObjForm.billerId.value=token[11];
						if (document.forms[0].AcctNum.value=="1012200698354")
							{
							document.forms[0].billerId.value="1226";
							}
							else

								if (document.forms[0].AcctNum.value=="1032200724265")
									{
									document.forms[0].billerId.value="2560004";
									}
								else
									{
									ObjForm.billerId.value=token[11];
									}
					ObjForm.billerId.disabled = false;
					showImage("billerIdSerch");
					ObjForm.typOfServ.disabled = true;
					showImage("typOfServiceSerchr");
					//alert("returning true");
					return true;
				}
				else
				{
					//alert("token 11"+token[11]);
					//alert("biller id"+document.forms[0].billerId.value.toUpperCase());
					if(document.forms[0].billerId.value.toUpperCase()!=token[11])
					{
						alert("Enter the valid Biller id");
						ObjForm.billerId.value="";
						ObjForm.typOfServ.value="";
						return false;
					}
					else
					{
						ObjForm.AcctNum.value=token[5];
						//alert("returning true from fnFetchUbpCrAcctNum");
						return true;
					}
				}
						
			}
			else
			{
				ObjForm.billerId.disabled = true;
				hideImage("billerIdSerch");
				ObjForm.typOfServ.disabled = true;
				hideImage("typOfServiceSerchr");
				document.forms[0].AcctNum.disabled = false;
				ObjForm.billerId.value="";
				ObjForm.typOfServ.value="";
				ObjForm.AcctNum.value = "";
				return false;
				
			}

		}
	}
}
//code ended by Pankaj

function fnExplodeBalanceDetails(obj){
    var ObjForm = document.forms[0];
    var acctId = obj.value;
    var sUrl = "";
    var urlData = "";
    if(!fnIsNull(acctId)){
        var inputNameValues = "acctId|"+acctId;
        var outputNames = "errorFlg|errorMsg|acctId|solId|crncyCode|acctName|ledgerBal|availableBal|effAvailableBal|freezeStatus|freezeReasonCode|acctClosed|shadowBal|acctStatus|bankId|restrictAccess";
        var scriptName = "ubpdp049.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
        if(token != undefined){
                var iIndex = 1;
                var errorFlg = token[iIndex];
                var errorMsg = token[iIndex+=2];
                var acctId = token[iIndex+=2];
                var solId = token[iIndex+=2];
                var crncyCode = token[iIndex+=2];
                var acctName = token[iIndex+=2];
                var ledgerBal = token[iIndex+=2];
                var availableBal = token[iIndex+=2];
                var effAvailableBal = token[iIndex+=2];
                var freezeStatus = token[iIndex+=2];
                var freezeReasonCode = token[iIndex+=2];
                var acctClosed = token[iIndex+=2];
                var shadowBal = token[iIndex+=2];
                var acctStatus = token[iIndex+=2];
				var bankId = token[iIndex+=2];
                var restrictAccess = token[iIndex+=2];

                if(errorFlg == "Y"){
                        alert(errorMsg);
                        setFieldFocus(obj);
                }else{
                    if(restrictAccess == "Y"){
                                ledgerBal = "**********";
                                availableBal = "**********";
                                effAvailableBal = "**********";
                                shadowBal = "**********";
                    }else{
                        var amountFormat = "Million";
                        var crDrIndicator = "";
                        var prec = getPrec(crncyCode);

                        // Ledger Balance
                        var tmpAmt = parseFloat(ledgerBal);
                        if(tmpAmt < 0){
                                tmpAmt = tmpAmt * (-1);
                                crDrIndicator = "Dr";
                        }else{
                                crDrIndicator = "Cr";
                        }
                        tmpAmt = tmpAmt.toFixed(prec);
                        ObjForm.tmpAmtField.value = tmpAmt;
                        newformatAmt(amountFormat,ObjForm.tmpAmtField,crncyCode,'N');
                        ledgerBal = ObjForm.tmpAmtField.value + " " + crDrIndicator;

                        // Available Balance
                        var tmpAmt = parseFloat(availableBal);
                        if(tmpAmt < 0){
                                tmpAmt = tmpAmt * (-1);
                                crDrIndicator = "Dr";
                        }else{
                                crDrIndicator = "Cr";
                        }
                        tmpAmt = tmpAmt.toFixed(prec);
                        ObjForm.tmpAmtField.value = tmpAmt;
                        newformatAmt(amountFormat,ObjForm.tmpAmtField,crncyCode,'N');
                        availableBal = ObjForm.tmpAmtField.value + " " + crDrIndicator;

                        // Effective Available Balance
                        var tmpAmt = parseFloat(effAvailableBal);
                        if(tmpAmt < 0){
                                tmpAmt = tmpAmt * (-1);
                                crDrIndicator = "Dr";
                        }else{
                                crDrIndicator = "Cr";
                        }
                        tmpAmt = tmpAmt.toFixed(prec);
                        ObjForm.tmpAmtField.value = tmpAmt;
                        newformatAmt(amountFormat,ObjForm.tmpAmtField,crncyCode,'N');
                        effAvailableBal = ObjForm.tmpAmtField.value + " " + crDrIndicator;

                        // Shadow Balance
                        var tmpAmt = parseFloat(shadowBal);
                        if(tmpAmt < 0){
                                tmpAmt = tmpAmt * (-1);
                                crDrIndicator = "Dr";
                        }else{
                                crDrIndicator = "Cr";
                        }
                        tmpAmt = tmpAmt.toFixed(prec);
                        ObjForm.tmpAmtField.value = tmpAmt;
                        newformatAmt(amountFormat,ObjForm.tmpAmtField,crncyCode,'N');
                        shadowBal = ObjForm.tmpAmtField.value + " " + crDrIndicator;
                    }

                        var urlData = "";
                        urlData+= "&acctId="+acctId;
                        urlData+= "&solId="+solId;
                        urlData+= "&crncyCode="+crncyCode;
                        urlData+= "&acctName="+acctName;
                        urlData+= "&ledgerBal="+ledgerBal;
                        urlData+= "&availableBal="+availableBal;
                        urlData+= "&effAvailableBal="+effAvailableBal;
                        urlData+= "&freezeStatus="+freezeStatus;
                        urlData+= "&freezeReasonCode="+freezeReasonCode;
                        urlData+= "&acctClosed="+acctClosed;
                        urlData+= "&shadowBal="+shadowBal;
                        urlData+= "&acctStatus="+acctStatus;
                        urlData+= "&entityId="+bankId;
                        //alert(urlData);

			var sUrl = "../custom/jsp/ubp_acctBal.jsp?";
			sUrl+= urlData;
			//alert("sUrl = "+sUrl);
			var xMax = screen.width, yMax = screen.height;
			var xOffset = (xMax - 120), yOffset = (yMax - 150);
			var params = "dialogWidth=800px;dialogHeight=50px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
			params += ";status=yes;toolbar=yes;menubar=yes;resizable=yes;help=yes;center=no";

			var retVal = "";
			if("Netscape" == browser_name)
			{
				window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");
			}
			else
			{
				retVal = window.popModalWindow(sUrl,"",params);
			}
			if (retVal == null || retVal == undefined)
			{
				return retVal;
			}
                }
        }
    }
    else{
                alert("Enter the Payer A/c. ID");
                ObjForm.payAcctId.focus();
    }
}

function showFinacleSignature()
{
        var bUrl = getBaseUrl();
	var ObjForm = document.forms[0];
        var acctNo = ObjForm.payAcctId.value;

	var errorFlg = "";
	var errorMsg = "";
	var acctBnkId = "";
        var cifIdForSig = "";
	

	if(fnIsNull(acctNo)){
		alert("Enter the Payer A/c. ID");
		ObjForm.payAcctId.focus();
	}else{
		var inputNameValues = "acctNo|"+acctNo;
		var outputNames = "errorFlg|errorMsg|acctBnkId|cifIdForSig|";
		var scriptName = "ubpdp082.scr"
		var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
		var token = retVal.split("|");
		if(token != undefined){
			errorFlg = token[1];
			errorMsg = token[3];
			acctBnkId = token[5];
			cifIdForSig = token[7];

			if(errorFlg == "Y"){
				alert(errorMsg);
				setFieldFocus(ObjForm.payAcctId);
			}
		}

		if(!fnIsNull(cifIdForSig)){
			var signUrl = bUrl + "/finbranch/GetSignature?EntityId=" + acctBnkId + "&CustId=" + cifIdForSig + "&AcctNo=" + acctNo ;
			window.open(signUrl);
		}
	}
}
