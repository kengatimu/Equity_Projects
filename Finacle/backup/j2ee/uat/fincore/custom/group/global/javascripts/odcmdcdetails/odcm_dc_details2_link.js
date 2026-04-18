/* THIS IS A GENERATED FILE. DO NOT MODIFY IT MANUALLY.*/
var objForm = null;
var AmountCrncyMap = {
	premiumAmt     :  "premiumCcy|N",
	insuredAmt     :  "insuredCcy|N",
	totDcConfAmt   :   "dcAmtccy|N" 
}
function fnOnLoad()
{
	objForm = document.forms[0];

	if(messageId ==  "720")
	{
		objForm.partialShipment[0].checked = false;
		objForm.partialShipment[1].checked = false;
		if(SWIFT2018_ENABLED == "Y")
		{
			objForm.partialShipment[2].checked = false;
		}
		objForm.transShipment[0].checked = false;
		objForm.transShipment[1].checked = false;
		if(SWIFT2018_ENABLED == "Y")
		{
			objForm.transShipment[2].checked = false;
		}
	}
	
	fnPopulateDropDownValues();
	fnPopulateControlValues();
	initFocusHandler();
	fnAssignUIDate(objForm.latestDateOfShipment);
	fnAssignUIDate(objForm.policyDate);
	fnAssignUIDate(objForm.insExpiryDate);
	fnSetRadioValues(); 
	fnToggleInsrDtlDisplay('1');
	fnEnableDisableConfFlds();	
	if(locInOutInd == 'O')
	{
		hideImage("sLnk65");
	}
	if(locInOutInd == 'I') 
	{ 
		objForm.autoreimbclaim.value = autoreimbclaim; 
	} 

	if((funcCode !=DcConst.MODIFY_MODE) && (funcCode !=DcConst.COPY_MODE) && (funcCode!= DcConst.ISSUE_MODE) && (funcCode!= DcConst.PREADVICE_MODE) &&(funcCode!= DcConst.ADVISE_MODE)){
		fnDisableFormDcDataControls(funcCode,objForm,0);

		if(funcCode !=DcConst.INQUIRE_MODE){
			if (sReferralMode != 'I' && sReferralMode != 'S')
			{
				objForm.Submit.focus();
				objForm.Cancel.disabled=false;
			}
		}
	}
	else if((funcCode == DcConst.MODIFY_MODE) && !(fnIsNull(locEventType)) && (locEventType !=DcConst.ISSUE_MODE)&& (locEventType!= DcConst.PREADVICE_MODE)	&& (locEventType != DcConst.ADVISE_MODE))
	{
		fnDisableFormDcDataControls('V',objForm,0);
		objForm.Cancel.disabled=false;
	}
	else  if((funcCode == DcConst.MODIFY_MODE) && (verifiedFlg == 'Y') && ((locEventType ==DcConst.ISSUE_MODE)||(locEventType!=	DcConst.PREADVICE_MODE) || (locEventType ==DcConst.ADVISE_MODE)))
	{
		fnDisableFormDcDataControls('V',objForm,0);
		fnEnableFormDc2DataControls();
		if((getRadioValue(objForm.reimburseMessage) == "Y")){
			fndisablereimbFlg();
		}
	}
	else if (fnIsNull(objForm.latestDateOfShipment.value)) 
	{
		fnSetFocusForDate(objForm.latestDateOfShipment);
	}


	showImage("sLnk15");
	showImage("sLnk13");
	showImage("sLnk25");
	showImage("sLnk34");    //To display Nostro account searcher during Modify mode also
    showImage("sLnk37");
    showImage("sLnk39");
    showImage("sLnk41");
    showImage("sLnk43");
    showImage("sLnk45");
	showImage("sLnk48");
	showImage("sLnk50");
	showImage("sLnk550");	
	if(funcCode == 'I')
	{
		showImage("sLnk57");
	}
	else
	{
		hideImage("sLnk57");
	}

	if( funcCode == 'A'  || (((funcCode == 'S'||funcCode == 'K') ||  funcCode == DcConst.MODIFY_MODE ) &&  verifiedFlg == 'N') || (locEventType == 'A' && funcCode == DcConst.MODIFY_MODE))
	{
			objForm.insuredAmt.readOnly = false;
			objForm.insuredBy.disabled = false;
			objForm.policyNo.readOnly = false;
			objForm.policyDate_ui.readOnly = false;
			objForm.payableAt.readOnly = false;
			objForm.premiumAmt.readOnly = false;
			objForm.insName.readOnly = false;
			objForm.insuNum.readOnly = false;
			objForm.insAddr1.readOnly = false;
			objForm.insAddr2.readOnly = false;
			objForm.insAddr3.readOnly = false;
			objForm.insCity.readOnly = false;
			objForm.insState.readOnly = false;
			objForm.insCntry.readOnly = false;
			objForm.insPostalCode.readOnly = false;
			objForm.insExpiryDate_ui.readOnly = false;
			objForm.insurancePcnt.readOnly = false;
			objForm.insCityDesc.readOnly = false;
			objForm.Validate.disabled = false;

			showImage("sLnk17");
			showImage("sLnk151");
			showImage("sLnk152");
			showImage("sLnk890");
			showImage("sLnk153");
	}

	if ((funcCode == DcConst.MODIFY_MODE) &&  (verifiedFlg == 'Y'))
	{
		fnEnableDisableRadioButtons(objForm.addConfirmation,'D');
		objForm.totDcConfAmt.disabled=true;
		objForm.dcConfPcnt.disabled=true;
	}

	if((funcCode == DcConst.ISSUE_MODE) || (funcCode == DcConst.COPY_MODE) || (funcCode == DcConst.MODIFY_MODE))
	{ 
		if((funcCode == DcConst.MODIFY_MODE) && (verifiedFlg == 'Y') && (locEventType != DcConst.REINSTATEMENT)) 
		{ 
			return true; 
		} 
	} 

	if(locInOutInd == 'I') 
	{ 
		objForm.drawnOnOtherBank.value = drawnOnOtherBank; 
		if(funcCode == DcConst.ADVISE_MODE || funcCode == DcConst.MODIFY_MODE || funcCode == DcConst.COPY_MODE)
		{ 
			objForm.drawnOnOtherBank[0].disabled = false; 
			objForm.drawnOnOtherBank[1].disabled = false; 
		}                   
		else 
		{ 
			objForm.drawnOnOtherBank[0].disabled = true; 
			objForm.drawnOnOtherBank[1].disabled = true; 
		} 
	} 

	if(funcCode == DcConst.ISSUE_MODE || funcCode == DcConst.PREADVICE_MODE || funcCode == DcConst.ADVISE_MODE || funcCode == DcConst.COPY_MODE || (funcCode == DcConst.MODIFY_MODE && verifiedFlg == 'N')) 
	{ 
		objForm.capitalGoodsTrans[0].disabled = false; 
		objForm.capitalGoodsTrans[1].disabled = false; 
	} 
	else 
	{ 
		objForm.capitalGoodsTrans[0].disabled = true; 
		objForm.capitalGoodsTrans[1].disabled = true; 
	} 

	if(locInOutInd == 'I')
	{

		if(( funcCode == 'E'  || funcCode == 'K' ||  funcCode == 'M' ||  funcCode == 'C') && verifiedFlg == 'N')
		{
			fnEnableDisableRadioButtons(objForm.autoreimbclaim,'E');
		}
		else
		{
			fnEnableDisableRadioButtons(objForm.autoreimbclaim,'D');
		}
	}

        fnEnableDisableAutoSheduleFlg();
        if ((funcCode == DcConst.AMENDMENT_MODE) && (getRadioValue(objForm.autoScheduleApplicable) == 'N'))
        {
			fnEnableDisableRadioButtons(objForm.autoScheduleApplicable,'E');
        }
        fnOnChangeAutoSheduleFlag();

       fnEnableDisableAutoRenewalFlg(); 
       if ((funcCode == DcConst.AMENDMENT_MODE) && (getRadioValue(objForm.autoRenewalApplicable) == 'N')&&(revolving == 'Y')) 
       { 
           if(revolving == 'Y')
           {
				setRadioValue('autoRenewalApplicable','N');
 				fnEnableDisableRadioButtons(objForm.autoRenewalApplicable,'D');
           }
           else
           {
           		fnEnableDisableRadioButtons(objForm.autoRenewalApplicable,'E'); 
           }
       } 
	   fnOnChangeAutoRenewalFlag(); 

	   if (getAmtInFloat(objForm.insuredAmt.value) == 0) 
	   { 
		   onChangeInsPcnt(); 
	   } 

	   if(((dcPreadvicedFlg == 'Y')  && (funcCode == DcConst.ISSUE_MODE || funcCode == DcConst.ADVISE_MODE)) || 
			   (preAdvProcessMsgFlg == 'Y'))
	   {
		   hideImage("sLnk16");
		   disableFields("latestDateOfShipment");
		   if(!fnIsNull(preplaceIfCharge))
		   {
			   disableFields("placeIfCharge");
		   }

		   if(!fnIsNull(preportOfLoading))
		   {
			   disableFields("portOfLoading");
		   }

		   if(!fnIsNull(preportOfDischarge))
		   {
			   disableFields("portOfDischarge");
		   }

		   if(!fnIsNull(preplaceForFinalDest))
		   {
			   disableFields("placeForFinalDest");
		   }

		   if(!fnIsNull(prelatestDateOfShipment))
		   {
			   hideImage("sLnk16");
			   disableFields("latestDateOfShipment");
		   }
		   if(preshipmentPrd == 'Y')
		   {
			   hideImage("sLnk49");
		   }
		   if(!fnIsNull(negotPeriod))
			   disableFields("negotPeriod");

		   if(!fnIsNull(capitalGoodsTrans))
			   disableFields("capitalGoodsTrans");

		   if(!fnIsNull(chargesBorneBy))
			   disableFields("chargesBorneBy");	

		   if(!fnIsNull(confRequired))
			   disableFields("confRequired");

		   if(!fnIsNull(autoScheduleApplicable))
			   disableFields("autoScheduleApplicable");

		   if(!fnIsNull(confRequired))
			   disableFields("confRequired");	

	   }

	if(funcCode == DcConst.AMENDMENT_MODE || (funcCode == DcConst.MODIFY_MODE && locEventType == "A" && (verifiedFlg == 'N')))
	{
		fnDisableFormDcDataControls('V',objForm,0);
		showImage("sLnk15");
		showImage("sLnk13");
		objForm.Validate.disabled=false;
        objForm.Cancel.disabled=false;		
	}
	if(SWIFT2018_ENABLED != "Y")
	{
		hideImage("periodOfPresen");
		hideImage("sLnk58");
		hideImage("sLnk59");
	}
		
	return true;
}

