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
<script language="javascript" src="../../javascripts/common_functions.js">
</script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js"></script>

<script type="text/javascript">
with(document) {
	write('<input type="hidden" name="evtAmt" id="evtAmt">');
	write('<input type="hidden" name="custom.customchk" id="customchk">');
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
		var chkremitType = ret[25];
		var chkcur = ret[27];

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
		var crncy = custPayDataSplit[2].toUpperCase();
		var funcCode = custPayDataSplit[3].toUpperCase();
		var n = remitType.indexOf(subtype3);
		if (n > 0 && (funcCode == "G" || funcCode == "M")) {
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
		else if (funcCode == "G" || funcCode == "M") {
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

		if (funcCode == "W") {
			if ((myString.search("~tfc_charge_details")) > 0) {
				var eventLen = myString.search("~tfc_charge_details");
				var newVal = myString.substring(eventLen, myString.length);
				var custDataSplit = newVal.split('|');
				var chkFlag = custDataSplit[1].toUpperCase();
			}
			else {
				var chkFlag = "N"
			}
			if (chkFlag != "Y") {
				if ((remitType == chkremitType) && (crncy == chkcur)) {
					document.forms[0].chargeId.value = "";
					document.forms[0].rateCode.value = ratecode2;
					document.forms[0].evtAmt.value = "valSet";
					setFieldsToCustomData("evtAmt");
					if (paramLen == -1) {
						fnresetcalcamt();
					}

				}
			}
		}


	}
}

function tfc_charge_details_ONCHANGE(obj) {
	if (funcCode == "W") {
		if (obj.id == "chargeId") {
			document.forms[0].customchk.value = "Y";
			setFieldsToCustomData("customchk");
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