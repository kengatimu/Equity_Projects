<%@ page import="com.infy.bbu.jsputil.*,FABProcess.*,FABCommon.*,FABInquiry.*,java.util.*, java.lang.*,finbranchUtil.*"%>
<%@ page import="fabclasses.*,FabServer.*,com.infy.bbu.*,applcommon.*" %>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<%
	FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
    if(null == securityInfo)
    {
    	securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
    }
    String sBODDate = (String)((securityInfo.bodDate).substring(0,10));
	
%>
<script type="text/javascript">
var bodDate = '<%=sBODDate%>';
if(mopId == "HPAYOFF")
{
	if(tranId != "")
	{
		document.write("<br>")
		document.write('<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="ctable">')
		document.write('<TR>')
		document.write('<td>')
		document.write('<TABLE width="100%" class="tableborder" border="0" cellspacing="0" cellpadding="0">')
		document.write('<TR>')
		document.write('<td colspan="2">')
		document.write('<TABLE width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">')
		document.write('<tr><td>')
		document.write('<TABLE width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">')
		document.write('<TR>')
		document.write('<td width="3%">');
		document.write('<img class="img" src="../Renderer/images/' + applangcode + '/info.gif" width="29" height="29" align="right" border="0">');
		document.write('</img></td>');
		document.write('<TD align="left"> <font color="black">Payoff Tran Id is ' + tranId + ' and Tran Date is ' + bodDate + '</font>')
		document.write('</b></td>')
		document.write('</TR>')
		document.write('</TABLE>')
		document.write('</TR>')
		document.write('</TABLE>')
		document.write('</TR>')
		document.write('</TABLE>')
		document.write('</TD>')
		document.write('</TR>')
		document.write('</TABLE>')
	}
}
</script>
