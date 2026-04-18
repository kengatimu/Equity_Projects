function cparam_crit_post_ONLOAD(){
	var ObjForm = document.forms[0];
	ObjForm.funcCode.focus();
	fnHideImage();
	if(ObjForm.funcCode.value == "A"){
		hideImage("parameterIdImg");
	}
	return true;
}

function fnHideImage(){
        hideImage("schemeCodeRow");
        hideImage("currencyCodeRow");
        hideImage("genericCodeRow");
        hideImage("genericIdRow");
        hideImage("solIdRow");
}

function fnClearInputFields(){
	var ObjForm = document.forms[0];
	ObjForm.schemeCode.value = "";
	ObjForm.currencyCode.value = "";
	ObjForm.genericCode.value = "";
	ObjForm.genericId.value = "";
	ObjForm.solId.value = "";
}

function fnValidateData(){
	var ObjForm = document.forms[0];
	var funcCode= ObjForm.funcCode.value;
	var parameterLevel = ObjForm.parameterLevel.value;
	var moduleName = ObjForm.moduleName.value;
	var parameterId = ObjForm.parameterId.value;
	var schemeCode = ObjForm.schemeCode.value;
	var currencyCode = ObjForm.currencyCode.value;
	var genericCode = ObjForm.genericCode.value;
	var genericId = ObjForm.genericId.value;
	var solId = ObjForm.solId.value;

        if(ObjForm.funcCode.value == "")
        {
                alert("Select the Mandatory Field");
                ObjForm.funcCode.focus();
                return false;
        }
        if(ObjForm.parameterLevel.value == "")
        {
                alert("Select the Parameter Level ");
                ObjForm.parameterLevel.focus();
                return false ;
        }
	if(ObjForm.moduleName.value == "")
        {
                alert("Enter the Module Name");
                ObjForm.moduleName.focus();
                return false ;
        }

	if(ObjForm.parameterId.value == "")
        {
                alert("Enter the Parameter Id");
                ObjForm.parameterId.focus();
                return false ;
        }

	if(parameterLevel == "BNKL"){
			
	}

	if(parameterLevel == "SOLL"){
		if(fnIsNull(solId)){
			alert("Enter the Sol Id");
			ObjForm.solId.focus();
			return false;
		}
	}

	if(parameterLevel == "SCHM"){
                if(fnIsNull(schemeCode)){
                        alert("Enter the Scheme Code");
			ObjForm.schemeCode.focus();
			return false;
                }
        }

	if(parameterLevel == "CURL"){
                if(fnIsNull(currencyCode)){
                        alert("Enter the Currency Code");
			ObjForm.currencyCode.focus();
                        return false;
                }
        }

	if(parameterLevel == "SHCR"){
                if(fnIsNull(schemeCode)){
                        alert("Enter the Scheme Code");
			ObjForm.schemeCode.focus();
                        return false;
                }

		if(fnIsNull(currencyCode)){
                        alert("Enter the Currency Code");
			ObjForm.currencyCode.focus();
                        return false;
                }
        }

	if(parameterLevel == "GENL"){
                if(fnIsNull(genericCode)){
                        alert("Enter the Generic Code");
			ObjForm.genericCode.focus();
                        return false;
                }

                if(fnIsNull(genericId)){
                        alert("Enter the Generic Id");
			ObjForm.genericId.focus();
                        return false;
                }
        }

	if(!isEnglish(moduleName)){
		alert("Invalid Characters entered");
		ObjForm.moduleName.focus();
		return false;
	}

	if(!isEnglish(parameterId)){
                alert("Invalid Characters entered");
                ObjForm.parameterId.focus();
                return false;
        }
	

	if (!fnCheckMandatoryFields())
	{
		return false;
	}

	return true;
}

function isEnglish(str)
{
    for (i=0; i<str.length; i++)
        {
                var validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_";
                if((validChars.indexOf(str.charAt(i)) == -1))
                {
                        return false;
                }
    }
    return true;
}

function fnOnChangeFuncCode(){

	var ObjForm = document.forms[0];
	var funcCode= ObjForm.funcCode.value;
	if(funcCode == "A"){
		hideImage("parameterIdImg");
	}else{
		showImage("parameterIdImg");
	}

	return;
}

