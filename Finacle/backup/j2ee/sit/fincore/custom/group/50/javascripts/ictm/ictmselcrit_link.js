var err = new ErrObject();
var objForm;
this.helpfile = "ictmselcrit";

function fnOnButtonClick(c) {
    var a = true;
    if (c.id == "Back") {
        var b = "M";
        fnShowCancelDialog(b);
        objForm.submitform.value = c.id;
        return true
    }
    if ((!validateTypes(objForm)) || (!fnValidateMandatoryFields()) || (!validateSelCrit())) {
        return false
    }
    objForm.submitform.value = c.id;
    convertToCaps();
    disableButtons();
    disableHyperLnks(4);
    objForm.submit()
}

function fnOnLoad() {
    objForm = document.forms[0];
    objForm.cInstNum.focus();
    fnPopulateControlValues();
    if (funcCode == "M" && cVerifyFlg == "") {
        cVerifyFlg = "N"
    }
    if (funcCode == "I") {
        objForm.validationRunFlg.value = validationRunFlg;
        if (ctsEnabledFlg == "Y") {
            objForm.ctsValStatFlg.value = ctsValStatFlg
        }
    }
    checkRadio(objForm.cCarveFlg, cCarveFlg);
    checkRadio(objForm.cVerifyFlg, cVerifyFlg);
    if (cLstFlg == "Y") {
        objForm.lstRcd.value = "1"
    } else {
        objForm.lstRcd.value = "3"
    }
    if (cRcdFlg == "Y") {
        objForm.lstRcd.value = "2"
    } else {
        objForm.lstRcd.value = "3"
    }
    if (cSelectAllFlg == "") {
        cSelectAllFlg = "Y"
    }
    objForm.cSelectAllFlg.value = cSelectAllFlg
}

function validateSelCrit() {
    if (getValInFloat(objForm.cFrmZnSrlNum.value) > getValInFloat(objForm.cToZnSrlNum.value)) {
        err.setErr(objForm.cToZnSrlNum, finbranchResArr.get("FAT000429"));
        err.displayErr();
        return false
    }
    return true
}
fkmResource = {
    "FORM-ACCEPT|FORM": "onFormAccept",
    "FORM-CANCEL|FORM": "onBack"
};

function onFormAccept() {
    var a = document.forms[0];
    if ((a.Accept != undefined) && (a.Accept != null)) {
        a.Accept.click()
    }
}

function onBack() {
    var a = document.forms[0];
    if ((a.Back != undefined) && (a.Back != null)) {
        a.Back.click()
    }
}

function rejectTypeChoice() {
    if (objForm.cRejInd.value != "") {
        if (ctsEnabledFlg == "Y") {
            objForm.ctsValStatFlg.disabled = true
        }
        objForm.validationRunFlg.disabled = true
    } else {
        if (ctsEnabledFlg == "Y") {
            objForm.ctsValStatFlg.disabled = false
        }
        objForm.validationRunFlg.disabled = false
    }
};

function showCustomRejReasonList(obj,objDesc,inPreceedence) {
	
	var reasonObj;
	var sPreceedenceFlg = inPreceedence;
	var desc = "NULL";
	var sDesc = ( (objDesc == null) || (objDesc == undefined) ) ? "" : objDesc.id;

	if(obj != null)
	{
			reasonObj = obj.id;
	}

	var inputNameValues = "";
	var outputNameValues = "oldRejCode|newRejCode|rejCodeDesc";
	var scriptName = "getCustomRejectCodes.scr";
	var pageTitle = "Rejection Reason List";
	var colHeader = "Rejection Code|New Rejection Code|Rejection Description";
	var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,pageTitle,colHeader,"1",false);

	if ("Microsoft Internet Explorer" == browser_name)
        {
                if (retVal != null && retVal != undefined )
                {
                        //Array for taking the values after splitting the value with "|".
                        var liarrBufArray = retVal.split("|");
                        obj.value = liarrBufArray[0];
                        if( (objDesc != null) && (objDesc != undefined) )
                        objDesc.value = liarrBufArray[2];
                }
		}

}