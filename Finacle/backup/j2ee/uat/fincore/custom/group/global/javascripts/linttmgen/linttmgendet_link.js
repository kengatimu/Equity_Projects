var MODIFY = "M";
var PLAN_CHANGE = "P";
var CANCEL = "X";
var VERIFY = "V";
var INQUIRE = "I";
var HIGH_DATE = "31-12-2099";
var err = new ErrObject("", "");

function fnOnLoad() {
	objForm = document.forms[0];
	fnSplitDate();
	fnPopulateControlValues();
	if (schemType != "CLA") {
		objForm.negotiatedRate.value = negotiatedRate
	}
	fnNextDate();
	initFocusHandler();
	checkRadio(objForm.peggedFlg, peggedFlg);
	checkRadio(objForm.reviewReqdOnStartDate, reviewReqdOnStartDate);
	fnAssignDateOnLoad(objForm);
	fnEnableDisablePegFreq();
	if (funcCode == MODIFY && (islamicProdType == "B" || islamicProdType == "A")) {
		objForm.maxInt.disabled = true;
		objForm.minInt.disabled = true
	}
	if (sReferralMode != "I" && sReferralMode != "S") {
		if (funcCode == MODIFY || funcCode == PLAN_CHANGE) {
			if (protPeggedFlg == "Y") {
				fnEnableDisableRadioButtons(objForm.peggedFlg, "D")
			}
			if (protPeggFreqFlg == "Y") {
				objForm.peggedFreqInMnths.disabled = true;
				objForm.peggedFreqInDays.disabled = true
			}
			if (protStartDateFlg == "Y") {
				fnEnableUIField(objForm.startDate, "N");
				hideImage("sLnk3")
			}
			if (protPegRevDateFlg == "Y") {
				fnEnableUIField(objForm.pegReviewDate, "N");
				hideImage("sLnk5")
			}
			if (mrDisableFlg == "Y") {
				fnEnableUIField(objForm.startDate, "N");
				hideImage("sLnk3")
			}
		}
		if (funcCode == MODIFY) {
			objForm.Print.disabled = true
		}
		else {
			if (funcCode == CANCEL) {
				objForm.Print.disabled = true;
				hideImage("sLnk5");
				hideImage("sLnk6");
				hideImage("sLnk7");
				hideImage("sLnk8");
				hideImage("sLnk9")
			}
			else {
				if (funcCode == VERIFY) {
					objForm.Print.disabled = false;
					hideImage("sLnk5");
					hideImage("sLnk6");
					hideImage("sLnk7");
					hideImage("sLnk8");
					hideImage("sLnk9")
				}
			}
		}
		if (funcCode == INQUIRE) {
			objForm.Ok.focus();
			hideImage("sLnk1");
			hideImage("sLnk2");
			hideImage("sLnk3");
			hideImage("sLnk5");
			hideImage("sLnk6");
			hideImage("sLnk7");
			hideImage("sLnk8");
			hideImage("sLnk9")
		}
		else {
			objForm.Submit.focus()
		}
		if (funcCode == PLAN_CHANGE) {
			funcCode = INQUIRE;
			hideImage("sLnk5");
			hideImage("sLnk6");
			hideImage("sLnk7");
			hideImage("sLnk8");
			hideImage("sLnk9");
			fnDisableFormControls(funcCode, objForm, 3);
			objForm.Submit.disabled = false
		}
		else {
			fnDisableFormControls(funcCode, objForm, 3)
		}
	}
	if (schemType == "LAA" && localeCode == "IN") {
		objForm.reasonCode.value = reasonCode;
		objForm.reasonCodeDesc.value = reasonCodeDesc
	}
	if (schemType == "CLA") {
		objForm.compInt.value = compInt;
		objForm.penOnInt.value = penOnInt;
		objForm.penOnPrin.value = penOnPrin;
		objForm.compPenInt.value = compPenInt;
		objForm.intOnOduePrin.value = intOnOduePrin;
		objForm.normRate.value = normRate;
		objForm.spread.value = spread;
		objForm.reasonCode.value = reasonCode;
		objForm.reasonCodeDesc.value = reasonCodeDesc;
		objForm.intPeriodInMnths.value = intPeriodInMnths;
		objForm.intPeriodInDays.value = intPeriodInDays;
		if (interPolationMthd == "L" || interPolationMthd == "N" || interPolationMthd == "S") {
			objForm.interPolationMthd.value = interPolationMthd
		}
		checkRadio(objForm.intPolForCcyHolBrknPrd, intPolForCcyHolBrknPrd)
	}
	if (schemType == "CLA") {
		if ("N" == intPenBrkUpApplFlg) {
			objForm.compInt.value = "";
			objForm.intOnOduePrin.value = "";
			objForm.penOnInt.value = "";
			objForm.penOnPrin.value = "";
			objForm.compInt.readOnly = true;
			objForm.penOnInt.readOnly = true;
			objForm.penOnPrin.readOnly = true;
			objForm.intOnOduePrin.readOnly = true
		}
		else {
			objForm.compPenInt.value = "";
			objForm.compPenInt.readOnly = true;
			if ("N" == penOnPrncDmdFlg) {
				objForm.penOnPrin.value = "";
				objForm.penOnPrin.readOnly = true
			}
			if ("N" == penOnIntDmdFlg) {
				objForm.penOnInt.value = "";
				objForm.penOnInt.readOnly = true
			}
			if ("N" == intOnIntDmdFlg) {
				objForm.compInt.value = "";
				objForm.compInt.readOnly = true
			}
		}
		if ("Y" == sepPenTblCodeExistFlg) {
			objForm.penOnInt.value = "";
			objForm.penOnPrin.value = "";
			objForm.compPenInt.value = "";
			objForm.penOnInt.disabled = true;
			objForm.penOnPrin.disabled = true;
			objForm.compPenInt.disabled = true
		}
	}
	if (funcCode == INQUIRE || funcCode == VERIFY || funcCode == CANCEL) {
		showImage("sLnk1")
	}
	fnPopNumDays();
	if ((schemType == "LAA" && localeCode == "IN") || (schemType == "CLA")) {
		getReasonCodeDesc()
	}
}

