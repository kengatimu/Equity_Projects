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
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src= "../../custom/javascripts/custom_functions.js"></script>
<script type ="text/javascript">
function post_ONLOAD() {
	//alert("am in");
	//alert(pstAccount);

	/*var dco = document.forms[0].pstAccount.value;
	var inputNameValues = "dco|" + dco;
	var outputNames = "schm|outVal";
	var scrName = "b_loanschm.scr";
	var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var ret = retVal.split("|");
	var output = ret[0];
	var value = ret[1];
	var a = value;
	alert(a);*/

	var inputNameValues = "";
	var outputNames = "val1";
	var scrName = "rmdfltpopmn001.scr";
	var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var ret = retVal.split("|");
	var chargeeventid5 = ret[13];
	var subtype3 = ret[19];
	var chargeeventid4 = ret[11];
	var ratecode2 = ret[15];
	var chargeeventid6 = ret[21];

	var custData = document.forms[0].customData.value;
	var custSplit = custData.split('|')
	var length = custSplit.length;
	var myString = custData;
	var remitTypeLen = myString.search("~irmcrit");
	var newremitType = myString.substring(remitTypeLen, myString.length);
	var custPayDataSplit = newremitType.split('|');
	var remitType = custPayDataSplit[1].toUpperCase();
	var funcCode = custPayDataSplit[3].toUpperCase();

	var radioButtons = document.getElementsByName('consolidateFlg');
	radioButtons[1].checked = true;
	radioButtons[0].checked = false;
	document.forms[0].notConvRate.disabled = true;
	fnChangeRateCode();

	var n = remitType.indexOf(subtype3);
	if (n > 0 && (funcCode == 'G' || funcCode == 'M')) {
		if (document.forms[0].rateCode.value == "") {
			document.forms[0].rateCode.value = ratecode2;
			fnChangeEventRateCode();
		}
		return true;
	}
	else if (funcCode == 'G' || funcCode == 'M') {
		if (document.forms[0].rateCode.value == "") {
			document.forms[0].rateCode.value = ratecode2;
			fnChangeEventRateCode();
		}
		return true;
	}
	else if (funcCode == "R") {
		if (document.forms[0].rateCode.value == "") {
			document.forms[0].rateCode.value = ratecode2;
			fnChangeEventRateCode();
		}
		return true;
	}
	else if (profileId == "11") {
		//if (funcCode == 'J' && a == 'CA289') {
		if (funcCode == 'J') {

			//alert("am in too");
			if (document.forms[0].rateCode.value == "") {
				document.forms[0].rateCode.value = ratecode2;
				fnChangeEventRateCode();
			}
			return true;
		}
	}

}

function irmeventdet_pre_ONCLICK(obj) {
	if ((funcCode == 'G' || funcCode == 'M') && (obj.id == "Submit" || obj.id == "Validate")) {
		var rate = document.forms[0].rate.value;
		var base = document.forms[0].notConvRate.value;
		var inputNameValues = "rate" + "|" + rate + "|" + "base" + "|" + base;
		var outputNames = "status1";
		var scrName = "rmdfltpopmn002.scr";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
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
