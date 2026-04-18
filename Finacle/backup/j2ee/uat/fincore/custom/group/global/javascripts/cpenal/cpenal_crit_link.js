<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		if(document.forms[0].funcCode.value=="")
        {
            alert("Please select the Function");
            document.forms[0].funcCode.focus();
            return false;
        }
		if(document.forms[0].acctId.value=="")
        {
            alert("Please Enter a valid Account Number");
            document.forms[0].acctId.focus();
            return false;
        }
		return true;
}