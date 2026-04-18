<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%!
	public static final String _ARJSP_JSP_NAME = "custom/hcashdx_det_dp001.jsp";
%>
<%@ include file="../commonInclude.jsp" %>
<arjsp:init groupName="custom" isEntryPoint="true" />
<jsp:useBean id="customBeanInst" class="com.infy.finbranch.groups.customBean" scope="session" />

<%
 request.setCharacterEncoding("utf-8");
fabclasses.FinSessionInit sessInit;
        synchronized(session) {
                sessInit = (fabclasses.FinSessionInit) session.getAttribute("FinSessionInit");
                if (sessInit == null) {
                        sessInit = (fabclasses.FinSessionInit)CustomMapper.fetchClassInstance("fabclasses.FinSessionInit");
                        session.setAttribute("FinSessionInit", sessInit);
                }
        }
	 request.setCharacterEncoding("utf-8");

    String alignInd = "";
    String textstyle = "";

    alignInd = "left";

    String sNextPage = "custom/hcashdx/hcashdx_det_dp001.jsp";
    String outErrorPage[] = new String[1];
        boolean isInitSuccessful = true;

 if(sessInit.InitializeSession(pageContext, ARJspCurr, outErrorPage) != 0)
        {
                sNextPage = outErrorPage[0] != null ? outErrorPage[0] : "../../arjspmorph/error_page.jsp";
                isInitSuccessful = false;
        }
 if(isInitSuccessful)
        {
                customBeanInst.Refresh(pageContext, ARJspCurr, ARJspRet);
                customBeanInst.populateFields(finbranch, PropertyManager.getProperties(session), ResourceManager.getResourceBundle(pageContext, "finbranch"));
                customBeanInst.setPageName(sNextPage);
        }
	String _ARJSP_TITLE_NAME = "";
   _ARJSP_TITLE_NAME = CommonFunctions.getLiteral(ARJspCurr,pageContext,"finbranch","FLT003104");


//	String sBaseHref = (String)pageContext.getAttribute("_ARJspApplicationBaseHref_", PageContext.SESSION_SCOPE);


//	String appContextPath 	= request.getContextPath();
//	String sProfileId 	= ProfilesManager.getProfileInSession(session);
//	String sProfileDir = ProfilesManager.getProfileDirectory(session);
//	FinSessionInit.validateMorphReq(pageContext, ARJspCurr);
%>
			

<html>
<head>
<% if (null != sBaseHref) { %> <base href="<%=sBaseHref + appContextPath + "/arjspmorph"%>"> <% } %>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><%=_ARJSP_TITLE_NAME%></title> 
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("finbranchResource_"+LocaleMapper.getLangCode(pageContext)+".js",sProfileId) %>"  > </script> 
<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />
<custom:mbuild/>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_evt.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("loc_evt.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("resource_functions.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_common_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/lists/<%=VRPKeys.getFile("showCurrency.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("hotkeyprocessor_link.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("hotkeydata_link.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/arjspmorph/<%=VRPKeys.getFile("crncyconv_link.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/hcashdx/<%=VRPKeys.getCustomFile("hcashdx_det_dp001.js",sProfileId)%>" > </script>


</head>

</html>