function callTextArea()
{
	if(((dcPreadvicedFlg == 'Y')  && (funcCode == DcConst.ISSUE_MODE || funcCode == DcConst.ADVISE_MODE)) ||
			(preAdvProcessMsgFlg == 'Y'))
	{
		if(preshipmentPrd == 'Y')
		{
			showTextArea('shipmentDesc','','N','left','U','N',65,6,'string','N');	
		}
		else
		{
			showTextArea('shipmentDesc','','N','left','U','N',65,6,'string','Y');
		}
	}
	else
	{
		showTextArea('shipmentDesc','','N','left','U','N',65,6,'string','Y');	
	}
}

function fnOnChangeAutoSheduleFlag()
{
        if(getRadioValue(objForm.autoScheduleApplicable) == 'Y')
        {
                //Display Auto Schedule Explode Image
                showImage("sLnk108");
        }
        else
        {
                //Hide Auto Schedule Explode Image
                hideImage("sLnk108");
        }
        return true;
}

function fnEnableDisableAutoSheduleFlg()
{
        if (funcCode == DcConst.COPY_MODE || funcCode == DcConst.ISSUE_MODE ||  funcCode == DcConst.PREADICE_MODE || funcCode == DcConst.ADVISE_MODE)
        {
                fnEnableDisableRadioButtons(objForm.autoScheduleApplicable,'E');
        }
        else if ((funcCode == DcConst.MODIFY_MODE) && (locEventType == DcConst.ISSUE_MODE ||locEventType == DcConst.PREADVICE_MODE||locEventType == DcConst.ADVISE_MODE) && (verifiedFlg == 'N') && (getRadioValue(objForm.autoScheduleApplicable) == "N"))

        {
                fnEnableDisableRadioButtons(objForm.autoScheduleApplicable,'E');
        }
        else if ((funcCode == DcConst.AMENDMENT_MODE) && (getRadioValue(objForm.autoScheduleApplicable) == "N"))
        {
                fnEnableDisableRadioButtons(objForm.autoScheduleApplicable,'E');
        }
        else if ((funcCode == DcConst.MODIFY_MODE) && (locEventType == DcConst.AMENDMENT_MODE) && (getRadioValue(objForm.autoScheduleApplicable) == "N"))
        {
                fnEnableDisableRadioButtons(objForm.autoScheduleApplicable,'E');
        }
        else
        {
                fnEnableDisableRadioButtons(objForm.autoScheduleApplicable,'D');
        }

        if(autoScheduleLLSize == 0 && (getRadioValue(objForm.autoScheduleApplicable) == "Y"))
        {
                fnEnableDisableRadioButtons(objForm.autoScheduleApplicable,'E');
        }

        return true;
}

