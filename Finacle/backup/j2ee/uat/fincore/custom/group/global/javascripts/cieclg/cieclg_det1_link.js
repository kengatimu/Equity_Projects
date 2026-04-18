//UBP Clearing--start--
var buttonFlg="N";
var insertTableFlg="Y";
var remoteClickedButton="N";
var repModSetNum;
//UBP clearing --End--
function cieclg_det1_post_ONLOAD()
{
        var ObjForm = document.forms[0];

        if(funcCode == "A"){
        
                //ObjForm.creditEntity.focus();
		hideImage("setNumRow");
		//Added for UBP change-start
		if(billPayYes=="Y")
		{	
			
			//Auto populating Cr Entity Id and its desc
			
			ObjForm.creditEntity.value=critCrAcctBnkId;
			
			ObjForm.creditEntity.disabled=true;
			hideImage("creditEntityImg");
			
			fnGetEntityDesc();
			
			//Auto populating Cr Acct Num and its desc
			ObjForm.crAcctNum.value=critCrAcctNum;
			
			ObjForm.crAcctNum.disabled=true;
			hideImage("crAcctNumImg");
			hideImage("customExplode1");
			fnGetAcctDetails();
				
			if(document.forms[0].retStrngValHid.value!="")
			{
				insertTableFlg ="Y";
				buttonFlg="Y";
				fngetDynData();
			}
			if(valType=="L")
			{
				if((document.forms[0].billRefNum.value!="")&& (document.forms[0].name.value!=""))
				{
					insertTableFlg ="Y";
					buttonFlg="Y";
				}
			}
			if((valType=="R")&&((billerId=="IPO")||(billerId=="SAFARICOM")||(billerId=="YU")))
			{
				if((document.forms[0].billRefNum.value!="")&& (document.forms[0].name.value!=""))
				{
					insertTableFlg ="Y";
					buttonFlg="Y";
				}
			}
			if((valType=="R")&&((billerId=="KRA")||(billerId=="SAFARICOM")||(billerId=="YU")))
			{
				if((billerId=="KRA"))
				{
					document.forms[0].freetext1.value=billerCode;
				}
				if((document.forms[0].billRefNum.value!="")&& (document.forms[0].tranParticular.value!=""))
				{
					document.forms[0].billRefNum.disabled=true;
					insertTableFlg ="Y";
					buttonFlg="Y";
				}
			}
		
		}
		else
		{
			ObjForm.creditEntity.focus();
		}
		//Added for UBP change--end
        }
        //Added for UBP change-start
        if(funcCode != "A")
        {
        	if(billPayYes=="Y")
		{
			
			fnOnLoadPopDynValue();
			document.getElementById("getBillDtl").style.display='none';
			hideImage("getBillDtl");
			document.forms[0].billRefNum.disabled = true;
			document.forms[0].name.disabled = true;
				
		}
        }
        
        //Added for UBP change-end
	if((funcCode != "A") && (funcCode != "M")){
		hideImage("creditEntityImg");
		hideImage("crAcctNumImg");
		hideImage("instrumentEntityImg");
		hideImage("instrumentBankCodeImg");
		hideImage("instrumentBranchCodeImg");
		hideImage("instrumentSortCodeImg");
		hideImage("instrumentDateImg");
		hideImage("targetZoneDateImg");
		hideImage("valueDateImg");
		
        }
	//ubp added start
	hideImage("UbpBillerRow");
	if(billPayYes=="Y")
	{
		showImage("UbpBillerRow");
	}
	
	//ubp added end
	hideImage("tranIdRow");
	if(status == "R"){
		showImage("tranIdRow");
	}

	hideImage("chargeTranIdRow");
        if((status == "V")||(status == "R")){
                showImage("chargeTranIdRow");
        }

	hideImage("rejectReasonCodeRow");
	if((funcCode == "O")||(status == "O")){
		showImage("rejectReasonCodeRow");
		ObjForm.rejectReasonCode.readOnly = false;
		fnGetRejectReasonCodeDesc();
	}

	hideImage("payingAcctSigImg");
	if(funcCode == "R"){
                showImage("payingAcctSigImg");
        }

	ObjForm.nostroAcct.disabled = true;
	ObjForm.vostroAcct.disabled = true;
	ObjForm.instrumentBankName.disabled = true;
	ObjForm.instrumentBranchName.disabled = true;
	ObjForm.instrumentAmtCcy.disabled = true;
	ObjForm.targetZoneCode.disabled = true;
	ObjForm.targetSolId.disabled = true;
	ObjForm.targetSetNum.disabled = true;
	fnDisableAmtFields();
	fnGetEntityDesc();
	fnGetEntityDescForInstrument();
	showSortCode();
	fnFormatAmountField(ObjForm.instrumentAmt);
	fnFormatAmountField(ObjForm.chargeAmt);
	if(!fnIsNull(ObjForm.crAcctNum.value)){
		var retVal = fnGetCrAcctDetails();
	}
        return true;
}

function fnValidateData(){
	var ObjForm = document.forms[0];
	var creditEntity = ObjForm.creditEntity.value;
	var crAcctNum = ObjForm.crAcctNum.value;
	var instrumentEntity = ObjForm.instrumentEntity.value;
	var instrumentAmt = ObjForm.instrumentAmt.value;
	var instrumentDate = ObjForm.instrumentDate.value;
	var instrumentAlpha = ObjForm.instrumentAlpha.value;
	var instrumentNum = ObjForm.instrumentNum.value;
	var valueDate = ObjForm.valueDate.value;
	var instrumentBankCode = ObjForm.instrumentBankCode.value;
	var instrumentBranchCode = ObjForm.instrumentBranchCode.value;
	var instrumentSortCode = ObjForm.instrumentSortCode.value;
	var payingAcct = ObjForm.payingAcct.value;
	var tranParticular = ObjForm.tranParticular.value;
	var tranRmks = ObjForm.tranRmks.value;
	var targetZoneDate = ObjForm.targetZoneDate.value;
	var rejectReasonCode = ObjForm.rejectReasonCode.value;

	if(fnIsNull(creditEntity))
        {
                alert("Enter the Credit A/c. Entity ID");
                ObjForm.creditEntity.focus();
                return false;
        }
	if(fnIsNull(crAcctNum))
        {
                alert("Enter the Credit Account ID");
                ObjForm.crAcctNum.focus();
                return false;
        }
	if(fnIsNull(instrumentEntity))
        {
                alert("Enter the Instrument Entity ID");
                ObjForm.instrumentEntity.focus();
                return false;
        }
	if(fnIsNull(instrumentAmt))
        {
                alert("Enter the Instrument Amount");
                ObjForm.instrumentAmt.focus();
                return false;
        }
	if(fnIsNull(instrumentDate))
        {
                alert("Enter the Instrument Date");
                ObjForm.instrumentDate_ui.focus();
                return false;
        }
	if(fnIsNull(instrumentAlpha))
        {
                //alert("Enter the Instrument Alpha");
                //ObjForm.instrumentAlpha.focus();
                //return false;
        }
	if(fnIsNull(instrumentNum))
        {
                alert("Enter the Instrument Srl. No.");
                ObjForm.instrumentNum.focus();
                return false;
        }
	if(fnIsNull(valueDate))
        {
                alert("Enter the Value Date");
                ObjForm.valueDate_ui.focus();
                return false;
        }
	if(fnIsNull(instrumentBankCode))
        {
                alert("Enter the Bank Code");
                ObjForm.instrumentBankCode.focus();
                return false;
        }	
	if(fnIsNull(instrumentBranchCode))
        {
                alert("Enter the Branch Code");
                ObjForm.instrumentBranchCode.focus();
                return false;
        }
	if(fnIsNull(instrumentSortCode))
        {
                alert("Enter the Sort Code");
                ObjForm.instrumentSortCode.focus();
                return false;
        }
	if(fnIsNull(targetZoneDate))
        {
                alert("Enter the Target Zone Date");
                ObjForm.targetZoneDate_ui.focus();
                return false;
        }
	if(fnIsNull(payingAcct))
        {
                alert("Enter the Paying Account ID");
                ObjForm.payingAcct.focus();
                return false;
        }
        if(billPayYes!="Y")
        {
		if(fnIsNull(tranParticular))
		{
			alert("Enter the Transaction Particulars");
			ObjForm.tranParticular.focus();
			return false;
		}
		if(fnIsNull(tranRmks))
		{
			alert("Enter the Transaction Remarks");
			ObjForm.tranRmks.focus();
			return false;
		}
        }
	if(funcCode == "O"){
		if(fnIsNull(rejectReasonCode))
        	{
	                alert("Enter the Reject Reason");
	                ObjForm.rejectReasonCode.focus();
	                return false;
	        }
	}

	if (!fnValidatePayingAcct())
        {
                return false;
        }

	if (!fnCheckMandatoryFields())
	{
		return false;
	}
	return true;
}

