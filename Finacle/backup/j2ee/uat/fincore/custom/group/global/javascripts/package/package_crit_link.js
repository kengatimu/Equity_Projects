<!--    This is getting executing on click of submit and validate button -->
function fnValidateData() {
	if (!fnCheckMandatoryFields())
	{
		return false;
	}
	if(fnIsNull(document.forms[0].funcCode.value))
        {
                alert("Function Code cannot be left blank");
                document.forms[0].funcCode.focus();
                return false;
        }
        if(fnIsNull(document.forms[0].packageCode.value))
        {
                alert("Package Code cannot be left blank");
                document.forms[0].packageCode.focus();
                return false;
        }	
	return true;
}

function package_crit_post_ONLOAD()
{
	document.forms[0].funcCode.focus();
	if(document.forms[0].funcCode.value == "A")
	{
		hideImage("sLnk2");
	}
	return true;
}

function functioncode()
{
	packagecode();
}
function packagecode()
{
	if(document.forms[0].funcCode.value == "A")
        {
                hideImage("sLnk2");
        }
	else
	{
		showImage("sLnk2");
	}
	return true;
} 

function packageCodSearcher()
{
        if(document.forms[0].funcCode.value != "A")
        {
                        var inputValues =       "funcCode|"+ document.forms[0].funcCode.value +"|packageCode|"+document.forms[0].packageCode.value;
                        var outputValues=       "packageCode";
                        var scrName     =       "DXC_BOI_PACKAGE_packageCodeSearcher.scr";
                        var literalNames=       "Package Code";
                        var pageTitle   =       "List Of Package Code";
                        var result      =       fnExecuteScriptForList(inputValues,outputValues,scrName,pageTitle,literalNames,"1",true);
        }
}

/*function fnFuncCode(obj)
{
        if((obj.value == "M")||(obj.value == "V")||(obj.value == "X")||(obj.value == "I"))
        {
                document.getElementById('A').style.display = "block";
        }
        else
        {
                document.getElementById('A').style.display = "none";
        }
}*/

function package_det_ONBLUR1(obj,p1,p2)
{
        var retVal = "";
        if (preEventCall('package_det',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = onBlurFormatDate(p1)) == false) {
                p1.value = "";
                p1.focus();
                return false;
        }
        if ((retVal = fnAssignDateOnEnter(p2)) == false) {
                return false;
        }
        if (postEventCall('package_det',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
