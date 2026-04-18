function cietxn_det7_post_ONLOAD()
{
	var ObjForm = document.forms[0];
	if(funcCode == "A"){
                ObjForm.targetEntity.focus();
                hideImage("rateCodeImg");
		hideImage("treaRefNumImg");
                fnDisableAmtFields();
                fnOnloadDisableFields();
                var acctCrncy = ObjForm.drAcctNumCcy.value;
                var refCrncy = ObjForm.refCrncy.value;

		ObjForm.rateCode.disabled = true;
		ObjForm.rate.disabled = true;
		ObjForm.treaRefNum.disabled = true;
		ObjForm.treaRate.disabled = true;
		hideImage("creditEntity");
       
	}
	return true;
}

function showRateWrkClss(){

	    var inputNameValues = "";
        var outputNames = "";
        var scriptName = "cietxnRate.scr";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
		var ret = retVal.split("|");

		if(ret[0] == "err")
		{	
			var ObjForm = document.forms[0];
			ObjForm.treaRate.disabled = true;
			ObjForm.rate.disabled = true;
		}
		else
		{
			var ObjForm = document.forms[0];
			ObjForm.treaRate.disabled = false;
			ObjForm.rate.disabled = false;
		}

}

function fnOnloadDisableFields(){
        var ObjForm = document.forms[0];
        ObjForm.targetEntityDesc.disabled = true;
        ObjForm.drAcctNumEntityId.disabled = true;
        ObjForm.drAcctNumSolId.disabled = true;
        ObjForm.drAcctNumCcy.disabled = true;
        ObjForm.drAcctName.disabled = true;
        ObjForm.nostroAcct.disabled = true;
	ObjForm.nostroAcctName.disabled = true;
}

function fnValidateData(){
	var ObjForm = document.forms[0];
	var targetEntity = ObjForm.targetEntity.value;
	var drAcctNum = ObjForm.drAcctNum.value;
	var drAcctNumEntityId = ObjForm.drAcctNumEntityId.value;
	var crAcctNum = ObjForm.crAcctNum.value;
	var acctCrncy = ObjForm.drAcctNumCcy.value.toUpperCase();
	var refCrncy = ObjForm.refCrncy.value.toUpperCase();
	var refAmt = ObjForm.refAmt.value;
	var rateCode = ObjForm.rateCode.value;
	var rate = ObjForm.rate.value;
	var refNo = ObjForm.refNo.value;
        var tranParticularsCode = ObjForm.tranParticularsCode.value;
        var tranParticular = ObjForm.tranParticular.value;
        var tranRmks = ObjForm.tranRmks.value;
        var tranRmks2 = ObjForm.tranRmks2.value;

	var instrumentType = ObjForm.instrumentType.value;
	var instrumentAlpha = ObjForm.instrumentAlpha.value;
	var instrumentNum = ObjForm.instrumentNum.value;
	var instrumentDate = ObjForm.instrumentDate.value;	
	
	if(fnIsNull(targetEntity))
        {
                alert("Enter the Debit A/c. Entity ID");
                ObjForm.targetEntity.focus();
                return false;
        }

	if(fnIsNull(drAcctNum))
        {
                alert("Enter the Debit Account ID");
                ObjForm.drAcctNum.focus();
                return false;
        }

	if(fnIsNull(crAcctNum))
        {
                alert("Enter the Credit Account ID");
                ObjForm.crAcctNum.focus();
                return false;
        }
	
	if(fnIsNull(refCrncy))
        {
                alert("Enter the Ref. CCY");
                ObjForm.refCrncy.focus();
                return false;
        }

	if(fnIsNull(refAmt))
        {
                alert("Enter the Ref Amt");
                ObjForm.refAmt.focus();
                return false;
        }
	
	if(acctCrncy != refCrncy){
		if(fnIsNull(rateCode))
		{
			alert("Enter the Rate Code");
			ObjForm.rateCode.focus();
                	return false;
        	}
	}

	if(fnIsNull(rate))
        {
                alert("Enter the Rate");
                ObjForm.rate.focus();
                return false;
        }		

	if(fnIsNull(refNo))
        {
                //alert("Enter the Ref. No.");
                //ObjForm.refNo.focus();
                //return false;
        }

        if(fnIsNull(tranParticularsCode))
        {
                //alert("Enter the Transaction Particulars Code");
                //ObjForm.tranParticularsCode.focus();
                //return false;
        }

        if(fnIsNull(tranParticular))
        {
                //alert("Enter the Transaction Particulars");
                //ObjForm.tranParticular.focus();
                //return false;
        }

        if(fnIsNull(tranRmks))
        {
                //alert("Enter the Remarks1");
                //ObjForm.tranRmks.focus();
                //return false;
        }

        if(fnIsNull(tranRmks2))
        {
                //alert("Enter the Remarks2");
                //ObjForm.tranRmks2.focus();
                //return false;
        }

	if(!fnIsNull(instrumentNum)){
		if(fnIsNull(instrumentType))
		{
			alert("Enter the Instrument Type");
			ObjForm.instrumentType.focus();
			return false;
		}
	
		if(fnIsNull(instrumentDate))
                {
                        alert("Enter the Instrument Date");
                        ObjForm.instrumentDate_ui.focus();
                        return false;
                }
	}

	if (!fnCheckMandatoryFields())
	{
		return false;
	}
	return true;
}

function getAcctIdList() {
	var ObjForm = document.forms[0];
        var targetEntity = ObjForm.targetEntity.value;
        if(fnIsNull(targetEntity)){
                alert("Enter the Debit A/c. Entity ID to search other entity accounts");
                ObjForm.targetEntity.focus();
        }else{
                cust_showAccountIdList(ObjForm.drAcctNum,null,null,'F');
        }

        var drAcctNum = ObjForm.drAcctNum.value;
        if(!fnIsNull(drAcctNum)){
                fnGetAcctDetails();
        }
}

function showEntityList(){
        var inputNameValues = "targetEntity| "
        var outputNameValues = "targetEntity|targetEntityDesc|targetEntityHomeCcy";
        var scriptName = "cietxndp019.scr";
        var listHeading = "Entity List";
        var colHeader = "Entity ID|Entity Description|Home Currency Code";
        var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
	var ObjForm = document.forms[0];
        var targetEntity = ObjForm.targetEntity.value;
        if(!fnIsNull(targetEntity)){
                ObjForm.drAcctNum.focus();
        }
}

function fnGetEntityDesc(){
        var ObjForm = document.forms[0];
        var targetEntity = ObjForm.targetEntity.value;

        if(fnIsNull(targetEntity)){
                ObjForm.targetEntityDesc.value = "";
        }else{
                var inputNameValues = "targetEntity|"+targetEntity;
                var outputNames = "errorFlg|errorMsg|targetEntity|targetEntityDesc";
                var scriptName = "cietxndp018.scr"
                var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
                var token = retVal.split("|");
                if(token != undefined){
                        var errorFlg = token[1];
                        var errorMsg = token[3];
                        var targetEntity = token[5];
                        var targetEntityDesc = token[7];

                        if(errorFlg == "Y"){
                                alert(errorMsg);
                                setFieldFocus(ObjForm.targetEntity);
                                return false;
                        }else{
                                ObjForm.targetEntity.value = targetEntity;
                                ObjForm.targetEntityDesc.value = targetEntityDesc;
                                ObjForm.drAcctNum.focus();
                        }
                }
        }
        return true;

}