function fnValidatePayingAcct(){
        var ObjForm = document.forms[0];
        var instrumentEntity = ObjForm.instrumentEntity.value;
	var instrumentBankCode = ObjForm.instrumentBankCode.value;
	var instrumentBranchCode = ObjForm.instrumentBranchCode.value;
	var payingAcct = ObjForm.payingAcct.value;

	var inputNameValues = "instrumentEntity|"+instrumentEntity+"|instrumentBankCode|"+instrumentBankCode+"|instrumentBranchCode|"+instrumentBranchCode+"|payingAcct|"+payingAcct;
	var outputNames = "errorFlg|errorMsg|payingAcct";
	var scriptName = "cieclgdp007.scr"
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	var token = retVal.split("|");
	if(token != undefined){
		var errorFlg = token[1];
		var errorMsg = token[3];
		var payingAcct = token[5];

		if(errorFlg == "Y"){
			alert(errorMsg);
			setFieldFocus(ObjForm.payingAcct);
			return false;
		}else{
			//ObjForm.payingAcct.value = payingAcct;
		}
        }
        return true;

}

function getAcctIdList() {
        var ObjForm = document.forms[0];
        var creditEntity = ObjForm.creditEntity.value;
        if(fnIsNull(creditEntity)){
                alert("Enter the Credit A/c. Entity ID to search for Credit Account ID");
                ObjForm.creditEntity.focus();
        }else{
                cust_showAccountIdList(ObjForm.crAcctNum,null,null,'F');
        }

        var crAcctNum = ObjForm.crAcctNum.value;
        if(!fnIsNull(crAcctNum)){
                fnGetAcctDetails();
        }
}

function showEntityList(){
	var inputNameValues = "creditEntity| "
        var outputNameValues = "creditEntity|creditEntityDesc|creditEntityHomeCcy";
        var scriptName = "cieclgdp027.scr";
        var listHeading = "Entity List";
        var colHeader = "Entity ID|Entity Description|Home Currency Code";
        var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
        var ObjForm = document.forms[0];
        var creditEntity = ObjForm.creditEntity.value;
        if(!fnIsNull(creditEntity)){
        	//ubp add-start
        	if((billPayYes!="Y")&&(funcCode == "A"))
		{
                	ObjForm.crAcctNum.focus();
                }
                //ubp add-end
        }
}

function showEntityListForInstrument(){
        var inputNameValues = "instrumentEntity| "
        var outputNameValues = "instrumentEntity|instrumentEntityDesc|instrumentEntityHomeCcy";
        var scriptName = "cieclgdp028.scr";
        var listHeading = "Entity List";
        var colHeader = "Entity ID|Entity Description|Home Currency Code";
        var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
        var ObjForm = document.forms[0];
        var instrumentEntity = ObjForm.instrumentEntity.value;
        if(!fnIsNull(instrumentEntity)){
		fnGetChargeAmt();
                ObjForm.instrumentAmt.focus();
        }
}

function fnGetEntityDesc(){
        var ObjForm = document.forms[0];
        var creditEntity = ObjForm.creditEntity.value;

        if(fnIsNull(creditEntity)){
                ObjForm.creditEntityDesc.value = "";
        }else{
                var inputNameValues = "targetEntity|"+creditEntity;
                var outputNames = "errorFlg|errorMsg|targetEntity|targetEntityDesc";
                var scriptName = "cieclgdp018.scr"
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
                                //ubp start
                                if((billPayYes!="Y")&&(funcCode == "A"))
				{
                                	ObjForm.crAcctNum.focus();
                                }
                                 //ubp start
                        }
                }
        }
        return true;

}

function fnGetEntityDescForInstrument(){
        var ObjForm = document.forms[0];
        var instrumentEntity = ObjForm.instrumentEntity.value;

        if(fnIsNull(instrumentEntity)){
                ObjForm.instrumentEntityDesc.value = "";
		fnClearTargetZoneSolIdDetails();
        }else{
                var inputNameValues = "targetEntity|"+instrumentEntity;
                var outputNames = "errorFlg|errorMsg|targetEntity|targetEntityDesc";
                var scriptName = "cieclgdp018.scr"
                var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
                var token = retVal.split("|");
                if(token != undefined){
                        var errorFlg = token[1];
                        var errorMsg = token[3];
                        var instrumentEntity = token[5];
                        var instrumentEntityDesc = token[7];

                        if(errorFlg == "Y"){
                                alert(errorMsg);
                                setFieldFocus(ObjForm.instrumentEntity);
                                return false;
                        }else{
                                ObjForm.instrumentEntity.value = instrumentEntity;
                                ObjForm.instrumentEntityDesc.value = instrumentEntityDesc;
				if(funcCode == "A"){
					fnGetChargeAmt();
	                                ObjForm.instrumentAmt.focus();
				}
                        }
                }
        }
        return true;

}

function fnClearBankBranchCode(){
	var ObjForm = document.forms[0];
	ObjForm.instrumentBankCode.value = "";
	ObjForm.instrumentBankName.value = "";
	ObjForm.instrumentBranchCode.value = "";
	ObjForm.instrumentBranchName.value = "";
	ObjForm.instrumentSortCode.value = "";
}

function fnClearBranchSortCode(){
	var ObjForm = document.forms[0];
	ObjForm.instrumentBranchCode.value = "";
        ObjForm.instrumentBranchName.value = "";
        ObjForm.instrumentSortCode.value = "";
}

function fnGetCrAcctDetails(){
        var ObjForm = document.forms[0];
        var crAcctNum = ObjForm.crAcctNum.value;
        if(!fnIsNull(crAcctNum)){
                fnGetAcctDetails();
        }else{
                fnClearAcctDetails();
        }
        return true;
}

function fnGetAcctDetails(){
	var ObjForm = document.forms[0];
        fnEnableAcctDetails();
        var crAcctNum = ObjForm.crAcctNum.value;
        var inputNameValues = "acctNum|"+crAcctNum;
        var outputNames = "errorFlg|errorMsg|acctNumEntityId|acctNumSolId|acctNumCcy|acctName|acctNum";
        var scriptName = "cieclgdp011.scr"
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
                        fnClearAcctDetails();
                        setFieldFocus(ObjForm.crAcctNum);
                        return false;

                }else{
                        ObjForm.creditEntity.value = crAcctNumEntityId;
                        fnGetEntityDesc();
                        ObjForm.crAcctNumEntityId.value = crAcctNumEntityId;
                        ObjForm.crAcctNumSolId.value = crAcctNumSolId;
                        ObjForm.crAcctNumCcy.value = crAcctNumCcy;
                        ObjForm.crAcctName.value = crAcctName;
                        ObjForm.crAcctNum.value = crAcctNum;
                        fnDisableAcctDetails();
			if(funcCode == "A"){
                        	fnGetChargeAmt();
				ObjForm.instrumentEntity.focus();
			}
                }
        }
        return true;
}

