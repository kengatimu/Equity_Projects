<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : irmcrit_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.This is used to pass the values.
<!--Date                : 21-03-2013
<!--Author              : Shilpa
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HIRM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            21-03-2013           Shilpa           Original version
<!--     0.2            6-06-2013           Shilpa           Original version
<!---------------------------------------------------------------------------------------------------------------->

<script type ="text/javascript">
function irmcrit_pre_ONCLICK(obj)
{
	var funcCode = document.forms[0].funcCode.value;
	var currency = document.forms[0].remitCcy.value;
	var remitType = document.forms[0].remitType.value;
	var remitCcy = currency.toUpperCase();

	if (profileId =="11" && obj.id == "Accept")
	{
		if (funcCode == "G" || funcCode == "J")
		{
			if (remitCcy == "USD" && remitType != "INWRMTTUSD")
			{
				alert ("Use Remit Type INWRMTTUSD when Remit Currency is USD");
				document.forms[0].remitType.value = "";
				document.forms[0].remitType.focus();
				return false;
			}
			if (remitCcy != "USD" && remitType == "INWRMTTUSD")
			{
				alert ("Dont Use Remit Type INWRMTTUSD when Remit Currency is not USD");
				document.forms[0].remitType.value = "";
				document.forms[0].remitType.focus();
				return false;
			}
		}
	}
setFieldsToCustomData("remitType","remitCcy","funcCode");
}
</script>


