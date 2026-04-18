<!---------------------------------------------------------------------------------------------------------------->
<!--Name		: laadisbdp002.jsp
<!--Description		: This jsp is used to populate a new popup window
<!--Date		: 31-03-2013
<!--Author		: Sourabh
<!--Called By		: ladisbdet_custom.jsp
<!--Calling jsp		: None
<!--Menu Option		: HTM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            31-03-2013           Sourabh           Original version
<!---------------------------------------------------------------------------------------------------------------->

<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="ladisb" isEntryPoint="false" />
<%@ include file='../commonInclude.jsp'%>

<%
         String sProfileId   = ProfilesManager.getProfileInSession(session);
%>

<%
String acctNum=request.getParameter("loanAcctId")!=null?request.getParameter("loanAcctId"):"";
String amt=request.getParameter("amt");
String laceAmt=request.getParameter("laceAmt");
String insuAmt=request.getParameter("insuAmt");
String contribution=request.getParameter("contribution");
%>
<html>
<head>
<TITLE>Stima Loan </TITLE>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_common_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("common_functions.js",sProfileId)%>"></script>
<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />
<script type="text/javascript">
function sendValues(obj) 
{
	var refNum	= document.forms[0].refNum.value;
	var Name	= document.forms[0].Name.value;
	var loanAmt	= document.forms[0].loanAmt.value;
	var proFee	= document.forms[0].proFee.value;
	var insFee	= document.forms[0].insFee.value;
	var contbtn	= document.forms[0].contbtn.value;
	
	
	if( refNum == "" )
		{
			alert("KPLC Quotation Reference Number must be entered.....");
			document.forms[0].refNum.focus();
			return false;
		}
		else
		{
			var refNumSub =(document.forms[0].refNum.value).substring(0,1).toUpperCase();
			var refNumLen	= refNum.length;
			if ((refNumSub!='A') && (refNumSub!='E') && (refNumSub!='I') && (refNumSub!='M') && (refNumSub!='P') && (refNumSub!='S') && (refNumSub!='T')) 
				{
					alert("Invalid KPLC Quotation Reference Number....Kindly key in number as per the Quotation");
					document.forms[0].refNum.focus();
					return false;
				}
				else
				{
					if(refNumLen != 15)
					{
						alert("Invalid KPLC Quotation Reference Number.Reference No should be of 15 charectors");
						document.forms[0].refNum.focus();
						return false;
					}
				}
		}
	//The following step is to Name fields
		if( Name == "" )
		{
			alert("Please Enter the customer name ..as per the Quotation");
			document.forms[0].Name.focus();
			return false;
		}

		
	sendObj={refNum:document.forms[0].refNum.value,Name:document.forms[0].Name.value,
	loanAmt:document.forms[0].loanAmt.value,proFee:document.forms[0].proFee.value,
	insFee:document.forms[0].insFee.value,contbtn:document.forms[0].contbtn.value};
	window.returnValue = sendObj;
	window.close();
}

</script>
</head>

<body>
<form name="form1">
<div id="div1"></div>
<br>
<h3>Stima Loan</h3>
<h4>Data Capture Screen</h4>
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
<td class="textlabel">Reference No</td>
<td class="textlabel"><input class="textfieldfont" id="refNum" name="refNum"  size="25"  value="" ></td>
</tr>
<tr>
<td class="textlabel">Name(as per Quotation)</td>
<td class="textlabel"><input class="textfieldfont" id="Name" name="Name" size="25" value=""  ></td>
</tr>
<tr>
<td class="textlabel">Loan Amount</td>
<td class="textlabel"><input class="textfieldfont" id="loanAmt" name="loanAmt" size="25"  value="<%=amt%>"  ></td>
</tr>
<tr>
<td class="textlabel">Processing Fee</td>
<td class="textlabel"><input class="textfieldfont" id="proFee" name="proFee" size="25" value="<%=laceAmt%>"  ></td>
</tr>
<tr>
<td class="textlabel">Insuarance Fee</td>
<td class="textlabel"><input class="textfieldfont" id="insFee" name="insFee" size="25" value="<%=insuAmt%>"  ></td>
</tr>
<tr>
<td class="textlabel">Contribution</td>
<td class="textlabel"><input class="textfieldfont" id="contbtn" name="contbtn" size="25" value="<%=contribution%>"  ></td>
</tr>
</TABLE>
</td>
</tr>
</TABLE>
</td>
</tr>
</TABLE>
<br>
<INPUT TYPE="button"  class="button"  VALUE="Submit" size = 1 onClick = "javascript:sendValues(this);">
<INPUT TYPE="reset"  class="button" VALUE="Clear" size = 1 >
</TABLE>
</td>
</TR>
</form>
</body>
</html>
