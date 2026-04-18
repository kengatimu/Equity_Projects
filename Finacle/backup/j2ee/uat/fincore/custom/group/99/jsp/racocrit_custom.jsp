<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : racocrit_custom.jsp 
<!--Description         : This is used to set default value for exchange rate code
<!--						rate code and treasury rate code.
<!--Date                : 08-07-2013
<!--Author              : Pankaj Gaur 
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : HLAUPAY
<!--Modification History:
<!--	Version No.	      	Date			Author 	       	Description
<!--	-------        	----------        	-----------     ------------------
<!--     0.1	    	08-07-2013	        Pankaj Gaur     	Original version
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">
function fnOnButtonClick(objBtn) {
 var tmpBtnId;

    //modified for svs integration
    if(objBtn.id != undefined )
      tmpBtnId = objBtn.id;
    else
      tmpBtnId = objBtn;
	//Modification For SVS Integration Ends  

	if(tmpBtnId == "Clear") {
		formReset(objForm);
		fnOnFormSubmit(tmpBtnId);
	}

	if( (tmpBtnId == "Accept") && !fnValidateForm() ) {
		return false;
	}
    
    //added for SVS Integration
    if( (tmpBtnId == "Accept") && fnValidateForm() )
    {
       if(objForm.fnCode.value == CHARGES && (getRadioValue(objForm.tranType) == TRANSFER)  && SVS_Flag != undefined  && SVS_Flag == "Y" && SVS_Verfication_Mandatory == "Y")
            {
                 if(fnDetailsChanged() == true)
                   { //After Signature Verfication If Details are Changed
                     objForm.SVS_Verify_Status.value = '';
                   }
                 if(objForm.SVS_Verify_Status.value == '')
                    {
                       showFinacleSignature(tmpBtnId);
                        return;
                    }
            }
     }
	 //Modifications For SVS Integration Ends
  //CHANGES MADE FOR TO:352636

     if(tmpBtnId == "Accept")
     {
    		/* If Crncy Code for Loan Account and Source Account is Same then no need of
        Tran. Exchange Rate. So clearing the Fileds*/
		if(objForm.srcAcctIdCrncy.value == objForm.crncyCode.value)
		{
                objForm.tranRateCode.value = "";
                objForm.tranRate.value = "";
                objForm.tranTreasuryRate.value = "";
		}
		else
		{
			var frm=document.forms[0];
			var lacAcctCurr=frm.crncyCode.value;
			var srcAcctCurr=frm.srcAcctIdCrncy.value;
					
			var inputNameValues = "lacAcctCurr|"+lacAcctCurr+ "|srcAcctCurr|"+srcAcctCurr;
			var outputNames = "rateCode|varCrncy|custVar";
			var scrName = "popexchangerate.scr";
			var retval = appFnExecuteScript(inputNameValues,outputNames,scrName,false);
			var token = retval.split("|");

			var rateCode = token[1];
			var varCrncy = token[3];
			var custVar = token[5];
			frm.tranRateCode.value = rateCode;
			frm.tranRate.value = varCrncy;
			frm.tranTreasuryRate.value = custVar;
		}

	}

//CHANGES ENDS HERE

	if(fnIsNull(objForm.recoveryAmtCrncy.value))
	{
		if(fnIsNull(objForm.srcAcctId.value))
			objForm.recoveryAmtCrncy.value = objForm.crncyCode.value;
		else
			objForm.recoveryAmtCrncy.value = objForm.srcAcctIdCrncy.value;
	}

	if(fnIsNull(objForm.srcAcctId.value))
		objForm.recoveryAmtCrncy.value = objForm.crncyCode.value;
	else
		objForm.recoveryAmtCrncy.value = objForm.srcAcctIdCrncy.value;

	return fnOnFormSubmit(tmpBtnId);
}
// EBL CUSTOMISATION START 
function racocrit_post_ONLOAD(obj)
	{
	//alert("sirgeorge");
		{
		var radioButtons = document.getElementsByName('tranType');
		radioButtons[0].checked = false;
	        radioButtons[0].disabled = true;
                radioButtons[1].checked = true;

		fnProtectFieldsBasedOnTranType();
		if (radioButtons[1].checked == true)
		{ 
		  radioButtons[0].checked = false;
		  radioButtons[0].disabled = true;
		  fnEnableDescFields(objForm);
	          enableFields("srcAcctId","refNo","tranDate");
		}
		}
	
	}
// EBL CUSTOMISATION ENDS

</script>
