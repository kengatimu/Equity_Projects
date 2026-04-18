<%/*-----------------------------------------------------------------------------------------
	NAME		: ddmpdet_custom.jsp
	Module Code	: DENOM
	Description	: Supports Denom,modules
	Menu Option	: HDDC
	Author		: Irenpreet
	DATE		: 18-JUN-2010
	Modification History:	
	====================
	SrlNo.	DATE		Author				Description

------------------------------------------------------------------------------------------*/%>
<%!
    public static final String _ARJSP_JSP_NAME = "ddc/ddcdet.jsp";
%>

<%@ page import="com.infy.bbu.jsputil.ProfilesManager" %>
<%@ page import="com.infy.bbu.jsputil.VRPKeys" %>
<%
        String sProfileId = ProfilesManager.getProfileInSession(session);
        VRPKeys vrpInst = (VRPKeys)session.getAttribute("VRPKeysInst");
	
	String sDenomCount      = ((request.getParameter("custom.DenomCount")!= null)?request.getParameter("custom.DenomCount"):"");
	String sDenomEntered = ((request.getParameter("custom.DenomEntered")!= null)?request.getParameter("custom.DenomEntered"):"N");
	String sEvent   = ((request.getParameter("custom.sEvent")!= null)?request.getParameter("custom.sEvent"):"E");
	String trnId = ((request.getParameter("custom.trnId")!= null)?request.getParameter("custom.trnId"):"");
%>

<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("array.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_denom_functions.js",sProfileId)%>"> </script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("ddcdet_custom_link.js",sProfileId)%>"> </script>
<script language="JAVASCRIPT">

var trnId;

function post_ONLOAD(ddcdet,obj)
{
	alert(rptCode);
var input      = "instnum|"+ddNum+"|ddIssDate|"+ddIssDate+"|bankCode|"+bankCode+"|brCode|"+brCode;
var outputNames    = "output|outVal";
var scrName     =   "ddtranid.scr";
var retVal = appFnExecuteScript(input,outputNames,scrName,false);
var retBuff = retVal.split("|");
var output = retBuff[0];
var value = retBuff[1];
trnId = value;	

	if ((profileId=='54') || (profileId=='43'))
	{
		var input      = "";
		var outputNames    = "output|outVal";
		var scrName     =   "b_workclass.scr";
		var retVal = appFnExecuteScript(input,outputNames,scrName,false);
		var retBuff = retVal.split("|");
		var output = retBuff[0];
		var value = retBuff[1];
	        var a = value;
	        var retBuff = retVal.split("|");
	        var output1 = retBuff[2];
	        var value1 = retBuff[3];
	        var b = value1;
		//alert(a);

			if (((a<510) || (a!=110)) && (b!=152)) 
			{
				document.forms[0].refundAcctNum.disabled=true;
				hideImage("sLnk1");	
			}
	}

}

</script>
<INPUT type="hidden" name="custom.trnId" id="trnId" value="<%=trnId%>">
<INPUT type="hidden" name="custom.DenomEntered" id="DenomEntered" value="<%=sDenomEntered%>">
<INPUT type="hidden" name="custom.DenomCount" id="DenomCount" value="<%=sDenomCount%>" >
<INPUT type="hidden" name="custom.Event" id="Event" value="<%=sEvent%>" >
