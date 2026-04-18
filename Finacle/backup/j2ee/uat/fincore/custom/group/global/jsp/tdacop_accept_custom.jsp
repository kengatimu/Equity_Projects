<!---------------------------------------------------------------------------------------------------------------->
<!--Name              :tdacop_accept_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 22-06-2018
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HOAACTD
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		22-06-2018	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>


	function tdacop_accept_pre_ONCLICK(obj)
	{
		if ((profileId == 54) && (mopId == "HOAACTD"))
		{
			if (obj.id=="Accept")
			{
				var schmCode=document.forms[0].schmCode.value;
				//alert(schmCode);
				setFieldsToCustomData("schmCode");
			}

		}

		if ((profileId == 54) && ((mopId == "HOAACTD")||(mopId == "HOAACVTD"))) {
        if (obj.id == "Accept") {
            var dco = headUserId;
            var input = "dco|" + dco;
            var outputNames = "paramV1";
            var scrName = "b_roleidvalidate.scr";
            var retVal = appFnExecuteScript(input, outputNames, scrName, false);
            var ret = retVal.split("|");
            if (ret[1] == "PASS") {
                return true;
            }
			else 
				if (ret[1] == "FAIL") {
                alert("Role id Not Allowed");
                return false;
            }
        }
    }

	}

</script>


