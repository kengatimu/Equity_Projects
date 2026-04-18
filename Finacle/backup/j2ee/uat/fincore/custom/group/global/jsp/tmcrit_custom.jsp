<!-------------------------------------------------------------------------------------------------------------------------------------------------------------->
<!--Name              : tmcrit_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder. 
<!--Date              : 07-05-2016
<!--Author            : jane
<!--Called By         : None 
<!--Calling jsp       : None
<!--Menu Option       : HTM
<!--Modification History:
<!--    Version No.    Date				Author                          Description
<!--    ---------               ----------			---------------                     --------------------
<!--     0.1            07-05-2016			 jane                                Original version	 
<!---------------------------------------------------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>

<script type ="text/javascript">
function fnOnButtonClick(btnObj)
{
	var tranDtObj = objForm.tranDate;
	var uiObj = eval("objForm." + tranDtObj.getAttribute("vFldId"));
	if (uiObj != null && uiObj != undefined) {
		uiObj.blur();
	}

    	if (btnObj.id == "Go" || btnObj.id == "Validate")
    	{
        	if(!fnValidateMandatoryFields() || !fnValidateForm()  || !validateTypes(objForm) || !fnValidateAddtlTranCrit())
        		return false;
		fnEnableDescFields(objForm);
		if(btnObj.id == "Go")
			{
			tranTypeSubType=document.forms[0].tranTypeSubType.value;
			//alert(tranTypeSubType);
			if ((tranTypeSubType=="T/O")||(tranTypeSubType=="T/IC")||(tranTypeSubType=="T/IP")||(tranTypeSubType=="T/SI")||(tranTypeSubType=="T/BS")||(tranTypeSubType=="T/SC"))
			{
				//alert("am in2");
				alert("Cannot use tran type");
				document.forms[0].tranTypeSubType.focus();
				return false;
			}
			fnOnFormSubmit("Accept");
			}
		else
			{
			fnOnFormSubmit("ValidateCriteria");
			}
    	}
   	if (btnObj.id == "Clear")
   	{
			document.location.href = jsUtil.formatUrl('../tm/tm_ctrl.jsp?actionCode='+btnObj.id);
        	return true;
    	}
    	return true;
}

function tmcrit_pre_ONCLICK(Obj) {   
	var fnCode1  = document.forms[0].funcCode.value;
	var tId = document.forms[0].tranId.value; 
	if(fnCode1 == "M" || fnCode1 == "P" || fnCode1 == "D" || fnCode1 == "V")
	{              
		var tranDate = document.forms[0].tranDate.value;
		var tranId = document.forms[0].tranId.value.toUpperCase();
		var inputNameValues = "tranDate|"+tranDate+"|tranId|"+tranId;
		var outputNames = ""; 
		 
		var retVal = appFnExecuteScript(inputNameValues,outputNames,'tm.scr',false);
		var retBuff = retVal.split("|");
		var output = retBuff[0];
		var value = retBuff[1];
		if(value == "F")
		{
			alert("Transaction initiated by another sol, only inquiry is allowed");
			document.forms[0].tranId.focus();
			return false;													
		}																					
	}
	//setFieldsToCustomData("funcCode","tranTypeSubType");
	//----------------------------------Edwin
	if (profileId == 54)
	{
		if(fnCode1 == "A")
		{
			tranTypeSubType=document.forms[0].tranTypeSubType.value;
			//alert(tranTypeSubType);
			if(tranTypeSubType=="T/I")
			{
				alert("Use VPH for Inward Clearing");
				document.forms[0].tranTypeSubType.focus();
				return false;
			}
		}
	}
	//-------------------------------------Edwin
}

</script>
