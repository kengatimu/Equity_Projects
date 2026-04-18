<%/*---------------------------------------------------------------------------------------
NAME                :   hcashx_denomDetails.jsp
Menu                :   HCASHX
Called JSP          :   None
Called Script       :   None
Description         :   This jsp is used for displaying dedom details details 
Author              :   Nitin Kumar
Date                :   02-Aug-2013
Module              :   HCASHX
Modification History:

<Serial No.>     <Date>         <Author Name>           <Description>
-------------   ---------       ------------------      ----------------
1               02-08-2013      Nitin Kumar       	Base Version
2		28-08-2013	Anik Soni	Changes made for TOL 368861
-------------------------------------------------------------------------------------*/%>
<%@ page contentType="text/html; charset=utf-8" %>
<%!
        public static final String _ARJSP_JSP_NAME = "custom/hcashx_denomDetails.jsp";
%>
<%@ include file="../../finbranch_common.jsp"   %>
        <%-- PAGE LEVEL IMPORTS  --%>
<%@ page import="FABInquiry.*" %>
<%@ page import="com.infy.COTP.*, com.infy.finbranch.groups.customBean" %>

<arjsp:init groupName="arjspmorph" isEntryPoint="false" />
<%
         String sProfileId   = ProfilesManager.getProfileInSession(session);
%>

<%
      	String pageTitle = request.getParameter("pageTitle");
	String sBaseHref = (String)pageContext.getAttribute("_ARJspApplicationBaseHref_", PageContext.SESSION_SCOPE);

	String bankName 	= request.getParameter("bankName");
	String branchName 	= request.getParameter("branchName");
	String empName 		= request.getParameter("empName");
	String creditCrncy 	= request.getParameter("creditCrncy");
	String debitCrncy 	= request.getParameter("debitCrncy");
	String totalCredit 	= request.getParameter("totalCredit");
	String totalDebit 	= request.getParameter("totalDebit");
	String homeCrncy 	= request.getParameter("homeCrncy");
	String userId           = request.getParameter("userId");
	String bodDate          = request.getParameter("bodDate");
	
	String creditNotes[] 		= new String[15];
	String creditNotesValue[] 	= new String[15];
	String debitNotes[] 		= new String[15];
	String debitNotesValue[] 	= new String[15];
	String creditCoins[] 		= new String[15];
	String creditCoinsValue[] 	= new String[15];
	String debitCoins[] 		= new String[15];
	String debitCoinsValue[] 	= new String[15];
	

	for(int i = 0;i<15;i++)
	{
		creditNotes[i] 		= request.getParameter("creditNotes[" + i + "]");
		creditNotesValue[i] 	= request.getParameter("creditNotesValue[" + i + "]");
		debitNotes[i] 		= request.getParameter("debitNotes[" + i + "]");
		debitNotesValue[i] 	= request.getParameter("debitNotesValue[" + i + "]");
		creditCoins[i] 		= request.getParameter("creditCoins[" + i + "]");
		creditCoinsValue[i] 	= request.getParameter("creditCoinsValue[" + i + "]");
		debitCoins[i] 		= request.getParameter("debitCoins[" + i + "]");
		debitCoinsValue[i] 	= request.getParameter("debitCoinsValue[" + i + "]");
	}
	
%>

<html>
<head>

<% if (null != sBaseHref) { %>
<base href="<%=sBaseHref+"/finbranch/custom/"%>">
<% } %>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>Denom Details</title>
<script language="javascript" src="../Renderer/custom/javascripts/common_functions.js"></script>
<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />

<script language="javascript">

 var bankName 		= '<%=bankName%>' ;
 var branchName 	= '<%=branchName%>' ;
 var empName 		= '<%=empName%>' ;
 var creditCrncy 	= '<%=creditCrncy%>' ;
 var debitCrncy 	= '<%=debitCrncy%>' ;
 var totalCredit 	= '<%=totalCredit%>' ;
 var totalDebit 	= '<%=totalDebit%>' ;
 var homeCrncy	 	= '<%=homeCrncy%>' ;
 var userId             = '<%=userId%>' ;
 var bodDate            = '<%=bodDate%>' ;
 
 var creditNotes 	= new Array(15) ;
 var creditNotesValue 	= new Array(15) ;
 var debitNotes 	= new Array(15) ;
 var debitNotesValue 	= new Array(15) ;
 var creditCoins 	= new Array(15) ;
 var creditCoinsValue 	= new Array(15) ;
 var debitCoins 	= new Array(15) ;
 var debitCoinsValue 	= new Array(15) ;
 var blank = "";


