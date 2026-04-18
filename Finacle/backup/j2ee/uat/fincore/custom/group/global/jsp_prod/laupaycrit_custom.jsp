<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : laupaycrit_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 25-06-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HLAUPAY
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		25-06-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function laupaycrit_post_ONLOAD()
	{
	if(mopId == "HLAUPAY")
		{
		var radioButtons = document.getElementsByName('tranType');
		radioButtons[0].checked = false;
        radioButtons[1].checked = true;
		}
		{
		var radioButtons = document.getElementsByName('drFrmAcct');
		radioButtons[1].checked = false;
        radioButtons[0].checked = true;
		}
	}

</script>

