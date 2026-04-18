<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : pordmpod_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 06-06-2013
<!--Author            : cate
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HPORDM
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		06-06-2013	CATE		Original version
<!--    0.2		08-08-2013	Priyanka T	Incorporated changes - TO - 357260
<!--    0.3		16-08-2013	Priyansh	Incorporated changes - TO - 367789 
<
!--	0.4		11-09-2013	Mohan Raghu Arudi  Incorporated changes - TO - 372032
<!--	0.5		17-09-2013	Bharath			Modified for TOL 373426 & 373359
<!--    0.6             16-12-2013      Soumya H Pillai  Modified for TOL 375536 
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/custom/javascripts/session.js"> </script>

<script>
	var funcCode2 = funcCode;
        setSValue("funcCode2|"+funcCode2);
	document.write('<input type="hidden" name="tmpAmtField" id="tmpAmtField">');
	document.write('<input type="hidden" name="tmpCcyField" id="tmpCcyField">');
</script>

<script>

//Modified for TOL 375536

function pre_ONLOAD(obj)
{
	if((mopId == "HPORDM"))
	{
		document.forms[0].tresExchRefNo.disabled=true;
		document.forms[0].exchRate.disabled=true;
		document.forms[0].exchRateCode.disabled=true;
		document.forms[0].tresExchRate.disabled=true;
		hideImage("sLnk14");	
		ratecodewrkclscheck();
		getFieldsFromCustomData("pymtRefNum");
		alert(document.forms[0].customData.value);
		var paymentref = document.forms[0].customData.value;
		var paymentreftemp=paymentref.split("|");
		var applcntNo =paymentreftemp[1];
		alert(applcntNo);
	}
	return true;
}
function custom_ONBLUR(obj,obj)
{
    if(obj.id =="drAcct")
{
fnRemitCrncyVal();
}
    if(obj.id =="exchRate")
{
calculateConvertedAmt();
}

 if(obj.id =="ourCorrespBic")
{
alert(ourCorrespBic);
//alert("bank Id is:"+bankId);
	if(document.forms[0].ourCorrespBic.value=="CITIUS33XXX"){
		document.forms[0].senderToRecvrInfo2.value="FXCONV"
	}
}

}

function callExchTranRateDtls()
{
var tempexchRate = document.forms[0].exchRate.value;
var temptresExchRate = document.forms[0].tresExchRate.value;
        convertToCaps();
        if ((fnIsNull(objForm.drAcctCrncy.value)) &&  (!fnIsNull(objForm.drAcct.value)))
        {
                if (! fnCallSendToServerForAccountId(objForm.drAcct,objForm.drAcctCrncy,objForm.drAcctSol,objForm.drAcctName)) return false;
        }
		fnRemitCrncyVal();
        fnEnableDisableRateFlds();
                document.forms[0].exchRate.disabled = true;
                document.forms[0].exchRateCode.disabled = true;
                document.forms[0].tresExchRate.disabled = true;
                document.forms[0].tresExchRefNo.disabled = true;
		hideImage("sLnk14");	
		ratecodewrkclscheck();

        var inputNameValues = "";
        var outputNames = "resultMsg";
        var scriptName = "pordmpoddp001.scr";
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var output = retVal.split("|");
        var result = output[1];
        if(result == "N")
        {
                document.forms[0].exchRate.disabled = true;
                document.forms[0].exchRateCode.disabled = true;
                document.forms[0].tresExchRate.disabled = true;
                document.forms[0].tresExchRefNo.disabled = true;
		hideImage("sLnk14");	
		ratecodewrkclscheck();
        }


        if (isCrossCrncyTranPO())
        {
                if(!fnChkMandatory("exchRateCode")) return false;
                var rv = getRateDtls('myframe','',objForm.remitCrncy.value,objForm.drAcct.value,objForm.drAcctCrncy.value,objForm.exchRateCode,objForm.exchRate,objForm.tresExchRate,objForm.remitAmt.value,objForm.remitCrncy.value);
                if(rv == false)
                {
                        objForm.exchRateCode.focus();
                document.forms[0].exchRate.disabled = true;
                document.forms[0].exchRateCode.disabled = true;
                document.forms[0].tresExchRate.disabled = true;
                document.forms[0].tresExchRefNo.disabled = true;
		hideImage("sLnk14");	
		ratecodewrkclscheck();
                        return false;
                }

        }
	if((tempexchRate != "") && (temptresExchRate != ""))
	{
		document.forms[0].exchRate.value = tempexchRate;
		document.forms[0].tresExchRate.value = temptresExchRate;
	}
               document.forms[0].exchRate.disabled = true;
                document.forms[0].exchRateCode.disabled = true;
                document.forms[0].tresExchRate.disabled = true;
                document.forms[0].tresExchRefNo.disabled = true;
		hideImage("sLnk14");	
		ratecodewrkclscheck();

}

