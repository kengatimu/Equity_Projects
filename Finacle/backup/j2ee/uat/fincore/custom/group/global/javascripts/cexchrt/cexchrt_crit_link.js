<!--    This is getting executing on click of submit and validate button -->
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
                if(document.forms[0].frmccyCode.value=='')
                {
                        alert("Please Enter From Currency Code");
                        document.forms[0].frmccyCode.focus();
                        return false;
                }
                if(document.forms[0].toccyCode.value=='')
                {
                        alert("Please Enter To Currency Code");
                        document.forms[0].toccyCode.focus();
                        return false;
                }
/*                if(document.forms[0].txnType.value=='')
                {
                        alert("Please Enter Transaction Type");
                        document.forms[0].txnType.focus();
                        return false;
                } */

                return true;
}
function fnGetRoleVal() {
    var ObjForm = document.forms[0];
    var roleId = ObjForm.roleId.value;

        var inputNameValues = "roleId|" + roleId;
        var outputNames = "errorFlg|errorMsg|roleId|roleDesc";
        var scriptName = "cexchrtdp001.scr"
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
function fnGetccyVal() {
    var ObjForm = document.forms[0];
    var frmccyCode = ObjForm.frmccyCode.value;

        var inputNameValues = "ccyCode|" + frmccyCode;
        var outputNames = "errorFlg|errorMsg|ccyCode|ccyDesc";
        var scriptName = "cexchrtdp002.scr"
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
        var token = retVal.split("|");
        if( (token != null)) {
            var errorFlg = token[1];
            var errorMsg = token[3];
            var ccyCode = token[5];
            var ccyDesc = token[7];
            if (errorFlg == "Y") {
                alert(errorMsg);
                ObjForm.frmccyCode.value = "";
                ObjForm.ccyDesc.value = "";
                setFieldFocus(ObjForm.frmccyCode);
                return false;
            } else {
                ObjForm.frmccyCode.value = ccyCode;
                ObjForm.ccyDesc.value = ccyDesc;
            }
        }
    return true;

}

function fnGetccyVal1() {
    var ObjForm = document.forms[0];
    var toccyCode = ObjForm.toccyCode.value;

        var inputNameValues = "ccyCode|" + toccyCode;
        var outputNames = "errorFlg|errorMsg|ccyCode|ccyDesc";
        var scriptName = "cexchrtdp002.scr"
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
        var token = retVal.split("|");
        if( (token != null)) {
            var errorFlg = token[1];
            var errorMsg = token[3];
            var ccyCode = token[5];
            var ccyDesc = token[7];
            if (errorFlg == "Y") {
                alert(errorMsg);
                ObjForm.toccyCode.value = "";
                ObjForm.toccyDesc.value = "";
                setFieldFocus(ObjForm.toccyCode);
                return false;
            } else {
                ObjForm.toccyCode.value = ccyCode;
                ObjForm.toccyDesc.value = ccyDesc;
            }
        }
    return true;

}

function cexchrt_crit_pre_ONLOAD()
{
	document.forms[0].roleDesc.disabled = true;
	document.forms[0].ccyDesc.disabled = true;
	document.forms[0].toccyDesc.disabled = true;
	return true;
}
