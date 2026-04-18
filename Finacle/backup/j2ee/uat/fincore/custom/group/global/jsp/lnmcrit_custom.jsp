<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : lnmcrit_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 07-08-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HLNM
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		07-08-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function lnmcrit_pre_ONCLICK(obj)
{
	if(mopId == "HLNM")
	{
	if (funcCode == "A" )
		{
		if(obj.id=="Accept")
			{
				var dco = document.forms[0].limPrefix.value;
				var input      = "dco|"+dco;
				var outputNames    = "output|outVal";
				var scrName     =   "b_limitprefix.scr";
				var retVal = appFnExecuteScript(input,outputNames,scrName,false);
				var retBuff = retVal.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var a = value;
				//alert(a);
				//document.forms[0].creditAcctNum.value=a;
				if (a=="0")
				{
					alert("Enter a valid CIF");
					document.forms[0].limPrefix.focus();
					return false;
				}
			}
		}
	}
}

</script>


