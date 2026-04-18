var browserName = navigator.appName;

/*From here the code for workflow starts*/

/* This function is called from the custom jsps generated from ONS WorkBenach
 * Tool
*/

function checkCustErrExecNextStep(Message)
{
	if(Message == "" || Message == "NULL")
	execNextStep();
}

function checkErrExecNextStep()
{
	if((eval(this.dispErrLLSize) != undefined && dispErrLLSize == 0))
	{
		if((eval(this.dispUsrErrLLSize) != undefined && dispUsrErrLLSize == 0) || (eval(this.dispUsrErrLLSize) == undefined))		
			execNextStep();
	}
}

function nextWFAction(paramType, strTabId, CB_REQD)
{	
	cust_enableButtons();
	if (arguments.length <= 2)
		CB_REQD = "N";
		
	if(paramType.toUpperCase() == "OBJ")
	{
		strTabId.click();
		return true;
	}
	else if(paramType.toUpperCase() == "ID")
	{
		cust_getStatus(CB_REQD, strTabId);
	}
}

function cust_enableButtons()
{
    var obj=document.forms[0].elements;
    var len=obj.length;
    for(var i=0;i<len;i++) 
    {
        switch(obj[i].type) 
        {
            case "button" :
            case "submit" :
            case "reset" :
            obj[i].disabled=false;
            break;
        }
    }
}

function cust_getStatus(sTabReqd, sTabName)
{
	var frm = document.forms[0];
	var objCB = eval("frm.chk"+sTabName);
	if(fnValidateForm(sTabName)) 
	{
		if( (sTabReqd == "Y") && !(objCB.checked) ) {
			if( (objCB.getAttribute("fds") == null)||(objCB.getAttribute("fds") == "")||(objCB.getAttribute("fds") != "Y") )
				objCB.click();
		}
		frm.submitform.value=sTabName;
		frm.tabName.value = sTabName;
		frm.actionCode.value = "gotoTab";
		cust_convertToCaps();
		cust_disableButtons();
		cust_fnEnableDescFields(frm);
		if(objCB !=undefined)
			objCB.click();
		frm.submit();
		return true;
	} else 
	{
		return false;
	}
}


function generic_wf(pageName,object) 
{
	
	checkErrExecNextStep();

}

function execNextStep()
{
	var objName = null;
	try
	{
		var objType = nextAction.substring(0,nextAction.indexOf("|"));
		if(objType != null)
		{
			objName = nextAction.substring(nextAction.indexOf("|")+1,nextAction.length);
			if(objType == "BUTTON")
			{
				objType = "OBJ";
				objName = eval("document.forms[0]."+objName);
			}
			else
			{
				objType = "ID";
			}
		}
		nextWFAction(objType,objName);
	 }catch(e)
	 	{
	 		cust_enableButtons();
	 		if(undefined != eval(document.forms[0].Continue))	
			document.forms[0].Continue.disabled=true;
	 		try
	 		{
	 			if(undefined != eval(document.forms[0].Cancel))	
				document.forms[0].Cancel.disabled=true;
	 			if(undefined != eval(document.forms[0].cancel))	
				document.forms[0].cancel.disabled=true;
	 			if(undefined != eval(document.forms[0].Back))	
				document.forms[0].Back.disabled=true;
	 			if(undefined != eval(document.forms[0].back))	
				document.forms[0].back.disabled=true;
	 		}catch(e){}
	 		
	 	}
}

function cust_convertToCaps()
{
	var obj=document.forms[0];
    var len=obj.length;

	for(i=0;i<len;i++)
	{
		if (obj[i].type == "text" || obj[i].type == "hidden" || obj[i].type == "textarea" )	{
			obj[i].value = fnTrim(obj[i].value);
		}
		if( ((obj[i].type == "text")||(obj[i].type == "textarea")) && obj[i].getAttribute("fdt") != 'lcase')
        {
			var txtStr = obj[i].value;
			obj[i].value = txtStr.toUpperCase();
		}
	}
}
function cust_disableButtons()
{
	var obj=document.forms[0].elements;
	var len=obj.length;
	for(var i=0;i<len;i++)
	{
		switch(obj[i].type)
		{
			case "button" :
			case "submit" :
			case "reset" :

			obj[i].disabled=true;
			break;
		}
	}
	cust_disableTabs();
}
function cust_disableTabs()
{
    var sTabcss = get_lyr_css('sTab');
    var hTabcss = get_lyr_css('hTab');

    if ((hTabcss != undefined && hTabcss != null) && (sTabcss != undefined && sTabcss != null))
    {
        hTabcss.cssText = "position:absolute; visibility:visible;"
        sTabcss.cssText = "position:absolute; visibility:hidden;"
    }
}

function cust_fnEnableDescFields(objForm)
{
	cust_fnEnableFieldsBasedOnAttribute(objForm, "fds", "Y")
}

function cust_fnEnableFieldsBasedOnAttribute(objForm, sAttributeName, sAttributeValue)
{
	var frmElem = objForm.elements;
	var frmElemLen = frmElem.length;
	var fieldObj = "";
	var fieldObjAttributeValue = "";
	for(iCount = 0; iCount < frmElemLen; iCount++)
	{
		fieldObj = frmElem[iCount];
		fieldObjAttributeValue = fieldObj.getAttribute(sAttributeName);

		/* field attribute value is null or blank, skip */
		if( (fieldObjAttributeValue == null) || (fieldObjAttributeValue == "") ) continue;
		fieldObjAttributeValue = fieldObjAttributeValue.toUpperCase();

		/* field attribute value is found, disable the field object*/
		if(fieldObjAttributeValue == sAttributeValue.toUpperCase()) fieldObj.disabled = false;
	}
}


function cust_disableButtons()
{
	var obj=document.forms[0].elements;
	var len=obj.length;
	for(var i=0;i<len;i++)
	{
		switch(obj[i].type)
		{
			case "button" :
			case "submit" :
			case "reset" :

			obj[i].disabled=true;
			break;
		}
	}
}

