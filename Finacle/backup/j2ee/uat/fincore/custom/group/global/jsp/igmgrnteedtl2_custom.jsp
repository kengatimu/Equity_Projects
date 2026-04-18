<!-------------------------------------------------------------------------------------------------------------------------------------------->
<!--Name                : igmgrnteedtl2_custom.jsp
<!--Description         : This is used to make details of guarantee field as mandatory TOL - 362602
<!--Date                : 25-07-2013
<!--Author              : Priyanka
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : IGM
<!--Modification History:
<!--    Version No.           Date                       Author             Description
<!--    -------              ----------                 -----------        ------------------
<!--     0.1                 25-07-2013                  Priyanka          Original version
<!--     0.1                 19-08-2013                  Priyansh          Modified version TO: 367801 (Removed Validate from condition) 
<!--------------------------------------------------------------------------------------------------------------------------------------------->


<script type="text/javascript">

function igmgrnteedtl2_pre_ONCLICK(obj)
{
	if(funcCode == "A" || funcCode == "M")
	{
		if (obj.id == "Submit" || obj.id == "PrevPage")
        	{
			var retVal = ""
                	if ((retVal =  valMandatoryFields()) == false) {
                            	return false;
			}
                }
	}
}	

function igmgrnteedtl2_pre_TAB_SWITCH()
{
	if(funcCode == "A" || funcCode == "M")
        {

		var retVal = ""
        	if ((retVal =  valMandatoryFields()) == false) {
                    	return false;
		}
        }
}

function valMandatoryFields()
{
	var ObjForm = document.forms[0];
        if(fnIsNull(ObjForm.igmDtlsOfGrnt.value))
        {
                alert("Enter the Details of Guarantee.");
                return false;
        }

}


</script>



