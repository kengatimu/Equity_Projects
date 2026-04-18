function cietxn_det6_post_ONLOAD()
{
        var ObjForm = document.forms[0];

	if(cashTxnFlg == "Y"){
		hideImage("drAcctNumRow");
		hideImage("instrumentTypeRow");
		hideImage("instrumentDateRow");
	}

	hideImage("rateCodeImg");
	hideImage("debitEntityRow");
	hideImage("creditEntityRow");		
	hideImage("crAcctNumImg");
	hideImage("sLnk7");
	hideImage("sLnk12");
	hideImage("drAcctNumSigImg");
	hideImage("treaRefNumImg");
        hideImage("targetEntityimg");
	if(fnIsNull(entity2PymtTranId)){
		hideImage("pymtTranIdRow");
	}
	fnFormatAmountField(ObjForm.refAmt);
        fnFormatAmountField(ObjForm.tranAmt);
        fnFormatAmountField(ObjForm.chargeAmt);
        fnFormatAmountField(ObjForm.rate);

	hideImage("sLnk8");

        return true;
}

function fnFormatAmountField(obj){
	var p1 = removeCommas(obj.value);
	var ObjForm = document.forms[0];
	var amountFormat = "Million";
        var crncyCode = "";

	crncyCode = ObjForm.crAcctNumCcy.value;
	if(obj.id == "refAmt"){
		if(fnIsNull(p1)){
			fnClearAmtFields();
			fnClearRateFields();
			return false;
		}

		if(isNaN(p1)){
			alert("Please Enter a Valid Amount");
			fnClearAmtFields();
	                fnClearRateFields();
			setFieldFocus(ObjForm.refAmt);
	                return false;
		}

		if(parseFloat(p1) <= parseFloat("0")){
			alert("Amount should be greater than zero");
			fnClearAmtFields();
			fnClearRateFields();
			setFieldFocus(ObjForm.refAmt);
			return false;
		}

		crncyCode = ObjForm.refCrncy.value;
	}

	newformatAmt(amountFormat,obj,crncyCode,'N');	
	if(fnIsNull(ObjForm.refCrncy.value)){
		ObjForm.refCrncy.focus();
		return false;
	}

	return true;
}

function fnExplodeBalanceDetails(obj){
    var ObjForm = document.forms[0];
    var acctId = obj.value;
    var sUrl = "";
    var urlData = "";
    if(!fnIsNull(acctId)){
	if(obj.id == "drAcctNum"){
		var entityId = ObjForm.drAcctNumEntityId.value;
	}else{
		var entityId = ObjForm.crAcctNumEntityId.value;
	}
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
			if(obj.id == "drAcctNum"){
	                        urlData+= "&entityId="+document.forms[0].drAcctNumEntityId.value;
			}
			if(obj.id == "crAcctNum"){
	                        urlData+= "&entityId="+document.forms[0].crAcctNumEntityId.value;
                        }
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
                window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no"
);
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
		if(obj.id == "drAcctNum"){
			alert("Enter the Debit Account ID");
			obj.focus();
		}
		if(obj.id == "crAcctNum"){
			alert("Enter the Credit Account ID");
			obj.focus();
		}
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
	if(fnValidateData()){
		var ObjForm = document.forms[0];
		if(ObjForm.cashTxn[0].checked == true){
			ObjForm.cashTxnFlg.value = "Y";
		}else{
			ObjForm.cashTxnFlg.value = "N";
		}
		fnRemoveCommas();
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

function showFinacleSignature(){
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