function fnSubmitForm(a) {
	convertToCaps();
	disableButtons();
	fnEnableDescFields(objForm);
	disableHyperLnks(3);
	fnEnableFormDataControls(objForm);
	objForm.submitform.value = a;
	objForm.submit();
	return true
}

function fnValidateForm(a) {
	convertToCaps();
	if (!fnChangeEndDate()) {
		return false
	}
	var d = objForm.peggedFreqInMnths;
	var c = objForm.peggedFreqInDays;
	if (!fnValidateNumberFields(d, c)) {
		err.displayErr();
		return false
	}
	if (funcCode == MODIFY || funcCode == PLAN_CHANGE) {
		if (!fnValidateMandatoryFields()) {
			return false
		}
		if (!validateTypes(objForm)) {
			return false
		}
		if (a == window[multiRecName].addNewAction || a == window[multiRecName].prevPageAction || a == window[multiRecName].nextPageAction || a == window[multiRecName].prevAction || a == window[multiRecName].nextAction || a == window[multiRecName].selectAction || a == window[multiRecName].jumpToAction) {
			if (!fnValidateMaxMin()) {
				return false
			}
			if (!fnValidateDays()) {
				return false
			}
			if ((funcCode == MODIFY) || (funcCode == PLAN_CHANGE) && (btnObj.id == "next")) {
				var b = new String();
				addDayMonthsToDate(objForm.endDate, d, c, b);
				if (!fnCompareDates(b.value, HIGH_DATE) || b.value == HIGH_DATE) {
					alert(finbranchResource.FAT000884);
					return false
				}
			}
			if ((funcCode != MODIFY) && (funcCode != PLAN_CHANGE || sReferralMode == "S" || sReferralMode == "I") && (!isNavigationRequired(btnObj.id, currPos, iTotalSize, null))) {
				return false
			}
			if (mrDisableFlg == "Y") {
				alert(finbranchResArr.get("FAT000885"));
				return false
			}
		}
	}
	return true
}

function fnOnButtonClick(a) {
	objForm.actionCode.value = a.id;
	if (a.id == "Submit" || a.id == "Validate") {
		if (funcCode == VERIFY && allVisitFlg != "Y" && a.id == "Submit") {
			alert(finbranchResArr.get("FAT000886"));
			return false
		}
		if (MODIFY == funcCode) {
			if (!fnCompareDates(objForm.startDate.value, objForm.endDate.value)) {
				alert(finbranchResArr.get("FAT001350"));
				fnSetFocusForDate(objForm.endDate);
				return false
			}
		}
		if (fnValidateForm() && fnValidateMaxMin() && fnValidateDays()) {
			fnSubmitForm(a.id)
		}
	}
	else {
		if (a.id == "Ok" || a.id == "Print") {
			fnSubmitForm(a.id)
		}
		else {
			if (a.id == "Cancel") {
				fnShowCancelDialog();
				return true
			}
		}
	}
	return true
}

function fnSplitDate() {
	var a = startDate.split(" ");
	var b = endDate.split(" ");
	startDate = a[0];
	endDate = b[0]
}

function fnNextDate() {
	if (isNewRec == "true") {
		if (peggedFlg == "Y") {
			addDayMonthsToDate(objForm.startDate, objForm.peggedFreqInMnths.value, objForm.peggedFreqInDays.value, objForm.endDate)
		}
		else {
			objForm.endDate.value = HIGH_DATE
		}
		addDayMonthsToDate(objForm.startDate, "0", "1", objForm.startDate)
	}
}

