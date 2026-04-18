<! DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
/*-----------------------------------------------------------------------------------------
 Name					: denomdp003.jsp
 Calling Jsp			: denomdp004.jsp
 Called JSP				: NA
 Date					: 23-JUL-2010
 Called Script			: denomdp004.scr
 Description			: This JSP receives the FunctionCode and Currency details from user
						  and sends to the backend.
 Module					: DENOM
 Menu Option			: HDENOM
 Author					: Castro / Sandeep Patil 
 Modification History	:	
	<Serial No.>	<Date>			<Author>			<Description>
	0.1				23-JUL-2010		Sandeep Patil		Draft Version
------------------------------------------------------------------------------------------*/
%>
<%!
	public static final String _ARJSP_JSP_NAME = "jsp/denommn003.jsp";
%>

<%@ include file="../commonInclude.jsp" %>
<arjsp:init groupName="custom"  isEntryPoint="true" />
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
<%
	sNextPage = "custom/jsp/denommn003.jsp";
	String sParam[] = new String[10];
	String sValues[] = new String[10];
	String sDummy = "";
	String sFuncCode = "";
	String sCurrency = "";
	String sMessage  = (request.getParameter("Message")!= null)?request.getParameter("Message"):"";
	String sDetails  = (request.getParameter("Details")!= null)?request.getParameter("Details"):"";
	sFuncCode = ((request.getParameter("custom.FuncCode")!= null)?request.getParameter("custom.FuncCode"):"");
	sCurrency = ((request.getParameter("custom.Currency")!= null)?request.getParameter("custom.Currency"):"");
	customBeanInst.Refresh(pageContext, ARJspCurr, ARJspRet);
	/*customBeanInst.populateFields(finbranch, PropertyBeanInst.getProperties(),ResourceBeanInst.getResourceBundle(pageContext, "finbranch"));*/
	customBeanInst.populateFields(finbranch, PropertyManager.getProperties(session),ResourceManager.getResourceBundle(pageContext, "finbranch"));
	customBeanInst.setPageName(sNextPage);
%>

<custom:getRepository/>

<%
	String sProcRequestRet = null;
	String sFirstAccess    = (String)ARJspRep.getVal("IsFirstAccess");
	if (sFirstAccess == null)
	{
		//sProcRequestRet = customBeanInst.procRequest(); 
		ARJspRep.setVal("IsFirstAccess", "NO");
	}
%>

<%
String customData   = "";
customData = customBeanInst.getCustomData(session);

if(request.getParameter("PressAccept") != null)
{
	String sAppNextPage = customBeanInst.getNextPage();
	sParam[0]       =   "Message";
	sParam[1]	    =   "Details";
	sValues         =   customBeanInst.getCustOutData(sParam);
	sMessage	    =   sValues[0];
	sDetails	    =   sValues[1];

/*----------------------------------------------------------------------------------------
	ON SUCCESS EXECUTION OF SCRIPT, THE PAGE IS FORWARDED TO OPS015denomdp001.jsp
------------------------------------------------------------------------------------------*/
	if(sMessage.equals("Y"))
	{
	%>
	<jsp:forward page="denomdp004.jsp" >
    </jsp:forward>
	<%
	}
}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"> </script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_common_functions.js",sProfileId)%>"> </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("resource_functions.js",sProfileId)%>"> </script>

<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("hotkeydata_link.js",sProfileId)%>"> </script>
<custom:mbuild/>
<script language="javascript">

function fnPageLoad()
{
	//initFocusHandler();
	document.forms[0].FuncCode.focus();
	return true;
}

//-----------------------------------------------------------------------------------
// Function Name	:  fnValidateForm
// Description		:  This function performs all necessary form validations
//-----------------------------------------------------------------------------------
function fnValidateForm()
{
	var objForm=document.forms[0];
	if(objForm.FuncCode.value == "")
	{
		alert("Please enter Function Code");
		objForm.FuncCode.focus();
		return false;
	}
	if(objForm.Currency.value == "")
	{
		alert("Please enter Currency Code");
		objForm.Currency.focus();
		return false;
	}
	var input = "Validate|Y|" + "FuncCode|" + objForm.FuncCode.value + "|Currency|" + objForm.Currency.value;
	var retVal = cust_fnExecuteScript(input,"","denomdp004.scr",false);
	var msg = retVal.split("|");
	if(msg[0] == "Error")
	{	
		alert(msg[1]);
		return false;
	}
	else
		return true;
}

//-----------------------------------------------------------------------------------
//Function Name	:  fnSubmit
//Description	:  This function submits all the values when Go button is clicked.
//-----------------------------------------------------------------------------------
function fnSubmit()
{
	var objForm=document.forms[0];
	if(!fnValidateForm())
		return false;
	objForm.Currency.value=objForm.Currency.value.toUpperCase();
	objForm.action="jsp/denomdp004.jsp?PressAccept=Y&custom.FuncCode="+objForm.FuncCode.value+"&custom.Currency="+objForm.Currency.value+"&scrName=denomdp004.scr";
	document.forms[0].submit();
	return true;
}
	
