<!----------------------------------------------------------------------------------------------------->
<!--Name                : inquirydetails_custom.jsp
<!--Description         : Modified to show tod availed amount
<!--Date                : 07-08-2013
<!--Author              : Bharath Reddy B
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HACLI
<!--Modification History:
<!--    Version No.           Date                       Author             Description
<!--    -------              ----------                 -----------        ------------------
<!--     0.1                 07-08-2013                  Bharath            Original version
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
        //alert("Acct " + catodAcctNum);
        var input = "acctId|" + catodAcctNum;
        var retVal = appFnExecuteScript(input, "", "catod_contract.scr", false);
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
