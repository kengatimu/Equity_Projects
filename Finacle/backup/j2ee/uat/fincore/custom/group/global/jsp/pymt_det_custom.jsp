<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : pymt_det_custom.jsp 
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 11-03-2013
<!--Author              : Chandrasekhar
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : HSIM
<!--Modification History:
<!--    Version No.          Date                Author             Description
<!--    ---------          ----------           ---------          -----------------
<!--     0.1               11-03-2013            Chandrasekhar            Original version
<!---------------------------------------------------------------------------------------------------------------->
<script type ="text/javascript">

function pymt_det_ONBLUR()
{
	var remitValue = document.forms[0].customData.value;
	var remit = document.getElementById('remitMode').value;
	var ret = remitValue.split("|");
	var funcCode = ret[1];
	var crncyCode = ret[3];
	var crncy = crncyCode.toUpperCase();		

	if(funcCode == 'A' && remit == 'B' && document.forms[0].acctId.value == "")
	{
		var inputNameValues = "currency"+"|"+crncy;
		var outputNames     = "";
		var scrName         = "siacctpopulate.scr";
		var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		if(ret[0] == "errMsg")
		{
			alert(ret[1]);
			return false;
		}
		if(ret[0] == "forAcid" && document.forms[0].acctId.value == "")
		{
			forAcid = ret[1];
			document.forms[0].acctId.value = forAcid;	
		}	
	}
}	
function pymt_det_ONCHANGE()
{
	var remitValue = document.forms[0].customData.value;
	var remit = document.getElementById('remitMode').value;
	var ret = remitValue.split("|");
	var funcCode = ret[1];
	var crncyCode = ret[3];
	var crncy = crncyCode.toUpperCase();
	
	if(funcCode == 'A' && remit == 'B' && document.forms[0].acctId.value == "")
	{
		var inputNameValues = "currency"+"|"+crncy;
		var outputNames     = "";
		var scrName         = "siacctpopulate.scr";
		var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		if(ret[0] == "errMsg")
		{
			alert(ret[1]);
			return false;
		}
		if(ret[0] == "forAcid" && document.forms[0].acctId.value == "")
		{
			forAcid = ret[1];
			document.forms[0].acctId.value = forAcid;	
		}
	}
}
</script>