function fnGetDrAcctDetails(){
	var ObjForm = document.forms[0];
	var drAcctNum = ObjForm.drAcctNum.value;

        if(!fnIsNull(drAcctNum)){
                var retVal = fnValidateAcctNumEntityId(drAcctNum,'drAcctNum');
                if(retVal == false){
                        return false;
                }
        }

        if(!fnIsNull(drAcctNum)){
                fnGetAcctDetails();
        }else{
		fnClearAcctDetails();
	}
	ObjForm.refAmt.value = "";
	fnClearRateFields();
	fnClearAmtFields();
	return true;
}

function fnGetAcctDetails(){
	var ObjForm = document.forms[0];
	fnEnableAcctDetails();
	var drAcctNum = ObjForm.drAcctNum.value;
	var inputNameValues = "acctNum|"+drAcctNum;
	var outputNames = "errorFlg|errorMsg|acctNumEntityId|acctNumSolId|acctNumCcy|acctName|acctNum|cifIdForSig";
	var scriptName = "cietxndp011.scr"
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	var token = retVal.split("|");
	var cifIdForSig = token[15];
	if(token != undefined){
		var errorFlg = token[1];
		var errorMsg = token[3];
		var drAcctNumEntityId = token[5];
		var drAcctNumSolId = token[7];
		var drAcctNumCcy = token[9];
		var drAcctName = token[11];
		var drAcctNum = token[13];
		var cifIdForSig = token[15];
		if(errorFlg == "Y"){
			alert(errorMsg);
			fnClearAcctDetails();
			setFieldFocus(ObjForm.drAcctNum);
			return false;
			
		}else{
			if(fnIsNull(ObjForm.targetEntity.value)){
                                ObjForm.targetEntity.value = drAcctNumEntityId;
                                fnGetEntityDesc();
                        }
                        ObjForm.drAcctNumEntityId.value = drAcctNumEntityId;
                        ObjForm.drAcctNumSolId.value = drAcctNumSolId;
                        ObjForm.drAcctNumCcy.value = drAcctNumCcy;
                        ObjForm.drAcctName.value = drAcctName;
                        ObjForm.drAcctNum.value = drAcctNum;
                        ObjForm.cifIdForSig.value = cifIdForSig;
                        fnDisableAcctDetails();
			//Added for biometric validation - Dileep
			doLocalBioMetricVal();
			document.forms[0].varbiotest.value = getSValue("bioStatus");
			//alert("Bio result : " + document.forms[0].varbiotest.value);
		}
	}
	return true;
}

function fnEnableAcctDetails(){
        var ObjForm = document.forms[0];
        ObjForm.drAcctNumEntityId.disabled = false;
        ObjForm.drAcctNumSolId.disabled = false;
        ObjForm.drAcctNumCcy.disabled = false;
        ObjForm.drAcctName.disabled = false;
}

function fnEnableAcctDetails2(){
        var ObjForm = document.forms[0];
        ObjForm.crAcctNumEntityId.disabled = false;
        ObjForm.crAcctNumSolId.disabled = false;
        ObjForm.crAcctNumCcy.disabled = false;
        ObjForm.crAcctName.disabled = false;
}

function fnDisableAcctDetails(){
	var ObjForm = document.forms[0];
	ObjForm.drAcctNumEntityId.disabled = true;
	ObjForm.drAcctNumSolId.disabled = true;
	ObjForm.drAcctNumCcy.disabled = true;
	ObjForm.drAcctName.disabled = true;
}

function fnDisableAcctDetails2(){
        var ObjForm = document.forms[0];
        ObjForm.crAcctNumEntityId.disabled = true;
        ObjForm.crAcctNumSolId.disabled = true;
        ObjForm.crAcctNumCcy.disabled = true;
        ObjForm.crAcctName.disabled = true;
}

function fnClearAcctDetails(){
	var ObjForm = document.forms[0];
	ObjForm.drAcctNumEntityId.value = "";
	ObjForm.drAcctNumSolId.value = "";
	ObjForm.drAcctNumCcy.value = "";
	ObjForm.drAcctName.value = "";
	ObjForm.cifIdForSig.value = "";
	ObjForm.chargeEventId.value = "";
	ObjForm.chargeAmt.value = "";
	ObjForm.chargeAmtCcy.value = "";
	ObjForm.nostroAcct.value = "";
	ObjForm.nostroAcctName.value = "";
	ObjForm.vostroAcct.value = "";
	fnClearAmtFields();
	fnClearRateFields();
}

function fnClearAcctDetails2(){
        var ObjForm = document.forms[0];
        ObjForm.crAcctNumEntityId.value = "";
        ObjForm.crAcctNumSolId.value = "";
        ObjForm.crAcctNumCcy.value = "";
        ObjForm.crAcctName.value = "";
        ObjForm.cifIdForSig.value = "";
        ObjForm.chargeEventId.value = "";
        ObjForm.chargeAmt.value = "";
        ObjForm.chargeAmtCcy.value = "";
        ObjForm.nostroAcct.value = "";
        ObjForm.nostroAcctName.value = "";
        ObjForm.vostroAcct.value = "";
        fnClearAmtFields();
        fnClearRateFields();
}

function fnDisableAmtFields(){
	var ObjForm = document.forms[0];
	ObjForm.tranAmt.disabled = true;
	ObjForm.tranAmtCcy.disabled = true;
	ObjForm.chargeAmt.disabled = true;
	ObjForm.chargeAmtCcy.disabled = true;
}
function getRefCrncyList(){
	var ObjForm = document.forms[0];
	var oldValue = ObjForm.refCrncy.value;
	var retVal = popModalWindow("../arjspmorph/"+applangcode+"/get_currency.jsp?wReturn=refCrncy&Currency="+oldValue,"CurrencyList");
	if (retVal != null) {
		var j = retVal.split("|");
		ObjForm.refCrncy.value = j[0];
		ObjForm.refAmt.focus();
		fnComputeTranAmt(ObjForm.refCrncy);
	}
}

function getRateCodeList() {
	var frm = document.forms[0];
        rateCode = frm.rateCode.value;
        var retVal = popModalWindow("../arjspmorph/"+applangcode+"/rate_codes.jsp?wReturn=document.forms[0].rateCode&DebitCrncy="+frm.refCrncy.value+"&CreditCrncy="+frm.drAcctNumCcy.value,"RateCodes");
        if (retVal != null)
        {
        	frm.rateCode.value = retVal;
		fnComputeTranAmt(frm.rateCode);
	}
}

function fnValidateRefCcy(){
        var ObjForm = document.forms[0];
        var refCrncy = ObjForm.refCrncy.value;
        var inputNameValues = "refCrncy|"+refCrncy;
        var outputNames = "errorFlg|errorMsg";
        var scriptName = "cietxndp013.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
        if(token != undefined){
                var errorFlg = token[1];
                var errorMsg = token[3];

                if(errorFlg == "Y"){
                        alert(errorMsg);
                        fnClearAmtFields();
			fnClearRateFields();
                        setFieldFocus(ObjForm.refCrncy);
                        return false;
                }
        }
        return true;
}

