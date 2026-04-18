<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : tutmcrit_custom.jsp
<!--Description       : This file should restrict the user to do other transaction when the transaction is still in enter status.
<!--Date              : 19-08-2013
<!--Author            : Pankaj Gaur
<!--Called By         : None
<!--Calling jsp       : None
<!--Menu Option       : HTUTM
<!--Modification History:
<!--    Version No.      Date           Author                     Description
<!--    ---------        ----------     ---------------            --------------------
<!--    0.1             19-08-2013      Pankaj Gaur                Original Version
<!---------------------------------------------------------------------------------------------------------------->

<script>
//Changes done for CR:-358474
function fnOnButtonClick(btnObj)
{
		//alert(btnObj.id);
    	if (btnObj.id == "Accept" || btnObj.id == "Validate")
    	{
        	if(!fnValidateMandatoryFields() || !fnValidateForm()  || !validateTypes(objForm))
        		return false;
		fnEnableDescFields(objForm);
		if(btnObj.id == "Accept")
		{
			if(document.forms[0].funcCode.value == "A" && mopId == "HTUTM")
			{
				var inputNameValues = "funcCode|"+document.forms[0].funcCode.value;
				var outputNames     = "";
				var scrName         = "tranvaldp003.scr";
				var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
				var token = retVal.split("|");
				if(token != undefined)
				{
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
					else
					{
						fnOnFormSubmit("Accept");
					}
				}	
			}
			else
			{
				fnOnFormSubmit("Accept");
			}
			//Changes end for CR:-358474 
		}
		else
			fnOnFormSubmit("Validate");
    	}
   	if (btnObj.id == "Clear")
   	{
			document.location.href = jsUtil.formatUrl('../tutm/tutm_ctrl.jsp?actionCode='+btnObj.id);
        	return true;
    	}
    	return true;
}

</script>



