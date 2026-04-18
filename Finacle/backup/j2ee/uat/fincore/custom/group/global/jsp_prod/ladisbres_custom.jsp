<%--
#--------------------------------------------------------------------------------------------
#--Source Name           : ladisbres_custom.jsp
#--Author                : Bharath Reddy B
#--Date                  : 31-03-2013
#--Title                 : 
#--Description           : Custom file to display charge tran id in frontend
#
#--<Serial No.>  <Date>         <Author Name>           <Description>
#--0.00a         31-03-2013     Bharath Reddy B        	Original Version
#--0.00a         03-08-2013	Bharath			Modified for TOL 364952
#--------------------------------------------------------------------------------------------
--%>

<%@ page import="com.infy.bbu.ons.util.FinAppMiscInfo" %>
<%@ page import="com.infy.bbu.ons.common.CommonConstants" %>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="ladisb" isEntryPoint="false" />

<%-- Display Tran ID generated after custom charge collection --%>
<script language="javascript" src="../Renderer/custom/javascripts/session.js"> </script>
<script type = "text/javascript">
document.write('<input type="hidden" name="tranId" id="tranId"  value="">');
document.write('<input type="hidden" name="tranMsg" id="tranMsg"  value="">');
document.write('<input type="hidden" name="tranId1" id="tranId1"  value="">');
var func = ""

if(mopId == "HLADISB" )
{
	var tranId = "";
	var custData = document.forms[0].customData.value;
	if ( custData.length != 0 )
	{
		getFieldsFromCustomData("tranId","tranMsg");
	}
	var tranId = document.forms[0].tranId.value;
	var tranMsg = document.forms[0].tranMsg.value;
	var tranId1 = "";
	if(tranId1 == "")
	{
		var retVal = appFnExecuteScript("", "tranId|tranId1", "laadisbdp015.scr", false);
		var ret = retVal.split("|");
		tranId1 = ret[1];
	}
	if(tranId == "" )
	{
		var retVal = appFnExecuteScript("", "tranId|tranId1", "laadisbdp012.scr", false);
		var ret = retVal.split("|");
		tranId = ret[1];
	}

		LaAcctNum = getSValue("LaAcctNum");
		//alert("Account Number: " +LaAcctNum );
		if((LaAcctNum != null ) || (LaAcctNum != undefined))
		{
			var inputNameValues    = "loanForacid|"+LaAcctNum;
			var outputNames		= "";
			var scrName		= "ast0057mn002.scr";
			var retVal		= appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			if( ret[0] == "Error" && ret[1] != "dummy" )
			{
				alert(ret[1]);
			}
		}

	if(tranId != "" )
	{
		document.write("<br>")
		document.write('<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="ctable">')
		document.write('<TR>')
		document.write('<td>')
		document.write('<TABLE width="100%" class="tableborder" border="0" cellspacing="0" cellpadding="0">')
		document.write('<TR>')
		document.write('<td colspan="2">')
		document.write('<TABLE width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">')
		document.write('<tr><td>&nbsp;</td></tr>')
		document.write('<tr><td>')
		document.write('<TABLE width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">')
		document.write('<TR>')
		document.write('<td width="3%">');
		document.write('<img class="img" src="../Renderer/images/' + applangcode + '/info.gif" width="29" height="29" align="right" border="0">');
		document.write('</img></td>');
		document.write('<TD align="left"> <font color="black">'+tranMsg+' Transcation & charges collected successfully Transaction ID: ' + tranId + '</font>')
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
	if( (tranId1 != undefined) && (tranId1 != "" ))
	{
		document.write("<br>")
		document.write('<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="ctable">')
		document.write('<TR>')
		document.write('<td>')
		document.write('<TABLE width="100%" class="tableborder" border="0" cellspacing="0" cellpadding="0">')
		document.write('<TR>')
		document.write('<td colspan="2">')
		document.write('<TABLE width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">')
		document.write('<tr><td>&nbsp;</td></tr>')
		document.write('<tr><td>')
		document.write('<TABLE width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">')
		document.write('<TR>')
		document.write('<td width="3%">');
		document.write('<img class="img" src="../Renderer/images/' + applangcode + '/info.gif" width="29" height="29" align="right" border="0">');
		document.write('</img></td>');
		document.write('<TD align="left"> <font color="black">  Gross Disbursement done successfully.Transaction Id is ' + tranId1 + '</font>')
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
