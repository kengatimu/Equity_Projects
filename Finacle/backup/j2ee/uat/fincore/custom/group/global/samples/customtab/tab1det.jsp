<%@ include file="../commonInclude.jsp" %>

<%@ page import="customUtil.customFunctions,com.infy.finbranch.groups.customBean, java.util.HashMap" %>

<arjsp:init groupName="custom" isEntryPoint="false" />
<custom:getRepository />

<%
    String llName       = "solIdList";
    String recVal       = "";
    String customData   = "";
    boolean isNewRec    = false;
    HashMap hm      = (HashMap)ARJspRep.getVal(llName);

    if (hm == null)
    {
        /*
            This case will come into picture when the LinkList
            is fetched from the NAPI Service.
        */
        customData = customBean.getCustomData(session);

        hm = customFunctions.getListFromCustData(llName,customData);
        if (hm == null)
            isNewRec = true;
        else
        {
            ARJspRep.setVal(llName, hm);
            ARJspRep.setVal(llName + "_RecNum", "1");
            recVal = (String)hm.get("1");
        }
    }
    else
    {
        int recNum = Integer.parseInt((String)ARJspRep.getVal(llName + "_RecNum"));
        if (recNum > hm.size())
            isNewRec = true;
        else
            recVal = (String)hm.get(String.valueOf(recNum));
    }
%>

<html>
<head>
<title>Sample File</title>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js"></script>

<custom:mbuild/>

<script language="javascript">
var frm;
var isNewRec = <%=isNewRec%>;
var recVal = '<%=recVal%>';
function fnLoad()
{
	frm = document.forms[0];
	getCustomFieldValue("statfld1","statfld2");
    if (isNewRec)
        return true;

    if (recVal != "") {
        var values = recVal.split("|");
        frm.customerName.value = values[0];
        frm.desigCode.value = values[1];
    }

    return true;
}

function fnValidateForm()
{
    if (frm.customerName.value == "")
    {
        alert("Field must be entered.");
        frm.customerName.focus();
        return false;
    }
	return true;
}

function fnOnButtonClick(obj)
{
	if (!fnValidateForm())
		return false;

	setCustomFieldValue("statfld1","statfld2");
	if (obj.id == 'prev' || obj.id == 'next')
	{
		frm.submitform.value = "MULTIRECNAVIGATION";
		frm.direction.value = obj.id;
	}
	else
	{
		frm.submitform.value = obj.id;
	}
	
	frm.submit();
    return true;
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

<table class="htable" cellspacing="0" cellpadding="0">
<tr class="ccaption"><td colspan="1">&nbsp;Static Data&nbsp;</td>
</tr></table>

<table class="ctable">
<tr>
    <td class="ctext" >&nbsp;Static Field1 &nbsp;</td>
    <td><input type="text" class="text" name="statfld1" id="statfld1" size="5" maxlength="5"></td>

    <td class="ctext" >&nbsp;Static Field2 &nbsp;</td>
    <td><input type="text" class="text" name="statfld2" id="statfld2" size="5" maxlength="5"></td>
</tr>
</table>

<table class="htable" cellspacing="0" cellpadding="0">
<tr class="ccaption"><td colspan="1">&nbsp;Custom Multi Rec&nbsp;</td>
</tr></table>

<table class="ctable">
<tr>
    <td class="ctext" >&nbsp;Customer Name &nbsp;</td>
    <td><input type="text" class="text" name="customerName" id="customerName" size="5" maxlength="5"></td>

    <td class="ctext" >&nbsp;Description code&nbsp;</td>
    <td><input type="text" class="text" name="desigCode" id="desigCode" size="5" maxlength="5"></td>
</tr>

<tr>
<td colspan="5">
<input type="button" class="button" id="prev" value="prev" class="button" onclick="javascript:return fnOnButtonClick(this);"></td>

<td>
<input type="button" class="button" id="next" value="next" class="button" onclick="javascript:return fnOnButtonClick(this);"></td>
</tr></table>

</span>

<input type="hidden" name="CUST_LLNAME" value="solIdList">
<input type="hidden" id="direction" name="solIdList_DIRECTION" value="">
<input type="hidden" name="pagename" value="tab1det">
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

