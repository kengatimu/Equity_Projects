<%@ page contentType="text/html; charset=utf-8" %>
<%!
	public static final String _ARJSP_JSP_NAME = "custom/jsp/cust_dummy_frm_fetch.jsp";
%>

<%@ include file="../../finbranch_common.jsp" %>
<%
    String sProfileId   = ProfilesManager.getProfileInSession(session);
%>
	
	<%-- PAGE LEVEL IMPORTS  --%>
<%@ page import="com.infy.COTP.*, fabclasses.CommonFunctions" %>

<arjsp:init groupName="arjspmorph" isEntryPoint="false" />

<%
	String _ARJSP_TITLE_NAME = "";
	_ARJSP_TITLE_NAME = CommonFunctions.getLiteral(ARJspCurr,pageContext,"finbranch","FLT000041");
%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><%=_ARJSP_TITLE_NAME%></title> 
<LINK href="../../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />
</head>

<%
	String qryStr  = request.getQueryString();
%>

<frameset rows="100%,0%">
	<frame name="dummy_fetch" src="cust_dummy_frm_fetch.jsp" marginwidth="10" marginheight="10" scrolling="no" frameborder="0">
	<frame hidden name="fetch" src="cust_fetch.jsp?<%=qryStr%>" marginwidth="10" marginheight="15" scrolling="auto" frameborder="0">
</frameset>
</html>
