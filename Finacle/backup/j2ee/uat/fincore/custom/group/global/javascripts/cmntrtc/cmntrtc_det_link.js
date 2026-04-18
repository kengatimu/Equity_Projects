<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		if(document.forms[0].rateCodeCash.value =='')
		{
			alert("Please Enter the Rate Code");
			document.forms[0].rateCodeCash.focus();
			return false;
		}
		 if(document.forms[0].rateCodeTransfer.value =='')
                {
                        alert("Please Enter the Rate Code");
                        document.forms[0].rateCodeTransfer.focus();
                        return false;
                }

		return true;
}

function fnGetFunctionCodeDesc(f){
        switch(f){
                case 'A': return "Add";
                case 'M': return "Modify";
                case 'V': return "Verify";
                case 'I': return "Inquire";
                                case 'X': return "Cancel";
                default : return f;
        }

}
function cmntrtc_det_post_ONLOAD() {

        if((funcCode == "V") || (funcCode == "I") || (funcCode == "X") || (funcCode == "D")){
                document.forms[0].rateCodeCash.disabled=true;
                document.forms[0].rateCodeTransfer.disabled=true;
        }
}


function fnGetrateCodeCash(){
    var ObjForm = document.forms[0];
    
    var rateCodeCash = ObjForm.rateCodeCash.value;
        var inputNameValues = "rateCodeCash|" + rateCodeCash;
        var outputNames = "errorFlg|errorMsg|rateCodeCash";
        var scriptName = "cmntrtcdp003.scr"
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
        var token = retVal.split("|");
        if( (token != null)) {
            var errorFlg = token[1];
            var errorMsg = token[3];
            var rateCodeCash = token[5];
            if (errorFlg == "Y") {
                alert(errorMsg);
                ObjForm.rateCodeCash.value = "";
                setFieldFocus(ObjForm.rateCodeCash);
                return false;
            } else {
                ObjForm.rateCodeCash.value = rateCodeCash;
            }
        }
    return true;
}

function fnGetrateCodetransfer(){
    var ObjForm = document.forms[0];
    
    var rateCodeTransfer = ObjForm.rateCodeTransfer.value;
        var inputNameValues = "rateCodeTransfer|" + rateCodeTransfer;
        var outputNames = "errorFlg|errorMsg|rateCodeCash";
        var scriptName = "cmntrtcdp004.scr"
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
        var token = retVal.split("|");
        if( (token != null)) {
            var errorFlg = token[1];
            var errorMsg = token[3];
            var rateCodeTransfer = token[5];
            if (errorFlg == "Y") {
                alert(errorMsg);
                ObjForm.rateCodeTransfer.value = "";
                setFieldFocus(ObjForm.rateCodeTransfer);
                return false;
            } else {
                ObjForm.rateCodeTransfer.value = rateCodeTransfer;
            }
        }
    return true;
}
