<%-- Generated from spec file --%>

<%
	String sGrpName = ARJspCurr.getCurrentGroup(); 
	String sPopUpExceptionWindow = (String)ARJspCurr.getInput(sGrpName+".PopUpExceptionWindow" ,"false");
	String sReferralMode = (String)ARJspCurr.getInput("refSubMode" ,"");
	ARJspCurr.setInput(sGrpName+".PopUpExceptionWindow","false");
%>
<script>

	var bEnableVal = <%=ParseValue.checkString(bEnableVal)%>;
	var sPopUpExceptionWindow = '<%=ParseValue.checkString(sPopUpExceptionWindow)%>' ;
	var sReferralMode = '<%=ParseValue.checkString(sReferralMode)%>' ;

</script>
