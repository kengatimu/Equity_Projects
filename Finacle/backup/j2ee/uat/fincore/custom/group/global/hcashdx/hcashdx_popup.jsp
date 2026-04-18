<%@ include file="../commonInclude.jsp"  %>

<arjsp:init groupName="Customize" isEntryPoint="false" />

<%

String _ARJSP_TITLE_NAME = "";

%>

<custom:getRepository />

<html>
<head>
<%

	String [] custData = (String [])ARJspCurr.getInput(com.infy.bbu.ons.common.CommonConstants.KEY_CUSTOM_DATA, null);
	if(custData == null){

	custData = new String[1];

	custData[0] = "";
	}
%>
<META http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><%=_ARJSP_TITLE_NAME%></title>
<custom:mbuild/>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("custom_common_functions.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("resource_functions.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/finbranchResource_<%= LocaleMapper.getLangCode(pageContext)%>.js" > </script>
<script language="javascript" src="../Renderer/javascripts/cust_pre_evt.js"></script>
<script language="javascript" src="../Renderer/javascripts/cust_post_evt.js" > </script>
<script language="javascript" src="../Renderer/javascripts/menuLayer.js"> </script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js "> </script>
<script language="javascript" src="../Renderer/custom/props/hcashdxprops.js" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/hcashdx/hcashdx_popup_glink.js" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/hcashdx/hcashdx_popup_link.js" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/jspjs/INFENG/hcashdx_popup_<%= LocaleMapper.getLangCode(pageContext)%>.js" > </script>
<LINK href="../../../stylesheets/services.css" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />

 <%@ include file="../../javascripts/appl_inc.js" %>
 <%@ include file="../../javascripts/common_inc.js" %>

</head>

<form>
	<body onload="JavaScript:fnOnLoad()">
		<%@ include file="hcashdx_popup_ginc.jsp" %>
	</body>
</form>

</html>
