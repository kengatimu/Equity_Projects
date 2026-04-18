<%@ include file="../commonInclude.jsp" %>

<arjsp:init groupName="custom" isEntryPoint="false" />
<custom:getRepository />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>Sample File</title> 
<custom:mbuild/>

<script language="javascript">
var frm;
function fnLoad()
{
	frm = document.forms[0];
	getCustomFieldValue("fld1");
}

function fnValidateForm()
{
	setCustomFieldValue("fld1");
	return true;
}

function fnOnButtonClick(obj)
{
	if (!fnValidateForm())
		return false;

	frm.submitform.value = obj.id;
	frm.submit();
}

</script>	
</head>

<body class="cbody" onLoad="fnLoad();">
<form method="post" action="../custom/custom_ctrl.jsp">
<span class="cform">
<%@ include file="../../javascripts/appl_inc.js" %>
<%@ include file="../../javascripts/header.js" %>

<table class="htable" cellspacing="0" cellpadding="0">
  <tr>
  	<td colspan="4" class="bcaptionw">&nbsp;Customer Master Maintenance&nbsp;</td>
   </tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td></tr>
</table>

<%@ include file="../javascripts/customtab.js" %>

<table class="ctable" cellspacing="0" cellpadding="0">
<tr>
<td class="ctext">This is sample file. </td>
<td><input type="text" id="fld1" name="fld1"></td></tr>
</table>

<input type="hidden" name="pagename" value="tab2det">
<input type="hidden" id="submitform" name="submitform">
<input type="hidden" name="customData" value="<%=session.getAttribute("custdata")%>">
</span>

<div align="center">
<input type="button" class="button" id="Submit" value="Submit" onClick="fnOnButtonClick(this)">
<input type="button" class="button" id="Cancel" value="Cancel" onClick="fnOnButtonClick(this)">
</div>

</form>
</body>
</html>

