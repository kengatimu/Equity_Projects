<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields()) {
			return false;
		}
		if(fnIsNull(document.forms[0].LowLimR1.value)) {
			alert("Enter Rate for Lower Limit");
			document.forms[0].LowLimR1.focus();
			return false;
		}
		if(fnIsNull(document.forms[0].HighLimR1.value)) {
			alert("Enter Rate for Higher Limit");
			document.forms[0].HighLimR1.focus();
			return false;
		}
		if(fnIsNull(document.forms[0].LowLimR2.value)) {
			alert("Enter Rate for Lower Limit");
			document.forms[0].LowLimR2.focus();
			return false;
		}
		if(fnIsNull(document.forms[0].HighLimR2.value)) {
			alert("Enter Rate for Higher Limit");
			document.forms[0].HighLimR2.focus();
			return false;
		}
		if(fnIsNull(document.forms[0].LowLimR3.value)) {
			alert("Enter Rate for Lower Limit");
			document.forms[0].LowLimR3.focus();
			return false;
		}
		if(fnIsNull(document.forms[0].HighLimR3.value)) {
			alert("Enter Rate for Higher Limit");
			document.forms[0].HighLimR3.focus();
			return false;
		}
		if(fnIsNull(document.forms[0].LowLimR4.value)) {
			alert("Enter Rate for Lower Limit");
			document.forms[0].LowLimR4.focus();
			return false;
		}
		if(fnIsNull(document.forms[0].HighLimR4.value)) {
			alert("Enter Rate for Higher Limit");
			document.forms[0].HighLimR4.focus();
			return false;
		}
		if(fnIsNull(document.forms[0].LowLimR5.value)) {
			alert("Enter Rate for Lower Limit");
			document.forms[0].LowLimR5.focus();
			return false;
		}
		if(fnIsNull(document.forms[0].HighLimR5.value)) {
			alert("Enter Rate for Higher Limit");
			document.forms[0].HighLimR5.focus();
			return false;
		}
		if(fnIsNull(document.forms[0].LowLimR6.value)) {
			alert("Enter Rate for Lower Limit");
			document.forms[0].LowLimR6.focus();
			return false;
		}
		if(fnIsNull(document.forms[0].HighLimR6.value)) {
			alert("Enter Rate for Higher Limit");
			document.forms[0].HighLimR6.focus();
			return false;
		}
		return true;
}
function fnValidateNumbers(objectField){
	var iChars = ".,-0123456789";
	for (var i = 0; i < objectField.length; i++) 
	{
		if (iChars.indexOf(objectField.charAt(i)) == -1) 
		{		
			return false;
		}
	}
	return true;
}
