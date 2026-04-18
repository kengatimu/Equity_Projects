
<!--	This gets executed on click of Go/Submit/Validate button -->
function fnValidateData() {
	var ObjForm = document.forms[0];
	if (!fnCheckMandatoryFields())
	{
		return false;
	}
    if (!validateTypes(ObjForm)) return false;
    if(!fnCustomValidateForm()) return false;
	return true;
}

function fnCustomSearcher_paysysId(){
    var ObjForm = document.forms[0];

    if((ObjForm.funcCode.value == "A") || (ObjForm.funcCode.value == "M") || (ObjForm.funcCode.value == "V") || (ObjForm.funcCode.value == "D")){
       // var returnVal = showPaySysIdList();
	var returnVal = locShowToPaysysId();

        
        fnFrontEndEvents_ONCLICK(ObjForm.cifId);

    }
}

function cprofilecrit_post_ONLOAD(obj){
	var ObjForm = document.forms[0];


	/* Confirmation Pop Up Display Start*/
	if(fnIsNull(ObjForm.cmmFetchCallMode.value)){
		ObjForm.cmmFetchCallMode.value = "E";
	}
	if(ObjForm.cmmFetchCallMode.value == "E"){
		if(!fnIsNull(cmmErrorDetails)){
			var errorLL = cmmErrorDetails.split("~");	
			var confMsgExists = "N";
			if(errorLL != undefined){
				for(var m=0; m < errorLL.length; m++){
					var errorDetails = errorLL[m].split("#");
					if(errorDetails != undefined){
						var errorType = errorDetails[0];
						var errorMsg = errorDetails[1];
						if(errorType == "C"){
							confMsgExists = "Y";
							break;
						}
					}			
				}
			}
			if(confMsgExists == "Y"){
				ObjForm.Accept.disabled = true;
				var sUrl = "../custom/jsp/displayCmmErrorDetails.jsp?&appLangCode="+appLangCode+ "&subGroupName="+subGroupName+ "&calbase="+calbase+ "&rtId=" +rtId+"&funcCode="+ObjForm.funcCode.value;
				var retVal = window.showModalDialog(sUrl,"Preview","dialogWidth:35;dialogHeight:15;status=no;toolbar=no;menubar=no;resizable=yes");
				if(retVal != undefined){
					if(retVal == "Accept"){
						ObjForm.cmmFetchCallMode.value = "N";
						ObjForm.Accept.disabled = false;
						ObjForm.Accept.click();
					}else{
						ObjForm.Accept.disabled = false;
					}
				}else{
					ObjForm.Accept.disabled = false;
				}
			}
		}
	}else{
		ObjForm.cmmFetchCallMode.value = "E";
	}
	/* Confirmation Pop Up Display End*/

    return true;
}

function fnCustomValidateForm(){
	var ObjForm = document.forms[0];

    return true;
}

function fnFrontEndEvents_ONBLUR(obj){
	var ObjForm = document.forms[0];


    return true;
}

function fnFrontEndEvents_ONCHANGE(obj){
	var ObjForm = document.forms[0];


    return true;
}

function fnFrontEndEvents_ONCLICK(obj){
	var ObjForm = document.forms[0];


    return true;
}
function locShowToCifId(){
	
	console.log(document.forms[0].cifId)
	//showRefCode(document.forms[0].cifId,'CK','N','B','');
	if(document.forms[0].funcCode.value="M")
	{
     alert(document.forms[0].funcCode.value);	
	 funcCode = document.forms[0].funcCode.value 
	 //var inputNameValues = "Function|"+document.forms[0].funcCode.value+"|EvtType|"+document.forms[0].EvtType.value.toUpperCase()+"|pageNumber|1|pageSize|20|navDir|N|";
	 var inputNameValues ="funcCode|"+funcCode;
     alert(inputNameValues);
	 var outputNames     = "cifId";
	 var title           = "Pending List of Customers" ;
	 var literalNames    = "CIF ID";
	 var scrName         = "cprofileFetchCifId.scr";
	 var hyperLnks       = "1";
	 var retVal          = fnExecuteScriptForList(inputNameValues,outputNames,scrName,title,literalNames,hyperLnks,true);

	}
}
