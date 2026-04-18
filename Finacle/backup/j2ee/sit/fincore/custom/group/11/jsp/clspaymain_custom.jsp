<!---------------------------------------------------------------------------------------------------------------->
<!--Name              :clspaymain_custom.jsp
<!--Name              :clspaymain_custom.jsp
<!--Description       : This file should reside in custom jsp bank specific folders.
<!--Date              : 15-07-2013
<!--Author            : Pankaj Gaur
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : hclspay
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.2		31-07-2013		Pankaj Gaur	Change made for CR 360751
<!--	0.2		19-08-2013		jane	Change made for CR 368031
<!---------------------------------------------------------------------------------------------------------------->
<script>
function clspaymain_post_ONLOAD(obj)
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
    //modified for svs integration
    if(btnObj.id != undefined)
      tmpBtnId = btnObj.id;
    else
      tmpBtnId = btnObj;

  	
	//Modification For SVS Integration Ends
	if(tmpBtnId == 'Go' && templateFuncCode == "I")
	{
		fnOnFormSubmit('Cancel');
	}

	if(tmpBtnId == 'Accept')
	{
		//alert("inside accept");
		enableFields("tranExchgRtCode","tranExchgRt","tranExchgTreaRt");
				
			var frm=document.forms[0];
			var lacAcctCurr=frm.crAmtCrncy.value;
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
		//Added For SVS Integration
        if(funcType == 'S' && tranType == 'T' && SVS_Flag != undefined  && SVS_Flag == "Y" && SVS_Verfication_Mandatory == "Y")
        { //when funcode is S - Payment and Trantype is Transfer
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
	else if(tmpBtnId == 'Submit')
	{
		/* validating the amount fields on using the hotkey F10 */
		if(!fnValidateAmtFields()) return false;

		if(!fnValidateForm()) return false;

		//Added For SVS Integration
        if(funcType == 'S' && tranType == 'T' && SVS_Flag != undefined  && SVS_Flag == "Y" && SVS_Verfication_Mandatory == "Y")
        { //When functype is S-Payment and Trantype is Transfer
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
	else if(tmpBtnId == 'Modify')
	{
		fnOnFormSubmit(tmpBtnId);
	}
	else if(tmpBtnId == 'Cancel')
	{
		formReset(objForm);
		fnOnFormSubmit(tmpBtnId);
		return;
	}
    if (tmpBtnId == 'ChangeDate' && templateMode != 'Y')
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
	else if(tmpBtnId == 'Explode')
	{
		fnOnFormSubmit(tmpBtnId);
	}
}
</script>
