<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : clcrit_custom.jsp
<!--Description         : This is used provide signature option for account ID.
<!--Date                : 05-06-2013
<!--Author              : Prashanth
<!--Called By           : None
<!--Calling  Jsp        : custsvswindow.jsp
<!--Menu Option         : HACLHM 
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------           -----------        ------------------
<!--     0.1            05-06-2013           Saurabh Sinha          Original version
<!--     0.2            24-07-2013           SABY                   TO-362862
<!---------------------------------------------------------------------------------------------------------------->
<%
	String acctLabel = "A/c. ID";
	String acctIdStr = "acctId";
	String solIdStr = "solId";
	//String sProfileId 	= ProfilesManager.getProfileInSession(session);
%>
<%@ include file="custsvswindow.jsp" %>
<script type="text/javascript">

/*function post_ONLOAD() {
if(mopId == 'HALHI') {
document.forms[0].funcCode.selectedIndex = 1;
//document.forms[0].funcCode.disabled= true;
}
}

/*function fnProtectFuncCode()
{
        var tmpOperation = getRadioValue(objForm.operation);
	if(tmpOperation == "S" && menuType != 'I' && mopId != 'HALHI') {
                fnAppendOption(objForm.funcCode, OPTION_DELETE_DESC, OPTION_DELETE_VALUE);
                fnAppendOption(objForm.funcCode, OPTION_WITHDRAW_DESC, OPTION_WITHDRAW_VALUE);
        }
}
*/

	//Edwin start
function aclcrit_pre_ONCLICK(obj)
{	
	if (profileId =="56")
	{
		//alert(profileId);
		if (document.forms[0].acctId.value !="") 
		{	
			var acctId = document.forms[0].acctId.value;
			var inputNameValues =  "acctId|"+ acctId;
			var outputNames     = "";
			var scrName         = "CrmCoreInterfaceCheck.scr";
			var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			if(a == "N")
			{
				alert("Financial Card Number Not Maintained on CIF");
				return false;
			}
			if (a == "M")
			{
				alert("Acct Manager Not Maintained for the account");
				return false;
			}
		}	
	}

	setFieldsToCustomData("acctNo");
}
	
	////edwin end
</script>
