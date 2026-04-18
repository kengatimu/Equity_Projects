/*---------------------------------------------------------------------------------------------------------------->
<!--Name                : ctoda_det1_link.js 
<!--Description         : This is the details page link file for ctoda menu inquiry mode
<!--Date                : 26-08-2013
<!--Author              :  
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : ctoda
<!--Modification History:
<!--	Version No.	      	Date		         Author		Description
<!--	-------        		----------        	-----------	------------------
<!--	 0.1				26-08-2103			Kalvin		created for TO :361667									
<!--	 
<!---------------------------------------------------------------------------------------------------------------->*/
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

function app_post_ONLOAD()     
{
//	document.forms[0].contractId.disabled = true;
//	document.forms[0].accName.disabled = true;
//	document.forms[0].accCCY.disabled = true;
//	document.forms[0].maxAvailAmt.disabled = true;
//	document.forms[0].contractPeriodMM.disabled = true;
//	document.forms[0].chrgAmt.disabled = true;
//	document.forms[0].netTodAmount.disabled = true;
//	document.forms[0].expDate.disabled = true;
//	document.forms[0].availPeriodMM.disabled = true;
}



function fnAvailmentAmtOnchange()
{
	if(document.forms[0].availAmt.value !="")
	{
		if((isNaN(document.forms[0].availAmt.value)) || ((document.forms[0].availAmt.value) < 0))
		{
			alert("Enter a numeric value or a valid amount.");
			document.forms[0].availAmt.value="";
			document.forms[0].availAmt.focus();
			return false;
		}
		var amtInFloat =parseFloat(document.forms[0].availAmt.value);
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

function fnGetFunctionCodeDesc(funcCode){
        switch(funcCode){
                case 'A': return "Add New Contract ";
                case 'M': return "Modify New Contract  ";
                case 'X': return "Cancel New Contract ";
                case 'T': return "Terminate Contract ";
                case 'V': return "Verify ";
                case 'I': return "Inquire Contract ";
                case 'E': return "Enhance/Extend Contract";
                case 'Z': return "Modify Enhance/Extend Contract";
                default : return funcCode;
        }

}

function fnShowTODHist(index){
		var ObjForm = document.forms[0];
		//alert(reqId[index]);
		//return;
	var inputNameValues = "reqId|" + reqId[index];
var outputNameValues = "availAmt|status|remarks|cretUser|cretDate|lodgedUsr|lodgedDate|verfdUser|verfdDate";

	var scriptName = "ctodadp018.scr";
	var listHeading = "HISTORY DETAILS";
	var colHeader = "AVAILMENT AMOUNT|STATUS|REMARKS|CREATED BY|CREATED DATE|LODGED BY|LODGED DATE|VERIFIED BY|VERIFIED DATE ";
	var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"24",false);

		if(retVal != undefined)
	{
	
        var value = retVal.split("|");
		//alert(value);
	
	}
	}
