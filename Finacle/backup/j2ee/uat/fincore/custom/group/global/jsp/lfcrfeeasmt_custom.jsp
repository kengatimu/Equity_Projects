<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : lfcrfeeasmt_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 20-05-2013
<!--Author            : charles
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HSAC
<!--Modification History:
<!--    Version No.     Date            Author          Description
<!--    -----------     ------          ----------      ---------------------------
<!--    0.1             20-05-2013      Nithin          Original version
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">
function lfcrfeeasmt_ONLOAD3(c) {
    var b = "";
	if(profileId == "54")
	{
		if(mopId == "HPAYOFF")
		{
			disableFields("checkFlg");
		}
	}

    var a = document.forms[0];
    if (pre_ONLOAD("lfcrfeeasmt", c) == false) {
        return false;
    }
    if (preEventCallForLocale("lfcrfeeasmt", c, "ONLOAD") == false) {
        return false;
    }
    if ((b = setDefaults()) == false) {
        return false;
    }
    if (postEventCallForLocale("lfcrfeeasmt", c, "ONLOAD") == false) {
        return false;
    }
    fnPopUpExceptionWindow(a.actionCode);
    if (post_ONLOAD("lfcrfeeasmt", c) == false) {
        return false;
    }
    return (b == undefined) ? true : b;
}

</script>