function fnOnChangeAutoRenewalFlag() 
{ 
	if(getRadioValue(objForm.autoRenewalApplicable) == 'Y') 
	{ 
		//Display Auto Schedule Explode Image 
		showImage("sLnk107"); 
	} 
	else 
	{ 
		//Hide Auto Schedule Explode Image 
		hideImage("sLnk107"); 
	} 
	return true; 
} 
function fnExplodeAutoScheduleDetails()
{
        objForm.callerId.value = "callAutoSchedule";
        jsUtil.submit("EXPLODE", jsUtil.getType().ACTION_CODE);
        return true;
}
    
function fnEnableDisableConfFlds()
{
    var radioValue = getRadioValue(objForm.addConfirmation);
    if(radioValue == 'N')
    {
        objForm.dcConfPcnt.value = 0;
        objForm.totDcConfAmt.value = 0;
        /*Reviewed by frontend team and the value to be kept as readonly
         * instead of disabled */
        objForm.dcConfPcnt.readOnly=true;
        objForm.totDcConfAmt.readOnly=true;
    }
    else if (radioValue == 'P')
    {
        /*Reviewed by frontend team and the value to be kept as readonly
        * instead of disabled */
        objForm.dcConfPcnt.readOnly=false;
        objForm.totDcConfAmt.readOnly=false;
    }
    else
    {
        objForm.dcConfPcnt.value = 100;
		if(verifiedFlg != 'Y')
		{
        	objForm.totDcConfAmt.value = dcAvailAmt;
		}
        /*Reviewed by frontend team and the value to be kept as readonly
        * instead of disabled */
        objForm.dcConfPcnt.readOnly=true;
        objForm.totDcConfAmt.readOnly=true;
    }
	newformatAmt(format,objForm.totDcConfAmt,dcAmtccy,'N');
}

