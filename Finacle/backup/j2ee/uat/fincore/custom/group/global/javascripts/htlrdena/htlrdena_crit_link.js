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

 //gettng list of teller id
function TellrId(obj,p1)
 {
       	if(document.forms[0].funcCode.value =="")
       	{
       		alert("Please select function code");

       	}
       	else
       	{
       		var inputNameValues = "funcCode|"+document.forms[0].funcCode.value;
          	var outputNames = "tellerId|crncy|solId";
          	var scrName = "tlrdenadp003.scr";
          	var title   = "Teller Id";
         	var literalNames= "Teller Id|CRNCY CODE|SOLID";
       		var retVal=fnExecuteScriptForList(inputNameValues,outputNames,scrName,title,literalNames,"1",false);
		if(retVal != undefined)
		{
			var sValues = retVal.split("|");
			document.forms[0].tellerId.value = sValues[0];
		}
		if(retVal != undefined)
		{
			var sValues = retVal.split("|");
			document.forms[0].tellerId.value  = sValues[0];
			document.forms[0].crncyCode.value =  sValues[1];
			document.forms[0].solId.value	  =  sValues[2];
		}
	}

}

// fetchg data based on function code
/*function fnFuncChnge(obj)
{
	var retVal = "";
	if (preEventCall('htlrdenm_crit',obj,'ONCHANGE') == false) {
		return false;
	}
	if (postEventCall('htlrdenm_crit',obj,'ONCHANGE') == false) {
		return false;
	}

	document.forms[0].tellerId.value ="";
	document.forms[0].crncyCode.value	= "";
	document.forms[0].solId.value	= "";
	if((document.forms[0].funcCode.value=="M") || (document.forms[0].funcCode.value=="X")|| (document.forms[0].funcCode.value=="I"))
	{
		showImage("search2");
		showImage("search3");
		showImage("search1");
		var inputNameValues = "";
		var outputNames = "";
		var scrName = "tlrdenadp004.scr";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		if(retVal != undefined)
		{
			var val = retVal.split("|");
			if(val[0]=="N")
			{
				alert(val[1]);
				document.forms[0].tellerId.readOnly = false;
				document.forms[0].solId.readOnly = false;
				return false;
			}
			else
			{
				var tmp = val[1].split("!");
				document.forms[0].tellerId.value = tmp[0];
				//document.forms[0].tellerId.readOnly=true;
				document.forms[0].solId.value	 = tmp[2];
				//document.forms[0].solId.readOnly=true;

				if((tmp[4] == "Y") && (document.forms[0].funcCode.value=="X"))
				{
					document.forms[0].tellerId.value = "";
					document.forms[0].solId.value	 = "";
				}
			}
		}
	}
	if((document.forms[0].funcCode.value=="V")|| (document.forms[0].funcCode.value=="X"))
	{

		showImage("search1");
		showImage("search3");
		showImage("search2");
		document.forms[0].tellerId.readOnly = false;
		document.forms[0].solId.readOnly = false;
	}
	return (retVal == undefined) ? true : retVal;
}*/

//Validating currency

function fnValidCurr()
{
	if(document.forms[0].crncyCode.value != "")
	{
		convertToCaps(document.forms[0].crncyCode.value);
		var input = "currCode|"+document.forms[0].crncyCode.value ;
		var output = "";
		var scrName = "tlrdenadp009.scr";
		var retVal = appFnExecuteScript(input,"output",scrName,false);
		var accVal = new Array();
		accVal  = retVal.split("|");
		if(accVal[1] == "I")
		{
			alert("Enter Valid Currency");
			document.forms[0].crncyCode.value = "";
			document.forms[0].crncyCode.focus();
			return false;
		}
		else
		{
			return true;
		}
	}
}

//Validating Sol Id

function fnValidSol()
{
	if(document.forms[0].solId.value != "")
	{
		convertToCaps(document.forms[0].solId.value);
		var input = "solId|"+document.forms[0].solId.value ;
		var output = "";
		var scrName = "tlrdenadp010.scr";
		var retVal = appFnExecuteScript(input,"output",scrName,false);
		var accVal = new Array();
		accVal  = retVal.split("|");
		if(accVal[1] == "I")
		{
			alert("Enter Valid Sol Id");
			document.forms[0].solId.value = "";
			document.forms[0].solId.focus();
			//document.forms[0].funcCode.value = "";
			return false;
		}
		else
		{
			return true;
		}
	}
}

//Validating Teller Id

function fnValidTellr()
{
	if(document.forms[0].funcCode.value =="")
	{
	       	alert("Please select function code");
	       	document.forms[0].tellerId.value = "";
	       	document.forms[0].funcCode.focus();
	       	return false;

       	}

	if(document.forms[0].tellerId.value =="")
	{
	       	alert("Please enter valid teller ID");
	       	document.forms[0].tellerId.focus();
	       	return false;

       }

	if(document.forms[0].tellerId.value != "")
	{
		convertToCaps(document.forms[0].tellerId.value);
		var input = "tellrId|"+document.forms[0].tellerId.value +"|func|" +document.forms[0].funcCode.value;
		var output = "";
		var scrName = "tlrdenadp011.scr";
		var retVal = appFnExecuteScript(input,"output",scrName,false);
		var accVal = new Array();
		accVal  = retVal.split("|");
		if(accVal[1] == "I")
		{
			alert("Enter Valid Teller Id");
			document.forms[0].tellerId.value = "";
			document.forms[0].tellerId.focus();
			//document.forms[0].funcCode.value = "";
			return false;
		}
		else
		{
			return true;
		}
	}
}


function fnClearNrorpt()
{
    document.forms[0].reset();
    doSubmit("Clear");
    return true;

}


function getRefCrncyList(){
        var ObjForm = document.forms[0];
        var oldValue = ObjForm.crncyCode.value;
	alert(applangcode);
        var retVal = popModalWindow("../arjspmorph/"+applangcode+"/get_currency.jsp?wReturn=crncyCode&Currency="+oldValue,"CurrencyList");
        if (retVal != null) {
                var j = retVal.split("|");
                ObjForm.crncyCode.value = j[0];
        }
}
