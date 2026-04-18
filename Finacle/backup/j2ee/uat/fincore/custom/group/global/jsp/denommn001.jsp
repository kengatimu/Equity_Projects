<%
/*-----------------------------------------------------------------------------------------
 NAME					: denommn001.jsp
 Calling Jsp			: NA
 Called JSP				: None
 Called Script			: denomdp007.scr
 Description			: This JSP receives cross currency exchange details from user and submits it to
						  backend for performing transaction.
 Author					: Castro / Sandeep Patil
 Menu Option			: HCASHDX
 Module Code			: DENOM
 Modification History	:
	<Srl No.>	<Date>			<Author>			<Description>
	0.1			23-JUL-2010		Sandeep Patil		Draft Version
	0.2			11-AUG-2011		Prakash				Modified to include BOP requirement for NA
------------------------------------------------------------------------------------------*/
%>
<%@ include file="../commonInclude.jsp" %>

<%!
        public static final String _ARJSP_JSP_NAME = "/custom/jsp/denommn001.jsp";
%>

<%
        String sGrpName         = ((String)session.getAttribute("groupName")!=null)?(String)session.getAttribute("groupName"):"custom";
%>

<arjsp:init groupName="custom" isEntryPoint="true" />
<jsp:useBean id="customBeanInst" class="com.infy.finbranch.groups.customBean" scope="session" />
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
<custom:getRepository/>
<%
	//Initialising the ContextManager for ARJspCurr repository
	ContextManager custARJspCurr = (ContextManager) session.getAttribute("CustomARJspCurr");
	session.setAttribute("groupName","custom");
