var objForm = null;
var err = new ErrObject("", "");

function fnIsValidDateOfBirth(b, a) {
    if (fnIsValidDate(a)) {
        if (!fnIsNull(b.value) && !fnCompareDates(a.value, b.value)) {
            err.setErr(a, finbranchResArr.get("FAT000193"));
            return false
        }
    } else {
        err.setErr(a, finbranchResArr.get("FAT000188"));
        return false
    }
    return true
}

function fnIsValidGuardianDetails(g) {
    var a = g.grdnCode;
    var j = g.grdnName;
    var h = g.grdnAddrLine1;
    var e = g.grdnAddrLine2;
    var c = g.grdnAddrLine3;
    var d = g.grdnCityCode;
    var b = g.grdnStateCode;
    var f = g.grdnPostalCode;
    var i = g.grdnCntryCode;
    if (!fnIsNull(a.value)) {
        err.setErr(a, finbranchResArr.get("FAT000173"));
        return false
    }
    if (!fnIsNull(j.value)) {
        err.setErr(j, finbranchResArr.get("FAT000174"));
        return false
    }
    if (!fnIsNull(h.value)) {
        err.setErr(h, finbranchResArr.get("FAT000175"));
        return false
    }
    if (!fnIsNull(e.value)) {
        err.setErr(e, finbranchResArr.get("FAT000175"));
        return false
    }
    if (!fnIsNull(c.value)) {
        err.setErr(c, finbranchResArr.get("FAT000175"));
        return false
    }
    if (!fnIsNull(d.value)) {
        err.setErr(d, finbranchResArr.get("FAT000176"));
        return false
    }
    if (!fnIsNull(b.value)) {
        err.setErr(b, finbranchResArr.get("FAT000177"));
        return false
    }
    if (!fnIsNull(f.value)) {
        err.setErr(f, finbranchResArr.get("FAT000178"));
        return false
    }
    if (!fnIsNull(i.value)) {
        err.setErr(i, finbranchResArr.get("FAT000179"));
        return false
    }
    if (!fnAlphaCheck("grdnPostalCode")) {
        g.grdnPostalCode.focus();
        return false
    }
    return true
}

function fnIsValidWitness1Details(i) {
    var f = i.wit1Name;
    var e = i.wit1AddrLine1;
    var d = i.wit1AddrLine2;
    var c = i.wit1AddrLine3;
    var a = i.wit1CityCode;
    var h = i.wit1StateCode;
    var g = i.wit1CntryCode;
    var b = i.wit1PostalCode;
    if (!fnAlphaCheck("wit1PostalCode")) {
        i.wit1PostalCode.focus();
        return false
    }
    if (!fnIsNull(f.value)) {
        if (!fnIsNull(e.value)) {
            if (fnIsNull(a.value)) {
                err.setErr(a, finbranchResArr.get("FAT000924"));
                return false
            }
            if (fnIsNull(h.value)) {
                err.setErr(h, finbranchResArr.get("FAT000924"));
                return false
            }
            if (fnIsNull(g.value)) {
                err.setErr(g, finbranchResArr.get("FAT000924"));
                return false
            }
            if (fnIsNull(b.value)) {
                err.setErr(b, finbranchResArr.get("FAT000924"));
                return false
            }
        } else {
            err.setErr(e, finbranchResArr.get("FAT004910"));
            return false
        }
        return true
    }
    if (!fnIsNull(e.value)) {
        if (fnIsNull(f.value)) {
            err.setErr(f, finbranchResArr.get("FAT004908"));
            return false
        }
        return false
    }
    return true
}

