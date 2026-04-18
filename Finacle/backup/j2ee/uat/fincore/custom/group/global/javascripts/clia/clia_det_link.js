<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
if(parseFloat(currentAdjAmt)==parseFloat("0.00"))
{
alert("Current Adjustment Amount is Zero");
return false;

}
		return true;
}