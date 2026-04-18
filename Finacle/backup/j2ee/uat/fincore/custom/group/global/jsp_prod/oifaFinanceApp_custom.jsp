<!--------------------------------------------------------------------------------------------------------------->
<!--Name                : oifaFinanceApp_custom.jsp
<!--Description         : This is used to pass assetValue to ContractDtlsIst_custom.jsp -(costOfConstruction).
<!--Date                : 08-08-2013 
<!--Author              : Kim
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : 
<!--Modification History:
<!--    Version No.         Date                       Author             Description
<!--    -------             ----------                 -----------        ------------------
<!--    0.1                 08-08-2013                 Kim                Original version
<!--    0.2                 23-08-2013                 jane               Modified version
<!---------------------------------------------------------------------------------------------------------------->

<script>

function pre_ONLOAD(obj)
{
	getFieldsFromCustomData("schmCode");
}
	
function oifaFinanceApp_pre_ONCLICK(obj)
	{
		setFieldsToCustomData("schmCode","assetValue");
		
	}

function oifaFinanceApp_pre_TAB_SWITCH(obj)
	{
		setFieldsToCustomData("schmCode","assetValue");
		
	}



</script>