function fnIsValidWitness2Details(c) {
    var a = c.wit2Name;
    var f = c.wit2AddrLine1;
    var e = c.wit2AddrLine2;
    var d = c.wit2AddrLine3;
    var b = c.wit2CityCode;
    var h = c.wit2StateCode;
    var g = c.wit2CntryCode;
    var i = c.wit2PostalCode;
    if (!fnAlphaCheck("wit2PostalCode")) {
        c.wit2PostalCode.focus();
        return false
    }
    if (!fnIsNull(a.value)) {
        if (!fnIsNull(f.value)) {
            if (fnIsNull(b.value)) {
                err.setErr(b, finbranchResArr.get("FAT000924"));
                return false
            }
            if (fnIsNull(h.value)) {
                err.setErr(h, finbranchResArr.get("FAT000924"));
                return false
            }
            if (fnIsNull(g.value)) {
                err.setErr(g, finbranchResArr.get("FAT000924"));
                return false
            }
            if (fnIsNull(i.value)) {
                err.setErr(i, finbranchResArr.get("FAT000924"));
                return false
            }
        } else {
            err.setErr(f, finbranchResArr.get("FAT004910"));
            return false
        }
        return true
    }
    if (!fnIsNull(f.value)) {
        if (fnIsNull(a.value)) {
            err.setErr(a, finbranchResArr.get("FAT004908"));
            return false
        }
        return false
    }
    return true
}

function fnValidateForm(b) {
    objForm = document.forms[0];
    var d = objForm.dtOfBirth;
    var a = objForm.BODDate;
    var c = objForm.nomMinorFlg;
    var e = isPageEmpty(objForm);
    if (e == true) {
        objForm.IsPageEmpty.value = e;
        return true
    }
    if (locallyCheckIsPageImpty()) {
        return true
    }
    if (sMode != "I" && !fnValidateMandatoryFields()) {
        return false
    }
    convertToCaps();
    if (sMode == "V") {
        fnEnableFormDataControls(objForm);
        return true
    }
    if (!checkDOBforMinor()) {
        return false
    }
    if (e && (NewFlg == "true")) {
        if (b != window[multiRecName].nextAction && b != window[multiRecName].addNewAction) {
            return true
        }
    }
    if (e && (NewFlg == "false")) {
        disableHyperLnks(16);
        showConfirmDialog("nominationdetails");
        return true
    }
    if (templateMode != "Y" && sMode != "I") {
        if ((!e) && (!fnValidateMandatoryFields())) {
            return false
        }
    }
    if (!isNumber(objForm.nomPcnt.value)) {
        alert(finbranchResArr.get("FAT000167"));
        objForm.nomPcnt.focus();
        return false
    }
    if (valReq && !fnIsValidDateOfBirth(a, d)) {
        err.displayErr();
        return false
    }
    if (getRadioValue(c) != "Y" && !fnIsValidGuardianDetails(objForm)) {
        err.displayErr();
        return false
    }
    if (!fnIsValidWitness1Details(objForm)) {
        err.displayErr();
        return false
    }
    if (!fnIsValidWitness2Details(objForm)) {
        err.displayErr();
        return false
    }
    if (!fnAlphaCheck1("regValue")) {
        objForm.regValue.focus();
        return false
    }
    if (!fnAlphaCheck("nomPostalCode")) {
        objForm.nomPostalCode.focus();
        return false
    }
    if (b == window[multiRecName].addNewAction || b == window[multiRecName].prevPageAction || b == window[multiRecName].nextPageAction || b == window[multiRecName].prevAction || b == window[multiRecName].nextAction || b == window[multiRecName].selectAction || b == window[multiRecName].jumpToAction) {
        if ((((sMode != "A") && (sMode != "M") && (sMode != "Y") && (sTmplMode == "null")) || ("V" == sTmplMode) || ("I" == sTmplMode) || ("D" == sTmplMode)) && (!isNavigationRequired(btnObj.id, currPos, iTotalSize, null))) {
            return false
        }
    }
    disableHyperLnks(16);
    return true
}

