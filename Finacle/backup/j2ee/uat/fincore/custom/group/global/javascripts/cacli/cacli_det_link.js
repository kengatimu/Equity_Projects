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

function fnShowTranDetails(obj1)
{
	var sUrl = "";
	var urlData = "";
	var inputNameValues = "accountID|"+accountID + "|rowNum|"+obj1.value+"|fromDate|"+fromDate+"|toDate|"+toDate+"|fromAmt|"+fromAmt+"|toAmt|"+toAmt+"|fromInstrumentNo|"+fromInstrumentNo+"|toInstrumentNo|"+toInstrumentNo+"|orderBy|"+orderBy+"|lastNTran|"+lastNTran;
	var outputNames = "errorFlg|errorMsg|tranId|tranDate|instrType|instrNum|instrDate|glDate|valueDate|tranType|reportCode|remarks|refNo|acctId|refAmt|amount|entryUsrId|pstdUsrId|tranPartiCode|tranParti|tranDesc|remarks1|remarks2|verifyUsrId|rateCode|TrsryRate|reversal|delRecord|tranSolId|TrsryRefNum|entered|posted|verified";
	var scriptName = "caclidp004.scr";
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");

	if(token != undefined){
		var iIndex = 1;
		var errorFlg = token[iIndex];
		var errorMsg = token[iIndex+=2];
		var tranId = token[iIndex+=2];
		var tranDate = token[iIndex+=2];
		var instrType = token[iIndex+=2];
		var instrNum = token[iIndex+=2];
		var instrDate = token[iIndex+=2];
		var glDate = token[iIndex+=2];
		var valueDate = token[iIndex+=2];
		var tranType = token[iIndex+=2];
		var reportCode = token[iIndex+=2];
		var remarks = token[iIndex+=2];
		var refNo = token[iIndex+=2];
		var acctId = token[iIndex+=2];
		var refAmt = token[iIndex+=2];
		var amount = token[iIndex+=2];
		var entryUsrId = token[iIndex+=2];
		var pstdUsrId = token[iIndex+=2];
		var tranPartiCode = token[iIndex+=2];
		var tranParti = token[iIndex+=2];
		var tranDesc = token[iIndex+=2];
		var remarks1 = token[iIndex+=2];
		var remarks2 = token[iIndex+=2];
		var verifyUsrId = token[iIndex+=2];
		var rateCode = token[iIndex+=2];
		var TrsryRate = token[iIndex+=2];
		var reversal = token[iIndex+=2];
		var delRecord = token[iIndex+=2];
		var tranSolId = token[iIndex+=2];
		var TrsryRefNum = token[iIndex+=2];
		var entered = token[iIndex+=2];
		var posted = token[iIndex+=2];
		var verified = token[iIndex+=2];
			
		var urlData = "";
		urlData+= "&tranId="+tranId;
		urlData+= "&tranDate="+tranDate;	
		urlData+= "&instrType="+instrType;
		urlData+= "&instrNum="+instrNum;
		urlData+= "&instrDate="+instrDate;
		urlData+= "&glDate="+glDate;	
		urlData+= "&valueDate="+valueDate;
		urlData+= "&tranType="+tranType;
		urlData+= "&reportCode="+reportCode;
		urlData+= "&remarks="+remarks;
		urlData+= "&refNo="+refNo;
		urlData+= "&acctId="+acctId;
		urlData+= "&refAmt="+refAmt;
		urlData+= "&amount="+amount;
		urlData+= "&entryUsrId="+entryUsrId;	
		urlData+= "&pstdUsrId="+pstdUsrId;
		urlData+= "&tranPartiCode="+tranPartiCode;
		urlData+= "&tranParti="+tranParti;
		urlData+= "&tranDesc="+tranDesc;
		urlData+= "&remarks1="+remarks1;
		urlData+= "&remarks2="+remarks2;
		urlData+= "&verifyUsrId="+verifyUsrId;
		urlData+= "&TrsryRate="+TrsryRate;
		urlData+= "&rateCode="+rateCode;
		
		urlData+= "&reversal="+reversal;	
		urlData+= "&delRecord="+delRecord;
		urlData+= "&tranSolId="+tranSolId;
		urlData+= "&TrsryRefNum="+TrsryRefNum;
		urlData+= "&entered="+entered;
		urlData+= "&posted="+posted;
		urlData+= "&verified="+verified;
		
	}
	
	var sUrl = "../custom/jsp/cacli_tranDetails.jsp?";
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
		
			
function locfnOnLoad()
{
	//if(glDate[0]== 0)
	if(ListMaxDisplay == 0)
	{
		alert("There are no transactions with the given criteria");
	}
}