<%for(int i=0; i<15; i++){%>

creditNotes[<%=i%>] 		= "<%=creditNotes[i]%>";
creditNotesValue[<%=i%>] 	= "<%=creditNotesValue[i]%>";
debitNotes[<%=i%>] 		= "<%=debitNotes[i]%>";
debitNotesValue[<%=i%>] 	= "<%=debitNotesValue[i]%>";
creditCoins[<%=i%>] 		= "<%=creditCoins[i]%>";
creditCoinsValue[<%=i%>] 	= "<%=creditCoinsValue[i]%>";
debitCoins[<%=i%>] 		= "<%=debitCoins[i]%>";
debitCoinsValue[<%=i%>] 	= "<%=debitCoinsValue[i]%>";

<%}%>

function fnPrintForm()
{

document.getElementById('accept').style.visibility='hidden';
document.getElementById('Cancel').style.visibility='hidden';

getPrint("div4");
document.getElementById('accept').style.visibility='visible';
document.getElementById('Cancel').style.visibility='visible';
//oCell.innerHTML = '<BR><INPUT class="button" TYPE="button" NAME="Accept" id = "accept" VALUE="ACCEPT" onclick="fnPrintForm();"> <INPUT class="button" TYPE="button" NAME="Cancel" id = "can" VALUE="CANCEL" onclick="fnCancel()">';
}

function getPrint(print_area)
{
    //Creating new page
    var pp = window.open();
//Adding HTML opening tag with HEAD portion
    pp.document.writeln('<HTML><HEAD><title>Print Preview</title></head>');
//<LINK href="/finbranch/custom/stylesheets/Styles.css"  type="text/css" rel="stylesheet">');
//  pp.document.writeln('<LINK href="/finbranch/custom/stylesheets/PrintStyle.css"  type="text/css" rel="stylesheet" media="print"><base target="_self"></HEAD>')
    pp.document.writeln('<style>');
    pp.document.writeln('BODY {');
    pp.document.writeln('font-family:Arial, Verdana, Geneva, Helvetica, sans-serif;');
    pp.document.writeln('font-size:8px;');
    pp.document.writeln('background:#ffffff;');
    pp.document.writeln('padding: 0px;');
    pp.document.writeln('height: 8.3in;');
    pp.document.writeln('width: 5.8in;');
    pp.document.writeln('margin: 2cm;');
    pp.document.writeln('media: print;');
    pp.document.writeln('}');
    pp.document.writeln('</style>');
    //Adding Body Tag
    pp.document.writeln('<body MS_POSITIONING="GridLayout" bottomMargin="0" leftMargin="0" topMargin="0" rightMargin="0">');
    //Writing print area of the calling page
    pp.document.writeln(document.getElementById(print_area).innerHTML);
    //Ending Tag of BODY and HTML
    pp.document.writeln('</body></HTML>');
    //Added by Santhosh for QC id: 2255
    //Removed the code for print and close buttons
    window.print();
//Added by Parikshith
	pp.close();
}

fnPrintTranDetails();