function fnOnChangeParameterLevel(){
	var ObjForm = document.forms[0];

	var parameterLevel = ObjForm.parameterLevel.value;
	if(parameterLevel == "BNKL"){
		fnClearInputFields();
		fnHideImage();
		enableFields("solId");
		showImage("solIdRow");
		hideImage("solIdImg");
		ObjForm.solId.value = "ALL"
		disableFields("solId");
		ObjForm.parameterId.focus();
	}

	if(parameterLevel == "SOLL"){
		fnClearInputFields();
		fnHideImage();
		enableFields("solId");
		showImage("solIdRow");
		showImage("solIdImg");
		ObjForm.solId.focus();
        }

	if(parameterLevel == "SCHM"){
		fnClearInputFields();
		fnHideImage();
		enableFields("schemeCode");
		showImage("schemeCodeRow");
		ObjForm.schemeCode.focus();
        }

	if(parameterLevel == "CURL"){
		fnClearInputFields();
		fnHideImage();
		enableFields("currencyCode");
		showImage("currencyCodeRow");
		ObjForm.currencyCode.focus();
        }

	if(parameterLevel == "SHCR"){
		fnClearInputFields();
		fnHideImage();
		enableFields("schemeCode","currencyCode");
		showImage("schemeCodeRow");
		showImage("currencyCodeRow");
		ObjForm.schemeCode.focus();
        }

	if(parameterLevel == "GENL"){
		fnClearInputFields();
		fnHideImage()
		enableFields("genericCode","genericId");
		showImage("genericCodeRow");
		showImage("genericIdRow");
		ObjForm.genericCode.focus();
        }
	
	if(parameterLevel == ""){
		fnClearInputFields();
		fnHideImage();
	}

	return;
}

function showModuleList(){
     	var ObjForm = document.forms[0]; 
	var inputNameValues = "moduleName|"+ ObjForm.moduleName.value;
      var outputNameValues = "moduleName|moduleDesc";
      var scriptName = "cparam_module_list.scr";
      var listHeading = "Module List";
      var colHeader = "Module ID|Module Description";
      var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
}

function showParameterList(){
	var ObjForm = document.forms[0];	
	var funcCode = ObjForm.funcCode.value;
	var moduleName = ObjForm.moduleName.value;
	var parameterLevel = ObjForm.parameterLevel.value;
	var parameterId = ObjForm.parameterId.value;

	var callScript = "N";

	if(fnIsNull(funcCode)){
                alert("Select the Function Code");
                ObjForm.funcCode.focus();
        }

	if(funcCode == "M"){
		if(fnIsNull(moduleName)){
                	alert("Enter the Module Name");
                	ObjForm.moduleName.focus();
        	}else if(fnIsNull(parameterLevel)){
                        alert("Select the Parameter Level");
                        ObjForm.parameterLevel.focus();
                }else {
			callScript = "Y";	
		}
	}

	if(funcCode == "C"){
		callScript = "Y";
	}

	if(funcCode == "V"){
		callScript = "Y";	
	}
	
	if(funcCode == "MV"){
                if(fnIsNull(moduleName)){
                        alert("Enter the Module Name");
                        ObjForm.moduleName.focus();
                }else if(fnIsNull(parameterLevel)){
                        alert("Select the Parameter Level");
                        ObjForm.parameterLevel.focus();
                }else {
                        callScript = "Y";
                }
        }

	if(funcCode == "VV"){
		callScript = "Y";
        }

	if(funcCode == "I"){
                if(fnIsNull(moduleName)){
                        alert("Enter the Module Name");
                        ObjForm.moduleName.focus();
                }else if(fnIsNull(parameterLevel)){
                        alert("Select the Parameter Level");
                        ObjForm.parameterLevel.focus();
                }else {
                        callScript = "Y";
                }
        }

	if(funcCode == "CV"){
		callScript = "Y";
        }	
	
	if(funcCode == "DV"){
                if(fnIsNull(moduleName)){
                        alert("Enter the Module Name");
                        ObjForm.moduleName.focus();
                }else if(fnIsNull(parameterLevel)){
                        alert("Select the Parameter Level");
                        ObjForm.parameterLevel.focus();
                }else {
                        callScript = "Y";
                }
        }

	if(funcCode == "VDV"){
		callScript = "Y";
        }

	if(callScript == "Y"){
		var inputNameValues = "funcCode|"+funcCode+"|moduleName|"+moduleName+"|parameterLevel|"+parameterLevel+"|parameterId|"+parameterId;
		var outputNameValues = "parameterId|moduleName|parameterLevel";
		var scriptName = "cparam_parameter_list.scr";
		var listHeading = "Parameter List";
		var colHeader = "Parameter Id|Module Id|Parameter Level";
		var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
	}
}