function fnGetChargeAmt(){
        var ObjForm = document.forms[0];
        var crAcctNum = ObjForm.crAcctNum.value;
        var crAcctNumEntityId = ObjForm.crAcctNumEntityId.value;
	if(fnIsNull(crAcctNumEntityId)){
		return;
	}
	var instrumentEntity = ObjForm.instrumentEntity.value;
        var inputNameValues = "crAcctNum|"+crAcctNum+"|crAcctNumEntityId|"+crAcctNumEntityId+"|instrumentEntity|"+instrumentEntity;
        var outputNames = "errorFlg|errorMsg|chargeAmt|chargeAmtFlg|chargeAmtCcy|chargeAmtCcyFlg|chargeEventId|chargeEventIdFlg|nostroAcct|nostroAcctFlg|vostroAcct|vostroAcctFlg|targetZoneCode|targetZoneCodeFlg|targetSolId|targetSolIdFlg";
        var scriptName = "cieclgdp014.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
        if(token != undefined){
                var errorFlg = token[1];
                var errorMsg = token[3];
                var chargeAmt = token[5];
                var chargeAmtFlg = token[7];
                var chargeAmtCcy = token[9];
                var chargeAmtCcyFlg = token[11];
                var chargeEventId = token[13];
                var chargeEventIdFlg = token[15];
                var nostroAcct = token[17];
                var nostroAcctFlg = token[19];
                var vostroAcct = token[21];
                var vostroAcctFlg = token[23];
		var targetZoneCode = token[25];
		var targetZoneCodeFlg = token[27];
		var targetSolId = token[29];
                var targetSolIdFlg = token[31];

                if(errorFlg == "Y"){
                        alert(errorMsg);

                        if(chargeAmtFlg == "Y"){
                                ObjForm.chargeAmt.value = chargeAmt;
                        }else{
                                ObjForm.chargeAmt.value = "0.00"
                        }

                        if(chargeAmtCcyFlg == "Y"){
                                ObjForm.chargeAmtCcy.value = chargeAmtCcy;
                        }else{
                                ObjForm.chargeAmtCcy.value = ObjForm.crAcctNumCcy.value;
                        }

                        if(chargeEventIdFlg == "Y"){
                                ObjForm.chargeEventId.value = chargeEventId;
                        }else{
                                ObjForm.chargeEventId.value = "";
                        }

                        if(nostroAcctFlg == "Y"){
                                ObjForm.nostroAcct.value = nostroAcct;
                        }else{
                                ObjForm.nostroAcct.value = "";
                        }

                        if(vostroAcctFlg == "Y"){
                                ObjForm.vostroAcct.value = vostroAcct;
                        }else{
                                ObjForm.vostroAcct.value = "";
                        }
	
			if(targetZoneCodeFlg == "Y"){
                                ObjForm.targetZoneCode.value = targetZoneCode;
                        }else{
                                ObjForm.targetZoneCode.value = "";
                        }

			if(targetSolIdFlg == "Y"){
                                ObjForm.targetSolId.value = targetSolId;
                        }else{
                                ObjForm.targetSolId.value = "";
                        }

                        return false;

                }else{
                        ObjForm.chargeAmt.value = chargeAmt;
                        ObjForm.chargeAmtCcy.value = chargeAmtCcy;
                        ObjForm.chargeEventId.value = chargeEventId;
                        ObjForm.nostroAcct.value = nostroAcct;
                        ObjForm.vostroAcct.value = vostroAcct;
			ObjForm.targetZoneCode.value = targetZoneCode;
			ObjForm.targetSolId.value = targetSolId;
                }
        }
        return true;
}

function fnEnableAcctDetails(){
        var ObjForm = document.forms[0];
        ObjForm.crAcctNumEntityId.disabled = false;
        ObjForm.crAcctNumSolId.disabled = false;
        ObjForm.crAcctNumCcy.disabled = false;
        ObjForm.crAcctName.disabled = false;
}

function fnDisableAcctDetails(){
        var ObjForm = document.forms[0];
        ObjForm.crAcctNumEntityId.disabled = true;
        ObjForm.crAcctNumSolId.disabled = true;
        ObjForm.crAcctNumCcy.disabled = true;
        ObjForm.crAcctName.disabled = true;
}

function fnClearAcctDetails(){
        var ObjForm = document.forms[0];
        ObjForm.crAcctNumEntityId.value = "";
        ObjForm.crAcctNumSolId.value = "";
        ObjForm.crAcctNumCcy.value = "";
        ObjForm.crAcctName.value = "";
        ObjForm.chargeEventId.value = "";
        ObjForm.chargeAmt.value = "";
        ObjForm.chargeAmtCcy.value = "";
        ObjForm.nostroAcct.value = "";
        ObjForm.vostroAcct.value = "";
	ObjForm.targetZoneCode.value = "";
	ObjForm.targetSolId.value = "";
}

function fnClearTargetZoneSolIdDetails(){
        var ObjForm = document.forms[0];
        ObjForm.chargeEventId.value = "";
        ObjForm.chargeAmt.value = "";
        ObjForm.chargeAmtCcy.value = "";
        ObjForm.nostroAcct.value = "";
        ObjForm.vostroAcct.value = "";
        ObjForm.targetZoneCode.value = "";
        ObjForm.targetSolId.value = "";
}

function fnDisableAmtFields(){
	var ObjForm = document.forms[0];
	ObjForm.chargeAmt.disabled = true;
	ObjForm.chargeAmtCcy.disabled = true;
}

function fnFormatAmountField(obj){
	var p1 = removeCommas(obj.value);
	var ObjForm = document.forms[0];
	var amountFormat = "Million";
        var crncyCode = "";

	crncyCode = ObjForm.crAcctNumCcy.value;
	newformatAmt(amountFormat,obj,crncyCode,'N');	
	return true;
}

function showSortCodeList(){
	var ObjForm = document.forms[0];
	var instrumentBankCode = ObjForm.instrumentBankCode.value;
	var instrumentBranchCode = ObjForm.instrumentBranchCode.value;
	var instrumentSortCode = ObjForm.instrumentSortCode.value;
	var instrumentEntity = ObjForm.instrumentEntity.value;

	if(fnIsNull(instrumentEntity)){
		alert("Enter Instrument Entity to search for Sort Code");
		ObjForm.instrumentEntity.focus();
	}else{
		var inputNameValues = "instrumentBankCode|"+instrumentBankCode+"|instrumentBranchCode|"+instrumentBranchCode+"|instrumentSortCode|"+instrumentSortCode+"|instrumentEntity|"+instrumentEntity;
		var outputNameValues = "instrumentSortCode|instrumentBankCode|instrumentBranchCode|shortName|instrumentBranchName|delFlg";
		var scriptName = "cieclgdp029.scr";
		var listHeading = "Bank/Branch And Sort Code List";
		var colHeader = "Sort Code|Bank Code|Branch Code|Short Name|Branch Name|Del.";
		var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
		showBankCode();
	}
}

function showSortCode(){
        var ObjForm = document.forms[0];
        var instrumentBankCode = ObjForm.instrumentBankCode.value;
        var instrumentBranchCode = ObjForm.instrumentBranchCode.value;
        var instrumentSortCode = ObjForm.instrumentSortCode.value;
        var instrumentEntity = ObjForm.instrumentEntity.value;
	
	if(fnIsNull(instrumentSortCode)){
		ObjForm.instrumentSortCode.value = "";
		ObjForm.instrumentBranchCode.value = "";
		ObjForm.instrumentBranchName.value = "";
		return false;
	}

        if(fnIsNull(instrumentEntity)){
                alert("Enter Instrument Entity to search for Sort Code");
		ObjForm.instrumentSortCode.value = "";
                ObjForm.instrumentEntity.focus();
        }else{
                var inputNameValues = "instrumentBankCode|"+instrumentBankCode+"|instrumentBranchCode|"+instrumentBranchCode+"|instrumentSortCode|"+instrumentSortCode+"|instrumentEntity|"+instrumentEntity;
                var outputNames = "instrumentSortCode|instrumentBankCode|instrumentBranchCode|shortName|instrumentBranchName|delFlg";
                var scriptName = "cieclgdp032.scr";
		var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
                var token = retVal.split("|");
                if(token != undefined){
                        var errorFlg = token[1];
                        var errorMsg = token[3];
                        var instrumentSortCode = token[5];
                        var instrumentBankCode = token[7];
			var instrumentBranchCode = token[9];
			var shortName = token[11];
			var instrumentBranchName = token[13];
			var delFlg = token[15];

                        if(errorFlg == "Y"){
                                alert(errorMsg);
				ObjForm.instrumentBranchCode.value = "";
				ObjForm.instrumentBranchName.value = "";
                                setFieldFocus(ObjForm.instrumentSortCode);
                                return false;
                        }else{
                                ObjForm.instrumentBankCode.value = instrumentBankCode;
				ObjForm.instrumentBranchCode.value = instrumentBranchCode;
				ObjForm.instrumentSortCode.value = instrumentSortCode;
				ObjForm.instrumentBranchName.value = instrumentBranchName;
				showBankCode();
                        }
                }
        }
}

