<%@ include file="../commonInclude.jsp" %>
<script language="javascript">
function multdrcrit_post_ONLOAD(obj)
{
	if((typeof(WF_IN_PROGRESS) != "undefined")&&(WF_IN_PROGRESS=="PEAS"))
    {
   		 document.forms[0].tranSubType[0].checked ="checked";
    }
    return true

}
</script>
