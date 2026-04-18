<!---------------------------------------------------------------------------------------------------------------->
<!--Name              :tdrendet_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 15-12-2016
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HOAACTD
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		15-12-2016	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
 function post_ONLOAD()
	{
		//alert("m in");
	if(mopId == "HOAACTD")
		{
				var radioButtons = document.getElementsByName('autoClosureFlg');
				radioButtons[0].checked = true;
                radioButtons[1].checked = false;
                

		}	
		
	}

</script>
