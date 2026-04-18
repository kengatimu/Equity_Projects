<! DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
/*-----------------------------------------------------------------------------------------
 Name					: denomdp004.jsp
 Calling Jsp			: denommn003.jsp
 Called JSP				: None
 Date					: 23-JUL-2010
 Called Script			: denomdp005.scr
 Description			: This JSP receives denomination details from user and submits it to
						  backend for performing Add/Modify/Delete Operation.
 Module					: DENOM
 Menu Option			: HDENOM
 Author					: Castro / Sandeep Patil 
 Modification History	:	
	<Serial No.>	<Date>			<Author>			<Description>
	0.1				23-JUL-2010		Sandeep Patil		Draft Version
------------------------------------------------------------------------------------------*/
%>
<%!
	public static final String _ARJSP_JSP_NAME = "/custom/denomdp004.jsp";
%>

<%@ include file="../commonInclude.jsp" %>
<arjsp:init groupName="custom"  isEntryPoint="true" />
<jsp:useBean id="customBeanInst" class="com.infy.finbranch.groups.customBean" scope="session" />
<%
	String sNextPage = "jsp/denomdp004.jsp";
	String sParam[] = new String[10];
	String sValues[] = new String[10];
	String sDummy = "";
	customBeanInst.Refresh(pageContext, ARJspCurr, ARJspRet);
	customBeanInst.populateFields(finbranch, PropertyManager.getProperties(session),ResourceManager.getResourceBundle(pageContext, "finbranch"));
	customBeanInst.setPageName(sNextPage);
	String sAppNextPage = customBeanInst.getNextPage();
%>

<custom:getRepository/>

<%
	String customData   = "";
	customData = customBeanInst.getCustomData(session);
	String sFuncCode = "";
	String sCurrency = "";
	String sMessage  = (request.getParameter("Message")!= null)?request.getParameter("Message"):"";
	String sDetails  = (request.getParameter("Details")!= null)?request.getParameter("Details"):"";
	String sCrncyName= "";
	String sNumOfDecPoints = "0";
	String sScrName = "";
	String sDisabled="N";
	String[] NoteArray = null;
	String[] CoinArray = null;
	int iNoteArrayLen = 0;
	int iCoinArrayLen = 0;

	/*************************************************************************
		RECEIVING FUNCCODE, CURRENCY CODE FROM CRITERIA PAGE
	*************************************************************************/
	sFuncCode = (request.getParameter("custom.FuncCode")!= null)?request.getParameter("custom.FuncCode"):"";
	sCurrency = (request.getParameter("custom.Currency")!= null)?request.getParameter("custom.Currency"):"";
	sCrncyName = (request.getParameter("custom.CrncyName")!= null)?request.getParameter("custom.CrncyName"):"";
	sNumOfDecPoints = (request.getParameter("custom.NumOfDecPoints")!= null)?request.getParameter("custom.NumOfDecPoints"):"0";
	sScrName = (request.getParameter("scrName")!= null)?request.getParameter("scrName"):"";

	if((request.getParameter("PressAccept") != null) && (sMessage.equals("")))
	{
		sParam[0]	= "Message";
		sParam[1]	= "Details";
		sParam[2]	= "CrncyName";
		sParam[3]	= "NumOfDecPoints";
		sParam[4]	= "NoteDenom";
		sParam[5]	= "CoinDenom";
		if(sFuncCode.equals("I"))
		sParam[6]	= "disabled";
		sValues = customBeanInst.getCustOutData(sParam);
		sMessage	=   sValues[0];
		sDetails	=   sValues[1];
		if(sFuncCode.equals("I"))
		sDisabled	=	sValues[6];
		if(!sScrName.equals("denomdp005.scr"))
		{
			sCrncyName	=   sValues[2];
			sNumOfDecPoints =   sValues[3];
			NoteArray	=   sValues[4].split("~");
			CoinArray	=   sValues[5].split("~");
			ARJspRep.setVal("NoteArray", NoteArray);
			ARJspRep.setVal("CoinArray", CoinArray);
		}
		else
		{
			NoteArray  = (String[])ARJspRep.getVal("NoteArray");
			CoinArray  = (String[])ARJspRep.getVal("CoinArray");
		}
	}
