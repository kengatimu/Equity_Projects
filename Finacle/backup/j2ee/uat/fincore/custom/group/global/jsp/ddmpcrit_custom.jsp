<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : ddmpcrit_custom.jsp
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

function ddmpcrit_pre_ONCLICK(obj)
{
	objForm = document.forms[0];
	alert(objForm.rptCode.value);
	if(objForm.rptCode.value == "UFAA")
	{
		objForm.rptCode.value == "0013000100774"
	}
}

function fnButtonClick(objBtn)
{
   objForm = document.forms[0];
   /*Begin Menu Architecture changes
         The action code calue has been set, which is passed to the bean*/
   objForm.actionCode.value=objBtn.id;
   /*End menu Architecture changes*/
   if(objBtn.id == "Clear")
   {
                document.location.href = jsUtil.formatUrl('../ddmp/ddmp_ctrl.jsp?actionCode=' + objBtn.id);
                return true;
   }
   if(objBtn.id == "Accept")
   {

        // fc template code change
       if (!validateTypes(objForm))
       {
           return false;
       }
      convertToCaps();
  if(fnRateCodeValidate(objForm) && fnSubmit(objForm))
      {
         objForm.submitform.value="GETDETAILS";

                 /*Begin Menu Architecture changes
                 The action code calue has been set, which is passed to the bean*/
         objForm.actionCode.value= "GETDETAILS";
         /*End menu Architecture changes*/

         enableFields('payeeCrncy','payeeName','payeeAcctId','tranId','pymtDate','funcCode');
         fnEnableDescFields(objForm);
         disableHyperLnks(10);
         disableButtons();
                 if(CRDRD_Pflg){
                         objForm.FetchCard.disabled = false;
                 }
         objForm.submit();
         return true;
      }
   }
   if(objBtn.id == "Cancel")
   {
        if(!confirm(finbranchResArr.get("FAT000925")))
                 return false;
        else{
                 formResetTextFields(objForm);
                 objForm.funcCode.value = "";
                 doSubmit(objBtn.id);
                 return true;
        }
   }
  if(objBtn.id == "Go")
   {
      convertToCaps();
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
	if (objForm.funcCode.value == 'T')
          {
              if (fnIsNull(objForm.ddTemplateId.value))
              {
                  alert(finbranchResArr.get("FAT000200"));
                  objForm.ddTemplateId.focus();
                  return false;
              }
          }
       // end FC code

      if(fnSubmit(objForm))
      {
         enableFields('pymtDate');
         objForm.submitform.value="GETDETAILS";

         /*Begin Menu Architecture changes
                 The action code calue has been set, which is passed to the bean*/
                 objForm.actionCode.value= "GETDETAILS";
         /*End menu Architecture changes*/

         enableFields('payeeCrncy','payeeName','payeeAcctId','tranId','pymtDate','funcCode');
         fnEnableDescFields(objForm);
         disableHyperLnks(10);
         disableButtons();

                 if(CRDRD_Pflg){
                         objForm.FetchCard.disabled = false;
                 }
         objForm.submit();
         return true;
      }
   }

}


</script>



