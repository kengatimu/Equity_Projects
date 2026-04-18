<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}

		if(fnIsNull(document.forms[0].funcCode.value))
		{
			alert("Enter Function COde");
			document.forms[0].funcCode.focus();
			return false;
		}

		if(fnIsNull(document.forms[0].cifId.value))
		{
			alert("Enter Customer ID")
			document.forms[0].cifId.focus();
			return false;
		}

		if(fnIsNull(document.forms[0].accNo.value))
		{
			alert("Enter Account Number");
			document.forms[0].accNo.focus();
			return false;
		}	
		return true;
}

function funcCodeOnchange()
{
	document.forms[0].cifId.value = "";
	document.forms[0].accNo.value = "";
	document.forms[0].acctName.value = "";
       var ObjForm = document.forms[0];
        ObjForm.drAcctNumEntityId.value = "";
        ObjForm.drAcctNumSolId.value = "";
        ObjForm.drAcctNumCcy.value = "";
        ObjForm.drAcctName.value = "";
	if((document.forms[0].funcCode.value == "R") || (document.forms[0].funcCode.value == ""))
        {
                hideImage("sLnk5");
                showImage("sLnk4");
                hideImage("sLnk6");
                showImage("sLnk2");
        }
        else
        {
                hideImage("sLnk4");
                showImage("sLnk5");
                hideImage("sLnk2");
                showImage("sLnk6");
        }
}

function cifSearcher()
{
        var field             = "cifAcc";
        var outputNames       = "cifId|accNo";
        var pageTitle         = "List of CIF IDs";
        var scrName           = "ebAlertSearchers.scr";
        var hyperLnkCols      = "1";
        var literalNames      = "Customer ID|Account Number";
        var isPopulationReq   = "true";
        var inputNameValues   = "funcCode|" +document.forms[0].funcCode.value +"|"+ "field|" +field; 
        var retVal            = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,hyperLnkCols,isPopulationReq);
}

function accSearcher()
{
        var field             = "cifAcc";
        var outputNames       = "cifId|accNo";
        var pageTitle         = "List of Account Numbers";
        var scrName           = "ebAlertSearchers.scr";
        var hyperLnkCols      = "2";
        var literalNames      = "Customer ID|Account Number";
        var isPopulationReq   = "true";
        var inputNameValues   = "funcCode|" +document.forms[0].funcCode.value +"|"+ "field|" +field;
        var retVal            = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,hyperLnkCols,isPopulationReq);
}

