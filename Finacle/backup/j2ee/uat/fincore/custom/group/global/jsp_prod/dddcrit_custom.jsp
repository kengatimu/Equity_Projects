<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : dddcrit_custom.jsp
<!--Description       : This file should restrict the user to do other transaction when the transaction is still in enter status.
<!--Date              : 19-08-2013
<!--Author            : Pankaj Gaur
<!--Called By         : None
<!--Calling jsp       : None
<!--Menu Option       : HDDD
<!--Modification History:
<!--    Version No.      Date           Author                     Description
<!--    ---------        ----------     ---------------            --------------------
<!--    0.1             19-08-2013      Pankaj Gaur                Original Version
<!---------------------------------------------------------------------------------------------------------------->

<script>
function fnOnButtonClick(btnObj)
{
	
  if(btnObj.id == "Accept")
   {
	 var inputNameValues = "funcCode|A";
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

   if( (btnObj.id == "Accept") && !fnValidateForm() )
      return false;
   else if (btnObj.id == "Clear") {
      formReset(objForm);

      checkRadio(objForm.createFeeFlg,'N');
   }

   objForm.submitform.value = btnObj.id;
   convertToCaps();
   disableHyperLnks(2);
   disableButtons();
   fnEnableDescFields(objForm);
   objForm.submit();
   return true;
}

</script>



