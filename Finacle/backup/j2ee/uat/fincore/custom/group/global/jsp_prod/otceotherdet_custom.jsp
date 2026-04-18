<!--------------------------------------------------------------------------------------------------------------->
<!--Name                : otceotherdet_custom.jsp
<!--Description         : This is used to mandatorize free text 1 otceotherdet_custom.jsp.
<!--Date                : 05-12-2013 
<!--Author              : jane
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HOTCE
<!--Modification History:
<!--    Version No.         Date                       Author             Description
<!--    -------             ----------                 -----------        ------------------
<!--    0.1                 05-12-2013                 jane                Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>

function otceotherdet_pre_ONCLICK(obj)
{
	//alert(profileId);
	if (profileId=="50")
	{
		if (obj.id=="Submit")
		{
		if (document.forms[0].freeText1.value=="")
			{
			alert("Enter Remmitance Information In Free text 1");
                document.forms[0].freeText1.focus();
                return false;
			}
		
		}
	}
	

}

</script>
