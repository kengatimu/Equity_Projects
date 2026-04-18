<%/*-----------------------------------------------------------------------------------------
	NAME		: ddmpdet_custom.jsp
	Module Code	: DENOM
	Description	: Supports Denom,modules
	Menu Option	: HDDMP
	Author		: Irenpreet
	DATE		: 18-JUN-2010
	Modification History:	
	====================
	SrlNo.	DATE		Author				Description

------------------------------------------------------------------------------------------*/%>
<%!
    public static final String _ARJSP_JSP_NAME = "ddmp/ddmpdet.jsp";
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
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("ddmpdet_custom_link.js",sProfileId)%>"> </script>


<INPUT type="hidden" name="custom.DenomEntered" id="DenomEntered" value="<%=sDenomEntered%>">
<INPUT type="hidden" name="custom.DenomCount" id="DenomCount" value="<%=sDenomCount%>" >
<INPUT type="hidden" name="custom.Event" id="Event" value="<%=sEvent%>" >

