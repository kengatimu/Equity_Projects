<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : acmps_int_tax_details_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 15-07-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : OAACPS
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		15-07-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>

function acmps_int_tax_details_pre_ONCLICK(obj)
{
	//alert("am in 1");
	if((obj.id=="Submit") || (obj.id=="Validate"))
	{
		//alert("am in");
		if (document.forms[0].intCreditAcId.value!="")
		{
			document.forms[0].intDebitAcId.value = document.forms[0].intCreditAcId.value;
		}
	}
}

</script>