function pordmpod_ONCHANGE7(obj)
{
                document.forms[0].exchRate.disabled = true;
                document.forms[0].exchRateCode.disabled = true;
                document.forms[0].tresExchRate.disabled = true;
                document.forms[0].tresExchRefNo.disabled = true;
		hideImage("sLnk14");	
		ratecodewrkclscheck();
        var retVal = "";
        if (preEventCall('pordmpod',obj,'ONCHANGE') == false) {
                return false;
        }
       if ((retVal = fnRemitCrncyVal()) == false) {
                return false;
        }
	if ((retVal = showAcctDtls()) == false) {
                return false;
        }

        if (preEventCallForLocale('pordmpod',obj,'ONCHANGE') == false) {
                return false;
        }
        if (postEventCallForLocale('pordmpod',obj,'ONCHANGE') == false) {
                return false;
        }
        if (postEventCall('pordmpod',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function pordmpod_ONCHANGE9(obj)
{
                document.forms[0].exchRate.disabled = true;
                document.forms[0].exchRateCode.disabled = true;
                document.forms[0].tresExchRate.disabled = true;
                document.forms[0].tresExchRefNo.disabled = true;
		hideImage("sLnk14");	
		ratecodewrkclscheck();
	var ObjForm = document.forms[0];
	if ((retVal = newformatAmt("Million",ObjForm.remitAmt,ObjForm.remitCrncy.value,'N')) == false) {
                return false;
        }
        fnSetExchRateCode();
        var retVal = "";
        if (preEventCall('pordmpod',obj,'ONCHANGE') == false) {
                return false;
        }
       if ((retVal = fnRemitCrncyVal()) == false) {
                return false;
        }
 
	if (preEventCallForLocale('pordmpod',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = OnchangeRemitAmt()) == false) {
                return false;
        }
        if (postEventCallForLocale('pordmpod',obj,'ONCHANGE') == false) {
                return false;
        }
        if (postEventCall('pordmpod',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function pordmpod_ONCHANGE11(obj)
{
                document.forms[0].exchRate.disabled = true;
                document.forms[0].exchRateCode.disabled = true;
                document.forms[0].tresExchRate.disabled = true;
                document.forms[0].tresExchRefNo.disabled = true;
		hideImage("sLnk14");	
		ratecodewrkclscheck();
	var ObjForm = document.forms[0];
	if ((retVal = newformatAmt("Million",ObjForm.remitAmt,ObjForm.remitCrncy.value,'N')) == false) {
                return false;
        }
        var retVal = "";
        if (preEventCall('pordmpod',obj,'ONCHANGE') == false) {
                return false;
        }
        if (preEventCallForLocale('pordmpod',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = OnchangeRemitAmt()) == false) {
                return false;
        }
        if (postEventCallForLocale('pordmpod',obj,'ONCHANGE') == false) {
                return false;
        }
        if (postEventCall('pordmpod',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function fnSetExchRateCode(){
        document.forms[0].remitCrncy.value = document.forms[0].remitCrncy.value.toUpperCase();
        if ((document.forms[0].remitCrncy.value=="USD")||(document.forms[0].remitCrncy.value=="GBP") ||

        (document.forms[0].remitCrncy.value=="EUR") ||(document.forms[0].remitCrncy.value=="JPY")

        ||(document.forms[0].remitCrncy.value=="CHF")||(document.forms[0].remitCrncy.value=="ZAR")

        ||(document.forms[0].remitCrncy.value=="CAD") ||(document.forms[0].remitCrncy.value=="AUD")

        ||(document.forms[0].remitCrncy.value=="SEK") ||(document.forms[0].remitCrncy.value=="NOK")

        ||(document.forms[0].remitCrncy.value=="DKK ")){

                document.forms[0].exchRateCode.value="TTS";

        }

}

/*function pordmpod_post_ONCHANGE(obj)
{
	if (obj.id == "remitCrncy" || obj.id == "drAcct" || obj.id == "remitAmt" || obj.id == "exchRateCode" || obj.id == "exchRate") 
	{
		if((!fnIsNull(objForm.remitCrncy.value)) && (!fnIsNull(objForm.drAcctCrncy.value)))
        	{
               		calculateConvertedAmt();
		}
	}

}*/


//jane start

if(mopId == "HPORDM")
{
	function pordmpod_post_ONLOAD(obj)
	{ 
		var tempexchRate = document.forms[0].exchRate.value;
		var temptresExchRate = document.forms[0].tresExchRate.value;
		var tempexchRateCode = document.forms[0].exchRateCode.value;
		document.forms[0].tresExchRefNo.disabled=true;
		document.forms[0].exchRate.disabled=true;
		document.forms[0].exchRateCode.disabled=true;
		document.forms[0].tresExchRate.disabled=true;
		hideImage("sLnk14");	
		ratecodewrkclscheck();

		if (profileId == 54)
		{
			if( (document.forms[0].orderType.value == "CT") && (funcCode == "M"))
			{
				getFieldsFromCustomData("pymtRefNum");
				var paymentref = document.forms[0].customData.value;
				alert (paymentref);
				if((funcCode == 'M') && (pymtRefNum!=""))
				{
					var inputNameValues  = "pymtRefNum|"+pymtRefNum;
					var outputNames = "resultMsg";
					var scriptName = "PordMChk.scr";
					var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
					var output = retVal.split("|");
					var FIUSR = output[1];
					var Channel = output[3];
				}
				else
				{
					var FIUSR = "N";
					var Channel= "NA";
				}
				alert(Channel);
				if (FIUSR =='Y') 
				{
					var obj = document.forms[0];
					obj.benefPartyName.disabled = true;
					obj.benefPartyAddress1.disabled = true;
					obj.benefPartyAddress2.disabled = true;
					obj.benefPartyAddress3.disabled = true;
					obj.benefPartyCntryCode.disabled = true;
					obj.remitCrncy.disabled= true;
					obj.drAcct.disabled= true;
					obj.remitInfo1.disabled = true;
					obj.awiBankCode.disabled = true;
					obj.crchrgAcct.disabled = true;
					obj.awiAcct.disabled = true;
					obj.awiCntryCode.disabled = true;
					obj.chrgAcct.disabled = true;
					obj.remitAmt.disabled = true;
					obj.benefPartyAcct.disabled = true;
					obj.purposeCode.disabled = true;
					obj.awiBic.disabled = true;
					obj.crAcct.disabled = true;
					obj.ourCorrespBranchCode.disabled = true;
					obj.routedPaysysId.disabled = true;
					obj.ourCorrespBic.disabled = true;
					obj.ourCorrespBankCode.disabled = true;
					obj.chrgEventId.disabled = true;
					obj.chargeOption.disabled = true;
					obj.pTranRefNum.disabled = true;
					obj.awiAddrInd.disabled = true;
					obj.awiBranchCode.disabled = true;
					obj.benefPartyAddrInd.disabled = true;
				}
			}
		}



	if((document.forms[0].tresExchRefNo.value != "") && (document.forms[0].exchRate.value != "") && (document.forms[0].remitAmt.value != ""))
	{
		calculateConvertedAmt();
	}
	fnToggleTextDisplay("senderToRecvrInfoShow");
	fnToggleTextDisplay("remitInfoShow");
	//document.forms[0].senderToRecvrInfo1.disabled=true;
	document.forms[0].senderToRecvrInfo2.disabled=false;
	document.forms[0].senderToRecvrInfo3.disabled=true;
	document.forms[0].senderToRecvrInfo4.disabled=true;
	document.forms[0].senderToRecvrInfo5.disabled=true;
	document.forms[0].senderToRecvrInfo6.disabled=true;

        var inputNameValues = "";
        var outputNames = "resultMsg";
        var scriptName = "pordmpoddp001.scr";
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var output = retVal.split("|");
	var result = output[1];	
	if(result == "N")
	{
                document.forms[0].exchRate.disabled = true;
                document.forms[0].exchRateCode.disabled = true;
                document.forms[0].tresExchRate.disabled = true;
                document.forms[0].tresExchRefNo.disabled = true;
		hideImage("sLnk14");	
		ratecodewrkclscheck();
	}	

	if(document.forms[0].customData.value != "")
       	{
		getFieldsFromCustomData("convertedAmt","convertedCrncy");
			//alert(document.forms[0].customData.value);
			paymentref = document.forms[0].customData.value;
			var paymentreftemp=paymentref.split("|");
			var applcntNo =paymentreftemp[1];
			//alert(applcntNo);
			if ((applcntNo!="") && (profileId=="55"))
			{
				//alert("am in");
				var inputNameValues = "applcntNo" + "|" + applcntNo ;
				//var inputNameValues = "applcntNo" + "|" + remitInfo1;
				var outputNames = "";
				var scrName = "b_controlnumberval.scr";
				var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
				//alert(retVal);
				var ret = retVal.split("|");
				var a = ret[1];
				if(ret[0] == "MSG1"){	
					alert(a);
					//alert("its ok");
					}
				var b = ret[3];
				if(ret[2] == "MSG2"){	
					//alert(b);
				}
				var c = ret[5];
				if(ret[4] == "MSG3"){	
					//alert(c);
				}
				//alert("am in 2");

				var d = ret[7];
				if(ret[6] == "MSG4"){	
					//alert(d);
				}
					//alert("am in");
				var e = ret[9];
				if(ret[8] == "MSG5"){	
					//alert(e);
				}

				var f = ret[11];
				if(ret[10] == "MSG6"){	
					//alert(f);
				}
				var g = ret[13];
				if(ret[12] == "MSG7"){	
					//alert(f);
				}

				document.forms[0].benefPartyName.value=b;
				document.forms[0].benefPartyAddress1.value=g;
				document.forms[0].remitAmt.value=c;
				document.forms[0].remitAmt.disabled=true;
				document.forms[0].benefPartyAcct.value=f;
				document.forms[0].senderToRecvrInfo2.value=e;
				document.forms[0].remitInfo1.value=d;
				document.forms[0].awiAddrInd.value="B"
				document.forms[0].awiBic.value="TARATZTZXXX"
				document.forms[0].purposeCode.value="2B15"
				//document.forms[0].awiBankCode.value="01"
				//document.forms[0].awiBranchCode.value="6701"
				

					if (a=="FAILURE")
					{
						alert(b);
						document.forms[0].remitInfo1.focus();
						return false;
					}

			}
	}

	if(document.forms[0].drAcct.value != "")
	{
		if(document.forms[0].drAcctCrncy.value != document.forms[0].remitCrncy.value)
		{
			fnRemitCrncyVal();
			calculateConvertedAmt();
		}
	}

	//Added for tol 373426
	if( (document.forms[0].orderType.value == "CT") && (funcCode == "A") )
	{
		var retVal
		var obj = document.forms[0];
		obj.benefPartyAddrInd.selectedIndex = 4;
		obj.benefPartyAddrInd.disabled = true;
		obj.benefPartyName.disabled = false;
		obj.benefPartyAddress1.disabled = false;
		obj.benefPartyAddress2.disabled = false;
		obj.benefPartyAddress3.disabled = false;
		obj.benefPartyCntryCode.disabled = false;
		document.forms[0].benefPartyAddrInd.value="A";
		//obj.benefPartyAcct.disabled = true;
		obj.awiAcct.disabled = true;
        }

		if( (document.forms[0].orderType.value == "CT") && (funcCode == "V") )
		{
			if ((document.forms[0].chargeOption.value=="OUR")&&(document.forms[0].routedPaysysId.value=="SWIFT"))
					{
					 document.forms[0].chrgEventId.value="SWIFTOUR";
					}
		}
		if((tempexchRate != "") && (temptresExchRate != ""))
		{
			document.forms[0].exchRate.value = tempexchRate;
			document.forms[0].tresExchRate.value = temptresExchRate;
		}
		document.forms[0].exchRateCode.value = tempexchRateCode;
	}
	function pordmpod_pre_ONCLICK(obj)
	{
	if((obj.id=="Submit") || (obj.id=="Validate"))
				{
				if(document.forms[0].purposeCode.value == "")
					{
					alert("Enter Purpose Code");
					document.forms[0].purposeCode.focus();
					return false;
					}
					//kate starts
					if(document.forms[0].remitInfo1.value == "")
							{
					  alert("Enter Remitance Info");
					document.forms[0].remitInfo1.focus();
					return false;
							}
					if (document.forms[0].awiBic.value=="CBKEKENXXXX")
						{
						
							
							if (document.forms[0].deptNum.value == "")
							{
								alert("Enter dept no.");
								document.forms[0].deptNum.focus();
								return false;
							}

						}
							//kate ends

				/*	if ((document.forms[0].awiBic.value=="TARATZTZXXX")&& ((document.forms[0].drAcct.value!="3006211183832")&&(document.forms[0].drAcct.value!="3006211183830")))
						{
						
							//alert("am in");
							//alert(document.forms[0].awiBic.value);
								var remitInfo1=document.forms[0].remitInfo1.value;
								var remitAmt=document.forms[0].remitAmt.value;
								var benefPartyAcct=document.forms[0].benefPartyAcct.value;
							//if (applcntRefNo!="")
							//{
									//alert ("am in");
									//alert (addrLine3);
									var inputNameValues = "applcntNo" + "|" + remitInfo1 ;
									//var inputNameValues = "applcntNo" + "|" + remitInfo1;
									var outputNames = "";
									//var scrName = "b_controlnumberval.scr";
									var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
									//alert(retVal);
									var ret = retVal.split("|");
									var a = ret[1];
									if(ret[0] == "MSG1"){	
										alert(a);
										//alert("its ok");
										}
									var b = ret[3];
									if(ret[2] == "MSG2"){	
										alert(b);
									}
									var c = ret[5];
									if(ret[4] == "MSG3"){	
										alert(c);
									}
									//alert("am in 2");

									var d = ret[7];
									if(ret[6] == "MSG4"){	
										alert(d);
									}
										//alert("am in");
									var e = ret[9];
									if(ret[8] == "MSG5"){	
										alert(e);
									}

									var f = ret[11];
									if(ret[10] == "MSG6"){	
										alert(f);
									}

									//document.forms[0].benefPartyName.value=b;
									document.forms[0].remitAmt.value=c;
									document.forms[0].benefPartyAcct.value=f;
									document.forms[0].senderToRecvrInfo2.value=e;
										if (a=="FAILURE")
										{
											alert(b);
											document.forms[0].remitInfo1.focus();
											return false;
										}

						}*/
					/*
					if(document.forms[0].awiAcct.value == "")
								{
					  alert("Enter value in the field");
					document.forms[0].awiAcct.focus();
					return false;
								}
					*/

				
					//Added for tol 373426
       					if (nameAndAddressMand() == false) {
							return false;
        				}

						if ((document.forms[0].chargeOption.value=="OUR")&&(document.forms[0].routedPaysysId.value=="SWIFT"))
						{
						 document.forms[0].chrgEventId.value="SWIFTOUR";
						}
				var tresExchRefNo = document.forms[0].tresExchRefNo.value;
				if(tresExchRefNo != "")
				{
					var tresExchRate = document.forms[0].tresExchRate.value; 
					var exchRateCode = document.forms[0].exchRateCode.value; 
					var exchRate = document.forms[0].exchRate.value; 
					var remitCrncy = document.forms[0].remitCrncy.value; 
					var drAcctCrncy = document.forms[0].drAcctCrncy.value; 
					var remitAmt = document.forms[0].remitAmt.value;
					remitAmt = removeCommas(remitAmt);
					var inputNameValues = "remitCrncy|"+remitCrncy+"|drAcctCrncy|"+drAcctCrncy+"|exchRateCode|"+exchRateCode+"|tresExchRate|"+tresExchRate+"|exchRate|"+exchRate+"|tresExchRefNo|"+tresExchRefNo+"|remitAmt|"+remitAmt;
        				var outputNames = "errorFlg|errorMsg";
        				var scriptName = "pordmtreasval.scr"
        				var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        				var token = retVal.split("|");
					var errorFlg = token[1];
					var errorMsg = token[3];
					if(errorFlg == "Y")
					{
						alert(errorMsg);
						document.forms[0].tresExchRefNo.focus();
						return false;
					}	

				}
			}
	
	setFieldsToCustomData("convertedAmt","convertedCrncy");
	return true;
	}

	function pordmpod_pre_TAB_SWITCH()
	{

				/*if ((document.forms[0].awiBic.value=="TARATZTZXXX")&& ((document.forms[0].drAcct.value!="3006211183832")&&(document.forms[0].drAcct.value!="3006211183830")))
						{

							if(document.forms[0].remitInfo1.value == "")
								{
								  alert("Enter Control number");
								document.forms[0].remitInfo1.focus();
								return false;
								}
						
							//alert("am in");
							//alert(document.forms[0].awiBic.value);
								var remitInfo1=document.forms[0].remitInfo1.value;
								var remitAmt=document.forms[0].remitAmt.value;
								var benefPartyAcct=document.forms[0].benefPartyAcct.value;
							//if (applcntRefNo!="")
							//{
									//alert ("am in");
									//alert (addrLine3);
									var inputNameValues = "applcntNo" + "|" + remitInfo1;
									//var inputNameValues = "applcntNo" + "|" + remitInfo1;
									var outputNames = "";
									//var scrName = "b_controlnumberval.scr";
									var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
									var ret = retVal.split("|");
									var a = ret[1];
									if(ret[0] == "MSG1"){	
										alert(a);
										//alert("its ok");
										}
									var b = ret[3];
									if(ret[2] == "MSG2"){	
										alert(b);
									}
									var c = ret[5];
									if(ret[4] == "MSG3"){	
										alert(c);
									}

									var d = ret[7];
									if(ret[6] == "MSG4"){	
										alert(d);
									}

									var e = ret[9];
									if(ret[8] == "MSG5"){	
										alert(e);
									}

									var f = ret[11];
									if(ret[10] == "MSG6"){	
										alert(f);
									}

									//document.forms[0].benefPartyName.value=b;
									document.forms[0].remitAmt.value==c;
									document.forms[0].benefPartyAcct.value==f;
									document.forms[0].senderToRecvrInfo2.value==e;
										if (a=="FAILURE")
										{
											alert(b);
											document.forms[0].remitInfo1.focus();
											return false;
										}

						}*/
	setFieldsToCustomData("convertedAmt","convertedCrncy");
		//Added for tol 373426
       	if (nameAndAddressMand() == false) {
			return false;
       	}
        	return true;
	}

	function  pordmpod_post_ONCLICK(obj)
	{
		setFieldsToCustomData("convertedAmt","convertedCrncy");
                return true;
	}
}

//jane end
function  pordmpod_pre_ONCLICK(obj)
{
///Edwin Start
	if(document.forms[0].drAcct.value != "")
	{
		if (profileId == 54)
		{
			var acct = document.forms[0].drAcct.value;
			var inputNameValues =  "acctNum|"+ acct;
			var outputNames     = "";
			var scrName         = "ePordAccVal.scr";
			var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			if(a == "Y")
			{
				var radioButtons = document.getElementsByName('waiverCharges');
				radioButtons[0].checked = true;
				radioButtons[0].disabled = true;
				radioButtons[1].disabled = true;
				return true;
			}
			else
			{
				var radioButtons = document.getElementsByName('waiverCharges');
				radioButtons[0].enabled = true;
				radioButtons[1].enabled = true;
				radioButtons[1].checked = true;				
				return true;
			}
		}
	}

////-------edwin
}


function calculateConvertedAmt()
{
	//fnRemitCrncyVal();
	var ObjForm = document.forms[0];

	var ObjForm = document.forms[0];
	ObjForm.tmpAmtField.value = ObjForm.remitAmt.value;
        ObjForm.tmpCcyField.value = ObjForm.remitCrncy.value.toUpperCase();
        if ((retVal = newformatAmt("Million",ObjForm.tmpAmtField,ObjForm.tmpCcyField.value,'N')) == false) {
                return false;
        }
        var acctCrncy = ObjForm.drAcctCrncy.value.toUpperCase();
        var refCrncy = ObjForm.tmpCcyField.value.toUpperCase();
        var refAmtTmp = ObjForm.tmpAmtField.value;
        var refAmt = removeCommas(refAmtTmp);
        var rateCode = ObjForm.exchRateCode.value.toUpperCase();
        var rateTmp = ObjForm.exchRate.value;
        var rate = removeCommas(rateTmp);
	if(parseFloat(rate) == 0){
		rate = "";
	}
        var inputNameValues = "refCrncy|"+refCrncy+"|acctCrncy|"+acctCrncy+"|refAmt|"+refAmt+"|rateCode|"+rateCode+"|rate|"+rate;
        var outputNames = "errorFlg|errorMsg|rate|tranAmt|tranAmtCcy";
        var scriptName = "pordmdp001.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
        if(token != undefined){
                var errorFlg = token[1];
                var errorMsg = token[3];
                var rate = token[5];
                var convertedAmt = token[7];
                var convertedCrncy = token[9];

                if(errorFlg == "Y"){
                        alert(errorMsg);
                        ObjForm.convertedAmt.value = "";
                        ObjForm.convertedCrncy.value = "";
                        ObjForm.exchRate.value = "";
                        setFieldFocus(ObjForm.refCrncy);
                        return false;

                }else{
                        //ObjForm.exchRate.value = rate;
                        ObjForm.convertedAmt.value = convertedAmt;
                        ObjForm.convertedCrncy.value = convertedCrncy;
                        newformatAmt("Million",ObjForm.convertedAmt,ObjForm.convertedCrncy.value,'N');
                }
        }

        return;
}
function appFnExecuteScript(inputNameValues, outputNames, scrName, isPopulationReq)
{
        var sUrl = "../custom/jsp/cust_frm_fetch.jsp?";

        if(!cust_fnIsNull(inputNameValues))
                sUrl += "&inputs="+ encodeURIComponent(inputNameValues);


        if(cust_fnIsNull(scrName))
        {
                alert("Script Name is mandatory");
                return;
        }

        sUrl += "&scrName="+scrName;

        if (isPopulationReq && cust_fnIsNull(outputNames))
        {
                alert("Output Names are mandatory");
                return;
        }

        var xMax = screen.width, yMax = screen.height;
        var xOffset = (xMax - 120), yOffset = (yMax - 150);
        var params = "dialogWidth=0px;dialogHeight=0px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
        params += ";status=no;toolbar=no;menubar=no;resizable=yes;help=no;center=no";

        var retVal = "";
        if("Netscape" == browser_name)
                window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");
        else
        {
                retVal = window.showModalDialog(sUrl,"",params);
        }

        if (retVal == null || retVal == undefined)
                return retVal;

        var retBuff = retVal.split("|");
        var retBuffLen = retBuff.length;
        if (retBuff[0] == 'Err')
        {
                var str = "";
                for (var i=1; i<retBuffLen; i++)
                {
                        str += retBuff[i] + "\n";
                }
                return;
        }

        if (!isPopulationReq)
                return retVal;

        var frm = document.forms[0];
        var outBuff = outputNames.split("|");
        var outBuffLen = outBuff.length;

        for (var i=0; i<outBuffLen; i++)
        {
        for (var j=0; j<retBuffLen; j++)
                {
                        if (outBuff[i] == retBuff[j])
                        {
                                if ((eval("frm." + outBuff[i]) != undefined))
                                {
                                        eval("frm."+outBuff[i]+".value=\""+retBuff[j+1]+"\"");
                                        break;
                                }
                        }
                }
        }
}

function cust_fnIsNull(str)
{
        str = cust_fnTrim(str);
        if (str == null || str == "")
                return true;
        return false;
}

function cust_fnTrim(str)
{
        var cnt;

        len = str.length;
        var str = str;
        begin = -1;
        for(cnt=0;cnt<len;cnt++)
        {
                if (str.charAt(cnt) == " ")
                        begin = cnt;
                else
                        break;
        }
        str = str.slice(begin+1,len);
        len = str.length;
        end = len;
        for(cnt=len-1;cnt>=0;cnt--)
        {
                if (str.charAt(cnt) == " ")
                        end = cnt;
                else
                        break;
        }
        str = str.slice(0,end);
        return str;
}

//Added for tol 373426
function nameAndAddressMand()
{ 

	var obj = document.forms[0];
	if( (document.forms[0].orderType.value == "CT") && (funcCode == "A") )
	{
		if (document.forms[0].awiBic.value!="TARATZTZXXX")
		{
		
			if( obj.benefPartyName.value == "" )
			{
				alert("Enter Beneficiary Name"); 
				obj.benefPartyName.focus();
				return false;
			}

			if( obj.routedPaysysId.value == "SWIFT" )
			{
				if( obj.benefPartyAddress1.value == "" )
				{
					alert("Enter Address Line 1"); 
					obj.benefPartyAddress1.focus();
					return false;
				}

				//obj.benefPartyAddress1.value=benefPartyAddress1.substring(0 ,33);
				/*if( obj.benefPartyAddress2.value == "" )
				{
					alert("Enter Address Line 2"); 
					obj.benefPartyAddress2.focus();
					return false;
				}*/
			}

			if( obj.benefPartyAcct.value == "" )
			{
				alert("Enter Beneficiary Account Number "); 
				obj.benefPartyAcct.focus();
				return false;
			}

			if( obj.benefPartyCntryCode.value == "" )
			{
				alert("Enter Beneficiary Country");
				obj.benefPartyCntryCode.focus();
				return false;
			}
		}

		if (obj.awiAddrInd.value != "B" )
		{
			if(  (((obj.benefPartyCntryCode.value).toUpperCase() == "US") || ((obj.benefPartyCntryCode.value).toUpperCase() == "USA")) && ((obj.remitCrncy.value).toUpperCase() == "USD") )
			{
				if( obj.senderToRecvrInfo1.value == "" )
				{
					alert("Enter Fed Wire Number/Sort Code");
					obj.senderToRecvrInfo1.focus();
					return false;
				}
			}

			if( (((obj.benefPartyCntryCode.value).toUpperCase() == "GB") || ((obj.benefPartyCntryCode.value).toUpperCase() == "UK")) && ((obj.remitCrncy.value).toUpperCase() == "GBP") )
			{
				if( obj.senderToRecvrInfo1.value == "" )
				{
					alert("Enter Fed Wire Number/Sort Code");
					obj.senderToRecvrInfo1.focus();
					return false;
				}
			}

			if(((obj.remitCrncy.value).toUpperCase() == "USD") && (((obj.benefPartyCntryCode.value).toUpperCase() == "USA") || ((obj.benefPartyCntryCode.value).toUpperCase() == "US")) )
			{
				if( obj.senderToRecvrInfo1.value.length > 9 )
				{
					alert("Fed Wire Number/Sort Code can not be more than 9 digits");
					obj.senderToRecvrInfo1.focus();
					return false;
				}
			}

			if(((obj.remitCrncy.value).toUpperCase() == "GBP") && (((obj.benefPartyCntryCode.value).toUpperCase() == "UK") || ((obj.benefPartyCntryCode.value).toUpperCase() == "GB")) )
			{
				if( obj.senderToRecvrInfo1.value.length > 6 )
				{
					alert("Fed Wire Number/Sort Code can not be more than 6 digits");
					obj.senderToRecvrInfo1.focus();
					return false;
				}
			}
		}
		else
		{
			obj.senderToRecvrInfo1.value = "";
		}
	}
	if( (document.forms[0].orderType.value == "BT") && (funcCode == "A") )
	{
		
		if( obj.awiCntryCode.value == "" )
		{
			alert("Enter Account with Institution Country Code");
			obj.awiCntryCode.focus();
			return false;
		}
	}
	return true;
}

//Watchlist START Edwin.zico
function pordmpod_pre_ONCHANGE(obj) 
{
	if (profileId == 54)
    {
		if (obj.id == "drAcct") 
		{
			//alert("amin");
			if (obj.value != "") 
			{
				//alert("amin2");
				//if(document.forms[0].drAcct.value != "")
				//{
					//alert("ami3");
					var acct = document.forms[0].drAcct.value;
					var inputNameValues =  "acctNum|"+ acct;
					var outputNames     = "";
					var scrName         = "ebCamlAccVal.scr";
					var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var a = value;
					if(a == "Y")
					{
						alert("AML check!!! customer is watchlisted");
						return true;
					}
					else
					{
						if(a == "B")
						{
							alert("AML check!!! customer is Blacklisted");
							document.forms[0].drAcct.focus();
							clearDescField("drAcct");
							return false;
						}
					}
				//}
			}
		}
	}
}	

//Watchlist END Edwin.zico

function pordmpod_post_ONCHANGE(objct)
{
        //if (objct.id == "remitCrncy" || objct.id == "drAcct" || objct.id == "remitAmt" || objct.id == "exchRateCode" || objct.id == "exchRate")
        if (objct.id == "remitCrncy" || objct.id == "drAcct" || objct.id == "remitAmt" || objct.id == "exchRateCode" || objct.id == "exchRate" || objct.id == "tresExchRefNo")
        {
                if((!fnIsNull(objForm.remitCrncy.value)) && (!fnIsNull(objForm.drAcctCrncy.value)))
                {
                        calculateConvertedAmt();
                }
        }

	var obj = document.forms[0];
	if( objct.id == "awiAddrInd" )
	{
		if (objct.value != "B" )
		{
			if(  (((obj.benefPartyCntryCode.value).toUpperCase() == "US") || ((obj.benefPartyCntryCode.value).toUpperCase() == "USA")) && ((obj.remitCrncy.value).toUpperCase() == "USD") )
			{
				if( obj.senderToRecvrInfo1.value == "" )
				{
					alert("Enter Fed Wire Number/Sort Code");
					obj.senderToRecvrInfo1.focus();
					return false;
				}
			}

			if( (((obj.benefPartyCntryCode.value).toUpperCase() == "GB") || ((obj.benefPartyCntryCode.value).toUpperCase() == "UK")) && ((obj.remitCrncy.value).toUpperCase() == "GBP") )
			{
				if( obj.senderToRecvrInfo1.value == "" )
				{
					alert("Enter Fed Wire Number/Sort Code");
					obj.senderToRecvrInfo1.focus();
					return false;
				}
			}

			if(((obj.remitCrncy.value).toUpperCase() == "USD") && (((obj.benefPartyCntryCode.value).toUpperCase() == "USA") || ((obj.benefPartyCntryCode.value).toUpperCase() == "US")) )
			{
				if( obj.senderToRecvrInfo1.value.length > 9 )
				{
					alert("Fed Wire Number/Sort Code can not be more than 9 digits");
					obj.senderToRecvrInfo1.focus();
					return false;
				}
			}

			if(((obj.remitCrncy.value).toUpperCase() == "GBP") && (((obj.benefPartyCntryCode.value).toUpperCase() == "UK") || ((obj.benefPartyCntryCode.value).toUpperCase() == "GB")) )
			{
				if( obj.senderToRecvrInfo1.value.length > 6 )
				{
					alert("Fed Wire Number/Sort Code can not be more than 6 digits");
					obj.senderToRecvrInfo1.focus();
					return false;
				}
			}
		}
		else
		{
			obj.senderToRecvrInfo1.value = "";
		}
	}
        var inputNameValues = "";
        var outputNames = "resultMsg";
        var scriptName = "pordmpoddp001.scr";
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var output = retVal.split("|");
        var result = output[1];
        if(result == "N")
        {
                document.forms[0].exchRate.disabled = true;
                document.forms[0].tresExchRate.disabled = true;
		ratecodewrkclscheck();
        }


}
</script>
<script language="Javascript">
function fnRemitCrncyVal()
{
if((funcCode == "A") || (funcCode == "M") || (funcCode == "C"))
{
	var tresExchRefNo = document.forms[0].tresExchRefNo.value;
	if((tresExchRefNo == "")|| (tresExchRefNo == " "))
	{
		var acctCrncy = document.forms[0].drAcctCrncy.value;
		var refCrncy = document.forms[0].remitCrncy.value;
		var inputNameValues = "acctCrncy|" + acctCrncy +"|refCrncy|" + refCrncy + "|tranType|" + tranType;
		var outputNames = "rateCode|rate|treaRate|errorFlg|errorMsg";
		var scrName="ratehpordm001.scr";
		var retVal = appFnExecuteScript(inputNameValues,outputNames,scrName,false);
        var result      = retVal.split("|");
        var rateCode      = result[1];
        var rate      = result[3];
        var treaRate      = result[5];
		var errorFlg = result[7];
		var errorMsg = result[9];

		if(errorFlg!="Y")
		{
			document.forms[0].exchRateCode.value=rateCode;
			document.forms[0].exchRate.value=rate;
			document.forms[0].exchRateCode.disabled=true;
			document.forms[0].exchRate.disabled=true;
			document.forms[0].tresExchRate.value=treaRate;
			//document.forms[0].treaRate.disabled=true;
			hideImage("sLnk14");
			ratecodewrkclscheck();
		}
		else
		{
			document.forms[0].exchRateCode.value ='';
			document.forms[0].exchRate.value ='';
			document.forms[0].exchRateCode.disabled=false;
			document.forms[0].exchRate.disabled=false;
			document.forms[0].tresExchRate.value='';
			//document.forms[0].treaRate.disabled=false;
			//showImage("sLnk14");
                document.forms[0].exchRate.disabled = true;
                document.forms[0].exchRateCode.disabled = true;
                document.forms[0].tresExchRate.disabled = true;
                document.forms[0].tresExchRefNo.disabled = true;
			hideImage("sLnk14");	
			ratecodewrkclscheck();
		}
	}
}
return true;
}

function ratecodewrkclscheck()
{
        //var workClass = workClass;
        //var inputNames = "workClass|" + workClass;
        var inputNames = "";
        var outputNames = "";
        var scr = "workclassCheck.scr";
        var retVal = appFnExecuteScript(inputNames, outputNames, scr, false);
        var result = retVal.split("|");
        var errFlg = result[1];
        var errMsg = result[3];
        var wrkclsFlg = result[5];

        if(errFlg == "N")
        {
                if (wrkclsFlg == "Y")
                {
                        document.forms[0].exchRateCode.disabled = false;
                        document.forms[0].exchRate.disabled = false;
                        document.forms[0].tresExchRate.disabled = false;
                        document.forms[0].tresExchRefNo.disabled = false;
                        showImage("sLnk14");
                }
        }
        else
        {
                alert(errMsg);
        }
return true;
}

function callExchTrRefNoSearcher()
{
 showDynCritSearcher('HTREFNO', 'tr_ref_num=:document.forms[0].tresExchRefNo', ':document.forms[0].tresExchRefNo=tr_ref_num|:document.forms[0].exchRateCode=ratecode|:document.forms[0].exchRate=cust_rate|:document.forms[0].tresExchRate=treasury_rate');
calculateConvertedAmt();
}

</script>

