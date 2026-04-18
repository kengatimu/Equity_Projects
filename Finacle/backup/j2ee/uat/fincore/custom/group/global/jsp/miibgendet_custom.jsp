<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : miibgendet_custom.jsp
<!--Description       : This file mandates the bill amount entered cannot be equal to zero.
<!--Date              : 05-08-2013
<!--Author            : Priyanka T
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : MIIB
<!--Modification History:
<!--    Version No.     Date            Author          Description
<!--    -----------     ------          ----------      ---------------------------
<!--    0.1             05-08-2013      Priyanka T             Original version  TO - 362602
<!---------------------------------------------------------------------------------------------------------------->

<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>

<script type ="text/javascript">

function miibgendet_pre_ONCLICK(obj)
{
	if((obj.id == "Submit") || (obj.id == "Validate"))
	{
	        var boeAmt = document.forms[0].boeAmt.value;
 		if (parseFloat(boeAmt) <= 0)
    		{
        		alert("The amount must be greater than zero.");
        		document.forms[0].boeAmt.focus();
        		return false;
		}
    	
	}
}

function miibgendet_pre_TAB_SWITCH()
{
	var boeAmt = document.forms[0].boeAmt.value;
        if (parseFloat(boeAmt) <= 0)
        {
                alert("The amount must be greater than zero.");
                document.forms[0].boeAmt.focus();
                return false;
        }
}


</script>




