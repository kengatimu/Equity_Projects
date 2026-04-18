<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : ddxmicrit_custom.jsp
<!--Description         : This file should restrict user to do other transaction when the transaction is in enter status. 
<!--Date                : 16-08-2013
<!--Author              : Priyanka T
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HDDXMI
<!--Modification History:
<!--    Version No.       Date               Author         Description
<!--    -------         ----------         -----------      ------------------
<!--     0.1            16-08-2013           Priyanka T         Original version
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript">

function fnOnButtonClick(objBtn){
        if(objBtn.id == 'Clear' || objBtn.id == 'Cancel'){
                if(confirm(finbranchResArr.get("FAT000360"))){
                        objForm.actionCode.value = objBtn.id;
                        formReset(objForm);
                        fnResetRadioValues();
                        objForm.submit();
                }
        } else {
                if(objBtn.id == 'GetValueDate')
                {
                        if (fnIsNull(objForm.ddAcctId.value))
                        {
                                alert(finbranchResArr.get("FAT000200"));
                                objForm.ddAcctId.focus();
                                return;
                        }
                        objForm.actionCode.value = objBtn.id;
                        objForm.submit();
                        return;
                }
		 if(objBtn.id == 'Go')
                {
                        if(objForm.funcCode.value == 'A')
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
                if(!fnValidateForm()) return false;

                objForm.actionCode.value = objBtn.id;
                convertToCaps();
                disableButtons();
                disableHyperLnks(20);
                objForm.submit();
        }
}


</script>
