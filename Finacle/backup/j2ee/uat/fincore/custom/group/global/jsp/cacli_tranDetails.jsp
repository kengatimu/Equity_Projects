<%/*---------------------------------------------------------------------------------------
NAME                :   cacli_tranDetails.jsp
Menu                :   CACLI
Called JSP          :   None
Called Script       :   None
Description         :   This jsp is used for displaying Transaction details in CACLI menu
Author              :   Nitin Kumar
Date                :   13-June-2013
Module              :   CACLI
Modification History:

<Serial No.>     <Date>         <Author Name>           <Description>
-------------   ---------       ------------------      ----------------
1               13-06-2013      Nitin Kumar       	Base Version
-------------------------------------------------------------------------------------*/%>
<%@ page contentType="text/html; charset=utf-8" %>
<%!
        public static final String _ARJSP_JSP_NAME = "custom/cacli_tranDetails.jsp";
%>
<%
         String sProfileId   = ProfilesManager.getProfileInSession(session);
%>


<%@ include file="../../finbranch_common.jsp"   %>
        <%-- PAGE LEVEL IMPORTS  --%>
<%@ page import="FABInquiry.*" %>
<%@ page import="com.infy.COTP.*, com.infy.finbranch.groups.customBean" %>

<arjsp:init groupName="arjspmorph" isEntryPoint="false" />

<%
        String pageTitle = request.getParameter("pageTitle");
        String sBaseHref = (String)pageContext.getAttribute("_ARJspApplicationBaseHref_", PageContext.SESSION_SCOPE);

        String tranId = request.getParameter("tranId");
	String tranDate = request.getParameter("tranDate");
	String instrType = request.getParameter("instrType");
	String instrNum = request.getParameter("instrNum");
	String instrDate = request.getParameter("instrDate");
	String glDate = request.getParameter("glDate");
	String valueDate = request.getParameter("valueDate");
	String tranType = request.getParameter("tranType");
	String reportCode = request.getParameter("reportCode");
	String remarks = request.getParameter("remarks");
	String refNo = request.getParameter("refNo");
	String acctId = request.getParameter("acctId");
	String refAmt = request.getParameter("refAmt");
	String amount = request.getParameter("amount");
	String entryUsrId = request.getParameter("entryUsrId");
	String pstdUsrId = request.getParameter("pstdUsrId");
	String tranPartiCode = request.getParameter("tranPartiCode");
	String tranParti = request.getParameter("tranParti");
	String tranDesc = request.getParameter("tranDesc");
	String remarks1 = request.getParameter("remarks1");
	String remarks2 = request.getParameter("remarks2");
	String verifyUsrId = request.getParameter("verifyUsrId");
	String rateCode = request.getParameter("rateCode");
	String TrsryRate = request.getParameter("TrsryRate");
	String reversal = request.getParameter("reversal");
	String delRecord = request.getParameter("delRecord");
	String tranSolId = request.getParameter("tranSolId");
	String TrsryRefNum = request.getParameter("TrsryRefNum");
	String entered = request.getParameter("entered");
	String posted = request.getParameter("posted");
	String verified = request.getParameter("verified");
%>

<html>
<head>

<% if (null != sBaseHref) { %>
<base href="<%=sBaseHref+"/finbranch/custom/"%>">
<% } %>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>Transaction Inquiry</title>
<script language="javascript" src="../Renderer/custom/javascripts/common_functions.js"></script>
<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />

<script language="javascript">
var tranId = '<%=tranId%>' ;
var tranDate = '<%=tranDate%>' ;
var instrType = '<%=instrType%>' ;
var instrNum = '<%=instrNum%>' ;
var instrDate = '<%=instrDate%>' ;
var glDate = '<%=glDate%>' ;
var valueDate = '<%=valueDate%>' ;
var tranType = '<%=tranType%>' ;
var reportCode = '<%=reportCode%>' ;
var remarks = '<%=remarks%>' ;
var refNo = '<%=refNo%>' ;
var acctId = '<%=acctId%>' ;
var refAmt = '<%=refAmt%>' ;
var amount = '<%=amount%>' ;
var entryUsrId = '<%=entryUsrId%>' ;
var pstdUsrId = '<%=pstdUsrId%>' ;
var tranPartiCode = '<%=tranPartiCode%>' ;
var tranParti = '<%=tranParti%>' ;
var tranDesc = '<%=tranDesc%>' ;
var remarks1 = '<%=remarks1%>' ;
var remarks2 = '<%=remarks2%>' ;
var verifyUsrId = '<%=verifyUsrId%>' ;
var rateCode = '<%=rateCode%>' ;
var TrsryRate = '<%=TrsryRate%>' ;
var reversal = '<%=reversal%>' ;
var delRecord = '<%=delRecord%>' ;
var tranSolId = '<%=tranSolId%>' ;
var TrsryRefNum = '<%=TrsryRefNum%>' ;
var entered = '<%=entered%>' ;
var posted = '<%=posted%>' ;
var verified = '<%=verified%>' ;

fnPrintTranDetails();

