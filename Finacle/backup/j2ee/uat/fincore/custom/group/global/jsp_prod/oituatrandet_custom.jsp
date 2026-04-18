<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : oituatrandet_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 24-06-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : OITUA
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		25-06-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function oituatrandet_post_ONLOAD()
	{
	if(mopId == "OITUA")
		{
		var radioButtons = document.getElementsByName('tranTypeFlag');
		radioButtons[0].checked = false;
        radioButtons[1].checked = true;
		}
	}

</script>
