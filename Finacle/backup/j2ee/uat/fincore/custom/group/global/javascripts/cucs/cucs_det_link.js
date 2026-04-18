<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		if(document.forms[0].status.value=="")
        {
            alert("Please select the Status");
            document.forms[0].status.focus();
            return false;
        }
		else
		{
			if(funcCode == "A")
			{
				if(document.forms[0].status.value!="Y")
				{
					alert("Please select the Status:Y-Certified Cheque");
					document.forms[0].status.focus();
					return false;
				}
			}
			if(funcCode == "R")
			{
				if(document.forms[0].status.value!="Z")
				{
					alert("Please select the Status:Z-Certified Cheque released");
					document.forms[0].status.focus();
					return false;
				}
			}
			if(funcCode == "M")
			{
				if(document.forms[0].status.value!="P")
				{
					alert("Please select the Status:P-Paid");
					document.forms[0].status.focus();
					return false;
				}
			}
		}
		
		if(document.forms[0].chqAmt.value=="")
        {
            alert("Please Enter a Cheque Amount");
            document.forms[0].chqAmt.focus();
            return false;
        }
		else
		{
			if(isNaN(document.forms[0].chqAmt.value))
			{	
				alert("Cheque Amount should be numeric only!!");
				document.forms[0].chqAmt.focus();
					return false;	
			}	
		}
		if(document.forms[0].paidAmt.value=="")
        {
            alert("Paid Amount should not be null");
            document.forms[0].paidAmt.focus();
            return false;
        }
		else
		{
			if(isNaN(document.forms[0].paidAmt.value))
			{	
				alert("Paid Amount should be numeric only!!");
				document.forms[0].paidAmt.focus();
					return false;	
			}	
		}

		return true;
}

function post_ONLOAD()
{
    var ObjForm = document.forms[0];
	if(funcCode !="M")
	{
		//document.forms[0].paidAmt.disabled = true;
		document.getElementById("paidAmt").disabled = true;
	}
	if(funcCode == "A")
	{
		document.getElementById("status").value = "Y";
		document.getElementById("status").disabled = false;
		document.getElementById("chqAmt").disabled = false;
		document.getElementById("paidAmt").value = "0";
	}
		
	if(funcCode =="R")
	{
		document.getElementById("status").value = "Z";
		document.getElementById("status").disabled = false;
		document.getElementById("chqAmt").disabled = true;
		document.getElementById("paidAmt").value = "0";
	}
	if(funcCode =="M")
	{
		document.getElementById("status").value = "P";
		document.getElementById("status").disabled = false;
		document.getElementById("chqAmt").disabled = true;
		document.getElementById("paidAmt").disabled = false;
	}
	
}
