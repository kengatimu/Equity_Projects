<!---------------------------------------------------------------------------------------------------------------->
<!--    Name              :   ratelistcrit_custom.jsp
<!--    Description       :   User Work Class validation for Verify and add functions
<!--    Date              :   16-02-2013
<!--    Author            :   Manoj
<!--    Called By         :   None
<!--    Calling jsp       :   fbillvalmn001.scr
<!--    Menu Option       :   HMNTRTLM
<!--    Modification History:
<!--    Sl No.             Date           Author             Description
<!--   ---------       ----------    ----------------    --------------------
<!--   0.1            	16-02-2013    	 Manoj            Original Version
<!---------------------------------------------------------------------------------------------------------------->

<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<%@ include file="../commonInclude.jsp" %>

<custom:getRepository/>
<%
	String sProcRequestRet = null;
	String sFirstAccess    = (String)ARJspRep.getVal("IsFirstAccess");
	if (sFirstAccess == null)
	{
				ARJspRep.setVal("IsFirstAccess", "NO");
	}

	FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
	if(null == securityInfo)
	{
		securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
	}

	String sBODDate = (String)((securityInfo.bodDate).substring(0,10));
	String homeSol	= (String)((securityInfo.homeSolId));
	String homeCcy	= (String)((securityInfo.homeCrncyCode));
	String workClass  = (String)((securityInfo.userWorkClass));
%>

<script type = "text/javascript">
function ratelistcrit_pre_ONCLICK(btn){
	if(btn.id != "Clear" && mopId == "HMNTRTLM"){
		var userWrkCls = '<%=workClass%>';
		<%-- Function code from HMNTRTLM menu--%>
	
		var funcCod = document.forms[0].funcCode.value;
		var wclass = userWrkCls
		<%-- Common initialization for appFnExecuteScript --%>
		var inputNameValues = "userWrkCls" + "|" + wclass + "|" + "funcCode" + "|" + funcCod;
		var outputNames = "paramV";
		var scrName = "fbillvalmn001.scr";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		if(ret[0] == "Error") {
			alert(ret[1]);
			return false;
		}
		if(ret[1] == "Y") {
			alert("Insufficent Workclass to verify.");
			//return false;	
		}
		else if(ret[1] == "W")  {
			alert("Manual Addational of Rates is not allowed Use the Uploader.");	
			 //return false;	
		}
		else{
			return true;
		}
	}
	else{
		return true;
	}
}
</script>
