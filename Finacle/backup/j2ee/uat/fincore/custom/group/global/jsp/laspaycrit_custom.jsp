<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : laspaycrit_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 25-06-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HLASPAY
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		25-06-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function laspaycrit_post_ONLOAD()
	{
	if(mopId == "HLASPAY")
		{
		var radioButtons = document.getElementsByName('tranType');
		radioButtons[0].checked = false;
        radioButtons[1].checked = true;
		}
        {
		var radioButtons = document.getElementsByName('drFrmAcct');
		radioButtons[1].checked = false;
        radioButtons[0].checked = true;
		}
 
	}

function laspaycrit_pre_ONCLICK()
{
        if(profileId == 54)
        {
                if(mopId == "HLASPAY")
                {
			if(document.forms[0].pymtType.value == "R")
                        {
                                var inputNameValues       = "mopId|"+mopId;
                                var outputNames           = "workClass";
                                var scrName               = "HLA_HLS_val_wokclass.scr";
                                var isAutoPopulationRqrd  = false;
                                var retVal = appFnExecuteScript(inputNameValues,outputNames,scrName,isAutoPopulationRqrd);


                                temp = retVal.split("|");

                                if(temp[1] != "310")
                                {
                                        #alert("Reversal is not allowed for Kenya");
                                        #return false;
                                }
                        }
                }
        }
}



</script>