function fnCalcConfAmtPcnt(fld)
{
    var radioValue = getRadioValue(objForm.addConfirmation);
    var confAmt = null;
	objForm.fld.value = fld;

        if (radioValue == 'P')
        {
            if (getAmtInStdFormat(objForm.totDcConfAmt.value) <= 0 && fld == "A")
            {
                alert(finbranchResArr.get("FAT004462"));
                objForm.totDcConfAmt.focus();
                return false;
            }

            if((!fnIsNull(objForm.totDcConfAmt.value)) && (!fnIsNull(dcAvailAmt)) && fld == "A")
            {
				newformatAmt(format,objForm.totDcConfAmt,dcAmtccy,'N');
				if(fnCompareAmounts(dcAvailAmt, objForm.totDcConfAmt.value))
                {
                    alert(finbranchResArr.get("FAT008562"));
                    objForm.totDcConfAmt.focus();
                    return false;
                }
            }

            /* Fix for ticket id 377371 */
            if(!(fnValidateAndFormatAmt(format,objForm.totDcConfAmt,dcAmtccy,"N")))
            {
                return false;
            }

			sendDataToServer('myframe','IDCMCONFIRMATIONCALC','F','dcConfPcnt|totDcConfAmt|dcAvailAmt|fld|dcAmtccy','dcConfPcnt|totDcConfAmt');
        }
        return true;
}

