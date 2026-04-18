<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : ogmgendtl_custom.jsp
<!--Description       : This jsp During add, 
<!--					If Bg type is BBG and bg currency is not homeCurency, then bg 
<!--					amount is multiplied with rate to get amoutn in home 
<!--					currency and according to the output amt alerts are displayed.
<!--					If the greater or equal to 1000000 50% cash cover and 50% other acceptance securities.
<!--Date              : 17-01-2013
<!--Author            : Shishira
<!--Called By         : bankgrntValmn001.scr  
<!--Calling jsp       : None
<!--Menu Option       : OGM/IGM.
<!--Modification History:
<!--    Version No.      Date           Author                     Description
<!--    ---------        ----------     ---------------            --------------------
<!--     0.1             17-01-2013     Shishira                   Original version
<!--	0.2				24-07-2013		Priya K					Modified for TO-355718
<!---------------------------------------------------------------------------------------------------------------->
<%@ include file="../commonInclude.jsp" %>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="ogmgen" isEntryPoint="false" />
<%
	String sBgType      =   (String)ARJspCurr.getInputWithGroup("bgType", null);
	String sBgAmtCrncy  =   (String)ARJspCurr.getInputWithGroup("bgCrncyCode", null);
%>
<script>
document.write('<input type="hidden" id="TenderRefName" name="TenderRefName">');
document.write('<input type="hidden" id="TenderRefNum" name="TenderRefNum">');
document.write('<input type="hidden" id="ProcuringEntityName" name="ProcuringEntityName">');
document.write('<input type="hidden" id="ProcuringEntityCode" name="ProcuringEntityCode">');
document.write('<input type="hidden" id="TenderType" name="TenderType">');
document.write('<input type="hidden" id="TenderMethod" name="TenderMethod">');
document.write('<input type="hidden" id="DeadLineDate" name="DeadLineDate">');
document.write('<input type="hidden" id="TenderLotNumber" name="TenderLotNumber">');
document.write('<input type="hidden" id="Amount" name="Amount">');
</script>

