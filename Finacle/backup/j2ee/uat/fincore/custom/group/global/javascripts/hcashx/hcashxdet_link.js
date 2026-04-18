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

function fnvalidate_acctcrncy()
{
	convertToCaps();
		if(document.forms[0].acctCrncy.value != "")
		{
			var input = "crncy|"+document.forms[0].acctCrncy.value;
			var scrName = "cashxValidateCrncy.scr";
			var output = "";
			var arrRetVal = appFnExecuteScript(input,"output",scrName,false);
			var arrAcctDet = new Array();
			arrAcctDet  = arrRetVal.split("|");
			if(arrAcctDet[1]=="N")
			{
				alert(arrAcctDet[3]);
				document.forms[0].crncy.value = "";
				return false;
			}
	}
}



/* VALIDATING THE AMOUNT RECEIVED FIELD */

function fnvalidate_received()
{
	var receivedamt = removeCommas(document.forms[0].receivedAmt.value);
		receivedAmt = document.forms[0].receivedAmt.value;
		if(receivedAmt < 0)
		{
			alert("Enter a positive value for the 'Amount received' field");
			document.forms[0].receivedAmt.focus();
			return;
		}
	javascript:newformatAmt('MILLION',document.forms[0].receivedAmt,document.forms[0].acctCrncy.value,'N');
}

/* CHECKING FOR SPECIAL CHARACTERS IN AMOUNT RECEIVED FIELD,PAY BACK & GET BACK AMOUNT FIELDS */



function hcashxdet_pre_ONCLICK(obj)
{
	if(obj.id == "Submit")
	{
		javascript:cust_convertToCaps();
		var receivedamt = removeCommas(document.forms[0].receivedAmt.value);
		var refCrncys	= document.forms[0].acctCrncy.value + "@" + document.forms[0].acctCrncy.value;
		var refAmts	= document.forms[0].receivedAmt.value + "@" + document.forms[0].receivedAmt.value;
		
		
		/* VALIDATE IF ANY OF THE MANDATORY FIELDS IS LEFT UNENTERED */		
		if(document.forms[0].acctCrncy.value == "")
		{
			alert("Currency code field must be entered");
			document.forms[0].acctCrncy.focus();
			return false;
		}
		if(document.forms[0].receivedAmt.value == "")
		{
			alert("Amount field must be entered");
			document.forms[0].receivedAmt.focus();
			return false;
		}
		
		var retVal   = cust_fndenompopup("A","C","CR","",refCrncys,refAmts,"C@D","","","D","N@Y","tm");
		//var retVal = cust_fndenompopup("A","C","CR","",document.forms[0].acctCrncy.value,document.forms[0].amtRcvd.value,"C",BodDate,"","P","Y","");
		if(retVal == "cancel" || retVal == false)
		{
			return false;
		}
		else
		{
			document.forms[0].RetVal.value = retVal;
		}
		
		var receivedamt = removeCommas(document.forms[0].receivedAmt.value);
		document.forms[0].receivedAmt.value = receivedamt; 
		var acctCrncy = document.forms[0].acctCrncy.value;
		var inputNameValues = "acctCrncy|"+acctCrncy +"|receivedAmt|"+receivedamt;
		var outputNames = "";
		var scrName;
		var crncy1 = document.forms[0].acctCrncy;
		document.forms[0].CashExchange.value = "S";
		//document.forms[0].submit();
		
	}
}

function fnShowCrncyCodeSearcher()
{
     
       //showCurrency(document.forms[0].acctCrncy,'ctrl','F','','N');
       //cust_showCurrencyList(document.forms[0].acctCrncy);
      
       var inputNameValues = "" ;
       var outputNames ="acctCrncy" + "|" + "cntrycode" + "|" + "currencyname" + "|" + "delflg" + "|" + "entityflg";
       var literalNames = "CCY Code | Country | CCY Name |Del|Entity";
       var pageTitle = "CCY LIST";
       var output = "";
       var hyperLnkCols = '1';
       var scrName = "denomdp054.scr";
       var retVal = fnExecuteScriptForList(inputNameValues, outputNames,scrName, pageTitle, literalNames, hyperLnkCols, true);
}
