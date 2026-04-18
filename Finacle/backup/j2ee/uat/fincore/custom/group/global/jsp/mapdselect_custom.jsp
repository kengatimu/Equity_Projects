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
function mapdselect_post_ONLOAD(obj)
{
        if (mopId=="HMAPD")
        {
                
                        alert("HMAPD");
						//document.forms[0].limLvlIntFlg.value="Y";
                        var radioButtons = document.getElementsByName('intCollFlg');
						radioButtons[0].checked = false;
						radioButtons[1].checked = false;
						radioButtons[2].checked = true;
						radioButtons[0].disabled = true;
						radioButtons[1].disabled = true;
                        document.forms[0].intCollFlg.Disabled=true;
                
        }
}

</script>

