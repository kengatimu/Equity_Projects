<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : ddccrit_custom.jsp
<!--Description       : This file should restrict the user to do other transaction when the transaction is still in enter status.
<!--Date              : 16-08-2013
<!--Author            : Priyanka T 
<!--Called By         : None
<!--Calling jsp       : None
<!--Menu Option       : HDDC
<!--Modification History:
<!--    Version No.      Date           Author                     Description
<!--    ---------        ----------     ---------------            --------------------
<!--    0.1             16-08-2013      Priyanka T                       Original Version
<!---------------------------------------------------------------------------------------------------------------->

<script>
function fnOnButtonClick(objBtn)
{
	//function ddccrit_pre_ONCLICK(obj)
	///{

if ((objBtn.id=="Accept") &&(profileId=="54"))
        {
	//alert (objForm.funcCode.value);
                 //Changes done for CR:-358474
                 if(objForm.funcCode.value == 'P')
                 {
					var dco=userId;
					var input      = "dco|"+dco;
					var outputNames    = "output|outVal";
					var scrName     =   "b_workclass.scr";
					var retVal = appFnExecuteScript(input,outputNames,scrName,false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var a = value;
					if (a<110)
					{
						{
							alert("Only Workclass 110 and above allowed to Post")
							return false;
						}
					 }
				}
		}

	 if(objBtn.id == 'Accept')
        {
		//alert (objForm.funcCode.value);
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

   if(objBtn.id == 'getValueDate')
   {
           if (fnIsNull(objForm.ddAcctNum.value) && (objForm.isNonSysDD[0].checked))
           {
            alert(finbranchResArr.get("FAT000200"));
            objForm.ddAcctNum.focus();
            return;
        }
        doSubmit("SCRIPTVALUEDATE");
        return;
   }
   if (objBtn.id == 'Clear')
   {
      formReset(objForm);
      /*----B-O Clear button functionality corrected, done with MAC----*/
//    objForm.isNonSysDD.value = "N";
//    objForm.chkisNonSysDD.checked = false;
          setRadioValue('isNonSysDD',"N");
          objForm.isNonSysDD[1].checked = true;

//    objForm.createFeeFlg.value = "N";
//    objForm.chkcreateFeeFlg.checked = false;
          setRadioValue('createFeeFlg',"N");
          objForm.createFeeFlg[1].checked = true;

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
      objForm.submitform.value = objBtn.id;
      objForm.submit();
   }
    else if(objBtn.id == 'endMenu')
   {
    objForm.submitform.value = objBtn.id;
        convertToCaps();
        disableHyperLnks(6);
        disableButtons();
        enableFormElements();
        fnEnableDescFields(objForm);
        objForm.submit();
        return true;
   }

    else if (doLocalValidations())
   {
           objForm.submitform.value = objBtn.id;
           convertToCaps();
           disableHyperLnks(6);
           disableButtons();
           enableFormElements();
           fnEnableDescFields(objForm);
           objForm.submit();
           return true;
   }
   else
   {
           return false;
   }

}
</script>