function fnPrintTranDetails(){
        with (document){
        write('<!-- HEADERBLOCK-BEGIN -->');
        write('<div id="div4" name="div4" class="ctable">');
        write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
        write('<tr>');
        write('<td>');
        write('<table border="0" colspan="5" cellpadding="0" cellspacing="0" width="100%">');
        write('<!-- HEADERBLOCK-END -->');
        write('<!-- DETAILSBLOCK-BEGIN -->');
        write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
        write('<tr>');
        write('<td valign="top">');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
        write('<tr>');
        write('<td>');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
        write('<tr>');
        write('<td>');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');
        write('<tr>');
        write('<td height="25" colspan="5" align="right">');
        write('<table border="0" cellspacing="0" cellpadding="0">');
        write('</table>');
        write('</td>');
        write('</tr>');
        
	write('<h4>'+bankName+'</h4>');
	
	write('<h4>'+branchName+'</h4>');
	
	write('<h4>CASH EXCHANGED RECIEPT</h4>');
	write('<tr style="height:60px;">');
	write('<td class="textlabel">Amount Received : '+totalCredit+' '+creditCrncy+'</td>');
	write('</tr>');
	write('<table border="1" bordercolor="black" cellspacing="0" cellpadding="0" style="float:left;margin-right:10px;margin-bottom:30px;">');
	write('<tr>');
	write('<th>Notes Denomination</th>');
	write('<th>Number</th>');
	write('</tr>');
	write('<tr>');
	for(var i = 0;i<15;i++)
	{
		if(!isNaN(creditNotesValue[i]))
		{
			write('<tr>');
			if(!isNaN(creditNotesValue[i]))
			{
				write('<td>'+creditNotesValue[i]+'</td>');
				write('<td>'+creditNotes[i]+'</td>');
			}
			else
			{
				write('<td>'+blank+'</td>');
				write('<td>'+blank+'</td>');
			}
			write('</tr>');
		}
	}
	write('</table>');
	//////////////////////
        write('<tr style="height:60px;">');
        write('<td class="textlabel"></td>');
        write('</tr>');

	if(creditCrncy == homeCrncy)
	{
		write('<table border="1" bordercolor="black" cellspacing="0" cellpadding="0" style="float:left;margin-bottom:30px;">');
		write('<tr>');
		write('<th>Coins Denomination</th>');
		write('<th>Number</th>');
		write('</tr>');
		write('<tr>');
		for(var i = 0;i<15;i++)
		{
			if(!isNaN(creditCoinsValue[i]))
			{
				write('<tr>');
				if(!isNaN(creditCoinsValue[i]))
				{
					write('<td>'+creditCoinsValue[i]+'</td>');
					write('<td>'+creditCoins[i]+'</td>');
				}
				else
				{
					write('<td>'+blank+'</td>');
					write('<td>'+blank+'</td>');
				}
				write('</tr>');
			}
		}
	
		write('</table>');
	}
	
	/////////////////////////
		
	write('<tr style="height:60px;">');
	write('<td class="textlabel">Amount Given Out : '+totalDebit+' '+debitCrncy+'</td>');
	write('</tr>');

	write('<table border="1" bordercolor="black" cellspacing="0" cellpadding="0" style="float:left;margin-right:10px;margin-top:10px;">');
	write('<tr>');
	write('<th>Notes Denomination</th>');
	write('<th>Number</th>');
	write('</tr>');
	for(var i = 0;i<15;i++)
	{
		if(!isNaN(debitNotesValue[i]))
		{
			write('<tr>');
			if(!isNaN(debitNotesValue[i]))
			{
				write('<td>'+debitNotesValue[i]+'</td>');
				write('<td>'+debitNotes[i]+'</td>');
			}
			else
			{
				write('<td>'+blank+'</td>');
				write('<td>'+blank+'</td>');
			}
			write('</tr>');
		}

	}
	write('</table>');
	
	////////////////////////

        write('<tr style="height:60px;">');
        write('<td class="textlabel"></td>');
        write('</tr>');


	if(debitCrncy == homeCrncy)
	{
		write('<table border="1" bordercolor="black" cellspacing="0" cellpadding="0" style="float:left;margin-top:10px;">');
		write('<tr>');
		write('<th>Coins Denomination</th>');
		write('<th>Number</th>');
		write('</tr>');
		for(var i = 0;i<15;i++)
		{
			if(!isNaN(debitCoinsValue[i]))
			{	
				write('<tr>');
				if(!isNaN(debitCoinsValue[i]))
				{
					
					write('<td>'+debitCoinsValue[i]+'</td>');
					write('<td>'+debitCoins[i]+'</td>');
					
				}
				else
				{
					
					write('<td>'+blank+'</td>');
					write('<td>'+blank+'</td>');
					
				}
				write('</tr>');
			}
			
		}	
		write('</table>');
	}

	//////////////

	write('<br>');
	
	write('<tr style="height:60px;">');
	write('<td class="textlabel">Customer signature: __________________ </td>');
	write('</tr>');
	write('<br>');
	write('<tr style="height:60px;">');
	write('<td class="textlabel">You were served by: '+empName+' '+userId+'</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">Print Time: '+bodDate+'</td>');
        write('</tr>');
	
	write('</table>');
        write('</td>');
        write('</tr>');
        write('</table>');
        write('</td>');
        write('</tr>');
        write('</table>');
        write('</td>');
        write('</tr>');
        write('</table>');
        write('<!-- DETAILSBLOCK-END -->');
        write('<br>');
        write('&nbsp;<input class="button" type="button" id="Cancel" value="OK" onClick="javascript:return window.close()" >');
        document.write('<input id="accept" name="Accept" type="button" class="button" value="Print"	onClick="javascript: fnPrintForm();"></input> ');
        document.write('</div>');
        } //End with()
}

</script>
</head>
</html>
