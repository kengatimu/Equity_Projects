<%-- This jsp file is hand coded and not generated. This menu option is developed using customization framework --%>
<%--    This is the COMMON include for any custom tab/menu which will written  --%>
<%@ include file='../custom/commonInclude.jsp'%>

<%--    The GROUPNAME specified below should be same as the value of pagename HIDDEN field below  --%>
<arjsp:init groupName="custom" isEntryPoint="true" />

<%--    The <useBean> tag has to be used for writing new custom menu options  --%>
<jsp:useBean id="customBeanInst" class="com.infy.finbranch.groups.customBean" scope="session" />

<%
customBeanInst.Refresh(pageContext, ARJspCurr, ARJspRet);
customBeanInst.populateFields(finbranch, PropertyBeanInst.getProperties(), ResourceBeanInst.getResourceBundle(pageContext, "finbranch"));

	SecurityInfo70 securityinfo=(FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
	if(null == securityinfo)
	{
		securityinfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
	}
	
	String sNextPage = "/custom/dn.jsp"; 
	customBeanInst.setPageName(sNextPage);
	
	String sAppNextPage = customBeanInst.getNextPage();
	String sParam[] = new String[] {"custValues","solIdError","custIdError","crncyCodeError","schmCodeError","glSubHeadCodeError","fromAcRangeError","toAcRangeError","mrtFileNameError"};
	String sValues[] = customBeanInst.getCustOutData(sParam);
	
	if (request.getParameter("PressAccept") != null)
	{
		try
		{
			if(sValues != null && sValues.length > 0 )
			{
	
				if("S".equals(sValues[0]))
				{
					String sMsg = "Process Initiated. Please Check Report / Status in Your Background Print / Reports Queue";
					String sGroupName = sGroupName = ARJspCurr.getCurrentGroup();
					String DN_CTRL_PAGE  = "../custom/dn.jsp";
					ARJspCurr.flushInput();
					ARJspCurr.setInput(sGroupName+".RESULT_MSG",sMsg);
					ARJspCurr.setInput(sGroupName+".RETURN_URL",DN_CTRL_PAGE );
					%>
					<jsp:forward page="../arjspmorph/INFENG/commonresultpage.jsp" />
					<%
	
				}
					
			}
			else{
				out.println("Problem in Script");
			}
	
			LinkList sGetLL = customBeanInst.getOutLL();
	
		}
		catch(Exception e)
		{
			out.println("Exception occured : "+e);
		}
	}
%>


<HTML>
<HEAD>
<TITLE> DN - Due Notice </TITLE>
<META http-equiv="Content-Type" content="text/html;charset=utf-8">
<LINK href="../Renderer/stylesheets/services.css" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />
<custom:mbuild/>
<script language="javascript" src="../Renderer/javascripts/lists/openDate.js"> </script>
<script language="javascript" src="../Renderer/javascripts/lists/showSolId.js"> </script>
<script language="javascript" src="../Renderer/javascripts/lists/showCustId.js"> </script>
<script language="javascript" src="../Renderer/javascripts/lists/showCurrency.js"> </script>
<script language="javascript" src="../Renderer/javascripts/lists/showSchemeCode.js"> </script>
<script language="javascript" src="../Renderer/javascripts/lists/showSchmCodes.js"> </script>
<script language="javascript" src="../Renderer/javascripts/lists/showAccountIdList.js"> </script>
<script language="javascript" src="../Renderer/javascripts/lists/showGLSubHeadCodeList.js"> </script>
<script language="javascript" src="../Renderer/javascripts/lists/showMRTFileList.js"> </script>

<script language="javascript" src="../Renderer/javascripts/<%=vrpInst.getFile("hotkeyprocessor_link.js")%>"> </script>

<script language="javascript">

	function fnPopulateFields()
	{
		var frm = document.forms[0];
		frm.solId.value = '<%=ARJspCurr.getInputWithGroup("solId",securityinfo.contextSolId)%>';
		frm.reportTo.value = '<%=ARJspCurr.getInputWithGroup("reportTo","")%>';
		frm.custId.value = '<%=ARJspCurr.getInputWithGroup("custId","")%>';
		frm.crncyCode.value = '<%=ARJspCurr.getInputWithGroup("crncyCode",securityinfo.homeCrncyCode)%>';
		frm.depositType.value = '<%=ARJspCurr.getInputWithGroup("depositType","")%>';
		frm.schmCode.value = '<%=ARJspCurr.getInputWithGroup("schmCode","")%>';
		frm.glSubHeadCode.value = '<%=ARJspCurr.getInputWithGroup("glSubHeadCode","")%>';
		frm.fromAcRange.value = '<%=ARJspCurr.getInputWithGroup("fromAcRange","")%>';
		frm.toAcRange.value = '<%=ARJspCurr.getInputWithGroup("toAcRange","")%>';
		frm.fromMatDate.value = '<%=ARJspCurr.getInputWithGroup("fromMatDate","")%>';
		frm.toMatDate.value = '<%=ARJspCurr.getInputWithGroup("toMatDate","")%>';
		frm.lienAc.value = '<%=ARJspCurr.getInputWithGroup("lienAc","")%>';
		frm.safeCustody.value = '<%=ARJspCurr.getInputWithGroup("safeCustody","")%>';
		frm.autoRenew.value = '<%=ARJspCurr.getInputWithGroup("autoRenew","N")%>';
		frm.principalCust.value = '<%=ARJspCurr.getInputWithGroup("principalCust","")%>';
		frm.mrtFileName.value = '<%=ARJspCurr.getInputWithGroup("mrtFileName","")%>';
		
	}
	
	var BODDate = "<%=(securityinfo.bodDate).substring(0,10)%>";
	
	function validateSubmit()
	{
	if( fnIsNull(document.forms[0].reportTo.value))
	{
		alert(finbranchResource.FAT000200);
		document.forms[0].reportTo.focus();
		return false;
	}
	if( fnIsNull(document.forms[0].solId.value))
	{
	    	alert(finbranchResource.FAT000200);
	    	document.forms[0].solId.focus();
	    	return false;
    	}
	if( fnIsNull(document.forms[0].fromMatDate.value))
	{
	    	alert(finbranchResource.FAT000200);
	    	document.forms[0].fromMatDate.focus();
	    	return false;
    	}
	else
	{
		if (validateTypes(document.forms[0])== false)
		{
			document.forms[0].fromMatDate.focus();
				return false;
		}

	}

    	if( fnIsNull(document.forms[0].toMatDate.value))
	{
		alert(finbranchResource.FAT000200);
	    	document.forms[0].toMatDate.focus();
	    	return false;
    	}
	else
	{
		if (validateTypes(document.forms[0])== false)
		{
			document.forms[0].toMatDate.focus();
			return false;
		}
	}
	
		
	if( fnIsNull(document.forms[0].principalCust.value))
	{
	    	alert(finbranchResource.FAT000200);
	    	document.forms[0].principalCust.focus();
	    	return false;
    	}
	if( fnIsNull(document.forms[0].mrtFileName.value))
	{
	    	alert(finbranchResource.FAT000200);
	    	document.forms[0].mrtFileName.focus();
	    	return false;
    	}	
		
		document.forms[0].stepScreen.value = "1";	
		document.frm.action = "dn.jsp?PressAccept=Y";
        	document.frm.submit();
	}

</script>
</HEAD>

<BODY class="cbody" onKeyDown="fnKeyDownProcessor(event)" onLoad="fnPopulateFields()" onKeyUp="fnKeyUpProcessor(event)">
<FORM method="post" name="frm">
<span class="cform">
<%@ include file="../javascripts/appl_inc.js"%>
<%@ include file="../javascripts/header.js"%>

<%
if (request.getParameter("PressAccept") != null)
{
	if("F".equals(sValues[0]))
	{
		String hyperLink[] = new String[] {"document.forms[0].solId","document.forms[0].custId","document.forms[0].crncyCode","document.forms[0].schmCode","document.forms[0].glSubHeadCode","document.forms[0].fromAcRange","document.forms[0].toAcRange","document.forms[0].mrtFileName"};
		out.println("<div id=\"errorLayer\" class=\"errorPanel cform\">");
		out.println("<table class='ctable' valign='center'>");
		out.println("<tr><td class='ccaption'>Error Message(s)</td></tr>");
		for(int count=1; count<=8; count++)
		{
			if(!(" ".equals(sValues[count])))
			out.println("<tr><td class='ctext'><a onMouseOver='displayHand(this)' onClick='fnSelectField("+hyperLink[count-1]+")'>"+sValues[count]+"</a></td></tr>");
		}
		out.println("</table>");
		out.println("</div>");
		ARJspCurr.flushInput();

	}
}
%>

<table class="ctable" cellspacing="0" cellpadding="0" border="0">
<tr>
<td class="page-heading">Due Notice</td>
</tr>
</table>

<table class="ctable1" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr class="rowspacing" >
<td colspan="5">&nbsp;</td>
</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">
<tr>
<td>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td valign="top">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td class="activetab1">Select</td>
<td class="activetab3" width="90%">&nbsp;</td>
</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
<tr>
<td>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop1">
<tr>
<td class="textlabel">Report To<script>setMandatory("Y")</script></td>	
<td class="textfield">
<INPUT TYPE="text" class="textfieldfont" name="custom.reportTo" id="reportTo" value="" size="16" maxlength = "30">
</td>
<td class="coloumnwidth">&nbsp;</td>
<td class="textlabel">Sol ID<script>setMandatory("Y")</script></td>	
<td class="textfield">
<INPUT TYPE="text" class="textfieldfont" name="custom.solId" id="solId" value= <%=securityinfo.contextSolId%> size="16" maxlength = "8" onblur="javascript:{this.value = this.value.toUpperCase();}">
<a target="_self" id="Lnk1" href='JavaScript:showSolId(document.forms[0].solId,"","F","")'>
<IMG src="../Renderer/images/search_icon.gif" width="16" height="17" border=0></a>
</td>
</tr>
			 
<tr>
<td class="textlabel">Cust. ID</td>
<td class="textfield">
<INPUT TYPE="text" class="textfieldfont" name="custom.custId" id="custId" value="" size="16" maxlength = "9" onblur="javascript:{this.value = this.value.toUpperCase();}">
<A target="_self" id="sLnk2" href='JavaScript:showCustId(document.forms[0].custId,"ctrl","F")'>
<IMG class="img" height=17 alt=Search src="../images/search_icon.gif" width=16 border=0></A>
</td>
<td class="coloumnwidth">&nbsp;</td>
<td class="textlabel">&nbsp;</td>
<td class="textfield">&nbsp;</td>
</tr>


<tr>
<td class="textlabel">CCY</td>
<td class="textfield">
<INPUT TYPE="text" class="textfieldfont" name="custom.crncyCode" id="crncyCode" value="" size="16" maxlength = "3" onblur="javascript:{this.value = this.value.toUpperCase();}">
<a id="Lnk3" href='javascript:showCurrency(document.forms[0].crncyCode,"ctrl","F","")'>
<img class="img" alt="Search" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0"></img></a>
</td>
<td class="coloumnwidth">&nbsp;</td>
<td class="textlabel">Deposit Type</td>
<td class="textfield">
<SELECT class="listboxfont" name="custom.depositType" id = "depositType">
	<OPTION value=""></OPTION>
	<OPTION value="C">C-Certificates of Deposit</OPTION>
	<OPTION value="N">N-Notice Deposit</OPTION>
	<OPTION value="R">R-Recurring Deposit</OPTION>
	<OPTION value="T">T-Other Deposits</OPTION>
	<OPTION value="F">F-FFD Deposits</OPTION>
	<OPTION value="P">P-Pool Deposit</OPTION>
	<OPTION value="M">M-Multi Pool Deposit</OPTION>
</SELECT>
</td>
</tr>

<tr>
<td class="textlabel">Scheme Code</td>
<td class="textfield">
<INPUT TYPE="text" class="textfieldfont" name="custom.schmCode" id="schmCode" value="" size="16" maxlength = "5" onblur="javascript:{this.value = this.value.toUpperCase();}">
<A target="_self" id= "sLnk7" href='JavaScript:showSchemeCode(document.forms[0].schmCode,"ctrl","F")'>
<IMG id="ilnk3"height=17 src="../images/search_icon.gif" width=16 border=0></A>
<td class="coloumnwidth">&nbsp;</td>
<td class="textlabel">GL Sub Head Code</td>
<td class="textfield">
<INPUT TYPE="text" class="textfieldfont" name="custom.glSubHeadCode" id="glSubHeadCode" value="" size="16" maxlength = "5" onblur="javascript:{this.value = this.value.toUpperCase();}">
<a target="_self" id="sLnk5" href='JavaScript:showSchmCodes(document.forms[0].schmCode,document.forms[0].glSubHeadCode,document.forms[0].solId.value,"","F","","",document.forms[0].crncyCode);'>
<img id="iLnk10" height=17 src="../Renderer/images/search_icon.gif" alt="' + jspRes.FLT001074 + '" width=16 border=0></a>
</td>
</tr>

<tr>
<td class="textlabel">From A/c. ID</td>
<td class="textfield">
<INPUT TYPE="text" class="textfieldfont" name="custom.fromAcRange" id="fromAcRange" value="" size="16" maxlength = "16" onblur="javascript:{this.value = this.value.toUpperCase();}">
<a id="sLnk6" href='javascript:showAccountIdList(document.forms[0].fromAcRange,document.forms[0].solId.value,"","F","",document.forms[0].crncyCode.value,"","",document.forms[0].solId.value,"","","","","","");'>
<img id="iLnk1" width=16 height=17 valign="top" class="img" src="../Renderer/images/search_icon.gif" border="0"></img></a>
</td>
<td class="coloumnwidth">&nbsp;</td>
<td class="textlabel">To A/c. ID</td>
<td class="textfield">
<INPUT TYPE="text" class="textfieldfont" name="custom.toAcRange" id="toAcRange" value="" size="16" maxlength = "16" onblur="javascript:{this.value = this.value.toUpperCase();}">
<a id="sLnk7" href='javascript:showAccountIdList(document.forms[0].toAcRange,document.forms[0].solId.value,"","F","",document.forms[0].crncyCode.value,"","",document.forms[0].solId.value,"","","","","","");'>
<img id="iLnk1" width=16 height=17 valign="top" class="img" src="../Renderer/images/search_icon.gif" border="0"></img></a>
</td>
</tr>

<tr>
<td class="textlabel">From Maturity Date<script>setMandatory("Y")</script></td>
<td class="textfield">
<INPUT TYPE="text" class="textfieldfont"name="custom.fromMatDate" id="fromMatDate" mnebl=' + bMnemonic + ' maxlength="10" fdt = "fdate" value="" size="16" onblur="javascript:{this.value = this.value.toUpperCase();}"
onkeyup="javascript:return fnFormatDate(document.forms[0].fromMatDate,event)" onchange = "validateTypes(document.forms[0]);">
<script>
document.write('<a target=_self id="Lnk9" href=\'javascript:openDate(document.forms[0].fromMatDate,\"'+ BODDate +'\")\'>');
document.write('<img class="img" src="../Renderer/images/calender.gif" width="24" height="20" border="0"></img></a>');
</script>
</td>
<td class="coloumnwidth">&nbsp;</td>
<td class="textlabel">To Maturity Date<script>setMandatory("Y")</script></td>
<td class="textfield">
<INPUT TYPE="text" class="textfieldfont" name="custom.toMatDate" id="toMatDate" maxlength="10" fdt = "fdate" value="" size="16" onblur="javascript:{this.value = this.value.toUpperCase();}" onkeyup="javascript:return fnFormatDate(document.forms[0].toMatDate,event)" onchange = "validateTypes(document.forms[0]);">
<script>	
document.write('<a target=_self id="Lnk10" href=\'javascript:openDate(document.forms[0].toMatDate,\"'+ BODDate +'\")\'>');
document.write('<img class="img" src="../Renderer/images/calender.gif" width="24" height="20" border="0"></img></a>');
</script>
</td>
</tr>

<tr>
<td class="textlabel">Lien A/c.</td>
<td class="textfield">
<SELECT class="listboxfont" name="custom.lienAc" id = "lienAc">
<OPTION value=""></OPTION>
<OPTION value="O">O-to select only the a/cs which have lien</OPTION>
<OPTION value="E">E-to exclude accounts which have lien</OPTION>
</SELECT>
</td>
<td class="coloumnwidth">&nbsp;</td>
<td class="textlabel">Safe Custody</td>
<td class="textfield">
<SELECT class="listboxfont" name="custom.safeCustody" id = "safeCustody">
<OPTION value="">For all accounts</OPTION>
<OPTION value="Y">Y-Deposits under safe custody only </OPTION>
<OPTION value="N">N-Otherwise</OPTION>
</SELECT>
</td>
</tr>

<tr>
<td class="textlabel">Auto Renew?<script>setMandatory("Y")</script></td>
<td class="textfield">
<SELECT class="listboxfont" name="custom.autoRenew" id = "autoRenew">
<OPTION value="N">N-No Auto Renewal</OPTION>
<OPTION value="L">L-Limited</OPTION>
<OPTION value="U">U-Unlimited</OPTION>
</SELECT>
</td>
<td class="coloumnwidth">&nbsp;</td>
<td class="textlabel">Principal Cust <script> setMandatory("Y")</script></TD>
<td class="textfield">
<SELECT class="listboxfont" name="custom.principalCust" id = "principalCust">
<OPTION value=""></OPTION>
<OPTION value="P">P-Principal account holder only</OPTION>
<OPTION value="A">A-All</OPTION>
</SELECT>
</td>
</tr>

<tr>
<td class="textlabel">Mrt File Name<script>setMandatory("Y")</script></td>
<td class="textfield">
<INPUT TYPE="text" class="textfieldfont" name="custom.mrtFileName" id="mrtFileName" value="" size="16" maxlength="20" >
<a target="_self" id="sLnk6" href='JavaScript:showMRTFileList(document.forms[0].mrtFileName,null,"DUE_NOTICE_TRN_RPT","F")'>
<img id="iLnk10" height=17 src="../Renderer/images/search_icon.gif" alt="' + jspRes.FLT001074 + '" width=16 border=0></a>
</td>
<td class="coloumnwidth">&nbsp;</td>
<td class="textlabel">&nbsp;</td>
<td class="textfield">&nbsp;</td>
</tr>
<tr>
<td colspan="5" class="rowspacingbottom"></td>
</tr>
</table>
</tr>
</td>
</table>
</tr>
</td>
</table>
</tr>
</td>
</table>
</tr>
</td>
</table>
</span>
<div align="left" class="ctable">
<INPUT TYPE="BUTTON" CLASS="button" VALUE=Go onClick="validateSubmit();">
<INPUT TYPE=RESET CLASS="button" VALUE="Clear">
</div>
<input type="hidden" name="submitform" value="Submit">
<input type="hidden" name="pagename" value="/custom/dn">
<input type="hidden" name="scrName" value="dn.scr">
<input type="hidden" name="cust.stepScreen" id="stepScreen">
<input type="hidden" name="custNames" value="">
<input type="hidden" name="custValues" value="">
</FORM>
</BODY>
</HTML>
