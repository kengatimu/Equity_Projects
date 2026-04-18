<!---------------------------------------------------------------------------------------------------------------->
<!--    Name              :  miclzcrit_custom.jsp
<!--    Description       :   This jsp checks whether the sol_id is related to main branch or not.If not this 
<!--						  will popup a message that Cannot be operated from Branch...Contact H/O Clearing.  
<!--	                      This file should reside in finbranch/custom/jsp folder.
<!--    Date              :   17-01-2012
<!--    Author            :   Chandrasekhar 
<!--    Called By         :   None
<!--    Calling jsp       :   None
<!--    Menu Option       :   HMICZ.
<!--    Modification History:
<!--    Sl No.             Date        		   Author               Description
<!--   ---------         ----------      ---------------------    --------------------
<!--     0.1            <17-01-2012>      Chandrasekhar				Original Version 
<!---------------------------------------------------------------------------------------------------------------->

<%--    Including  the common file for every custom JSP programs --%>
<script type = "text/javascript">
function miclzcrit_pre_ONCLICK(btnId){
	if(btnId.id != "Clear") {
	
	<%-- Zone code from micz menu--%>
	var zone = document.forms[0].zoneCode.value.toUpperCase();
	
	<%-- Common initialization for appFnExecuteScript --%>
	var inputNameValues = "zoneCode" + "|" + zone;
	var outputNames = "paramV";
	var scrName = "clgznoprtnmn004.scr";
	var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var ret = retVal.split("|");
	var yesOrNo = ret[1];

	if(yesOrNo == "Y"){
		alert("Cannot be operated from Branch...Contact H/O Clearing");
		return false;
	}
	else if(yesOrNo == "X"){
		alert("Set up not done for cparam value");
		return false;
	}
}
return true;
}
</script>
