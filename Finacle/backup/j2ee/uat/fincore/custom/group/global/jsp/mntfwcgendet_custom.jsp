<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : mntfwcgendet_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 02-07-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : MNTFWC
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		02-07-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>

function mntfwcgendet_pre_ONCLICK(obj)
{
	//alert("am in 1");
	if((obj.id=="Submit") || (obj.id=="Validate"))
	{
		//alert("am in");
		if (document.forms[0].acctId.value!="")
		{
			document.forms[0].custPayOutAcct.value = document.forms[0].acctId.value;
		}
	}
}

</script>

