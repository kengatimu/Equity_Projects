<!---------------------------------------------------------------------------------------------------------------->
<!--Name              :tdgendet_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 12-07-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HOAACTD
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		12-07-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function tdgendet_pre_ONCLICK(obj)
	{
		
	
	if(mopId == "HOAACTD")
		{
		if((obj.id=="Submit") || (obj.id=="Validate"))
				{
				if(document.forms[0].modeOfOperCode.value == "")
					{
					alert("Enter mode of operation");
					document.forms[0].modeOfOperCode.focus();
					return false;
					}
				}
		}	
		
	}


</script>
