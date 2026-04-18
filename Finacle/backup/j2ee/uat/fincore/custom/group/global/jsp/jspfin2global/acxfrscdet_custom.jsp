<%--
<%@include file="formatAcct.jsp" %>
--%>
<%
	String acctLabel = "A/c. ID";
	String acctIdStr = "xferAcctId";
	String solIdStr = "";
%>
<%@ include file="custsvswindow.jsp" %>
<script type="text/javascript">

function acxfrscdet_pre_ONCHANGE(obj)
{
	if(obj.id == "xferAcctId") {
	var inputNameValues = "acctNum|"+obj.value;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" )
        {
                alert(ret1[1]);
        }
	}
return true;
}

function fnShowAccountIdList(acctObj,solId,acctName,inPreceedence,acctCrncy)
{
        showAccountIdList(acctObj,solId,acctName,inPreceedence,acctCrncy);
        fnFetchAcctDtls();
	acxfrscdet_pre_ONCHANGE(acctObj);
}


function acxfrscdet_pre_ONCLICK(obj)
{
	if((obj.id=="Submit") || (obj.id=="Validate"))
		{

		if ((profileId !="43") && (profileId !="56"))
			{

			if ((document.forms[0].sourceSchm.value=="SB777") || (document.forms[0].sourceSchm.value=="VA300") || (document.forms[0].sourceSchm.value=="VA302") || (document.forms[0].sourceSchm.value=="CA207") || (document.forms[0].sourceSchm.value=="SB126"))
				{
						alert("ACCOUNT SCHEME TRANSFER NOT ALLOWED");
						document.forms[0].sourceSchm.focus();
						return false;
					
				}
			}

			if (document.forms[0].targetSchm.value=="SB190")
			{
				//alert(document.forms[0].xferAcctId.value);
				var acct = document.forms[0].xferAcctId.value;
				var input      = "acct|"+acct;
				var outputNames    = "output|outVal";
				var scrName     =   "staffac_check.scr";
				var retVal = appFnExecuteScript(input,outputNames,scrName,false);
				var retBuff = retVal.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var a = value;
				//alert(a);
				var retBuff = retVal.split("|");
				var output1 = retBuff[2];
				var value1 = retBuff[3];
				var b = value1;
				//alert(b);
				if (b>0)
				{
					alert("ACCOUNT EXIST WITH THAT SCHEME TRANSFER NOT ALLOWED");
					document.forms[0].targetSchm.focus();
					return false;
				}
			}
		}

}
</script>
