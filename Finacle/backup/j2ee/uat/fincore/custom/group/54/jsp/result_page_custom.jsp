<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : result_page_custom.jsp 
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 11-03-2013
<!--Author              : Chandrasekhar
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : HOAACVSB
<!--Modification History:
<!--    Version No.          Date                Author             Description
<!--    ---------          ----------           ---------          -----------------
<!--     0.1               18-05-2013            Chandrasekhar            Original version
<!---------------------------------------------------------------------------------------------------------------->

<script type="text/javascript">
function pre_ONLOAD(){
	if(mopId == "HOAACVSB"){
		var custVal = document.forms[0].customData.value;
		var ret = custVal.split("|");
		var acctNum = ret[1];
		var funcCode = ret[2];

		var inputNameValues = "acctNum"+"|"+acctNum+"|"+"funcCode"+"|"+funcCode;
		var outputNames     = "";
		var scrName         = "acctopnvalmn009.scr";
		var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		if(ret[0] == "Error")
		{
			alert(ret[1]);
			return false;
		}
		if(ret[1] == "Z")
		{
			alert("A Database error has occured. Please contact your DBA.");
			return false;
		}
		if(ret[0] == "MSG")
		{
				alert(ret[1]);
			return true;
		}
				
	}
}

</script>
