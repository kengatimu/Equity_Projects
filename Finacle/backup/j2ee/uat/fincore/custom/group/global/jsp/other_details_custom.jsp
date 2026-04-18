<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : other_details_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.This is used to pass the values
<!--Date                : **-**-2025
<!--Author              : 
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HOAACCA/SB, HACM Etc
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1			**/**/2025			 CM - EMT	      Remove special characters and format amt to DRC formats(,)
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript">

	function other_details_pre_ONLOAD(obj) 
	{
		if (profileId == 43) 
		{
			var forms = document.forms;
			var fields = ['srcFeeChrgAmt', 'srcFeeSysCalcAmt', 'subvPdChrgAmt', 'subvPdSysCalcAmt', 'subvRcdChrgAmt', 'subvRcdSysCalcAmt', 'dlrContrChrgAmt', 'dlrContrSysCalcAmt'];
			for (var i = 0; i < fields.length; i++) 
			{
				var fieldName = fields[i];
				var field = forms[0][fieldName];
				if (field) 
				{
					var val = field.value;
					// Replace &#44; with comma if it exists
					val = val.replace(/&#44;/g, ",");
					field.value = val;
				}
			}
		}
	}

</script>