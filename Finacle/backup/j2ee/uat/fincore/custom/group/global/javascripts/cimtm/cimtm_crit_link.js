<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields()){
			return false;
		}
		if(fnIsNull(document.forms[0].funcCode.value)){
			alert("Enter Function Code");
			document.forms[0].funcCode.focus();
			return false;
		}
	        if((document.forms[0].funcCode.value != "AP") && (document.forms[0].funcCode.value != "A")){
			if(fnIsNull(document.forms[0].PymntRefNum.value)){
				alert("Enter Payment Ref Number");
				document.forms[0].PymntRefNum.focus();
				return false;
			}
			if(fnIsNull(document.forms[0].pymntRefDate.value)){
				alert("Enter Payment Ref Date");
				document.forms[0].pymntRefDate.focus();
				return false;
			}
		}
		return true;
}

function funcCodeOnchange()
{
       var ObjForm = document.forms[0];
	if(document.forms[0].funcCode.value == "A")
	{
		document.forms[0].PymntRefNum.value = "";
		document.forms[0].pymntRefDate.value = "";
                //showImage("sLnk2");
		document.forms[0].pymntRefDate_ui.disabled=true;
		document.forms[0].PymntRefNum.disabled=true;
        }
        else
        {
		document.forms[0].pymntRefDate_ui.disabled=false;
		document.forms[0].PymntRefNum.disabled=false;
                //showImage("sLnk2");
                //hideImage("sLnk2");
        }
}
