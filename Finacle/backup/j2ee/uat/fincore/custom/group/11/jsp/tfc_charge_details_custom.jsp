<!---------------------------------------------------------------------------------------------------------------->
<!--Name              :  tfc_charge_details_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 28-06-2013
<!--Author            : george
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : OGM
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		28-06-2013		george		Original version
<!--    0.2		13-08-2013   	Venki		Fix for 357258[ODCM]
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../../javascripts/common_functions.js" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>

<script type="text/javascript">
with(document) {
	write('<input type="hidden" name="evtAmt" id="evtAmt">');
}

function tfc_charge_details_post_ONLOAD(obj) {
	//document.forms[0].chargeRemarks.disabled = true;
	document.forms[0].tranParticulars.disabled = true;
	var dcAmt = "0";
	var evtAmt = "0"
	if (mopId == "ODCM") {
		if (document.forms[0].funcCode.value != "V") {
			var custDataTemp = document.forms[0].customData.value;
			var custData = custDataTemp.split("|");
			for (var i = 0; i < custData.length; i++) {
				if (custData[i] == "~odcm_general_details") {
					dcAmt = custData[i + 1];
				}
			}
			for (var j = 0; j < custData.length; j++) {
				if (custData[j] == "~tfc_charge_details") {
					evtAmt = custData[j + 1];
				}
			}
			if (evtAmt == dcAmt) {

			}
			else {
				document.forms[0].evtAmt.value = dcAmt;
				setFieldsToCustomData("evtAmt");
				doSubmit("Recalculate");
			}
		}
	}

	if (mopId == "HIRM") {

		var dco = document.forms[0].operAccntId.value;
		var inputNameValues = "dco|" + dco;
		var outputNames = "schm|outVal";
		var scrName = "b_loanschm.scr";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		var output = ret[0];
		var value = ret[1];
		var value2 = ret[3];
		var value3 = ret[5];
		var a = value;
		var b = value2;
		var c = value3;
		var funcCode = document.forms[0].funcCode.value;

		if (profileId == "11") {

			if (funcCode == 'G' || funcCode == 'J' || funcCode == 'M') {
				if (c == "Y") {
					//the below line can be uncommented so as the charge Id is flushed off.
					document.forms[0].chargeId.value = "";
					document.forms[0].chargeId.disabled = true;
					//the below 2 lines to be commented if chargeId is to be flushed.
					document.forms[0].calculatedAmt.value = "0.00";
					document.forms[0].immediateCollectionAmt.value = "0.00";
					document.forms[0].evtAmt.value = "valSet";
					setFieldsToCustomData("evtAmt");
					if (paramLen == -1) {
						document.forms[0].Validate.click();
					}
				}
					if (c == "Y"){
					document.forms[0].chargeId.value = "";
					document.forms[0].chargeId.focus();
					return false;
				}
			}
		}


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

		//modified by Anuya
		var modParams = "valSet";
		var paramLen = myString.indexOf(modParams);
		//end of modification

		var custPayDataSplit = newremitType.split('|');
		var remitType = custPayDataSplit[1].toUpperCase();
		var funcCode = custPayDataSplit[3].toUpperCase();

		var n = remitType.indexOf(subtype3);
		if (n > 0 && (funcCode == 'G' || funcCode == 'M')) {
			if (document.forms[0].chargeId.value == "") {
				document.forms[0].chargeId.value = chargeeventid4;
				document.forms[0].rateCode.value = ratecode2;
				document.forms[0].evtAmt.value = "valSet";
				setFieldsToCustomData("evtAmt");
				if (paramLen == -1) {
					fnresetcalcamt();
				}

			}
			return true;
		}
		else if (funcCode == 'G' || funcCode == 'M') {
			if (document.forms[0].chargeId.value == "") {
				document.forms[0].chargeId.value = chargeeventid5;
				document.forms[0].rateCode.value = ratecode2;
				document.forms[0].evtAmt.value = "valSet";
				setFieldsToCustomData("evtAmt");
				if (paramLen == -1) {
					fnresetcalcamt();
				}

			}
			return true;
		}
		else if (funcCode == "R") {
			if (document.forms[0].chargeId.value == "") {
				document.forms[0].chargeId.value = chargeeventid6;
				document.forms[0].rateCode.value = ratecode2;
				document.forms[0].evtAmt.value = "valSet";
				setFieldsToCustomData("evtAmt");
				if (paramLen == -1) {
					fnresetcalcamt();
				}
				
			}
			return true;
		}
		else if (profileId == "11") {
			if (funcCode == 'J' && a == 'CA289') {
				document.forms[0].chargeId.value = "IRMSUP";
				document.forms[0].rateCode.value = ratecode2;
				document.forms[0].evtAmt.value = "valSet";
				setFieldsToCustomData("evtAmt");
				if (paramLen == -1) {
					fnresetcalcamt();
				}
				return true;
			}
			
		}
	}
}


function pre_TAB_SWITCH(obj) {
	if (mopId == 'HIRM') {
		document.forms[0].evtAmt.value = "";
		setFieldsToCustomData("evtAmt");
	}
}

</script>