function showBankCodeList(){
	var ObjForm = document.forms[0];
        var instrumentBankCode = ObjForm.instrumentBankCode.value;
        var instrumentEntity = ObjForm.instrumentEntity.value;

        if(fnIsNull(instrumentEntity)){
                alert("Enter Instrument Entity to search for Bank Code");
		ObjForm.instrumentEntity.focus();
        }else{
                var inputNameValues = "instrumentBankCode|"+instrumentBankCode+"|instrumentEntity|"+instrumentEntity;
                var outputNameValues = "instrumentBankCode|shortName|instrumentBankName|delFlg";
                var scriptName = "cieclgdp030.scr";
                var listHeading = "Bank Code List";
                var colHeader = "Bank Code|Short Name|Bank Name|Del.";
                var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
        }
}

function showBankCode(){
        var ObjForm = document.forms[0];
        var instrumentBankCode = ObjForm.instrumentBankCode.value;
        var instrumentEntity = ObjForm.instrumentEntity.value;

	if(fnIsNull(instrumentBankCode)){
                ObjForm.instrumentBankCode.value = "";
                ObjForm.instrumentBankName.value = "";
                return false;
        }

	if(fnIsNull(instrumentEntity)){
		alert("Enter Instrument Entity to search for Bank Code");
                ObjForm.instrumentBankCode.value = "";
                ObjForm.instrumentBankName.value = "";
		ObjForm.instrumentEntity.focus();
                return false;
        }

        if(fnIsNull(instrumentEntity)){
                alert("Enter Instrument Entity to search for Bank Code");
                ObjForm.instrumentEntity.focus();
        }else{
                var inputNameValues = "instrumentBankCode|"+instrumentBankCode+"|instrumentEntity|"+instrumentEntity;
                var outputNames = "instrumentBankCode|shortName|instrumentBankName|delFlg";
                var scriptName = "cieclgdp033.scr";
		var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
                var token = retVal.split("|");
                if(token != undefined){
                        var errorFlg = token[1];
                        var errorMsg = token[3];
                        var instrumentBankCode = token[5];
                        var instrumentBankName = token[7];
			var delFlg = token[9];

                        if(errorFlg == "Y"){
                                alert(errorMsg);
                                ObjForm.instrumentBankName.value = "";
                                setFieldFocus(ObjForm.instrumentBankCode);
                                return false;
                        }else{
                                ObjForm.instrumentBankCode.value = instrumentBankCode;
                                ObjForm.instrumentBankName.value = instrumentBankName;
                        }
                }
        }
}

function showBranchCodeList(){
	var ObjForm = document.forms[0];
        var instrumentBankCode = ObjForm.instrumentBankCode.value;
        var instrumentBranchCode = ObjForm.instrumentBranchCode.value;
	var instrumentSortCode = ObjForm.instrumentSortCode.value;
        var instrumentEntity = ObjForm.instrumentEntity.value;

        if(fnIsNull(instrumentEntity)){
                alert("Enter Instrument Entity to search for Bank/Branch and Sort Code");
		ObjForm.instrumentEntity.focus();
        }else{
		if(fnIsNull(instrumentBankCode)){
			alert("Enter Bank Code to search for Branch Code");	
			ObjForm.instrumentBankCode.focus();
		}else{
			var inputNameValues = "instrumentBankCode|"+instrumentBankCode+"|instrumentBranchCode|"+instrumentBranchCode+"|instrumentSortCode|"+instrumentSortCode+"|instrumentEntity|"+instrumentEntity;
			var outputNameValues = "instrumentBankCode|instrumentBranchCode|shortName|instrumentBranchName|instrumentSortCode|delFlg";
			var scriptName = "cieclgdp031.scr";
			var listHeading = "Bank/Branch And Sort Code List";
			var colHeader = "Bank Code|Branch Code|Short Name|Branch Name|Sort Code|Del.";
			var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"2",true);
			showBankCode();
		}
        }
}


function showBranchCode(){
        var ObjForm = document.forms[0];
        var instrumentBankCode = ObjForm.instrumentBankCode.value;
        var instrumentBranchCode = ObjForm.instrumentBranchCode.value;
        var instrumentSortCode = ObjForm.instrumentSortCode.value;
        var instrumentEntity = ObjForm.instrumentEntity.value;

	if(fnIsNull(instrumentBranchCode)){
                ObjForm.instrumentSortCode.value = "";
                ObjForm.instrumentBranchCode.value = "";
                ObjForm.instrumentBranchName.value = "";
                return false;
        }

	if(fnIsNull(instrumentEntity)){
		alert("Enter Instrument Entity to search for Bank/Branch and Sort Code");
                ObjForm.instrumentSortCode.value = "";
                ObjForm.instrumentBranchCode.value = "";
                ObjForm.instrumentBranchName.value = "";
		ObjForm.instrumentEntity.focus();
                return false;
        }

	if(fnIsNull(instrumentBankCode)){
                alert("Enter Bank Code to search for Branch/Sort Code");
		ObjForm.instrumentBankCode.focus();
                ObjForm.instrumentSortCode.value = "";
		ObjForm.instrumentBranchCode.value = "";
                ObjForm.instrumentBranchName.value = "";
                return false;
        }

	var inputNameValues = "instrumentBankCode|"+instrumentBankCode+"|instrumentBranchCode|"+instrumentBranchCode+"|instrumentSortCode|"+instrumentSortCode+"|instrumentEntity|"+instrumentEntity;
	var outputNames = "instrumentSortCode|instrumentBankCode|instrumentBranchCode|shortName|instrumentBranchName|delFlg";
	var scriptName = "cieclgdp034.scr";
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	var token = retVal.split("|");
	if(token != undefined){
		var errorFlg = token[1];
		var errorMsg = token[3];
		var instrumentBankCode = token[5];
		var instrumentBranchCode = token[7];
		var shortName = token[9];
		var instrumentBranchName = token[11];
		var instrumentSortCode = token[13];
		var delFlg = token[15];

		if(errorFlg == "Y"){
			alert(errorMsg);
			ObjForm.instrumentBranchName.value = "";
			setFieldFocus(ObjForm.instrumentBranchCode);
			return false;
		}else{
			ObjForm.instrumentBankCode.value = instrumentBankCode;
			ObjForm.instrumentBranchCode.value = instrumentBranchCode;
			ObjForm.instrumentSortCode.value = instrumentSortCode;
			ObjForm.instrumentBranchName.value = instrumentBranchName;
			showBankCode();
		}
        }
}

function showRejectReasonCodeList(){
	showRejReasonList(document.forms[0].rejectReasonCode,document.forms[0].rejectReasonCodeDesc,'F');

}

function fnGetRejectReasonCodeDesc(){
	var ObjForm = document.forms[0];
	var rejectReasonCode = ObjForm.rejectReasonCode.value;
	if(fnIsNull(rejectReasonCode)){
		ObjForm.rejectReasonCodeDesc.value = "";
		return false;
	}
	var inputNameValues = "rejectReasonCode|"+rejectReasonCode;
	var outputNames = "errorFlg|errorMsg|rejectReasonCode|rejectReasonCodeDesc";
	var scriptName = "cieclgdp026.scr"
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	var token = retVal.split("|");
	if(token != undefined){
        	var errorFlg = token[1];
	        var errorMsg = token[3];
	        var rejectReasonCode = token[5];
	        var rejectReasonCodeDesc = token[7];

	        if(errorFlg == "Y"){
	                alert(errorMsg);
	                setFieldFocus(ObjForm.rejectReasonCode);
	                return false;
	        }else{
	                ObjForm.rejectReasonCode.value = rejectReasonCode;
	                ObjForm.rejectReasonCodeDesc.value = rejectReasonCodeDesc;
        	}
	}
}

