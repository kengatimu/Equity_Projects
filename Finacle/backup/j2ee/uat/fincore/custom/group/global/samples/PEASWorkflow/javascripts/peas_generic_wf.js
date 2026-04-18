var browserName = navigator.appName;

/*From here the code for workflow starts*/

function checkErrExecNextStep()
{
	if((eval(this.dispErrLLSize) != undefined && dispErrLLSize == 0) || (eval(this.dispUsrErrLLSize) != undefined && dispUsrErrLLSize == 0))
	{
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

function getWFProcessId()
{
	var inputProcessname	= "processId|" + WFProcessId;
	var outputNames			= "parentProcId";
	scrName					= "getParentProcId.scr";
	retVal 					= appFnExecuteScript(inputProcessname, outputNames, scrName, true);

	if (retVal == null || retVal == undefined)
		return false;
	else
		return true;
}

function appFnExecuteScript(inputNameValues,outputNames,scrName,isPopulationReq)
{
	var sUrl = "../custom/jsp/cust_frm_fetch.jsp?";
	
	if(!cust_fnIsNull(inputNameValues))
			sUrl += "&inputs="+escape(inputNameValues);

	if(cust_fnIsNull(scrName))
	{
		alert("Script Name is mandatory");
		return;
	}
	
	sUrl += "&scrName="+scrName;

	if (isPopulationReq && cust_fnIsNull(outputNames))
	{
		alert("Output Names are mandatory");
		return;
	}
	
	var xMax = screen.width, yMax = screen.height;
	var xOffset = (xMax - 120), yOffset = (yMax - 150);
	var params =
	"dialogWidth=0px;dialogHeight=0px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
	params += ";status=no;toolbar=no;menubar=no;resizable=yes;help=no;center=no";
	
	var retVal = "";
	if("Netscape" == browser_name)
	{
		window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes
		,toolbar=no,menubar=no,help=no");
	}
	else
	{
		retVal = window.showModalDialog(sUrl,"",params);
	}
	if (retVal == null || retVal == undefined)
	{
		return retVal;
	}
	
	var retBuff		= retVal.split("|");
	var retBuffLen 	= retBuff.length;
	
	if (retBuff[0] == 'Err')
	{
		var str = "";
		for (var i=1; i<retBuffLen; i++)
		{
			str += retBuff[i] + "\n";
		}
		alert(str);
		return false;
	}
	if (!isPopulationReq)
	{
		alert("pop req is false");
		return retVal;
	}
	
	var frm			= document.forms[0];
	var outBuff 	= outputNames.split("|");
	var outBuffLen 	= outBuff.length;
	
	for (var i=0; i<outBuffLen; i++)
	{
		for (var j=0; j<retBuffLen; j++)
		{
			if (outBuff[i] == retBuff[j])
			{
				if ((eval("frm." + outBuff[i]) != undefined))
				{
					eval("frm."+outBuff[i]+".value=\""+retBuff[j+1]+"\"");
					break;
				}
			}
		}
	}
	return retVal;
}

function cust_fnIsNull(str)
{
	str = cust_fnTrim(str);
	if (str == null || str == "")
		return true;
	else
		return false;
}

function cust_fnTrim(str)
{
	var cnt;

	len = str.length;
	var str = str;
	begin = -1;
	for(cnt=0;cnt<len;cnt++)
	{
		if (str.charAt(cnt) == " ")
			begin = cnt;
		else
			break;
	}
	str = str.slice(begin+1,len);
	len = str.length;
	end = len
	for(cnt=len-1;cnt>=0;cnt--)
	{
		if (str.charAt(cnt) == " ")
			end = cnt;
		else
			break;
	}
	str = str.slice(0,end);
	return  str;
}

function cust_enableButtons()
{
    var obj=document.forms[0].elements;
    var len=obj.length;
    for(var i=0;i<len;i++) {
        switch(obj[i].type) {
            case "button" :
            case "submit" :
            case "reset" :
            obj[i].disabled=false;
            break;
        }
    }
    enableTabs();
}
