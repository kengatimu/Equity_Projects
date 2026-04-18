<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : cdepcrit_custom.jsp
<!--Description       : This file should restrict the user to do other transaction when the transaction is still in enter status.
<!--Date              : 19-08-2013
<!--Author            : Pankaj Gaur
<!--Called By         : None
<!--Calling jsp       : None
<!--Menu Option       : HCDEP
<!--Modification History:
<!--    Version No.      Date           Author                     Description
<!--    ---------        ----------     ---------------            --------------------
<!--    0.1             19-08-2013      Pankaj Gaur                Original Version
<!---------------------------------------------------------------------------------------------------------------->

<script>
function fnOnButtonClick(btnObj)
{
	if(btnObj.id == "GO")
	{
		if (!validateData()) {
			return false; 
		}
		convertToCaps();
		//Changes done for CR:-358474 
		if(document.forms[0].funcCode.value == "A" && mopId == "HCDEP")
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
					frm.submitform.value = "ACCEPT";
				}
			}	
		}
		else
		{
			frm.submitform.value = "ACCEPT";
		}
		//Changes end for CR:-358474 
	}
	else
	{
		formReset(frm);
		frm.submitform.value = "CANCEL";
	}
	disableHyperLnks(3);
	enableFormElements(); 
	disableButtons();
	doSubmit(frm.submitform.value);
}

</script>



