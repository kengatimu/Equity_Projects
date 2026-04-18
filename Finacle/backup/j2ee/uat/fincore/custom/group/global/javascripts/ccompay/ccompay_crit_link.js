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
	var tranId = objForm.tranId.value;
    var tranDate = objForm.tranDate.value;
	var funcCode = objForm.funcCode.value ;
	
	if(funcCode == "")
	{
		alert ("Select the Function Code.");
		objForm.funcCode.focus();
		return false;
	} 
	
	if (funcCode=="A")
	{
		var temp2=objForm.pmntType.value;
		if(temp2 == "")
		{
			alert ("Select the Payment Type.");
			objForm.pmntType.focus();
			return false;
		} 
	}
	else
	{
		if(fnIsNull(tranId))
		{
			alert("Enter the Transaction ID.");
			objForm.tranId.focus();
			return false;
		}

		if(fnIsNull(tranDate))
		{
			alert("Enter the Transaction Date");
			objForm.tranDate_ui.focus();
			return false;
		}

	}
	
	return true;
}

function fnOnChangeFuncCode(){
	var ObjForm = document.forms[0];
	var funcCode = ObjForm.funcCode.value;
	
	if(funcCode == "A"){
		hideImage("tranIdRow");
		hideImage("tranDateRow");
		ObjForm.tranId.value = "";
		ObjForm.tranDate.value = "";
		ObjForm.tranDate_ui.value = "";
		ObjForm.pmntType.disabled = false;
		ObjForm.pmntType.focus();
	}
	if(funcCode == "I"){
		showImage("tranIdRow");
		showImage("tranDateRow");
		ObjForm.pmntType.value = "";
		ObjForm.pmntType.disabled = true;
	}
	if(funcCode == "R"){
		showImage("tranIdRow");
		showImage("tranDateRow");
		ObjForm.pmntType.value = "";
		ObjForm.pmntType.disabled = true;
	}
	return;
}

function fnOnChangePmntType(){
	var objForm = document.forms[0];
    objForm.Accept.focus();
}