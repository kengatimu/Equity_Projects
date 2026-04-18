<%-- The jsp is used for invocation of the GBM Menu in Separate Window--%>
<%!
	public static final String _ARJSP_JSP_NAME = "/custom/jsp/custom_gbmscreen.jsp";
%>

<%@ include file="../commonInclude.jsp" %>
<arjsp:init groupName="custom"  isEntryPoint="true" />
<jsp:useBean id="customBeanInst" class="com.infy.finbranch.groups.customBean" scope="session" />

<%--Contains securityinfo session object for getting data related to a user --%>
<% 
	SecurityInfo70 userInfo = (SecurityInfo70)session.getAttribute("FinUserInfo");
%>

<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
  <title>GBM Maintenance</title>
	
		<%-- APP LEVEL LINKS  --%>
   <script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getResourceFile("finbranchResource_"+LocaleMapper.getLangCode(pageContext)+".js") %>"  > </script> 
  <LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />

  <custom:mbuild/>

  		<%-- PAGE LEVEL LINKS  --%>
  <script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_pre_evt.js",sProfileId)%>" > </script>
  <script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_post_evt.js",sProfileId)%>" > </script>
  <script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("core_banking.js",sProfileId)%>" > </script>
  <script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("resource_functions.js",sProfileId)%>" > </script>
  <script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_functions.js",sProfileId)%>" > </script>
  <script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("common_functions.js",sProfileId)%>" > </script>
  <script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("menuLayer.js",sProfileId)%>" > </script>
  <script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("hotkeyprocessor_link.js",sProfileId)%>" > </script>
  <script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("hotkeydata_link.js",sProfileId)%>" > </script>
  <SCRIPT language="javascript" src="../custom/javascripts/custom_functions_wf.js" ></SCRIPT>
  	<%-- APP LEVEL INCLUDES  --%>
 <%@ include file="../../javascripts/appl_inc.js" %>
 </head>
<body onLoad=GBMCall();>
<form method="post" class="cform" id="frmMain" onSubmit="return false">

		<%-- PAGE LEVEL IMPORTS  --%>
	<%@ include file="../../javascripts/header.js" %>

	<table class="ctable" width="100%" border="0" cellspacing="0" cellpadding="0" class="normal">
	<tr>
	<td class="page-heading" name="gbmHead" value=""> GBM Maintenance</td>
	</tr>
	</table>
	<table class="ctable" width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="rowspacing" >
		<td colspan="5">&nbsp;</td>
		</tr>
		</table>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">
		<tr>
		<td valign="top">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">
		<tr>
		<td>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">
		<tr class="textfielddisplaylabel1" valign="middle">
		<td colspan="5">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="resultpage">
		<tr>
		<td width="3%">
		<img class="img" src="../Renderer/images/info.gif" width="29" height="29" align="right" border="0">
		</img>
		</td>
		<td width="97%" >Menu Invoked Successfully</td>
		</tr>
		<tr>
		<td colspan="5" class="rowspacing"><spacer type="block" height=1 width=1></spacer></td>
		</tr>
		</table>
		</td></tr>
		</table></td></tr>
		</table></td></tr>
		</table></td></tr>
		</table>
		</div>
	</span>
<script>
// The Function containing the code for GBM Jsp invocation	
function GBMCall()
{
	var userId = '<%=ParseValue.checkString(userInfo.userId)%>';
	var cxtSol = '<%=ParseValue.checkString(userInfo.contextSolId)%>';
	var sessionId = '<%=ParseValue.checkString(userInfo.sessionId)%>';
		
	URL="http://<IP address of m/c where GBM is running>:<port_num>/gbm28/servlet/com.gbm.common.GBMLoginServlet?SolId="+cxtSol;
	URL= URL+"&UserId="+userId;
	URL= URL+"&SessionId="+sessionId;

	window.open(URL);
}
</script>	
</body>
</html>


