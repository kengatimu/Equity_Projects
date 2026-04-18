<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}

function fnCheckMandatoryFields()
{
	var objForm = document.forms[0];
	var temp1 = objForm.funcCode.value;
	if(temp1 == "")
	{
		alert ("Select Function to be performed");
		objForm.funcCode.focus();
		return false;
	}
	var temp1=objForm.rejCode.value.replace(/\s/g,'');
	objForm.rejCode.value = temp1;
	if(temp1 == "")
	{
		alert ("Enter Reject Reason Code");
		objForm.rejCode.focus();
		return false;
	}
	if (!fnValidateReasonCode())
	{
		return false;
	}
	return true;
}

function fnValidateReasonCode()
{
	var objForm = document.forms[0];
	var inputNameValues =  "rejCode|"+objForm.rejCode.value;
	var outputNames ="errFlag|errMsg|desc"
	var scrName     = "crejValCode.scr";
	var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);

	if(retVal=="")
	{
		alert("Unable to Validate Reason Code!")
		return;
	}
	else
	{
		 var ret = retVal.split("|");
		 if(ret[1] == "Y")
		 {
			alert(ret[3]);
			objForm.rejCodeDesc.value="";
			objForm.rejCode.focus();
			return false;
		 }
		 objForm.rejCodeDesc.value=ret[5];
	}
	return true;
}