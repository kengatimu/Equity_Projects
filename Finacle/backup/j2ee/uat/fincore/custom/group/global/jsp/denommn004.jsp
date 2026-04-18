<%
/*-----------------------------------------------------------------------------------------
   NAME			:   denommn004.jsp 
   Calling Jsp	:   None
   Called JSP	:   None
   Called Script:   denomdp014.scr 
   Description	:   This JSP receives Sol Id from user and submits it to backend for 
					calculating the sum of round off amount for all the tellers in that Sol 
					and records to a report
   Menu Option  :   HDENRO
   Author		:   Jayashri

   Modification History:	
   ====================
   Serial No.	DATE		Author			Description							
------------------------------------------------------------------------------------------*/
%>
<%@ include file="../commonInclude.jsp" %>

<HTML>
<META http-equiv="Content-Type" content="text/html;charset=utf-8">
<HEAD>

<TITLE></TITLE>
<%@page contentType="text/html; charset=utf-8" %>

<jsp:useBean id="customBeanInst" class="com.infy.finbranch.groups.customBean" scope="session" />
<arjsp:init groupName="custom" isEntryPoint="true" />

<%
	customBeanInst.Refresh(pageContext, ARJspCurr, ARJspRet);
	customBeanInst.populateFields(finbranch, PropertyManager.getProperties(session), ResourceManager.getResourceBundle(pageContext, "finbranch"));
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
String sParam[] = new String[10];
String sValues[] = new String[10];
String sMessage = "";
String sDetails = "";
%>
<%@ page import="com.infy.bbu.jsputil.*,FABProcess.*,FABCommon.*,FABInquiry.*,java.util.*, java.lang.*"%>

<%
	if(request.getParameter("PressAccept") != null)
    {
		String sAppNextPage = customBeanInst.getNextPage();

		sParam[0]       =   "Message";
		sParam[1]	    =   "Details";
		sValues			=   customBeanInst.getCustOutData(sParam);
		sMessage	    =   sValues[0];
		sDetails	    =   sValues[1];
		
	}
%>