function fnExplodeBalanceDetails(obj){
    var ObjForm = document.forms[0];
    var acctId = obj.value;
    var sUrl = "";
    var urlData = "";
    if(!fnIsNull(acctId)){
	var entityId = ObjForm.crAcctNumEntityId.value;
        var inputNameValues = "acctId|"+acctId+"|entityId|"+entityId;
        var outputNames = "errorFlg|errorMsg|acctId|solId|crncyCode|acctName|ledgerBal|availableBal|effAvailableBal|freezeStatus|freezeReasonCode|acctClosed|shadowBal|acctStatus";
        var scriptName = "cieclgdp013.scr"
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

                if(errorFlg == "Y"){
                        alert(errorMsg);
                        setFieldFocus(obj);
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
			urlData+= "&entityId="+document.forms[0].crAcctNumEntityId.value;
			//alert(urlData);	
                }
        }
	
        var sUrl = "../custom/jsp/cieclg_acctBal.jsp?";
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
		alert("Enter the Credit Account ID");
    }
}


function fnShowZoneCode(obj1,obj2,sol) {
	showZoneCode(obj1,obj2,sol,"F");
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
	
		fnRemoveCommas();
		//UBP Clearing--START
		//xyz
		var ObjForm = document.forms[0];
		var tranParticular = ObjForm.tranParticular.value;
		var tranRmks = ObjForm.tranRmks.value;
		if ((funcCode == "A")&&(billPayYes=="Y"))
		{
			var ObjForm = document.forms[0];
			var billRefNum=ObjForm.billRefNum.value.toUpperCase();
			var refNumHidden=ObjForm.refNumHidden.value.toUpperCase();
			if(buttonFlg=="N")
			{
				alert("PLease Click Get Bill Details button");
				return false;
			}

			if((refNumHidden!=billRefNum) && (billerId!="IPO"))
			{
				buttonFlg="N";
				alert("RefNum has been changed.PLease click on Get Bill Details button.");
				ObjForm.name.value="";
				ObjForm.tranRmks.value="";
				insertTableFlg="Y";
				//ObjForm.name.disabled=true;
				return false;
			}
			if(insertTableFlg =="N")
			{
				alert("As the Validation failed ,so cannot Submit");
				return false;
			}

			//alert("refNumHidden"+refNumHidden);
			//alert("billRefNum"+billRefNum);
					
					
		}
		if(fnIsNull(tranParticular))
		{
			alert("Enter the Transaction Particulars");
			ObjForm.tranParticular.focus();
			return false;
		}
		if(fnIsNull(tranRmks))
		{
			alert("Enter the Transaction Remarks");
			ObjForm.tranRmks.focus();
			return false;
		}
		//UBP Clearing--END
		doSubmit(btnObj.id);
	}
}

function fnRemoveCommas(){
        var ObjForm = document.forms[0];

        var instrumentAmt = ObjForm.instrumentAmt.value;
        instrumentAmt = removeCommas(instrumentAmt);
        ObjForm.instrumentAmt.value = instrumentAmt;

        var chargeAmt = ObjForm.chargeAmt.value;
        chargeAmt = removeCommas(chargeAmt);
        ObjForm.chargeAmt.value = chargeAmt;
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
		case 'D': return "Delete";
		case 'G': return "Regularize";
		case 'I': return "Inquire";
		case 'M': return "Modify";
		case 'R': return "Release";
		case 'V': return "Verify";
		case 'O': return "Outward Reject";
		default : return funcCode;
	}

}

