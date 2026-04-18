<%@ page contentType="text/html; charset=utf-8" %>

<%!
	public static final String _ARJSP_JSP_NAME = "custom/jsp/cust_dummy_frm_fetch.jsp";
%>

<%@ include file="../../finbranch_common.jsp" %>

<arjsp:init groupName="arjspmorph" isEntryPoint="false" />

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
	String inputs	= request.getParameter("inputs");  
	String classname	= request.getParameter("classname");		
	
%>
<script>

var qryStr="";
var inputs = '<%=inputs%>' ;
var classname = '<%=classname%>' ;
if (inputs != null) {
		qryStr = "&inputs="+encodeURIComponent(inputs);
}
		
qryStr += "&classname="+encodeURIComponent(classname);
	
function invokeJsp()
{
	with (document) {
	write('<frameset rows="100%,0%">');
	write('<frame name="dummy_fetch" src="cust_dummy_frm_fetch.jsp" marginwidth="10" marginheight="10" scrolling="no" frameborder="0">');
	write('<frame hidden name="fetch" src="cust_fetch_fi.jsp?'+qryStr+'" marginwidth="10" marginheight="15" scrolling="auto" frameborder="0">');
	write('</frameset>');
	} //End with()
} 

invokeJsp();
</script>
</html>
