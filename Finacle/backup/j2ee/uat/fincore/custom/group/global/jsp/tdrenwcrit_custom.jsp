<%--
<%@include file="formatAcct.jsp" %>
--%>
<%
	String acctLabel = "A/c. ID";
	String acctIdStr = "acctId";
	String solIdStr = "";
%>
<%@ include file="custsvswindow.jsp" %>

<script type="text/javascript">
//overidding the system function to include the customization
function fnFetchAcctSchm()
{
    clearDescField("schmDesc","acctIdCrncy","acctSol","acctName","schmCode");
    if (!fnIsNull(objForm.acctId.value))
    {
	var inputNameValues = "acctNum|"+objForm.acctId.value;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" )
        {
                alert(ret1[1]);
        }
    	doSubmit("FetchAcctSchmDtls");
	return true;
    }
}
</script>
