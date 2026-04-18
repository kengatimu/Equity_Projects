
var objForm = "";
this.helpfile = "ictmrej";
var TOTAL_LEN = 2;

function fnOnLoad() {
    objForm = document.forms[0];
    initFocusHandler();
    fnPopulateControlValues();
    checkRadio(objForm.drawnOnUsFlg, drawnOnUsFlg);
    fnSetCheckboxCtrl(objForm);
    fnDisableFormDataControls(funcCode, objForm, 12);
    if (rejType == "E") {
        if (fnIsNull(extnNoOfDays)) {
            objForm.extnNoOfDays.value = 1
        }
        objForm.extnCode.focus();
        disableFields("rejCode1", "rejCode2", "rejCode3", "rejCode4", "rejCode5");
        hideImage("sLnk1");
        hideImage("sLnk2");
        hideImage("sLnk3");
        hideImage("sLnk4");
        hideImage("sLnk5")
    } else {
        objForm.extnNoOfDays.value = "";
        objForm.extnCode.value = "";
        objForm.rejCode1.focus();
        hideImage("sLnk11");
        disableFields("extnCode", "extnNoOfDays")
    }
    if (vStatus == "B") {
        hideImage("sLnk6");
        hideImage("sLnk7");
        hideImage("sLnk9");
        hideImage("sLnk10")
    }
}

function showExtnReasonList() {
    if (!window.showModalDialog) {
        callBackFn = "chkExtnCodeLength"
    }
    showDynSearcher("EXTCODE", "", ":extnCode=ref_code");
    if (window.showModalDialog) {
        chkExtnCodeLength()
    }
}

function fnOnButtonClick(a) {
    if (a.id == "Accept" && rejType == "E") {
        if (fnIsNull(objForm.extnCode.value)) {
            alert(finbranchResource.FAT000200);
            objForm.extnCode.focus();
            return false
        }
    }
    if (a.id == "Back") {
        fnShowCancelDialog(funcCode);
        objForm.submitform.value = a.id;
        return true
    }
    if ((a.id != "Back") && (fnIsNull(objForm.rejCode1.value)) && rejType != "E") {
        alert(finbranchResArr.get("FAT000200"));
        objForm.rejCode1.focus();
        return false
    }
    if (vStatus != "B") {
        if (!fnValidateMandatoryFields()) {
            return false
        }
    }
    if (!validateTypes(objForm)) {
        return false
    }
    convertToCaps();
    objForm.submitform.value = a.id;
    objForm.submit()
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

function chkExtnCodeLength() {
    var a = document.forms[0];
    if (a.extnCode.value.length > TOTAL_LEN) {
        alert(finbranchResArr.get("FAT003345"));
        a.extnCode.focus();
        return false
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

