<script language="javascript" src="../../javascripts/common_functions.js" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<script language="javascript" src="../Renderer/custom/javascripts/ictmdet_cust.js" ></script>
<script type="text/javascript">
function post_ONLOAD() 
{
	if (profileId=="11")
	{
		alert(document.forms[0].acctId.value);
		if (document.forms[0].acctId.value!="")
		{
			var acctNumber = document.forms[0].acctId.value;
        
			// Checking Document Expiry date --- Anderson
        		var inputNameValues = "foracid|"+acctNumber;
        		var outputNames     = "msgFlg";
        		var scrName         = "checkDocExpDate.scr";
       			var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        		var ret1 = retVal.split("|");
			alert(ret1[1]);
        		// End Checking Document Expiry date --- Anderson	


		}
	}
}
</script>