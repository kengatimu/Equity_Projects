function fnValidateData(){
	var ObjForm = document.forms[0];
	var parameterId = ObjForm.parameterId.value;
	var parameterDesc = ObjForm.parameterDesc.value;
	var parameterType = ObjForm.parameterType.value;
	var listType = ObjForm.listType.value;

	if(fnIsNull(ObjForm.parameterId.value))
        {
                alert("Enter the Parameter Id");
                ObjForm.parameterId.focus();
                return false;
        }

	if(fnIsNull(ObjForm.parameterDesc.value))
        {
                alert("Enter the Parameter Description");
                ObjForm.parameterDesc.focus();
                return false;
        }

	if(fnIsNull(ObjForm.parameterType.value))
        {
                alert("Select the Parameter Type");
                ObjForm.parameterType.focus();
                return false;
        }

	if(fnIsNull(ObjForm.listType.value))
        {
                alert("Select the List Type");
                ObjForm.listType.focus();
                return false;
        }

	if(listType != "FT"){
		var queryName = ObjForm.queryName.value;
		var queryId = ObjForm.queryId.value;
		var queryDetails = ObjForm.queryDetails.value;
		if(fnIsNull(ObjForm.queryName.value))
		{
			alert("Enter the Query Name");
			ObjForm.queryName.focus();
			return false;
		}

		if(fnIsNull(ObjForm.queryId.value))
                {
                        alert("Enter the Query Id");
                        ObjForm.queryId.focus();
                        return false;
                }

		if(fnIsNull(ObjForm.queryDetails.value))
                {
                        alert("Enter the Query Details");
                        ObjForm.queryDetails.focus();
                        return false;
                }

	}

	if(!isEnglish(parameterDesc)){
                alert("Invalid Characters entered");
                ObjForm.parameterDesc.focus();
                return false;
        }

	//if(!isEnglish(parameterValue)){
      //          alert("Invalid Characters entered");
        //        ObjForm.parameterValue.focus();
          //      return false;
        //}

	if (!fnCheckMandatoryFields())
	{
		return false;
	}
	return true;
}

function isEnglish(str){
    for (i=0; i<str.length; i++)
        {
                var validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_,|.!-/:@>";
                if((validChars.indexOf(str.charAt(i)) == -1))
                {
                        return false;
                }
    }
    return true;
}

function fnOnChangeListType(){
        var ObjForm = document.forms[0];
        var listType = ObjForm.listType.value;
        if(listType == "FT"){
		hideImage("queryDetailsRow1");
		hideImage("queryDetailsRow2");
		ObjForm.queryName.value = "";
		ObjForm.queryId.value = "";
		ObjForm.queryDetails.value = "";
		disableFields("queryName","queryId","queryDetails");
        }
	if(listType == "LS" || listType == "LD"){
		showImage("queryDetailsRow1");
                showImage("queryDetailsRow2");
		showImage("queryNameImg");
		showImage("queryIdImg");
		ObjForm.queryName.value = "";
                ObjForm.queryId.value = "";
                ObjForm.queryDetails.value = "";
		enableFields("queryName","queryId","queryDetails");
		ObjForm.queryName.focus();
        }

	if(listType == ""){
		hideImage("queryDetailsRow1");
                hideImage("queryDetailsRow2");
		ObjForm.queryName.value = "";
                ObjForm.queryId.value = "";
                ObjForm.queryDetails.value = "";
                disableFields("queryName","queryId","queryDetails");
	}
        return;
}

function removeCommas(sNum){
	sNew ="";
	var sTemp = sNum.split(",");
	for (i=0;i<sTemp.length;i++)
	{
		if (sTemp[i]!=null)
			sNew = sNew + sTemp[i];
	}
	return sNew;
}

function fnValAndSubmit(btnObj){
	//if(fnValidateData()){
		doSubmit(btnObj.id);
//	}
}

