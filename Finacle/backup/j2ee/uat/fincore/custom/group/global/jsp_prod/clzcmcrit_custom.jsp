<!---------------------------------------------------------------------------------------------------------------->
<!--    Name              :   clzcmcrit_custom.jsp
<!--    Description       :   User Work Class validation for Verify and add functions
<!--    Date              :   16-02-2013
<!--    Author            :   Manoj
<!--    Called By         :   None
<!--    Calling jsp       :   clzcmmn001.scr
<!--    Menu Option       :   HCLZCM
<!--    Modification History:
<!--    Sl No.             Date           Author             Description
<!--   ---------       ----------    ----------------    --------------------
<!--   0.1            	16-02-2013    	 Manoj            Original Version
<!---------------------------------------------------------------------------------------------------------------->

<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<%@ include file="../commonInclude.jsp" %>

<script type = "text/javascript">
function clzcmcrit_pre_ONCLICK(btn){
	if(btn.id == "Accept" && mopId == "HCLZCM"){
		<%-- Function code from HCLZCM menu--%>
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
