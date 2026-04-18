<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : limxfrmain_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 20-05-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : limxfrmain_cglink.js
<!--Menu Option       : HLIMXFR
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		20-05-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<%@ page import="com.infy.bbu.jsputil.*" %>
<%String sProfileId = ProfilesManager.getProfileInSession(session); %>
<% VRPKeys vrpInst = (VRPKeys)session.getAttribute("VRPKeysInst");%>

<script language="javascript" src="../Renderer/custom/javascripts/limxfrmain_cglink.js"></script>

<script language="javascript">
{
printFunctionBlock();
//alert("hello");
}
</script>







