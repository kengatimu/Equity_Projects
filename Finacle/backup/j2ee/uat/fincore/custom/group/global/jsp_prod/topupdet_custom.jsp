<!---------------------------------------------------------------------------------------------------------------->
<!--Name              :topupdet_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 12-07-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HTOPUP
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		12-07-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function topupdet_pre_ONCLICK(obj)
	{
		
	
	if(mopId == "HTOPUP")
		{
		if((obj.id=="Submit") || (obj.id=="Validate"))
				{
				if(document.forms[0].purposeOfTopUp.value == "")
					{
					alert("Enter purpose of topup");
					document.forms[0].purposeOfTopUp.focus();
					return false;
					}
				}
		}	
		
	}


</script>

