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
	if(document.forms[0].agentcode.value=="")
	{
		alert("Please Enter a valid Agent Code");
		document.forms[0].agentcode.focus();
		return false;
	}
	
 	var crncyCode = (document.forms[0].crncyCode.value).toUpperCase();
	if(crncyCode =="")
	{
		alert("Enter Currency Code");
		document.forms[0].crncyCode.focus();
		return false;
	}

	if(crncyCode =="CDF" ||crncyCode=="USD"||crncyCode=="cdf" ||crncyCode=="usd")
	{
		document.forms[0].crncyCode.value = crncyCode;
	}
	else
	{
		alert("Enter Valid Currency CDF or USD..!");
		document.forms[0].crncyCode.focus();
		return false;

	}
	return true;
}
