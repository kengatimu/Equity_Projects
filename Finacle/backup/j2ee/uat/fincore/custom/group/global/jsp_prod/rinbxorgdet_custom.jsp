<!--------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<!--Name                : rinbxorgdet_custom.jsp
<!--Description         : to disable the withdraw buttons for approved('C'-completed status- referals for TOL - 367967
<!--Date						 : 11-07-2013 
<!--Author					  :  Vijaya V
<!--Called By			  : None
<!--Calling jsp				 : None
<!--Menu Option         : HRINBX
<!--Modification History:
<!--    Version No.           Date                       Author             Description
<!--    -------				  ----------                 -----------        ------------------
<!--     0.1				  20-08-2013				Vijaya V			Original version
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<script>

function post_ONLOAD()
{
	if(refId != "" )
	{
		var inputNameValues = "refId" + "|" +refId ;
		var scrName = "referralmn001.scr";
		var outputNames = "paramV1";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");

		document.getElementById("referralFetch").disabled = false; 

		// referral in approval status, hence WITHDRAW  , WITHDRAWAL AND MODIFY buttons are disabled.
		if(ret[1] == "C")
		{
			document.getElementById("WITHDRAW").disabled = true; 
			document.getElementById("referralFetch").disabled = true; 
		}
	}
}

// Added by Revathi for handling bio validation if the tran comes from HRINBX
function rinbxorgdet_pre_ONCLICK(obj)
{
        if(obj.id == "referralFetch")
        {
                //alert("We are going to withdraw and modify the transaction");
                setSValue("isParentRINBX|"+"Y");
				return true;
        }
}
// Revathi - Changes end

</script>