function fnGetStatusCodeDesc(status){
        switch(status){
                case 'A': return "Lodged";
                case 'V': return "Lodged and Verified";
                case 'G': return "Regularized";
                case 'R': return "Released to Shadow Balance";
                case 'D': return "Deleted";
                case 'O': return "Outward Rejected";
		case 'I': return "Inward Rejected";
                default : return status;
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
        strTargetBankId = document.forms[0].creditEntity.value;
        if(defCrncyCode  == undefined){ strCrncyCode  = "";} else { strCrncyCode  = defCrncyCode;}
        if(defSchemeCode == undefined){ strSchemeCode = "";} else { strSchemeCode = defSchemeCode;}
        if(defSchemeType == undefined){ strSchemeType = "";} else { strSchemeType = defSchemeType;}
        if(defSolId      == undefined){ strSolId      = "";} else { strSolId      = defSolId;}
        if(defCifId     == undefined){ strCifId     = "";} else { strCifId     = defCifId;}
        if(searchLang     == undefined){ strsearchLang = "";} else { strsearchLang = searchLang;}
        if(defGLSubHead  == undefined){ strGLSubHead  = "";} else { strGLSubHead  = defGLSubHead;}
        if(defOwnership  == undefined){ strOwnership  = "";} else { strOwnership  = defOwnership;}
        //if(defShortName  != undefined){ strShortName  = defShortName;}
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
        }
        else
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

//Addded for UBP customization-start

//UBP Clearing-onclick of Get bill details button-START
function fnGetBillDtl()
{
	//fnValidateData();
if(fnValidateData())
{
	var ObjForm = document.forms[0];
	var billRefNum=ObjForm.billRefNum.value.toUpperCase();
	var name=ObjForm.name.value;
	//var valType=ObjForm.valType.value;
	//var critCrAcctNum= ObjForm.crAcctNum.value;
	fnRemoveCommas();
	
	if(fnIsNull(billRefNum))
	{
			alert("Please enter Bill Ref. Num.");
			ObjForm.billRefNum.focus();
			return false;
	}
	ObjForm.refNumHidden.value=billRefNum;
	
if((billerId!="IPO")&& (billerId!="KRA") && (billerId!="TURNQUEST") && (billerId!="KASNEB") && (billerId!="SAFARICOM")&& (billerId!="YU"))
{
	
	//If validation is None
	if((valType=="N"))
	{
		if(fnIsNull(name))
		{
			alert("Please enter Name");
			ObjForm.name.focus();
			return false;
		}
		var a=" ";
		//ObjForm.tranPart.value=billRefNum+a+name;
		ObjForm.tranParticular.value=billRefNum+a+name;
		
		buttonFlg="Y";
		insertTableFlg ="Y";
	}
	//Local validation
	if((valType=="L")||(valType=="LR"))
	{
		var inputNameValues = "billRefNum|"+billRefNum+"|billAcctId|"+critCrAcctNum+"|insertTableFlg|"+insertTableFlg;
		var outputNames = "errorFlg|errorMsg|namefld|insertTableFlg";
		var scriptName = "ubpdp059.scr"
		var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
		var token = retVal.split("|");
		if(token != undefined)
		{
			var errorFlg = token[1];
			var errorMsg = token[3];
			var namefld = token[5];
			insertTableFlg=token[7];
		
			if(errorFlg == "Y")
			{
				alert(errorMsg);
				buttonFlg="Y";
				insertTableFlg ="N";
				return false;
			}
			else
			{
				buttonFlg="Y";
				insertTableFlg ="Y";
				//alert(buttonFlg);
				//alert("insertTableFlg"+insertTableFlg);	
				ObjForm.name.value = namefld;
				//ObjForm.tranRem.value=billRefNum;
				ObjForm.tranRmks.value=billRefNum;
				if((valType=="LR"))
				{
					ObjForm.billRefNum.disabled = true;
				}

				
			}
		//return true;
		}
	}
	//Remote validation--start
	if((valType=="R")||(valType=="LR"))
	{
		
		if(remoteClickedButton=="Y")
		{
			alert("Remote Validation already done!");
			return false;
		}
		
		var inputNameValues = "billRefNum|"+billRefNum+"|billAcctId|"+critCrAcctNum+"|billerId|"+billerId+"|billAmt|"+ObjForm.instrumentAmt.value+"|insertTableFlg|"+insertTableFlg+"|typOfServ|"+typOfServ+"|refCrncy|"+zoneCcy;
		var outputNames = "errorFlg|errorMsg|valSuccMsg|insertTableFlg|remTranPart|remName|remtranRem|retStrngVal";
		var scriptName = "ubpdp060.scr"
		var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
		var token = retVal.split("|");
		if(token != undefined)
		{
			//alert(retVal);
			var errorFlg = token[1];
			var errorMsg = token[3];
			var valSuccMsg = token[5];
			insertTableFlg=token[7];
			var remTranPart=token[9];
			var remName=token[11];
			var remtranRem=token[13];
			var retStrngVal=token[15];
			if(errorFlg == "Y")
			{
				alert(errorMsg);
				insertTableFlg ="N";
				buttonFlg="Y";
				return false;
			}
			else
			{
				buttonFlg="Y";
				var a=" ";
				
				remoteClickedButton="Y";
				ObjForm.retStrngValHid.value=retStrngVal;
				//alert("retStrngValHid value"+ObjForm.retStrngValHid.value);
				//ObjForm.tranPart.value = tranPart+a+ remTranPart;
				//ObjForm.name.value = ObjForm.name.value+a+ remName;
				if(ObjForm.name.value!="")
				{
					ObjForm.name.value=ObjForm.name.value+"/"+remName;
				}
				else
				{
					ObjForm.name.value = remName;
				}
				
				//ObjForm.tranRem.value =remtranRem;
				ObjForm.tranRmks.value =remtranRem;
				/*if(billerId=="MARA")
				{
					ObjForm.maraUpDate.value=errorFlg;
				}*/
				insertTableFlg ="Y";
				if(retStrngVal!="")
				{
					var fieldListStr=retStrngVal;
					var fieldList = fieldListStr.split(',');
					var len = fieldListStr.length;
					//alert("tot : " +fieldList.length);
					//alert("Field 1 : "+fieldList[0]);
					for (var i = 0; i < fieldList.length; i++) 
					{
						//alert("Record : " + i);
						var fieldDtls = fieldList[i].split('!');
					    for (var n = 0; n < 1; n++) 
					    {
					    	
						   // alert("fieldDtls[n]"+fieldDtls[n]);
							//alert("fieldDtls[n+1]"+fieldDtls[n+1]);
							//alert("fieldDtls[n+2]"+fieldDtls[n+2]);
							//alert("fieldDtls[n+3]"+fieldDtls[n+3]);
							//label display
							var lblElement = document.createElement("td");
							lblElement.setAttribute("class","textlabel");
							lblElement.setAttribute("type", "textlabel");
							lblElement.setAttribute("style", "height: 200px");
							//lblElement.setAttribute("border", "3px solid #FF0000");
							
							//lblElement.setAttribute("style", "borderColor=red");
							//document.getElementById(controlID).style.borderColor="red";

							//lblElement.setAttribute("value", fieldDtls[n+1]);
							//lblElement.setAttribute("type", "text");
							//lblElement.setAttribute("name",fieldDtls[n]);
							//lblElement.setAttribute("id",fieldDtls[n]);
							if(i>=0)
							{
								var br = document.createElement("br");
								lblElement.innerHTML=br;
								lblElement.innerHTML=br;
								lblElement.innerHTML=br;
								lblElement.innerHTML=br;
								lblElement.innerHTML=br;
								lblElement.innerHTML=br;
							}
							lblElement.innerHTML=fieldDtls[n+1];
							
							if((i%2==0))
							{
									
									var hidden1 = document.getElementById("DisplayField1"); 
									hidden1.parentNode.appendChild(lblElement);

							}
							else
							{
								var hidden1 = document.getElementById("DisplayField3"); 
								hidden1.parentNode.appendChild(lblElement);
							}
							//field display

							var newElement = document.createElement("td");
							newElement.setAttribute("type","textlabel");
							newElement.setAttribute("class","textlabel");
							newElement.setAttribute("style", "height: 200px");
							//var newElement = document.createElement("input");
							//newElement.setAttribute("type",fieldDtls[n+2]);
							//newElement.setAttribute("name",fieldDtls[n]);
							//newElement.setAttribute("class","textfield");
							//newElement.setAttribute("id",fieldDtls[n]);
							//newElement.setAttribute("size","60");
							//newElement.setAttribute("value", fieldDtls[n+3]);
							if(i>=0)
							{
								//alert("inside br"+i);
								var br = document.createElement("br");
								newElement.innerHTML=br;
								newElement.innerHTML=br;
								newElement.innerHTML=br;
								newElement.innerHTML=br;
								newElement.innerHTML=br;
								newElement.innerHTML=br;
							}
							newElement.innerHTML=fieldDtls[n+3];
							if((i%2==0))
							{
								
									var hidden = document.getElementById("DisplayField2"); 
									hidden.parentNode.appendChild(newElement);

							}
							else
							{
								var hidden = document.getElementById("DisplayField4"); 
								hidden.parentNode.appendChild(newElement);
							}
							
					     }
	
					}
				}
				if((valType=="LR")||(valType=="R"))
				{
					ObjForm.billRefNum.disabled = true;
				}
				//ObjForm.tranRem.value=remtranRem;
				ObjForm.tranRmks.value=remtranRem;
				alert(valSuccMsg);
			}
		//return true;
		}
	}
	
	//Remote validation-ends
//END OF IF SPECICIAL CASES	
}
if((billerId=="IPO"))
{
	if(valType=="R")
	{
	fnOnbuttonClickValidateIPO();
	}
}
if((billerId=="KRA"))
{
	if(valType=="R")
	{
	fnOnbuttonClickValidateKRA();
	}
}
if((billerId=="SAFARICOM"))
{
	if(valType=="R")
	{
		fnOnbuttonClickValidateSaf();
	}
}
if((billerId=="YU"))
{
	if(valType=="R")
	{
		fnOnbuttonClickValidateYu();
	}
}
if((billerId=="KASNEB"))
{
	if(valType=="N")
	{
	fnOnbuttonClickValidateKasneb();
	}
}
if((billerId=="TURNQUEST"))
{
	if(valType=="R")
	{
	fnOnbuttonClickValidateTurnquest();
	}
}
}
}



function fnOnbuttonClickValidateIPO()
{
	var ObjForm = document.forms[0];
	var billRefNum=ObjForm.billRefNum.value;
	//var billAmt=ObjForm.billAmt.value;
	var appCatgry=ObjForm.appCatgry.value;
	
	if(fnIsNull(billRefNum))
	{
		alert("Please enter Ref. Num");
		ObjForm.billRefNum.focus();
		return false;
	}
	if(appCatgry=="")
	{
		alert("Please enter Applicant Category");
		ObjForm.appCatgry.focus();
		return false;
	}
	var inputNameValues = "billRefNum|"+billRefNum+"|billerId|"+billerId+"|billAmt|"+ObjForm.instrumentAmt.value+"|billAcctId|"+critCrAcctNum+"|appCatgry|"+appCatgry;
	var outputNames = "errorFlg|errorMsg|billRefNum|name";
	var scriptName = "ubpdp029.scr"
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	var token = retVal.split("|");
	if(token != undefined)
	{
		var errorFlg = token[1];
		var errorMsg = token[3];
		var billRefNum = token[5];
		var name = token[7];
		if(errorFlg == "Y")
		{
			alert(errorMsg);
			insertTableFlg ="N";
			buttonFlg="Y";
			return false;
		}
		else
		{
			buttonFlg="Y";
			var a=" ";
			ObjForm.name.value=name;
			ObjForm.billRefNum.value=billRefNum;
			//ObjForm.tranPart.value=billRefNum+a+name;
			ObjForm.tranParticular.value=billRefNum+a+name;
			
			ObjForm.billRefNum.disabled = true;
			insertTableFlg ="Y";
		}
		
	}
	buttonFlg="Y";
	//return true;
}

function fnOnbuttonClickValidateKRA()
{
	var ObjForm = document.forms[0];
	var billRefNum=ObjForm.billRefNum.value;
	
	if(fnIsNull(billRefNum))
	{
		alert("Please enter Ref. Num");
		ObjForm.billRefNum.focus();
		return false;
	}
if(valType="R")
{
	var inputNameValues = "billRefNum|"+billRefNum+"|billerId|"+billerId+"|billAmt|"+ObjForm.instrumentAmt.value;
	var outputNames = "errorFlg|errorMsg|departCode|docRefNum|regionCode|slipPayCode|stationCode|sysCode";
	var scriptName = "ubpdp030.scr"
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	var token = retVal.split("|");
	if(token != undefined)
	{
		var errorFlg = token[1];
		var errorMsg = token[3];
		var departCode = token[5];
		var docRefNum = token[7];
		var regionCode = token[9];
		var slipPayCode = token[11];
		var stationCode = token[13];
		var sysCode = token[15];
		
		if(errorFlg == "Y")
		{
			alert(errorMsg);
			insertTableFlg ="N";
			buttonFlg="Y";
			return false;
		}
		else
		{
			buttonFlg="Y";
			insertTableFlg ="Y";
			var a=" ";
			ObjForm.freetext2.value=departCode;
			ObjForm.freetext3.value=docRefNum;
			ObjForm.freetext4.value=regionCode;
			ObjForm.freetext5.value=slipPayCode;
			ObjForm.freetext6.value=stationCode;
			ObjForm.freetext7.value=sysCode;
			//ObjForm.tranPart.value=docRefNum+a+slipPayCode;
			ObjForm.tranParticular.value=docRefNum+a+slipPayCode;
			
			
			ObjForm.billRefNum.disabled = true;
			ObjForm.name.disabled = true;
			
		}
		//return true;
	}
	//return true;
}
else
{
	buttonFlg="Y";
}
}

function fnOnbuttonClickValidateSaf()
{
	var ObjForm = document.forms[0];
	var billRefNum=ObjForm.billRefNum.value;
	
	if(fnIsNull(billRefNum))
	{
		alert("Please enter Ref. Num");
		ObjForm.billRefNum.focus();
		return false;
	}
	var inputNameValues = "billRefNum|"+billRefNum+"|billerId|"+billerId+"|billAmt|"+ObjForm.instrumentAmt.value+"|billAcctId|"+critCrAcctNum;
	var outputNames = "errorFlg|errorMsg|particulars|name";
	var scriptName = "ubpdp032.scr"
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	var token = retVal.split("|");
	if(token != undefined)
	{
		var errorFlg = token[1];
		var errorMsg = token[3];
		var particulars = token[5];
		var name = token[7];
		if(errorFlg == "Y")
		{
			alert(errorMsg);
			insertTableFlg ="N";
			buttonFlg="Y";
			return false;
		}
		else
		{
			//alert("SUCCESS");
			buttonFlg="Y";

			//ObjForm.tranPart.value=particulars;
			ObjForm.tranParticular.value=particulars;
			
			ObjForm.name.value=name;
			ObjForm.billRefNum.disabled = true;
			ObjForm.name.disabled = true;
			insertTableFlg ="Y";
							
		}

	}
}

function fnOnbuttonClickValidateYu()
{
	var ObjForm = document.forms[0];
	var billRefNum=ObjForm.billRefNum.value;
	if(fnIsNull(billRefNum))
	{
		alert("Please enter Ref. Num");
		ObjForm.billRefNum.focus();
		return false;
	}	
	 if ((retVal =  isNumeric(billRefNum)) == false) 
	 {
         ObjForm.billRefNum.focus();
         return false;
	 }
	if((billRefNum.length < 10)|| (billRefNum.length > 12))
	
	{
			 alert("Length cannot be less than 10 digits or greater than 12 digits");
			 ObjForm.billRefNum.focus();
             return false;
	}
	if(valType=="R")
	{
	var inputNameValues = "billRefNum|"+billRefNum+"|billerId|"+billerId+"|billAmt|"+ObjForm.instrumentAmt.value+"|billAcctId|"+critCrAcctNum;
	var outputNames = "errorFlg|errorMsg|particulars|name";
	var scriptName = "ubpdp038.scr"
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	var token = retVal.split("|");
	if(token != undefined)
	{
		var errorFlg = token[1];
		var errorMsg = token[3];
		var particulars = token[5];
		var name = token[7];
		if(errorFlg == "Y")
		{
			alert(errorMsg);
			insertTableFlg ="N";
			buttonFlg="Y";
			return false;
		}
		else
		{
			//alert("SUCCESS");
			buttonFlg="Y";
			//ObjForm.tranPart.value=particulars;
			ObjForm.tranParticular.value=particulars;
			
			ObjForm.name.value=name;
			ObjForm.billRefNum.disabled = true;
			ObjForm.name.disabled = true;
			insertTableFlg ="Y";
							
		}

	}
	//buttonFlg="Y";
	}
	else
	{
		buttonFlg="Y";
	}

}

function isNumeric(str)
{
	for (i=0; i<str.length; i++)
	{
		var validChars = "0123456789";
		if((validChars.indexOf(str.charAt(i)) == -1))
		{
			alert("Please enter only Numeric values");
			return false;
		}
	}
	    return true;
}

function fnBlurPayRef()
{
	if(billerId=="KASNEB")
	{
	//alert("on blur pay ref");
		var ObjForm = document.forms[0];
		var freetext1 = ObjForm.freetext1.value.toUpperCase();
		if(fnIsNull(freetext1))
		{
			ObjForm.refDesc.disabled = true;
			ObjForm.refDesc.value = "";
			return false;
		}
			//change
		var inputNameValues = "freetext1|"+freetext1;
		var outputNames = "errorFlg|errorMsg|refDesc";
		var scriptName = "ubpdp043.scr"
		var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
		var token = retVal.split("|");
		if(token != undefined)
		{
				var errorFlg = token[1];
				var errorMsg = token[3];
				var refDesc = token[5];
		
				if(errorFlg == "Y")
				{
					alert(errorMsg);
					ObjForm.refDesc.value = "";
					ObjForm.freetext1.focus();

					return false;
				}
				else
				{
					ObjForm.refDesc.value = refDesc;
				}
		//return true;
		//}

		}
	}
}

function fnChangePayRef()
{
	if(billerId=="KASNEB")
	{
		var ObjForm = document.forms[0];
		var freetext1 = ObjForm.freetext1.value;
		if(fnIsNull(freetext1))
		{
			ObjForm.refDesc.disabled = true;
			ObjForm.refDesc.value = "";
			return false;
		}
	}
}

function fnPayForRefCode()
{
	var ObjForm = document.forms[0];
	var freetext1 = ObjForm.freetext1.value;
	var inputNameValues = "freetext1|"+freetext1;
	var outputNameValues = "freetext1|refDesc|bankId";
	var scriptName = "ubpdp024.scr";
	var listHeading = "Ref Code";
	var colHeader = "Ref Code|Ref Desc|Bank ID";
	var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
}

function fnOnbuttonClickValidateKasneb()
{
	var ObjForm = document.forms[0];
	var freetext1 = ObjForm.freetext1.value;
	var freetext2 = ObjForm.freetext2.value;
	var refDesc1=ObjForm.refDesc.value;
	if(fnIsNull(freetext1))
	{
			alert("Enter the Payments For");
			ObjForm.freetext1.focus();
			return false;
    }
	if(fnIsNull(freetext2))
	{
			alert("Enter the Kasneb Form Serial number");
			ObjForm.freetext2.focus();
			return false;
    }
	var a=" / ";
	//ObjForm.tranPart.value = freetext2+a+freetext1+a+refDesc1;
	ObjForm.tranParticular.value = freetext2+a+freetext1+a+refDesc1;
	
	

	buttonFlg="Y";
}

function fnRiskNote()
{
	var ObjForm = document.forms[0];
	var value1=document.forms[0].riskNote[1].checked;
	
	if(value1==true)
	{
		var input2="RiskNote Num";
		var output2="Cust ID";
		/*Change the value of literal using inbuilt replace function of HTML*/
		document.forms[0].innerHTML=document.forms[0].innerHTML.replace(input2,output2);
	}
	else
	{
		var input2="Cust ID";
		var output2="RiskNote Num";
		/*Change the value of literal using inbuilt replace function of HTML*/
		document.forms[0].innerHTML=document.forms[0].innerHTML.replace(input2,output2);
	}
		
}

function fnOnbuttonClickValidateTurnquest()
{
	var ObjForm = document.forms[0];
	var billRefNum=ObjForm.billRefNum.value;
	var riskNote1=ObjForm.riskNote[0].checked;
	var riskNote2=ObjForm.riskNote[1].checked;
	var riskNoteClick;
	if(fnIsNull(billRefNum))
	{
		alert("Please enter RiskNote Num/Cust ID");
		ObjForm.billRefNum.focus();
		return false;
	}
	if(riskNote1== true)
	{
		riskNoteClick="Y";
	}
	else
	{
		riskNoteClick="N";
		
	}
	if(valType=="R")
	{
		var inputNameValues = "billRefNum|"+billRefNum+"|riskNoteClick|"+riskNoteClick;
		var outputNames = "errorFlg|errorMsg|name|othername|propertyId|itemDesc";
		var scriptName = "ubpdp035.scr"
		var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
		var token = retVal.split("|");
		if(token != undefined)
		{
			var errorFlg = token[1];
			var errorMsg = token[3];
			var name = token[5];
			var othername = token[7];
			var propertyId = token[9];
			var itemDesc = token[11];
			if(errorFlg == "Y")
			{
				alert(errorMsg);
				return false;
				insertTableFlg ="N";
				buttonFlg="Y";
				
			}
			else
			{
				buttonFlg="Y";
				var a=" ";
				ObjForm.name.value = name+a+othername;
				if(riskNoteClick=="Y")
				{
					var a=" ";
					//ObjForm.tranPart.value=billRefNum+a+propertyId;
					ObjForm.tranParticular.value=billRefNum+a+propertyId;
					
				}
				else
				{
					//ObjForm.tranPart.value=billRefNum;
					ObjForm.tranParticular.value=billRefNum;
					
				}
				ObjForm.billRefNum.disabled = true;
				ObjForm.name.disabled = true;
				insertTableFlg ="Y";
				
			}
			//return true;
		}
		
		//return true;
	}
	else
	{
		buttonFlg="Y";
	}
}




function fngetDynData()
{
		var ObjForm = document.forms[0];
		var fieldListStr=ObjForm.retStrngValHid.value;
		var fieldList = fieldListStr.split(',');
		var len = fieldListStr.length;
		//alert("tot : " +fieldList.length);
		//alert("Field 1 : "+fieldList[0]);
		for (var i = 0; i < fieldList.length; i++) 
		{
			//alert("Record : " + i);
			var fieldDtls = fieldList[i].split('!');
		    for (var n = 0; n < 1; n++) 
		    {
		    	
			   // alert("fieldDtls[n]"+fieldDtls[n]);
				//alert("fieldDtls[n+1]"+fieldDtls[n+1]);
				//alert("fieldDtls[n+2]"+fieldDtls[n+2]);
				//alert("fieldDtls[n+3]"+fieldDtls[n+3]);
				//label display
				var lblElement = document.createElement("td");
				lblElement.setAttribute("class","textlabel");
				lblElement.setAttribute("type", "textlabel");
				lblElement.setAttribute("style", "height: 200px");
				//lblElement.setAttribute("border", "3px solid #FF0000");
				
				//lblElement.setAttribute("style", "borderColor=red");
				//document.getElementById(controlID).style.borderColor="red";

				//lblElement.setAttribute("value", fieldDtls[n+1]);
				//lblElement.setAttribute("type", "text");
				//lblElement.setAttribute("name",fieldDtls[n]);
				//lblElement.setAttribute("id",fieldDtls[n]);
				if(i>=0)
				{
					var br = document.createElement("br");
					lblElement.innerHTML=br;
					lblElement.innerHTML=br;
					lblElement.innerHTML=br;
					lblElement.innerHTML=br;
					lblElement.innerHTML=br;
					lblElement.innerHTML=br;
				}
				lblElement.innerHTML=fieldDtls[n+1];
				
				if((i%2==0))
				{
						
						var hidden1 = document.getElementById("DisplayField1"); 
						hidden1.parentNode.appendChild(lblElement);

				}
				else
				{
					var hidden1 = document.getElementById("DisplayField3"); 
					hidden1.parentNode.appendChild(lblElement);
				}
				//field display

				var newElement = document.createElement("td");
				newElement.setAttribute("type","textlabel");
				newElement.setAttribute("class","textlabel");
				newElement.setAttribute("style", "height: 200px");
				//var newElement = document.createElement("input");
				//newElement.setAttribute("type",fieldDtls[n+2]);
				//newElement.setAttribute("name",fieldDtls[n]);
				//newElement.setAttribute("class","textfield");
				//newElement.setAttribute("id",fieldDtls[n]);
				//newElement.setAttribute("size","60");
				//newElement.setAttribute("value", fieldDtls[n+3]);
				if(i>=0)
				{
					//alert("inside br"+i);
					var br = document.createElement("br");
					newElement.innerHTML=br;
					newElement.innerHTML=br;
					newElement.innerHTML=br;
					newElement.innerHTML=br;
					newElement.innerHTML=br;
					newElement.innerHTML=br;
				}
				newElement.innerHTML=fieldDtls[n+3];
				if((i%2==0))
				{
					
						var hidden = document.getElementById("DisplayField2"); 
						hidden.parentNode.appendChild(newElement);

				}
				else
				{
					var hidden = document.getElementById("DisplayField4"); 
					hidden.parentNode.appendChild(newElement);
				}
				
		     }

		}
}


function fnOnLoadPopDynValue()
{
	var ObjForm = document.forms[0];
	
	var inputNameValues = "setNum|"+setNum+"|billAcctId|"+critCrAcctNum+"|zoneCode|"+zoneCode+"|zoneDate|"+zoneDate;
	var outputNames = "errorFlg|errorMsg|name|billRefNum|tranPart|tranRem|remDynFld|appCatgry|freetext1|freetext2|freetext3|freetext4|freetext5|freetext6|freetext7|refDesc|riskNote";
	var scriptName = "ubpdp071.scr"
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	
	var token = retVal.split("|");
	if(token != undefined)
	{
		var errorFlg = token[1];
		var errorMsg = token[3];
		var name = token[5];
		var billRefNum = token[7];
		var tranPart = token[9];
		var tranRem = token[11];
		var remDynFld = token[13];
		var appCatgry= token[15];
		var freetext1= token[17];
		var freetext2= token[19];
		var freetext3= token[21];
		var freetext4= token[23];
		var freetext5= token[25];
		var freetext6= token[27];
		var freetext7= token[29];
		var refDesc= token[31];
		var riskNote= token[33];
		if(errorFlg == "Y")
		{
			alert(errorMsg);
			return false;
		}
		else
		{
			if(remDynFld!="NOVALUE")
			{
				ObjForm.retStrngValHid.value=remDynFld;
				fngetDynData();
			}
			if(billerId=="IPO")
			{
				ObjForm.appCatgry.value = appCatgry;
				ObjForm.appCatgry.disabled = true;
			}
			if(billerId=="KRA")
			{
				ObjForm.freetext1.value=freetext1;
				ObjForm.freetext2.value=freetext2;
				ObjForm.freetext3.value=freetext3;
				ObjForm.freetext4.value=freetext4;
				ObjForm.freetext5.value=freetext5;
				ObjForm.freetext6.value=freetext6;
				ObjForm.freetext7.value=freetext7;
				ObjForm.freetext1.disabled=true;
				ObjForm.freetext2.disabled=true;
				ObjForm.freetext3.disabled=true;
				ObjForm.freetext4.disabled=true;
				ObjForm.freetext5.disabled=true;
				ObjForm.freetext6.disabled=true;
				ObjForm.freetext7.disabled=true;
				
			}
			if((billerId=="KASNEB"))
			{
				ObjForm.freetext1.value=freetext1;
				ObjForm.freetext2.value=freetext2;
				ObjForm.freetext1.disabled=true;
				ObjForm.freetext2.disabled=true;
				ObjForm.refDesc.value = refDesc;
				hideImage("getPayFor");
				
			}
			if(billerId=="TURNQUEST")
			{
				//alert("riskNote"+riskNote);
				if(riskNote=="Y")
				{
						document.forms[0].riskNote[0].value="Y";
						document.forms[0].riskNote[0].checked=true;
						document.forms[0].riskNote[0].disabled=true;
						
				}
				else
				{
						document.forms[0].riskNote[1].value="N";
						document.forms[0].riskNote[1].checked=true;
						document.forms[0].riskNote[1].disabled=true;
						
				}
			}
			ObjForm.name.value = name;
			ObjForm.billRefNum.value=billRefNum;
			ObjForm.tranParticular.value=tranPart;
			ObjForm.tranRmks.value=tranRem;
		
			
		}
	//return true;
	}
}

//Addded for UBP customization-end
