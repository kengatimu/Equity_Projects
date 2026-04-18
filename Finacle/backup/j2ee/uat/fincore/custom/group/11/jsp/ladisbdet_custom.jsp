<!---------------------------------------------------------------------------------------------------------------->
<!--Name		: ladisbdet_custom.jsp 
<!--Description		: todgrant field attribute is changed and populated to default value.
<!--Date		: 04-04-2013
<!--Author		: Sateesh 
<!--Called By		: None    
<!--Calling jsp		: None
<!--Menu Option		: HLASPAY
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------           -----------        ------------------
<!--     0.1            04-04-2013           Sateesh            Original version
<!--     0.2            13-06-2013           Prashanth          added some fields to custom data
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">
//ebl cust
function post_ONLOAD()
{
	if( mopId == "HLADISB" )
	{
		if (funcCode == "D" )
		{
		//cate Start-- Defualting A-A/c Transfers:-356399
	
			document.forms[0].disbMode.value="A";
			var custData = document.forms[0].customData.value;
			var custDataVal = custData.split("|");
			var dco = custDataVal[2];
			var input      = "dco|"+dco;
			var outputNames    = "output|outVal";
			var scrName     =   "b_clupayment.scr";
			var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			document.forms[0].creditAcctNum.value=a;


			//cate End 356399

			
			//kate restricting operative accounts with SB113/114 scheme codes
			var dco=document.forms[0].creditAcctNum.value;
					
			var input      = "dco|"+dco;
			var outputNames    = "output|outVal";
			var scrName     =   "b_acctsbgrp.scr";
			var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			//var schmCode =a;
			//alert(a);
			

			if ((a=="SB113") || (a=="SB114"))
			{
					alert("Do not use SB113 or SB114");
					document.forms[0].creditAcctNum.focus();
					return false;
						
			}
//kate restricting operative accounts with SB113/114 scheme codes

		}
		if (funcCode == "R" )
		{
			//jane bank Start-- Defualting A-A/c Transfers:-362214
			var custData = document.forms[0].customData.value;
			var custDataVal = custData.split("|");
			var dco = custDataVal[2];
			//alert(dco);
			var input      = "dco|"+dco;
			var outputNames    = "output|outVal";
			var scrName     =   "b_disbrevers.scr";
			var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			alert(a);
			document.forms[0].creditAcctNum.value=a;
			document.forms[0].creditAcctNum.disabled=true;
		}
		//jane add 362214
	}

        //Islamic Banking Customization For Disbursement through Customer Operative Account
        //Change done by Mohan Raghu Arudi

        if((mopId == "PSC") || (mopId == "HLADISB")){
                if ((funcCode == "D" )|| (funcCode == "R")){
                        if(tranType == "T"){
                                fnPopulateOpAcctDtlsForIslamicLoanAcct();
                        }
                }
        }        
	
}
//ebl end cust

function ladisbdet_pre_ONCLICK(obj)
{
	if (mopId == "HLADISB" )
	{
		if (funcCode == "D" )
		{
			if ( obj.id == "TRANDET") 
			{
				if ( (document.forms[0].creditAcctNum.value) != "" ) 
				{
					var custData		= document.forms[0].customData.value;
					var custDataVal 	= custData.split("|");
					var totDisbAmt		= custDataVal[4];	
					totDisbAmt = totDisbAmt.replace(new RegExp(',','g'),"");
					totDisbAmt = parseFloat(totDisbAmt,2);
					var loanAcctId		= acctNum;
					var disbAmt		= totDisbAmt;
					var refNum		= document.forms[0].tranRemarks.value;
					var crAcctId		= document.forms[0].creditAcctNum.value;
					var inputNameValues	= "loanAcctId|"+loanAcctId+"|disbAmt|"+disbAmt+"|refNum|"+refNum+"|crAcctId|"+crAcctId;
					var outputNames		= "";
					var scrName		= "laadisbdp005.scr";
					var retVal		= appFnExecuteScript(inputNameValues, outputNames, scrName, false);
					var ret = retVal.split("|");
					
					if( ret[0] == "Error" && ret[1] != "dummy" )
					{
						alert(ret[1]);
						return false;
					}
					else
					{
						if( ret[4] == "popUp" && ret[5] != "dummy" )
						{
							var url="../custom/11/jsp/laadisbdp003.jsp?loanAcctId='" + acctNum + "'&disbAmt="+totDisbAmt;
							var argsVariable;
							var answer = window.showModalDialog(url,argsVariable, "dialogWidth:600px; dialogHeight:500px; center:yes");
							if(answer != undefined)
							{
								if(answer.category != undefined && answer.cdsNo != undefined) 
								{
									document.forms[0].tranRemarks.value = answer.category+"/"+answer.cdsNo;
								}
							}
						}
					}
					setFieldsToCustomData("loanAmtCrncy","creditAcctNum");
				}

					//kate restricting operative accounts with SB113/114 scheme codes
			var dco=document.forms[0].creditAcctNum.value;
					
			var input      = "dco|"+dco;
			var outputNames    = "output|outVal";
			var scrName     =   "b_acctsbgrp.scr";
			var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			//var schmCode =a;
			//alert(a);
			

			if ((a=="SB113") || (a=="SB114"))
			{
					alert("Do not use SB113 or SB114");
					document.forms[0].creditAcctNum.focus();
					return false;
						
			}
//kate restricting operative accounts with SB113/114 scheme codes
			}
		}
	}
}

function fnPopulateOpAcctDtlsForIslamicLoanAcct(){
        var ObjForm = document.forms[0];
        var custData = document.forms[0].customData.value;
        var custDataVal = custData.split("|");
        var loanAcct = custDataVal[2];
        var inputNameValues = "loanAcct|"+loanAcct;
        var outputNames = "errorFlg|errorMsg|islLoanAcctFlg|opAcct|opAcctSolId|opAcctCrncyCode|opAcctName";
        var scriptName = "islFinanceCustdp001.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
        if(token != undefined){
                var errorFlg = token[1];
                var errorMsg = token[3];
                var islLoanAcctFlg = token[5];
                var opAcct = token[7];
                var opAcctSolId = token[9];
                var opAcctCrncyCode = token[11];
                var opAcctName = token[13];

                if(errorFlg == "Y"){
                        alert(errorMsg);
                }else{
                        if(islLoanAcctFlg == "Y"){
                                ObjForm.creditAcctNum.value = opAcct;
                                ObjForm.creditAcctSol.value = opAcctSolId;
                                ObjForm.creditAcctCrncy.value = opAcctCrncyCode;
                                ObjForm.creditAcctName.value = opAcctName;
                                ObjForm.creditAcctNum.disabled = false;
                                ObjForm.creditAcctNum.readOnly = false;
                                ObjForm.disbMode.value = "A";
                                ObjForm.creditAcctNum.focus();
                                showImage("sLnk3");
                        }
                }
        }
}

</script>
