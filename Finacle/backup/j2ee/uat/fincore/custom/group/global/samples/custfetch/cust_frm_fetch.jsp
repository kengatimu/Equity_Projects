<%@ page contentType="text/html; charset=utf-8" %>
<%!
	public static final String _ARJSP_JSP_NAME = "custom/jsp/cust_dummy_frm_fetch.jsp";
%>

<%@ include file="../../finbranch_common.jsp" %>
<% 
           response.setHeader("Pragma","No-Cache"); 
           response.setDateHeader("Expires",0); 
           response.setHeader("Cache-Control","no-Cache,no-store"); 
%> 
	
	<%-- PAGE LEVEL IMPORTS  --%>
<%@ page import="com.infy.COTP.*, fabclasses.CommonFunctions, fabclasses.FinSessionInit" %>
<%@ page import="com.infy.bbu.jsputil.*" %>
<arjsp:init groupName="arjspmorph" isEntryPoint="false" />

<%
	String _ARJSP_TITLE_NAME = "";
	_ARJSP_TITLE_NAME = CommonFunctions.getLiteral(ARJspCurr,pageContext,"finbranch","FLT000041");
	String sProfileId 	= ProfilesManager.getProfileInSession(session);
	fabclasses.FinSessionInit.validateMorphReq(pageContext, ARJspCurr);
%>

<html>

<head>
<META HTTP-EQUIV="PRAGMA" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache,no-store"> 
<META HTTP-EQUIV="Expires" CONTENT="-1"> 
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><%=_ARJSP_TITLE_NAME%></title> 
<%@ include file="../../javascripts/coredomain.js" %>
<LINK href="../../Renderer/stylesheets/services.css" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />
<script language="javascript" src="../../Renderer/javascripts/<%=VRPKeys.getFile("login_common_functions.js",sProfileId)%>" > </script>
</head>

<%
	String qryStr  = request.getQueryString();
	String rtId    = (String)session.getAttribute("rtId");
%>

<frameset rows="100%,0%">
	<frame name="dummy_fetch" src="cust_dummy_frm_fetch.jsp?rtId=<%=rtId%>" marginwidth="10" marginheight="10" scrolling="no" frameborder="0">
	<frame hidden name="fetch" src="cust_fetch.jsp?<%=qryStr%>&rtId=<%=rtId%>" marginwidth="10" marginheight="15" scrolling="auto" frameborder="0">
</frameset>
</html>
