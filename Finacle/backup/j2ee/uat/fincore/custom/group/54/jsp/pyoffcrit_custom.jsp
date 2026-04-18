<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : pyoffcrit_custom.jsp 
<!--Description         : This is used to set todgrant to no and it is protect.
<!--Date                : 01-08-2013
<!--Author              : Pankaj Gaur 
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : HPAYOFF
<!--Modification History:
<!--	Version No.	      	Date			Author 	       	Description
<!--	-------        	----------        	-----------     ------------------
<!--	 0.2			01-08-2013			Pankaj Gaur		Changes made according to issue 363102	
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">
function pyoffcrit_post_ONCHANGE(obj)
{
	if (obj.id == "funcCode")
    	{
		if ((obj.value == "I") || (obj.value == "R"))
		{
			if (document.forms[0].tranTypeSubType.value == "")
			{
				document.forms[0].tranTypeSubType.value = "T/CI";
			}
		}
    	}

	if(mopId == "HPAYOFF" )
	{
	if (funcCode == "R" )
		{
			if(obj.id=="acctId")
			{
			var dco=document.forms[0].acctId.value;
			var input      = "dco|"+dco;
			var outputNames    = "output|outVal";
			var scrName     =   "b_clupayment.scr";
			var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			//alert(a);
			document.forms[0].collectRefundAcctNo.value=a;

			}
		}
	}

}

function fnOnButtonClick(btnObj)
{
    var tmpBtnId;

    //modified for svs integration
    if(btnObj.id != undefined )
      tmpBtnId =btnObj.id;
    else
      tmpBtnId = btnObj;
	//modification for SVS Integration Ends  

	if( (tmpBtnId == "Submit") && !fnValidateForm() ) {
		return false;
	}
    //Added for SVS Integration
    if( (tmpBtnId == "Submit") && fnValidateForm() )
     {
     if(funcCode == FUNC_PAYOFF && objForm.tranType.value == TRANSFER && SVS_Flag != undefined  && SVS_Flag == "Y" && SVS_Verfication_Mandatory == "Y")
         {
            if(fnDetailsChanged() == true)
             { //After Signature Verfication if details are changed
              objForm.SVS_Verify_Status.value = '';
             }
            if(objForm.SVS_Verify_Status.value == '')
             {
              showFinacleSignature(tmpBtnId);
              return;
             }
         }
      }
	 // Modification for SVS Integration Ends 
	if (tmpBtnId == 'ChangeDate')
    {
        if (fnIsNull(objForm.acctId.value))
            {
                alert(finbranchResArr.get("FAT000200"));
                objForm.acctId.focus();
                return;
            }
    }	
	if(funcCode == FUNC_PAYOFF && objForm.tranType.value == "T" && objForm.tranSubType.value == "CI")
	{
		if((!fnIsNull(objForm.instrmntType.value)))
		{
			if(fnIsNull(objForm.instrmntDate.value) && fnIsNull(objForm.instrmntNum.value) && fnIsNull(objForm.instrmntAlpha.value))
			{
				alert(finbranchResArr.get("FAT000023"));
				objForm.instrmntNum.focus();
				return false;
			}
		}
		if((!fnIsNull(objForm.instrmntDate.value)) && fnIsNull(objForm.instrmntNum.value))
		{
			alert(finbranchResArr.get("FAT000026"));
			objForm.instrmntNum.focus();
			return false;
		}
		if((!fnIsNull(objForm.instrmntNum.value)) && fnIsNull(objForm.instrmntDate.value))
		{
			alert(finbranchResArr.get("FAT000027"));
			objForm.instrmntDate.focus();
			return false;
		}
		if((!fnIsNull(objForm.instrmntDate.value)) && (!fnIsNull(objForm.instrmntNum.value)) && fnIsNull(objForm.instrmntAlpha.value))
		{
			alert(finbranchResArr.get("FAT000025"));
			objForm.instrmntAlpha.focus();
			return false;
		}

	}
	fnCtrlFldsBasedOnTranType();
	convertToCaps();
	if(tmpBtnId == "Submit")
		objForm.submitform.value = "Accept";
	else	
		objForm.submitform.value = tmpBtnId;
	fnEnableDescFields(objForm);
	enableFields("tranRateCode","tranRate","tranTreasuryRate","treasuryRefNum","feeRateCode","feeRate","tranTypeSubType","collectRefundAcctNo","feeTreasuryRate","treasuryRefNum","payoffReason");
	//Changes made according to issue 363102
	//alert("inside custom jsp");
	var frm=document.forms[0];
	var lacAcctCurr=frm.crncyCode.value;
	//alert("from currency"+lacAcctCurr);
	var srcAcctCurr=frm.collCrncyCode.value;
	//alert("to currency"+srcAcctCurr)
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
	//Changes end for 363102
	
	disableButtons();
	disableHyperLnks(8);
	if(funcCode == FUNC_VERIFY || funcCode == FUNC_CANCEL) 
	{ 
	    objForm.tranTypeSubType.disabled = false; 
	    objForm.collectRefundAcctNo.disabled = false; 
	    objForm.instrmntNum.disabled = false;
	    objForm.instrmntAlpha.disabled = false;
	    objForm.instrmntType.disabled = false;
	    objForm.instrmntDate.disabled = false;
	} 
	fnEnableFormDataControls(objForm); 
	objForm.submit();
	return true;
}
</script>
