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
<%@ page import="com.infy.COTP.*, fabclasses.CommonFunctions" %>
<%@ page import="fabclasses.*" %>
<arjsp:init groupName="arjspmorph" isEntryPoint="false" />

<%
	String _ARJSP_TITLE_NAME = "";
	_ARJSP_TITLE_NAME = CommonFunctions.getLiteral(ARJspCurr,pageContext,"finbranch","FLT000041");
	
	String sBaseHref = (String)pageContext.getAttribute("_ARJspApplicationBaseHref_", PageContext.SESSION_SCOPE);
	fabclasses.FinSessionInit.validateMorphReq(pageContext, ARJspCurr);
%>

<html>
<head>
<META HTTP-EQUIV="PRAGMA" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache,no-store"> 
<META HTTP-EQUIV="Expires" CONTENT="-1"> 
<% if (null != sBaseHref) { %>
  <base href="<%=sBaseHref+"/finbranch/custom/"%>">
<% } %>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
  <title><%=_ARJSP_TITLE_NAME%></title> 
  <LINK href="../Renderer/stylesheets/services.css" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />
 </head>

<body class="cbody">
<P>Processing......</P>
<img src="../Renderer/images/wait.gif">
</body>

</html>