function fnEnableDisableAutoRenewalFlg() 
{
	
if ((funcCode == DcConst.COPY_MODE || funcCode == DcConst.ISSUE_MODE ||   funcCode == DcConst.PREADVICE_MODE || funcCode == DcConst.ADVISE_MODE))
    {
        enableFields('autoRenewalApplicable');
    }
    else
    {
        if ((funcCode == DcConst.MODIFY_MODE) && (locEventType == DcConst.ISSUE_MODE || locEventType == DcConst.PREADVICE_MODE || locEventType == DcConst.ADVISE_MODE || locEventType == DcConst.AMENDMENT_MODE) && (getRadioValue(objForm.autoRenewalApplicable) == "N") && (verifiedFlg == 'N'))
        {
            enableFields('autoRenewalApplicable');
        }
        else
        {
            if ((funcCode == DcConst.AMENDMENT_MODE) && (getRadioValue(objForm.autoRenewalApplicable) == "N"))
            {
                enableFields('autoRenewalApplicable');
            }
            else
            {
                if ((funcCode == DcConst.MODIFY_MODE) && (locEventType == DcConst.AMENDMENT_MODE) && (getRadioValue(objForm.autoRenewalApplicable) == "N"))
                {
                    enableFields('autoRenewalApplicable');
                }
                else
                {
                    disableFields('autoRenewalApplicable');
                }
		 
            }
        }
    }

    if(autoRenewalLLSize == 0 && (getRadioValue(objForm.autoRenewalApplicable) == "Y"))
    {
        enableFields('autoRenewalApplicable');
    }
    if(revolving == 'Y')
    {
		setRadioValue('autoRenewalApplicable','N');
        disableFields('autoRenewalApplicable');
    }

    return true;	
 
} 

function fnExplodeAutoRenewalDetails() 
{ 
	objForm.callerId.value = "callAutoRenewal"; 
	jsUtil.submit("EXPLODE", jsUtil.getType().ACTION_CODE); 
	return true; 
}

function onChangeInsPcnt() 
{ 
	var insPcnt = getValInStdFormat(objForm.insurancePcnt.value); 
	var posTol = getValInStdFormat(positiveTolerance); 
	var dcVal = getAmtInFloat(dcOpenValue); 

	if((!isNumber(objForm.insurancePcnt.value)) || insPcnt < 0) { 
		alert(finbranchResArr.get("FAT000167")); 
		objForm.insurancePcnt.focus(); 

		return false; 
	} 

	var prec = getPrec(insuredCcy); 
	var insAmt = (insPcnt/100) * (dcVal + (dcVal * (posTol/100))); 

	insAmt = Math.round(insAmt*Math.pow(10,prec))/Math.pow(10,prec); 

	objForm.insuredAmt.value = insAmt; 
} 

function fnEnableFormDc2DataControls() 
{
	objForm.placeIfCharge.readOnly=false;
	objForm.portOfLoading.readOnly=false;
	objForm.portOfDischarge.readOnly=false;
	objForm.placeForFinalDest.readOnly=false;
	objForm.transShipment[0].disabled=false;
	objForm.transShipment[1].disabled=false;
	objForm.transShipment[2].disabled=false;
	objForm.partialShipment[0].disabled=false;
	objForm.partialShipment[1].disabled=false;
	objForm.partialShipment[2].disabled=false;
	objForm.houseAirwaysBill[0].disabled=false;
	objForm.houseAirwaysBill[1].disabled=false;
	objForm.acIdentification.readOnly=false;
	objForm.reimburseMessage[0].disabled=false;
	objForm.reimburseMessage[1].disabled=false;
	objForm.dcReimbApplicableRule.disabled=false;
	objForm.addConfirmation[0].disabled=false;
	objForm.addConfirmation[1].disabled=false;
	objForm.addConfirmation[2].disabled=false;

	var radioValue = getRadioValue(objForm.addConfirmation);
    if (radioValue == 'P')
    {
        /*Reviewed by frontend team and the value to be kept as readonly
                 * instead of disabled */
        objForm.dcConfPcnt.readOnly=false;
        objForm.totDcConfAmt.readOnly=false;
    }
	
	objForm.Validate.disabled=false;
	objForm.Cancel.disabled=false;
	objForm.shipmentTerms.readOnly=false;
	showImage("sLnk15");
	showImage("sLnk25");
	showImage("sLnk37");
	showImage("sLnk39");
	showImage("sLnk41");
	showImage("sLnk43");
	showImage("sLnk45");
	showImage("sLnk48");
	showImage("sLnk50");
	showImage("sLnk19");
	fnSetRadioValues();	
}

