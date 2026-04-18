<%@ page import="customUtil.customFunctions,com.infy.finbranch.groups.customBean, java.util.HashMap" %>

<%@ taglib uri="custom.tld" prefix="custom" %>
<custom:getRepository/>

<%--
	This section is to show the Multi-rec Fields values during the
	click of prev and next button.
--%>

<%
	String llName 		= "solIdList";
	String recVal 		= "";
	String customData	= "";
	boolean isNewRec	= false;
	HashMap	hm		= (HashMap)ARJspRep.getVal(llName);

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

<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js"></script>

<script language="javascript">

var isNewRec = <%=isNewRec%>;
var recVal = '<%=recVal%>';

function cust_per_post_ONLOAD()
{
	getCustomFieldValue("statfld1","statfld2");
	alert("customdata "+document.forms[0].customData.value);
	if (isNewRec)
		return true;

	var frm = document.forms[0];
	if (recVal != "") {
		var values = recVal.split("|");
		frm.customerName.value = values[0];
		frm.desigCode.value = values[1];
	}

	return true;
}

function fnClick(btnObj)
{
	var frm = document.forms[0];
	if (cust_fnIsNull(frm.customerName.value))
	{
		alert("Field must be entered.");
		frm.customerName.focus();
		return false;
	}
	
	frm.submitform.value = "MULTIRECNAVIGATION";
	frm.direction.value = btnObj.id;
	frm.submit();

	return true;
}

function fnClick1(btnObj)
{
	setCustomFieldValue("statfld1","statfld2");
	alert("customdata "+document.forms[0].customData.value);
	return true;
}

</script>

<span class="cform">

<table class="htable" cellspacing="0" cellpadding="0">
<tr class="ccaption"><td colspan="1">&nbsp;Custom Data&nbsp;</td>
</tr></table>

<table class="ctable">
<tr>
	<td class="ctext" >&nbsp;customerName &nbsp;</td>
	<td><input type="text" class="text" name="customerName" id="customerName" size="5" maxlength="5"></td>

	<td class="ctext" >&nbsp;Description code&nbsp;</td>
	<td><input type="text" class="text" name="desigCode" id="desigCode" size="5" maxlength="5"></td>
</tr>
<tr>
	<td class="ctext" >&nbsp;Static Field1 &nbsp;</td>
	<td><input type="text" class="text" name="statfld1" id="statfld1" size="5" maxlength="5" onchange="javascript:return fnClick1(this);"></td>

	<td class="ctext" >&nbsp;Static Field2 &nbsp;</td>
	<td><input type="text" class="text" name="statfld2" id="statfld2" size="5" maxlength="5" onchange="javascript:return fnClick1(this);"></td>
</tr>

<tr>
<td colspan="5">
<input type="button" class="button" id="prev" value="prev" class="button" onclick="javascript:return fnClick(this);"></td>

<td>
<input type="button" class="button" id="next" value="next" class="button" onclick="javascript:return fnClick(this);"></td> 
</tr></table>

</span>

<input type="hidden" name="CUST_LLNAME" value="solIdList">
<input type="hidden" id="direction" name="solIdList_DIRECTION" value="">
