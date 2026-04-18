<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		if(getRadioValue(document.forms[0].tax)=='')
		{
			alert("Please Select the Tax Option");
			document.forms[0].tax.focus();
			return false;
		}
	if(document.forms[0].percentage.disabled !=true)
	{
		if(document.forms[0].percentage.value=="")
		{
			alert("Please Enter Tax Percentage");
			document.forms[0].percentage.focus();
			return false;
		}
		else
		{	
			if(document.forms[0].percentage.value==0)
			{
				alert("Tax Percentage should be greater than 0");
                        	document.forms[0].percentage.focus();
                        	return false;
			}
			
			if(isNaN(document.forms[0].percentage.value))
			{
				alert("Tax Percentage should be numeric only!!");
				document.forms[0].percentage.focus();
                                return false;
			}

			if((document.forms[0].percentage.value < 0) || (document.forms[0].percentage.value > 100))
			{
				alert("Percentage can range from 0 to 100 only!!");
				document.forms[0].percentage.focus();
                                return false;
                        }
	
		}	

		//return false;
		return true;
	}
		return true;
}

function cltfm_det_post_ONLOAD() {

//        if((funcCode == "A") || (funcCode == "M") || (funcCode == "V") || (funcCode == "I") || (funcCode == "X")){
        if((funcCode == "A") || (funcCode == "V") || (funcCode == "I") || (funcCode == "X")){
                document.forms[0].schmCode.disabled=true;
                document.forms[0].cifId.disabled=true;
		document.forms[0].acctId.disabled = true;
		document.forms[0].percentage.disabled = true;
        }
        if(funcCode == "M"){
                document.forms[0].schmCode.disabled=true;
                document.forms[0].cifId.disabled=true;
		document.forms[0].acctId.disabled = true;
		if (document.forms[0].percentage.value==""){
		document.forms[0].percentage.disabled = true;
		}
        }
        if((funcCode == "V") || (funcCode == "I") || (funcCode == "X")){
		document.forms[0].tax[0].disabled = true;
		document.forms[0].tax[1].disabled = true;
	}
}


function cltfm_det_pre_ONCLICK(obj){
        if(obj.id == 'Cancel')
        {
                document.forms[0].reset();
                doSubmit("clear");
                return false;
        }
  return true;

}