function fnCheckInteger()
{
	var ObjForm = document.forms[0];

	if (!fnIsAlphabetNum(document.forms[0].mWaivermnths.value))
	{
		alert("Only Positive Integers are allowed");
		return false;
	}

        return true;
}

function fnIsAlphabetNum(str)
{
	var strReg = /^([0-9 ])+$/ 
	if(!fnIsNull(str))
	return(strReg.test(str));
	return true;
}

function fnOnButtonClick(btnObj)
{
	if(confirm(finbranchResArr.get("FAT000925")))
	{
		var ObjForm = document.forms[0];
		ObjForm.parameterId.value = "";
		doSubmit(btnObj);
	}
}

function low_isValidAmt(amt)
{
	var amtLen = amt.length;
	var lastChar = (amt.charAt(amtLen - 1)).toUpperCase();
	if (isNaN(lastChar) && lastChar != '.') {
		alert("Enter a numeric value");
		return false;
	}
	if (isNaN(amt)) {
		alert("Enter a numeric value");
		return false;
	}
	var regExp = /[Ee]/g;
	if (regExp.test(amt)) {
		alert("Enter a numeric value");
		return false;
	}
	return true;
}

function cparam_det_post_ONLOAD()
{
	var ObjForm = document.forms[0];

	if(funcCode == "A" || funcCode == "M" || funcCode ==  "C" || funcCode == "V"){
		hideImage("parameterValueRow");
		ObjForm.parameterValue.value = "";
	}

	if(funcCode == "A"){
		ObjForm.queryName.value = "";
		ObjForm.queryId.value = "";
		ObjForm.queryDetails.value = "";
		hideImage("queryDetailsRow1");
		hideImage("queryDetailsRow2");
		ObjForm.parameterType.focus();
		disableFields("parameterId");
	}

	if(funcCode == "M"){
		if(listType == "FT"){
                	hideImage("queryDetailsRow1");
			hideImage("queryDetailsRow2");
		}
		disableFields("parameterId","parameterType","listType","queryName","queryId","queryDetails");
        }

	if(funcCode == "C"){
                if(listType == "FT"){
                        hideImage("queryDetailsRow1");
                        hideImage("queryDetailsRow2");
                }
                disableFields("parameterId","parameterDesc","parameterType","listType","queryName","queryId","queryDetails");
        }

	if(funcCode == "V"){
                if(listType == "FT"){
                        hideImage("queryDetailsRow1");
                        hideImage("queryDetailsRow2");
                }
                disableFields("parameterId","parameterDesc","parameterType","listType","queryName","queryId","queryDetails");
        }

	if(funcCode == "MV"){
                if(listType == "FT"){
                        hideImage("queryDetailsRow1");
                        hideImage("queryDetailsRow2");
                }
                disableFields("parameterId","parameterDesc","parameterType","listType","queryName","queryId","queryDetails");
        }

	if(funcCode == "VV"){
                if(listType == "FT"){
                        hideImage("queryDetailsRow1");
                        hideImage("queryDetailsRow2");
                }
                disableFields("parameterId","parameterDesc","parameterType","parameterValue","listType","queryName","queryId","queryDetails");
        }

	if(funcCode == "I"){
                if(listType == "FT"){
                        hideImage("queryDetailsRow1");
                        hideImage("queryDetailsRow2");
                }
                disableFields("parameterId","parameterDesc","parameterType","parameterValue","listType","queryName","queryId","queryDetails");
        }
	
	if(funcCode == "CV"){
                if(listType == "FT"){
                        hideImage("queryDetailsRow1");
                        hideImage("queryDetailsRow2");
                }
                disableFields("parameterId","parameterDesc","parameterType","parameterValue","listType","queryName","queryId","queryDetails");
        }
	
	if(funcCode == "DV"){
                if(listType == "FT"){
                        hideImage("queryDetailsRow1");
                        hideImage("queryDetailsRow2");
                }
                disableFields("parameterId","parameterDesc","parameterType","parameterValue","listType","queryName","queryId","queryDetails");
        }

	if(funcCode == "VDV"){
                if(listType == "FT"){
                        hideImage("queryDetailsRow1");
                        hideImage("queryDetailsRow2");
                }
                disableFields("parameterId","parameterDesc","parameterType","parameterValue","listType","queryName","queryId","queryDetails");
        }
	
	if(parameterLevel == "BNKL"){
		hideImage("schemeCodeRow");
		hideImage("currencyCodeRow");
		hideImage("genericCodeRow");
		hideImage("genericIdRow");
	}
	if(parameterLevel == "SOLL"){
                hideImage("schemeCodeRow");
                hideImage("currencyCodeRow");
                hideImage("genericCodeRow");
		hideImage("genericIdRow");
        }
	if(parameterLevel == "SCHL"){
		hideImage("solIdRow");
                hideImage("currencyCodeRow");
                hideImage("genericCodeRow");
		hideImage("genericIdRow");
        }
	if(parameterLevel == "CURL"){
		hideImage("solIdRow");
                hideImage("schemeCodeRow");
                hideImage("genericCodeRow");
		hideImage("genericIdRow");
        }
	if(parameterLevel == "SHCR"){
		hideImage("solIdRow");
                hideImage("genericCodeRow");
		hideImage("genericIdRow");
        }
	if(parameterLevel == "GENL"){
                hideImage("solIdRow");
		hideImage("schemeCodeRow");
		hideImage("currencyCodeRow");
        }

	return true;
}

