
<script type= "text/javascript">
function fnCommonFetchAcctDtls(acctObj, acctName, acctSol, acctCrncy, isError, fType)
{
    var acctNumber = acctObj.id;
    wReturnDesc = acctCrncy + '|'+ acctSol +'|'+ acctName + '|' + acctNumber;
    /*Appended account number to description string at last, note that this is
    * not a description field and will be return changed value if
    * formatAccount.scr is implemented */
    ret = fnLowCommonFetchAcctDtls(acctObj, wReturnDesc, isError, fType);
    if(ret == false) {
    	return (ret);
    } else {
        var inputNameValues = "acctNum|"+acctObj.value;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" )
        {
                alert(ret1[1]);
        }
        return(ret);
   }
}
</script>
