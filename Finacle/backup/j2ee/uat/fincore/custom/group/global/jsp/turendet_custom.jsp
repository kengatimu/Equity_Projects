<!---------------------------------------------------------------------------------------------------------------->
<!--Name              :turendet_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 15-12-2016
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HOAACTD
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		15-12-2016	jane		Original version
<!--	0.2		**-**-2025	C.M		
<!---------------------------------------------------------------------------------------------------------------->
<script>

	function turendet_pre_ONCLICK(obj)
	{
		if((mopId == "HOAACTD") || (mopId == "HOAACTU") || (mopId == "HOAACMTD") || (mopId == "HOAACMTU") || (mopId == "HOAACVTD") || (mopId == "HOAACVTU") || (mopId == "HACMTD") || (mopId == "HACMTU")) 
		{
			if ((obj.id == "Submit") || (obj.id == "Validate"))
			{
				if (profileId == 43)
				{
					var autoClosureFlg_radioButtons = document.getElementsByName('autoClosureFlg');
					var autoClosureFlg_selectedValue = null;
					for (var i = 0; i < autoClosureFlg_radioButtons.length; i++) {
						if (autoClosureFlg_radioButtons[i].checked) {
							autoClosureFlg_selectedValue = autoClosureFlg_radioButtons[i].value;
							break;
						}
					}
					
					var autoRenewFlg_radioButtons = document.getElementsByName('autoRenewFlg');
					var autoRenewFlg_selectedValue = null;
					for (var i = 0; i < autoRenewFlg_radioButtons.length; i++) {
						if (autoRenewFlg_radioButtons[i].checked) {
							autoRenewFlg_selectedValue = autoRenewFlg_radioButtons[i].value;
							break;
						}
					}
					
					if((autoClosureFlg_selectedValue == "N") && (autoRenewFlg_selectedValue == "N"))
					{
						alert("Both Auto-Closure and Auto-Renewal cannot be NO !!");
						return false;
					}
				}
			}
		}
	}
	
	function turendet_pre_TAB_SWITCH()
	{
		if((mopId == "HOAACTD") || (mopId == "HOAACTU") || (mopId == "HOAACMTD") || (mopId == "HOAACMTU") || (mopId == "HOAACVTD") || (mopId == "HOAACVTU") || (mopId == "HACMTD") || (mopId == "HACMTU")) 
		{
			if (profileId == 43)
			{
				var autoClosureFlg_radioButtons = document.getElementsByName('autoClosureFlg');
				var autoClosureFlg_selectedValue = null;
				for (var i = 0; i < autoClosureFlg_radioButtons.length; i++) {
					if (autoClosureFlg_radioButtons[i].checked) {
						autoClosureFlg_selectedValue = autoClosureFlg_radioButtons[i].value;
						break;
					}
				}
				
				var autoRenewFlg_radioButtons = document.getElementsByName('autoRenewFlg');
				var autoRenewFlg_selectedValue = null;
				for (var i = 0; i < autoRenewFlg_radioButtons.length; i++) {
					if (autoRenewFlg_radioButtons[i].checked) {
						autoRenewFlg_selectedValue = autoRenewFlg_radioButtons[i].value;
						break;
					}
				}
				
				if((autoClosureFlg_selectedValue == "N") && (autoRenewFlg_selectedValue == "N"))
				{
					alert("Both Auto-Closure and Auto-Renewal cannot be no !!");
					return false;
				}
			}
		}
	}

</script>