function fnAlphaCheck1(FldObj)
{
        var validChars = /[^A-Za-z0-9._/\ ]/; //Anything other than 0-9, A- Z, . , /,\ and Underscore is  invalid.
        var obj = 'document.forms[0].'+FldObj;
        if(validChars.test((eval(obj)).value))
        {
                alert(finbranchResArr.get("FAT000485"));
                (eval(obj)).focus();
                return false;
        }
        return true;
}



function locallyCheckIsPageImpty() {
    var a = true;
    convertToCaps();
    if ((((fnIsNull(objForm.nomName.value)) && (fnIsNull(objForm.relation.value)) && (fnIsNull(objForm.nomAddrLine1.value)) && (fnIsNull(objForm.nomCityCode.value)) && (fnIsNull(objForm.nomPcnt.value))) && (!fnIsNull(objForm.regValue.value))) || (((fnIsNull(objForm.nomName.value)) && (fnIsNull(objForm.relation.value)) && (fnIsNull(objForm.nomAddrLine1.value)) && (fnIsNull(objForm.nomCityCode.value)) && (fnIsNull(objForm.nomPcnt.value))) && (fnIsNull(objForm.regValue.value)))) {
        a = true
    }
    if ((((!fnIsNull(objForm.nomName.value)) || (!fnIsNull(objForm.relation.value)) || (!fnIsNull(objForm.nomAddrLine1.value)) || (!fnIsNull(objForm.nomCityCode.value)) || (!fnIsNull(objForm.nomPcnt.value))) && (!fnIsNull(objForm.regValue.value))) || (((!fnIsNull(objForm.nomName.value)) || (!fnIsNull(objForm.relation.value)) || (!fnIsNull(objForm.nomAddrLine1.value)) || (!fnIsNull(objForm.nomCityCode.value)) || (!fnIsNull(objForm.nomPcnt.value))) && (fnIsNull(objForm.regValue.value)))) {
        a = false
    }
    objForm.IsPageEmpty.value = a;
    return a
}

function fnOnButtonClick(a) {
    objForm.actionCode.value = a.id;
    if (a.id == "Cancel") {
        objForm.actionCode.value = a.id;
        formReset(objForm);
        return
    }
    if ((a.id == "Back") || fnValidateForm()) {
        objForm.actionCode.value = a.id;
        if (templateMode != "Y") {
            if ((a.id == "Validate") && !fnValidateMandatoryFields()) {
                return false
            }
        }
        doSubmit(a.id);
        if (!locallyCheckIsPageImpty()) {
            objForm.submitform.value = a.id;
            disableButtons();
            fnEnableDescFields(objForm);
            doSubmit(a.id)
        }
    }
}

function checkDOBforMinor() {
    var d = objForm.dtOfBirth.value;
    var a = d.split("-");
    var b = parseFloat(a[0]);
    var e = parseFloat(a[1]);
    var c = parseFloat(a[2]);
    c = c + parseInt(MaxMinorAge);
    tempDate = b + "-" + e + "-" + c;
    if ((getRadioValue(objForm.nomMinorFlg) == "Y") && fnIsNull(objForm.dtOfBirth.value)) {
        alert(finbranchResArr.get("FAT004912"));
        setErrFieldFocus("dtOfBirth");
        return false
    }
    if (!fnCompareDates(tempDate, objForm.BODDate.value)) {
        checkRadio(objForm.nomMinorFlg, "Y")
    } else {
        checkRadio(objForm.nomMinorFlg, "N")
    }
    fnDisableGuradianDetails();
    return true
}

function checkGuard() {
    if (sMode == "A" || sMode == "M") {
        if ((getRadioValue(objForm.nomMinorFlg) == "Y") && (fnIsNull(objForm.grdnName.value) || fnIsNull(objForm.grdnCode.value) || fnIsNull(objForm.grdnAddrLine1.value) || fnIsNull(objForm.grdnAddrLine2.value) || fnIsNull(objForm.grdnAddrLine3.value) || fnIsNull(objForm.grdnCityCode.value) || fnIsNull(objForm.grdnStateCode.value) || fnIsNull(objForm.grdnCntryCode.value) || fnIsNull(objForm.grdnPostalCode.value))) {
            alert(finbranchResArr.get("FAT001609"));
            objForm.grdnName.focus();
            return false
        }
    }
    return true
}

