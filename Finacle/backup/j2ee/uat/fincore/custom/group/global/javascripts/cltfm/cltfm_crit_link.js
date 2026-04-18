<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
	if(document.forms[0].funcCode.value=="")
		{
			alert("Please select the Function");
			document.forms[0].funcCode.focus();
			return false;
		}
		if(document.forms[0].type.value=="")
		{
			alert("Please Select the Type");
			document.forms[0].type.focus();
			return false;
		}
		if(document.forms[0].type.value =="scheme"){
			if(document.forms[0].schmCode.value=="")
		{
			alert("Please Enter the Scheme Code");
			document.forms[0].schmCode.focus();
			return false;
		}
		}
		if(document.forms[0].type.value =="customer"){
		if(document.forms[0].cifId.value=="")
		{
			alert("Please Enter the Customer ID");
			document.forms[0].cifId.focus();
			return false;
		}	
		}
		if(document.forms[0].type.value == "account"){
		if(document.forms[0].acctId.value == "")
		{
			alert("Please Enter the Account Number");
			document.forms[0].acctId.focus();
			return false;
		}
		}
		return true;
}

function cltfm_det_ONCLICK5(obj){
	if(obj.id == 'Cancel')
        {
                document.forms[0].reset();
                doSubmit("clear");
                return false;
        }
  return true;
}

function cltfm_crit_pre_ONCLICK(obj)
{
  if(obj.id == 'Clear')
        {
                document.forms[0].reset();
                doSubmit("clear");
                return false;
        }
  return true;
}


function fnValAndSubmit(btnObj){
        var ObjForm = document.forms[0];
        //var txnType = ObjForm.txnType.value;
        var funcCode = ObjForm.funcCode.value;
	if(fnValidateData()){
             doSubmit(btnObj.id);
                        return;
        }
}
function showEntityList1() {
    var inputNameValues = "schmCode| "
    var outputNameValues = "schmCode|Desc";
    var scriptName = "cltfmdp001.scr";
    var listHeading = "Scheme Codes";
    var colHeader = "Scheme Code|Scheme Description";
    var RetVal = fnExecuteScriptForList(inputNameValues, outputNameValues, scriptName, listHeading, colHeader, "1", true);
    var ObjForm = document.forms[0];
}

function fnSchmCode(){
    var ObjForm = document.forms[0];
    var schmCode = ObjForm.schmCode.value;
    
        var inputNameValues = "schmCode|" + schmCode ;
        var outputNames = "errorFlg|errorMsg|schmCode";
        var scriptName = "cltfmdp002.scr"
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
        var token = retVal.split("|");
        if( (token != null)) {
            var errorFlg = token[1];
            var errorMsg = token[3];
            var schmCode = token[5];
            if (errorFlg == "Y") {
                alert(errorMsg);
                ObjForm.schmCode.value = "";
                setFieldFocus(ObjForm.schmCode);
                return false;
            } else {
                ObjForm.schmCode.value = schmCode;
            }
        }
    return true;
}

function fnGetCifIdVal() {
    var ObjForm = document.forms[0];
    //var acctNum = ObjForm.acctNum.value;
    var cifId = ObjForm.cifId.value;
        var inputNameValues =  "cifId|" + cifId;
        var outputNames = "errorFlg|errorMsg|cifId";
        var scriptName = "cltfmdp003.scr"
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
        var token = retVal.split("|");
        if( (token != null)) {
            var errorFlg = token[1];
            var errorMsg = token[3];
            var cifId = token[5];
            if (errorFlg == "Y") {
                alert(errorMsg);
                ObjForm.cifId.value = "";
                setFieldFocus(ObjForm.cifId);
                return false;
            } else {
                ObjForm.cifId.value = cifId;
            }
        }
    return true;
}

function fnAcctNumVal() {
    var ObjForm = document.forms[0];
    //var acctNum = ObjForm.acctNum.value;
    var acctId = ObjForm.acctId.value;
        var inputNameValues =  "acctId|" + acctId;
        var outputNames = "errorFlg|errorMsg|acctId";
        var scriptName = "cltfmdp004.scr"
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
        var token = retVal.split("|");
        if( (token != null)) {
            var errorFlg = token[1];
            var errorMsg = token[3];
            var acctId = token[5];
            if (errorFlg == "Y") {
                alert(errorMsg);
                ObjForm.acctId.value = "";
                setFieldFocus(ObjForm.acctId);
                return false;
            } else {
                ObjForm.acctId.value = acctId;
            }
        }
    return true;
}

function fnOnChange()
{

        var ObjForm = document.forms[0];
        var type= ObjForm.type.value;
        fnClearInputFields();
        if(type == "scheme")
        {
              ObjForm.cifId.disabled = true;
		ObjForm.acctId.disabled = true;
              hideImage("sLnk3");
		hideImage("sLnk4");
			  ObjForm.schmCode.disabled = false;
                showImage("sLnk2");
			  
        }
        if(type == "customer")
        {
                ObjForm.schmCode.disabled = true;
		ObjForm.acctId.disabled = true;
                hideImage("sLnk2");
		hideImage("sLnk4");
				ObjForm.cifId.disabled = false;
              showImage("sLnk3");
        }
	if(type == "account")
	{
	ObjForm.schmCode.disabled = true;
	ObjForm.cifId.disabled = true;
	hideImage("sLnk2");
	hideImage("sLnk3");
	ObjForm.acctId.disabled = false;
	showImage("sLnk4");
	}

}
function fnClearInputFields()
{
        var ObjForm=document.forms[0];
//	ObjForm.funcCode.value = "";
        ObjForm.schmCode.value = "";
        ObjForm.cifId.value = "";
	ObjForm.acctId.value ="";
        //ObjForm.type.value = "";
}

function cltfm_crit_post_ONLOAD()
{

        var ObjForm = document.forms[0];
        var type= ObjForm.type.value;
        fnClearInputFields();
	 if(type == "scheme")
        {
              ObjForm.cifId.disabled = true;
                ObjForm.acctId.disabled = true;
              hideImage("sLnk3");
                hideImage("sLnk4");
                          ObjForm.schmCode.disabled = false;
                showImage("sLnk2");

        }
        if(type == "customer")
        {
                ObjForm.schmCode.disabled = true;
                ObjForm.acctId.disabled = true;
                hideImage("sLnk2");
                hideImage("sLnk4");
                                ObjForm.cifId.disabled = false;
              showImage("sLnk3");
        }
        if(type == "account")
        {
        	ObjForm.schmCode.disabled = true;
        	ObjForm.cifId.disabled = true;
        	hideImage("sLnk2");
        	hideImage("sLnk3");
        	ObjForm.acctId.disabled = false;
        	showImage("sLnk4");
        }
	
}

