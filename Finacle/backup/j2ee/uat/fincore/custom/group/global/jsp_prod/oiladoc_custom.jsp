<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : oiladoc_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              :27-06-2013
<!--Author            : cate
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : OISA/OICA
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		27-06-2013	CATE		Original version
<!---------------------------------------------------------------------------------------------------------------->


<script>
function oiladoc_post_ONLOAD(obj)
{
	if(mopId == "OISA" ||  mopId == "OICA" )
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
