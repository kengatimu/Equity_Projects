<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields()){
			return false;
		}
		if(fnIsNull(document.forms[0].custName.value)){
			alert("Enter Customer Name");
			document.forms[0].custName.focus();
			return false;
		}
		if(document.forms[0].custDob_ui.value == ""){
		    alert("Enter Customer DateOfBirth");
		    document.forms[0].custDob_ui.focus();
		    return false;
		}
		if(document.forms[0].blackReason.value == ""){
                        alert("Enter Customer BlackList Reason");
                        document.forms[0].blackReason.focus();
			return false;
		}
		if(document.forms[0].evideNce.value == ""){
			alert("Enter BlackList evidence");
			document.forms[0].evideNce.focus();
			return false;
		}

		return true;
}