function fndisablereimbFlg()
{
	objForm.dcReimbApplicableRule.readOnly=true;
	objForm.reimburseMessage[0].disabled=true;
	objForm.reimburseMessage[1].disabled=true;
}

function fndisableaddConfirmFlg()
{
	objForm.addConfirmation[0].disabled=true;
	objForm.addConfirmation[1].disabled=true;
	objForm.addConfirmation[2].disabled=true;
}
	
function fnOnButtonClick(btnObj)
{
	objForm = document.forms[0];
	document.forms[0].actionCode.value = btnObj.id;
	
	if (btnObj.id == "senToRecDesc"){
	 	doSubmitForm(btnObj.id);
	 	return true;
	}
	else if (btnObj.id == "instrDesc"){
	 	doSubmitForm(btnObj.id);
	 	return true;
	 }
	else if (btnObj.id == "chargesTextDesc"){
	 	doSubmitForm(btnObj.id);
	 	return true;
	 }
	else if (btnObj.id == "additionalDesc"){
	 	doSubmitForm(btnObj.id);
	 	return true;
	 }
	else if (btnObj.id == "docRequiredDesc"){
	 	doSubmitForm(btnObj.id);
	 	return true;
	 }
	else if (btnObj.id == "goodsDesc"){
	 	doSubmitForm(btnObj.id);
	 	return true;
	 }
	else if (btnObj.id == "shipmentDesc"){
	 	doSubmitForm(btnObj.id);
	 	return true;
	 }
	else if (btnObj.id == "licenseDesc"){
	 	doSubmitForm(btnObj.id);
	 	return true;
	 }
	 else if (btnObj.id == "reimSenToRecDesc"){
	 	doSubmitForm(btnObj.id);
	 	return true;
	 }
	else if (btnObj.id == "periodDesc"){

		doSubmitForm(btnObj.id);

		return true;

	}
	else if (btnObj.id == Const.ACTION_CANCEL)
	    {
	        if(confirm(finbranchResArr.get("FAT000925"))==true)
	        {
	            if(locInOutInd == 'O')
					document.location.href = jsUtil.formatUrl('../odcm/odcm_ctrl.jsp?actionCode=' + btnObj.id);
				else
					document.location.href = jsUtil.formatUrl('../idcm/idcm_ctrl.jsp?actionCode=' + btnObj.id);
				
				return true;
	        }
	        else
	            return false;
	    }
	    else if (btnObj.id == Const.ACTION_BACK)
	        {
	            if(locInOutInd == 'O')
					document.location.href = jsUtil.formatUrl('../odcm/odcm_ctrl.jsp?actionCode=' + btnObj.id);
				else 
					document.location.href = jsUtil.formatUrl('../idcm/idcm_ctrl.jsp?actionCode=' + btnObj.id);
				
				return true;
	    }
		else if (btnObj.id == Const.ACTION_SUBMIT) 
		{ 
			//if(additionalDesc.indexOf("") !=-1) */
			if(additionalDesc.indexOf("<AUTO") !=-1)	
			
			{ 
				if(confirm(finbranchResArr.get("FAT004760"))==false) 
					return false; 
			} 
		} 

	
	    if(!fnValidateForm())
	        return false;
	    else
	        doSubmit(btnObj.id);
        return true;
}
function fnChkFlgs()
{
	if(locInOutInd == 'O')
	{
		if(getRadioValue(objForm.confRequired) == "Y" || getRadioValue(objForm.confRequired) == "M")
		{
			if(fnIsNull(objForm.confirmedBy.value))
			{	
				alert("Confirmation by should be entered");
				objForm.confirmedBy.focus();
				return false;
			}
			return true;
		}
	
		if(getRadioValue(objForm.confRequired) == "N")
		{
			if(!fnIsNull(objForm.confirmedBy.value))
			{
				alert("Confirmation by should not be entered");
				objForm.confirmedBy.focus();
				return false;
			}
			return true;
		}
	}
	else if(locInOutInd == 'I')
	{
		if(getRadioValue(objForm.confRequired) == "Y")
        {
            if(fnIsNull(objForm.confirmedBy.value))
            {
                alert("Confirmation by should be entered");
                objForm.confirmedBy.focus();
				return false;
            }
            return true;
        }

        if(getRadioValue(objForm.confRequired) == "N" || getRadioValue(objForm.confRequired) == "M")
        {
            if(!fnIsNull(objForm.confirmedBy.value))
            {
                alert("Confirmation by should not be entered");
                objForm.confirmedBy.focus();
				return false;
            }
            return true;
        }
	}
	
	return true;
}

