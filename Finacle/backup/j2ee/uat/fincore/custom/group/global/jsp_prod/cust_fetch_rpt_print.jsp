<%@ page contentType="text/html; charset=utf-8" %>
<%!
	public static final String _ARJSP_JSP_NAME = "custom/jsp/cust_fetch_rpt_print.jsp";
%>
<%@ include file="../../finbranch_common.jsp" %>


	<%-- PAGE LEVEL IMPORTS  --%>
<%@ page import="FABInquiry.*" %>
<%@ page import="com.infy.COTP.*, com.infy.finbranch.groups.CustomizeBean,java.util.LinkedHashMap" %>
<%@ page import="com.infy.bbu.jsputil.*" %>

<%@ taglib uri="taglib.tld" prefix="arjsp" %>

<arjsp:init groupName="Customize" isEntryPoint="false" />

<%
         String sProfileId   = ProfilesManager.getProfileInSession(session);
%>


<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">

<LINK href="../../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />
</head>
<%@ page import="java.util.Enumeration" %>


<script language ="javascript">

<%

String sCloseWindow = (String)request.getParameter("closeWindow");
sCloseWindow = (sCloseWindow != null) ? sCloseWindow :"";

if (sCloseWindow.equals("Y"))
{

%>
	window.close();
<%
}
%>

</script>

</html>