function fnClearRateFields(){
	var ObjForm = document.forms[0];
	ObjForm.rateCode.value = "";
	ObjForm.rate.value = "";
	return true;
}

function fnClearAmtFields(){
	var ObjForm = document.forms[0];
	ObjForm.tranAmt.value = "";
	ObjForm.tranAmtCcy.value = "";
	return true;
}

function fnFormatAmountField(obj){
	var p1 = removeCommas(obj.value);
	var ObjForm = document.forms[0];
	var amountFormat = "Million";
        var crncyCode = "";

	crncyCode = ObjForm.drAcctNumCcy.value;
	if(obj.id == "refAmt"){
                if(fnIsNull(p1)){
                        fnClearAmtFields();
                        fnClearRateFields();
                        return false;
                }
                crncyCode = ObjForm.refCrncy.value;
        }

        var retValue = ""
        retValue = newformatAmt(amountFormat,obj,crncyCode,'N');
        if(retValue == false){
                return false;
        }

        p1 = removeCommas(obj.value);
        if(parseFloat(p1) <= parseFloat("0")){
                alert("Amount should be greater than zero");
                fnClearAmtFields();
                fnClearRateFields();
                setFieldFocus(ObjForm.refAmt);
                return false;
        }

	if(fnIsNull(ObjForm.refCrncy.value)){
		ObjForm.refCrncy.focus();
		return false;
	}

	return true;
}

function fnClearAmtRateFields(){
        var ObjForm = document.forms[0];
        ObjForm.refCrncy.value = "";
        ObjForm.refAmt.value = "";
        ObjForm.rateCode.value = "";
        ObjForm.rate.value = "";
        ObjForm.tranAmt.value = "";
        ObjForm.tranAmtCcy.value = "";

}

function fnComputeTranAmt(obj){
        var ObjForm = document.forms[0];
	var drAcctNum = ObjForm.drAcctNum.value;
	var drAcctNumEntityId = ObjForm.drAcctNumEntityId.value;
	var crAcctNum = ObjForm.crAcctNum.value;
        var crAcctNumEntityId = ObjForm.crAcctNumEntityId.value;
        var drAcctCrncy = ObjForm.drAcctNumCcy.value.toUpperCase();
	var crAcctCrncy = ObjForm.crAcctNumCcy.value.toUpperCase();
        var refCrncy = ObjForm.refCrncy.value.toUpperCase();
        var refAmtTmp = ObjForm.refAmt.value;
        var refAmt = removeCommas(refAmtTmp);
        var rateCode = ObjForm.rateCode.value.toUpperCase();
        var rateTmp = ObjForm.rate.value;
        var rate = removeCommas(rateTmp);
	var treaRateTmp = ObjForm.treaRate.value;
        var treaRate = removeCommas(treaRateTmp);

	hideImage("rateCodeImg");
	hideImage("treaRefNumImg");
	ObjForm.rate.disabled = true;
	ObjForm.rateCode.disabled = true;
	ObjForm.treaRefNum.disabled = true;
	ObjForm.treaRate.disabled = true;

        var retVal = "";

	if(fnIsNull(drAcctNum)){
		alert("Please Enter Debit Account ID");
		ObjForm.drAcctNum.focus();
		return false;
	}

	if(fnIsNull(crAcctNum)){
                alert("Please Enter Credit Account ID");
                ObjForm.crAcctNum.focus();
                return false;
        }

        if(obj.id == "refCrncy"){

                if(fnIsNull(refCrncy)){
                        fnClearAmtRateFields();
                        hideImage("rateCodeImg");
			hideImage("treaRefNumImg");
                        ObjForm.rate.disabled = true;
                        ObjForm.rateCode.disabled = true;
			ObjForm.treaRefNum.disabled = true;
                        ObjForm.treaRate.disabled = true;
			ObjForm.chargeEventId.value = "";
                        ObjForm.chargeAmt.value = "";
                        ObjForm.chargeAmtCcy.value = "";
                        return false;
                }

                if ((retVal =  fnValidateRefCcy()) == false) {
                        ObjForm.refAmt.value = "";
                        ObjForm.rateCode.value = "";
                        ObjForm.rate.value = "";
			ObjForm.treaRefNum.value = "";
                        ObjForm.treaRate.value = "";
                        ObjForm.tranAmt.value = "";
                        ObjForm.tranAmtCcy.value = "";
			ObjForm.chargeEventId.value = "";
                        ObjForm.chargeAmt.value = "";
                        ObjForm.chargeAmtCcy.value = "";
                        hideImage("rateCodeImg");
			hideImage("treaRefNumImg");
                        return false;
                }else{
                        ObjForm.rateCode.value = "";
                        ObjForm.rate.value = "";
			ObjForm.treaRefNum.value = "";
                        ObjForm.treaRate.value = "";
                        ObjForm.tranAmt.value = "";
                        ObjForm.tranAmtCcy.value = "";
			ObjForm.chargeEventId.value = "";
                        ObjForm.chargeAmt.value = "";
                        ObjForm.chargeAmtCcy.value = "";
                }

        }

        if(obj.id == "rateCode"){
                rate = "";
        }

        var inputNameValues = "drAcctNum|"+drAcctNum+"|drAcctNumEntityId|"+drAcctNumEntityId+"|refCrncy|"+refCrncy+"|drAcctCrncy|"+drAcctCrncy+"|crAcctCrncy|"+crAcctCrncy+"|refAmt|"+refAmt;
        var outputNames = "errorFlg|errorMsg|rateCode|rate|treaRate|tranAmt|tranAmtCcy|chargeAmt|chargeAmtCcy|chargeEventId|nostroAcct|vostroAcct|nostroAcctName";
        var scriptName = "cietxndp066.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
        if(token != undefined){
                var errorFlg = token[1];
                var errorMsg = token[3];
                var rateCode = token[5];
		var rate = token[7];
		var treaRate = token[9];
                var tranAmt = token[11];
                var tranAmtCcy = token[13];
		var chargeAmt = token[15];
		var chargeAmtCcy = token[17];
		var chargeEventId = token[19];
		var nostroAcct = token[21];
		var vostroAcct = token[23];
		var nostroAcctName = token[25];

                if(errorFlg == "Y"){
                        alert(errorMsg);
                        ObjForm.tranAmt.value = "";
                        ObjForm.tranAmtCcy.value = "";
                        ObjForm.rate.value = "";
			ObjForm.treaRate.value = "";
			ObjForm.chargeEventId.value = "";
                        ObjForm.chargeAmt.value = "";
                        ObjForm.chargeAmtCcy.value = "";	
			ObjForm.nostroAcct.value = "";
			ObjForm.nostroAcctName.value = "";
			ObjForm.vostroAcct.value = "";
                        setFieldFocus(ObjForm.refCrncy);
                        return false;

                }else{
                        ObjForm.rateCode.value = rateCode;
			ObjForm.rate.value = rate;
			ObjForm.treaRate.value = treaRate;
                        ObjForm.tranAmt.value = tranAmt;
                        ObjForm.tranAmtCcy.value = tranAmtCcy;
			ObjForm.chargeAmt.value = chargeAmt;
			ObjForm.chargeAmtCcy.value = chargeAmtCcy;
			ObjForm.chargeEventId.value = chargeEventId;
			ObjForm.nostroAcct.value = nostroAcct;
			ObjForm.vostroAcct.value = vostroAcct;
			ObjForm.nostroAcctName.value = nostroAcctName;
                        newformatAmt("Million",ObjForm.tranAmt,ObjForm.tranAmtCcy.value,'N');
			newformatAmt("Million",ObjForm.chargeAmt,ObjForm.chargeAmtCcy.value,'N');

			if(!fnIsNull(drAcctCrncy)){
				if(drAcctCrncy != refCrncy){
					showImage("treaRefNumImg");
				}
			}
                }
        }

        return;
}

