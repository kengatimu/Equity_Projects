var browserName = navigator.appName;

/* Included this function for the redirection of menu options*/
function cust_convertMenuOption(menuName)
{
	if (menuName == 'GSPM')	
		return 'HGSPM';
	return menuName;
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
	end = len;
	for(cnt=len-1;cnt>=0;cnt--)
	{
		if (str.charAt(cnt) == " ")
			end = cnt;
		else
			break;
	}
	str = str.slice(0,end);
	return str;
}

function cust_fnIsNull(str)
{
	str = cust_fnTrim(str);
	if (str == null || str == "")
	    	return true;
	return false;
}

function cust_popModalWindow(sUrl,wName)
{
        if("Netscape" == browserName) {
       		window.open(sUrl,wName,"width=500,height=500,modal=yes,left=150,top=40,scrollbars=yes,toolbar=no,menubar=0");
		return;
        }
        else {
                var retval = window.showModalDialog(sUrl,wName,"dialogWidth:40;dialogHeight:25;status=no;toolbar=no;menubar=no;resizable=yes");
                return(retval);
        }
}


function appFnExecuteScript(inputNameValues, outputNames, scrName, isPopulationReq)
{
    	var sUrl = "../custom/jsp/cust_frm_fetch.jsp?";

	if(!cust_fnIsNull(inputNameValues))
		sUrl += "&inputs="+ encodeURIComponent(inputNameValues);


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
	var params = "dialogWidth=0px;dialogHeight=0px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
	params += ";status=no;toolbar=no;menubar=no;resizable=yes;help=no;center=no";

	var retVal = "";
	if("Netscape" == browser_name)
		window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");
	else
	{
		retVal = window.showModalDialog(sUrl,"",params);
	}
	
	if (retVal == null || retVal == undefined)
		return retVal;

	var retBuff = retVal.split("|");
	var retBuffLen = retBuff.length;
	if (retBuff[0] == 'Err')
	{
		var str = "";
		for (var i=1; i<retBuffLen; i++)
		{
			str += retBuff[i] + "\n";
		}
		return;
	}
	
	if (!isPopulationReq)
		return retVal;

	var frm = document.forms[0];
	var outBuff = outputNames.split("|");
	var outBuffLen = outBuff.length; 

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
}

