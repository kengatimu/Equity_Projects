function showTellerIdList()
{
	objForm = document.forms[0];
    var inputNameValues = "pageNumber|1|pageSize|10|telId|" + objForm.telId.value + "|solId|" + objForm.solId.value;
	var outputNames = "telId";
	var scrName = "dentillmn002.scr";
	var literalNames = "Teller Id List";
	var pageTitle = "List of available Teller Id for the given criteria";
    var retVal = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,'1',true);

}

function fnDisbFields(obj)
{
	var funcCode = document.forms[0].report.value;
	if(funcCode == "V")
	{
		document.forms[0].telId.value = "Vault";
		document.forms[0].telId.disabled = true;
		hideImage("sLnk1");
	}
	else
	{
		document.forms[0].telId.disabled = false;
		document.forms[0].telId.value = "";
		showImage("sLnk1");
	}
}

function hdentill_det_pre_ONCLICK(obj)
{
	if(obj.id == "Submit")
        {
		if((document.forms[0].report.value != "V")&& (document.forms[0].report.value != "T"))
		{
			alert('Please select Position Report');
			document.forms[0].report.focus();
			return false;
		}
	}
}
