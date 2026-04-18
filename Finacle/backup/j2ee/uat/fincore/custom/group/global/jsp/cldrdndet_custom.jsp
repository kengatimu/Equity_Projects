<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : aclslres_custom.jsp 
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 01-08-2013
<!--Author              : George
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : HCLDRDN
<!--Modification History:
<!--    Version No.           Date                 Author                Description
<!--    ---------           ----------            ----------          -----------------
<!--     0.1                29-07-2013             George              Original version          
<!---------------------------------------------------------------------------------------------------------------->


<script>
function cldrdndet_post_ONLOAD(obj)

		{
	   if (mopId=="HCLDRDN")
			{
		  //alert("isha kuwa ");
		  if (funCode == "D" )
				{
			var dco = document.forms[0].customData.value;
			//alert(dco);
			var input      = "dco|"+dco;
			var outputNames    = "output|outVal";
			var scrName     =   "b_clupayment.scr";
			var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			//alert(a);
			document.forms[0].creditAcctNum.value=a;

			document.forms[0].drawDownMode.value="T";
				}

			}

		}

</script>
