<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields()){
			return false;
		}
                var fromDate = document.forms[0].fromDate.value;
                if(!fnCompareDates(fromDate,BODDate)){
                        alert("From Date should not be Greater than BOD Date");
                        document.forms[0].fromDate.focus();
                        return false;
                }
                if(document.forms[0].fromDate.value == ""){
                        alert("Enter From Date")
                        document.forms[0].fromDate.focus();
                        return false;
                }
		return true;
}

function Validate_sol(){
                 if(document.forms[0].idSolId.value != ""){
                var sol             = document.forms[0].idSolId.value;
                var inputNameValues = "idSolId|" +sol;
                var outputNames     = "";
                var scrName         = "ebrptVal.scr";
                var retVal          = appFnExecuteScript(inputNameValues,outputNames,scrName,false);
                var valueFromScript = retVal.split("|");
                if(valueFromScript[1] == "N")
                {
                        alert("InValid SOL ID");
                        document.forms[0].idSolId.focus();
                        return false;
                }
    }
}
