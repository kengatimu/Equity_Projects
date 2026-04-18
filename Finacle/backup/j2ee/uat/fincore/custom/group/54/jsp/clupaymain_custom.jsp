<!---------------------------------------------------------------------------------------------------------------->
<!--Name              :clupaymain_custom.jsp
<!--Description       : This file should reside custom jsp bank specfic folder.
<!--Date              : 15-07-2013
<!--Author            : Jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : hclupay
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!--	0.1		15-07-2013		jane		Original version
<!--	0.1		31-07-2013		Pankaj Gaur	Change made for CR 360751
<!---------------------------------------------------------------------------------------------------------------->
<script>
function clupaymain_pre_ONLOAD(obj)
	{

	var dco=document.forms[0].customData.value;
				
		var input      = "dco|"+dco;
		var outputNames    = "output|outVal";
		var scrName     =   "b_clupayment.scr";
		var retVal = appFnExecuteScript(input,outputNames,scrName,false);
		var retBuff = retVal.split("|");
		var output = retBuff[0];
		var value = retBuff[1];
		var a = value;
		//alert(a);
		document.forms[0].srcAcctId.value=a;
	}

function fnOnButtonClick(btnObj)
{
    var tmpBtnId;
    if(btnObj.id != undefined)
      tmpBtnId = btnObj.id;
    else
      tmpBtnId = btnObj;
      //Modification For SVS Integration Ends

	if(tmpBtnId == 'Accept')
	{
		enableFields("tranExchgRtCode","tranExchgRt","tranExchgTreaRt");
				
			var frm=document.forms[0];
			var lacAcctCurr=frm.laAcctIdCrncy.value;
			var srcAcctCurr=frm.srcAcctIdCrncy.value;
					
			var inputNameValues = "lacAcctCurr|"+lacAcctCurr+ "|srcAcctCurr|"+srcAcctCurr;
			var outputNames = "rateCode|varCrncy|custVar";
			var scrName = "popexchangerate.scr";
			var retval = appFnExecuteScript(inputNameValues,outputNames,scrName,false);
			var token = retval.split("|");

			var rateCode = token[1];
			var varCrncy = token[3];
			var custVar = token[5];
			frm.tranExchgRtCode.value = rateCode;
			frm.tranExchgRt.value = varCrncy;
			frm.tranExchgTreaRt.value = custVar;
		
		if(templateMode != 'Y'){	
		if(!fnValidateMandatoryFields()) 
		return false;
		}
		if(templateMode != 'Y'){
		if(!fnValidateConditionalMandatoryFields()) 
		return false;
		}
		if(!validateTypes(objForm)) return false;
		enableFields("tranExchgRtCode","tranExchgRt","tranExchgTreaRt");
		
        //added for SVS Integration
        if(funcType == 'U' && tranType == 'T' && SVS_Flag != undefined  && SVS_Flag == "Y" && SVS_Verfication_Mandatory == "Y")
        {//when funtype is U - Payment and Trantype is Transfer
          if(fnDetailsChanged() == true)
           {//After Sign Verfication, if details are changed
            objForm.SVS_Verify_Status.value = '';
           }
          if(objForm.SVS_Verify_Status.value == '')
           {
             showFinacleSignature(tmpBtnId);
             return;
           }
        }
        //Modification For SVS Integration Ends
		fnOnFormSubmit(tmpBtnId);
	}
	else if(tmpBtnId == 'Modify')
	{
		if(FetchClupayAmtDtls=="Y")
			objForm.adjTranFee.value="";

		if(FetchUICAmtDtls == "Y")
		{
			checkRadio(objForm.intRefundOnPrpmtFlg,'N');
			checkRadio(objForm.amtDerivationType,'A');
			objForm.actualAdvIntRefundAmt.value="";
			objForm.advIntRefundPcnt.value="";
		}
		
		  fnLocalGetCollIntOnFlg();
		fnOnFormSubmit(tmpBtnId);
	}
	else if(tmpBtnId == 'Validate')
	{
		fnOnFormSubmit(tmpBtnId);
	}
	else if(tmpBtnId == 'ViewTran')
	{
		if(!fnValidateForm()) return false;
	        fnOnFormSubmit(tmpBtnId);
        }
	else if(tmpBtnId == 'Submit')
	{
		/* validating the amount fields on using the hotkey F10 */
		if(FetchClupayAmtDtls=="Y")
		{
		if(!fnValidateAmtFields()) return false;	
		}
		if(!fnValidateForm()) return false;
		if(FetchClupayAmtDtls=="Y" ||(templateMode=="Y"&&(templateFuncCode !='A' && templateFuncCode !='C' && templateFuncCode !='M')))
		{
			if(!fnIsNull(objForm.adjPrepayFee.value))
			{
				if(getAmtInFloat(objForm.adjPrepayFee.value) < 0)
				{
					alert(finbranchResArr.get("FAT000252"));
					objForm.adjPrepayFee.focus();
					return false;
				}
			}
		}
        //added for SVS Integration
        if(funcType == 'U' && tranType == 'T' && SVS_Flag != undefined  && SVS_Flag == "Y" && SVS_Verfication_Mandatory == "Y")
        { //when funtype is U - Payment and Trantype is Transfer
          if(fnDetailsChanged() == true)
           { //After Sign Verfication, if details are changed
            objForm.SVS_Verify_Status.value = '';
           }
          if(objForm.SVS_Verify_Status.value == '')
           {
             showFinacleSignature(tmpBtnId);
             return;
           }
           
        }
        //Modification For SVS Integration Ends
		fnOnFormSubmit(tmpBtnId);
	}
	else if(tmpBtnId == 'Cancel')
	{
		formReset(objForm);
		fnOnFormSubmit(tmpBtnId);
	}
    if (tmpBtnId == 'ChangeDate')
    {
        
        if (fnIsNull(objForm.loanAcctId.value) && (templateMode != 'Y'))
            {
            alert(finbranchResArr.get("FAT000200"));
                objForm.loanAcctId.focus();
                return;
            }
           fnOnFormSubmit("SCRIPTVALUEDATE");
        return;
    }
}
</script>