function fnGetChargeAmt(){
        var ObjForm = document.forms[0];
        return true;
}

function fnShowRefCodeTranCode(){
	var ObjForm = document.forms[0];
	showRefCode(ObjForm.tranParticularsCode,'DD','N','F');	
	var tranParticularsCode = ObjForm.tranParticularsCode.value;
	if(!fnIsNull(tranParticularsCode)){
		ObjForm.tranParticular.focus();
	}else{
		ObjForm.tranParticularsCode.focus();	
	}
}

function fnExplodeBalanceDetails(obj1,obj2){
    var ObjForm = document.forms[0];
    var entityId = obj1.value;
    var acctId = obj2.value;
    var sUrl = "";
    var urlData = "";
    if(!fnIsNull(acctId)){
        var inputNameValues = "acctId|"+acctId+"|entityId|"+entityId;
        var outputNames = "errorFlg|errorMsg|acctId|solId|crncyCode|acctName|ledgerBal|availableBal|effAvailableBal|freezeStatus|freezeReasonCode|acctClosed|shadowBal|acctStatus|restrictAccess";
        var scriptName = "cietxndp009.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
        if(token != undefined){
		var iIndex = 1;
                var errorFlg = token[iIndex];
                var errorMsg = token[iIndex+=2];
		var acctId = token[iIndex+=2];
                var solId = token[iIndex+=2];
                var crncyCode = token[iIndex+=2];
                var acctName = token[iIndex+=2];
                var ledgerBal = token[iIndex+=2];
		var availableBal = token[iIndex+=2];
		var effAvailableBal = token[iIndex+=2];
		var freezeStatus = token[iIndex+=2];
		var freezeReasonCode = token[iIndex+=2];
		var acctClosed = token[iIndex+=2];
		var shadowBal = token[iIndex+=2];
		var acctStatus = token[iIndex+=2];
		var restrictAccess = token[iIndex+=2];

                if(errorFlg == "Y"){
                        alert(errorMsg);
                        setFieldFocus(obj);
                }else{
		    if(restrictAccess == "Y"){
                                ledgerBal = "**********";
                                availableBal = "**********";
                                effAvailableBal = "**********";
                                shadowBal = "**********";
                    }else{
			var amountFormat = "Million";
                        var crDrIndicator = "";
                        var prec = getPrec(crncyCode);

                        // Ledger Balance
                        var tmpAmt = parseFloat(ledgerBal);
                        if(tmpAmt < 0){
                                tmpAmt = tmpAmt * (-1);
                                crDrIndicator = "Dr";
                        }else{
                                crDrIndicator = "Cr";
                        }
                        tmpAmt = tmpAmt.toFixed(prec);
                        ObjForm.tmpAmtField.value = tmpAmt;
                        newformatAmt(amountFormat,ObjForm.tmpAmtField,crncyCode,'N');
                        ledgerBal = ObjForm.tmpAmtField.value + " " + crDrIndicator;

                        // Available Balance
                        var tmpAmt = parseFloat(availableBal);
                        if(tmpAmt < 0){
                                tmpAmt = tmpAmt * (-1);
                                crDrIndicator = "Dr";
                        }else{
                                crDrIndicator = "Cr";
                        }
                        tmpAmt = tmpAmt.toFixed(prec);
                        ObjForm.tmpAmtField.value = tmpAmt;
                        newformatAmt(amountFormat,ObjForm.tmpAmtField,crncyCode,'N');
                        availableBal = ObjForm.tmpAmtField.value + " " + crDrIndicator;

                        // Effective Available Balance
                        var tmpAmt = parseFloat(effAvailableBal);
                        if(tmpAmt < 0){
                                tmpAmt = tmpAmt * (-1);
                                crDrIndicator = "Dr";
                        }else{
                                crDrIndicator = "Cr";
                        }
                        tmpAmt = tmpAmt.toFixed(prec);
                        ObjForm.tmpAmtField.value = tmpAmt;
                        newformatAmt(amountFormat,ObjForm.tmpAmtField,crncyCode,'N');
                        effAvailableBal = ObjForm.tmpAmtField.value + " " + crDrIndicator;

                        // Shadow Balance
                        var tmpAmt = parseFloat(shadowBal);
                        if(tmpAmt < 0){
                                tmpAmt = tmpAmt * (-1);
                                crDrIndicator = "Dr";
                        }else{
                                crDrIndicator = "Cr";
                        }
                        tmpAmt = tmpAmt.toFixed(prec);
                        ObjForm.tmpAmtField.value = tmpAmt;
                        newformatAmt(amountFormat,ObjForm.tmpAmtField,crncyCode,'N');
                        shadowBal = ObjForm.tmpAmtField.value + " " + crDrIndicator;
		    }
			
			var urlData = "";
			urlData+= "&acctId="+acctId;
			urlData+= "&solId="+solId;	
			urlData+= "&crncyCode="+crncyCode;
			urlData+= "&acctName="+acctName;
			urlData+= "&ledgerBal="+ledgerBal;
			urlData+= "&availableBal="+availableBal;	
			urlData+= "&effAvailableBal="+effAvailableBal;
			urlData+= "&freezeStatus="+freezeStatus;
			urlData+= "&freezeReasonCode="+freezeReasonCode;
			urlData+= "&acctClosed="+acctClosed;
			urlData+= "&shadowBal="+shadowBal;
			urlData+= "&acctStatus="+acctStatus;
			urlData+= "&entityId="+document.forms[0].drAcctNumEntityId.value;
			//alert(urlData);	
                }
        }
	
        var sUrl = "../custom/jsp/cietxn_acctBal.jsp?";
	sUrl+= urlData;
	//alert("sUrl = "+sUrl);
        var xMax = screen.width, yMax = screen.height;
        var xOffset = (xMax - 120), yOffset = (yMax - 150);
        var params = "dialogWidth=800px;dialogHeight=50px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
        params += ";status=yes;toolbar=yes;menubar=yes;resizable=yes;help=yes;center=no";

        var retVal = "";
        if("Netscape" == browser_name)
        {
                window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");
        }
        else
        {
                retVal = window.popModalWindow(sUrl,"",params);
        }
        if (retVal == null || retVal == undefined)
	{
                return retVal;
	}
    }
    else{
		alert("Enter the Debit Account ID");
		ObjForm.drAcctNum.focus();
    }
}