%>
<%
	String sProcRequestRet = null;
	String sFirstAccess    = (String)ARJspRep.getVal("IsFirstAccess");
	if (sFirstAccess == null)
	{
//		sProcRequestRet = customBeanInst.procRequest(); 
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
//String sBopRefValue=((request.getParameter("custom.bopRefValue")!=null)?request.getParameter("custom.bopRefValue"):"");
//String sBopFlg = ((request.getParameter("custom.bopFlg")!= null)?request.getParameter("custom.bopFlg"):"");
//String sBopChkFlg=((request.getParameter("custom.bopChkFlg")!=null)?request.getParameter("custom.bopChkFlg"):"");
//String sBopPopFlg=((request.getParameter("custom.bopPopFlg")!=null)?request.getParameter("custom.bopPopFlg"):"");
String sBopRefValue="";
String sBopFlg = "";
String sBopChkFlg = "";
String sBopPopFlg = "";
%>
<%
	if(request.getParameter("PressAccept") != null)
	{
		String sAppNextPage = customBeanInst.getNextPage();
		sParam[0]	= "Message";
		sParam[1]	= "Details";
		sValues		= customBeanInst.getCustOutData(sParam);
		sMessage	= sValues[0];
		sDetails	= sValues[1];
	}
if(sMessage.equals("ERROR"))
{
	sBopRefValue=((request.getParameter("custom.bopRefValue")!=null)?request.getParameter("custom.bopRefValue"):"");
	sBopFlg = ((request.getParameter("custom.bopFlg")!= null)?request.getParameter("custom.bopFlg"):"");
	sBopChkFlg=((request.getParameter("custom.bopChkFlg")!=null)?request.getParameter("custom.bopChkFlg"):"");
	sBopPopFlg=((request.getParameter("custom.bopPopFlg")!=null)?request.getParameter("custom.bopPopFlg"):"");
%>

<script>alert("Error: Please re-create the transaction");
</script>
<%
}
%>
<HTML>
<HEAD>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("resource_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_common_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("array.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_denom_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_advicePrint.js",sProfileId)%>"></script>

<HEAD>
<TITLE>CASH EXCHANGE</TITLE>
<SCRIPT>




function getRateCodeList()
{
	var frm = document.forms[0];
	var oldCode = frm.rateCode.value;
	showRefCode(frm.rateCode,'67','N','B');
}

function fnOnLoad()
{
	document.forms[0].acctCrncy.focus();
	
}


	
function fnRefresh()
{
	if(confirm("Going back would result in loss of all data"))
	{
		document.forms[0].action   =   "jsp/denommn001.jsp";
		document.forms[0].submit();
		document.forms[0].bopRefValue.value = "";
	}
}

/* FUNCTION FOR CHECKING SPECIAL CHARACTERS IN THE CURRENCY CODE FIELDS */
function fnchk_invld_chr(obj)
{
	obj.value = obj.value.toUpperCase();
	var iChars = "!~@`#$&*()+=[]\\\';,/{}|\":<>?.%-^_ ";
	var iFlag1  = 0;
	var value = obj.value;
	for (var j = 0; j < value.length; j++)
	{
		if (iChars.indexOf(value.charAt(j)) != -1)
		{
			alert("Special characters are not allowed");
			obj.value="";
			obj.focus();
			return false;
		}
	}
	
	return true;
}
function fnDfltRC(obj)
{
	var frm = document.forms[0]; 
	if((fnTrim(frm.acctCrncy.value) != "") && (fnTrim(frm.refCrncy.value) != "") )
		{
			//var ptype = (frm.pTranType[0].checked==true)?"D":"C";
			var input = "pTranType|D|rateType|TM|acctCrncy|"+frm.acctCrncy.value+"|refCrncy|"+frm.refCrncy.value;
			var output= "";
			var retVal = cust_fnExecuteScript(input,output,"denomdp053.scr",false);
			if(retVal !=undefined)
			{
				var vals = retVal.split("|");
				if(vals[0] !="N")
				{
					frm.rateCode.value = vals[1];
					frm.rateCode.onchange();
				}
				else
				{
					alert(vals[1]);
					//frm.rateCode.value = "";
					return false;
				}		
			}
		}
		return true;
}
/* VALIDATING FROM CURRENCY,TO CURRENCY AND RATE CODE FIELDS*/
function fnValidate_fields()
{
	
	var frm = document.forms[0];
	if(frm.acctCrncy.value == "")
	{
		alert("Currency code cannot be blank..Enter a valid currency code.");
		frm.acctCrncy.focus();
		return false;
	}
	if(frm.refCrncy.value == "")
	{
		alert("Currency code cannot be blank..Enter a valid currency code.");
		frm.refCrncy.focus();
		return false ;
	}
	if(frm.rateCode.value == "")
	{
		if(frm.refCrncy.value != frm.acctCrncy.value)
		{
			alert("RateCode cannot be left blank..Enter a valid rate code.");
			frm.rateCode.focus();
			return false;
		}
	}
	if(frm.refCrncy.value == frm.acctCrncy.value)
	{
		if(frm.acctCrncy.value == "")
		{
			alert("Currency code cannot be blank..Enter a valid currency code.");
			frm.acctCrncy.focus();
			return false;
		}
	}
	var acctCrncy = frm.acctCrncy.value;
	var refCrncy = frm.refCrncy.value;
	var RateCode = frm.rateCode.value;
	var scrName = "denomdp009.scr";
	var outputNames = "";
	var inputNameValues = "RateCode|"+RateCode
						 +"|acctCrncy|"+acctCrncy
						 +"|refCrncy|"+refCrncy;
	var retVal = cust_fnExecuteScript(inputNameValues,outputNames,scrName,false);
	var values = retVal.split("|");
	if(values[0] == "Success")
	{
		return true;
	}
	else
	{
		var val = values[1].split("&");
		if (val[0] == "FROM")
		{
			alert(val[1]);
			frm.acctCrncy.focus();
			return false;
		}
		
		if (val[0] == "TO")
		{
			alert(val[1]);
			frm.refCrncy.focus();
			return false;
		}
		
		if(val[0] == "RATE")
		{
			alert(val[1]);
			frm.rateCode.focus();
			return false;
		}
		return true;
	}
	return true;
}

/* FUNCTION FOR CHECKING SPECIAL CHARACTERS IN THE AMOUNT FIELDS */
function fnchk_invld_chr_amt(obj)
{
	var iChars = "!~@`#$&*()+=[]\\\';/{}|\":<>?%^_ ";
	var iFlag1  = 0;
	var value = obj.value;
	for (var j = 0; j < value.length; j++)
	{
		if (iChars.indexOf(value.charAt(j)) != -1)
		{
			alert("Special characters not allowed");
			obj.value="";
			obj.focus();
			return 0;
		}
	}
	
}

/* VALIDATING THE AMOUNT RECEIVED FIELD */
function fnvalidate_received(obj)
{
	var frm = document.forms[0];
	var receivedamt = removeCommas(frm.receivedAmt.value);
	if(isNaN(receivedamt))
	{
		alert("Enter valid Received Amount");
		frm.receivedAmt.focus();
		return false;
	}
	if(receivedamt < 0)
	{
		alert("Enter a positive value for 'Amount received' field");
		frm.receivedAmt.focus();
		return false;
	}
	if(receivedamt == 0)
	{
		alert("Enter a valid value for 'Amount received' field to make a transaction");
		frm.receivedAmt.focus();
		return false;
	}
	javascript:newformatAmt('MILLION',frm.receivedAmt,frm.acctCrncy.value,'N');
	return true;
}

/* VALIDATING THE AMOUNT IN FROM CURRENCY FIELD */
function fnvalidate_exchanged(obj)
{
	var frm = document.forms[0];
	var acctcrncyAmt = removeCommas(frm.acctCrncyAmt.value);
	if(acctcrncyAmt < 0)
	{
		alert("Enter a positive value for the 'Amount in from currency' field");
		obj.focus();
		return false;
	}
	/* VALIDATE FOR RECEIVED AMOUNT AND TO BE EXCHANGED AMOUNT */
	if((frm.receivedAmt.value == 0)&&(frm.acctCrncyAmt.value == 0))
	{
		alert("Enter a valid amount to make a transaction");
		frm.receivedAmt.focus();
		return false;
	}
	 javascript:newformatAmt('MILLION',frm.acctCrncyAmt,frm.acctCrncy.value,'N');
}

/* VALIDATING THE AMOUNT IN TO CURRENCY FIELD */
function exchange_amt(obj)
{
	var frm = document.forms[0];
	var refamt = removeCommas(frm.refAmt.value);
	if(obj == frm.refAmt)
	{
		if(frm.refAmt < 0)
		{
			alert("Converted amount cannot be negative... ")
			obj.focus()
			return false;
		}
	}
	javascript:newformatAmt('MILLION',frm.refAmt,frm.acctCrncy.value,'N');
}

function fnValidate()
{
	var frm = document.forms[0];
	var amt1 = frm.receivedAmt;
	if((fnValidate_fields())&&(fnvalidate_received(amt1)))
	{
		cust_showCrncyConverterForTranMaint(frm.acctCrncy,frm.refCrncy,frm.rateCode,frm.rate,frm.acctCrncyAmt);
		javascript:newformatAmt('MILLION',frm.refAmt,frm.refCrncy.value,'N');
		javascript:newformatAmt('MILLION',frm.acctCrncyAmt,frm.acctCrncy.value,'N');
		frm.receivedAmt.value = frm.acctCrncyAmt.value;
		return true;
	}
	else
		return false;
}

/* ON PRESS OF SUBMIT BUTTON */
function fnAccept()
{ 
	var frm = document.forms[0];
	var receivedamt = removeCommas(frm.receivedAmt.value);	
	var acctcrncyAmt = removeCommas(frm.acctCrncyAmt.value);
	var refAmt = removeCommas(frm.refAmt.value);	
	var refCrncys	= frm.acctCrncy.value + "@" + frm.refCrncy.value;
	var refAmts		=  frm.receivedAmt.value + "@" + frm.refAmt.value;

	/* VALIDATE IF ANY OF THE MANDATORY FIELDS IS LEFT UNENTERED */
	if(frm.acctCrncy.value == "")
	{
		alert("Currency code cannot be blank..Enter a valid currency code.");
		frm.acctCrncy.focus();
		return false;
	}
	if(frm.refCrncy.value == "")
	{
		alert("Currency code cannot be blank..Enter a valid currency code.");
		frm.refCrncy.focus();
		return false ;
	}
	if(frm.receivedAmt.value == "")
	{
		alert("Received Amount cannot be blank...Enter a valid amount.");
		frm.receivedAmt.focus();
		return false;
	}
	if(frm.acctCrncyAmt.value == "")
	{
		alert("Amount in from currency cannot be blank...Enter a valid amount.");
		frm.acctCrncyAmt.focus();
		return false ;
	}
	if(frm.rateCode.value == "")
	{
		if(frm.refCrncy.value != frm.acctCrncy.value)
		{
			alert("RateCode cannot be blank..Enter a valid rate code.");
			frm.rateCode.focus();
			return false;
		}
	}
	if(frm.refAmt.value == "")
	{
		alert("Amount in to Currency cannot be blank..Please click on the CCY Converter link to procced.");
		return false;
	}

	var retVal = cust_fndenompopup("A","C","CR","",refCrncys,refAmts,"C@D","","","C","N@Y");
	if(retVal == "cancel" || retVal == false)
		return false;
	else
		frm.RetVal.value = retVal;
	var receivedamt = removeCommas(frm.receivedAmt.value);
	frm.receivedAmt.value = receivedamt;
	var acctcrncyAmt = removeCommas(frm.acctCrncyAmt.value);
	frm.acctCrncyAmt.value = acctcrncyAmt;
	var refAmt = removeCommas(frm.refAmt.value);
	frm.refAmt.value = refAmt;
//	var payBackAmt = removeCommas(frm.payBckAmt.value);
//	var getBackAmt = removeCommas(frm.getBckAmt.value);
	var acctCrncy = frm.acctCrncy.value;
	var refCrncy = frm.refCrncy.value;
	var rateCode = frm.rateCode.value;
	//var bopFlag = frm.bopFlag.value;
	var inputNameValues = "acctCrncy|"+acctCrncy
		+"|refCrncy|"+refCrncy
		+"|receivedAmt|"+receivedamt
		+"|acctCrncyAmt|"+acctcrncyAmt
		+"|rateCode|"+rateCode
//		+"|payBckAmt|"+payBackAmt
//		+"|getBckAmt|"+getBackAmt

			+"|retval|"+retVal;

	var outputNames = "";
	var scrName;
	frm.action = "jsp/denommn001.jsp?&PressAccept=Y";
	frm.submit();
}

/* FUNCTION TO ASSIGN THE VALUE OF RECEIVED AMOUNT TO AMOUNT IN FROM CURRENCY*/
function fnSetAmtFrnCry(obj)
{
	
	var frm = document.forms[0];
	if(obj.id == 'refCrncy' || obj.id == 'acctCrncy')
	{
		if(frm.refCrncy.value != frm.acctCrncy.value)
		{
			frm.refAmt.value = "";
			frm.rate.value = "";
			frm.rateCode.readOnly = false;
		}
	}
	javascript:newformatAmt('MILLION',frm.receivedAmt,frm.acctCrncy.value,'N');
	javascript:frm.acctCrncyAmt.value=frm.receivedAmt.value;
	if(frm.refCrncy.value == frm.acctCrncy.value)
	{
		frm.refAmt.value = frm.receivedAmt.value;
		frm.rate.value = "";
		frm.rateCode.value = "";
		frm.rateCode.readOnly = true;
	}
	if(frm.refAmt.value!="")
	{
	frm.refAmt.value="";
	}
	
}


var NO_KEY = 0;
var CtrlKey = 17;
var CharYKey = 89;
var CtrlKeyDown = false;
var CharYKeyDown = false;

function fnKeyDown(event)
{
	switch(event.keyCode)
	{
		case CtrlKey :
			CtrlKeyDown = true;
			break;
		case CharYKey:
			CharYKeyDown = true;
			if(CtrlKeyDown && CharYKeyDown)
			{
				event.keyCode = NO_KEY;
				event.returnValue = false;
				CtrlKeyDown = false;
				CharYKeyDown = false;
				fnValidate();
			}
		default :
			CtrlKeyDown = false;
	}
}

function fnKeyUp(event)
{
	switch(event.keyCode)
	{
		case CtrlKey :
			CtrlKeyDown = false;
			CharYKeyDown = false;
			break;
	}
}


//---- Below functions called for BOP requirement specific to NA ----//
function fnBopPopTemp()
{
	fnBOPPopUpCall(document.forms[0].receivedAmt.value,'',document.forms[0].acctCrncy.value,'','HCASHDX');
}

function fnBopButtonFetch()
{
	return fnFetchBOPDtls(document.forms[0].receivedAmt.value,'',document.forms[0].acctCrncy.value,'','HCASHDX');
}


function printBopBlock()
{
	with(document)
	{
		write('<tr>');
		write('<tr class=""><spacer type="block" height=1 width=1></spacer></tr>');
		write('<tr class=""><spacer type="block" height=1 width=1></spacer></tr>');
		write('<tr class=""><spacer type="block" height=1 width=1></spacer></tr>');
		write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
		write('<td align="right">');
		write('</td>');
		write('</tr>');
		write('<table class="tableborder" width="100%" border="0" cellpadding="0" cellspacing="0">');
		write('<tr><td>');
		write('<table class="innertable" width="100%" border="0" cellpadding="0" cellspacing="0">');
		write('<tr>');
		write('<td class="textlabel"><b>BOP Allowed Flag</b></td>');
		write('<td><table><tr>');
		write('<td class="textfield">');
		write('<input type="radio" name="custom.bopFlag" id="bopFlag" value="Y" onClick ="fnBopPopTemp();" disabled >Yes');		
		write('<input type="radio" name="custom.bopFlag" id="bopFlag" value="N" checked disabled>No</td>');
		write('<td>');
		write('<input type="button" class="button" id="fetch" value="Fetch BOP" onClick="fnBopButtonFetch();" disabled>');
		write('</td>');
		write('</tr>');
		write('</table>');
		write('</td>');
		write('</tr>');
		write('</table>');
		write('</td></tr></table>');		
		write('</DIV>');
		write('</SPAN>');		
	}
}

//----  function to paint accept and clear buttons ----//
function printSubClearBlock()
{
	with(document)
	{
		write('</TABLE>');
		write('</TABLE>');
		write('<DIV class="ctable">');
		write('<TR class="page-heading">');
		write('<TD width=10%></TD>');
		write('<TD width=10%>');
		write('<INPUT type="button" class="button" value="ACCEPT" name="Accept" onclick="fnAccept();">');
		write('</TD>');
		write('<TD width=15%>');
		write('<INPUT type="button" class="button" value="CLEAR" name="Cancel" onclick ="fnRefresh();">');
		write('</TD>');
		write('</TR>');
		write('</DIV>');
		
	}
}


</SCRIPT>
</HEAD>
<custom:mbuild/>

<BODY class="cbody" onload="javascript:fnOnLoad();"  onKeyDown="javascript:return fnKeyDown(event);" onKeyUp="javascript:return fnKeyUp(event);">
<FORM name="form1" class="cform" method="post" onLoad="fnOnLoad();">

<%@ include file="../javascripts/appl_inc.js" %>
<%@ include file="../javascripts/header.js" %>

<SPAN class="cform">
<INPUT type="Hidden" name="submitform" value="Submit">
<INPUT type="Hidden" name="pagename" value="/finbranch/custom/jsp/">
<INPUT type="Hidden" name="scrName" value="denomdp007.scr">
<INPUT type="Hidden" name="actionCode" value="" >
<INPUT type="Hidden" name="branch" value="" id="branch" >
<INPUT type="Hidden" name="badd1" value="" id="badd1" >
<INPUT type="Hidden" name="badd2" value="" id="badd2" >
<INPUT type="Hidden" name="city" value="" id="city" >
<INPUT type="Hidden" name="cntry" value="" id="cntry" >
<INPUT type="Hidden" name="state" value="" id="state" >
<INPUT type="Hidden" name="pin" value="" id="pin" >
<INPUT type="Hidden" name="userid" value="" id="userid" >
<INPUT type="Hidden" name="total" value="" id="total" >
<INPUT type="Hidden" name="time" value="" id="time" >
<INPUT type="Hidden" name="fromc" id="fromc" value="">
<INPUT type="Hidden" name="toc" id="toc" value="">
<INPUT type="Hidden" name="from" id="from" value="">
<INPUT type="Hidden" name="to" id="to" value="">
<INPUT type="Hidden" name="rte" id="rte" value="">
<INPUT type="Hidden" name="narrative" id="narrative" value="">
<INPUT type="Hidden" name="td" id="td" value="">
<INPUT type="Hidden" name="custom.bopRefValue" id="bopRefValue" value="<%=sBopRefValue%>">
<INPUT type="Hidden" name="custom.bopChkFlg" id="bopChkFlg" value="<%=sBopChkFlg%>">
<INPUT type="Hidden" name="custom.bopPopFlg" id="bopPopFlg" value="<%=sBopPopFlg%>">
<INPUT type="Hidden" name="custom.bopFlg" id="bopFlg" value="<%=sBopFlg%>">


<TABLE class="ctable">
	<TR> <TD class="page-heading">Direct Cash Exchange Screen (In Same And Different Currencies)</TD> </TR>
</TABLE>

<%
	out.println(sDetails);
%>

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
	<a href="javascript:showHelpFile('hcashdx_det_help.htm');">
	<img class="img" align="right" src="../Renderer/images/help.gif" width="47" height="21"  vspace="1" border="0"></img></a>
	</td>
</tr>
<!-- FIELDS ON SCREEN HERE -->

<TR class="rowspacing">
	<TD class="textlabel">
		From Currency
	</TD>
	<TD>
		<INPUT type="text" class="textfieldfont" size="30" name="custom.acctCrncy" id="acctCrncy" maxlength="3" onChange="fnchk_invld_chr(this);fnDfltRC(this)" onblur="fnSetAmtFrnCry(this)">
		<a id="sLnk1" href="javascript: cust_showCurrencyList(document.forms[0].acctCrncy)">
		<IMG SRC="../Renderer/images/search_icon.gif" width="16" height="17" border=0 hotKeyId="search1"/>
		</IMG></a>
	</TD>

<TD class="textlabel">
		To Currency
	</TD>
	<TD>
		<INPUT type="text" class="textfieldfont" size="30" name="custom.refCrncy" id="refCrncy" maxlength="3" onChange="fnchk_invld_chr(this);fnDfltRC(this)" onblur="fnSetAmtFrnCry(this)">
		<a id="sLnk2"   href="javascript: cust_showCurrencyList(document.forms[0].refCrncy);">
		<IMG SRC="../Renderer/images/search_icon.gif" width="16" height="17" border=0 hotKeyId="search1"/>
		</IMG></a>
		</TD>
</TR>

<TR class="rowspacing">
	<TD class="textlabel">
		Amount received
	</TD>
	<TD> 
		<INPUT type="text" class="textfieldfont" size="30" name="custom.receivedAmt" id="receivedAmt" onChange="fnchk_invld_chr_amt(this);" onBlur="fnSetAmtFrnCry(this)" >
	</TD>
</TR>

</TABLE>
</TABLE>
</TABLE>
<BR>
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
</td>
</tr>

<TR class="rowspacing">
	<TD class="textlabel">
		Amount in from currency
	</TD>
	<TD>
		<INPUT type="text" class="textfieldfont" size="30" name="custom.acctCrncyAmt" id="acctCrncyAmt" READONLY>
		&nbsp;&nbsp;&nbsp; (to be exchanged)
	</TD>
</TR>

<TR class="rowspacing">
	<TD class="textlabel">
		Amount in to currency 
	</TD>
	<TD>
		<INPUT type="text" class="textfieldfont" size="30" name="custom.refAmt" id="refAmt" onChange="fnchk_invld_chr_amt(this)" READONLY>
		&nbsp;&nbsp;&nbsp; (Press Ctrl+Y for CCY converter link)
		<!--  <a href = "fnValidate()"class="topnavi" >&nbsp;&nbsp;&nbsp; CCY Converter</a> -->
		<div onclick="javascript:fnValidate();" onMouseOver='displayHand(this)' class="topnavi"><U><font color=blue>CCY Converter</font></U></div>
	</TD>
</TR>

<TR class="rowspacing">
	<TD class="textlabel">
		Rate Code
	</TD>
	<TD>
		<INPUT type="text" class="textfieldfont" size="30" name="custom.rateCode" id="rateCode" maxlength="5" onChange="fnchk_invld_chr(this)">
		<a id="sLnk3" href="javascript:getRateCodeList()">
		<IMG SRC="../Renderer/images/search_icon.gif" width="16" height="17" border=0 hotKeyId="search1"/>
		</IMG></a>
	</TD>
</TR>

<TR class="rowspacing">
	<TD class="textlabel">
		Rate
	</TD>
	<TD>
		<INPUT type="text" class="textfieldfont" size="30" name="custom.rate" id="rate" readonly>
	</TD>
</TR>


<!--TR class="rowspacing">
	<TD class="textlabel">
		Pay Back Amount:
	</TD>
	<TD>
		<INPUT type="text" class="textfieldfont" size="30" name="custom.payBckAmt" id="payBckAmt" onChange="fnchk_invld_chr_amt(this)" READONLY>
	</TD>
</TR>

<TR class="rowspacing">
	<TD class="textlabel">
	Get Back Amount:
	</TD>
	<TD>
		<INPUT type="text" class="textfieldfont" size="30" name="custom.getBckAmt" id="getBckAmt" onChange="fnchk_invld_chr_amt(this)" READONLY>
	</TD>
</TR-->
<!-- FIELDS ON SCREEN ENDS HERE -->

</TABLE>
</TABLE>
</TABLE>



<!--

</TABLE>



<table class="tableborder" width="100%" border="0" cellpadding="0" 
cellspacing="0">
<tr><td>
<table class="innertable" width="100%" border="0" cellpadding="0" 
cellspacing="0">
<tr>
<td class="textlabel"><b>BOP Allowed Flag</b></td>
<td><table><tr>


<td class="textfield"><input type="radio" name="custom.bopFlag" id="bopFlag" 
value="Y" 
onclick="fnBOPPopUpCall(document.forms[0].receivedAmt.value,'',document.forms[0].acctCrncy.value,'','HCASHDX');" disabled >Yes
<input type="radio" name="custom.bopFlag" id="bopFlag" value="N" checked 
disabled>No</td>
<td><input type="button" class="Button" id="fetch" value="Fetch BOP" 
onClick="javascript: return fnFetchBOPDtls(document.forms[0].receivedAmt.value,'',document.forms[0].acctCrncy.value,'','HCASHDX');" disabled></td>
</tr>
</table>
</td>
</tr>
</table>
</td></tr></table>

</DIV>
</SPAN>
-->
<!-- BUTTONS -->
<!--
<DIV class="ctable">
	<TR class="page-heading">
		<TD width=10%></TD>
		<TD width=10%>
			<INPUT type="button" class="button" value="ACCEPT" name="Accept" onclick="fnAccept();">
		</TD>
		<TD width=15%>
			<INPUT type="button" class="button" value="CLEAR" name="Cancel" onclick ="fnRefresh();">
		</TD>
	</TR>
</DIV>

-->




<SCRIPT>


printSubClearBlock();

</SCRIPT>
	

<!-- HIDDEN FIELDS -->

<INPUT type="Hidden" name="submitform" value="Submit">
<INPUT type="Hidden" name="pagename" value="/custom/jsp/denommn001.jsp">
<INPUT type="Hidden" name="scrName" value="denomdp007.scr" >	
<INPUT type="Hidden" name="custom.CashExchange" value="D" >
<INPUT type="Hidden" name="custom.RetVal" id="RetVal" value="">

</FORM>
</BODY>
</HTML>

