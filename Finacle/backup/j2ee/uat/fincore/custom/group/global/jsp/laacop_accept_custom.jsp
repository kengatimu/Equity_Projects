<!---------------------------------------------------------------------------------------------------------------->
<!--    Name              :   laacop_accept_custom.jsp
<!--    Description       :   To check repeated borrower or not
<!--    Date              :   18-04-2013
<!--    Author            :   Manoj
<!--    Called By         :   None
<!--    Calling       	  :   acctopnvalmn001.scr
<!--    Menu Option       :   HOAACLA
<!--    Modification History:
<!--    Sl No.             Date           Author             Description
<!--   ---------       ----------    ----------------    --------------------
<!--   0.1            	18-04-2013    	 Manoj            Original Version
<!--   0.2				10-07-2013		 Kalvin			  Modified for TO/CR No :356308 in lineNo:18
<!--   0.3				14-08-2013		Priya K				Reconciled with Jane source
<!---------------------------------------------------------------------------------------------------------------->

<script type="text/javascript"> 
//Reconciled with Jane source
function laacop_accept_post_ONLOAD(obj)
{
	document.forms[0].solId.disabled=true;
}

function laacop_accept_pre_ONCLICK(btn)
{
	/*-----changes made for TO/CR: 356308----------------*/
	setFieldsToCustomData("schmCode","tempForacid");
	/*-------------end of change-----------------------------*/
	if (btn.id != 'Cancel' && mopId == "HOAACLA") 
	{
		var cifId1 = document.forms[0].cifId.value;
		var schmCode1 = document.forms[0].schmCode.value;
		<%-- Common initialization for fnExecuteScript --%>
		var inputNameValues =  "cifId" + "|" + cifId1 + "|" + "schmCode" + "|" + schmCode1 ;
		var outputNames = "paramV";
		var scrName = "acctopnvalmn001.scr";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		if(ret[1] == "W") 
		{
			alert("Repeated Borrower");
			document.forms[0].cifId.focus(); 
			return true;
		}
	}
}

</script>


