<!---------------------------------------------------------------------------------------------------------------->
<!--    Name              :   clacop_accept_custom.jsp
<!--    Description       :   To mask solid
<!--    Date              :   17-07-2013
<!--    Author            :   jane
<!--    Called By         :   None
<!--    Calling       	  :   
<!--    Menu Option       :   HOAACCL
<!--    Modification History:
<!--    Sl No.             Date           Author             Description
<!--   ---------       ----------    ----------------    --------------------
<!--   0.1            	17-07-2013    	 jane            Original Version--359464
<!--	0.2				16-08-2013		Priya K				Modified for 358434
<!---------------------------------------------------------------------------------------------------------------->
<script>

function clacop_accept_post_ONLOAD(obj)
	{
	document.forms[0].solId.disabled=true;
	}
//Modified for 358434
function clacop_accept_pre_ONCLICK(obj)
{	
        setFieldsToCustomData("schmCode");
        return true;

}
</script>