function fnPrintTranDetails(){
        with (document){
        write('<!-- HEADERBLOCK-BEGIN -->');
        write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
        write('<tr>');
        write('<td>');
        write('<table border="0" cellspacing="0" cellpadding="0">');
        write('<tr>');
        write('<td class="page-heading">Account Balance Details</td>');
        write('</tr>');
        write('</table>');
        write('<table border="0" colspan="5" cellpadding="0" cellspacing="0" width="100%">');
        write('<!-- HEADERBLOCK-END -->');
        write('<!-- DETAILSBLOCK-BEGIN -->');
        write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
        write('<tr>');
        write('<td valign="top">');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
        write('<tr>');
        write('<td>');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
        write('<tr>');
        write('<td>');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');
        write('<tr>');
        write('<td height="25" colspan="5" align="right">');
        write('<table border="0" cellspacing="0" cellpadding="0">');
        write('</table>');
        write('</td>');
        write('</tr>');

        write('<tr>');
        write('<td class="textlabel">Transaction ID</td>');
        write('<td class="textfielddisplaylabel">'+tranId+'</td>');
	write('<td class="textlabel">Instrument Type</td>');
        write('<td class="textfielddisplaylabel">'+instrType+'</td>');
        write('</tr>');

	write('<tr>');
        write('<td class="textlabel">Transaction Date</td>');
        write('<td class="textfielddisplaylabel">'+tranDate+'</td>');
        write('<td class="textlabel">Instrument No.</td>');
        write('<td class="textfielddisplaylabel">'+instrNum+'</td>');
        write('</tr>');

        write('<tr>');
        write('<td class="textlabel"> General Ledger Date</td>');
        write('<td class="textfielddisplaylabel">'+glDate+'</td>');
        write('<td class="textlabel">Instrument Date</td>');
        write('<td class="textfielddisplaylabel">'+instrDate+'</td>');
        write('</tr>');

        write('<tr>');
        write('<td class="textlabel">Value Date</td>');
        write('<td class="textfielddisplaylabel">'+valueDate+'</td>');
        write('<td class="textlabel">Transaction Type</td>');
        write('<td class="textfielddisplaylabel">'+tranType+'</td>');
        write('</tr>');

        write('<tr>');
        write('<td class="textlabel">Report Code</td>');
        write('<td class="textfielddisplaylabel">'+reportCode+'</td>');
        write('<td class="textlabel">Remarks</td>');
        write('<td class="textfielddisplaylabel">'+remarks+'</td>');
        write('</tr>');

	write('<tr>');
        write('<td class="textlabel">Ref. No.</td>');
        write('<td class="textfielddisplaylabel">'+refNo+'</td>');
        write('<td class="textlabel">A/c ID</td>');
        write('<td class="textfielddisplaylabel">'+acctId+'</td>');
        write('</tr>');
        
        write('<tr>');
	write('<td class="textlabel">Ref. Amt.</td>');
	write('<td class="textfielddisplaylabel">'+refAmt+'</td>');
	write('<td class="textlabel">Amt.</td>');
	write('<td class="textfielddisplaylabel">'+amount+'</td>');
        write('</tr>');
        
        write('<tr>');
	write('<td class="textlabel">Entry User ID</td>');
	write('<td class="textfielddisplaylabel">'+entryUsrId+'</td>');
	write('<td class="textlabel">Posted User ID</td>');
	write('<td class="textfielddisplaylabel">'+pstdUsrId+'</td>');
        write('</tr>');
        
        write('<tr>');
	write('<td class="textlabel">Transaction Particulars Code</td>');
	write('<td class="textfielddisplaylabel">'+tranPartiCode+'</td>');
	write('<td class="textlabel">Transaction Description</td>');
	write('<td class="textfielddisplaylabel">'+tranDesc+'</td>');
        write('</tr>');
        
        write('<tr>');
	write('<td class="textlabel">Transaction Particulars</td>');
	write('<td class="textfielddisplaylabel">'+tranParti+'</td>');
	write('<td class="textlabel">Remarks2</td>');
	write('<td class="textfielddisplaylabel">'+remarks2+'</td>');
        write('</tr>');
        
        write('<tr>');
	write('<td class="textlabel">Remarks1</td>');
	write('<td class="textfielddisplaylabel">'+remarks1+'</td>');
	write('<td class="textlabel">Verified User ID</td>');
	write('<td class="textfielddisplaylabel">'+verifyUsrId+'</td>');
        write('</tr>');
        
        write('<tr>');
	write('<td class="textlabel">Rate Code/Rate</td>');
	write('<td class="textfielddisplaylabel">'+rateCode+'</td>');
	write('<td class="textlabel">Treasury Rate</td>');
	write('<td class="textfielddisplaylabel">'+TrsryRate+'</td>');
        write('</tr>');
        
        write('<tr>');
	write('<td class="textlabel">Reversal</td>');
	write('<td class="textfielddisplaylabel">'+reversal+'</td>');
	write('<td class="textlabel">Deleated Records</td>');
	write('<td class="textfielddisplaylabel">'+delRecord+'</td>');
        write('</tr>');
        
        write('<tr>');
	write('<td class="textlabel">Transaction SOL ID</td>');
	write('<td class="textfielddisplaylabel">'+tranSolId+'</td>');
	write('<td class="textlabel">Treasury Ref. No.</td>');
	write('<td class="textfielddisplaylabel">'+TrsryRefNum+'</td>');
        write('</tr>');
        
        write('<tr>');
	write('<td class="textlabel">Entered</td>');
	write('<td class="textfielddisplaylabel">'+entered+'</td>');
	write('<td class="textlabel">Posted</td>');
	write('<td class="textfielddisplaylabel">'+posted+'</td>');
        write('</tr>');
        
        write('<tr>');
	write('<td class="textlabel">Verified</td>');
	write('<td class="textfielddisplaylabel">'+verified+'</td>');
        write('</tr>');
        
      

        write('</table>');
        write('</td>');
        write('</tr>');
        write('</table>');
        write('</td>');
        write('</tr>');
        write('</table>');
        write('</td>');
        write('</tr>');
        write('</table>');
        write('<!-- DETAILSBLOCK-END -->');
        write('<br>');
        write('&nbsp;<input class="button" type="button" id="OK" value="OK" onClick="javascript:return window.close()" >');
        } //End with()
}

</script>
</head>
</html>