function fnChangeEndDate() {
	if ((objForm.numOfDays.value <= 0) && (!fnIsNull(objForm.startDate.value))) {
		alert(finbranchResArr.get("FAT000392"));
		objForm.numOfDays.focus();
		return false
	}
	addDayMonthsToDate(objForm.startDate, "0", (objForm.numOfDays.value - 1), objForm.endDate);
	if (!fnCompareDates(objForm.endDate.value, HIGH_DATE)) {
		alert(finbranchResArr.get("FAT000883"));
		fnSetFocusForDate(objForm.endDate);
		return false
	}
	else {
		fnAssignUIDate(objForm.endDate)
	}
	return true
}

function fnDateDiff(f, d) {
	var g = new Date(f.substring(6, 10), parseInt(f.substring(3, 5) - 1, 10), f.substring(0, 2));
	var e = new Date(d.substring(6, 10), parseInt(d.substring(3, 5) - 1, 10), d.substring(0, 2));
	var c = Math.round(g.getTime() / (24 * 3600 * 1000));
	var b = Math.round(e.getTime() / (24 * 3600 * 1000));
	var a = c - b;
	return a
}

function fnPopNumDays() {
	if ((!fnIsNull(objForm.startDate.value)) && (!fnIsNull(objForm.endDate.value))) {
		objForm.numOfDays.value = fnDateDiff(objForm.endDate.value, objForm.startDate.value) + 1
	}
}

function fnValidateMaxMin() {
	if (getValInFloat(objForm.maxInt.value) < 0) {
		alert(finbranchResArr.get("FAT000487"));
		objForm.maxInt.focus();
		return false
	}
	if (getValInFloat(objForm.minInt.value) < 0) {
		alert(finbranchResArr.get("FAT000487"));
		objForm.minInt.focus();
		return false
	}
	if (getValInFloat(objForm.minInt.value) > getValInFloat(objForm.maxInt.value)) {
		alert(finbranchResArr.get("FAT005148"));
		objForm.minIntDr.focus();
		return false
	}
	return true
}

function fnEnableDisablePegFreq() {
	if (getRadioValue(objForm.peggedFlg) == "N") {
		objForm.peggedFreqInMnths.disabled = true;
		objForm.peggedFreqInDays.disabled = true;
		objForm.pegReviewDate.value = "";
		objForm.peggedFreqInMnths.value = "";
		objForm.peggedFreqInDays.value = "";
		linkHide("sLnk5", true);
		disableFields("pegReviewDate")
	}
	else {
		objForm.peggedFreqInMnths.disabled = false;
		objForm.peggedFreqInDays.disabled = false;
		objForm.pegReviewDate.value = pegReviewDate;
		enableFields("pegReviewDate");
		linkHide("sLnk5", false);
		objForm.peggedFreqInMnths.value = peggedFreqInMnths;
		if (mopId = "HLINTTM") {
			if (funcCode == "M") {
				if (peggedFreqInDays == "0") {
					objForm.peggedFreqInDays.value = "999";
				}
			}
		}
	}
}

function fnValidateDays() {
	if ((parseInt(objForm.peggedFreqInMnths.value, 10) > 0) && (parseInt(objForm.peggedFreqInDays.value, 10) > 30)) {
		alert(finbranchResArr.get("FAT000318"));
		objForm.peggedFreqInDays.focus();
		return false
	}
	return true
}

