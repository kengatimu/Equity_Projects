<!--------------------------------------------------------------------------------------------------------------->
<!--Name                : mptdisbdet_custom.jsp
<!--Description         : This is used to protect some fields like sectCode,subSectCode,freeCode3 .
<!--Date                : 25-06-2013 
<!--Author              : GEORGE
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : 
<!--Modification History:
<!--    Version No.           Date                       Author                 Description
<!--    -------         ----------                       -----------        ------------------
<!--     0.1            25-06-2013                       GEORGE          Original version
<!---------------------------------------------------------------------------------------------------------------->


<script>

function mptdisbdet_post_ONLOAD(obj)

{
document.forms[0].
reportCodeOfPreShipAc.value="PC";
document.forms[0].
reportCodeOfPreShipAc.disabled=true;

}
function odcm_dc_details1_post_ONLOAD(obj)
                {
                document.forms[0].applicableRules.value="UCP";

                }

</script>


		
