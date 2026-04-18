<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : irmeventdet_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.This script used to make the field protected and populated.
<!--Date                : 13-03-2013
<!--Author              : Shilpa
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HORM/HIRM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            13-03-2013           Shilpa           Original version
<!--     0.2            6-06-2013            Shilpa           getting data from crit page
<!--     0.3            19-06-2013           Shilpa           split value modified in post_onload function.
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src= "../../custom/javascripts/custom_functions.js"></script>
<script type ="text/javascript">

function post_ONLOAD()
	{
		var	inputNameValues    = "";
		var	outputNames        = "val1";
		var	scrName            = "rmdfltpopmn001.scr";
		var	retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		var chargeeventid5= ret[13]; 
		var subtype3= ret[19];  
		var chargeeventid4= ret[11]; 
		var ratecode2= ret[15];
		var chargeeventid6= ret[21];
		var subtype4= ret[25];
		var crcncy= ret[27];
       	var custData = document.forms[0].customData.value;
		var myString = custData;
		var remitTypeLen = myString.search("~irmcrit");
		var newremitType = myString.substring(remitTypeLen ,myString.length);
		var custPayDataSplit = newremitType.split('|');
		var remitType = custPayDataSplit[1].toUpperCase();
       	var remitCcy = custPayDataSplit[2].toUpperCase();
		var funcCode = custPayDataSplit[3].toUpperCase();	
			
		var radioButtons = document.getElementsByName('consolidateFlg');
		radioButtons[1].checked = true;
       	radioButtons[0].checked = false;
	
	
		document.forms[0].notConvRate.disabled = true;
		fnChangeRateCode();
       	
		var n = remitType.indexOf(subtype3);
		var m = remitType.indexOf(subtype4);

		if (profileId == "50")
		{
			if(funcCode == 'G'||funcCode == 'J'||funcCode == 'M')
			{
			 	var pstAccount = document.forms[0].pstAccount.value;
				var input      = "pstAccount|"+pstAccount;
				var outputNames    = "output|outVal";
				var scrName     =   "getschmCode.scr";
				var retVal = appFnExecuteScript(input,outputNames,scrName,false);
				var retBuff = retVal.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var a = value;

				if (a == "CA202")
					{
					clearDescField("chrgEvntId");
					}
			}
		}

       	if (n > 0 && (funcCode == 'G'||funcCode == 'M')){ 			
			if(document.forms[0].rateCode.value ==""){	
				document.forms[0].rateCode.value = ratecode2;
				fnChangeEventRateCode();
			}
			if(document.forms[0].chrgEvntId.value == ""){
				document.forms[0].chrgEvntId.value = chargeeventid4;
			}
			return true;
		}
		else if(m>0 && funcCode=="W" && crcncy==remitCcy)
		{
			if(document.forms[0].rateCode.value ==""){
				document.forms[0].rateCode.value = ratecode2;
				fnChangeEventRateCode();
            }
			document.forms[0].chrgEvntId.value = "";
			return true;
		} 
		else if(funcCode == 'G'||funcCode == 'M'){
			if(document.forms[0].rateCode.value ==""){
				document.forms[0].rateCode.value = ratecode2;
				fnChangeEventRateCode();
			}
			if(document.forms[0].chrgEvntId.value == ""){
				document.forms[0].chrgEvntId.value = chargeeventid5;
			}
			return true;
		}
		else if(funcCode == "R"){
			if(document.forms[0].rateCode.value ==""){
				document.forms[0].rateCode.value = ratecode2 ;
				fnChangeEventRateCode();
        	}
        	if(document.forms[0].chrgEvntId.value == ""){
				document.forms[0].chrgEvntId.value = chargeeventid6;
        	}
			return true;
		}
}

function irmeventdet_pre_ONCLICK(obj){
	if((funcCode == 'G' || funcCode == 'M') && (obj.id == "Submit" || obj.id == "Validate")){         
		var rate = document.forms[0].rate.value;
		var base = document.forms[0].notConvRate.value;
		var	inputNameValues    = "rate" + "|" + rate + "|" + "base" + "|" + base;
		var	outputNames        = "status1";
		var	scrName            = "rmdfltpopmn002.scr";
		var	retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		var base1 = ret[5];
		if (base1 == "Y") {
			alert("CONVERTION RATE OUT OF RANGE.....CANNOT PROCEED!");
			document.forms[0].rate.focus();
			return false;
		}
	}
}	
</script>
