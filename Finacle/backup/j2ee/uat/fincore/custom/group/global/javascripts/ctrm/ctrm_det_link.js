<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() 
{
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}

function showRoles()
{
	var roleDesc = "";
	showRoleList(document.forms[0].tempRolId,roleDesc, '', 'ctrl', 'F');

}

function ctrm_det_pre_ONCLICK(obj)
{

	if((obj.id == "Submit") || (obj.id == "Validate"))
	{
		if((document.forms[0].tempRolId.value == "") && (document.forms[0].expDate.value == ""))
		{
			alert("Enter Temp Role ID details");
			document.forms[0].tempRolId.focus();
			return false;
		}
		if(document.forms[0].tempRolId.value != "")
		{
			if(document.forms[0].expDate.value == "")
			{
				alert("Enter a valid Expiry Date");
				document.forms[0].expDate_ui.focus();
				return false;
			}
		}
		if (!fnIsValidDate(document.forms[0].expDate))
		{
			alert("Enter Date in proper format");
			document.forms[0].expDate.value = "";
			document.forms[0].expDate_ui.focus();
			return false;
		}		
        return true; 
	}
}

function ctrm_det_pre_ONLOAD(obj)
{
    document.forms[0].currRolId.disabled = true;
}

<!-- This function is added for formatting a particular MRH Row -->

function fnValidateForm(obj){
	objForm = document.forms[0];
	return true;
}
