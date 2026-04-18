<!-------------------------------------------------------------------------------------------------------------------------------------------->
<!--Name                : igmgrnteedtl1_custom.jsp
<!--Description         : This is used to make details of guarantee field as mandatory TOL - 362602
<!--Date                : 25-07-2013
<!--Author              : Priyanka
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : IGM
<!--Modification History:
<!--    Version No.           Date                       Author             Description
<!--    -------              ----------                 -----------        ------------------
<!--     0.1                 25-07-2013                  Priyanka          Original version - TO - 362602
<!--------------------------------------------------------------------------------------------------------------------------------------------->

<script type="text/javascript">

function igmgrnteedtl1_pre_ONCLICK(obj)
{
	if (obj.id == "Submit" || obj.id == "Validate" || obj.id == "NextPage")
        {
		var retVal = ""
                if ((retVal =  valMandatoryFields()) == false) {
                            return false;
                }
	}
}	

function igmgrnteedtl1_pre_TAB_SWITCH()
{
	var retVal = ""
        if ((retVal =  valMandatoryFields()) == false) {
                    return false;
        }
}

function valMandatoryFields()
{
	var ObjForm = document.forms[0];
        if(fnIsNull(ObjForm.purpOfGrntee.value))
        {
                alert("Enter the Purpose of Guarantee.");
                ObjForm.purpOfGrntee.focus();
                return false;
        }

}


</script>



