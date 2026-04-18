<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : imcdtl_custom.jsp 
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
function fnOnButtonClick(btnObj)
{
    var tmpBtnId;

    //modified for svs integration
    if(btnObj.id != undefined )
      tmpBtnId = btnObj.id;
    else
      tmpBtnId = btnObj;
	//modification for svs integration ends
	if(tmpBtnId == 'Accept')
	{
		if (objForm.refundPcnt.value != null)
		{
			if( objForm.refundPcnt.value <0 || objForm.refundPcnt.value >100)
			{
				alert(finbranchResArr.get("FAT004436"));
				objForm.marginMoneyPcnt.focus();
				return false;
			}
		}

		newformatAmt(format,objForm.crAmt,objForm.laAcctIdCrncy.value,"N")
		newformatAmt(format, objForm.amtToRefund,objForm.laAcctIdCrncy.value, "N");	
		if((tranType == 'T') && (funcType == 'U'))
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

//CHANGES MADE FOR TO:352636
	
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
		
//CHANGES ENDS HERE

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
        //Modification for SVS Integration Ends
		fnOnFormSubmit(tmpBtnId);
	}
	else if(tmpBtnId == 'Modify')
	{
		fnOnFormSubmit(tmpBtnId);
	}
	else if(tmpBtnId == 'Submit')
	{
		if(funcType == 'V' && allVisitedFlg != 'Y') 
		{
			alert(finbranchResArr.get("FAT000886"));
			return false;
		}
		if(!fnValidateForm(tmpBtnId)) return false;
		fnOnFormSubmit(tmpBtnId);
	}
	else if(tmpBtnId == 'Cancel')
	{
		if((funcType != 'V') && confirm(finbranchResArr.get("FAT000925"))==false)
                return false;
                else
                {
			setRadioValue('record',"N");
			formReset(objForm);
			fnOnFormSubmit(tmpBtnId);
                }
	}
	else if(tmpBtnId == 'SummaryInfo')
	{
		fnOnFormSubmit(tmpBtnId);
	}
	else if(tmpBtnId == 'ViewTran')
    	{
		 if(!fnValidateForm(tmpBtnId)) return false;
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