<script type ="text/javascript">
function ogmgendtl_pre_ONCLICK(btnId) {
//Modification for TO-355718
	    setFieldsToCustomData("paysysId");
//Modification ends
	if(btnId.id!= "Cancel" && funcCode == "A"){
		//alert("tested OK");
		var functType = funcCode;
		var bgCcy = "<%=sBgAmtCrncy%>"
		var bgTyp = "<%=sBgType%>"
		alert(bgTyp);

		var bgAmt = document.forms[0].bgAmt.value
		var bgRate = document.forms[0].rate.value;
		
		bgAmt = bgAmt.replace(new RegExp(',','g'),"");
		var bgAmt= parseFloat(bgAmt,2);
		
		if(bgAmt != "" || bgAmt != 0){
			var inputNameValues = "bgAmt" + "|" + bgAmt +"|" +"bgCcy" + "|" + bgCcy +"|" +"bgTyp" + "|" + bgTyp + "|" + "bgRate" + "|" + bgRate ;
			var outputNames = "";
			var scrName = "bankgrntValmn07.scr";
			var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			var alrtMsg = ret[1];
			if(ret[0] == "MSG"){
				//alert("am in 4");
				alert(alrtMsg);
			}
			
		}
		
		
			 //if (document.forms[0].addrLine3.value == "")
				//{
						//alert("PLEASE ENTER REFERENCE NO");
						//document.forms[0].addrLine3.focus();
						//return false;
			//	}
			if (profileId == 50)
			{
				var addrLine3=document.forms[0].addrLine3.value;
		//if (applcntRefNo!="")
		//{
				//alert ("am in");
				//alert (addrLine3);
				var bgTyp = "<%=sBgType%>"
				//alert(bgTyp);
				//var serialnum = document.forms[0].customData.value;
				//var bgTyp1=pEntity.split("|");
				//var bgTyp =pEntitytemp[2];
				//alert(bgTyp);
				var inputNameValues = "applcntRefNo" + "|" + addrLine3 +"|" +"bgTyp" + "|" + bgTyp ;
				var outputNames = "";
				var scrName = "EprocurementValidation.scr";
				var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
				var ret = retVal.split("|");
				var a = ret[1];
				if(ret[0] == "MSG1"){	
					alert(a);
					alert("its ok");
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

				var g = ret[13];
				if(ret[12] == "MSG7"){	
					alert(g);
				}

				var h = ret[15];
				if(ret[14] == "MSG8"){	
					alert(h);
				}
				var i = ret[17];
				if(ret[16] == "MSG9"){	
					alert(i);
				}
				var j = ret[19];
				if(ret[18] == "MSG10"){	
					alert(j);
				}
				

				if (a=="0")
				{
					//document.forms[0].TenderRefName.value=b;
				document.forms[0].TenderRefName.value=b;
				alert("ok");
				alert(c);
				document.forms[0].TenderRefNum.value=c;
				document.forms[0].ProcuringEntityName.value=d;
				alert("ok1");
				document.forms[0].ProcuringEntityCode.value=e;
				document.forms[0].TenderType.value=f;
				document.forms[0].TenderMethod.value=g;
				document.forms[0].DeadLineDate.value=h;
				document.forms[0].TenderLotNumber.value=i;
				document.forms[0].Amount.value=j;

				var TenderRefName=document.forms[0].TenderRefName.value;
				var TenderRefNum=document.forms[0].TenderRefNum.value;
				var ProcuringEntityName=document.forms[0].ProcuringEntityName.value;
				var ProcuringEntityCode=document.forms[0].ProcuringEntityCode.value;
				var TenderType=document.forms[0].TenderType.value;
				var TenderMethod=document.forms[0].TenderMethod.value;
				var DeadLineDate=document.forms[0].DeadLineDate.value;
				var TenderLotNumber=document.forms[0].TenderLotNumber.value;
				var Amount=document.forms[0].Amount.value;
				document.forms[0].otherBankRefNo.value="102229882";
				alert(Amount);
					if (bgTyp=="BBG")
					{
					document.forms[0].bgAmt.value=Amount;
					}
				}
				else
					if (a!="0")
					{
						alert("SYSTEM ERROR/RECORD NOT FOUND");
						document.forms[0].addrLine3.focus();
						return false;

					}
			}
		
	}
	return true;
}


//Modification for TO-355718

function ogmgendtl_pre_ONCHANGE(btnId) {

	if(btnId.id!= "Cancel" && funcCode == "A"){
		var functType = funcCode;
		var bgCcy = "<%=sBgAmtCrncy%>"
		var bgTyp = "<%=sBgType%>"
		//alert(bgTyp);
		var bgAmt = document.forms[0].bgAmt.value
		var bgRate = document.forms[0].rate.value;
		
		bgAmt = bgAmt.replace(new RegExp(',','g'),"");
		var bgAmt= parseFloat(bgAmt,2);
		//alert("am in 5");
		if(bgAmt != "" || bgAmt != 0){
			//alert("tested OK1");
			var inputNameValues = "bgAmt" + "|" + bgAmt +"|" +"bgCcy" + "|" + bgCcy +"|" +"bgTyp" + "|" + bgTyp + "|" + "bgRate" + "|" + bgRate ;
			var outputNames = "";
			var scrName = "bankgrntValmn07.scr";
			var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			var alrtMsg = ret[1];
			if(ret[0] == "MSG"){
				//alert("am in 2");
				alert(alrtMsg);
			}
			
		}
		if (profileId == 50)
			{

			var addrLine3=document.forms[0].addrLine3.value;
	
			//alert ("am in");
			//alert (addrLine3);
			var bgTyp = "<%=sBgType%>"
			//alert(bgTyp);
			var inputNameValues = "applcntRefNo" + "|" + addrLine3 +"|" +"bgTyp" + "|" + bgTyp;
			var outputNames = "";
			var scrName = "EprocurementValidation.scr";
			var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			var a = ret[1];
			if(ret[0] == "MSG1"){	
				alert(a);
				alert("its ok");
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

			var g = ret[13];
			if(ret[12] == "MSG7"){	
				alert(g);
			}

			var h = ret[15];
			if(ret[14] == "MSG8"){	
				alert(h);
			}
			var i = ret[17];
			if(ret[16] == "MSG9"){	
				alert(i);
			}
			var j = ret[19];
			if(ret[18] == "MSG10"){	
				alert(j);
			}
			

			if (a=="0")
			{
				//document.forms[0].TenderRefName.value=b;
			document.forms[0].TenderRefName.value=b;
			alert("ok");
			document.forms[0].TenderRefNum.value=c;
			document.forms[0].ProcuringEntityName.value=d;
			alert("ok1");
			document.forms[0].ProcuringEntityCode.value=e;
			document.forms[0].TenderType.value=f;
			document.forms[0].TenderMethod.value=g;
			document.forms[0].DeadLineDate.value=h;
			document.forms[0].TenderLotNumber.value=i;
			document.forms[0].Amount.value=j;

			var TenderRefName=document.forms[0].TenderRefName.value;
			var TenderRefNum=document.forms[0].TenderRefNum.value;
			var ProcuringEntityName=document.forms[0].ProcuringEntityName.value;
			var ProcuringEntityCode=document.forms[0].ProcuringEntityCode.value;
			var TenderType=document.forms[0].TenderType.value;
			var TenderMethod=document.forms[0].TenderMethod.value;
			var DeadLineDate=document.forms[0].DeadLineDate.value;
			var TenderLotNumber=document.forms[0].TenderLotNumber.value;
			var Amount=document.forms[0].Amount.value;
			document.forms[0].otherBankRefNo.value="102229882";
			alert(Amount);
				if (bgTyp=="BBG")
				{
				document.forms[0].bgAmt.value=Amount;
				}
			}
			else
				if (a!="0")
				{
					alert("SYSTEM ERROR/RECORD NOT FOUND");
					document.forms[0].addrLine3.focus();
					return false;

				}
		}
		
	}
	return true;

	
}


function ogmgendtl_pre_ONBLUR(btnId) {

	if(btnId.id!= "Cancel" && funcCode == "A"){
		var functType = funcCode;
		var bgCcy = "<%=sBgAmtCrncy%>"
		var bgTyp = "<%=sBgType%>"

		var bgAmt = document.forms[0].bgAmt.value
		var bgRate = document.forms[0].rate.value;
		
		bgAmt = bgAmt.replace(new RegExp(',','g'),"");
		var bgAmt= parseFloat(bgAmt,2);
		//alert("am in 6");
		if(bgAmt != "" || bgAmt != 0){
			//alert("tested OK2");
			var inputNameValues = "bgAmt" + "|" + bgAmt +"|" +"bgCcy" + "|" + bgCcy +"|" +"bgTyp" + "|" + bgTyp + "|" + "bgRate" + "|" + bgRate ;
			var outputNames = "";
			var scrName = "bankgrntValmn07.scr";
			var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			var alrtMsg = ret[1];
			if(ret[0] == "MSG"){
				//alert("am in 3");
				alert(alrtMsg);
			}
			
		}

		if (profileId == 50)
		{
		 var addrLine3=document.forms[0].addrLine3.value;

			alert ("am in");
			alert (addrLine3);
			var bgTyp = "<%=sBgType%>"
			alert(bgTyp);
			var inputNameValues = "applcntRefNo" + "|" + addrLine3 +"|" +"bgTyp" + "|" + bgTyp;
			var outputNames = "";
			var scrName = "EprocurementValidation.scr";
			var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			var a = ret[1];
			if(ret[0] == "MSG1"){	
				alert(a);
				alert("its ok");
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

			var g = ret[13];
			if(ret[12] == "MSG7"){	
				alert(g);
			}

			var h = ret[15];
			if(ret[14] == "MSG8"){	
				alert(h);
			}
			var i = ret[17];
			if(ret[16] == "MSG9"){	
				alert(i);
			}
			var j = ret[19];
			if(ret[18] == "MSG10"){	
				alert(j);
			}
			

			if (a=="0")
			{
				//document.forms[0].TenderRefName.value=b;
			document.forms[0].TenderRefName.value=b;
			alert("ok");
			document.forms[0].TenderRefNum.value=c;
			document.forms[0].ProcuringEntityName.value=d;
			alert("ok1");
			document.forms[0].ProcuringEntityCode.value=e;
			document.forms[0].TenderType.value=f;
			document.forms[0].TenderMethod.value=g;
			document.forms[0].DeadLineDate.value=h;
			document.forms[0].TenderLotNumber.value=i;
			document.forms[0].Amount.value=j;

			var TenderRefName=document.forms[0].TenderRefName.value;
			var TenderRefNum=document.forms[0].TenderRefNum.value;
			var ProcuringEntityName=document.forms[0].ProcuringEntityName.value;
			var ProcuringEntityCode=document.forms[0].ProcuringEntityCode.value;
			var TenderType=document.forms[0].TenderType.value;
			var TenderMethod=document.forms[0].TenderMethod.value;
			var DeadLineDate=document.forms[0].DeadLineDate.value;
			var TenderLotNumber=document.forms[0].TenderLotNumber.value;
			var Amount=document.forms[0].Amount.value;
			alert(Amount);
				document.forms[0].otherBankRefNo.value="102229882"; 
				if (bgTyp=="BBG")
				{
				document.forms[0].bgAmt.value=Amount;
				}
			}
			else
				if (a!="0")
				{
					alert("SYSTEM ERROR/RECORD NOT FOUND");
					document.forms[0].addrLine3.focus();
					return false;

				}
		
				
		}
	}
	return true;

}
//ebl customization 355390

function ogmgendtl_post_ONLOAD(obj)
	{
		//alert("hey");
document.forms[0].rateCode.disabled=true;
document.forms[0].rate.disabled=true;

getFieldsFromCustomData("paysysId");
var serialnum = document.forms[0].customData.value;
//alert(serialnum);
	if(funcCode == "R")
	{
        var radioButtons = document.getElementsByName('bgCloseOnReverse');
        radioButtons[0].checked = true;
	}


	}
	//ebl customization 355390
//Modification for TO-355718
function ogmgendtl_pre_TAB_SWITCH()
{
	    setFieldsToCustomData("paysysId","TenderRefName","ProcuringEntityName","TenderType","DeadLineDate","TenderRefNum","TenderLotNumber");

		//if (document.forms[0].addrLine3.value == "")
			//{
					//alert("PLEASE ENTER REFERENCE NO");
					//document.forms[0].addrLine3.focus();
					//return false;

			//}
}
//Modification ends here

</script>
