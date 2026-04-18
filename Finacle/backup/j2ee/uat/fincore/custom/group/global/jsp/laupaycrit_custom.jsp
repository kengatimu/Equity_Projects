<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : laupaycrit_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 25-06-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HLAUPAY
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		25-06-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function laupaycrit_post_ONLOAD()
{
if(mopId == "HLAUPAY")
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

function laupaycrit_pre_ONCLICK()
{
	if(profileId == 54)
	{
		if(mopId == "HLAUPAY")
		{
			var inputNameValues       = "mopId|"+mopId;
                        var outputNames           = "workClass";
                        var scrName               = "HLA_HLS_val_wokclass.scr";
                        var isAutoPopulationRqrd  = false;
                        var retVal = appFnExecuteScript(inputNameValues,outputNames,scrName,isAutoPopulationRqrd);	

			temp = retVal.split("|");
			if(temp[1] != "310")
			{
				if(document.forms[0].pymtType.value == "R")
				{
					#alert("Reversal is not allowed for Kenya");
					#return false;
				}
			}
		}
	}
}
</script>