//-----------------------------------------------------------------------------------
//Function Name	:  fnRefresh
//Description	:  This function clears the currency, when Function code is changed
//-----------------------------------------------------------------------------------
function fnRefresh()
{
	var objForm = document.forms[0];
	objForm.Currency.value = "";
	objForm.CurrencyDesc.value = "";
}
	
//-----------------------------------------------------------------------------------
//Function Name	:  fnClear
//Description	:  This function clears all the values when Clear Button is Clicked.
//-----------------------------------------------------------------------------------
function fnClear()
{
	var objForm = document.forms[0];
	objForm.FuncCode.options[0].selected = true;
	objForm.Currency.value="";
	objForm.action="jsp/denommn003.jsp";
	objForm.submit();
}

</script>

<title>Currency Denomination Maintenance</title>
</head>
<body class="cbody" onLoad= "fnPageLoad()" onKeyDown="fnKeyDownProcessor(window.event)"> 
<form name="form1" method="post">
<%@ include file="../javascripts/appl_inc.js" %>
<%@ include file="../javascripts/header.js" %>
<%
/*----------------------------------------------------------------------------------------
	DISPLAYING ERROR MESSAGE RECEIVED FROM THE BACKEND SCRIPT
------------------------------------------------------------------------------------------*/
if(sMessage.equals("N"))
{
%>
<table class="ctable" cellspacing="0" cellpadding="0" border="0">
<tr>
<td colspan="5">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="errortableborder">
	<tr>
	<td width="3%"align="center">
	   <div align="center"><img src="../Renderer/images/error.gif" width="19" height="17"></div>
	</td>
	<td width="97%" class="alert">Error Message(s):</td>
	</tr>
	<tr class="alert">
	<td colspan="2">
		<a onMouseOver='displayHand(this)' onClick="fnSelectField('custom', 'Currency')">&nbsp;<%=sDetails%></a>
	</td>
	</tr>
	</table>
</td>
</tr>
</table>
<%
}
%>

<TABLE class="ctable">
	<TR> <TD class="page-heading">Currency Denomination Maintenance</TD> </TR>
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
<a href="javascript:showHelpFile('hdenom_crit_help.htm');">
<img class="img" align="right" hotKeyId="finHelp" src="../Renderer/images/help.gif" width="47" height="21"  vspace="1" border="0"></img></a>
</td>
</tr>
	
<tr>
	<td class="textlabel"> Function <script>setMandatory("Y");</script></td>
	<td class="textfield">
		<select class="listboxfont" id="FuncCode" name="custom.FuncCode" onChange="fnRefresh()">
			<OPTION VALUE="" SELECTED>--Select--</OPTION>
			<OPTION VALUE="A" <%=(sMessage.equals("N") && sFuncCode.equals("A")?"SELECTED":"")%>>A-Add</OPTION>
			<OPTION VALUE="M" <%=(sMessage.equals("N") && sFuncCode.equals("M")?"SELECTED":"")%>>M-Modify</OPTION>
			<OPTION VALUE="I" <%=(sMessage.equals("N") && sFuncCode.equals("I")?"SELECTED":"")%>>I-Inquire</OPTION>
			<OPTION VALUE="D" <%=(sMessage.equals("N") && sFuncCode.equals("D")?"SELECTED":"")%>>D-Delete</OPTION>
			<OPTION VALUE="U" <%=(sMessage.equals("N") && sFuncCode.equals("U")?"SELECTED":"")%>>U-UnDelete</OPTION>
		</select>
	</td>
	<td class="columnwidth">&nbsp;</td>
	<td class="textlabel">&nbsp;</td>
	<td class="textfielddisplaylabel">&nbsp;</td>
</tr>

<tr>
	<td class="textlabel"> Currency <script>setMandatory("Y");</script></td>
	<td colspan="4" class="textfield">
		<input class="textfieldfont" id="Currency" hotKeyId="search1" name=custom.Currency size="21" maxlength="3" value="<%=(sMessage.equals("N")?sCurrency:"")%>">&nbsp;
		<A id=sLnk1 href="javascript: cust_showCurrencyList(document.forms[0].Currency);" target=_self>
		<IMG height=17 src="../Renderer/images/search_icon.gif" hotKeyId="search1"  width=16 border=0></IMG></a>
		<input class="label" id="CurrencyDesc"  name="custom.CurrencyDesc" size="21" maxlength="50" readonly>&nbsp;
	</td>
	<td>&nbsp;</td>
	<td class="textfield">&nbsp;</td>
</tr>

</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
<BR>
<!-- *********************** Buttons ******************** -->
	<div align="left" class="ctable">
		<input type="BUTTON" class="button1" id="Accept" name="Accept" hotKeyId="Go" value="Go" onClick="javascript:return fnSubmit();">
		<input type="BUTTON" class="button1" id="Clear" name="Clear" hotKeyId="Cancel" value="Clear" onClick="fnClear();"> 
	</div>
	<INPUT type="Hidden" name="submitform" value="Submit">
	<INPUT type="Hidden" name="pagename" value="jsp/denommn003.jsp">
	<INPUT type="Hidden" name="scrName" value="denomdp004.scr" >
</form>
</body>