<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("SearcherList.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/lists/<%=VRPKeys.getFile("showAccountIdList.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/lists/<%=VRPKeys.getFile("showRefCode.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/lists/<%=VRPKeys.getFile("showSolId.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("resource_functions.js",sProfileId)%>"> </script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"></script>    
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_common_functions.js",sProfileId)%>"></script>
<HEAD>
<TITLE>Transaction Round Off Consolidation</TITLE>
<SCRIPT>


/*ON CLEARING THE PAGE */

function fnRefresh()
{
		document.forms[0].action   =   "jsp/denommn004.jsp";
		document.forms[0].submit();
}

/* ON LOADING THE PAGE */

function fnOnLoad()
{	
	alert("inside onload of HDENRO");	
	var msg = "<%=sMessage%>";
	var frm = document.forms[0];
	document.forms[0].SolId.focus();
}

/* VALIDATE THE TELLER IDS */

function validateTeller()
{
	var inputNameValues = "";
	var outputNames = "";
	var scrName = "denomdp017.scr";
	var retVal = cust_fnExecuteScript(inputNameValues,outputNames,scrName, false);
	var Values = retVal.split("|");
	if(Values[0] == "Success")
	{
		return true;
	}
	else
	{
		alert(Values[1]);
		return false;
	}
}

/* VALIDATING THE SOL ID FIELD FOR SPECIAL CHARACTERS */

function fnchk_invld_chr(obj)
{
	    var iChars = "!~@`#$&*()+=[]\\\';,/{}|\":<>?.%^_";
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

/* VALIDATE IF THE ENTERED SOL ID IS VALID OR NOT */

function fnvalidate_sol(obj)
{
	if(obj == document.forms[0].SolId)
	{
		fnchk_invld_chr(obj);
		if(document.forms[0].SolId.value=="")
		{
			alert("Sol Id has to be entered");
			document.forms[0].SolId.focus();
			return false;
		}
		var scrName = "denomdp013.scr";
		var SolId= document.forms[0].SolId.value;
		var inputNameValues = "SolId|"+SolId;
		var outputNames="";
		var retVal = cust_fnExecuteScript(inputNameValues,outputNames, scrName, false);
		var values = retVal.split("|");
		if(values[0] == "Success")
		{
			return true;
		}
		else
		{
			alert(values[1]);
			document.forms[0].SolId.focus();
			return 0;
		}
	}
}

/* VALIDATE FOR THE ENTERED SOL ID IF ANY RECORD EXISTS OR NOT */

function validate_sol(obj)
{
	if(obj == document.forms[0].SolId)
	{
		var scrName = "denomdp022.scr";
		var SolId= document.forms[0].SolId.value;
		var inputNameValues = "SolId|"+SolId;
		var outputNames="";
		var retVal = cust_fnExecuteScript(inputNameValues,outputNames, scrName, false);
		var values = retVal.split("|");
		if(values[0] == "Success")
		{
			return true;
		}
		else
		{
			alert(values[1]);
			document.forms[0].SolId.focus();
			return 0;
		}
	}
}

/* ON PRESS OF SUBMIT BUTTON */

function fnSubmit()
{
	var SolId = document.forms[0].SolId.value;
	document.forms[0].SolId1.value = SolId;
	var sol = document.forms[0].SolId.value;

	/* IF THE VALUE FOR SOL ID FIELD IS ENTERED AS "ALL" */

	if(sol == "all")
	{
		if(confirm("This would make a transaction for all the sol ids") && validateTeller())
		{
			if(fnvalidate_sol(document.forms[0].SolId))
			{   
					if (validate_sol(document.forms[0].SolId))
					{
						document.forms[0].action   =   "jsp/denommn004.jsp?&PressAccept=Y";
						document.forms[0].submit();
					}
			}
			else
			{
				return false;
			}
		}
	}
	else
	{
		/* IF THE USER ENTERS/SELECTS SOME VALID VALUE FOR SOL ID FIELD */

			validateTeller();
			if(fnvalidate_sol(document.forms[0].SolId))
			{   
				if (validate_sol(document.forms[0].SolId))
				{
					document.forms[0].action   =   "jsp/denommn004.jsp?&PressAccept=Y";
					document.forms[0].submit();
				}
			
			}
			else
			{
				return false;
			}
	}
}

</SCRIPT>

</HEAD>
<custom:mbuild/>

<BODY class="cbody" onLoad="fnOnLoad();">
<FORM name="form1" class="cform" method="post" onLoad="fnOnLoad();">

<%@ include file="../javascripts/appl_inc.js" %>
<%@ include file="../javascripts/header.js" %>

<SPAN class="cform">
<INPUT type="Hidden" name="submitform" value="Submit">
<INPUT type="Hidden" name="pagename" value="jsp/denomdp004.jsp">
<INPUT type="Hidden" name="scrName" value="denomdp014.scr">

<TABLE class="ctable">
	<TR> <TD class="page-heading">Transaction Round Off Consolidation Screen</TD> </TR>
</TABLE>
<%	if(sMessage.equals("Success")) {
		out.println(sDetails);	}
	if(sMessage.equals("Failure")) {
		out.println(sDetails);	}
%>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">
<tr>
<td>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td valign="top">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td class="activetab1">&nbsp;</td>
<td class="activetab3" width="90%">&nbsp;</td>
</tr>
</table>
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
</td>
</tr>

<!-- FIELDS ON SCREEN HERE -->

   <TR class="rowspacing">
	<TD class="textlabel">
		Sol Id:
	</TD>
	<TD> 
	<INPUT type="text" class = "text" size="25" name="Sol" id="SolId" maxlength="50"onkeypress="fnchk_invld_chr(this)">
    <a id="sLnk1" href="javascript: showSolId(document.forms[0].SolId,'ctrl','F','');">
	<IMG SRC="../Renderer/images/search_icon.gif" width="16" height="17" border=0 hotKeyId="search1"/>
	</IMG></a>
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
			<INPUT type="button" class="button" value="Submit" name="SUBMIT" onclick="fnSubmit();">
		</TD>
		<TD width=15%>
			<INPUT type="button" class="button" value="Clear" name="CANCEL" onclick ="fnRefresh();">
		</TD>
	</TR>
</DIV>

<!-- HIDDEN FIELDS -->

<INPUT type="Hidden" name="submitform" value="Submit">
<INPUT type="Hidden" name="pagename" value="jsp/denommn004.jsp">
<INPUT type="Hidden" name="scrName" value="denomdp014.scr" >	
<INPUT type="Hidden" name="custom.SolId1" id="SolId1" value="">	

</FORM>
</BODY>
</HTML>
