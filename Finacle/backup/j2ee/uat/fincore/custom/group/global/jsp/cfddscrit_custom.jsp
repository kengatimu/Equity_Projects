<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : cfddscrit_custom.jsp
<!--Description         : This file should restrict the user to do other transaction when the transaction is still in enter status. 
<!--Date                : 20-08-2013
<!--Author              : Priyanka T
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HCFDDS
<!--Modification History:
<!--    Version No.       Date               Author         Description
<!--    -------         ----------         -----------      ------------------
<!--     0.1            20-08-2013          Priyanka T      Original version - TO 358474
<!---------------------------------------------------------------------------------------------------------------->

<script language="javascript">
function fnOnButtonClick(objBtn)
{
        objForm.actionCode.value = objBtn.id;
	 if(objBtn.id == 'Accept')
        {
		 //Changes done for CR:-358474
		 if(objForm.funcCode.value == 'C')
                 {
                        var inputNameValues = "funcCode|"+objForm.funcCode.value;
                        var outputNames     = "";
                        var scrName         = "tranvaldp003.scr";
                        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
                        var token = retVal.split("|");
                        if(token != undefined){
                             var errorMsg = token[1];
                             var errorMsgRef = token[3];
	          if(!fnIsNull(errorMsg))
                             {
                                    alert(errorMsg);
                                    return false;
                             }
                             if(!fnIsNull(errorMsgRef))
                             {
                                    alert(errorMsgRef);
                                    return false;
                             } 
                             }
                 }

        }
	//Changes end for CR:-358474

        if (objBtn.id == 'Clear')
        {
                formReset(objForm);
                setRadioValue('createFeeFlg',"N");
                /*----B-O Clear button functionality corrected, done with MAC----*/

                objForm.ddNum.value="";
                objForm.ddAcctNum.value="";
                objForm.ddAmt.value="";
                objForm.tranType.value="";
                objForm.tranId.value="";
                objForm.funcCode.value="";
                objForm.ddValueDate.value="";
                objForm.ddIssDate.value="";
                objForm.issBankCode.value="";
                objForm.issBrCode.value="";
                objForm.issExtnCounter.value="";

                /*----E-O Clear button functionality corrected, done with MAC----*/

                objForm.submit();
        }
        else if(objBtn.id == 'endMenu')
        {
                convertToCaps();
                disableHyperLnks(6);
                disableButtons();
                enableFormElements();
                fnEnableDescFields(objForm);
                objForm.submit();
        }

  	else if(objBtn.id == 'GetValueDate')
        {
                objForm.createFeeFlg.value = getRadioValue(objForm.createFeeFlg);
                objForm.actionCode.value = "SCRIPTVALUEDATE";
                objForm.submit();
        }

        else if (doLocalValidations())
        {
                convertToCaps();
                disableHyperLnks(6);
                disableButtons();
                enableFormElements();
                fnEnableDescFields(objForm);
                objForm.submit();
        }

}

</script>
