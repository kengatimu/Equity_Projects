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
<script language="javascript" src="../../javascripts/common_functions.js"></script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js"></script>

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

	//additional code for Onload to be added after this line.
	if (mopId == "HIRM") {

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
		var subtype4 = ret[25];
		var crcncy = ret[27];

		var custData = document.forms[0].customData.value;
		var myString = custData;
		var remitTypeLen = myString.search("~irmcrit");
		var newremitType = myString.substring(remitTypeLen, myString.length);
		var custPayDataSplit = newremitType.split('|');
		var remitType = custPayDataSplit[1].toUpperCase();
		var remitCcy = custPayDataSplit[2].toUpperCase();
		var funcCode = custPayDataSplit[3].toUpperCase();
		getFieldsFromCustomData("evtAmt");
		var n = remitType.indexOf(subtype3);
		var m = remitType.indexOf(subtype4);
		//modified by Anuya
		var modParams = "valSet";
		var paramLen = myString.indexOf(modParams);

		//end of modification

		if (n > 0 && (funcCode == 'G' || funcCode == 'M')) {
			if (paramLen == -1) {
				if (document.forms[0].chargeId.value == "") {
					document.forms[0].chargeId.value = chargeeventid4;
					document.forms[0].rateCode.value = ratecode2;
					document.forms[0].evtAmt.value = "valSet";
					setFieldsToCustomData("evtAmt");

					fnresetcalcamt();
				}



			}
			//return true;
		}
		else if (m > 0 && funcCode == "W" && crcncy == remitCcy) {
			document.forms[0].chargeId.value = "";
			//return true;
		}
		else if (funcCode == 'G' || funcCode == 'M') {
			if (paramLen == -1) {
				if (document.forms[0].chargeId.value == "") {
					document.forms[0].chargeId.value = chargeeventid5;
					document.forms[0].rateCode.value = ratecode2;
					document.forms[0].evtAmt.value = "valSet";
					setFieldsToCustomData("evtAmt");
					fnresetcalcamt();
				}

			}
			//return true;
		}
		else if (funcCode == "R") {
			if (document.forms[0].chargeId.value == "") {
				if (paramLen == -1) {
					document.forms[0].chargeId.value = chargeeventid6;
					document.forms[0].rateCode.value = ratecode2;
					document.forms[0].evtAmt.value = "valSet";
					setFieldsToCustomData("evtAmt");

					fnresetcalcamt();
				}



			}
			//return true;
		}

		if (profileId == "50") {
			if (funcCode == 'G' || funcCode == 'J' || funcCode == 'M') {
				var pstAccount = document.forms[0].operAccntId.value;
				var input = "pstAccount|" + pstAccount;
				var outputNames = "output|exemptFlg|outVal";
				var scrName = "getschmCode.scr";
				var retVal = appFnExecuteScript(input, outputNames, scrName, false);
				var retBuff = retVal.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var value2 = retBuff[3];
				var a = value;
				var b = value2;

				//if (a == "CA202") {
				if (a == "CA202" || a == "CA205" || a == "CA210" || a == "SB110" || a == "SB105") {
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
					if ((a == "CA202" || a == "CA205" || a == "CA210" || a == "SB110" || a == "SB105") && (b == "Y")){
					document.forms[0].chargeId.value = "";
					document.forms[0].chargeId.focus();
					return false;
				}
			}

		}

		document.forms[0].evtAmt.value = "valSet";
		setFieldsToCustomData("evtAmt");
		return true;
	}
	//onload ends
}


</script>