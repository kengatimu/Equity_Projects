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

function fnDebitAccountIDList()

	{
		//alert("trading Inside list");

		var objForm=document.forms[0];

		if(fnIsNull(objForm.funcCode.value))
		{

			alert("Please select the func code");
            return;
		}
		if(objForm.funcCode.value=='V')
		{
			alert("Account list is available for only add function");

			objForm.funcCode.focus();
			return;
		}

	

		 var inputNameValues = "cdsno|"+objForm.cdscnumber.value;
    var outputNameValues = "acctno|";
	var scriptName = "cshapu_getAccounts.scr";
	var listHeading = "List of Customer Accounts";
    var colHeader = "acctno";
    var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",false)   ;
	
var uri_dec = decodeURIComponent(retVal);
var val= uri_dec.split(":");
       objForm.accountnumber.value=val[0];


  
	//showAccountIdList(objForm.accountnumber,objForm.debitAcctSolId,objForm.debitAcctName,'F',objForm.debitAcctCcy,'','','');
 	//if (objForm.accountnumber.value.length>22) { 
 	//objForm.accountnumber.value=objForm.accountnumber.value.substring(0,22); } 
 //	objForm.accountnumber.focus();

	

	}

function validateAcctNum(acctNum)
{

   objForm = document.forms[0];
    var acctnumber = acctNum;
    var inputNameValues = "operAcctNo" + "|" + acctnumber;
    var outputNames1 = "RESULTS";
    var scrName1 = "trading006.scr";
    var retVal = "";
    var retVal = appFnExecuteScript(inputNameValues, outputNames1, scrName1, false);
    if (retVal != "" && retVal != undefined)
    {
        var ret1 = retVal.split("|");
        var acct = ret1[1];
		  
        
		if(String(acct)=="Error"||acct==""||acct==undefined)
		{
			alert("Invalid account");

			return false;

		}
       

    }
    else
    {
        alert("There was an error retrieving the Account details for the customer");

        return false;

    }


    return true;

 }
 function fnAccountNumberChange(acctNumberObj)
 {

	  var acctNumber=cust_fnTrim(acctNumberObj.value);

	  if(!fnValidateSpecialChars(acctNumberObj))
	  {
	  	alert("Invalid account number entered");

	  	acctNumberObj.value="";
	  	acctNumberObj.focus();

	  	return false;
	  }
	  if(acctNumber.length!=13)
	  {
	  	alert("Invalid account number entered");
	  	acctNumberObj.value="";
	  	acctNumberObj.focus();
	  	return false;
	  }

	var inputNameValues = "foracid" + "|" + acctNumber;
    var outputNames1 = "RESULTS";
    var scrName1 = "tradingdp004.scr";
    var retVal = "";
    var retVal = appFnExecuteScript(inputNameValues, outputNames1, scrName1, false);

    if (retVal != "" && retVal != undefined)
    {
    	var ret1 = retVal.split("|");
             	
    	if(ret1[1]=="NULL")
    	{
    		alert("The account number does not exist");

			acctNumberObj.value="";

			acctNumberObj.focus();

    		return false;

    	}
    	else
    	{
    		var ret2=ret1[1].split("!");
    		//0 acct 1 name 2 currency 3 sol
    		var objForm=document.forms[0];
            
            objForm.operAcctCcy.value=ret2[2];
            objForm.operAcctSolId.value=ret2[3]
            objForm.operAcctName.value=ret2[1];
            


    	}
    }



 }
