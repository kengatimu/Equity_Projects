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
<script language="javascript" src="../Renderer/custom/javascripts/session.js">
</script>
<script type="text/javascript">

function inquirydetails_pre_ONLOAD(obj)
{
	if((profileId == "43") && ((mopId == "HACLI") || (mopId == "HACLINQ")))
	{
		//Address Line 1 label renaming to House no/street name
		document.forms[0].innerHTML = document.forms[0].innerHTML.replace('Address Line 1','House no/street name');
		//State label renaming to State/commune
		document.forms[0].innerHTML = document.forms[0].innerHTML.replace('State','State/commune');
	}
}

var iCalledTimes = "Y";
var catodAcctNum = ""

function post_ONLOAD()
{
    if (iCalledTimes == "Y")
    {
        catodAcctNum = "";
        catodAcctNum = getSValue("catodAcctNum");
        iCalledTimes = "N";
        if (catodAcctNum != "")
        {
	    if (!isNaN(catodAcctNum))
            {
                catod(catodAcctNum);
                delSValue("catodAcctNum");
            }
        }
        delSValue("catodAcctNum");
    }
    delSValue("catodAcctNum");
}
with(document)
{
    write('<div class="ctable">');
    write('<input type="text" class="label" readonly="readonly" id="TodAmt" name="TodAmt" size ="100">');
    write('</div>');
}



function catod()
{
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

<script>
// code for literal change
for (var iIndex = 1; iIndex < document.all.length; iIndex++)
{
    if (document.all[iIndex].innerText == " Free Text 2")
    {
        document.all[iIndex].innerText = " Veracious Tran ID";
    }
}
</script>