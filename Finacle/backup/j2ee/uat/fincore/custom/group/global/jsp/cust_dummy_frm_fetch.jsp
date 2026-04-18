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
	
	String sBaseHref = (String)pageContext.getAttribute("_ARJspApplicationBaseHref_", PageContext.SESSION_SCOPE);
%>

<html>
 <head>
<% if (null != sBaseHref) { %>
  <base href="<%=sBaseHref+"/finbranch/custom/"%>">
<% } %>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
  <title><%=_ARJSP_TITLE_NAME%></title> 
<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />
 </head>

<body class="cbody">
<P>Processing......</P>
<img src="../Renderer/images/wait.gif">
</body>

</html>