%>

<html>
<head>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"> </script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_common_functions.js",sProfileId)%>"> </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("resource_functions.js",sProfileId)%>"> </script>

<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("hotkeydata_link.js",sProfileId)%>" ></script>

<custom:mbuild/>

<script language="javascript">

function fnPageLoad()
{
	initFocusHandler();
	return true;
}

/*-----------------------------------------------------------------------------------
	Function Name	:  fnValidateForm
	Description		:  This function performs all necessary form validations
-----------------------------------------------------------------------------------*/
function fnValidateForm()
{
	var objForm  = document.forms[0];
	var inpObj;
	var inpCoinObj;
	var inpNoteObj;
	var emptyCoinFlag;
	var emptyNoteFlag;

	//----------------------------------------------------------------------------------
	// Validation for Number and the decimal places allowed.
	//----------------------------------------------------------------------------------
	emptyCoinFlag=true;
	emptyNoteFlag=true;
	for(idx=1;idx<=15;idx++)
	{
		inpObj = document.getElementById("NoteDenom" + idx);
		if (inpObj.value != "")
		{
			emptyNoteFlag = false;
			if ((isNaN(inpObj.value)) || (inpObj.value.indexOf(" ") != -1) ||  inpObj.value < 0)
                        {
				alert("Enter a valid number");
                                inpObj.focus();
                                return false;
                        }
			if (!fnValidateAmount(inpObj.value,0))
			{
				inpObj.focus();
				return false;
			}
		}

		inpObj = document.getElementById("CoinDenom" + idx);
		if (inpObj.value != "")
		{
			emptyCoinFlag = false;
                        if ((isNaN(inpObj.value)) || (inpObj.value.indexOf(" ") != -1) ||  inpObj.value < 0)
                        {
				alert("Enter a valid number");
                                inpObj.focus();
                                return false;
                        }
			if (!fnValidateAmount(inpObj.value,<%=sNumOfDecPoints%>))
			{
				inpObj.focus();
				return false;
			}
		}
	}
	if(emptyNoteFlag==true)
	{
		alert("Note Denomination cannot be empty!!!");
		return false;
	}
//	if(emptyCoinFlag==true)
//	{
//		alert("Coin Denomination cannot be empty!!!");
		//testing by putting 0 coins
//		return false;
//	}
	//----------------------------------------------------------------------------------
	// Validation for duplicate Note/Coin denomination fields.
	//----------------------------------------------------------------------------------
	for(i=1;i<=14;i++)
	{
		inpCoinObj = document.getElementById("CoinDenom" + i);
		inpNoteObj = document.getElementById("NoteDenom" + i);
		for(j=i+1;j<=15;j++)
		{

			inpObj = document.getElementById("CoinDenom" + j);
			if (inpCoinObj.value!="" && inpObj.value!="")
			{
				if(parseFloat(inpCoinObj.value)==parseFloat(inpObj.value))
				{
					alert("Duplicate coin denomination found!!!");
					inpObj.focus();
					return false;
				}
				if(inpObj.value==0)
				{
				alert("Coin Denomination Cannot Be Zero");
				inpObj.focus();
				return false;
				}
			}

			inpObj = document.getElementById("NoteDenom" + j);
			if (inpNoteObj.value!="" && inpObj.value!="")
			{
				if(parseInt(inpNoteObj.value)==parseInt(inpObj.value))
				{
					alert("Duplicate note denomination found!! !");
					inpObj.focus();
					return false;
				}
				if(inpObj.value==0)
				{
				alert("Note Denomination Cannot Be Zero");
				inpObj.focus();
				return false;
				}
			}
		}
	}
	return true;
}

//-----------------------------------------------------------------------------------
//Function Name	:  fnPressSubmit
//Description	:  This function submits the values entered/modified by the user to backend
//-----------------------------------------------------------------------------------
function fnPressSubmit()
{
	var objForm = document.forms[0];
		
		var output=fnValidateForm();
		if(output==false)
		{
			objForm.action="jsp/denommn003.jsp?Message=N&Details=Record not processed";
			return false;
		}
		else
		{
			objForm.action="jsp/denomdp004.jsp?PressAccept=Y";
			objForm.submit();
		}
		
}

