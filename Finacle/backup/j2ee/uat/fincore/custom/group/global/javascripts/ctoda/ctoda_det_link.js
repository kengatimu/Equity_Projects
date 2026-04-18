<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
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
function fnCheckAmt(obj)
{



}
function fnValAndSubmit(obj)
{

	if(funcCode == "V")
	{
		if(obj.id == "Submit")
		{

			var maxAvailAmt = document.forms[0].maxAvailAmt.value;
			var availAmt = document.forms[0].availAmt.value;
			if(availAmt > maxAvailAmt) 
			{
		//		alert("Availment amount is greater than maximum contract amount.Please cancel this request and add new one");
			//	return false;
			}
		}
	}
	doSubmit(obj.id);
	return true;
}

function app_post_ONLOAD()     
{
	document.forms[0].contractId.disabled = true;
	document.forms[0].accName.disabled = true;
	document.forms[0].accCCY.disabled = true;
	document.forms[0].maxAvailAmt.disabled = true;
	document.forms[0].contractPeriodMM.disabled = true;
	document.forms[0].chrgAmt.disabled = true;
	document.forms[0].netTodAmount.disabled = true;
	document.forms[0].expDate.disabled = true;
	document.forms[0].availPeriodMM.disabled = true;
	//Disabling submit button if the server returns error - Could not get response from server
	if(errStr == "1")
	{
		document.forms[0].Submit.disabled = true;
	}

}

function fnAvailmentAmtOnchange()
{

	var obj = document.forms[0];
	var format = "MILLION";
	if(document.forms[0].availAmt.value !="")
    {
				newformatAmt(format, obj.availAmt, obj.accCCY.value, 'N'); 
	}
	var availAmt = obj.availAmt.value;
	var aAmt = parseFloat(availAmt.replace(/\,/g, ''));	
	if(aAmt !="")
	{
		if((isNaN(aAmt)) || ((aAmt) < 0))
		{
			alert("Enter a numeric value or a valid amount.");
			document.forms[0].availAmt.value="";
			document.forms[0].availAmt.focus();
			return false;
		}

		var amtInFloat =parseFloat(aAmt);
		amtInFloat = amtInFloat.toFixed(2);
		document.forms[0].availAmt.value = amtInFloat;
		//if (amtInFloat == parseFloat('0.00'))
		if (amtInFloat == 0)
		{
			alert("Enter TOD availment amount grater than zero.");
			document.forms[0].availAmt.value="";
			document.forms[0].availAmt.focus();
			return false;
		}
	}	
	var input = "accNum|"+ accNum + "|availAmt|" + document.forms[0].availAmt.value + "|totAvailedAmt|" + document.forms[0].totAvailedAmt.value;
	var scrName = "ctodadp003.scr";
	var output = "";
	var retVal = appFnExecuteScript(input,"output",scrName,false);
	//alert("retVal : " + retVal);
	var amtCalc = new Array();
	amtCalc  = retVal.split("|");
	if(amtCalc[1]=="N")
	{
		alert(amtCalc[3]);
		document.forms[0].availAmt.value="";
		document.forms[0].availAmt.focus();
		return false;
	}
	else
	{
		document.forms[0].chrgAmt.value = amtCalc[3];
		document.forms[0].netTodAmount.value = amtCalc[5];
		var maxContractAmt = amtCalc[7];
		if (parseFloat(maxContractAmt) < parseFloat(document.forms[0].netTodAmount.value))
		{
			alert("Net TOD amount cannot be greater than Contract Amount, enter lower value in TOD availment amount.");
			document.forms[0].availAmt.value="";
			document.forms[0].chrgAmt.value="";
			document.forms[0].netTodAmount.value="";
			document.forms[0].availAmt.focus();
			return false;
		}
	}

	return true;
}

function fnAvailmentPeriodOnchange()
{
	if (document.forms[0].availPeriodMM.value !="")
	{
		if(!isInteger(document.forms[0].availPeriodMM.value))
		{
			alert("Enter a numeric value.");
			document.forms[0].availPeriodMM.value="";
			document.forms[0].availPeriodMM.focus();
			return false;
		}
		if (parseInt(document.forms[0].availPeriodMM.value) == 0)
		{
			alert("Enter Availment Period grater than zero.");
			document.forms[0].availPeriodMM.value="";
			document.forms[0].availPeriodMM.focus();
			return false;
		}
		if (parseInt(document.forms[0].contractPeriodMM.value) < parseInt(document.forms[0].availPeriodMM.value))
		{
			alert("Availment Period cannot be greater than Contract Period");
			document.forms[0].availPeriodMM.value="";
			document.forms[0].availPeriodMM.focus();
			return false;
		}
	}
	
	return true;
}

function isInteger(number) 
{
    var count;
    for (count = 0; count < number.length; count++) 
    {
        // Check that current character is number.
        var char = number.charAt(count);
        if (((char < '0') || (char > '9'))) 
        	return false;
    }
    // All characters are numbers.
    return true;
}
