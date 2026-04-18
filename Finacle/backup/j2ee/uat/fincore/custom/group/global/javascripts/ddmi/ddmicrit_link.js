var ADD = 'A';
var MODIFY = 'M';
var VERIFY = 'V';
var CASH = 'C';
var TRANSFER = 'T';
var BANK_INDUCED = 'BI';
var CUSTOMER_INDUCED = 'CI';
var TRANSFER_BANK_INDUCED = 'TBI';
var TRANSFER_CUSTOMER_INDUCED = 'TCI';
var err = new ErrObject("","");
var acctIndr= '';
var isOnLoad='N';
this.helpfile = "ddmicrit";


function fnOnLoad() {
	objForm = document.forms[0];
	fnPopulateControlValues();
	initFocusHandler();

	if(objForm.issDate.value =="")
	{
		objForm.issDate.value = BODDate;
	}

	/* fix under ticket id 276143 */
	if(!fnIsNull(objForm.purName.value)){
		objForm.pAcctName.value=objForm.purName.value;
	}

	//Start - Change done for FC templates
	if(templateMode == 'Y')
	{
		if (funcCode == 'C')
		{
			objForm.funcCode.value = ADD;
		}
		else
		{
			objForm.funcCode.value =  funcCode;
		}
		objForm.funcCode.disabled = true;
		objForm.tranId.readOnly = true;
		objForm.GetValueDate.disabled = true;

		if ( objForm.funcCode.value != ADD )
		{
			fnDisableFormControls(VERIFY, objForm, 23);
			fnSetPropertyValue(objForm.issDate,"readOnly",true);
			hideImage("slnk2");
			objForm.tranId.readOnly = true;
			hideImage("slnk13");
		}
		if (firstTimeAdd=='N')
		{
			objForm.Accept.focus();
		}
		else
		{
			objForm.Go.focus();
		}
	} //END - Change done for FC templates
	else
	{
		fnSetFocusOnFirstField(objForm.funcCode);
	}

	checkRadio(objForm.printInd, printInd);
	checkRadio(objForm.purType, purType);
	checkRadio(objForm.commType, commType);


	//start - Change done for FC templates
	if (objForm.funcCode.value == 'T' || templateMode == 'Y')
	{

		if(fcPurTranType == "T" && fcPurTranSubType == "BI")
		{
			var purRadioVal = TRANSFER_BANK_INDUCED;
		}
		else if (fcPurTranType == "T" && fcPurTranSubType == "CI")
		{
			var purRadioVal = TRANSFER_CUSTOMER_INDUCED;
		}
		else if (fcPurTranType == "C")
		{
			var purRadioVal = CASH;
		}
		checkRadio(objForm.purType,purRadioVal);

		if(fcCommTranType == "T" && fcCommTranSubType == "BI")
		{
			var commRadioVal = TRANSFER_BANK_INDUCED;
		}
		else if (fcCommTranType == "T" && fcCommTranSubType == "CI")
		{
			var commRadioVal = TRANSFER_CUSTOMER_INDUCED;
		}
		else if (fcCommTranType == "C")
		{
			var commRadioVal = CASH;
		}
		checkRadio(objForm.commType,commRadioVal);

	}
	//END - Change done for FC templates

	if (firstTimeAdd != 'N')	{
		objForm.GetValueDate.disabled = true;
	}
	isOnLoad='Y';
	/*Function manageFuncCode called in onLoad function and also onChange of the function code	*/
	manageFuncCode();
	isOnLoad='N';


	if(!(fnIsNull(objForm.funcCode.value)))
	{
		if((fnIsNull(objForm.commCrncyCode.value)) && (fnIsNull(objForm.commAcctId.value)))
			objForm.purChqAlpha.focus();

		if(!(fnIsNull(objForm.commAcctId.value)) && (objForm.commType.value != CASH))
			objForm.commChqAlpha.focus();

	}

	if(!(fnIsNull(objForm.purAcctId.value)))
	{
		if(fnIsNull(objForm.purAddrLine1.value))
			objForm.purAddrLine1.focus();
	}


	if (firstTimeAdd == 'N') {
		fnDisableFormControls(VERIFY, objForm, 23);
		objForm.purRateCode.readOnly = false;
		showImage("sLnk14");
		objForm.purRate.readOnly = false;
		objForm.purTreaRate.readOnly = false;
		objForm.purTreaRefNum.readOnly = false;
		objForm.commRateCode.readOnly = false;
		showImage("sLnk15");
		objForm.commRate.readOnly = false;
		objForm.commTreaRate.readOnly = false;
		objForm.commTreaRefNum.readOnly = false;
	}
	if ((ddAcctCrncy == purCrncyCode) && (objForm.purRate != undefined)) {
		objForm.purRateCode.readOnly = true;
		hideImage("sLnk14");
		objForm.purRate.readOnly = true;
		objForm.purTreaRate.readOnly = true;
		objForm.purTreaRefNum.readOnly = true;
	}
	if ((commCrCrncy == commCrncyCode) && (objForm.commRate != undefined)) {
		objForm.commRateCode.readOnly = true;
		hideImage("sLnk15");
		objForm.commRate.readOnly = true;
		objForm.commTreaRate.readOnly = true;
		objForm.commTreaRefNum.readOnly = true;
	}
	if(null != objForm.FetchPurCheque){
		objForm.FetchPurCheque.disabled = true;
	}
	if(null != objForm.FetchPurCard){
		objForm.FetchPurCard.disabled = true;
	}
	if(null != objForm.FetchCommCheque){
		objForm.FetchCommCheque.disabled = true;
	}
	if(null != objForm.FetchCommCard){
		objForm.FetchCommCard.disabled = true;
	}


}

