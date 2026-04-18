<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}

function fnCheckMandatoryFields() {
	var objForm = document.forms[0];
	var temp1=objForm.newRejCode.value.replace(/\s/g,'');
	objForm.newRejCode.value = temp1;
	if(temp1 == "")
	{
		alert ("Enter the new Reject Reason Code.");
		objForm.newRejCode.focus();
		return false;
	}
	return true;
}

function fnGetFunctionCodeDesc(funcCode) {
    switch (funcCode) {
        case 'A':
            return "Add";
        case 'I':
            return "Inquire";
        case 'M':
            return "Modify";
        case 'V':
            return "Verify";
        case 'X':
            return "Cancel";
		case 'D':
            return "Delete";
        default:
            return funcCode;
    }
}