//-----------------------------------------------------------------------------------
//Function Name	:  fnCancel
//Description	:  This function cancels the user selected operation
//-----------------------------------------------------------------------------------
function fnCancel()
{
	var objForm = document.forms[0];
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
	DISPLAYS ERROR MESSAGE RECEIVED FROM BACKEND IN THE JSP SCREEN
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
		<%=sDetails%>
	</td>
	</tr>
	</table>
</td>
</tr>
</table>
<BR>
<%
}
%>
<table class="ctable" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td  class="page-heading">Currency Denomination Maintenance</td>
	</tr>
</table>
<%
/*----------------------------------------------------------------------------------------
	DISPLAYS FUNCTION CODE AND CURRENCY DETAILS ENTERED IN THE FIRST SCREEN
------------------------------------------------------------------------------------------*/

if(!(sScrName.equals("denomdp005.scr") && sMessage.equals("Y")))
{
	if(!sMessage.equals("Result"))
	{
%>
	<table class="ctable" border="0" cellspacing="0" cellpadding="0">
	<tr >
		<td class="textlabel">&nbsp;Function :</td>
		<td class="textfielddisplaylabel">&nbsp;
		<%
			if(sFuncCode.equals("A"))
				out.write("A - ADD");
			else if(sFuncCode.equals("I"))
				out.write("I - INQUIRE");
			else if(sFuncCode.equals("M"))
				out.write("M - MODIFY");
			else if(sFuncCode.equals("D"))
				out.write("D - DELETE");
			else if(sFuncCode.equals("U"))
				out.write("U - UNDELETE");
		%>
		</td>
		<td class="columnwidth">&nbsp;</td>
		<%
			if(sFuncCode.equals("I"))
			{
		%>
		<td class="textlabel">&nbsp;Disabled :</td>
		<td class="textfielddisplaylabel">&nbsp;<%=sDisabled%></td>
		<%
			}
		%>
	</tr>

	<tr>
		<td class="textlabel">&nbsp;Currency :</td>
		<td colspan = "2" class="textfielddisplaylabel" nowrap>&nbsp;<%=sCurrency%>&nbsp;&nbsp;-&nbsp;&nbsp;<%=sCrncyName%></td>

		<td class="textlabel">&nbsp;Decimal Points Allowed :</td>
		<td colspan = "2" class="textfielddisplaylabel" nowrap>&nbsp;<%=sNumOfDecPoints%></td>
	</tr>
	</table>

<%	}
}
%>
	<table class="ctable1" width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="rowspacing" >
			<td colspan="5">&nbsp;</td>
		</tr>
	</table>

	<!-- ************************** Tab Name ********************************** -->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">
	<tr>
	<td>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
	<td valign="top">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
	<tr>
	<td>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">
	<tr>
	<td>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop1">
	<tr>
	<td class=""><SPACER type="block" height="1" width="1"></SPACER></td>
	<td class=""><SPACER type="block" height="1" width="1"></SPACER></td>
	<td class=""><spacer type="block" height=1 width=1></spacer></td>
	<td class=""><spacer type="block" height=1 width=1></spacer></td>
	<%
	if(!sMessage.equals("Result"))
	{
	%>
	<td align="right">
	<a href="javascript:showHelpFile('hdenom_det_help.htm');">
	<img class="img" align="right" hotKeyId="finHelp" src="../Renderer/images/help.gif" width="47" height="21"  vspace="1" border="0"></img></a>
	</td>
	</tr>
	<%}



