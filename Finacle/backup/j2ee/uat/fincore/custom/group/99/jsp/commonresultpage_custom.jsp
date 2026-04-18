<%-- getting the values from the arjsp object --%>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="arjspmorph" isEntryPoint="false" />

<%
	String sMsg = (String)ARJspCurr.getInputWithGroup("RESULT_MSG",null);
%>
<script type="text/javascript">

if(mopId== "HSALPAY") {
var argsVariable = "<%=sMsg%>";
var url="../custom/jsp/salpaymn001.jsp?trandeatail='" + argsVariable + "'";
var answer = window.showModalDialog(url,argsVariable, "dialogWidth:400px; dialogHeight:300px; center:yes");
}

</script>
