<%@ page contentType="text/html; charset=utf-8" %>
<%!
	public static final String _ARJSP_JSP_NAME = "../../finbranch/custom/jsp/cust_rpt_print_frm_fetch.jsp";
%>

<%@ include file="../../finbranch_common.jsp" %>
<arjsp:init groupName="Customize" isEntryPoint="false" />

<%
         String sProfileId   = ProfilesManager.getProfileInSession(session);
%>


<%
	String _ARJSP_TITLE_NAME = "";
	 _ARJSP_TITLE_NAME =ResourceManager.getString(pageContext,"finbranch","FLT000041");
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
	<frame hidden name="fetch" src="../../Customize/Customize_ctrl.jsp?actionCode=PRINTRPTFILE<%=qryStr%>" marginwidth="10" marginheight="15" scrolling="auto" frameborder="0">
</frameset>
</html>
