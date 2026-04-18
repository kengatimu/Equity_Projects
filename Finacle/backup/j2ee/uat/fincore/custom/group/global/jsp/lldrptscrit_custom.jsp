<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : lldrptscrit_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 29-07-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HLLDRPTS
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		29-07-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function lldrptscrit_post_ONLOAD()
{
	if(mopId == "HLLDRPTS")
	{
		document.forms[0].solSetId.value=headCtxSol;
	}

	}



</script>
