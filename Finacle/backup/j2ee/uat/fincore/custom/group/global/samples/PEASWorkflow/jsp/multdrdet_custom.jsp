<%@ include file="../commonInclude.jsp" %>
<arjsp:init groupName="multdr" isEntryPoint="false" />
<%
        String countPageLoads =(String)ARJspCurr.getInputWithGroup("countPageLoads","");
%>
<script language = "javascript">
var countPageLoads = "<%=countPageLoads%>" ;
function multdrdet_post_ONLOAD(obj)
{
	if((typeof(WF_IN_PROGRESS) != "undefined")&&(WF_IN_PROGRESS=="PEAS")&&(document.forms[0].acctId.value != "") && (countPageLoads !="Reloaded"))
	{
			<%
					ARJspCurr.setInputWithGroup("countPageLoads","Reloaded");
			%>
			document.forms[0].acctId.onchange();
	 }
     return true;
}
</script>
