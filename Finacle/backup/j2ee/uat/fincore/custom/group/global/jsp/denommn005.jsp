<%
/*-----------------------------------------------------------------------------------------
   NAME			:   denommn005.jsp 
   Calling Jsp	:   None 
   Called JSP	:   None
   Called Script:   denomdp007.scr 
   Description	:   This JSP receives details for for currency exchange in same currency
					from user and submits it to backend for performing transaction.
   Menu Option  :   HCASHX
   Author		:   Sandeep Patil
   Module Code	:	DENOM

   Modification History:	
   ====================
				
   Serial No.	DATE		Author			Description							
------------------------------------------------------------------------------------------*/
%>
<%!
	public static final String _ARJSP_JSP_NAME = "/custom/denommn005.jsp";
%>
<%@ include file="../commonInclude.jsp" %>
<%@page contentType="text/html; charset=utf-8" %>
<jsp:useBean id="customBeanInst" class="com.infy.finbranch.groups.customBean" scope="session" />
<arjsp:init groupName="custom" isEntryPoint="true" />
<%
        fabclasses.FinSessionInit sessInit;
        synchronized(session) {
                sessInit = (fabclasses.FinSessionInit) session.getAttribute("FinSessionInit");
                if (sessInit == null) {
                        sessInit = (fabclasses.FinSessionInit)CustomMapper.fetchClassInstance("fabclasses.FinSessionInit");
                        session.setAttribute("FinSessionInit", sessInit);
                }
        }
        String sNextPage = null;
        String outErrorPage[] = new String[1];
        boolean isInitSuccessful = true;

        if(sessInit.InitializeSession(pageContext, ARJspCurr, outErrorPage) != 0)
        {
                sNextPage = outErrorPage[0] != null ? outErrorPage[0] : "../arjspmorph/error_page.jsp";
                isInitSuccessful = false;
        }

        if(isInitSuccessful)
        {
		customBeanInst.Refresh(pageContext, ARJspCurr, ARJspRet);
		customBeanInst.populateFields(finbranch, PropertyManager.getProperties(session), ResourceManager.getResourceBundle(pageContext, "finbranch"));
	}
%>
<%
	//Initialising the ContextManager for ARJspCurr repository
	ContextManager custARJspCurr = (ContextManager) session.getAttribute("CustomARJspCurr");
	session.setAttribute("groupName","custom");
%>

<custom:getRepository/>
<%
        String sProcRequestRet = null;
        String sFirstAccess    = (String)ARJspRep.getVal("IsFirstAccess");
        if (sFirstAccess == null)
        {
			ARJspRep.setVal("IsFirstAccess", "NO");
        }
%>
<%
String applangcode = (String)session.getAttribute("applangcode");
String sDummy	= (request.getParameter("sDummy")!=null)?request.getParameter("sDummy"):"";
String sTranId	= "";
String sParam[] = new String[10];
String sValues[] = new String[10];
String sMessage = "";
String sDetails = "";
%>
<%
	TreeMap denomTM = new TreeMap();
	ARJspCurr.setInput("denomTM",denomTM);
	if(request.getParameter("PressAccept") != null)
    {
		String sAppNextPage = customBeanInst.getNextPage();

		sParam[0]       =   "Message";
		sParam[1]	    =   "Details";
		sValues			=   customBeanInst.getCustOutData(sParam);
		sMessage	    =   sValues[0];
		sDetails	    =   sValues[1];
	}
if(sMessage.equals("ERROR"))
{
%>
<script>alert("Error: Please re-create the transaction");
return false;
</script>
<%
}
%>
<HTML>
<META http-equiv="Content-Type" content="text/html;charset=utf-8">
<HEAD>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("resource_functions.js",sProfileId)%>"> </script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("array.js",sProfileId)%>" type="text/javascript"></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_denom_functions.js",sProfileId)%>"> </script> 
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_common_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("hotkeydata_link.js",sProfileId)%>"> </script>
<TITLE>CASH EXCHANGE</TITLE>

<SCRIPT>

/* ON LOAD OF THIS PAGE */

function fnOnLoad()
{	
	var frm = document.forms[0];
	frm.acctCrncy.focus();
}

/* ON PRESSING THE CLEAR BUTTON */