function fnSetRadioValues(){
	checkRadio(objForm.partialShipment,partialShipment);
	checkRadio(objForm.transShipment,transShipment);
	checkRadio(objForm.houseAirwaysBill,houseAirwaysBill);
	checkRadio(objForm.reimburseMessage,reimburseMessage);
	checkRadio(objForm.confRequired,confRequired);
	checkRadio(objForm.addConfirmation,addConfirmation);
	if(locInOutInd == 'I') 
	{ 
		checkRadio(objForm.drawnOnOtherBank,drawnOnOtherBank); 
        checkRadio(objForm.autoreimbclaim,autoreimbclaim);
	} 
    checkRadio(objForm.capitalGoodsTrans,capitalGoodsTrans);
	checkRadio(objForm.autoScheduleApplicable,autoScheduleApplicable);
	checkRadio(objForm.autoRenewalApplicable,autoRenewalApplicable);
}

function fnValidateForm() {
	convertToCaps();
	if(!fnValidateMandatoryFields())
		return false;
	if(!validateTypes(objForm))
		return false;
	if(!fnChkFlgs())
		return false;
	if(!validateDate(objForm.latestDateOfShipment))
		return false;
	if(!fnOnBlurReimbMsg())
        return false;
	if(!fnValidatenegotPeriod())	
		return false;
	if(getRadioValue(objForm.addConfirmation)=='P')
    {
		if(funcCode == DcConst.ADVISE_MODE ||funcCode == DcConst.COPY_MODE || (funcCode == DcConst.MODIFY_MODE && locEventType == DcConst.ADVISE_MODE))
    	{
			if(!fnCalcConfAmtPcnt("A"))
        		return false;
			if(!fnValConfPcnt())
    		    return false;
		} 
	}

	return true;
}

function fnValConfPcnt()
{
    if (!fnIsNull(objForm.dcConfPcnt.value))
    {
        var locPcnt = getValInStdFormat(objForm.dcConfPcnt.value);
        var chk1 = (isNaN(locPcnt) || locPcnt.indexOf(" ") != -1);
        var chk2 = ((parseFloat(locPcnt) <= 0) || (parseFloat(locPcnt)>=100));
        if (chk1)
		{
			var errMsg = finbranchResArr.get("FAT000167");
			alert(errMsg);
			objForm.dcConfPcnt.focus();
			return false;
		}
		else if(chk2)
		{
			var errMsg = finbranchResArr.get("FAT008563");
			alert(errMsg);
			objForm.dcConfPcnt.focus();
			return false;
		}
        return true;
    }
}

function fnOnBlurReimbMsg()
{
    objForm = document.forms[0];
	if(getRadioValue(objForm.reimburseMessage) == "Y")
	{
		if (fnIsNull(objForm.dcReimbApplicableRule.value))
		{
			alert(finbranchResArr.get("FAT000200"));
			objForm.dcReimbApplicableRule.focus();
			return false;
		}
	}
    return true;

}

function fnToggleInsrDtlDisplay(val)
{
	if(val == '1'){
		hideImage("sLnk54");
		showImage("sLnk55");
		showImage("sLnk56");
	}
	else{
		hideImage("sLnk55");
		showImage("sLnk54");
		hideImage("sLnk56");
	}

}

function fnPopulateDropDownValues()
{
	if(fnIsNull(confirmedBy))
		confirmedBy = "";
	if (fnIsNull(insuredBy))
		insuredBy = "";
}

