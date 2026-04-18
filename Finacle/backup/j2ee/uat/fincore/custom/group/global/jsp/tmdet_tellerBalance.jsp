<%/*---------------------------------------------------------------------------------------
NAME                :   tmdet_tellerBalance.jsp
Menu                :   HTM,HCASHDEP,HCASHWD
Called JSP          :   None
Called Script       :   None
Calling JS			:   tmdet_custom_link.js
Description         :   This jsp is used for displaying Teller Balance Details
Author              :   Kalvin Joseph
Date                :   18-JUL-2013
Module              :   TMDET
Modification History:

<Serial No.>     <Date>         <Author Name>           <Description>
-------------   ---------       ------------------      ----------------
1               18-07-2013      Kalvin Joseph	       Base Version
-------------------------------------------------------------------------------------*/%>
<%@ page contentType="text/html; charset=utf-8" %>
<%!
        public static final String _ARJSP_JSP_NAME = "custom/tmdet_tellerBalance.jsp";
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

    String ccy = request.getParameter("ccy");
	String ccyDesc = request.getParameter("ccyDesc");
	String cashAc = request.getParameter("cashAc");
	String tellerBalance = request.getParameter("tellerBalance");
	String drCr = request.getParameter("drCr");
	String futurePos = request.getParameter("futurePos");
	String drCr1 = request.getParameter("drCr1");
	
	
%>

<html>
<head>

<% if (null != sBaseHref) { %>
<base href="<%=sBaseHref+"/finbranch/custom/"%>">
<% } %>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>Teller balance Details</title>
<script language="javascript" src="../Renderer/custom/javascripts/common_functions.js"></script>
<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />



<script language="javascript">
var ccy = '<%=ccy%>' ;
var ccyDesc = '<%=ccyDesc%>' ;
var cashAc=  '<%=cashAc%>' ;
var tellerBalance = '<%=tellerBalance%>' ;
var drCr =  '<%=drCr%>' ;
var futurePos =  '<%=futurePos%>' ;
var drCr1 =  '<%=drCr1%>' ;




fnPrintTellerBal();

function fnPrintTellerBal(){
        with (document){
        write('<!-- HEADERBLOCK-BEGIN -->');
        write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
        write('<tr>');
        write('<td>');
        write('<table border="0" cellspacing="0" cellpadding="0">');
        write('<tr>');
        write('<td class="page-heading">Teller Balance Details</td>');
        write('</tr>');
	write('<tr>');
	write('</tr>');
	write('<tr>');
	 write('</tr>');
        write('</table>');
        write('<table border="0" colspan="5" cellpadding="0" cellspacing="0" width="100%">');
        write('<!-- HEADERBLOCK-END -->');

        write('<!-- DETAILSBLOCK-BEGIN -->');
        write('<table border="3" cellpadding="3" cellspacing="3" width="100%">');
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
		
       	write('<td class="textlabel">CCY</td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="textlabel">:  </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="textfielddisplaylabel">'+ccy+'</td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('</tr>');

		write('<td class="textlabel">CCY Description</td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="textlabel">:  </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="columnwidth">&nbsp; </td>');
        write('<td class="textfielddisplaylabel">'+ccyDesc+'</td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('</tr>');

		write('<td class="textlabel">Cash A/c.</td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="textlabel">:  </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="textfielddisplaylabel">'+cashAc+'</td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('</tr>');

		write('<td class="textlabel">Teller Balance</td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="textlabel">:  </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="textfielddisplaylabel">'+tellerBalance+'</td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('</tr>');

		write('<td class="textlabel">Debit/Credit</td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="textlabel">:  </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="textfielddisplaylabel">'+drCr+'</td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('</tr>');

		write('<td class="textlabel">Future Position</td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="textlabel">:  </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="textfielddisplaylabel">'+futurePos+'</td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('</tr>');

		write('<td class="textlabel">Debit/Credit</td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="textlabel">:  </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="columnwidth">&nbsp; </td>');
		write('<td class="textfielddisplaylabel">'+drCr1+'</td>');
		write('<td class="columnwidth">&nbsp; </td>');
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