/*----------------------------------------------------------------------------------------
	FOR DISPLAYING A MESSAGE WHEN RECORD IS SUCCESSFULLY ADDED/MODIFIED/DELETED
------------------------------------------------------------------------------------------*/
if(sMessage.equals("Result"))
{
%>
	<tr>
		<td width="3%">
			<img class="img" src="../Renderer/images/info.gif" width="29" height="29" align="right" border="0"></img>
		</td>
		<td width="97%"><%=sDetails%></td>
	</tr>
	<tr>
		<td></td>
		<td></td>
	</tr>
<%
}
else
{
%>
	<!-- ************************** Function ********************************** -->
	<tr>
		<td width="5%">&nbsp;</td>
		<td width="30%" class="textlabel"> Note Denomination</td>
		<td width="5%">&nbsp;</td>
		<td width="30%" class="textlabel"> Coin Denomination</td>
		<td width="30%">&nbsp;</td>
	</tr>
	<tr>
		<td width="5%">&nbsp;</td>
		<td width="30%" class="textlabel"> &nbsp;</td>
	</tr>
<%
	if(NoteArray != null)	iNoteArrayLen = NoteArray.length;
	if(CoinArray != null)	iCoinArrayLen = CoinArray.length;
/*****************************************************************************************
    Dynamically creating 15 text boxes for getting Note & Coin denominations from user.
******************************************************************************************/
	for(int i=1;i<=15;i++)
	{
%>
	<tr>
		<td width="5%">&nbsp;</td>
		<td width="30%"> 
<%/**************************************************************************************
	Populating Note Denominations during Modify/Inquire/Deleted
***************************************************************************************/%>
			<input class="textfieldfont" id="NoteDenom<%=i%>" name=custom.NoteDenom<%=i%> size="10" maxlength="15" style="WIDTH: 150px;"
			<% if (NoteArray.length > i) { %>
						value="<%=NoteArray[i]%>"
			<%	}	%>
			<%=(sFuncCode.equals("I") || sFuncCode.equals("D") || sFuncCode.equals("U"))?"readOnly":""%> >
		</td>
		<td width="5%">&nbsp;</td>
		<td width="30%">
<%/**************************************************************************************
	Populating Coin Denominations during Modify/Inquire/Deleted
***************************************************************************************/%>
			<input class="textfieldfont" id="CoinDenom<%=i%>" name=custom.CoinDenom<%=i%> size="10" maxlength="15" style="WIDTH: 150px;"
			<% if (CoinArray.length > i) { %>
				value="<%=CoinArray[i]%>"
			<%	}	%>
			<%=(sFuncCode.equals("I") || sFuncCode.equals("D"))?"readOnly":""%>	>
		</td>
		<td width="30%">&nbsp;</td>
	</tr>
<%
	}
}
%>
	<!-- ************************** /Function ********************************** -->

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
<%
/*----------------------------------------------------------------------------------------
	FOR DISPLAYING ONLY "OK" BUTTON, WHEN SUCCESS MESSAGE IS DISPLAYED
------------------------------------------------------------------------------------------*/
String sCancelValue="Cancel";
String sCancelHotKeyId="Cancel";
if((!sMessage.equals("Result")) && (!sFuncCode.equals("I")))
{
%>
	<input type="button" class="button" id="Submit" name="Submit" hotKeyId="Submit" value="Submit" onClick="fnPressSubmit();">
<%
}
else
{
	sCancelValue="Ok";
	sCancelHotKeyId="Go";
	
}
%>

	<input type="button" class="button" id="Cancel" name="Cancel" hotKeyId="<%=sCancelHotKeyId%>" value="<%=sCancelValue%>" onClick="javascript:return fnCancel();"> 
	</div>
	
	<INPUT type="Hidden" name="submitform" value="Submit">
	<INPUT type="Hidden" name="pagename" value="jsp/denomdp004.jsp">
	<INPUT type="Hidden" name="scrName" value="denomdp005.scr" >
	<INPUT type="Hidden" name="custom.FuncCode" value="<%=sFuncCode%>">
	<INPUT type="Hidden" name="custom.Currency" value="<%=sCurrency%>">
	<INPUT type="Hidden" name="custom.CrncyName" value="<%=sCrncyName%>">
	<INPUT type="Hidden" name="custom.NumOfDecPoints" value="<%=sNumOfDecPoints%>">
<script>
writeFooter();
</script>


</FORM>
</BODY>

