<%--
<%@include file="formatAcct.jsp" %>
--%>


<script type="text/javascript">
//overidding system function to add the customization
function fnLocFetchAcctDtls()
{
        var ret;
        clearDescField("acctCrncy", "acctSol", "acctName", "schmCode", "schmCodeDesc");
    if (!fnIsNull(objForm.acctId.value))
                ret = sendDataToServer('myframe', 'ACCTSCHM', 'F', 'acctId', 'acctCrncy|acctSol|acctName|schmCode|schmCodeDesc');
    if(ret == false) {
                objForm.acctId.value = "";
        objForm.acctId.focus();
        objForm.acctId.select();
        return false;
    }
	var inputNameValues = "acctNum|"+objForm.acctId.value;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" )
        {
                alert(ret1[1]);
        }
}
</script>
