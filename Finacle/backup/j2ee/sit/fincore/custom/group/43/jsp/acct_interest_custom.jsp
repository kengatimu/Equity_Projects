<script language="javascript">
function acct_interest_ONCHANGE(obj)
{
	if(mopId =="HOAACCL" || mopId =="HOAACMCL")
	{
		if(obj.id =='acctPrefIntDr')
		{
			var ObjForm = document.forms[0];
			var prIntrst = ObjForm.acctPrefIntDr.value;
			var inputNameValues = "prIntrst|" + prIntrst;
			var outputNames = "errorFlg|errorMsg";
			var scriptName = "prfIntrstLimit.scr"
			var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
			var token = retVal.split("|");
			if( (token != null)) 
			{
			    var errorFlg = token[1];
			    var errorMsg = token[3];
			    if (errorFlg == "Y") 
			    {
				alert(errorMsg);
				ObjForm.acctPrefIntDr.value = "";
				setFieldFocus(ObjForm.acctPrefIntDr);
				return false;
			    } 
			    else 
			    {
				ObjForm.acctPrefIntDr.value = prIntrst;
			    }
			}
        	}
    	}
	return true;
}
</script>