function fnGetFunctionCodeDesc(funcCode){
	switch(funcCode){
		case 'A': return "Add New Parameter";
		case 'M': return "Modify Parameter";
		case 'C': return "Cancel New Parameter";
		case 'V': return "Verify New Parameter";
		case 'MV': return "Modify Parameter Value";
		case 'VV': return "Verify Parameter Value";
		case 'I': return "Inquire Parameter Value";
		case 'CV': return "Cancel Parameter Value";
		case 'DV': return "Delete Parameter Value";
		case 'VDV': return "Verify Deleted Parameter Value";
		default : return funcCode;
	}

}

/***************************************************
* This function is used to disable all the visible
* controls in the screen.
****************************************************/
function fnCustDisableFormControls(objForm){
	
		var obj=document.forms[0];
		var len=obj.length;
		
		//disable form visible data controls
		for(i = 0; i < len; i++){
			if(( obj[i].type == 'text' )||( obj[i].type == 'textarea' )) {
				obj[i].readOnly = true;
			} else if (obj[i].type == 'select-one'){
				obj[i].disabled = true;
			} else if ( obj[i].type == 'checkbox' || obj[i].type == 'radio') {
				obj[i].disabled = true;
			}
		}
		
		if((objForm.Validate != undefined) && (objForm.Validate != null)){
		       objForm.Validate.disabled = true;
		}
}




// Added for Testing Onload event
function postEventCall(pageName,currObj,event){

    var funcName="";

    //This is to call the application level customization functions.
    //which will be defined in finbranch/custom/javascripts/app_custom.js

    funcName="this.app_post_"+event;

        if(eval(funcName)!=undefined)
        if(!eval(funcName).call(this,currObj))  return false;

    //End of application level customization hook

    funcName="this.post_usrhk_"+event;
    if(eval(funcName)!=undefined)
        if(!eval(funcName).call(this,currObj))  return false;

    funcName="this." + pageName + "_post_"+event;

        if(eval(funcName)!=undefined){

//------------------------------------------------
        //Following Code is altered
//------------------------------------------------


        if(this.WF_IN_PROGRESS == "Y" || this.WF_IN_PROGRESS == "PEAS"){
            if(!eval(funcName).call(this,currObj))  {
                fnSetFocusOnFirstField_postonload();
                return true;
            }
        }

        else{

                if(!eval(funcName).call(this,currObj)) {
                        return false;
                }
                else{
                        fnSetFocusOnFirstField_postonload();
                }

                return true;
        }

     }
}
