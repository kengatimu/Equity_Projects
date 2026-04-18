<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : "cdpspdp001.jsp"
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 21-01-2013
<!--Author              : NAGARJUNA REDDY
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : CDPSP
<!--Modification History:
<!--    Version No.       Date               Author                  Description
<!--    -------         ----------         -----------            ------------------
<!--     0.1            21-01-2013           Nagarjuna Reddy M           Original version
<!---------------------------------------------------------------------------------------------------------------->
<%@ include file="../commonInclude.jsp" %>
<html>
<head>
<TITLE>Pass Sheet Printing</TITLE>
</head>
<%
String noPgs = (String)(request.getParameter("noofpg")!= null?request.getParameter("noofpg"):"");
String pgAmt = (String)(request.getParameter("chrgAmt")!= null?request.getParameter("chrgAmt"):"");
String crgAmt = (String)(request.getParameter("chargeamt")!= null?request.getParameter("chargeamt"):"");
%>
<script type="text/javascript">

function fndoSubmit(obj){
	if(obj.id == "CANCEL") 
	sendObj={status:'F'};
	else
	sendObj={status:'S'};
	window.returnValue = sendObj;
	window.close();
}
</script>
<body>
<form name="form1">
<div name="div1" id="div1">
<br>
<h3> Pass Sheet Printing &nbsp;&nbsp; </h3>
<h4> &nbsp;&nbsp;</h4>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="ctable">
<TR>
<td>
<TABLE width="100%" class="tableborder" border="0" cellspacing="0" cellpadding="0">
<tr>
<td colspan="0">
<TABLE width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">
<tr><td>&nbsp;</td></tr>
<tr>
<td>
<TABLE width="50%" border="0" cellpadding="0" cellspacing="0" class="ctable">
<tr>
<td class="textlabel">Number of Pages for Printing:  <%=noPgs%></td>
</tr>
<tr>
<td class="textlabel"> The Charge amount per page for Printing :  <%=pgAmt%></td>
</tr>
<tr>
<td class="textlabel"> The Charge amount for Pass Sheet Printing :  <%=crgAmt%></td>
</tr>

</TABLE>
</td>
</tr>
</TABLE>
</td>
</tr>
</TABLE>
</div>
<br>
<INPUT TYPE="button"  class="button"  VALUE="YES" size = 1 onclick="javascript:fndoSubmit(this);">
<INPUT TYPE="button"  class="Button"  id="CANCEL"  value="CANCEL" onClick="javascript:fndoSubmit(this);">
</form>
</body>
</html>
