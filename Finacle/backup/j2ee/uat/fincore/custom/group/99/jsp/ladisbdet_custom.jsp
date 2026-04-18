<!---------------------------------------------------------------------------------------------------------------->
<!--Name		: ladisbdet_custom.jsp 
<!--Description		: todgrant field attribute is changed and populated to default value.
<!--Date		: 31-03-2013
<!--Author		: Samrat 
<!--Called By		: None    
<!--Calling jsp		: None
<!--Menu Option		: HLASPAY
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------           -----------        ------------------
<!--     0.1            31-03-2013           Samrat            	Original version
<!--     0.2            13-06-2013           Prashanth          added some fields to custom data
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">
function post_ONLOAD()
{


	if( mopId == "HLADISB" )
	{
		if (funcCode == "D" )
		{
			//cate Start-- Defualting A-A/c Transfers:-356399
	
				//alert("Hi");
			document.forms[0].disbMode.value="A";
			var custData = document.forms[0].customData.value;
			var custDataVal = custData.split("|");
			var dco = custDataVal[2];
			//alert(dco);
			var input      = "dco|"+dco;
			var outputNames    = "output|outVal";
			var scrName     =   "b_clupayment.scr";
			var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			//alert(a);
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

			var custData		= document.forms[0].customData.value;
			var custDataVal 	= custData.split("|");
			var totDisbAmt		= custDataVal[4];
			totDisbAmt = totDisbAmt.replace(new RegExp(',','g'),"");
                	totDisbAmt = parseFloat(totDisbAmt,2);
			var argsVariable;
			var inputNameValues	= "loanAcctId|"+acctNum+"|disbAmt|"+totDisbAmt;
			var outputNames		= "";
			var scrName		= "laadisbdp001.scr";
			var retVal		= appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			if( ret[0] == "Error" && ret[1] != "dummy" )
			{
			    alert(ret[1]);
			    return false;
			}

			if( ret[2] == "formTypeFlg" && ret[3] == "I" )
			{
				if( ret[4] == "loanAmt" && ret[5] != "dummy" )
				{
					var laAmt = ret[5]; 
				}
				
				if( ret[12] == "loanFee" && ret[13] != "dummy" )
				{
					var laFee = ret[13]; 
				}
				
				if( (document.forms[0].tranRemarks.value) == "" )
				{	
					var url="../custom/54/jsp/laadisbdp001.jsp?loanAcctId='" + acctNum + "'&amt="+laAmt+"&fee="+laFee+"&disbAmt="+totDisbAmt
					var answer = window.showModalDialog(url,argsVariable, "dialogWidth:600px; dialogHeight:500px; center:yes");
				}

				if(answer != undefined)
				{	
					if(answer.refNo != undefined) 
					{
						document.forms[0].refNum.value = answer.refNo;
					}
					document.forms[0].tranRemarks.value = answer.refNo + "/" + answer.cdscName;
					//document.forms[0].tranRemarks.value = answer.tranPtclr;

					if( ret[14] == "crAcctId" && ret[15] != "dummy" )
					{
						document.forms[0].disbMode.value = "A";
						document.forms[0].creditAcctNum.value = ret[15]; 
					}
					document.forms[0].shareAcctId.value = answer.shareInvAcct;
					setFieldsToCustomData("shareAcctId");
				}
			}

			if( ret[2] == "formTypeFlg" && ret[3] == "S" )
			{
				if( ret[4] == "loanAmt" && ret[5] != "dummy" )
				{
					var laAmt = ret[5]; 
				}
				
				if( ret[6] == "laceAmt" && ret[7] != "dummy" )
				{
					var laceAmt = ret[7]; 
				}
				
				if( ret[8] == "insuAmt" && ret[9] != "dummy" )
				{
					var insuAmt = ret[9]; 
				}
				
				if( ret[10] == "contribution" && ret[11] != "dummy" )				
				{
					var contribution = ret[11]; 
				}
				
				if( ret[14] == "crAcctId" && ret[15] != "dummy" )
				{
					document.forms[0].disbMode.value = "A";
					document.forms[0].creditAcctNum.value = ret[15]; 
				}				

				if( (document.forms[0].tranRemarks.value) == "" )
				{	
					var url="../custom/54/jsp/laadisbdp002.jsp?loanAcctId='" + acctNum + "'&amt="+laAmt+"&laceAmt="+laceAmt+"&insuAmt="+insuAmt+"&contribution="+contribution
					var answer = window.showModalDialog(url,argsVariable, "dialogWidth:600px; dialogHeight:500px; center:yes");
				}

				if(answer != undefined)
				{
					if(answer.refNum != undefined) 
					{
						//document.forms[0].refNum.value = answer.refNum;
						document.forms[0].tranRemarks.value = answer.refNum + "/" + answer.Name;
					}
				}
			}
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
			//alert(a);
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


function ladisbdet_pre_ONCLICK(obj)
{
	if (mopId == "HLADISB" )
	{
		if (funcCode == "D" )
		{
			if ( obj.id == "TRANDET") 
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
				setFieldsToCustomData("loanAmtCrncy","creditAcctNum","shareAcctId");	
				//new porting code
				var argsVariable;
				var inputNameValues	= "loanAcctId|"+acctNum;
				var outputNames		= "";
				var scrName		= "laadisbdp014.scr";
				var retVal		= appFnExecuteScript(inputNameValues, outputNames, scrName, false);
				var ret = retVal.split("|");
				var schmCode = ret[1];
				if ( schmCode == "LA505") {
					var rmks = document.forms[0].tranRemarks.value;
					if(rmks == ""){
						alert("Enter transaction Remarks as <Processing Charges>@<Total Premium>@<Insurance Code>. Eg.1000@100000@001");
						document.forms[0].tranRemarks.focus();
						return false;
					}
					var rmksArry = rmks.split(",");
					var aryLength = rmksArry.length;
					if(aryLength!=1){
						alert("Invalid Transaction particulars.Give amount without comma(,)");
						document.forms[0].tranRemarks.focus();
						return false;
					}
					var rmksArry = rmks.split(".");
					var aryLength = rmksArry.length;
					if(aryLength!=1){
						alert("Invalid Transaction particulars.Give amount without decimal precision");
						document.forms[0].tranRemarks.focus();
						return false;
					}
					var rmksArry = rmks.split("@");
					var aryLength = rmksArry.length;
					if(aryLength!=3){
						alert("Invalid Transaction particulars.Use only two @ symbols");
						document.forms[0].tranRemarks.focus();
						return false;
					}
					if ( isNaN(rmksArry[0]) ){
						alert("Invalid amount");
						document.forms[0].tranRemarks.focus();
						return false;
					}
					if ( isNaN(rmksArry[1]) ){
						alert("Invalid amount");
						document.forms[0].tranRemarks.focus();
						return false;
					}
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
<input type="hidden" class="textfieldfont" id="shareAcctId" name="hiddeFunctType">