function fnDisableFormFields()
{
	disableFields("funcCode","tranId","issDate","refNum","valueDate","ddTemplateId","printInd","ddAcctId","ddRptCode","purType","purAcctId","purCrncyCode","purName","purAddrLine1","purAddrLine2","purAddrLine3","purCityCode","purStateCode","purCntryCode","purPostalCode","purPhNum","purTelexNum","purFaxNum","purEmailId","purChqAlpha","purChqNum","purChqDate","purRptCode","purPstInd","commType","commAcctId","commCrncyCode","commChqAlpha","commChqNum","commChqDate","commRptCode");
}

function fnOnButtonClick(objBtn){

	if(objBtn.id == 'Clear' || objBtn.id == 'Cancel'){
		if(confirm(finbranchResArr.get("FAT000360"))){
			objForm.actionCode.value = objBtn.id;
			fnDisableFormFields();
			formReset(objForm);
			objForm.submit();
			return ;
		}
	} else {
		if(objBtn.id == 'GetValueDate')
		{
			if (fnIsNull(objForm.ddAcctId.value) && templateMode != 'Y')
			{
				alert(finbranchResArr.get("FAT000200"));	
				objForm.ddAcctId.focus();
				return;
			}
			objForm.actionCode.value = objBtn.id;
			fnEnableDescFields(objForm);
			objForm.submit();
			return;
		}

		// FC template code change
		if(objBtn.id == 'Go')
		{
			if (objForm.funcCode.value == 'T')
			{
				if (fnIsNull(objForm.ddTemplateId.value))
				{
					alert(finbranchResArr.get("FAT000200"));
					objForm.ddTemplateId.focus();
					return false;
				}
			}
		}

		if(templateMode != 'Y' && !fnValidateForm()) return false;
		// end FC template code change

		objForm.actionCode.value = objBtn.id;
		convertToCaps();
		disableButtons();
		disableHyperLnks(20);
		fnEnableDescFields(objForm);

		objForm.submit();

		return;
	}
}
function fnValidateForm() {
	objForm = document.forms[0];
	if((objForm.funcCode.value == ADD || objForm.funcCode.value == 'T')&& (fnIsNull(objForm.valueDate.value)))
	{
		alert(finbranchResArr.get("FAT000200"));
		fnSetFocusForDate(objForm.valueDate);
		return false;
	}
	if (fnIsNull(objForm.funcCode.value)) {
		alert(finbranchResArr.get("FAT000924"));
		objForm.funcCode.focus();
		return false;
	}
	if (!validateTypes(objForm)) {
		return false;
	}
	if (objForm.funcCode.value == ADD || objForm.funcCode.value == 'T') {   // FC template code change
		if (templateMode != 'Y' && !fnValidateMandatoryFields()) {
			return false;
		}
		if ((objForm.purTranType.value == TRANSFER) && (fnIsNull(objForm.purAcctId.value))) {
			alert(finbranchResArr.get("FAT000924"));
			objForm.purAcctId.focus();
			return false;
		}
		if ((objForm.purTranType.value == CASH) && (fnIsNull(objForm.purCrncyCode.value))) {
			alert(finbranchResArr.get("FAT000924"));
			objForm.purCrncyCode.focus();
			return false;
		}
		if ((objForm.purTranType.value == CASH) && (fnIsNull(objForm.purName.value))) {
			alert(finbranchResArr.get("FAT000924"));
			objForm.purName.focus();
			return false;
		}

		if ((objForm.commTranType.value == TRANSFER) && (fnIsNull(objForm.commAcctId.value))) {
			alert(finbranchResArr.get("FAT000924"));
			objForm.commAcctId.focus();
			return	 false;
		}
		if ((objForm.commTranType.value == CASH) && (fnIsNull(objForm.commCrncyCode.value))) {
			alert(finbranchResArr.get("FAT000924"));
			objForm.commCrncyCode.focus();
			return false;
		}

		/*
		   if (firstTimeAdd == 'N') {
		   if (getValInFloat(objForm.purTreaRate.value) <= 0) {
		   alert(finbranchResArr.get("FAT000355"));
		   objForm.purTreaRate.focus();
		   return false;
		   }
		   if (getValInFloat(objForm.commTreaRate.value) <= 0) {
		   alert(finbranchResArr.get("FAT000355"));
		   objForm.commTreaRate.focus();
		   return false;
		   }
		   }
		 */


		if(objForm.purPstInd.value.length > 2)
		{
			alert(finbranchResArr.get("FAT000600"));
			objForm.purPstInd.focus();
			return false;
		}
	} else {
		if (fnIsNull(objForm.tranId.value)) {
			alert(finbranchResArr.get("FAT000924"));
			objForm.tranId.focus();
			return false;
		}
		if (fnIsNull(objForm.issDate.value)) {
			alert(finbranchResArr.get("FAT000924"));
			fnSetFocusForDate(objForm.issDate);
			return false;
		}
	}
	if (objForm.purTranType.value == TRANSFER) {
		if ((!fnIsNull(objForm.purChqAlpha.value)) && (fnIsNull(objForm.purChqNum.value))) {
			alert(finbranchResArr.get("FAT000924"));
			objForm.purChqNum.focus();
			return false;
		}
		if ((!fnIsNull(objForm.purChqNum.value)) && (fnIsNull(objForm.purChqDate.value))) {
			alert(finbranchResArr.get("FAT000924"));
			fnSetFocusForDate(objForm.purChqDate);
			return false;
		}
		if ((!fnIsNull(objForm.purChqDate.value)) && (fnIsNull(objForm.purChqNum.value))) {
			alert(finbranchResArr.get("FAT000924"));
			objForm.purChqNum.focus();
			return false;
		}
		if ((!fnIsNull(objForm.commChqAlpha.value)) && (fnIsNull(objForm.commChqNum.value))) {
			alert(finbranchResArr.get("FAT000924"));
			objForm.commChqNum.focus();
			return false;
		}
		if ((!fnIsNull(objForm.commChqNum.value)) && (fnIsNull(objForm.commChqDate.value))) {
			alert(finbranchResArr.get("FAT000924"));
			fnSetFocusForDate(objForm.commChqDate);
			return false;
		}
		if ((!fnIsNull(objForm.commChqDate.value)) && (fnIsNull(objForm.commChqNum.value))) {
			alert(finbranchResArr.get("FAT000924"));
			objForm.commChqNum.focus();
			return false;
		}
	}

	purType = getRadioValue(objForm.purType);
	commType = getRadioValue(objForm.commType);
	if ((purType != CASH) && (commType != CASH) && (purType != commType)) {
		alert(finbranchResArr.get("FAT000427"));
		return false;
	}

	return true;
}

