<%@ page contentType="text/html; charset=utf-8" %>
<%!
	public static final String _ARJSP_JSP_NAME = "../../finbranch/custom/jsp/cust_rpt_print_frm_fetch.jsp";
%>

<%@ include file="../../finbranch_common.jsp" %>
<%
        response.setHeader("Pragma","No-Cache");
        response.setHeader("Cache-Control","no-Cache,no-store");
        response.setDateHeader("Expires",-1);
%>
<%-- PAGE LEVEL IMPORTS  --%>
<%@ page import="fabclasses.*" %>

<arjsp:init groupName="Customize" isEntryPoint="false" />

<%
	String _ARJSP_TITLE_NAME = "";
	 _ARJSP_TITLE_NAME =ResourceManager.getString(pageContext,"finbranch","FLT000041");
	fabclasses.FinSessionInit.validateMorphReq(pageContext, ARJspCurr);
%>

<html>

<head>
<META HTTP-EQUIV="Content-Type" content="text/html;charset=utf-8">
<META HTTP-EQUIV="PRAGMA" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache,no-store">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<title><%=_ARJSP_TITLE_NAME%></title> 
<LINK href="../Renderer/stylesheets/services.css" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />
</head>

<%
	String qryStr  = request.getQueryString();
%>

<frameset rows="100%,0%">	
	<frame hidden name="fetch" src="../../Customize/Customize_ctrl.jsp?actionCode=PRINTRPTFILE<%=qryStr%>" marginwidth="10" marginheight="15" scrolling="auto" frameborder="0">
</frameset>
</html>
