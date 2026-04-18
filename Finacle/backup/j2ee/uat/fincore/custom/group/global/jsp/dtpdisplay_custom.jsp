<!--------------------------------------------------------------------------------------------------------------->
<!--Name                : dtpdisplay_custom.jsp 
<!--Description         : 
<!--Date                : 07-02-2020
<!--Author              : Vino Palani 
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HDRP 
<!--Modification History:
<!--    Version No.           Date                       Author                 Description
<!--    -------         ----------                       -----------        ------------------
<!--     0.1            07-02-2020                       Vino Palani          Original version
<!---------------------------------------------------------------------------------------------------------------->
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="dtprint" isEntryPoint="false" />
<script type="text/javascript">
function dtpdisplay_pre_ONLOAD(obj){
	if (profileId == "54"){
        var inputNameValues = "ProfileId|profileId";
        var outputNames     = "";
        var scrName         = "ebHdrpGet.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
	var mopId =ret1[1];
	if ((mopId == "HDRP") || (profileId == "54")){
	document.oncontextmenu = new Function("return false;");
	doPnt();
	}
	}
}
function doPnt() {
    var ret = null;
    var hdeviceId;
    if (document.forms[0].deviceId[0].selected) {
        if (document.frames.dataframe.window.document.queryCommandSupported("print")) {
            document.frames.dataframe.window.document.execCommand("print", false, null)
        } else {
            dataframe.focus();
            dataframe.print()
        }
        ret = true
    } else {
        if (TPRNT_Pflg || LPRNT_Pflg || SPPRN_Pflg || PBRN_Pflg) {
            hdeviceId = document.forms[0].deviceId.value;
            if (!fnIsNull(hdeviceId)) {
                ret = eval(hdeviceId + "_Invoke").call()
            } else {
                alert(finbranchResource.FAT002908);
                document.forms[0].deviceId.focus()
            }
        } else {
            alert(finbranchResource.FAT002909)
        }
    }
    if (ret == true) {
        printTried = true;
        if (dupPrntAlwd != "true") {
            getUserConfi()
        }
    } else {
        document.forms[0].deviceId.value = hdeviceId;
        return false
    }
    return true
}
function getUserConfi() {
    if (!window.showModalDialog) {
        genericCallBackFn = [];
        genericCallBackFn = "getUserConfi_callBack"
    }
    var c = document.forms[0];
    var a = "&isInventoryUsedChkReq=" + checkInventoryUsed + "&isPQTFile=" + isPQTFile;
    ret = popModalWindow("../dtprint/" + applangcode + "/dtpconf.jsp?" + a, "Print Confirmation");
    if (window.showModalDialog) {
        var b = ret.split("|");
        c.deleteFile.value = b[1];
	if(b[1]=="N"){
	c.deleteFile.value = "Y";
	}
        c.inventoryUsed.value = b[2];
        c.printedSuccessfully.value = b[3];
	if(b[3]=="N"){
        c.printedSuccessfully.value = "Y"; 
	}
        if ((checkInventoryUsed == "true" && dupPrntAlwd != "true") && (c.printedSuccessfully.value != "Y" && c.inventoryUsed.value != "Y")) {
            printTried = false
        } else {
            doSubmit("ProceedAfterPrint")
        }
    }
    return
}
function getUserConfi_callBack(b) {
    var a = b.split("|");
    var c = document.forms[0];
    c.deleteFile.value = a[1];
	if(a[1]=="N"){
	c.deleteFile.value = "Y";
	}
    c.inventoryUsed.value = a[2];
	if( a[2]=="N"){
		c.inventoryUsed.value = "Y";
	}
    c.printedSuccessfully.value = a[3];
	if(a[3]=="N"){
		c.printedSuccessfully.value ="Y";
	}
    if ((checkInventoryUsed == "true" && dupPrntAlwd != "true") && (c.printedSuccessfully.value != "Y" && c.inventoryUsed.value != "Y")) {
        printTried = false
    } else {
        doSubmit("ProceedAfterPrint")
    }
}
function doPostPrintWork() {
    if (!printTried) {
        document.forms[0].Print.disabled = false;
        hideImage(divReturn.id);
        showImage(divCancel.id)
    } else {
        document.forms[0].Print.disabled = true;
        hideImage(divCancel.id);
        showImage(divReturn.id)
    }
}
</script>