function fnBack() {
    if (sTmplFuncCode == "null" || (sTmplFuncCode == "T")) {
        if ((bRefInq == "true") || (sRefSubmit == "true")) {
            formReset(objForm);
            objForm.submitform.value = "Cancel";
            doSubmit("Cancel")
        } else {
            if (!fnCancelCheck(sMode)) {
                formReset(objForm);
                objForm.submitform.value = "Cancel";
                doSubmit("Cancel")
            } else {
                objForm.submitform.value = "Back";
                objForm.actionCode.value = "Cancel";
                doSubmit("Back")
            }
        }
    } else {
        if (sTmplFuncCode == "I") {
            formReset(objForm);
            objForm.submitform.value = "Back";
            objForm.actionCode.value = "Cancel";
            doSubmit("Back")
        } else {
            if (bShowBack == "true") {
                objForm.submitform.value = "Back";
                objForm.actionCode.value = "Cancel";
                if (!fnShowCancelDialog(sMode)) {
                    return false
                }
                formReset(objForm)
            }
        }
    }
}

function fnCancelCheck(c) {
    var b = "A";
    var e = "C";
    var d = "M";
    var a = "T";
    if (c == b || c == e || c == d || c == a) {
        if (confirm(finbranchResArr.get("FAT000925")) != true) {
            return false
        }
    }
    return true
}

function locShowHelpFile() {
    var a;
    if (parentGroup == "sbacop") {
        a = "nomination_details_help1.htm"
    } else {
        if (parentGroup == "hacm") {
            a = "nomination_details_help2.htm"
        } else {
            if (parentGroup == "tdacop") {
                a = "nomination_details_help3.htm"
            } else {
                if (parentGroup == "hacmtd") {
                    a = "nomination_details_help4.htm"
                }
            }
        }
    }
    a = "nomination_details_help1.htm";
    showHelpFile(a)
}

function fnDisableGuradianDetails() {
    objForm = document.forms[0];
    if ((getRadioValue(objForm.nomMinorFlg) != "Y")) {
        disableFields("grdnName", "grdnCode", "grdnAddrLine1", "grdnCityCode", "grdnCityName", "grdnAddrLine2", "grdnAddrLine3", "grdnStateCode", "grdnPostalCode", "grdnStateName", "grdnCntryCode", "grdnCntryName", "prefGrdnName");
        hideImage("sLnk6");
        hideImage("sLnk7");
        hideImage("sLnk8");
        objForm.grdnName.value = "";
        objForm.grdnCode.value = "";
        objForm.grdnAddrLine1.value = "";
        objForm.grdnCityCode.value = "";
        objForm.grdnCityName.value = "";
        objForm.grdnAddrLine2.value = "";
        objForm.grdnAddrLine3.value = "";
        objForm.grdnStateCode.value = "";
        objForm.grdnPostalCode.value = "";
        objForm.grdnStateName.value = "";
        objForm.grdnCntryCode.value = "";
        objForm.grdnCntryName.value = "";
        objForm.prefGrdnName.value = ""
    } else {
        enableFields("grdnName", "grdnCode", "grdnAddrLine1", "grdnCityCode", "grdnAddrLine2", "grdnAddrLine3", "grdnStateCode", "grdnPostalCode", "grdnCntryCode", "prefGrdnName");
        objForm.grdnName.focus();
        showImage("sLnk6");
        showImage("sLnk7");
        showImage("sLnk8")
    }
}

function fnShowCustId() {
    showCifId(objForm.cifId, "ctrl", "F");
    fnGetCustInfo(objForm.cifId)
}

