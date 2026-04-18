<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		convertToCaps();
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}




<!-- This function is added for formatting a particular MRH Row -->

function formatRowValue(Obj, colNumber) {

      return Obj;

       }


<!-- This function is added for formatting a particular MRH Row -->

function fnValidateForm(obj){
	objForm = document.forms[0];

	return true;

}

function app_post_ONLOAD()     
{
	document.forms[0].funcCode.focus();
}

function fnShowCrncyCodeSearcher()
{
	//showAccountIdList(document.forms[0].accNum,'','','F');
	showCurrency(document.forms[0].crncyCode,'ctrl','F','','N');
	fnCurrencyOnchange();
}


function fnCurrencyOnchange()
{
	if(document.forms[0].crncyCode.value !="")
	{
		var input = "crncyCode|"+ document.forms[0].crncyCode.value;
		var scrName = "hdenomdp001.scr";
		var output = "";
		var retVal = appFnExecuteScript(input,"output",scrName,false);
		//alert("retVal : " + retVal);
		var crncyDet = new Array();
		crncyDet  = retVal.split("|");
		if(crncyDet[1]=="N")
		{
			alert(crncyDet[3]);
			document.forms[0].crncyCode.value="";
			document.forms[0].crncyCode.focus();
			return false;
		}
		else
		{
			document.forms[0].crncyName.value = crncyDet[3];
			document.forms[0].decimalPointAllow.value = crncyDet[5];
		}
	}
	return true;
}


function preEventCall(page,obj,event)
{
	/*if((obj.id == "Accept") && (event == "ONCLICK"))
	{
		if (!fnCustomFEValidation())
		{
			return false;
		}
	}*/
	
	if((obj.id == "Clear") && (event == "ONCLICK"))
	{
		document.forms[0].funcCode.value = "";
		document.forms[0].crncyCode.value = "";
		document.forms[0].crncyName.value = "";
		document.forms[0].decimalPointAllow.value = "";
		crncyName
		doSubmit("Clear");
	}
	return true;
}
