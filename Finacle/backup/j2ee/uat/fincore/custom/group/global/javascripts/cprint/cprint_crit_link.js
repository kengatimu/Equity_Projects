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
		if(document.forms[0].roleId.value=='')
		{
			alert("Please Enter Role ID");
			document.forms[0].roleId.focus();
			return false;
		}
		return true;
}

function cprint_crit_pre_ONCLICK(obj)
{
  if(obj.id == 'Clear')
        {
                document.forms[0].reset();
                doSubmit("clear");
                return false;
        }
  return true;
}


function fnGetRoleVal() {
    var ObjForm = document.forms[0];
    var roleId = ObjForm.roleId.value;

        var inputNameValues = "roleId|" + roleId;
        var outputNames = "errorFlg|errorMsg|roleId|roleDesc";
        var scriptName = "cprintdp001.scr"
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
        var token = retVal.split("|");
        if( (token != null)) {
            var errorFlg = token[1];
            var errorMsg = token[3];
            var roleId = token[5];
            var roleDesc = token[7];
		if (errorFlg == "Y") {
                alert(errorMsg);
                ObjForm.roleId.value = "";
                ObjForm.roleDesc.value = "";
		 setFieldFocus(ObjForm.roleId);
                return false;
            } else {
                ObjForm.roleId.value = roleId;
            	ObjForm.roleDesc.value = roleDesc;
		}
        }
    return true;

}

function cprint_crit_pre_ONLOAD()
{
        document.forms[0].roleDesc.disabled = true;
        return true;
}

