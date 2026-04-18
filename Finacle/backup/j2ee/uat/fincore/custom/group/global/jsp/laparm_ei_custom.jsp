<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : laparm_ei_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 03-03-2022
<!--Author              : Sos
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : HOAACLA
<!--Modification History:
<!--    Version No.           Date                 Author                Description
<!--    ---------           ----------            ----------          -----------------
<!--     0.1                03-03-2022             Sos              Original version
<!-- <!---------------------------------------------------------------------------------------------------------------->
<script>
function laparm_ei_post_ONLOAD(obj)
{
        if (mopId=="HOAACLA")
        {
                
                        alert("HOAACLA");
						//document.forms[0].limLvlIntFlg.value="Y";
                        var radioButtons = document.getElementsByName('eiType');
						radioButtons[0].disabled = true;
						radioButtons[1].disabled = true;
						radioButtons[2].disabled = true;
                        
                
        }
}

</script>

