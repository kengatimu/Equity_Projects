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
// overridding the system function for adding customization
function fnProcessAcctDtls(acctIdFldObj) {
        if(isEmptyObjValue(acctIdFldObj.value)) {
                clearDescField('acctCrncy','acctSolId','acctName','wthDrwlAmtCrncy','wthDrwlAmt');
                fnClearDateFields(objForm.clsValDate);
                return;
        }

	var inputNameValues = "acctNum|"+acctIdFldObj.value;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" )
        {
        	alert(ret1[1]);
        }
        doSubmit("GetAcctDtls");
}

function caactdcrit_pre_ONCLICK(obj)
{
		
		if ((profileId == 54) && (mopId == "HCAACTD")) {
        if (obj.id == "Accept") {
            var dco = headUserId;
            var input = "dco|" + dco;
            var outputNames = "paramV1";
            var scrName = "b_roleidvalidate.scr";
            var retVal = appFnExecuteScript(input, outputNames, scrName, false);
            var ret = retVal.split("|");
            if (ret[1] == "PASS") {
                return true;
            }
			else 
				if (ret[1] == "FAIL") {
                alert("Role id Not Allowed");
                return false;
            }
        }
	}

}
</script>
