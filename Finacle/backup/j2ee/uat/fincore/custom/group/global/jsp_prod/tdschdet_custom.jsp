<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : tdschdet_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 03-02-2014
<!--Author            : kate
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HOOACTD
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		03-02-2014	KATE		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function tdschdet_post_ONLOAD()
	{
		
	if(mopId == "HOAACTD")
		{
		var radioButtons = document.getElementsByName('xferInd');
		radioButtons[0].disabled= true;
        radioButtons[1].disabled = true;
		document.forms[0].operAcct.disabled = true;
		 hideImage("sLnk3");
		 }
        
 
	}



</script>

