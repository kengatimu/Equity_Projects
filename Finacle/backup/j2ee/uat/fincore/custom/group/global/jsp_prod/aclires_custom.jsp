<!----------------------------------------------------------------------------------------------------->
<!--Name                : aclires_custom.jsp
<!--Description         : Modified to show tod availed amount
<!--Date                : 08-10-2013
<!--Author              : Bharath Reddy B
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HACLINQ
<!--Modification History:
<!--    Version No.           Date                       Author             Description
<!--    -------              ----------                 -----------        ------------------
<!--     0.1                 08-10-2013                  Bharath            Original version
<!------------------------------------------------------------------------------------------------------>
<script language="javascript" src="../Renderer/custom/javascripts/session.js"> </script>
<script type="text/javascript">
var iCalledTimes = "Y";
var catodAcctNum = ""
function post_ONLOAD()
{
	if(iCalledTimes=="Y"){
		catodAcctNum = getSValue("catodAcctNum");
		//alert("Account Number: " +catodAcctNum );
		iCalledTimes="N";
		if(!isNaN(catodAcctNum)){
		//	alert("Call Catod" );
			catod(catodAcctNum);
			delSValue("catodAcctNum");
		}
	}	

}
        with (document) {
		write('<div class="ctable">');
        	write('<input type="text" class="label" readonly="readonly" id="TodAmt" name="TodAmt" size ="100">');
		write('</div>');
        }



function catod()
{
       // alert("Acct " + catodAcctNum);
        var input = "acctId|" + catodAcctNum;
        var retVal = appFnExecuteScript(input, "", "catod_contract.scr", false);
	//alert(retVal);
        if (retVal != null && retVal != undefined && retVal != "")
        {
                var ret = retVal.split("|");
                var message = ret[1];
                if (message != "N")
                {
                        document.forms[0].TodAmt.value = ret[3];
                }
        }
}
</script>
