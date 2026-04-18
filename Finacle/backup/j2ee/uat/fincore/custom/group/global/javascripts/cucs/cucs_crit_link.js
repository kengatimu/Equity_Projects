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
		if(document.forms[0].acctNo.value=="")
        {
            alert("Please Enter a valid Account Number");
            document.forms[0].acctNo.focus();
            return false;
        }
		if(document.forms[0].chqNo.value=="")
        {
            alert("Please Enter a valid Cheque Number");
            document.forms[0].chqNo.focus();
            return false;
        }
		return true;
}