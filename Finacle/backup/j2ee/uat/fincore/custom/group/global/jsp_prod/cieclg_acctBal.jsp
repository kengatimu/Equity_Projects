<%/*---------------------------------------------------------------------------------------
NAME                :   cieclg_acctBal.jsp
Menu                :   CIETXN
Called JSP          :   None
Called Script       :   None
Description         :   This jsp is used for displaying Balance Details
Author              :   Mohan Raghu Arudi
Date                :   03-Mar-2013
Module              :   CIETXN
Modification History:

<Serial No.>     <Date>         <Author Name>           <Description>
-------------   ---------       ------------------      ----------------
1               03-03-2013      Mohan Raghu Arudi       Base Version
-------------------------------------------------------------------------------------*/%>
<%@ page contentType="text/html; charset=utf-8" %>
<%!
        public static final String _ARJSP_JSP_NAME = "custom/cieclg_acctBal.jsp";
%>
<%@ include file="../../finbranch_common.jsp"   %>

        <%-- PAGE LEVEL IMPORTS  --%>
<%@ page import="FABInquiry.*" %>
<%@ page import="com.infy.COTP.*, com.infy.finbranch.groups.customBean" %>

<arjsp:init groupName="arjspmorph" isEntryPoint="false" />
<%
         String sProfileId   = ProfilesManager.getProfileInSession(session);
%>
<%
        String pageTitle = request.getParameter("pageTitle");
        String sBaseHref = (String)pageContext.getAttribute("_ARJspApplicationBaseHref_", PageContext.SESSION_SCOPE);

        String acctId = request.getParameter("acctId");
	String entityId = request.getParameter("entityId");
	String solId = request.getParameter("solId");
	String crncyCode = request.getParameter("crncyCode");
	String acctName = request.getParameter("acctName");
	String ledgerBal = request.getParameter("ledgerBal");
	String availableBal = request.getParameter("availableBal");
	String effAvailableBal = request.getParameter("effAvailableBal");
	String shadowBal = request.getParameter("shadowBal");
	String acctStatus = request.getParameter("acctStatus");
	String freezeStatus = request.getParameter("freezeStatus");
	String freezeReasonCode = request.getParameter("freezeReasonCode");
	String acctClosed = request.getParameter("acctClosed");
%>

<html>
<head>

<% if (null != sBaseHref) { %>
<base href="<%=sBaseHref+"/finbranch/custom/"%>">
<% } %>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>Account Balance Details</title>
<script language="javascript" src="../Renderer/custom/javascripts/common_functions.js"></script>
<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />

<script language="javascript">
var acctId = '<%=acctId%>' ;
var entityId = '<%=entityId%>' ;
var solId = '<%=solId%>' ;
var crncyCode = '<%=crncyCode%>' ;
var acctName = '<%=acctName%>' ;
var ledgerBal = '<%=ledgerBal%>' ;
var availableBal = '<%=availableBal%>' ;
var effAvailableBal = '<%=effAvailableBal%>' ;
var shadowBal = '<%=shadowBal%>' ;
var acctStatus = '<%=acctStatus%>' ;
var freezeStatus = '<%=freezeStatus%>' ;
var freezeReasonCode = '<%=freezeReasonCode%>' ;
var acctClosed = '<%=acctClosed%>' ;

fnPrintAcctBal();

function fnPrintAcctBal(){
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
        write('<td class="textlabel">Account ID</td>');
        write('<td class="textfielddisplaylabel">'+acctId+'</td>');
	write('<td class="textlabel">Account Name</td>');
        write('<td class="textfielddisplaylabel">'+acctName+'</td>');
        write('</tr>');

	write('<tr>');
        write('<td class="textlabel">Entity Id</td>');
        write('<td class="textfielddisplaylabel">'+entityId+'</td>');
        write('<td class="textlabel">Sol Id / CCY</td>');
        write('<td class="textfielddisplaylabel">'+solId+' / ' +crncyCode+'</td>');
        write('</tr>');

        write('<tr>');
        write('<td class="textlabel">Ledger Balance</td>');
        write('<td class="textfielddisplaylabel">'+ledgerBal+'</td>');
        write('<td class="textlabel">Available Balance</td>');
        write('<td class="textfielddisplaylabel">'+availableBal+'</td>');
        write('</tr>');

        write('<tr>');
        write('<td class="textlabel">Effective Available Balance</td>');
        write('<td class="textfielddisplaylabel">'+effAvailableBal+'</td>');
        write('<td class="textlabel">Shadow Balance</td>');
        write('<td class="textfielddisplaylabel">'+shadowBal+'</td>');
        write('</tr>');

        write('<tr>');
        write('<td class="textlabel">Account Status</td>');
        write('<td class="textfielddisplaylabel">'+acctStatus+'</td>');
        write('<td class="textlabel">Freeze Status</td>');
        write('<td class="textfielddisplaylabel">'+freezeStatus+'</td>');
        write('</tr>');

	write('<tr>');
        write('<td class="textlabel">Account Closed</td>');
        write('<td class="textfielddisplaylabel">'+acctClosed+'</td>');
        write('<td class="textlabel">Freeze Reason Code</td>');
        write('<td class="textfielddisplaylabel">'+freezeReasonCode+'</td>');
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
