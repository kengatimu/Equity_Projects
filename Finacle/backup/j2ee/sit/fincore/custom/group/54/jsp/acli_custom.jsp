<script type="text/javascript">

function post_ONLOAD(obj) 
{

	alert(document.forms[0].acctNum.value);
	if (document.forms[0].acctNum.value!="")
	{
		alert("Anderson");
		var acctNumber = document.forms[0].acctNum.value;
        
	// Checking Document Expiry date --- Anderson
        	var inputNameValues = "foracid|"+acctNumber;
        	var outputNames     = "msgFlg";
        	var scrName         = "checkDocExpDate.scr";
       		var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        	var ret1 = retVal.split("|");
        	alert(ret1[1]);

	// End of Document Expiry date checker --- Anderson


	}

}

</script>


<!------------end of  TO/CR no : 348467---------------------------->

