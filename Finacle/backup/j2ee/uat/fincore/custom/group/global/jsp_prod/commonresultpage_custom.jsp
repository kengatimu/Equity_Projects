<%-- getting the values from the arjsp object --%>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="arjspmorph" isEntryPoint="false" />
<%@ page import="com.infy.bbu.ons.util.FinAppMiscInfo" %>
<%@ page import="com.infy.bbu.ons.common.CommonConstants" %>
<script language="javascript" src="../Renderer/custom/javascripts/session.js"> </script>
<%
	String sMsg = (String)ARJspCurr.getInputWithGroup("RESULT_MSG",null);
%>

<%-- Getting the value from the session --%>
<%
String [] custData = (String [])ARJspCurr.getInput(com.infy.bbu.ons.common.CommonConstants.KEY_CUSTOM_DATA, null);
if(custData == null) 
{
	custData = new String[1];
	custData[0] = "";
}
%>


<script type="text/javascript">

/*if(mopId== "HSALPAY") {
var argsVariable = "<%=sMsg%>";
var url="../custom/jsp/salpaymn001.jsp?trandeatail='" + argsVariable + "'";
url = url + "&headCtxSol="+headCtxSol
var answer = window.showModalDialog(url,argsVariable, "dialogWidth:400px; dialogHeight:300px; center:yes");
}*/

function commonresultpage_post_ONLOAD(){
	if(mopId == "HSALPAY")
	{
	var tiltSpl1 = "<%=custData[0]%>";
	var tiltSpl = tiltSpl1.split("~");
	for (var i = 0; i < tiltSpl.length; i++)
	{
		if(tiltSpl[i].substring(0,16) == "commonresultpage")
		{
			if(tiltSpl[i] != "")
			{
				var message = tiltSpl[i].split('|');
				for (var j = 1; j < message.length; j++)
				{
					if(message[j] != "")
					{
						alert(message[j]);
					}	
				}
			}
		}
	}
	}
}

if(mopId == "HCBSU") {
    var cbsuCustData = "<%=custData[0]%>";
    var cbsuRetVal = cbsuCustData.split("|");
    var cbsuTrnId = cbsuRetVal[1];
    if((cbsuTrnId != "") && (cbsuTrnId != undefined))
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
            document.write('<TD align="left"> <font color="black">Registeration Charge Transaction ID: ' + cbsuTrnId + '</font>')
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

if(mopId== "HPORDM")
{
	var custData = "<%=custData[0]%>";
	var retVal = custData.split("|");
	var trnId = retVal[1];
	var trmDate = retVal[2];
	var funcCode2 = getSValue("funcCode2");
	if(funcCode2 == "V")
	{
		if(trnId != "" &&   retVal!="")
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
			document.write('<TD align="left"> <font color="black">Payment Order created with Transaction ID: ' + trnId + '</font>')
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
}
</script>
