<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields()){
			return false;
		}
		if(fnIsNull(document.forms[0].funcCode.value)){
			alert("Enter Function Code");
			document.forms[0].funcCode.focus();
			return false;
		}
	    
		if((document.forms[0].funcCode.value == "A") || (document.forms[0].funcCode.value == "V")){
			if(fnIsNull(document.forms[0].drAccount.value)){
				alert("Enter Debit Account");
				document.forms[0].drAccount.focus();
				return false;
			}
			
			
			if(fnIsNull(document.forms[0].crAccount.value)){
				alert("Enter the currency");
				document.forms[0].crAccount.focus();
				return false;
			}
		}
		return true;
}

function funcCodeOnchange()
{
       var ObjForm = document.forms[0];
	return true;
}



function fnShwAcctList()
{

              showAccountIdList(document.forms[0].drAccount, document.forms[0].solId,document.forms[0].acctName, 'F' , document.forms[0].crncyCode,'','','');


}


function fnFetchAcctDtls(acctObj, acctName, acctSol, acctCrncy, isError, fType)
{
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

function crfnFetchAcctDtls(acctObj, crAcctName, crAcctSol, crAcctCrncy, isError, fType)
{
                        var objForm = document.forms[0];
                var funcCode=objForm.funcCode.value;
                if(funcCode=="I")
                {

                  if ((retVal = fnCommonFetchAcctDtls(acctObj,crAcctName, crAcctSol, crAcctCrncy,isError,"VALACCTIDWITHCLSDFLG")) == false)
                  {
                       return false;
                  }
                }
                else
                {
                  if ((retVal = fnCommonFetchAcctDtls(acctObj,crAcctName, crAcctSol, crAcctCrncy,isError,"VALCUSTACCTID")) == false)
                   {
                       return false;
                   }
                }
}

//code added by Pankaj
function fnShowAccNumCrit()
{

	if(document.forms[0].funcCode.value != "V")
	{
		showAccountIdList(document.forms[0].drAccount,'','','F');
		var validAcct=fnFetchAcctName(document.forms[0].drAccount.value);
		//alert("result from fnFetchAcctName"+validAcct);
		if(validAcct==true)
		{
			var ubpresult = fnFetchUbpCrdrAccount();
			//alert("result from fnFetchUbpCrdrAccount"+ubpresult);
		}
	}
	else
	{
		var inputNameValues = "";
		var outputNameValues = "drAccount|billerId|payAcctId";
		var scriptName = "CR_ACCNUM_SERCHER.scr";
		var listHeading = "BILLER ACCOUNT LIST";
		var colHeader = "Biller Acct Num|Biller Id|Payer Acct Num";
		var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);

		if(document.forms[0].drAccount.value != "")
		{
			var validAcct=fnFetchAcctName(document.forms[0].drAccount.value);
			//alert("result from fnFetchAcctName"+validAcct);
			if(validAcct==true)
			{
				var ubpresult = fnFetchUbpCrdrAccount();
				//alert("result from fnFetchUbpCrdrAccount"+ubpresult);
			}
		}

		if(document.forms[0].payAcctId.value != "")
                {
					
			if((a = fnCommonFetchAcctDtls(document.forms[0].payAcctId,'acctName','solId','crncyCode',true,'VALACCTID')) =="false")
			{
				alert("failed");
				return false;
			}
			
                }
	}
//End
}