function fnRefresh()
{
	if(confirm("Going back would result in loss of all data"))
	{
		document.forms[0].action   =   "jsp/denommn005.jsp";
   		document.forms[0].submit();
	}
}

/* CHECKING SPECIAL CHARACTERS IN THE CURRENCY CODE FIELDS */

function fnchk_invld_chr(obj)
{
	    var iChars = "!~@`#$&*()+=[]\\\';,/{}|\":<>?.%-^_";
        var iFlag1  = 0;
        var value = obj.value;
        for (var j = 0; j < value.length; j++)
        {
			if (iChars.indexOf(value.charAt(j)) != -1)
        	{
				 alert("Special characters are not allowed");
				 obj.focus();
				 return 0;
             }
       }
	return false;
}
		
/* CHECKING FOR THE VALIDITY OF THE CURRENCY CODE FIELD : CURRENCY */

function fnvalidate_acctcrncy(obj)
{
	document.forms[0].receivedAmt.value="";
	document.forms[0].CurrencyDesc.value="";
	if(obj == document.forms[0].acctCrncy)
	{
		//fnchk_invld_chr(obj);
		var acctCrncy = document.forms[0].acctCrncy.value;
		var scrName = "denomdp020.scr";
		var CrncyCode = obj.value;
		var outputNames = "";
		var inputNameValues = "CrncyCode|"+CrncyCode;
		var retVal = cust_fnExecuteScript(inputNameValues,outputNames, scrName, false);
		var values = retVal.split("|");
		if(values[0] == "Success")
		{
			return true;
		}
		else
		{
			alert(values[1]);
			document.forms[0].acctCrncy.value="";
			document.forms[0].acctCrncy.focus();
			return false;
		}
	}
}


/* CHECKING FOR SPECIAL CHARACTERS IN AMOUNT RECEIVED FIELD,PAY BACK & GET BACK AMOUNT FIELDS */

function fnchk_invld_chr_amt(obj)
{
	var iChars = "!~@`#$&*()+=[]\\\';/{}|\":<>?%^_";
    var iFlag1  = 0;
    var value = obj.value;
    for (var j = 0; j < value.length; j++)
    {
		if (iChars.indexOf(value.charAt(j)) != -1)
        {
			alert("Special characters not allowed");
            obj.focus();
            return 0;
         }
      }
	return false;
}

/* VALIDATING THE AMOUNT RECEIVED FIELD */

function fnvalidate_received(obj)
{
	var receivedamt = removeCommas(document.forms[0].receivedAmt.value);
	//fnchk_invld_chr_amt(obj);
		receivedAmt = obj.value;
		if(receivedAmt < 0)
		{
			alert("Enter a positive value for the 'Amount received' field");
			document.forms[0].receivedAmt.focus();
			return;
		}
	javascript:newformatAmt('MILLION',document.forms[0].receivedAmt,document.forms[0].acctCrncy.value,'N');
}


/* ON PRESS OF SUBMIT BUTTON */	

function fnAccept()
{
	javascript:cust_convertToCaps()
	var receivedamt = removeCommas(document.forms[0].receivedAmt.value);
	var refCrncys	= document.forms[0].acctCrncy.value + "@" + document.forms[0].acctCrncy.value;
	var refAmts		= document.forms[0].receivedAmt.value + "@" + document.forms[0].receivedAmt.value;

	/* VALIDATE IF ANY OF THE MANDATORY FIELDS IS LEFT UNENTERED */

	if(document.forms[0].acctCrncy.value == "")
	{
		alert("Currency code field must be entered");
		document.forms[0].acctCrncy.focus();
		return false;
	}
 	if(document.forms[0].receivedAmt.value == "")
	{
		alert("Amount field must be entered");
		document.forms[0].receivedAmt.focus();
		return false;
	}
	
	var retVal = cust_fndenompopup("A","C","CR","",refCrncys,refAmts,"C@D","","","C","N@Y","tm");
	if(retVal == "cancel" || retVal == false)
	{
		return false;
	}
	else
	{
		document.forms[0].RetVal.value = retVal;
	}
	var receivedamt = removeCommas(document.forms[0].receivedAmt.value);
	document.forms[0].receivedAmt.value = receivedamt; 
	var acctCrncy = document.forms[0].acctCrncy.value;
	var inputNameValues = "acctCrncy|"+acctCrncy
		+"|receivedAmt|"+receivedamt;
	var outputNames = "";
	var scrName;
	var crncy1 = document.forms[0].acctCrncy;
	if(fnvalidate_acctcrncy(crncy1))
	{
		document.forms[0].action   =  "jsp/denommn005.jsp?PressAccept=Y";
		document.forms[0].submit();
	}
}