function fnRemoveCommas(){
        var ObjForm = document.forms[0];
        var refAmt = ObjForm.refAmt.value;
        refAmt = removeCommas(refAmt);
        ObjForm.refAmt.value = refAmt;

        var tranAmt = ObjForm.tranAmt.value;
        tranAmt = removeCommas(tranAmt);
        ObjForm.tranAmt.value = tranAmt;

        var chargeAmt = ObjForm.chargeAmt.value;
        chargeAmt = removeCommas(chargeAmt);
        ObjForm.chargeAmt.value = chargeAmt;
}

function isEnglish(str){
    for (i=0; i<str.length; i++)
        {
                var validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_";
                if((validChars.indexOf(str.charAt(i)) == -1))
                {
                        return false;
                }
    }
    return true;
}

function removeCommas(sNum){
	sNew ="";
	var sTemp = sNum.split(",");
	for (i=0;i<sTemp.length;i++)
	{
		if (sTemp[i]!=null)
			sNew = sNew + sTemp[i];
	}
	return sNew;
}

function fnValAndSubmit(btnObj){
var ObjForm = document.forms[0];
        if(fnValidateData()){
                fnRemoveCommas();
                var retVal ;
		doSubmit(btnObj.id);
        }
}

function fnCheckInteger()
{
	var ObjForm = document.forms[0];

	if (!fnIsAlphabetNum(document.forms[0].mWaivermnths.value))
	{
		alert("Only Positive Integers are allowed");
		return false;
	}

        return true;
}

function fnIsAlphabetNum(str)
{
	var strReg = /^([0-9 ])+$/ 
	if(!fnIsNull(str))
	return(strReg.test(str));
	return true;
}

function fnOnButtonClick(btnObj)
{
	if(confirm(finbranchResArr.get("FAT000925")))
	{
		var ObjForm = document.forms[0];
		doSubmit(btnObj);
	}
}

function low_isValidAmt(amt)
{
	var amtLen = amt.length;
	var lastChar = (amt.charAt(amtLen - 1)).toUpperCase();
	if (isNaN(lastChar) && lastChar != '.') {
		alert("Enter a numeric value");
		return false;
	}
	if (isNaN(amt)) {
		alert("Enter a numeric value");
		return false;
	}
	var regExp = /[Ee]/g;
	if (regExp.test(amt)) {
		alert("Enter a numeric value");
		return false;
	}
	return true;
}

function fnGetFunctionCodeDesc(funcCode){
	switch(funcCode){
		case 'A': return "Add";
		case 'I': return "Inquire";
		default : return funcCode;
	}

}

/***************************************************
* This function is used to disable all the visible
* controls in the screen.
****************************************************/
function fnCustDisableFormControls(objForm){
	
		var obj=document.forms[0];
		var len=obj.length;
		
		//disable form visible data controls
		for(i = 0; i < len; i++){
			if(( obj[i].type == 'text' )||( obj[i].type == 'textarea' )) {
				obj[i].readOnly = true;
			} else if (obj[i].type == 'select-one'){
				obj[i].disabled = true;
			} else if ( obj[i].type == 'checkbox' || obj[i].type == 'radio') {
				obj[i].disabled = true;
			}
		}
		
		if((objForm.Validate != undefined) && (objForm.Validate != null)){
		       objForm.Validate.disabled = true;
		}
}




// Added for Testing Onload event
function postEventCall(pageName,currObj,event){

    var funcName="";

    //This is to call the application level customization functions.
    //which will be defined in finbranch/custom/javascripts/app_custom.js

    funcName="this.app_post_"+event;

        if(eval(funcName)!=undefined)
        if(!eval(funcName).call(this,currObj))  return false;

    //End of application level customization hook

    funcName="this.post_usrhk_"+event;
    if(eval(funcName)!=undefined)
        if(!eval(funcName).call(this,currObj))  return false;

    funcName="this." + pageName + "_post_"+event;

        if(eval(funcName)!=undefined){

//------------------------------------------------
        //Following Code is altered
//------------------------------------------------


        if(this.WF_IN_PROGRESS == "Y" || this.WF_IN_PROGRESS == "PEAS"){
            if(!eval(funcName).call(this,currObj))  {
                fnSetFocusOnFirstField_postonload();
                return true;
            }
        }

        else{

                if(!eval(funcName).call(this,currObj)) {
                        return false;
                }
                else{
                        fnSetFocusOnFirstField_postonload();
                }

                return true;
        }

     }
}


//Show Account Id list js function

function cust_showAccountIdList(acctObj,solId,acctName,inPreceedence,currDesc,defCrncyCode,defSchemeCode,defSchemeType,defSolId,defCifId,defGLSubHead,defOwnership,defShortName,defAcctLbl,defPartn,doAutoSubmit,defMasterAcctId,searchLang,targetBankId,dispBankIDFldFlg){
/* Function modified to add input parameters to default in Account Id Criteria.
If these are not supplied, the list would continue working as before.
Note that the arguments.length <5 should be modified with care. */

        var sUrl = "";
        var preceedence = 'B';
        var strCrncyCode = "";
        var strSchemeCode = "";
        var strSchemeType = "";
        var strSolId = "";
        var strCifId = "";
        var strsearchLang = "";
        var strGLSubHead = "";
        var strOwnership = "";
        var strShortName = "";
        var strAcctLbl = "";
        var strPartn = "";
        var strSubmit = "";
        var strTargetBankId = "";
        var acctIdVal = "";

/* Assigning default if passed */
        if(acctObj.value != ""){acctIdVal = acctObj.value;}
        //if(targetBankId  == undefined){ strTargetBankId  = "";} else {strTargetBankId  = targetBankId.value;}
        strTargetBankId = document.forms[0].targetEntity.value;
    if(defCrncyCode  == undefined){ strCrncyCode  = "";} else { strCrncyCode  = defCrncyCode;}
    if(defSchemeCode == undefined){ strSchemeCode = "";} else { strSchemeCode = defSchemeCode;}
    if(defSchemeType == undefined){ strSchemeType = "";} else { strSchemeType = defSchemeType;}
    if(defSolId      == undefined){ strSolId      = "";} else { strSolId      = defSolId;}
    if(defCifId     == undefined){ strCifId     = "";} else { strCifId     = defCifId;}
    if(searchLang     == undefined){ strsearchLang = "";} else { strsearchLang = searchLang;}
    if(defGLSubHead  == undefined){ strGLSubHead  = "";} else { strGLSubHead  = defGLSubHead;}
    if(defOwnership  == undefined){ strOwnership  = "";} else { strOwnership  = defOwnership;}
//    if(defShortName  != undefined){ strShortName  = defShortName;}
    if(defAcctLbl    == undefined){ strAcctLbl  = "";} else { strAcctLbl  = defAcctLbl;}
    if(defPartn      == undefined){ strPartn = "";} else { strPartn = defPartn;}
        if(defMasterAcctId  == undefined){ strMasterAcctId  = "";} else { strMasterAcctId  = defMasterAcctId;}
        if(doAutoSubmit  == undefined){ strSubmit = "";} else { strSubmit = doAutoSubmit;}

    if(arguments.length > 3)
    {
        preceedence = inPreceedence;
    }
        if (arguments.length < 5)
        {
                sUrl = "../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy=NULL&wReturnSol=NULL&wReturnAcct=NULL&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+"&defSolId="+escape(strSolId)+"&defCifId="+escape(strCifId)+"&searchLang="+escape(strsearchLang)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+"&defOwnership="+strOwnership+"&defShortName="+escape(strShortName)+"&defAcctLbl="+strAcctLbl+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&targetBankId="+escape(strTargetBankId)+"&dispBankIDFldFlg="+dispBankIDFldFlg+"&defacctIdVal="+acctIdVal+"&doAutoSubmit="+strSubmit;
        }else
        {
                sUrl = "../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy="+currDesc.id+"&wReturnSol="+solId.id+"&wReturnAcct="+acctName.id+"&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+"&defSolId="+escape(strSolId)+"&defCifId="+escape(strCifId)+"&searchLang="+escape(strsearchLang)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+"&defShortName="+escape(strShortName)+"&defAcctLbl="+escape(strAcctLbl)+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&targetBankId="+escape(strTargetBankId)+"&dispBankIDFldFlg="+dispBankIDFldFlg+"&defacctIdVal="+acctIdVal+"&doAutoSubmit="+strSubmit;
        }

                if ("Microsoft Internet Explorer" == browser_name)
                {
                     var retVal = popModalWindow(sUrl,"");
                if (retVal != null && retVal != undefined )
                {
                        //Array for taking the values after splitting the value with "|".
                        var liarrBufArray = retVal.split("|");

                if(acctObj!=null) acctObj.value = liarrBufArray[0];
                        if(currDesc!=null) currDesc.value = liarrBufArray[1];
                        if(solId!=null) solId.value = liarrBufArray[2];
                        if(acctName!=null) acctName.value = liarrBufArray[3];
                }
                }else{
                            popModalWindowMozillaFrame(sUrl,"");
                }

}

