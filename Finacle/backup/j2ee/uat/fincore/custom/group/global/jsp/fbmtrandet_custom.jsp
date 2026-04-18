<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : fbmtrandet_custom.jsp 
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 14-08-2013
<!--Author              : jane
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : MEOB
<!--Modification History:
<!--    Version No.           Date                 Author                Description
<!--    ---------           ----------            ----------          -----------------
<!--     0.1                22-08-2013             jane              Original version          
<!---------------------------------------------------------------------------------------------------------------->
<script>
function fbmtrandet_post_ONLOAD(obj)

		{
	   if (mopId=="MEOB")
			{
		   
				var dco=document.forms[0].acctId.value;
				var input      = "dco|"+dco;
				var outputNames    = "output|outVal";
				var scrName     =   "b_acctsbgrp.scr";
				var retVal = appFnExecuteScript(input,outputNames,scrName,false);
				var retBuff = retVal.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var a = value;
				//alert(a);
				if (a=="FBA")
					{
					document.forms[0].rptCode.value="BP"
					}

			 } 
		}


	

</script>