</SCRIPT>
</HEAD>
<custom:mbuild/>

<BODY class="cbody" onload="javascript:fnOnLoad();" onKeyDown="fnKeyDownProcessor(window.event)">
<FORM name="form1" class="cform" method="post" onLoad="fnOnLoad();">
<%@ include file="../javascripts/appl_inc.js" %>
<%@ include file="../javascripts/header.js" %>
<SPAN class="cform">

<TABLE class="ctable">
	<TR> <TD class="page-heading">Cash Exchange Screen For Same Currency</TD> </TR>
<%	if(sMessage.equals("Success")) {
		out.println("<tr><td style=\"color:red\">Tran id generated : " + sDetails + "</td></tr>");}
		if(sMessage.equals("Failure")) {
		out.println(sDetails);}
%>
</TABLE>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">
<tr>
<td>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td valign="top">
</td>
</tr>
<tr>
<td>
<div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
<tr>
<td>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop1">
<tr>
<td class=""><spacer type="block" height=1 width=1></spacer></td>
<td class=""><spacer type="block" height=1 width=1></spacer></td>
<td class=""><spacer type="block" height=1 width=1></spacer></td>
<td class=""><spacer type="block" height=1 width=1></spacer></td>

<td align="right">
	<a href="javascript:showHelpFile('hcashx_det_help.htm');">
	<img class="img" align="right" src="../Renderer/images/help.gif" width="47" height="21"  vspace="1" border="0"></img></a>
	</td>
</tr>
<!-- FIELDS ON SCREEN HERE -->

<TR class="rowspacing">
	<TD class="textlabel">
	 Currency
	</TD>
	<TD> 
		<INPUT type="text" class="textfieldfont" hotKeyId="search1" size="30" name="custom.acctCrncy" id="acctCrncy" maxlength="3" onChange="fnvalidate_acctcrncy(this)"onkeypress="fnchk_invld_chr(this)">
		<A id=sLnk1 href="javascript:cust_showCurrencyList(document.forms[0].acctCrncy);" target=_self>
		<IMG height=17 src="../Renderer/images/search_icon.gif" hotKeyId="search1" width=16 border=0></IMG></a>
		<input class="label" id="CurrencyDesc"  name="custom.CurrencyDesc" size="21" maxlength="50" readonly>&nbsp;
	</TD>

<TR class="rowspacing">
	<TD class="textlabel">
		Amount received
	</TD>
	<TD> 
		<INPUT type="text" class="textfieldfont" size="30" name="custom.receivedAmt" id="receivedAmt" onBlur="fnvalidate_received(this)"onkeypress="fnchk_invld_chr_amt(this)">
	</TD>
</TR>

<!-- FIELDS ON SCREEN ENDS HERE -->

</TABLE>
</TABLE>
</TABLE>
</td>
</tr>
</TABLE>
</TABLE>
</TABLE>
</SPAN>
<!-- BUTTONS -->

<DIV class="ctable">
	 <TR class="page-heading">
		<TD width=10%></TD>
		<TD width=10%>
			<INPUT type="button" class="button1" value="Go" name="Go" hotKeyId="Go" onclick="fnAccept();">
		</TD>
		<TD width=15%>
			<INPUT type="button" class="button1" value="Clear" hotKeyId="Cancel" name="Cancel" onclick ="fnRefresh();">
		</TD>
	</TR>
</DIV>

<!-- HIDDEN FIELDS -->

<INPUT type="Hidden" name="submitform" value="Submit">
<INPUT type="Hidden" name="pagename" value="jsp/denommn005.jsp">
<INPUT type="Hidden" name="scrName" value="denomdp007.scr" >	
<INPUT type="Hidden" name="custom.CashExchange" value="S" >
<INPUT type="Hidden" name="custom.RetVal" id="RetVal" value="">	
</FORM>
</BODY>
</HTML>


