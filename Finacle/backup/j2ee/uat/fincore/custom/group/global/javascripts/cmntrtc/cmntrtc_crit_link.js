<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		if(document.forms[0].funcCode.value =='')

			{
				
				alert("Please Select the Function");
				document.forms[0].funcCode.focus();
				return false;
			}
		if(document.forms[0].fromCrncy.value=='')
		{
			alert("Please Enter From Currency");
			document.forms[0].fromCrncy.focus();
			return false;
		}
		if(document.forms[0].toCrncy.value=='')
		{
			alert("Please Enter To Currency");
			document.forms[0].toCrncy.focus();
			return false;

		}



		if((document.forms[0].fromCrncy.value) == (document.forms[0].toCrncy.value))
		{
			alert("FromCurrency and To Currency cannot be same");
			document.forms[0].fromCrncy.focus();
			return false;
		} 
		return true;
}
function fnValAndSubmit(btnObj){
        var ObjForm = document.forms[0];
        var funcCode = ObjForm.funcCode.value;
        if(fnValidateData()){
             doSubmit(btnObj.id);
                        return;
        }
}

function cmntrtc_crit_pre_ONCLICK(obj)
{

  if(obj.id == 'Clear')
        {
                document.forms[0].reset();
                doSubmit("clear");
                return false;
        }
  return true;
}

function fnGetCurrency(){
    var ObjForm = document.forms[0];
    
    var fromCrncy = ObjForm.fromCrncy.value;
        var inputNameValues = "fromCrncy|" + fromCrncy;
        var outputNames = "errorFlg|errorMsg|fromCrncy";
        var scriptName = "cmntrtcdp001.scr"
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
        var token = retVal.split("|");
        if( (token != null)) {
            var errorFlg = token[1];
            var errorMsg = token[3];
            var fromCrncy = token[5];
            if (errorFlg == "Y") {
                alert(errorMsg);
                ObjForm.fromCrncy.value = "";
                setFieldFocus(ObjForm.fromCrncy);
                return false;
            } else {
                ObjForm.fromCrncy.value = fromCrncy;
            }
        }
    return true;
}


function fnGetCurrency1(){
    var ObjForm = document.forms[0];
    
    var toCrncy = ObjForm.toCrncy.value;
        var inputNameValues = "toCrncy|" + toCrncy;
        var outputNames = "errorFlg|errorMsg|toCrncy";
        var scriptName = "cmntrtcdp002.scr"
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
        var token = retVal.split("|");
        if( (token != null)) {
            var errorFlg = token[1];
            var errorMsg = token[3];
            var toCrncy = token[5];
            if (errorFlg == "Y") {
                alert(errorMsg);
                ObjForm.toCrncy.value = "";
                setFieldFocus(ObjForm.toCrncy);
                return false;
            } else {
                ObjForm.toCrncy.value = toCrncy;
            }
        }
    return true;
}

