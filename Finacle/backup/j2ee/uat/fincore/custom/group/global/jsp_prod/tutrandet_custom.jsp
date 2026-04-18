<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : tutrandet_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 30-07-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HOAACTU
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		30-07-2013	jane		Original version
<!--	0.2		31-01-2020	Irungu		IM2005272
<!---------------------------------------------------------------------------------------------------------------->
<script>
function tutrandet_post_ONLOAD()
{
	if(mopId == "HOAACTU")
	{
		var radioButtons = document.getElementsByName('pymntOption');
		radioButtons[0].checked = false;
       		radioButtons[1].checked = true;
		
		if (profileId=="43")
			{
			var radioButtons = document.getElementsByName('tranCreationFlag');
			radioButtons[0].checked = false;
			radioButtons[1].checked = true;
			fnEnableDisableRadioButtons(document.forms[0].tranCreationFlag,'D');
			}	
	}
	
}



</script>
