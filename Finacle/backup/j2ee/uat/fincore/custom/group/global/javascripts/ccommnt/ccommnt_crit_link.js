<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}

function ccommnt_crit_ONCHANGE1(obj){
		var objForm = document.forms[0];
		if(objForm.funcCode.value == "A"){
			hideImage("sLnk2"); 
		}
		else{
			showImage("sLnk2"); 
		}
}

function fnCheckMandatoryFields() {
	var objForm = document.forms[0];
	
	var temp1 = objForm.funcCode.value ;
	if(temp1 == "")
	{
		alert ("Select the Function Code.");
		objForm.funcCode.focus();
		return false;
	} 
	
	temp1=objForm.commCode.value.replace(/\s/g,'');
	objForm.commCode.value = temp1;
	if(temp1 == "")
	{
		alert ("Enter the Commission Code.");
		objForm.commCode.focus();
		return false;
	} 
	return true;
}

function getCommCodeList() {
	
	var objForm = document.forms[0]
	
	var inputNameValues = "funcCode|"+objForm.funcCode.value;
	var outputNameValues = "commCode|commDesc|crncyCode|delFlg";
	var scriptName = "commntCommCode.scr";
	var pageTitle = "Commission Code List";
	var colHeader = "Commission Code|Commission Description|Currency|Del Flg.";
	var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,pageTitle,colHeader,"1",false);

	if ("Microsoft Internet Explorer" == browser_name)
        {
                if (retVal != null && retVal != undefined )
                {
                        var liarrBufArray = retVal.split("|");
                        objForm.commCode.value = liarrBufArray[0];
                }
		}

}