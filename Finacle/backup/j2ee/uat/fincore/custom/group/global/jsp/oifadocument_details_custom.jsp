<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : oifadocument_details_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              :27-06-2013
<!--Author            : cate
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : OIFA
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		27-06-2013	CATE		Original version
<!---------------------------------------------------------------------------------------------------------------->


<script>
function oifadocument_details_post_ONLOAD(obj)
{
	if(mopId == "OIFA")
	{
if( document.forms[0].docRemarks.value == "" )
	{
		alert("Enter a value in the field ");
		document.forms[0].docRemarks.focus();
		return false;
	   }
	 } 
}
</script>
