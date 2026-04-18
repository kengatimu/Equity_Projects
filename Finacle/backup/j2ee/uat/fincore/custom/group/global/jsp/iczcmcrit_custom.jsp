<!---------------------------------------------------------------------------------------------------------------->
<!--    Name              :   iczcmcrit_custom.jsp
<!--    Description       :   User Work Class validation for copy and add functions
<!--    Date              :   28-01-2012
<!--    Author            :   Shishira
<!--    Called By         :   None
<!--    Calling jsp       :   None
<!--    Menu Option       :   HICZCM.
<!--    Modification History:
<!--    Sl No.             Date           Author             Description
<!--   ---------         ----------      ----------------    --------------------
<!--   0.1            	<28-01-2012>     Shishira            Original Version
<!---------------------------------------------------------------------------------------------------------------->

<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<%@ include file="../commonInclude.jsp" %>

<script type = "text/javascript">
function iczcmcrit_pre_ONCLICK(btn){
	
	if(btn.id == "Submit" && mopId == "HICZCM"){
		<%-- Function code from HICZCM menu--%>
		var funcCod = document.forms[0].mode.value;
	
		<%-- Common initialization for appFnExecuteScript --%>
		var inputNameValues = "funcCode" + "|" + funcCod;
		var outputNames = "paramV";
		var scrName = "iczcmmn001.scr";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		if(ret[0] == "Error") {
			alert(ret[1]);
			return false;
		}
		else if(ret[0] == "Msg") {
			alert(ret[1]);
			return false;	
		}
		else{
			return true;
		}
	}
}
</script>