function showFinacleSignature()
{
        var bUrl = getBaseUrl();
        var acctBnkId = document.forms[0].drAcctNumEntityId.value;
        var cifIdForSig = document.forms[0].cifIdForSig.value;
        var acctNo = document.forms[0].drAcctNum.value;
        if(fnIsNull(cifIdForSig))
        {
                alert("Enter valid Account ID");
                document.forms[0].drAcctNum.focus();
                return;
        }

        var signUrl = bUrl + "/finbranch/GetSignature?EntityId=" + acctBnkId + "&CustId=" + cifIdForSig + "&AcctNo=" + acctNo ;
        window.open(signUrl);
}

function denom_pop_up(obj){
        var ObjForm = document.forms[0];
        var refAmt = removeCommas(ObjForm.refAmt.value);
        var refCrncy = ObjForm.refCrncy.value.toUpperCase();
        var retVal = cust_fndenompopup("A","C","NP","",refCrncy,refAmt,"D","","","P","Y","");

        if(retVal == "cancel" || retVal == false){
                return false;
        }else{
                ObjForm.returnValue1.value = retVal;
                return true;
        }
}

function fnResetDenomVariable(){
        var ObjForm = document.forms[0];
        ObjForm.returnValue1.value = "";
        return;
}

function cust_callTrRefNoSearcher(obj){
        var ObjForm = document.forms[0];
	ObjForm.treaRefNum.value = "";
	var targetEntity = ObjForm.drAcctNumEntityId.value;
	var drAcctNum = ObjForm.drAcctNum.value;
	var drAcctNumCcy = ObjForm.drAcctNumCcy.value;
	var refCrncy = ObjForm.refCrncy.value;

	//call custom searcher and get the return value here
	var inputNameValues = "targetEntity|"+targetEntity+"|drAcctNum|"+drAcctNum+"|refCrncy|"+refCrncy+"|drAcctNumCcy|"+drAcctNumCcy;
        var outputNameValues = "treasuryRefNum|treasuryEvent|ccy1|treasuryAmt|ccy2|purchaseOrSale|fundsDeliveryDate|treasuryRate|splRateCode|customerRate";
        var scriptName = "cietxndp058.scr";
        var listHeading = "Target Entity Treasury Ref. No. Search";
        var colHeader = "Treasury Ref. No.|Event|CCY1|Amt.|CCY2|Purchase/Sale|Funds Delivery Date|Treasury Rate|Rate Code|Customer Rate";
        var retVal = fnExecuteScriptForListForTreasury(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
}

function cust_callTrRefNoSearcher1(obj){
        callTrRefNoSearcher('S','10');
        var ObjForm = document.forms[0];
        var treaRefNum = ObjForm.treaRefNum.value;
        if(!fnIsNull(treaRefNum)){
                ObjForm.rateCode.disabled = true;
                ObjForm.rate.disabled = true;
                ObjForm.treaRate.disabled = true;
                hideImage("rateCodeImg");
        }
}

function callTrRefNoSearcher(trRefNumLoc,link){
        var frm = document.forms[0];
        enableFields("rateCode","rate","treaRate");
        frm.rateCode.value="";
        frm.rate.value="";
        frm.treaRate.value="";
        trRefNum = trRefNumLoc;
	showDynCritSearcher('HTREFNO','tr_ref_num=:document.forms[0].treaRefNum',':document.forms[0].treaRefNum=tr_ref_num|:document.forms[0].rateCode=ratecode|:document.forms[0].rate=cust_rate|:document.forms[0].treaRate=treasury_rate');
        if(!fnIsNull(frm.rateCode.value) && !fnIsNull(frm.rate.value) && !fnIsNull(frm.treaRate.value)){
                disableFields("rateCode","rate","treaRate");
                if(link == '9'){
                        tmDisableLink("sLnk10");
                }
                if(link == '11'){
                        tmDisableLink("sLnk12");
                }
        }

        fnComputeTranAmt(frm.rate);
}

//Added for biometric validation - Dileep
function doLocalBioMetricVal()
{

        var myMopId = "";
        var retVal4Menu = "";
        /**************************************************************************************
         * Checking if the menu invoked is present in valMenu. Only if the
         * mopId is present in valMenu array the biometric validation has
         * to be executed
         **************************************************************************************/
                retVal4Menu = isBioValReq4Menu(mopId);
                if(retVal4Menu == true)
                {
                        getFieldforBioAndCallBio(mopId);
                }
        return true;
}

function fnPrintReceipt(){

if(fnValidateData()){
        if(fnIsNull(rptFilePath)){
                var frm = document.forms[0];
                var inputNameValues="entityId|"+frm.targetEntity.value+"|drAcNum|"+frm.drAcctNum.value+"|refCrncy|"+frm.refCrncy.value+"|refAmt|"+removeCommas(frm.refAmt.value);
                
                var outputNames = "errorFlg|errorMsg|rptFilePath";
                var scriptName = "cietxndp060.scr"
                var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
                var token = retVal.split("|");
               
                if(token != undefined){
                        var errorFlg = token[1];
                        var errorMsg = token[3];
                        var rptFilePath = token[5]; 
                     

                        if(errorFlg == "Y"){
                                alert(errorMsg);
                                return false;
                        }
                        else{
                                cust_doJsPrint(rptFilePath,"printTransientFileOnDT","false","false");

				var flag=confirm("Print Successful?"); 
                                if(flag){
                                        frm.disablePrintFlg.value ="Y";
										frm.Submit.disabled=false;
                                        frm.Print.disabled=true;
                                }else{
                                        frm.Submit.disabled=true;
                                }
				
                        }
                }
        }

}
return;
}



//      Function to display the advice in the popup windiow.

function cust_doJsPrint(rptFileName,printFunctionName,duplicatePrintAllowed,printOnLoad)
{
        var sUrl = "../custom/jsp/cust_rpt_print.jsp?";

        if(!cust_fnIsNull(rptFileName))
                sUrl += "&rptFileName="+rptFileName;
        if(!cust_fnIsNull(printFunctionName))
                sUrl += "&printFunctionName="+printFunctionName;
        if(!cust_fnIsNull(duplicatePrintAllowed))
                sUrl += "&duplicatePrintAllowed="+duplicatePrintAllowed;
        if(!cust_fnIsNull(printOnLoad))
                sUrl += "&printOnLoad="+printOnLoad;

        sUrl += "&retPage=Y";
        var xMax = screen.width, yMax = screen.height;
        var xOffset = (xMax - 120), yOffset = (yMax - 150);
        var params ="dialogWidth=500px;dialogHeight=500px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
        params += ";status=no;toolbar=no;menubar=no;resizable=yes;help=no;center=no";
        var retVal = "";
        if("Netscape" == browser_name){
                window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");
        }else{
                retVal = window.popModalWindow(sUrl,"",params);
                window.close();
        }
        if (retVal == null || retVal == undefined){
                return retVal;
        }
}

function fnExecuteScriptForListForTreasury(inputNameValues, outputNames, scrName, pageTitle, literalNames, hyperLnkCols, isPopulationReq)
{
        var sUrl = "../custom/jsp/cust_fetch_list.jsp?";

        if((inputNameValues.indexOf("pageNumber") != -1) && (inputNameValues.indexOf("pageSize") == -1))
        {
                alert("Page Size is mandatory");
                return;
        }

        if((inputNameValues.indexOf("pageSize") != -1) && (inputNameValues.indexOf("pageNumber") == -1))
        {
                alert("Page Number is mandatory");
                return;
        }

        if(!cust_fnIsNull(inputNameValues))
                sUrl += "&inputs="+encodeURIComponent(inputNameValues);


        if(cust_fnIsNull(scrName))
        {
                alert("Script Name is mandatory");
                return;
        }

        sUrl += "&scrName="+scrName;


        if(cust_fnIsNull(outputNames))
        {
                alert("List ouput field names are mandatory");
                return;
        }

        sUrl += "&outputs="+outputNames;


        if(cust_fnIsNull(pageTitle))
        {
                pageTitle=finbranchResource.FHP000368;
        }

        sUrl += "&pageTitle="+encodeURIComponent(pageTitle);

        if(cust_fnIsNull(literalNames))
        {
                alert("Column Literal Names are mandatory");
                return;
        }

        sUrl += "&literalNames="+encodeURIComponent(literalNames);

        if(cust_fnIsNull(hyperLnkCols))
        {
                hyperLnkCols="1";
        }
        sUrl += "&hyperLnkCols="+hyperLnkCols;

        var retVal = cust_popModalWindow(sUrl, "Custom List");

        if (retVal == null || retVal == undefined)
                return retVal;

        if (!isPopulationReq)
                return retVal;

        if ("Microsoft Internet Explorer" == browser_name)
        {
                var frm = document.forms[0];
                var outBuff = outputNames.split("|");
                var outBuffLen = outBuff.length;

		var token = retVal.split("|");
		var treasuryRefNum = token[0];
		var treasuryRate = token[7];
		var splRateCode = token[8];
		var customerRate = token[9];

		var targetEntityId = frm.drAcctNumEntityId.value;
		var fromCcy = frm.refCrncy.value;
		var toCcy = frm.drAcctNumCcy.value;
		var refAmtTmp = frm.refAmt.value;
        	var refAmt = removeCommas(refAmtTmp);

		var inputNameValues = "targetEntityId|"+targetEntityId+"|fromCcy|"+fromCcy+"|toCcy|"+toCcy+"|refAmt|"+refAmt+"|splRateCode|"+splRateCode+"|customerRate|"+customerRate;
	        var outputNames = "errorFlg|errorMsg|tranAmt|tranAmtCcy";
	        var scriptName = "cietxndp061.scr"
	        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	        var token = retVal.split("|");
	        if(token != undefined){
	                var errorFlg = token[1];
	                var errorMsg = token[3];
	                var tranAmt = token[5];
	                var tranAmtCcy = token[7];

			if(errorFlg == "Y"){
				alert(errorMsg);
				return;
			}

			frm.treaRefNum.value = treasuryRefNum;
			frm.treaRate.value = treasuryRate;
			frm.rateCode.value = splRateCode;
			frm.rate.value = customerRate;
			frm.tranAmt.value = tranAmt;
			frm.tranAmtCcy.value = tranAmtCcy;
			newformatAmt("Million",frm.tranAmt,frm.tranAmtCcy.value,'N');
			fnCustDisableFormControls(frm);
			hideImage("rateCodeImg");
			hideImage("targetEntityImg");
			hideImage("drAcctNumImg");
		}
        }
}

function fnGetEntityDesc2(){
        var ObjForm = document.forms[0];
        var creditEntity = ObjForm.creditEntity.value;

        if(fnIsNull(creditEntity)){
                ObjForm.creditEntityDesc.value = "";
        }else{
                var inputNameValues = "targetEntity|"+creditEntity;
                var outputNames = "errorFlg|errorMsg|targetEntity|targetEntityDesc";
                var scriptName = "cietxndp018.scr"
                var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
                var token = retVal.split("|");
                if(token != undefined){
                        var errorFlg = token[1];
                        var errorMsg = token[3];
                        var creditEntity = token[5];
                        var creditEntityDesc = token[7];

                        if(errorFlg == "Y"){
                                alert(errorMsg);
                                setFieldFocus(ObjForm.creditEntity);
                                return false;
                        }else{
                                ObjForm.creditEntity.value = creditEntity;
                                ObjForm.creditEntityDesc.value = creditEntityDesc;
                                ObjForm.crAcctNum.focus();
                        }
                }
        }
        return true;

}

function fnGetAcctDetails2(){
        var ObjForm = document.forms[0];
        fnEnableAcctDetails2();
        var crAcctNum = ObjForm.crAcctNum.value;
        var inputNameValues = "acctNum|"+crAcctNum;
        var outputNames = "errorFlg|errorMsg|acctNumEntityId|acctNumSolId|acctNumCcy|acctName|acctNum";
        var scriptName = "cietxndp011.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
        if(token != undefined){
                var errorFlg = token[1];
                var errorMsg = token[3];
                var crAcctNumEntityId = token[5];
                var crAcctNumSolId = token[7];
                var crAcctNumCcy = token[9];
                var crAcctName = token[11];
                var crAcctNum = token[13];

                if(errorFlg == "Y"){
                        alert(errorMsg);
                        fnClearAcctDetails2();
                        setFieldFocus(ObjForm.crAcctNum);
                        return false;

                }else{
                        ObjForm.creditEntity.value = crAcctNumEntityId;
                        fnGetEntityDesc2();
                        ObjForm.crAcctNumEntityId.value = crAcctNumEntityId;
                        ObjForm.crAcctNumSolId.value = crAcctNumSolId;
                        ObjForm.crAcctNumCcy.value = crAcctNumCcy;
                        ObjForm.crAcctName.value = crAcctName;
                        ObjForm.crAcctNum.value = crAcctNum;
                        fnDisableAcctDetails2();
                        //fnGetNostroVostroAccts();
                        //fnComputeTranAmt(ObjForm.crAcctNum);
                }
        }
        return true;
}

function getAcctIdList2() {
        var ObjForm = document.forms[0];
        var creditEntity = ObjForm.creditEntity.value;
        cust_showAccountIdList2(ObjForm.crAcctNum,null,null,'F');
        var crAcctNum = ObjForm.crAcctNum.value;

        if(!fnIsNull(crAcctNum)){
                var retVal = fnValidateAcctNumEntityId(crAcctNum,'crAcctNum');
                if(retVal == false){
                        return false;
                }
        }

        if(!fnIsNull(crAcctNum)){
                fnGetAcctDetails2();
        }
}

//Show Account Id list js function for crAcctNum

function cust_showAccountIdList2(acctObj,solId,acctName,inPreceedence,currDesc,defCrncyCode,defSchemeCode,defSchemeType,defSolId,defCifId,defGLSubHead,defOwnership,defShortName,defAcctLbl,defPartn,doAutoSubmit,defMasterAcctId,searchLang,targetBankId,dispBankIDFldFlg){
/* Function modified to add input parameters to default in Account Id Criteria.
If these are not supplied, the list would continue working as before.
Note that the arguments.length <5 should be modified with care. */

        var sUrl = "";
        var preceedence = 'B';
        var strCrncyCode = "";
        var strSchemeCode = "";
        var strSchemeType = "";
        var strSolId = "";
        var strCifId = "";
        var strsearchLang = "";
        var strGLSubHead = "";
        var strOwnership = "";
        var strShortName = "";
        var strAcctLbl = "";
        var strPartn = "";
        var strSubmit = "";
        var strTargetBankId = "";
        var acctIdVal = "";

/* Assigning default if passed */
        if(acctObj.value != ""){acctIdVal = acctObj.value;}
        //if(targetBankId  == undefined){ strTargetBankId  = "";} else {strTargetBankId  = targetBankId.value;}
        strTargetBankId = document.forms[0].targetEntity.value;
    if(defCrncyCode  == undefined){ strCrncyCode  = "";} else { strCrncyCode  = defCrncyCode;}
    if(defSchemeCode == undefined){ strSchemeCode = "";} else { strSchemeCode = defSchemeCode;}
    if(defSchemeType == undefined){ strSchemeType = "";} else { strSchemeType = defSchemeType;}
    if(defSolId      == undefined){ strSolId      = "";} else { strSolId      = defSolId;}
    if(defCifId     == undefined){ strCifId     = "";} else { strCifId     = defCifId;}
    if(searchLang     == undefined){ strsearchLang = "";} else { strsearchLang = searchLang;}
    if(defGLSubHead  == undefined){ strGLSubHead  = "";} else { strGLSubHead  = defGLSubHead;}
    if(defOwnership  == undefined){ strOwnership  = "";} else { strOwnership  = defOwnership;}
//    if(defShortName  != undefined){ strShortName  = defShortName;}
    if(defAcctLbl    == undefined){ strAcctLbl  = "";} else { strAcctLbl  = defAcctLbl;}
    if(defPartn      == undefined){ strPartn = "";} else { strPartn = defPartn;}
        if(defMasterAcctId  == undefined){ strMasterAcctId  = "";} else { strMasterAcctId  = defMasterAcctId;}
        if(doAutoSubmit  == undefined){ strSubmit = "";} else { strSubmit = doAutoSubmit;}

    if(arguments.length > 3)
    {
        preceedence = inPreceedence;
    }
        if (arguments.length < 5)
        {
                sUrl = "../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy=NULL&wReturnSol=NULL&wReturnAcct=NULL&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+"&defSolId="+escape(strSolId)+"&defCifId="+escape(strCifId)+"&searchLang="+escape(strsearchLang)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+"&defOwnership="+strOwnership+"&defShortName="+escape(strShortName)+"&defAcctLbl="+strAcctLbl+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&targetBankId="+escape(strTargetBankId)+"&dispBankIDFldFlg="+dispBankIDFldFlg+"&defacctIdVal="+acctIdVal+"&doAutoSubmit="+strSubmit;
        }else
        {
                sUrl = "../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy="+currDesc.id+"&wReturnSol="+solId.id+"&wReturnAcct="+acctName.id+"&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+"&defSolId="+escape(strSolId)+"&defCifId="+escape(strCifId)+"&searchLang="+escape(strsearchLang)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+"&defShortName="+escape(strShortName)+"&defAcctLbl="+escape(strAcctLbl)+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&targetBankId="+escape(strTargetBankId)+"&dispBankIDFldFlg="+dispBankIDFldFlg+"&defacctIdVal="+acctIdVal+"&doAutoSubmit="+strSubmit;
        }

                if ("Microsoft Internet Explorer" == browser_name)
                {
                     var retVal = popModalWindow(sUrl,"");
                if (retVal != null && retVal != undefined )
                {
                        //Array for taking the values after splitting the value with "|".
                        var liarrBufArray = retVal.split("|");

                if(acctObj!=null) acctObj.value = liarrBufArray[0];
                        if(currDesc!=null) currDesc.value = liarrBufArray[1];
                        if(solId!=null) solId.value = liarrBufArray[2];
                        if(acctName!=null) acctName.value = liarrBufArray[3];
                }
                }else{
                            popModalWindowMozillaFrame(sUrl,"");
                }

}

function fnGetCrAcctDetails(){
        var ObjForm = document.forms[0];
        var crAcctNum = ObjForm.crAcctNum.value;

        if(!fnIsNull(crAcctNum)){
                var retVal = fnValidateAcctNumEntityId(crAcctNum,'crAcctNum');
                if(retVal == false){
                        return false;
                }
        }

        if(!fnIsNull(crAcctNum)){
                fnGetAcctDetails2();
                fnClearAmtFields();
                fnClearRateFields();
                ObjForm.refCrncy.focus();
        }else{
                fnClearAcctDetails2();
        }
        return true;
}

function fnValidateAcctNumEntityId(obj1,obj2){
        var ObjForm = document.forms[0];
        var inputNameValues = "txnType|RF|acctNum|"+obj1+"|fieldValidated|"+obj2;
        var outputNames = "errorFlg|errorMsg";
        var scriptName = "cietxndp062.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
        if(token != undefined){
                var errorFlg = token[1];
                var errorMsg = token[3];
                if(errorFlg == "Y"){
                        alert(errorMsg);
                        if(obj2 == 'drAcctNum'){
                                ObjForm.drAcctNum.value = "";
                                fnClearAcctDetails();
                        }

                        if(obj2 == 'crAcctNum'){
                                ObjForm.crAcctNum.value = "";
                                fnClearAcctDetails2();
                        }
                        return false;
                }
        }
        return true;
}