function fnOnClickForText(objBtn)
{
	if(objForm.moduleId.value =="DOCCR"){
		fnOnButtonClick(objBtn);
	}
}
function fnShowTextArea()
{
	if((funcCode !=DcConst.MODIFY_MODE)&&(funcCode !=DcConst.COPY_MODE)
			&&(funcCode!=DcConst.ISSUE_MODE)&&(funcCode!= DcConst.ADVISE_MODE) && (funcCode!= DcConst.PREADVICE_MODE))
	{
		if (paysysId == "SWIFT"){
			showTextArea('periodDesc','','N','left','U','N',35,1,'string','N','N','Z');
		} else {
			showTextArea('periodDesc','','N','left','U','N',35,4,'string','N');
		}

	}
	else
	{
		if (paysysId == "SWIFT"){
			showTextArea('periodDesc','','N','left','U','N',35,1,'string','Y','N','Z');
		} else {
			showTextArea('periodDesc','','N','left','U','N',35,4,'string','Y');
		}
	}
}

function fnOnCityChange()
{
    if(fnIsNull(objForm.insCity.value))
    objForm.insCityDesc.value = "";
}
function fnOnCntryChange()
{
    if(fnIsNull(objForm.insCntry.value))
    objForm.insCntryDesc.value = "";
}
function fnOnStateChange()
{
    if(fnIsNull(objForm.insState.value))
    objForm.insStateDesc.value = "";
}
function showTextArea1(dcTextDesc,a,b) 
{ 
	if((funcCode !=DcConst.MODIFY_MODE)&&(funcCode !=DcConst.COPY_MODE)
			&&(funcCode!=DcConst.ISSUE_MODE)&&(funcCode!= DcConst.ADVISE_MODE) && (funcCode!= DcConst.PREADVICE_MODE))
	{
		if(dcTextDesc == "reimSenToRecDesc" || dcTextDesc =="chargesTextDesc" || dcTextDesc =="senToRecDesc")
		{

			showTextArea(dcTextDesc,'','N','left','U','N',a,b,'string','N','N','Z');
		}
		else
			showTextArea(dcTextDesc,'','N','left','U','N',a,b,'string','N');
	}
	else
	{
		if(dcTextDesc == "reimSenToRecDesc" || dcTextDesc =="chargesTextDesc" || dcTextDesc =="senToRecDesc")
		{

			showTextArea(dcTextDesc,'','N','left','U','N',a,b,'string','Y','N','Z');
		}
		else
			showTextArea(dcTextDesc,'','N','left','U','N',a,b,'string','Y');
	}
} 

function fnValidatenegotPeriod()
{
       if ((!isNumber(objForm.negotPeriod.value)) || (getDecIndex(objForm.negotPeriod.value)!= -1)|| (getValInFloat(objForm.negotPeriod.value) < 0)) 
        {
                             alert(finbranchResArr.get("FAT000277")); 
 	objForm.negotPeriod.focus();
	return false;
        }

        return true;
}
function fetchInsuranceDetails()
{
	showDynSearcher('HSRFINS','entity_type=DOCCR|insurance_ccy=:dcAmtccy',':insuNum=insurance_number');
	fnGetInsuranceDetails();
}
function fnGetInsuranceDetails()
{
	if(!fnIsNull(objForm.insuNum.value))
	{
		if(!window.showModalDialog)
		{
			callBackFn_SDS="fnGetInsuranceDetails_callBackFn";
		}
		objForm.cifId.value =dcCifId;
		sendDataToServer('myframe','AGMTINSURANCEDTLS','F','cifId|insuNum','insExpiryDate|insName|insuredCcy||||insuredAmt|||||||policyNo|policyDate');
		if(window.showModalDialog)
		{
			newformatAmt(format, objForm.insuredAmt, insuredCcy, 'N');
			fnAssignUIDate(objForm.policyDate);
			fnAssignUIDate(objForm.insExpiryDate);
			objForm.insuredBy.value = 'A';
		}
	}
}
function fnExplodeInsuranceDetails()
{
	objForm.callerId.value = "insDtls";
	objForm.actionCode.value="EXPLODE";
	objForm.submit();
}
