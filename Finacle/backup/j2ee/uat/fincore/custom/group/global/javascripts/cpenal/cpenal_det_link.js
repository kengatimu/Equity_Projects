<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		if(funcCode == "W")
		{
			if(document.forms[0].addlWavingOffAmt.value == "")
			{
				alert("Please Enter Additional Waiving off amount");
				document.forms[0].addlWavingOffAmt.focus();
				return false;
			}
			else
			{
				if(isNaN(document.forms[0].addlWavingOffAmt.value))
				{	
					alert("Additional Waiving off amount should be numeric only!!");
					document.forms[0].addlWavingOffAmt.focus();
					return false;	
				}	
			}
			
			if(document.forms[0].waivingOffReason.value == "")
			{
				alert("Please Enter Waiving Off Reason");
				document.forms[0].waivingOffReason.focus();
				return false;
			}
			else
			{
				var str = document.forms[0].waivingOffReason.value;
				var n = str.length;
				if(n >= 200)
				{
					alert("Waiving Off Reason should be less than 200 char");
					document.forms[0].waivingOffReason.focus();
					return false;
				}
			}
		}
		return true;
}


function functionChange(obj)
{
    var ObjForm = document.forms[0];
	
	if(funcCode == "I")
	{
		document.getElementById('addlWavingOffAmt').style.visibility = 'hidden';
		document.getElementById('waivingOffReason').style.visibility = 'hidden';
		document.getElementById('L1').style.visibility = 'hidden';
		document.getElementById('L2').style.visibility = 'hidden';
	}
		
	if(funcCode =="W")
	{
		document.getElementById("acctName").disabled = true;
		document.getElementById("acctCrncyCode").disabled = true;
		document.getElementById("solId").disabled = true;
		document.getElementById("pAccrAmtDr").disabled = true;
		document.getElementById("pAccrUpToDateDr").disabled = true;
		document.getElementById("pApplUpToDateDr").disabled = true;
		document.getElementById("pApplAmtDr").disabled = true;
		document.getElementById("totWaivedOffAmt").disabled = true;
		document.getElementById("lastWaivedOffDate").disabled = true;
		document.getElementById("addlWavingOffAmt").disabled = false;
		document.getElementById("waivingOffReason").disabled = false;
		
	}
	
}
