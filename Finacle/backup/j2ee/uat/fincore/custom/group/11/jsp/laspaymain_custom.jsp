<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : laspaymain_custom.jsp 
<!--Description         : This is used to set todgrant to no and it is protect.
<!--Date                : 02-02-2013
<!--Author              : Sateesh 
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : HLASPAY
<!--Modification History:
<!--	Version No.	      	Date			Author 	       	Description
<!--	-------        	----------        	-----------     ------------------
<!--     0.1	    	02-02-2013	        Sateesh	        	Original version
<!--	 0.2			08-07-2013			Pankaj Gaur		Changes made according to issue 352636	
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">
function post_ONLOAD() 
{		
	if(mopId == "HLASPAY" )
	{
		//alert("Main 1");
		var radioButtons = document.getElementsByName('todGrant');
		radioButtons[0].checked = false;
		radioButtons[1].checked = true;
		radioButtons[0].disabled = true;
		radioButtons[1].disabled = true;
		//Kim Start -(361661)
		document.forms[0].loanAcctId.focus();
		//Kim End -(361661)
	}
}

function fnOnButtonClick(btnObj)
{
    var tmpBtnId;
    //modified for svs integration
    if(btnObj.id != undefined)
      tmpBtnId = btnObj.id;
    else
      tmpBtnId = btnObj;
	//modification for svs integration ends
    if (!isNumber(objForm.crAmt.value))
    {
		objForm.crAmt.focus();
		return false;
    }
    else
    {
    			var prec = getPrec(objForm.crAmtCrncy.value);
		if(!fnValidateAmount(objForm.crAmt.value,2)) return false;
    }
	if (sReferralMode == 'I' || sReferralMode == 'S') 
	{
		if (!isNavigationRequired(tmpBtnId, curCnt, recCnt, null))
		{
			return false;
		}
	}
	if(tmpBtnId == 'Accept')
	{
		if((tranType == 'T') && (funcType == 'S'))
		{
			if((!fnIsNull(objForm.instrmntDate.value)) && fnIsNull(objForm.instrmntNum.value))
			{
				alert(finbranchResArr.get("FAT000026"));
				objForm.instrmntNum.focus();
		        return false;
			}
			if((!fnIsNull(objForm.instrmntNum.value)) && fnIsNull(objForm.instrmntDate.value))
			{
				alert(finbranchResArr.get("FAT000027"));
				fnSetFocusForDate(objForm.instrmntDate);
				return false;
			}
			if((!fnIsNull(objForm.instrmntDate.value)) && (!fnIsNull(objForm.instrmntNum.value)) && fnIsNull(objForm.instrmntAlpha.value))
			{
				alert(finbranchResArr.get("FAT000025"));
				objForm.instrmntAlpha.focus();
		        return false;
			}
			
		}
		 
		if(!fnValidateMandatoryFields()) return false;		
		if(!fnValidateConditionalMandatoryFields()) return false;		
		if(!validateTypes(objForm)) return false;
		enableFields("tranExchgRtCode","tranExchgRt","tranExchgTreaRt");
		fnShowTODExplode();	


		/* If Crncy Code for Loan Account and Source Account is Same then no need of
        Tran. Exchange Rate. So clearing the Fileds*/
		/*if(objForm.srcAcctIdCrncy.value == objForm.laAcctIdCrncy.value){
                objForm.tranExchgRtCode.value = "";
                objForm.tranExchgRt.value = "";
                objForm.tranExchgTreaRt.value = "";
        }*/

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
			


        //Added for SVS Integration
        if(tranType == 'T' && objForm.drFrmAcct.value == 'Y' && SVS_Flag != undefined  && SVS_Flag == "Y" && SVS_Verfication_Mandatory == "Y")
        { //If trantype is transfer and Operative Account
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
        //modification for svs integration ends
		fnOnFormSubmit(tmpBtnId);
	}
	else if(tmpBtnId == 'Submit')
	{
		if(funcType == 'V' && allVisitFlg != 'Y') 
		{
			alert(finbranchResArr.get("FAT000886"));
			return false;
		}
		if(!fnValidateForm(tmpBtnId)) return false;
		if(!fnNegativeAmtcheck()) return false;
		fnOnFormSubmit(tmpBtnId); 
	}
	else if(tmpBtnId == 'Modify')
	{
		fnOnFormSubmit(tmpBtnId);
	}
	else if(tmpBtnId == 'Cancel')
	{
	    if(!fnShowCancelDialog(funcType))
		return false;
		objForm.record[1].checked = true;
		setRadioValue('record',"N");
		formReset(objForm);
		fnOnFormSubmit(tmpBtnId);
	}
	else if(tmpBtnId == 'SummaryInfo')
	{
		fnOnFormSubmit(tmpBtnId);
	}
	else if(tmpBtnId == 'Explode')
	{
		fnOnFormSubmit(tmpBtnId);
	}
	else if(tmpBtnId == 'PrevRec')
	{
		fnIsPageEmpty();
		objForm.direction.value = "PrevRec";
	        fnOnFormSubmit("PrevRec");
    	}
	if (tmpBtnId == 'ChangeDate')
	{
		if (fnIsNull(objForm.loanAcctId.value))
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
