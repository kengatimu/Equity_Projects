
function pklink_det_post_ONLOAD()
{
	document.forms[0].funcCode.focus();
	var ObjForm = document.forms[0];
	if((ObjForm.funcCode.value == "V") ||(ObjForm.funcCode.value == "I") || (ObjForm.funcCode.value == "X") || (ObjForm.funcCode.value == "D"))
	{
		hideImage("sLnk2");
	}
	return true;
}
function fnValidateForm(obj)
{
	objForm = document.forms[0];
	return true;
}
function fnFuncCode()
{
	packagecode();
}
function packagecode()
{
	if(document.forms[0].funcCode.value == "A")
	{
		showImage("sLnk2");
	}
	else
	{
		hideImage("sLnk2");
	}
	return true;
}

function packageCodSearcher()
{
	if(document.forms[0].funcCode.value == "A")
	{
		var inputValues =       "funcCode|"+ document.forms[0].funcCode.value +"|packageCode|"+document.forms[0].packageCode.value;
		var outputValues=       "packageCode";
		var scrName     =       "KGP_PKLINK_packageCodeSearcher.scr";
		var literalNames=       "Package Code";
		var pageTitle   =       "List Of Package Code";
		var result      =       fnExecuteScriptForList(inputValues,outputValues,scrName,pageTitle,literalNames,"1",true);
	}
}

function showCustSearcher()
{
	var funcCode = document.forms[0].funcCode.value;

	if(funcCode != "")
	{
		if(funcCode == "A")
		{
			showCifId(document.forms[0].cifId,'ctrl','F',document.forms[0].custName);
		}
		else
		{

			var inputValues =       "funcCode|"+funcCode+"|cifId|"+document.forms[0].cifId.value;

			var outputValues=       "cifId|packageCode";

			var scrName     =       "KGP_PKLINK_customerIdSearcher.scr";

			var literalNames=       "Customer Id|Package Code";

			var pageTitle   =       "Customer Id List";

			var result      =       fnExecuteScriptForList(inputValues,outputValues,scrName,pageTitle,literalNames,"1",true);
		}
	}
}

function pklink_det_ONCHANGE6(f, g, e, c, b, a) {
    var d = "";
    if (preEventCall("pklink_det", f, "ONCHANGE") == false) {
        return false;
    }
    if (preEventCallForLocale("pklink_det", f, "ONCHANGE") == false) {
        return false;
    }
    if ((d = sendDataToServer(g, e, c, b, a)) == false) {
        return false;
    }
    if (postEventCallForLocale("pklink_det", f, "ONCHANGE") == false) {
        return false;
    }
    if (postEventCall("pklink_det", f, "ONCHANGE") == false) {
        return false;
    }
    return (d == undefined) ? true : d;
}
/*function fnFuncCode(obj)
  {
  if(obj.value == "M")
  {
  document.getElementById('B').style.display = "block";
  document.getElementById('C').style.display = "none";
  document.getElementById('D').style.display = "none";
  document.getElementById('E').style.display = "none";
  document.getElementById('F').style.display = "none";
  document.forms[0].openFrmDate_ui.focus();
  }
  if(obj.value == "R")
  {
  document.getElementById('D').style.display = "block";
  document.getElementById('C').style.display = "none";
  document.getElementById('E').style.display = "none";
  document.getElementById('F').style.display = "none";        
  document.getElementById('B').style.display = "none";
  document.forms[0].claimFrmDate_ui.focus();
  }	
  if(obj.value == "A")
  {
  document.getElementById('D').style.display = "block";
  document.getElementById('C').style.display = "none";
  document.getElementById('F').style.display = "none";
  document.getElementById('E').style.display = "none";
  document.getElementById('B').style.display = "none";	
  document.forms[0].claimFrmDate_ui.focus();
  }
  if(obj.value == "S")
  {
  document.getElementById('E').style.display = "block";
  document.getElementById('C').style.display = "none";
  document.getElementById('F').style.display = "none";
  document.getElementById('D').style.display = "none";
  document.getElementById('B').style.display = "none";
  document.forms[0].rptType.focus();
  }
  if(obj.value == "D")
  {
  document.getElementById('C').style.display = "block";
  document.getElementById('F').style.display = "block";
  document.getElementById('D').style.display = "none";
  document.getElementById('E').style.display = "none";
  document.getElementById('B').style.display = "none";
  document.forms[0].claimType.focus();
  }	
  }*/
function pklink_det_ONBLUR1(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('pklink_det',obj,'ONBLUR') == false) {
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
	if (postEventCall('pklink_det',obj,'ONBLUR') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnValidateForm(obj)
{
	objForm = document.forms[0];
	return true;
}

function fnClearFields()
{
	document.forms[0].reset();
	return true;
}

