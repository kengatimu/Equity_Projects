<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (document.forms[0].fileField.value == "")
		{
			alert("Enter the Upload File name.");
			return false;
		}
		if (document.forms[0].funcCode.value == "")
		{
			alert("Enter Function Code");
			return false;
		}
		return true;
}

function caclhm_det_ONCLICK1(obj,p1)
{
	if (fnValidateData() == false) {
                return false;
        }
        fnUpload(obj);
}

function fnUpload(obj){

        if(!fnValidateData){
                return false;
        }

        var ObjForm = document.forms[0];
        if(ObjForm != null)
        {
                ObjForm.encoding = "multipart/form-data";
                var qrystr ="";
                for (var i = 0;i < ObjForm.elements.length; i++)
                {
                        var locVal = ObjForm.elements[i].value;
                        if(ObjForm.elements[i].name == "actionCode")
                        {
                                ObjForm.elements[i].value = "upload";
                        }

                        if (locVal != null && locVal.length > 0 && locVal != "" && locVal != " ")
                        {
                                if(ObjForm.elements[i].name == "undefined" || (ObjForm.elements[i].value != null && ObjForm.elements[i].value == "undefined" ))
                                        continue;
                                if(qrystr.length == 0)
                                {
                                        qrystr = ObjForm.elements[i].name + "=" + ObjForm.elements[i].value
                                }
                                else
                                {
                                        qrystr = qrystr + "&" + ObjForm.elements[i].name +"=" + ObjForm.elements[i].value
                                }
                        }
                }

                if(qrystr.indexOf("actionCode")==-1)
                {
                        qrystr = qrystr + "&actionCode=upload"
                }
                if(qrystr.indexOf("?")==-1 || qrystr.indexOf("?")!=0)
                {
                        qrystr = "?" + qrystr
                }
                ObjForm.action = ObjForm.action + qrystr
		disablePageLinks();
		hideAnchors();
		disableButtons();
		ObjForm.submit();
        }
}
