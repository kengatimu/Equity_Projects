<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : ormevent_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.This is  used to make 
<!--                      the fields protected and populated
<!--Date                : 13-03-2013
<!--Author              : Shilpa
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HORM/HIRM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            13-03-2013           Shilpa           Original version
<!--     0.2            19-06-2013           Shilpa           set variable removed
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src= "../../custom/javascripts/custom_functions.js"></script>
<script type ="text/javascript">
function post_ONLOAD(){
	if((funcCode == 'J')||(funcCode == 'M')){
        var	inputNameValues    = "";
		var	outputNames        = "val1";
		var	scrName            = "rmdfltpopmn001.scr";
		var	retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
      	var subtype1= ret[1];  
		var ratecode1= ret[3]; 
		var chargeeventid1= ret[5]; 
		var chargeeventid2= ret[7]; 
		var chargeeventid3= ret[9]; 
		var chargeeventid4= ret[11]; 
		var ratecode2= ret[15]; 
		var subtype2= ret[17]; 
		var chargeeventid6= ret[21];   
                            
        var radioButtons = document.getElementsByName('consolidateFlg');
		radioButtons[1].checked = true;
        radioButtons[0].checked = false;
		document.forms[0].notConvRate.disabled = true;
        var custData = document.forms[0].customData.value;
        var custSplit = custData.split('|')
		var length = custSplit.length;
		var myString = custData;
		var oprAcctLen = myString.search("~ormgendtl");
		var remitTypeLen = myString.search("~ormcrit");
		var newremitType = myString.substring(remitTypeLen ,myString.length);
		var newoprAcct = myString.substring(oprAcctLen,myString.length);
		var custPayDataSplit = newremitType.split('|');
		remitType = custPayDataSplit[1].toUpperCase();
		var custPayDataSplit1 = newoprAcct.split('|');
		oprAcct= custPayDataSplit1[1];  
		var n = remitType.indexOf(subtype1);	
		var m = remitType.indexOf(subtype2);	
    
		if(n>0) {
			if(document.forms[0].rateCode.value ==""){
			document.forms[0].rateCode.value = ratecode1;
				fnChangeEventRate();
			}
			if(document.forms[0].chrgEvntId.value == ""){
			document.forms[0].chrgEvntId.value = chargeeventid1;
			}
			return true;
		}
		else if(m>0){
			if(document.forms[0].rateCode.value ==""){	
				document.forms[0].rateCode.value = ratecode1;
				fnChangeEventRate();
			}	
			if(document.forms[0].chrgEvntId.value == ""){
				document.forms[0].chrgEvntId.value = chargeeventid3;
			}
			return true;
		}
        else{
			if(document.forms[0].rateCode.value ==""){	
				document.forms[0].rateCode.value = ratecode1;
				fnChangeEventRate();
			}
			if(document.forms[0].chrgEvntId.value == ""){
				document.forms[0].chrgEvntId.value = chargeeventid2;
			}
			return true;
		}
       

	}
    

	if (funcCode == "R"){
		var inputNameValues    = "";
		var outputNames        = "val1";
		var scrName            = "rmdfltpopmn001.scr";
		var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		var ratecode2= ret[15];
		var chargeeventid6= ret[21];
		if(document.forms[0].rateCode.value ==""){
		document.forms[0].rateCode.value = ratecode2 ;
            fnChangeEventRate();
        }
        if(document.forms[0].chrgEvntId.value == ""){
		document.forms[0].chrgEvntId.value = chargeeventid6;
        }
		return true;
	}
}

function ormeventdet_pre_ONCLICK(obj){
	if((funcCode == 'J' || funcCode == 'M') && (obj.id == "Submit" || obj.id == "Validate")){
		var rate = document.forms[0].rate.value;
		var base = document.forms[0].notConvRate.value;
		var	inputNameValues    = "rate" + "|" + rate + "|" + "base" + "|" + base;
		var	outputNames        = "status1";
		var	scrName            = "rmdfltpopmn006.scr";
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


function ormeventdet_ONCHANGE(obj){   
	if((funcCode == 'J')||(funcCode == 'M')){
		if(obj.id == "rate"){
			var rate = document.forms[0].rate.value;
			var base = document.forms[0].notConvRate.value;
			var	inputNameValues    = "rate" + "|" + rate + "|" + "base" + "|" + base;
			var	outputNames        = "status1";
			var	scrName            = "rmdfltpopmn002.scr";
			var	retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			var base1 = ret[5];
			if (base1 == "Y"){
				alert("CONVERTION RATE OUT OF RANGE.....CANNOT PROCEED!");
				document.forms[0].rate.focus();
				return false;
			}
		}
	}	
}
</script>

