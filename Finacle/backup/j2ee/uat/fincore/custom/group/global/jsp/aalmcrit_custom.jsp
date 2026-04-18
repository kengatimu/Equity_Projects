<!--------------------------------------------------------------------------------------------------------------->
<!--description         : Memo pad.
<!--Date                : 15-05-2013
<!--Author              : Prakash
<!--Called By           : None
<!--Calling  Jsp        : None
<!--Menu Option         : HAALI
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------           -----------        ------------------
<!--     0.1            22-05-2013           Prakash           Original version
<!---------------------------------------------------------------------------------------------------------------->
<%@include file="formatAcct.jsp" %>
<script language="javascript">
function showAccountID(funCode)
{
	if(funCode.value  == 'V' || funCode.value  == 'X')
        {
                var funCode = funCode.value;
                showVerfyPendList("GAM",funCode,"M","","","F",document.forms[0].accId,"","");
        }
        else
        {
                showAccountIdList(
                document.forms[0].accId,document.forms[0].solId,document.forms[0].accShortName,'F',document.forms[0].ccy);
        }
		memoPad();
}


function memoPad(){
	var acctNumber = document.forms[0].accId.value ;
	var inputNameValues = "acctNum|"+acctNumber;
	var outputNames     = "";
	var scrName         = "formatacctdp001.scr";
	var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var ret1 = retVal.split("|");
	if(ret1[0] == "MSG" ){
		alert(ret1[1]);
	}
}
</script>
