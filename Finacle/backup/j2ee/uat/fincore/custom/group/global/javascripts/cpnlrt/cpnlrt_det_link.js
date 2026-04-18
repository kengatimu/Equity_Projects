<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}

function fnCheckMandatoryFields(){
	var ObjForm = document.forms[0];
	var prcnt = ObjForm.levelPrcnt.value;
	
	var fieldValue=prcnt.toUpperCase();
	fieldValue=fieldValue.replace(/\s/g,'');
	fieldValue=fieldValue.replace(",","");
	ObjForm.levelPrcnt.value = 	fieldValue;		
	
	if (isNaN(fieldValue)){
		alert("Enter a Valid Number");
		ObjForm.levelPrcnt.focus();
		return false;
	}
	if(fieldValue==""){
		alert("Enter the Penalty Percentage");
		ObjForm.levelPrcnt.focus();
		return false;
	}
	if(fieldValue>100 || fieldValue < 0){
		alert("Percentage value should be between 0 and 100");
		ObjForm.levelPrcnt.focus();
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
		case 'U':
            return "Undelete";
        default:
            return funcCode;
    }
}

function fnGetFieldName(){
	switch (levelType){
		case 'A':
			var colName = "Account Id:";
			break;
		case 'C':
			var colName = "CIF Id:";
			break;
		case 'S':
			var colName = "Scheme Code:";
			break;
		default:
			var colName = "Level Id:";
	}
	document.getElementById('levelIdField').innerHTML = colName;
}

function post_ONLOAD(){
	var ObjForm = document.forms[0];
	if(funcCode=="A"){
		ObjForm.checkedFlg.value = "N";
	}
	if(ObjForm.checkedFlg.value == "Y")
	{
		ObjForm.delFlg.checked =true;
	}
	else
	{
		ObjForm.delFlg.checked =false;
	}
	fnGetFieldName();
}