function fnGetCustInfo(a) {
    if (fnIsNull(a.value)) {
        enableFields("dtOfBirth", "nomMinorFlg");
        showImage("sLnk5");
        objForm.nomName.value = "";
        objForm.cifId.value = "";
        objForm.nomAddrLine1.value = "";
        objForm.nomAddrLine2.value = "";
        objForm.nomAddrLine3.value = "";
        objForm.nomCityCode.value = "";
        objForm.nomStateCode.value = "";
        objForm.nomCntryCode.value = "";
        objForm.nomPostalCode.value = "";
        objForm.nomCityName.value = "";
        objForm.nomStateName.value = "";
        objForm.nomCntryName.value = "";
        fnClearDateFields(objForm.dtOfBirth);
        return
    }
    objForm.submitform.value = "GetCustInfo";
    objForm.submit()
}

function setDefault() {
    objForm = document.forms[0];
    initFocusHandler();
    setValue("grdnCode", grdnCode);
    fnPopulateControlValues();
    checkRadio(objForm.nomMinorFlg, nomMinorFlg);
    fnSetCheckboxCtrl(objForm);
    if (((sMode == "Y") && regValue != "") || (sReferralMode == "I") || (sReferralMode == "S")) {
        objForm.regValue.disabled = true
    }
    if (((sMode == "M") && regValue != "") || (sReferralMode == "I") || (sReferralMode == "S")) {
        objForm.regValue.disabled = true
    }
    if (lShowLImage == "true") {
        disableHyperLnks(Number(16))
    }
    if (("I" == sTmplMode) || ("D" == sTmplMode) || ("V" == sTmplMode)) {
        fnDisableFormDataControls("I", objForm, 16)
    } else {
        if (bRefInq == "true") {
            fnDisableFormDataControls("I", objForm, 16)
        } else {
            if (sRefSubmit == "true") {
                fnDisableFormDataControls("V", objForm, 16)
            } else {
                fnDisableFormControls(sMode, objForm, 16)
            }
        }
    }
    if ((templateFuncCode == "V") || (templateFuncCode == "X") || (templateFuncCode == "D") || (templateFuncCode == "U") || (templateFuncCode == "I")) {
        fnDisableFormControls(templateFuncCode, objForm, 100)
    }
    if ((sMode == "V" && bRefInq == "true")) {
        objForm.Back.focus()
    } else {
        if ((sMode == "V") || (sMode == "X")) {
            objForm.Submit.focus()
        } else {
            if (sMode == "I") {
                objForm.Back.focus()
            } else {
                objForm.cifId.focus()
            }
        }
    }
    if (!fnIsNull(objForm.cifId.value)) {
        disableFields("dtOfBirth", "nomMinorFlg");
        hideImage("sLnk5")
    }
    if ((getRadioValue(objForm.nomMinorFlg) != "Y")) {
        disableFields("grdnName", "grdnCode", "grdnAddrLine1", "grdnCityCode", "grdnCityName", "grdnAddrLine2", "grdnAddrLine3", "grdnStateCode", "grdnPostalCode", "grdnStateName", "grdnCntryCode", "grdnCntryName", "prefGrdnName");
        hideImage("sLnk6");
        hideImage("sLnk7");
        hideImage("sLnk8");
        objForm.grdnName.value = "";
        objForm.grdnCode.value = "";
        objForm.grdnAddrLine1.value = "";
        objForm.grdnCityCode.value = "";
        objForm.grdnCityName.value = "";
        objForm.grdnAddrLine2.value = "";
        objForm.grdnAddrLine3.value = "";
        objForm.grdnStateCode.value = "";
        objForm.grdnPostalCode.value = "";
        objForm.grdnStateName.value = "";
        objForm.grdnCntryCode.value = "";
        objForm.grdnCntryName.value = "";
        objForm.prefGrdnName.value = ""
    }
    checkDOBforMinor()
};
