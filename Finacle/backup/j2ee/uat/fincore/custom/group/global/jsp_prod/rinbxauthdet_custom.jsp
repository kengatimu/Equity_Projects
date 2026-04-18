<!--------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<!--Name                : rinbxauthdet_custom.jsp
<!--Description         : To perform biometric validation 
<!--Date			 	: 07-01-2014 
<!--Author				: Venki 
<!--Called By			: None
<!--Calling jsp			: None
<!--Menu Option         : HRINBX
<!--Modification History:
<!--    Version No.           Date                       Author             Description
<!--    -------				  ----------                 -----------        ------------------
<!--	1.0					  07-01-2014				 Venki					
<!--------------------------------------------------------------------------------------------------------------------------------------------------------------------->

<script>
function rinbxauthdet_pre_ONCLICK(obj)
{
	if(obj.id == "AUTH_ACTION")
	{
		if(obj.name == "Approve")
		{
			return  doLocalBioMetricVal();
		}
	}
}

function doLocalBioMetricVal()
{
	var retVal4Menu = "";
	retVal4Menu = isBioValReq4Menu(mopId);
	if(retVal4Menu == true)
	{
		return getFieldforBioAndCallBio(mopId);
	}
	return true;
}
</script>
