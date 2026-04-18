<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : mapdselect_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 03-03-2022
<!--Author              : Sos
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : HMAPD
<!--Modification History:
<!--    Version No.           Date                 Author                Description
<!--    ---------           ----------            ----------          -----------------
<!--     0.1                03-03-2022             Sos              Original version
<!-- <!---------------------------------------------------------------------------------------------------------------->
<script>
function mapddet_post_ONLOAD(obj)
{
        if (mopId=="HMAPD")
        {
                
                        alert("HMAPD");
						alert(document.forms[0].dintCollFlg.value);
                        //document.forms[0].limLvlIntFlg.value="Y";
                        document.forms[0].dintCollFlg.value="Y";
                        document.forms[0].dintCollFlg.disabled = true;
                
        }
}

</script>