/*******************************************************************************
This function has to be used while dealing with product menu option
**********************************************************************************/
function cust_fnExecuteScript(inputNameValues, outputNames, scrName, isPopulationReq)
{
	//var sUrl = "../Renderer/custom/jsp/cust_frm_fetch.jsp?";
//var sUrl = "../custom/jsp/cust_frm_fetch.jsp?";
	var sUrl = "../jsp/cust_frm_fetch.jsp?";

	if(!cust_fnIsNull(inputNameValues))
		sUrl += "&inputs="+inputNameValues;

    //	alert(inputNameValues);
	if(cust_fnIsNull(scrName))
	{
		alert("Script Name is mandatory");
		return;
	}
	
	sUrl += "&scrName="+scrName;

//	alert(sUrl);
	if (isPopulationReq && cust_fnIsNull(outputNames))
	{
		alert("Output Names are mandatory");
		return;
	}

//	alert("before modalwindow");    
	var xMax = screen.width, yMax = screen.height;
	var xOffset = (xMax - 120), yOffset = (yMax - 150);
	var params = "dialogWidth=0px;dialogHeight=0px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
	params += ";status=no;toolbar=no;menubar=no;resizable=yes;help=no;center=no";

	var retVal = "";
	if("Netscape" == browser_name)
		window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");
	else
	{
//		alert("before modalwindow"); 
			retVal = window.showModalDialog(sUrl,"",params);
//		alert("after modalwindow"); 
	}
	
	if (retVal == null || retVal == undefined)
		return retVal;

	var retBuff = retVal.split("|");
	var retBuffLen = retBuff.length;
	if (retBuff[0] == 'Err')
	{
		var str = "";
		for (var i=1; i<retBuffLen; i++)
		{
			str += retBuff[i] + "\n";
		}
//		alert(str);
		return;
	}
	
	if (!isPopulationReq)
		return retVal;

	var frm = document.forms[0];
	var outBuff = outputNames.split("|");
	var outBuffLen = outBuff.length; 

	for (var i=0; i<outBuffLen; i++)
	{
	//	alert("in custom functions");
       // alert(outBuffLen[i]);
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
}

/**********************************************************************************************************/





function fnExecuteScriptForList(inputNameValues, outputNames, scrName, pageTitle, literalNames, hyperLnkCols, isPopulationReq)
{
    	var sUrl = "../custom/jsp/cust_fetch_list.jsp?";
    	
    	if((inputNameValues.indexOf("pageNumber") != -1) && (inputNameValues.indexOf("pageSize") == -1))
    	{
    		alert("Page Size is mandatory");
    		return;
    	}
    		
    	if((inputNameValues.indexOf("pageSize") != -1) && (inputNameValues.indexOf("pageNumber") == -1))
    	{
    		alert("Page Number is mandatory");
    		return;
    	}

	if(!cust_fnIsNull(inputNameValues))
		sUrl += "&inputs="+encodeURIComponent(inputNameValues);


	if(cust_fnIsNull(scrName))
	{
		alert("Script Name is mandatory");
		return;
	}
	
	sUrl += "&scrName="+scrName;


	if(cust_fnIsNull(outputNames))
	{
		alert("List ouput field names are mandatory");
		return;
	}

	sUrl += "&outputs="+outputNames;


	if(cust_fnIsNull(pageTitle))
	{
		pageTitle=finbranchResource.FHP000368;
	}

	sUrl += "&pageTitle="+encodeURIComponent(pageTitle);

	if(cust_fnIsNull(literalNames))
	{
		alert("Column Literal Names are mandatory");
		return;
	}
	
	sUrl += "&literalNames="+encodeURIComponent(literalNames);	
	
	if(cust_fnIsNull(hyperLnkCols))
	{
		hyperLnkCols="1";
	}
	sUrl += "&hyperLnkCols="+hyperLnkCols;
	
	var retVal = cust_popModalWindow(sUrl, "Custom List");
	
	if (retVal == null || retVal == undefined)
		return retVal;
	
	if (!isPopulationReq)
		return retVal;
	
	if ("Microsoft Internet Explorer" == browser_name)
	{
		var frm = document.forms[0];
		var outBuff = outputNames.split("|");
		var outBuffLen = outBuff.length;
		var retBuff = retVal.split("|");			

		for (var i=0; i<outBuffLen; i++)
		{
			if ((eval("frm." + outBuff[i]) != undefined))
			{
				eval("frm."+outBuff[i]+".value=\""+unescape(retBuff[i])+"\"");
			}
		}
	}
}


function cust_fnFormatDate(obj)
{
    var arrBodDate = BODDate.split("-");
    var tmpArrBodYr = arrBodDate[2].substring(0,2);
    var regEx = /[^0-9-]/g;
    var str = obj.value;
   
    if(window.event.keyCode != 8) //DO NOT FORMAT for BACKSPACE
    {
	if (regEx.test(obj.value)) {
		switch(obj.value.length){
			case 1:
				obj.value = "0";
				break;
			case 2:
				temp = str.charAt(0);
				obj.value = "0" + temp;
				break;
			case 4:
				obj.value = obj.value.substring(0, str.length - 1);
				obj.value += "0";
				break;
			case 5:
				temp = str.charAt(3);
				obj.value = obj.value.substring(0, str.length - 2);
				obj.value += "0" + temp;
				break;
			default:
				break;
		}
    	}
        
        //APPROACH IN ALL BANK IN THE WORLD 
        //For YEAR entered less than 38, current century + the year is displayed	
        //For YEAR entered greater than or equal to 38, previous century + the year is displayed	
	if(obj.value.length == 8 && (obj.value.split("-"))[2] < 38)
	{
		temp = str.substring(6,str.length);
		obj.value = obj.value.substring(0, str.length - 2);
		obj.value += tmpArrBodYr + temp;
	}
	else if(obj.value.length == 8 && (obj.value.split("-"))[2] >= 38)
	{
		temp = str.substring(6,str.length);
		obj.value = obj.value.substring(0, str.length - 2);
		obj.value += parseInt(tmpArrBodYr-1,10) + temp;
	}
    }
    return true;
}

function cust_fnFormatAcct(acctObj)
{
	var	sVal	=	acctObj.value;
	var sFormat	=	"";

	if (sVal.indexOf(".")	!=	-1) 
	{
		var	arrSVal	=	sVal.split(".");
		if ((arrSVal.length != 2)	&& (arrSVal.length	!=	3))
		{
			alert("Please enter account no. in this format \'SolId.Acctype.Account No.\'");
			acctObj.focus();
			return false;
		}

		if (arrSVal.length	==	3)
		{
			if (fnIsNull(arrSVal[0]))
			{
				alert("Please enter the Sol Id value.");
				acctObj.focus();
				return false;
			}
			else
			{
				sFormat	=	fnLpad(arrSVal[0],4);
			}

			if (fnIsNull(arrSVal[1]))
			{
				alert("Please enter the Account Type value.")
				acctObj.focus();
				return false;
			}
			else
			{
				sFormat	=	sFormat + fnLpad(arrSVal[1],2);
			}

			if (fnIsNull(arrSVal[2]))
			{
				alert("Please enter the Account No. value.")
				acctObj.focus();
				return false;
			}
			else
			{
				sFormat	=	sFormat + fnLpad(arrSVal[2],6);
			}
		}

		if (arrSVal.length	==	2)
		{
			if (fnIsNull(arrSVal[0]))
			{
				alert("Please enter the Account Type value.")
				acctObj.focus();
				return false;
			}
			else
			{
				sFormat	=	fnLpad(headCtxSol,4) + fnLpad(arrSVal[0],2);
			}

			if (fnIsNull(arrSVal[1]))
			{
				alert("Please enter the Account No. value.")
				acctObj.focus();
				return false;
			}
			else
			{
				sFormat	=	sFormat + fnLpad(arrSVal[1],6);
			}
		}
		acctObj.value	=	sFormat;
		return true;
	}
}

function showDispMesg()
{
	var frm=document.forms[0];
	if (frm.dispMesg != "undefined" && frm.dispMesg != null){
		getCustomFieldValue("dispMesg");
		if (frm.dispMesg.value != ""){
			alert(frm.dispMesg.value);
		}	
	}
}
function DateAdd(startDate, numDays, numMonths, numYears)
{
	var returnDate = new Date(startDate.getTime());
	var yearsToAdd = numYears;
	
	var month = returnDate.getMonth()	+ numMonths;
	if (month > 11)
	{
		yearsToAdd = Math.floor((month+1)/12);
		month -= 12*yearsToAdd;
		yearsToAdd += numYears;
	}
	returnDate.setMonth(month);
	returnDate.setFullYear(returnDate.getFullYear()	+ yearsToAdd);
	
	returnDate.setTime(returnDate.getTime()+60000*60*24*numDays);
	
	return returnDate;

}

function YearAdd(startDate, numYears)
{
		return DateAdd(startDate,0,0,numYears);
}

function MonthAdd(startDate, numMonths)
{
		return DateAdd(startDate,0,numMonths,0);
}

function DayAdd(startDate, numDays)
{
		return DateAdd(startDate,numDays,0,0);
}

function fnCheckDateDiff(initDateObj,adnDays,endDateObj)
{
	if(fnIsNull(endDateObj.value) || !fnIsValidDate(endDateObj))
	{
			return true;
	}

	var eDate=endDateObj.value;
	var sDate=initDateObj.value;
	var eArrDt=eDate.split("-");
	var sArrDt=sDate.split("-");

	var eDt = new Date();
	eDt.setDate(parseInt(eArrDt[0],10));
	eDt.setMonth(parseInt(eArrDt[1],10) - 1);
	eDt.setYear(parseInt(eArrDt[2],10));

	var sDt = new Date();

	sDt.setDate(parseInt(sArrDt[0],10));
	sDt.setMonth(parseInt(sArrDt[1],10) - 1);
	sDt.setYear(parseInt(sArrDt[2],10));

	var eMSecs = eDt.getTime();
	var sMSecs = sDt.getTime();
	var dtDiff = Math.ceil(60*60*24*parseInt(adnDays,10)*1000);
	//alert("Diff = "+Math.ceil(eMSecs-sMSecs)+" Req. Diff = "+dtDiff)	
	if(Math.ceil(eMSecs-sMSecs) > dtDiff) return false;
	return true;
}



/*From here the code for workflow starts*/


function getObj(id)
{
	var obj = (document.getElementById)? document.getElementById(id): (document.all)? document.all[id]: null;
	if (obj != null)
		return obj;

	var chk = false;
	var frmElem = document.forms[0].elements;
	for (var i=0; i<frmElem.length; i++)
	{
		obj = frmElem[i];
		if (obj.id != undefined && (obj.id).indexOf(id) != -1)
		{
			chk = true;
			break;
		}
		else if (obj.name != undefined && (obj.name).indexOf(id) != -1)
		{
			chk = true;
			break;
		}
	}

	if (!chk)
	{
		alert("The field [" + id + "] doesn't exists in the form");
		obj = null;
	}

	return obj;
}

function isValidObj(tempObj) {
	var frm = document.forms[0];
	var chkObj;
	
	chkObj = eval("frm."+tempObj);
	if(chkObj==undefined){
		return false;
	}else{
		return true;
	}
}

function populateWFData()
{
	var frm = document.forms[0];
	var obj;
	var objId;
	var type;
	var val;
	var tmpObj;
	var tmpElemArr;
	var tmpElem="";
	var tmpAttrib;
	
	for(i=0; i<arguments.length; i++)
	{
		tmpElemArr = arguments[i].split('_');
		tmpObj=null;
		tmpElem="";
		for(var j=0;j<tmpElemArr.length;j++) {
			if(j != 0){
				tmpElem = tmpElem +"_";	
			}
			tmpElem = tmpElem + tmpElemArr[j];
			if(isValidObj(tmpElem)) {
				tmpObj = tmpElem;
			}
		}
	
		objId = tmpObj;
		obj = getObj(objId);
		
		type = obj.type;
		val = eval("WF_DATA_ARR."+arguments[i]);
		if (val == undefined)
			continue;

		if (type == 'checkbox')
		{
			if (val == 'Y')
				obj.checked = true;
			else
				obj.checked = false;

			eval("frm."+arguments[i].substring(3) + ".value=val");
		}
		else if (type == 'radio')
		{
			checkRadio(obj, val);
		}
		else
		{
			obj.value = val;
			tmpAttrib = obj.getAttribute("fdt");
			if (tmpAttrib == "fdate" || tmpAttrib == "date" || tmpAttrib == "datetime")
			{				
				cust_fnAssignUIDate(obj);
			}	
		}
	}
}

function checkErrExecNextStep()
{
	if((eval(this.dispErrLLSize) != undefined && dispErrLLSize == 0) || (eval(this.dispUsrErrLLSize) != undefined && dispUsrErrLLSize == 0))
	{
		execNextStep();
	}
}

function nextWFAction(paramType, strTabId, CB_REQD)
{	
	enableButtons();
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

function nextNewWFAction(paramType, strTabId, CB_REQD)
{
    enableButtons();
    if (arguments.length <= 2)
        CB_REQD = "N";

    if(paramType.toUpperCase() == "OBJ")
    {
        strTabId.click();
        return true;
    }
    else if(paramType.toUpperCase() == "ID")
    {
        cust_getTabStatus(CB_REQD, strTabId);
    }
}

function cust_getStatus(sTabReqd, sTabName){
	var frm = document.forms[0];
	var objCB = eval("frm.chk"+sTabName);
	if(fnValidateForm(sTabName)) {
		if( (sTabReqd == "Y") && !(objCB.checked) ) {
			if( (objCB.getAttribute("fds") == null)||(objCB.getAttribute("fds") == "")||(objCB.getAttribute("fds") != "Y") )
				objCB.click();
		}
		frm.submitform.value=sTabName;
		frm.tabName.value = sTabName;
		cust_convertToCaps();
		cust_disableButtons();
		cust_fnEnableDescFields(frm);
		frm.submit();
		return true;
	} else {
		return false;
	}
}
function cust_getTabStatus(sTabReqd, sTabName){
	var frm = document.forms[0];
	var objCB = eval("frm.chk"+sTabName);
	if(fnValidateForm(sTabName)) {
	if( (sTabReqd == "Y") && !(objCB.checked) ) {
        if( (objCB.getAttribute("fds") == null)||(objCB.getAttribute("fds") == "")||(objCB.getAttribute("fds") != "Y") )
            objCB.click();
	}
    	frm.actionCode.value = "gotoTab";
        frm.tabName.value = sTabName;
    	cust_convertToCaps();
    	cust_disableButtons();
    	cust_fnEnableDescFields(frm);
    	frm.submit();
    	return true;
    	} else {
        return false;
    	}
}

function generic_wf(pageName,object) 
{
	checkErrExecNextStep();
	return true;
}

function execNextStep()
{
	var objName = null;
	try
	{
	
	var objType = nextAction.substring(0,nextAction.indexOf("|"));

	if(objType != null){
		objName = nextAction.substring(nextAction.indexOf("|")+1,nextAction.length);
		if(objType == "BUTTON"){
			objType = "OBJ";
			objName = eval("document.forms[0]."+objName);
		}
		else{
			objType = "ID";
		}
	}

	nextWFAction(objType,objName);
	}
	catch(e){}
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

function cust_fnAssignUIDate(objDate){

 var itemName = objDate.name + "_ui";
 var element = document.getElementsByName(itemName);
 if(element[0] == null)
   return;
 element[0].value = cust_fnConvertToUIDate(objDate.value);

}

function cust_fnConvertToUIDate(stdDateString)
{	
    var day = "";
    var month = "";
    var year="";

    var displayStr = stdDateString;     //This is default return value

    if (displayStr == "")
        return displayStr;

    // if mnemonic , copy as it is
    if(cust_isValidDateMneumonic(displayStr))
       return displayStr;
    //check for the delimeter and seperate date, month and year.
    if((displayDateFormat == "01"))
    {
        if(displayStr.indexOf("/") != -1)
            var a_strDate = displayStr.split("/");
        if(displayStr.indexOf("-") != -1)
            var a_strDate = displayStr.split("-");
        if(displayStr.indexOf(".") != -1)
            var a_strDate = displayStr.split(".");
        displayStr = a_strDate[1]+"-"+a_strDate[0]+"-"+a_strDate[2];
        return displayStr;
    }
    return displayStr;

}

function cust_isValidDateMneumonic(dateMneumonic)
{
    var mnemonics   = cust_getMnemonics();
    var len         = mnemonics.length;
    for(var index = 0; index < len; index++)
    {
        if(mnemonics[index].mnemonicsList == dateMneumonic)
        {
            return true;
        }
    }
    return false;
}

function cust_getMnemonics()
{
	var mnemonicsList = new Array("$BOD$","$BOD-1$","$BOD+1$","$MEND$","$QEND$","$HEND$","$YEND$");
	var mnemonicsDesc = new Array("Begin of Day","Date Previous to Begin Of Day","Date Next To Begin Of Day","Month End","Quarter End","Half Year End","Year End");
	var len = mnemonicsDesc.length;
	var mnemonics = new Array(len);
	for(var index = 0 ; index < len; index++)
	{
		mnemonics[index] = new cust_MnemonicsClass(mnemonicsList[index],mnemonicsDesc[index]);
	}
	return mnemonics;
}
function cust_MnemonicsClass(mnemonicsList,mnemonicsDesc)
{
    this.mnemonicsList = mnemonicsList;
	this.mnemonicsDesc = mnemonicsDesc;
}


//Function to show the calendar - openDate() functions modified from common_functions.js
function cust_openDate(obj,inpDate)
{
        var date = "";
        if(inpDate == null) inpDate = '';
        date = popModalWindowVar("../../arjspmorph/"+applangcode+"/date.jsp?txtDate="+obj.id+"&date="+inpDate,"Calendar",250,350,15,20);
        if(date != null)
        {
                //set the value to ui and hidden fields.
                obj.value = fnConvertToUIDate(date);
                fnAssignDateOnEnter(obj);
        }
}

//Function for making all text fields as Read Only
// By Sandeep
function fnreadOnly()
{
var form=document.forms[0];
var len=form.length;
	for(i=0;i<len;i++)
	{
		if(form[i].type == "text")
		{
		var txtStr = form[i].readOnly;
		form[i].readOnly = true;
		}
	}
}

// Declaring required variables
var digits = "0123456789";
// non-digit characters which are allowed in phone numbers
var phoneNumberDelimiters = "()- ";
// characters which are allowed in international phone numbers
// (a leading + is OK)
var validWorldPhoneChars = phoneNumberDelimiters + "+";
// Minimum no of digits in an international phone no.
var minDigitsInIPhoneNumber = 10;

function isInteger(s)
{   var i;
    for (i = 0; i < s.length; i++)
    {
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag)
{   var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++)
    {
        // Check that current character isn't whitespace.
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function checkInternationalPhone(obj)
{
        s=stripCharsInBag(obj.value,validWorldPhoneChars);
        return (isInteger(s) && s.length >= minDigitsInIPhoneNumber);
}

function emailCheck(str) {

		var at="@"
		var dot="."
		var lat=str.indexOf(at)
		var lstr=str.length
		var ldot=str.indexOf(dot)
		if (str.indexOf(at)==-1){
		    return false
		}

		if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
		   return false
		}

		if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
		    return false
		}

		 if (str.indexOf(at,(lat+1))!=-1){
		    return false
		 }

		 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
		    return false
		 }

		 if (str.indexOf(dot,(lat+2))==-1){
		    return false
		 }
		
		 if (str.indexOf(" ")!=-1){
		    return false
		 }

 		 return true					
	}

/*      CALL THIS FUNCTION WHEN DATA NEEDS TO BE SENT TO THE SERVER             ****
*       This function builds a url based on the return values expected and sends the data to server.
*       @fetchId                -       This field is helpful to indicate which function to call in the backend
*       @precedence             -       This field is helpful to set the precedence (FAB or FIN) in the backend
*       @wReturn                -       This field is helpful to the take the value as parameter for fetching the record from the backend
*       @wReturnDesc    -       This field is the helpful to populate the return value. This is used for populating return values.
*                                               This field will contain '|' seperated html element id's into which the return values need to be
*                                               populated.
*
* This function needs to be called from a local javascript function with the
* group link javacript after checking the field for null value.If the field is
* null then call the clearDescField() function with the required parameters.
*/
function cust_sendDataToServer(frameName,fetchId, precedence, wReturn, wReturnDesc)
{
        var strArray = wReturn.split("|");
        var tmpStr="";

        if (strArray.length > 0)
        {
                for (var i=0;i<strArray.length;i++)
                {
                        tmpStr = tmpStr+"|"+eval('document.forms[0].'+strArray[i]+'.value');
                }

                tmpStr = tmpStr.substring(1);
        }

    var sUrl = "../../arjspmorph/"+applangcode+"/frm_fetch.jsp?fetchId="+fetchId+"&precedence="+precedence;
        if(wReturn != '')
                sUrl = sUrl+"&wReturn="+tmpStr;

        if(wReturnDesc != '')
                sUrl = sUrl+"&wReturnDesc="+wReturnDesc;

    var xMax = screen.width, yMax = screen.height;
    var xOffset = (xMax - 120), yOffset = (yMax - 150);
    var params = "dialogWidth=0px;dialogHeight=0px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
    params += ";status=no;toolbar=no;menubar=no;resizable=no;help=no;center=no";
    if("Netscape" == browser_name)
        window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");
    else {
    var inpData = wReturnDesc;
    var obj = document.forms[0];
    var outData = window.showModalDialog(sUrl,document.forms[0],params);
        if (outData.toLowerCase().indexOf("|") == -1)
        {
                if(outData != "")
                        alert("\""+outData+"\"");
                return false;
        }

        var inBufferArr         =       inpData.split("|");
        var outBufferArr        =       outData.split("|");
        var checkDoubleSel      =   'N';

        if (inBufferArr.length > outBufferArr.length)
        {
                 alert("Input fields which needs to be populated are \nnot matching the return values");
                 return false;
        }

        for (i=0;i<inBufferArr.length;i++)
        {
                if(inBufferArr[i].substring(0,4) == 'sel1')
                {
                    eval("obj."+inBufferArr[i].substring(4,inBufferArr[i].length)+".value=\""+outBufferArr[i]+"\"");
                        checkDoubleSel = 'N';
                }
                else if(inBufferArr[i].substring(0,4) == 'sel2')
                {
                        var tmpOutBufferArr = outBufferArr[i]+"/"+outBufferArr[i+1];
                    eval("obj."+inBufferArr[i].substring(4,inBufferArr[i].length)+".value=\""+tmpOutBufferArr+"\"");
                        checkDoubleSel = 'Y';
                }
                else if(inBufferArr[i].substring(0,3) != 'chk')
                {
                        if(checkDoubleSel != 'Y')
                        {
                                if(inBufferArr[i].substring(0,3) == 'rdo')
                                        setRadioValue(inBufferArr[i].substring(3,inBufferArr[i].length),outBufferArr[i]);
                                else
                                        eval("obj."+inBufferArr[i]+".value=\""+outBufferArr[i]+"\"");
                        }
                        else
                        {
                                if(inBufferArr[i].substring(0,3) == 'rdo')
                                        setRadioValue(inBufferArr[i].substring(3,inBufferArr[i].length),outBufferArr[i+1]);
                                else
                                        eval("obj."+inBufferArr[i]+".value=\""+outBufferArr[i+1]+"\"");
                        }

                }
                else
                {
                        if(outBufferArr[i] == 'Y')
                                        eval("obj."+inBufferArr[i]+".checked=true");

                }
        }
        if(i>0&& inBufferArr.length < outBufferArr.length && !isEmptyObjValue(outBufferArr[i]))
        {
                errIndex=outData.indexOf(FETCH_ERR);
                if (errIndex != -1)
                {
                        alert(outData.substring(errIndex + FETCH_ERR_LEN));
                        return false;
                }
        }
        }
        return true;
}

