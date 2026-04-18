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
<!--     0.3            07-08-2013           Bharath            Validation added for different cif id disbursal
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
			var scrName     =   "b_clupayment.scr";
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

}


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
					setFieldsToCustomData("loanAmtCrncy","creditAcctNum","shareAcctId");		
				}
			}
		}
	}
}
</script>
<input type="hidden" class="textfieldfont" id="shareAcctId" name="hiddeFunctType">
