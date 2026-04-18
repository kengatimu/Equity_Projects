<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : fbmgendet_custom.jsp
<!--Description       : This file mandates the bill amount entered cannot be equal to zero.
<!--Date              : 03-08-2013
<!--Author            : Priyanka T
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : MEOB
<!--Modification History:
<!--    Version No.     Date            Author          Description
<!--    -----------     ------          ----------      ---------------------------
<!--    0.1             03-08-2013      Priyanka T             Original version  TO - 362602
<!---------------------------------------------------------------------------------------------------------------->

<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>

<script type ="text/javascript">

function fbmgendet_pre_ONCLICK(obj)
{
	if(obj.id == "Submit" || obj.id == "Validate")
	{
		var boeAmt = document.forms[0].boeAmt.value;
        	if(parseFloat(boeAmt)<=0)
        	{
                	alert("The amount must be greater than zero.");
                	document.forms[0].boeAmt.focus();
                	return false;
        	}
	}

}

function fbmgendet_pre_TAB_SWITCH()
{
	var boeAmt = document.forms[0].boeAmt.value;
        if(parseFloat(boeAmt)<=0)
        {
                alert("The amount must be greater than zero.");
                document.forms[0].boeAmt.focus();
                return false;
        }
}

</script>