function manageFuncCode() {

	objForm.ddTemplateId.value = ddTemplateId;

	if (objForm.funcCode.value == ADD || objForm.funcCode.value == 'T')
	{
		if(objForm.valueDate.value =="")
		{
			objForm.valueDate.value = BODDate;
		}
		if (objForm.funcCode.value == 'T')
		{
			objForm.ddTemplateId.readOnly = false;
			showImage("slnk21");
			objForm.ddTemplateId.focus();
		}
		else
		{
			//Fix for 470482 - Part 2	
			var tmpFuncCode = objForm.funcCode.value;
			var tmpIssDate = objForm.issDate.value;
			objForm.templateType.value = "";
			if (isOnLoad=='N'){
				objForm.purName.value="";
				objForm.purCrncyCode.value="";
				objForm.commCrncyCode.value="";
				ddTemplateId="";
				formReset(objForm);		
				fnResetRadioValues();

			}

			objForm.ddTemplateId.value = "";
			objForm.ddTemplateId.readOnly = true;
			hideImage("slnk21");
			objForm.funcCode.value = tmpFuncCode;
			objForm.issDate.value = tmpIssDate;
			objForm.valueDate.value = BODDate;	
		}
		enableFormElements();
		if(firstTimeAdd != 'N')	{
			fnSetPropertyValue(objForm.valueDate,"readOnly",false);
			showImage("sLnk16");
			objForm.GetValueDate.disabled = false;
		}

		if(templateMode == 'Y')
		{
			objForm.funcCode.disabled = true;
			objForm.GetValueDate.disabled = true;
		}
		objForm.tranId.value = "";
		objForm.tranId.readOnly = true;
		hideImage("sLnk13");
		objForm.issDate.value = BODDate;
		fnAssignUIDate(objForm.issDate);
		fnSetPropertyValue(objForm.issDate,"readOnly",true);
		hideImage("sLnk2");
		if(firstTimeAdd != 'N'){
			if(objForm.valueDate.value == null)
			{
				objForm.valueDate.value = BODDate;
			}
		}
		else{
			fnSetPropertyValue(objForm.valueDate,"readOnly",true);
			hideImage("sLnk16");
		}
		fnAssignUIDate(objForm.valueDate);

		objForm.ddAcctId.readOnly = false;
		showImage("sLnk12");
		objForm.ddRptCode.readOnly = false;
		showImage("sLnk3");
		showImage("sLnk7");
		objForm.refNum.readOnly = false;
		objForm.purRptCode.readOnly = false;
		showImage("sLnk25");
		objForm.commRptCode.readOnly = false;
		showImage("sLnk11");
		objForm.ddAcctCrncy.disabled = true;
		objForm.ddSolId.disabled = true ;
		objForm.ddAcctName.disabled = true;
		objForm.pAcctCrncy.disabled = true;
		objForm.pSolId.disabled = true ;
		objForm.pAcctName.disabled = true;
		objForm.purAcctBalance.disabled = true;
	}
	//Fix for 470482:  else if (!fnIsNull(objForm.funcCode.value))
	else if (!fnIsNull(objForm.funcCode.value)){ 

		var tmpFuncCode = objForm.funcCode.value;
		var tmpIssDate = objForm.issDate.value;
		var tmpTranId = objForm.tranId.value

			// start - fc template code change
			if (isOnLoad=='N'){
				objForm.purName.value="";
				objForm.purCrncyCode.value="";
				objForm.commCrncyCode.value="";
				ddTemplateId="";	
				formReset(objForm);										 
				fnResetRadioValues();
			}
		objForm.ddTemplateId.value = "";
		objForm.ddTemplateId.readOnly = true;
		hideImage("slnk21");
		// end fc templaet cdoe change
		objForm.funcCode.value = tmpFuncCode;
		objForm.issDate.value = tmpIssDate;
		objForm.tranId.value = tmpTranId;
		fnAssignUIDate(objForm.issDate);
		disableFormElements(23);
		objForm.GetValueDate.disabled = true;
		objForm.Clear.disabled = false;
		if(templateMode != 'Y')
		{
			objForm.tranId.readOnly = false;
			objForm.tranId.disabled = false;
			showImage("sLnk13");
			fnSetPropertyValue(objForm.issDate,"readOnly",false);
			showImage("sLnk2");
			objForm.funcCode.disabled = false;
		}
		fnSetPropertyValue(objForm.valueDate,"readOnly",true);
		hideImage("sLnk16");


		if(null != objForm.FetchPurCheque){
			objForm.FetchPurCheque.disabled = true;
		}
		if(null != objForm.FetchPurCard){
			objForm.FetchPurCard.disabled = true;
		}
		if(null != objForm.FetchCommCheque){
			objForm.FetchCommCheque.disabled = true;
		}
		if(null != objForm.FetchCommCard){
			objForm.FetchCommCard.disabled = true;
		}
		objForm.purRptCode.readOnly = true;
		hideImage("sLnk25");
		hideImage("sLnk26");
		hideImage("sLnk27");
	}
	else{
		objForm.ddTemplateId.readOnly = true;
		hideImage("slnk21");
		if (isOnLoad=='N'){
			objForm.purName.value="";
			objForm.purCrncyCode.value="";
			objForm.commCrncyCode.value="";
			ddTemplateId="";	
			formReset(objForm);
			fnResetRadioValues();
			clearDescField("purcntryName");
		}

	}
	self.focus();

	if(templateMode == 'Y')
	{
		if (firstTimeAdd=='N')
		{
			objForm.Accept.focus();
		}
		else
		{
			objForm.Go.focus();
		}
	}
	else
		objForm.funcCode.focus();
	if (objForm.funcCode.value == 'T')
	{
		objForm.ddTemplateId.focus();
	}
	managePurType();
	manageCommType();

}

