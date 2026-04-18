<%
/*-----------------------------------------------------------------------------------------
   NAME         :   tutmdtl_custom.jsp
   Description  :   This is a custom JSP to enable denominations
   Menu Option  :   HTUTM
   Author       :   Arathilakshmi
   Date		:	26-08-2011

   Modification History:
   ====================
   Serial No.   DATE            Author                  Description
   1.		26-AUG-2011		Arathilakshmi				Draft Version
------------------------------------------------------------------------------------------*/
%>

<%!
    public static final String _ARJSP_JSP_NAME = "tutm/tutmdtl.jsp";
%>

<%@ page import="com.infy.bbu.jsputil.ProfilesManager" %>
<%@ page import="com.infy.bbu.jsputil.VRPKeys" %>
<%
        String sProfileId = ProfilesManager.getProfileInSession(session);
        VRPKeys vrpInst = (VRPKeys)session.getAttribute("VRPKeysInst");
	
	String sDenomCount      = ((request.getParameter("custom.DenomCount")!= null)?request.getParameter("custom.DenomCount"):"");
	String sDenomEntered = ((request.getParameter("custom.DenomEntered")!= null)?request.getParameter("custom.DenomEntered"):"N");
	String sEvent   = ((request.getParameter("custom.sEvent")!= null)?request.getParameter("custom.sEvent"):"E");

%>

<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("array.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_denom_functions.js",sProfileId)%>"> </script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("tutmdtl_custom_link.js",sProfileId)%>"> </script>
<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("custom_common_functions.js",sProfileId)%>" ></SCRIPT>


<INPUT type="hidden" name="custom.DenomEntered" id="DenomEntered" value="<%=sDenomEntered%>">
<INPUT type="hidden" name="custom.DenomCount" id="DenomCount" value="<%=sDenomCount%>" >
<INPUT type="hidden" name="custom.Event" id="Event" value="<%=sEvent%>" >

