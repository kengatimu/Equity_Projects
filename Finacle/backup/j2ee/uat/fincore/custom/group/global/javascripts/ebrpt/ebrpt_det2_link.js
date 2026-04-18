<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
          var asOnDate = document.forms[0].asOnDate.value;
if(!fnCompareDates(asOnDate,BODDate))
    {
        alert("AsOnDate should not be Greater than BOD Date");
        document.forms[0].asOnDate.focus();
        return false;
    }

  if(document.forms[0].asOnDate.value == "")
            {
                alert("Select the AsOnDate");
                document.forms[0].asOnDate.focus();
                return false;
            }
  if(document.forms[0].solId.value == "")
            {
                alert("Select the solId");
                document.forms[0].solId.focus();
                return false;
            }

	var a = Validate_sol();

                if(a  == false)
                {
                        return false;
                }
	
		return true;
}

function Validate_sol()
        {
                 if(document.forms[0].solId.value != "")
    {
                var sol             = document.forms[0].solId.value;
                var inputNameValues = "sol_id" ;
                var outputNames     = "sol_id";
                var scrName         = "ebrptVal.scr";
                var retVal          = appFnExecuteScript(inputNameValues,outputNames,scrName,false);
                var valueFromScript = retVal.split("|");
                if(valueFromScript[1] == "N")
                {
                        alert("InValid SOL ID");
                        document.forms[0].solId.focus();
                        return false;
                }
    }
}