function managePurType() {

	var radioVal = getRadioValue(objForm.purType);
	if (objForm.funcCode.value == ADD || objForm.funcCode.value == 'T') {
		if (radioVal == CASH) {
			objForm.purTranType.value = CASH;
			objForm.purTranSubType.value = CUSTOMER_INDUCED;
		}
		if (radioVal == TRANSFER_BANK_INDUCED) {
			objForm.purTranType.value = TRANSFER;
			objForm.purTranSubType.value = BANK_INDUCED;
		}
		if (radioVal == TRANSFER_CUSTOMER_INDUCED) {
			objForm.purTranType.value = TRANSFER;
			objForm.purTranSubType.value = CUSTOMER_INDUCED;
		}


		if (objForm.purTranType.value == CASH) {
			objForm.purAcctId.value = "";
			objForm.purAcctId.readOnly = true;
			objForm.purChqAlpha.value = "";
			objForm.purChqAlpha.readOnly = true;
			objForm.purChqNum.value = "";
			objForm.purChqNum.readOnly = true;
			fnClearDateFields(objForm.purChqDate);
			fnSetPropertyValue(objForm.purChqDate,"readOnly",true);
			hideImage("sLnk4");
			hideImage("sLnk27");
			hideImage("sLnk6");
			hideImage("sLnk14");
			objForm.purCrncyCode.readOnly = false;
			objForm.purName.readOnly = false;
			showImage("sLnk5");
			if(null != objForm.FetchPurCheque){
				objForm.FetchPurCheque.disabled = true;
			}
			if(null != objForm.FetchPurCard){
				objForm.FetchPurCard.disabled = true;
			}
			objForm.purAddrLine1.value = "";
			objForm.purAddrLine1.readOnly = false;
			objForm.purAddrLine2.value = "";
			objForm.purAddrLine2.readOnly = false;
			objForm.purAddrLine3.value = "";
			objForm.purAddrLine3.readOnly = false;
			objForm.purCityCode.value = "";
			objForm.purCityCode.readOnly = false;
			objForm.purStateCode.value = "";
			objForm.purStateCode.readOnly = false;
			objForm.purCntryCode.value = "";
			objForm.purCntryCode.readOnly = false;
			objForm.purPostalCode.value = "";
			objForm.purPostalCode.readOnly = false;
			objForm.purPhNum.value = "";
			objForm.purPhNum.readOnly = false;
			objForm.purTelexNum.value = "";
			objForm.purTelexNum.readOnly = false;
			objForm.purFaxNum.value = "";
			objForm.purFaxNum.readOnly = false;
			objForm.purEmailId.value = "";
			objForm.purEmailId.readOnly = false;
			clearDescField("pAcctCrncy","pSolId","pAcctName","purcityName","purstateName","purcntryName","purAddrLine1","purCityCode","purAddrLine2","purStateCode","purPostalCode","purCntryCode","purPhNum","purTelexNum","purFaxNum","purEmailId");

		}
		if (objForm.purTranType.value == TRANSFER) {

			objForm.purAcctId.readOnly = false;
			objForm.purChqAlpha.readOnly = false;
			objForm.purChqNum.readOnly = false;
			fnSetPropertyValue(objForm.purChqDate,"readOnly",false);
			objForm.purCrncyCode.readOnly = true;
			objForm.purName.readOnly = true;
			hideImage("sLnk5");
			showImage("sLnk4");
			showImage("sLnk27");
			showImage("sLnk6");
			showImage("sLnk14");
			if(null != objForm.FetchPurCheque){
				objForm.FetchPurCheque.disabled = false;
			}
			if(null != objForm.FetchPurCard){
				objForm.FetchPurCard.disabled = false;
			}

			objForm.purAddrLine1.readOnly = false;
			objForm.purAddrLine2.readOnly = false;
			objForm.purAddrLine3.readOnly = false;
			objForm.purCityCode.readOnly = false;
			objForm.purStateCode.readOnly = false;
			objForm.purCntryCode.readOnly = false;
			objForm.purPostalCode.readOnly = false;
			objForm.purPhNum.readOnly = false;
			objForm.purTelexNum.readOnly = false;
			objForm.purFaxNum.readOnly = false;
			objForm.purEmailId.readOnly = false;
			showImage("sLnk10");
			showImage("sLnk19");
			showImage("sLnk20");
		}
	}
	}

	function manageCommType() {

		var radioVal = getRadioValue(objForm.commType);
		var purType = getRadioValue(objForm.purType);

		if (objForm.funcCode.value == ADD || objForm.funcCode.value == 'T') {
			if (radioVal == CASH) {
				objForm.commTranType.value = CASH;
				objForm.commTranSubType.value = CUSTOMER_INDUCED;
			}
			if (radioVal == TRANSFER_BANK_INDUCED) {
				objForm.commTranType.value = TRANSFER;
				objForm.commTranSubType.value = BANK_INDUCED;
			}
			if (radioVal == TRANSFER_CUSTOMER_INDUCED) {
				objForm.commTranType.value = TRANSFER;
				objForm.commTranSubType.value = CUSTOMER_INDUCED;
			}


			if (objForm.commTranType.value == CASH) {

				objForm.commAcctId.value = "";
				clearDescField('commAcctCrncy','commSolId','commAcctName');
				objForm.commAcctId.readOnly = true;
				hideImage("sLnk26");
				objForm.commAcctCrncy.disabled = true;
				objForm.commSolId.disabled = true;
				objForm.commAcctName.disabled = true;
				objForm.commChqAlpha.value = "";
				objForm.commChqNum.value = "";
				fnClearDateFields(objForm.commChqDate);
				objForm.commChqAlpha.readOnly = true;
				objForm.commChqNum.readOnly = true;
				fnSetPropertyValue(objForm.commChqDate,"readOnly",true);
				hideImage("sLnk8");
				hideImage("sLnk15");
				objForm.commCrncyCode.readOnly = false;
				showImage("sLnk9");
				if(null != objForm.FetchCommCheque){
					objForm.FetchCommCheque.disabled = true;
				}
				if(null != objForm.FetchCommCard){
					objForm.FetchCommCard.disabled = true;
				}
			}
			if (objForm.commTranType.value == TRANSFER) {

				objForm.commAcctId.readOnly = false;
				objForm.commChqAlpha.readOnly = false;
				objForm.commChqNum.readOnly = false;
				fnSetPropertyValue(objForm.commChqDate,"readOnly",false);
				objForm.commCrncyCode.readOnly = true;
				hideImage("sLnkr9");
				showImage("sLnk8");
				showImage("sLnk26");
				showImage("sLnk10");
				showImage("sLnk15");
				if(null != objForm.FetchCommCheque){
					objForm.FetchCommCheque.disabled = false;
				}
				if(null != objForm.FetchCommCard){
					objForm.FetchCommCard.disabled = false;
				}
			}
		}
		}

		function setCommDetails() {
			var purType = getRadioValue(objForm.purType);
			var radioVal = getRadioValue(objForm.commType);
			if (((purType == TRANSFER_BANK_INDUCED) || (purType == TRANSFER_CUSTOMER_INDUCED)) && (radioVal != CASH)) {
				if (fnIsNull(objForm.commChqAlpha.value)) {
					objForm.commChqAlpha.value = objForm.purChqAlpha.value
				}
				if (fnIsNull(objForm.commChqNum.value)) {
					objForm.commChqNum.value = objForm.purChqNum.value
				}
				if (fnIsNull(objForm.commChqDate.value)) {
					objForm.commChqDate.value = objForm.purChqDate.value;
					fnAssignUIDate(objForm.commChqDate);
				}
				if (fnIsNull(objForm.commAcctId.value)) {
					objForm.commAcctId.value = objForm.purAcctId.value
						objForm.commCrncyCode.value = objForm.purCrncyCode.value
				}
			}
		}

		function fnShowAccountIdList(acctObj,solId,acctName,inPreceedence,acctCrncy,acctInd) {
			showAccountIdList(acctObj,solId,acctName,inPreceedence,acctCrncy);
			fnPopulateFieldValue(acctInd);

		}

		fkmResource =
		{
			"FORM-ACCEPT|FORM"          : "onFormAccept"
				,"FORM-CANCEL|FORM"         : "onFormCancel"

		}

		function onFormAccept()
		{
			var frm = document.forms[0];
			if( (frm.Accept != undefined) && (frm.Accept != null) )
				frm.Accept.click();
			if( (frm.Go != undefined) && (frm.Go != null) )
				frm.Go.click();
		}

		function onFormCancel()
		{
			var frm = document.forms[0];
			if( (frm.Cancel != undefined) && (frm.Cancel != null) )
				frm.Cancel.click();
		}

		function callRateDtls()
		{
			/*Changed as part of recon ticket : 333575*/
			getRateDtls('myframe',objForm.ddAcctId.value,objForm.ddAcctCrncy.value,objForm.purAcctId.value,objForm.purCrncyCode.value,objForm.purRateCode,objForm.purRate,objForm.purTreaRate);
			/*End of change as part of recon ticket : 333575*/
		}

		function callChrgRateDtls()
		{
			getRateDtls('myframe',objForm.commAcctId.value,objForm.commCrncyCode.value,"",commCrCrncy,objForm.commRateCode,objForm.commRate,objForm.commTreaRate);
		}
		function updateCommType()
		{
			var radioVal = getRadioValue(objForm.purType);
			checkRadio(objForm.commType,radioVal);
			manageCommType();
		}

		function fnInvokeDevice(btnObj,hdeviceId)
		{
			var fldName = "";
			var frm = document.forms[0];

			if(btnObj.id=="FetchPurCard")
			{
				fldName = "frm.purAcctId";
				acctIndr = 'PUR';
			}
			else if(btnObj.id=="FetchCommCard")
			{
				fldName = "frm.commAcctId";
				acctIndr = 'COMM';
			}
			else if(btnObj.id=="FetchPurCheque")
			{
				fldName = "frm.purChqNum";
			}
			else if(btnObj.id=="FetchCommCheque")
			{
				fldName = "frm.commChqNum";
			}
			eval("frm."+ btnObj.id +".disabled = true");
			eval(hdeviceId + "_invoke("+ fldName +", true)");
			eval("frm."+ btnObj.id +".disabled = false");
		}

		function printDeviceTag(){
			if(CHQRD_Pflg){
				for (i=0; i< CHQRD.length; i++)
				{
					eval(CHQRD_DeviceId[i] +"_load").call();
				}
			}
			if(CRDRD_Pflg){
				for (i=0; i< CRDRD.length; i++)
				{
					eval(CRDRD_DeviceId[i] +"_load").call();
				}
			}
		}

		function fnFetchAcctDtls(acctObj, acctName, acctSol, acctCrncy, isError, valFuncName,acctInd) {
			if(acctInd == 'PUR') {
				clearDescField("pAcctCrncy","pSolId","pAcctName","purcityName","purstateName","purcntryName","purAddrLine1","purCityCode","purAddrLine2","purStateCode","purPostalCode","purCntryCode","purPhNum","purTelexNum","purFaxNum","purEmailId");
			}

			if(fnCommonFetchAcctDtls(acctObj,acctName,acctSol,acctCrncy,isError,valFuncName))
			{
				fnPopulateFieldValue(acctInd);
				if(acctInd == 'PUR' && !fnIsNull(acctObj.value)) {
					// add by morning start
					getAccountBalance (acctObj);
					setFieldsToCustomData("purAcctBalance");
					// add by morning end
					doSubmit("GETPURINFO");
				}
			}
			else
				return false;
			return true;
		}
