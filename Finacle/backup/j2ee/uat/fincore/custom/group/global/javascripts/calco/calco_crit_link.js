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
		if(document.forms[0].funcCode.value == "R"){
			if(fnIsNull(document.forms[0].CrncyCode.value)){
				alert("Enter Currency Code");
				document.forms[0].CrncyCode.focus();
				return false;
			}
			if(fnIsNull(document.forms[0].AplliDate.value)){
				alert("Enter Applicable Date");
				document.forms[0].AplliDate_ui.focus();
				return false;
			}
			if(fnIsNull(document.forms[0].depPerdMths.value)){
				alert("Enter Deposit Type");
				document.forms[0].depPerdMths.focus();
				return false;
			}
			if(fnIsNull(document.forms[0].depPerdDays.value)){
				alert("Enter Deposit Months");
				document.forms[0].depPerdDays.focus();
				return false;
			}

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

