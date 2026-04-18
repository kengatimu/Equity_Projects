<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%!
	public static final String _ARJSP_JSP_NAME = "dtprint/dtpdisplay.jsp";
%>
<%@ include file="../../../finbranch_common.jsp" %>
<%@ page import="fabclasses.CommonFunctions" %>
<%@ page  errorPage="../../../arjspmorph/error_page.jsp"  import=" gcode.iface.* , gcode.dataobjects.* " %>
<%fabclasses.FinSessionInit.setRequestResponseParams(request,response);%> 
<arjsp:init groupName="dtprint" isEntryPoint="false" />
<%

	String _ARJSP_TITLE_NAME = "";
   _ARJSP_TITLE_NAME = CommonFunctions.getLiteral(ARJspCurr,pageContext,"finbranch","FLT017335");


	String sBaseHref = (String)pageContext.getAttribute("_ARJspApplicationBaseHref_", PageContext.SESSION_SCOPE);


	String appContextPath 	= request.getContextPath();
	String sProfileId 	= ProfilesManager.getProfileInSession(session);
	String sProfileDir = ProfilesManager.getProfileDirectory(session);
	String auditParentGroupName1 = (String)session.getAttribute("auditParentGroupName");
%>
	
<script language="javascript">
var audGrpName = "<%=auditParentGroupName1%>";
</script>

<html>
<head>
<% if (null != sBaseHref) { %> <base href="<%=sBaseHref + appContextPath + "/dtprint/"%>"> <% } %>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<META HTTP-EQUIV="PRAGMA" CONTENT="-1">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<title><%=_ARJSP_TITLE_NAME%></title> 
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getResourceFile("finbranchResource_"+LocaleMapper.getLangCode(pageContext)+".js") %>"  > </script> 
<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />
<custom:mbuild/>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_evt.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("loc_evt.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("core_banking.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("resource_functions.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("login_common_functions.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_functions.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("common_functions.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("menuLayer.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("hotkeyprocessor_link.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("hotkeydata_link.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/dtprint/<%=VRPKeys.getFile("dtpdisplay_link.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/dtprint/<%=VRPKeys.getFile("dtpdisplay_glink.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/props/<%=VRPKeys.getFile("dtprintprops.js",sProfileId)%>" > </script>
<%@ include file="../../../javascripts/coredomain.js" %>
<%@ include file="../../../javascripts/appl_inc.js" %>
<%@ include file="../../../javascripts/time_out.js" %>
<%@ include file="../../../javascripts/dtprint/dtpdisplay_inc.js" %>
<%@ include file="../../../javascripts/dtprint/dtpdisplay_ginc.js" %>

</head>
<%@ include file="dtpdisplay.jsf" %>

</html>
