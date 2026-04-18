<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
        if(fnIsNull(document.forms[0].funcCode.value))
        {
                alert("Please select a Function code");
		document.forms[0].funcCode.focus();
                return false;
        }
        if(fnIsNull(document.forms[0].evntId.value))
        {
                alert("Please select a Event ID");
		document.forms[0].evntId.focus();
                return false;
        }
        if(fnIsNull(document.forms[0].schmCode.value))
        {
                alert("Please select a Scheme Code");
		document.forms[0].schmCode.focus();
                return false;
        }
        if(fnIsNull(document.forms[0].crncy.value))
        {
                alert("Please select a Currency Code");
		document.forms[0].crncy.focus();
                return false;
        }

        if(fnIsNull(document.forms[0].srlNum.value))
        {
                alert("Please select a Serial Number");
		document.forms[0].srlNum.focus();
                return false;
        }
/*
        if(fnIsNull(document.forms[0].chrgType.value))
        {
                alert("Please select charge Type");
		document.forms[0].chrgType.focus();
                return false;
        }
*/
		return true;
}

function fnShowEvtIDList(a)
{
var c=objForm.evntType.value;
objForm.evntType.value=c.toUpperCase();
if(a.value=="V"||a.value=="X")
{
var a=a.value;
showVerfyPendList("PTT",a,"","","","F",document.forms[0].evntType,document.forms[0].evntId,"",document.forms[0].evntType)
}
else{
var b="N";
if(a.value=="I")
{
b=" "
}
getEvtIdList(document.forms[0].evntId,"ctrl","F","NULL",b,"Y",document.forms[0].evntType.value)
}
}



function fnShowEventType()
{
showDetailsPageForDynCritSearcher("EVENTTYPES","",":evntType=event_type|:evtTypeDesc=event_type_desc")
};


function fnGetSchmVal() {
    var ObjForm = document.forms[0];
    var schmCode = ObjForm.schmCode.value;

        var inputNameValues = "schmCode|" + schmCode;
        var outputNames = "errorFlg|errorMsg|schmCode";
        var scriptName = "ccprmdp001.scr"
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

function fnGetCrncyVal() {
    var ObjForm = document.forms[0];
    var crncy = ObjForm.crncy.value;

        var inputNameValues = "crncy|" + crncy;
        var outputNames = "errorFlg|errorMsg|crncy";
        var scriptName = "ccprmdp002.scr"
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
        var token = retVal.split("|");
        if( (token != null)) {
            var errorFlg = token[1];
            var errorMsg = token[3];
            var crncy = token[5];
            if (errorFlg == "Y") {
                alert(errorMsg);
                ObjForm.crncy.value = "";
                setFieldFocus(ObjForm.crncy);
                return false;
            } else {
                ObjForm.crncy.value = crncy;
            }
        }
    return true;

}

function fnGetEvtIdVal() {
    var ObjForm = document.forms[0];
    var evntId = ObjForm.evntId.value;

        var inputNameValues = "evntId|" + evntId;
        var outputNames = "errorFlg|errorMsg|evntId";
        var scriptName = "ccprmdp003.scr"
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
        var token = retVal.split("|");
        if( (token != null)) {
            var errorFlg = token[1];
            var errorMsg = token[3];
            var evntId = token[5];
            if (errorFlg == "Y") {
                alert(errorMsg);
                ObjForm.evntId.value = "";
                setFieldFocus(ObjForm.evntId);
                return false;
            } else {
                ObjForm.evntId.value = evntId;
            }
        }
    return true;
}

function fnGetEvtTypVal() {
    var ObjForm = document.forms[0];
    var evntType = ObjForm.evntType.value;

        var inputNameValues = "evntType|" + evntType;
        var outputNames = "errorFlg|errorMsg|evntType";
        var scriptName = "ccprmdp004.scr"
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
        var token = retVal.split("|");
        if( (token != null)) {
            var errorFlg = token[1];
            var errorMsg = token[3];
            var evntType = token[5];
            if (errorFlg == "Y") {
                alert(errorMsg);
                ObjForm.evntType.value = "";
                setFieldFocus(ObjForm.evntType);
                return false;
            } else {
                ObjForm.evntType.value = evntType;
            }
        }
    return true;
}

function showsrlNum()
{
	var ObjForm = document.forms[0];
	var evntType = ObjForm.evntType.value;
	var evntId = ObjForm.evntId.value;

	if(fnIsNull(evntType))
	{
		alert("Enter the Event Type");
		return;
	}

	if(fnIsNull(evntId))
	{
		alert("Enter the Event Id");
		return;
	}

        var inputNameValues = "evntType|"+evntType+"|evntId|"+evntId;
        var outputNameValues = "srlNum|tranrmks";
        var scriptName = "ccprmdp005.scr";
        var listHeading = "List Of Serial Numbers"
        var colHeader = "Serial Number| Tran Remarks";
        var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
}
function fnGetsrlNumVal() {
	var ObjForm = document.forms[0];
	var evntType = ObjForm.evntType.value;
	var evntId = ObjForm.evntId.value;
	var srlNum = ObjForm.srlNum.value;

	if(fnIsNull(evntType))
	{
		alert("Enter the Event Type");
                ObjForm.srlNum.value = "";
		return;
	}

	if(fnIsNull(evntId))
	{
		alert("Enter the Event Id");
                ObjForm.srlNum.value = "";
		return;
	}
	if(fnIsNull(srlNum))
	{
		alert("Enter the srlNum");
		return;
	}

        var inputNameValues = "evntType|" + evntType+"|evntId|"+evntId+"|srlNum|"+srlNum;
        var outputNames = "errorFlg|errorMsg";
        var scriptName = "ccprmdp006.scr"
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
        var token = retVal.split("|");
        if( (token != null)) 
	{
            var errorFlg = token[1];
            var errorMsg = token[3];
            var srlNum = token[5];
            if (errorFlg == "Y") 
	    {
                alert(errorMsg);
                ObjForm.srlNum.value = "";
                setFieldFocus(ObjForm.srlNum);
                return false;
            } 
        }
    return true;
}

