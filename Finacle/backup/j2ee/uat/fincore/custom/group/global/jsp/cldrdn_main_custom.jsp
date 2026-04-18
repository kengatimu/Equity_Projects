<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : cldrdn_main_custom.jsp 
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 06-08-2013
<!--Author              : jane
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : HCLDRDN
<!--Modification History:
<!--    Version No.           Date                 Author                Description
<!--    ---------           ----------            ----------          -----------------
<!--     0.1                06-08-2013             jane              Original version          
<!---------------------------------------------------------------------------------------------------------------->


<script>
function cldrdn_main_pre_ONCLICK(obj)

		{
	   if (mopId=="HCLDRDN")
			{
		   if (funCode == "D" )
				{
				   if (obj.id=="accept")
				   {
					  var loan=document.forms[0].acctNum.value;


					  if(document.forms[0].customData.value == "")
							{
							document.forms[0].customData.value = loan;
						//alert(document.forms[0].customData.value);
							}
				   }

				}
		  
			}

		}

</script>
