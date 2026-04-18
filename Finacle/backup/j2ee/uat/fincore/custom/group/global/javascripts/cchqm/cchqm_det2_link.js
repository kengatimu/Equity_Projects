<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}

function fnOnChange()
{
if(document.forms[0].funCode.value=='U')
{
		document.getElementById('download').style.visibility='hidden';
		document.getElementById('down').style.visibility='hidden';
		document.getElementById('fileField').style.visibility='visible';
        	document.getElementById('up').style.visibility='visible';
		document.getElementById('sLnk2').style.visibility='hidden';

}
if(document.forms[0].funCode.value=='D')
{
	document.getElementById('fileField').style.visibility='hidden';
	document.getElementById('up').style.visibility='hidden';
	document.getElementById('download').style.visibility='visible';
        document.getElementById('down').style.visibility='visible';
	document.getElementById('sLnk2').style.visibility='visible';
}
return true;
}

function cchqm_det2_pre_ONCLICK(obj){
        if(obj.id == 'Cancel')
        {
                document.forms[0].reset();
                doSubmit("clear");
                return false;
        }
  return true;

}


