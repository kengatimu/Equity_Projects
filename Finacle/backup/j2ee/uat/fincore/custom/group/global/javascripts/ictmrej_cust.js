/*-----------------------------------------------------------------------------------------
    NAME            :   ictmrej_custom.js
    Module Code     :   DENOM
    Menu Option     :   HACLINQ
    Author          :   Khan
    DATE            :   11-07-2013

    Modification History:
    ====================
    Serial No.      DATE            Author               Description
    1           11-07-2013          Khan                 Draft Version
--------------------------------------------------------------------------------------------*/
function fnOnLoad() {
	getFieldsFromCustomData("instAmt");
	var csdata = document.forms[0].customData.value;
	var csdataTemp = csdata.split("|");
	var amount = csdataTemp[1];
	var amount = removeCommas(amount);
	objForm = document.forms[0];
	initFocusHandler();
	fnPopulateControlValues();
	checkRadio(objForm.drawnOnUsFlg, drawnOnUsFlg);
	fnSetCheckboxCtrl(objForm);
	fnDisableFormDataControls(funcCode, objForm, 12);
	if (rejType == 'E') {
		if (fnIsNull(extnNoOfDays)) {
			objForm.extnNoOfDays.value = 1;
		}
		objForm.extnCode.focus();
		disableFields('rejCode1', 'rejCode2', 'rejCode3', 'rejCode4', 'rejCode5');
		hideImage("sLnk1");
		hideImage("sLnk2");
		hideImage("sLnk3");
		hideImage("sLnk4");
		hideImage("sLnk5");
	}
	else {
		objForm.extnNoOfDays.value = "";
		objForm.extnCode.value = "";
		objForm.rejCode1.focus();
		hideImage("sLnk11");
		disableFields('extnCode', 'extnNoOfDays');
	}
	if (rejType == 'O') {
		checkRadio(objForm.drawnOnUsFlg, 'N');
		//var outRejSolId = objForm.outRejSolId.value;
		var acctId = objForm.acctId.value;
		var acctCrncy = objForm.acctCrncy.value;
		var instrNum = objForm.instrNum.value;
		var acctSolId = objForm.acctSolId.value;

		var inputValues = "acctId|" + acctId + "|acctCrncy|" + acctCrncy + "|acctSolId|" + "|instrNum|" + instrNum + "|amount|" + amount;
		//var outputValues = "outRejSolId|outRejZoneCode|outRejZoneDate|outRejSetNum|outRejInstSrlNum";
		var outputValues = "";
		var scriptName = "populateValueForOutRej.scr";
		//var retVal = appFnExecuteScript(inputValues ,outputValues ,scriptName ,true);
		var retVal = appFnExecuteScript(inputValues, outputValues, scriptName, false);

		if (retVal != "") {
			var retBuff = retVal.split("|");
			objForm.outRejSolId.value = retBuff[1];
			objForm.outRejZoneCode.value = retBuff[3];
			objForm.outRejZoneDate.value = retBuff[5];
			objForm.outRejSetNum.value = retBuff[7];
			objForm.outRejInstSrlNum.value = retBuff[9];
		}

	}
	if (vStatus == 'B') {
		hideImage("sLnk6");
		hideImage("sLnk7");
		hideImage("sLnk9");
		hideImage("sLnk10");
	}
}


function removeCommas(str) {
	while (str.search(",") >= 0) {
		str = (str + "").replace(',', '');
	}
	return str;
};