// add by morning start
function getAccountBalance(acctObj) {
	if (null == acctObj || "" == acctObj.value)
	{
		return false;
	}
	else
	{
		// call finacle script to get the balance information
		var input = "purAcctId|"+acctObj.value;
		var output = "";
		var scriptName = "ddgenmn001.scr";
		var retVal = appFnExecuteScript(input,output,scriptName,false);
		var strVal = retVal.split("|");
		document.getElementById("purAcctBalance").value = strVal[1];
		newformatAmt("Million",document.getElementById("purAcctBalance"),strVal[1],'N');
	}
}
// add by morning end

		function fnPopulateFieldValue(acctInd) {

			PUR = 'PUR';
			COMM = 'COMM';

			switch (acctInd)
			{
				case PUR :
					objForm.purCrncyCode.value = objForm.pAcctCrncy.value;
					objForm.purName.value = objForm.pAcctName.value;
					objForm.commAcctId.value = objForm.purAcctId.value;
					objForm.commAcctCrncy.value = objForm.pAcctCrncy.value;
					document.forms[0].commSolId.value = document.forms[0].pSolId.value;
					document.forms[0].commAcctName.value = document.forms[0].pAcctName.value;
					objForm.commCrncyCode.value = objForm.pAcctCrncy.value;
					break;

				case COMM :
					objForm.commCrncyCode.value = objForm.commAcctCrncy.value;
					break;
			}
		}

		function fetchDetails(fldType)
		{
			if(fldType=="Card")
			{
				if(acctIndr == 'PUR'){
					if(!(fnFetchAcctDtls(objForm.purAcctId,'pAcctName','pSolId','pAcctCrncy',true,'VALACCTID','PUR'))){
						objForm.purAcctId.value = '';
						objForm.purCrncyCode.value = '';
						objForm.purName.value = '';
						setFieldFocus(objForm.purAcctId);
					}
				}
				else{
					if(!(fnFetchAcctDtls(objForm.commAcctId,'commAcctName','commSolId','commAcctCrncy',true,'VALACCTID','COMM'))){
						objForm.commAcctId.value = '';
						objForm.commCrncyCode.value = '';
						setFieldFocus(objForm.commAcctId.focus);
					}
				}
			}
		}

		function showSignature ()
		{
			if(SVS_Flag != undefined  && SVS_Flag == "Y" )
			{
				showSVSSignature();
			}

			else{
				displaySignatureWindow(groupName,document.forms[0].purAcctId.value);
			}
		}
		function showSVSSignature()
		{
			if (fnIsNull(objForm.purAcctId.value) && templateMode != 'Y') {
				alert(finbranchResArr.get("FAT000200"));
				objForm.purAcctId.focus();
				return;
			}

			var data = '?sAcctId='+escape(objForm.purAcctId.value)+'&sSolId='+escape(pSolId)+'&fromAppId='+escape(fromAppId)+'&sActiveDate='+escape(BODDate)+'&toMenu=hddmi&contextSwitch=Y' ;
			displaySVSWindow(data);

		}

		function callbackSVS(data,menu)
		{
			//   for SSO COntext Switching
		}

		function showSignatureComm()
		{
			if(SVS_Flag != undefined  && SVS_Flag == "Y" )
			{
				if (fnIsNull(objForm.commAcctId.value) && templateMode != 'Y') {
					alert(finbranchResArr.get("FAT000200"));
					document.forms[0].commAcctId.focus();
					return;
				}
				var data = '?sAcctId='+escape(objForm.commAcctId.value)+'&sSolId='+escape(commSolId)+'&fromAppId='+escape(fromAppId)+'&sActiveDate='+escape(BODDate)+'&toMenu=hddmi&contextSwitch=Y' ;
				displaySVSWindow(data);
			}
			else{
				displaySignatureWindow(groupName,document.forms[0].commAcctId.value);
			}
		}

		//Modification For SVS Integration Ends

		function fnSrchrFetchAcctDtls()
		{
			var oldPurAcctId = objForm.purAcctId.value;
			fnShowAccountIdList(objForm.purAcctId, objForm.pSolId, objForm.pAcctName, 'F', objForm.pAcctCrncy,'PUR');
			if(oldPurAcctId.toUpperCase() != objForm.purAcctId.value){
				fnFetchAcctDtls(objForm.purAcctId,'pAcctName','pSolId','pAcctCrncy',true,'VALACCTID','PUR');
				setCommDetails();
			}
		}

		function showGtmplSearcher()
		{

			showDynSearcher('HTEMPLID','template_id=:ddTemplateId|entity_type=HDDMI|context_sol_id='+cxtSol+'|userId='+USERID+'',':ddTemplateId=template_id|:templateType=entity_type');

			if (objForm.funcCode.value == 'T' && !(fnIsNull(objForm.ddTemplateId.value)))
				fetchTemplateDtls();

		}

		function fetchTemplateDtls()
		{
			if (objForm.funcCode.value == 'T')
			{
				objForm.ddTemplateId.disabled = false;
				if (fnIsNull(objForm.ddTemplateId.value))
				{
					alert(finbranchResArr.get("FAT000200"));
					objForm.ddTemplateId.focus();
					return false;
				}
				else
				{
					doSubmit("getTemplateData");
					return true;

				}
			}
		}

		function fnResetRadioValues()
		{
			setRadioValue('printInd','L');
			setRadioValue('purType','C');
			setRadioValue('commType','C');
		}

