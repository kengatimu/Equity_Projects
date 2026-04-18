<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		
		if(document.forms[0].funcCode.value == "")
		{
			document.forms[0].funcCode.focus();
			alert("Function cannot be Empty");
			return false;

		}
		if(document.forms[0].fromDate.value == "")
		{
			document.forms[0].fromDate.focus();
			alert("From Date cannot be Empty");
			return false;

		}
		if(document.forms[0].toDate.value == "")
		{
			document.forms[0].toDate.focus();
			alert("To Date cannot be Empty");
			return false;

		}
		if(document.forms[0].lastNRecords.value == "")
		{
			document.forms[0].lastNRecords.focus();
			alert("Last N Records cannot be Empty");
			return false;

		}
		
		return true;
}