function fnShowSchemeCodeList(){
        if((document.forms[0].funcCode.value == '') || (document.forms[0].funcCode.value == 'A')){
                getGspmSchemeCodeList(document.forms[0].schemeCode,"","N","T","F");
        }else{
                //fnSchemeCodeSearchForVerify();
		getGspmSchemeCodeList(document.forms[0].schemeCode,"","N","T","F");
        }
}

function fnShowCurrencyCodeList(){
        if((document.forms[0].funcCode.value == '') || (document.forms[0].funcCode.value == 'A')){
		showCurrencyList(document.forms[0].currencyCode)
        }else{
                //fnCrncyCodeSearchForVerify();
		showCurrencyList(document.forms[0].currencyCode)
        }
}

function getGspmSchemeCodeList(objSchmCode, schmType, delFlg, schmCat, inPreceedence, objSchmDesc, ctrlOrMorph){
    var preceedence = inPreceedence == null ? 'B' : inPreceedence;
    var sUrl = "";
        var url = "../";

        if(arguments.length > 1){
                if(ctrlOrMorph == undefined)
                url = "../arjspmorph/";
    	}
	if (arguments.length < 6) 
	// Without scheme description
	{
		sUrl = url+applangcode+"/tagspmschcodelist.jsp?wReturn="+objSchmCode.id+"&schmCode="+objSchmCode.value+"&schmType="+schmType+"&schmCat="+schmCat+"&delFlg="+delFlg+"&preceedence="+preceedence;
    	}else 
	// With scheme description
	{
		sUrl = url+applangcode+"/tagspmschcodelist.jsp?wReturn="+objSchmCode.id+"&wReturnDesc="+objSchmDesc.id+"&schmCode="+objSchmCode.value+"&schmType="+schmType+"&schmCat="+schmCat+"&delFlg="+delFlg+"&preceedence="+preceedence;
    	}

	var retVal = popModalWindow(sUrl,"Scheme Code List");
    if ("Microsoft Internet Explorer" == browser_name)
    {
        if (retVal != null && retVal != undefined )
        {
            // Array for taking the values after splitting the value with "|".
            var liarrBufArray = retVal.split("|");
            objSchmCode.value = liarrBufArray[0];
            if (objSchmDesc != null && objSchmDesc != undefined && objSchmDesc.id != null)
            {
                objSchmDesc.value = liarrBufArray[1];
            }
        }
    }
}
/***************************************************
* This function is used to clear all the controls
* at the browser level.
****************************************************/
function fnClearFields(){
	var obj=document.forms[0];
	var len=obj.length;
	for(i=0;i<len;i++){
		if(obj[i].type == "text" || obj[i].type == "textarea"){
			var txtStr = obj[i].value;
			obj[i].value = "";
		}
		else if(obj[i].type == "select-one"){
			obj[i].options[0].selected ="true";
		}
		else if(obj[i].type == "radio"){
			obj[i].checked ="false";
		}
	}
	obj.actionCode.value = "Clear"; 
	obj.submit();
}

/*************************************************************
 * Function which validates blank entries and submits the form
 * if it is success.
 *************************************************************/
function fnValAndSubmit(btnObj){
	if(fnValidateData()){

		doSubmit(btnObj.id);

	}
}

/*********************************************************
 * 
 *
 ***********************************************************/


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
