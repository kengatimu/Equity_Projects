<%
/*
Author: Narry
Purpose: Testing
*/
%>
<%!
    public static final String _ARJSP_JSP_NAME = "laopi/laopires.jsp";
%>

<%@ page import="com.infy.bbu.jsputil.ProfilesManager" %>
<%@ page import="com.infy.bbu.jsputil.VRPKeys" %>

<%@ include file="../commonInclude.jsp" %>
<arjsp:init groupName="laopi" isEntryPoint="false" />
<%
		String sIsCalledMenu = (String)ARJspCurr.getInputWithGroup("IsCalledMenu","");
%>
<script>
	var isCalledMenu="<%=sIsCalledMenu%>";
</script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("laopires_custom_link.js",sProfileId)%>"></script>