function addRowForLinttm(arrObj) {
	var recNum = arrObj[0];
	var isCurrRec = arrObj[1];
	var locStyle = "";
	var temp = "";
	if (isCurrRec == "Y") {
		locStyle = 'class="searclist1arow"'
	}
	else {
		if (recNum % 2 == 0) {
			locStyle = 'class="searclist1"'
		}
		else {
			locStyle = 'class="searclist2"'
		}
	}
	with(document) {
		if (schemType == "CLA") {
			if ("N" == intPenBrkUpApplFlg) {
				write("<tr " + locStyle + 'class="ctext">');
				write('<td width="6%">' + jsUtil.encodeChar(arrObj[2]) + "&nbsp;</td>");
				write('<td width="6%">' + jsUtil.encodeChar(arrObj[3]) + "&nbsp;</td>");
				write('<td width="8%">' + jsUtil.encodeChar(arrObj[4]) + "&nbsp;</td>");
				write('<td width="5%">' + jsUtil.encodeChar(arrObj[19]) + "&nbsp;</td>");
				write('<td width="8%">' + jsUtil.encodeChar(arrObj[5]) + "&nbsp;</td>");
				write('<td width="8%">' + jsUtil.encodeChar(arrObj[6]) + " &nbsp;</td>");
				write('<td width="8%">' + jsUtil.encodeChar(arrObj[7]) + " &nbsp;</td>");
				write('<td width="8%">' + jsUtil.encodeChar(arrObj[8]) + " &nbsp;</td>");
				write('<td width="8%">' + jsUtil.encodeChar(temp) + "<br>" + jsUtil.encodeChar(temp) + " &nbsp;</td>");
				write('<td width="8%">' + jsUtil.encodeChar(temp) + "<br>" + jsUtil.encodeChar(temp) + " &nbsp;</td>");
				write('<td width="8%">' + jsUtil.encodeChar(arrObj[13]) + " &nbsp;</td>");
				write('<td width="5%">' + jsUtil.encodeChar(arrObj[14]) + " &nbsp;</td>");
				write('<td width="6%">' + jsUtil.encodeChar(arrObj[15]) + " &nbsp;</td>");
				write('<td width="6%">' + jsUtil.encodeChar(arrObj[18]) + " &nbsp;</td>");
				write('<td width="2%" class="leftscroll">&nbsp;</td>')
			}
			else {
				write("<tr " + locStyle + 'class="ctext">');
				write('<td width="6%">' + jsUtil.encodeChar(arrObj[2]) + " &nbsp;</td>");
				write('<td width="6%">' + jsUtil.encodeChar(arrObj[3]) + " &nbsp;</td>");
				write('<td width="8%">' + jsUtil.encodeChar(arrObj[4]) + " &nbsp;</td>");
				write('<td width="5%">' + jsUtil.encodeChar(arrObj[19]) + " &nbsp;</td>");
				write('<td width="8%">' + jsUtil.encodeChar(arrObj[5]) + " &nbsp;</td>");
				write('<td width="8%">' + jsUtil.encodeChar(arrObj[6]) + " &nbsp;</td>");
				write('<td width="8%">' + jsUtil.encodeChar(arrObj[7]) + " &nbsp;</td>");
				write('<td width="8%">' + jsUtil.encodeChar(arrObj[8]) + " &nbsp;</td>");
				write('<td width="8%">');
				if ("Y" == intOnIntDmdFlg) {
					write(arrObj[9])
				}
				write("<br>" + jsUtil.encodeChar(arrObj[10]) + " &nbsp;</td>");
				write('<td width="8%">');
				if ("Y" == penOnPrncDmdFlg) {
					write(arrObj[11])
				}
				write("<br>");
				if ("Y" == penOnIntDmdFlg) {
					write(arrObj[12])
				}
				write("&nbsp;</td>");
				write('<td width="8%">' + jsUtil.encodeChar(temp) + "&nbsp;</td>");
				write('<td width="5%">' + jsUtil.encodeChar(arrObj[14]) + " &nbsp;</td>");
				write('<td width="6%">' + jsUtil.encodeChar(arrObj[15]) + " &nbsp;</td>");
				write('<td width="6%">' + jsUtil.encodeChar(arrObj[18]) + " &nbsp;</td>");
				write('<td width="2%" class="leftscroll">&nbsp;</td>')
			}
		}
		else {
			write("<tr " + locStyle + 'class="ctext">');
			write("<td>" + jsUtil.encodeChar(arrObj[4]) + " &nbsp;</td>");
			write("<td>" + jsUtil.encodeChar(arrObj[16]) + " &nbsp;</td>");
			write("<td>" + jsUtil.encodeChar(fnConvertToUIDate(arrObj[2])) + " &nbsp;</td>");
			write("<td>" + jsUtil.encodeChar(fnConvertToUIDate(arrObj[3])) + " &nbsp;</td>");
			write("<td>" + jsUtil.encodeChar(arrObj[14]) + " &nbsp;</td>");
			write("<td>" + jsUtil.encodeChar(fnConvertToUIDate(arrObj[15])) + " &nbsp;</td>");
			write("<td>" + jsUtil.encodeChar(arrObj[17]) + " &nbsp;</td>");
			write("<td>" + jsUtil.encodeChar(fnConvertToUIDate(arrObj[18])) + " &nbsp;</td>");
			write('<td class="leftscroll">&nbsp;</td>')
		}
	}
	document.write("</tr>")
}

function getReasonCodeDesc() {
	var a = objForm.reasonCode.value;
	if (fnIsNull(a)) {
		clearDescField("reasonCodeDesc")
	}
	else {
		sendDataToServer("myframe", "REFCODE", "F", "reasonCode|refRecType", "reasonCodeDesc")
	}
}

function searcherForIntTblCode() {
	showIntTblCodeWithVersionWE(objForm.intTblCode, "LCB", document.forms[0].intTblDesc, "V", "", objForm.intTblVerNum, "");
	if (getRadioValue(objForm.peggedFlg) == "N") {
		objForm.intTblVerNum.value = ""
	}
};