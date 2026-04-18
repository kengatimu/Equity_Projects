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

		if(fnIsNull(document.forms[0].idType.value))
		{
			alert("Enter Identification Type")
			document.forms[0].idType.focus();
			return false;
		}

		if(fnIsNull(document.forms[0].UniqIdNum.value))
		{
			alert("Enter Unique Identification Number");
			document.forms[0].UniqIdNum.focus();
			return false;
		}	
		return true;
}

function funcCodeOnchange()
{
	document.forms[0].idType.value = "";
	document.forms[0].UniqIdNum.value = "";
}
