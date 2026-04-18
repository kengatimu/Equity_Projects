<%--
Title						:	WorkFlow Controller - wflow.jsp
Date of Creation				:	08-10-2003
Funcutanality					: 	Work Flow for doing customer add and sb account opening .
--%>
<%@ page language="java" %>
	<%-- DEFAULT IMPORTS OF JSP SKEL GEN --%>
<%@ page import="com.infy.bbu.jsputil.*,java.util.*" %>
<%@ page import="FABCommon.SecurityInfo70" %>
<%@ page import="com.infy.finbranch.groups.cummBean" %>
<%@ page import="com.infy.finbranch.groups.sbacopBean" %>
<%!
	public static final String _ARJSP_JSP_NAME = "workflow/wflow.jsp";
%>

<%@ include file="../finbranch_common.jsp" %>
	<%-- PAGE LEVEL IMPORTS  --%>
<%@ page import="FABProcess.*" %>
	<%-- DEFAULT BEANS OF GENERATOR --%>

<%-- CONTEXT BEAN  --%>
<%
	String _ARJSP_TITLE_NAME = "WorkFlow";
	com.infy.finbranch.groups.finbranch_sessionBean finbranch;
	synchronized(session) {
		finbranch = (com.infy.finbranch.groups.finbranch_sessionBean) session.getAttribute("finbranch");
		if (finbranch == null) {
			finbranch = (com.infy.finbranch.groups.finbranch_sessionBean)CustomMapper.fetchClassInstance("com.infy.finbranch.groups.finbranch_sessionBean");
			session.setAttribute("finbranch", finbranch);
		}
	}
	
	

%>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
	<%-- APPLICATION LEVEL IMPORTS --%>
<%@ page import="fabclasses.*" %>

<arjsp:init groupName="workflow" isEntryPoint="true"/>

<%
	int	 iStatus = 1;
	String sGroupName= "workflow";
	String sGroupName1 =(String)ARJspCurr.getInput("GroupName",null);
	session.setAttribute("fin_GroupName",sGroupName1);
	
	SecurityInfo70 securityInfo = (SecurityInfo70)session.getAttribute("FinUserInfo");
	if(securityInfo != null)
	{
		securityInfo.sameUsrVfyFlg = 'Y';
		session.setAttribute("FinUserInfo",securityInfo);		
	}
	securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
	if(securityInfo != null)
	{
		securityInfo.sameUsrVfyFlg = 'Y';
		session.setAttribute("UserInfo",securityInfo);
	}
	
	String [] Steps = new String[4];
	Steps[0] ="../cumm/cumm_ctrl.jsp?submitform=Accept&pagename=cumm";
	Steps[1]= "../cumm/cumm_ctrl.jsp?submitform=Accept&pagename=cumm";
	Steps[2]= "../sbacop/sbacop_ctrl.jsp?mo=HOAACSB&submitform=Accept&pagename=sbacop";
	Steps[3]= "../sbacop/sbacop_ctrl.jsp?mo=HOAACVSB&submitform=Accept&pagename=sbacop&sbacop.verifyCancel=V";

	Integer NextStep = null;
	String sNextStep = null;

	NextStep = (Integer)ARJspCurr.getInput("_NextStep_", new Integer(0));
	sNextStep = (NextStep.intValue() == Steps.length) ? "" : Steps[NextStep.intValue()];
	
	if(sNextStep != null && !sNextStep.equals(""))
	{
		ARJspCurr.setInput("_NextStep_", new Integer(NextStep.intValue()+1));
%>
		<arjsp:call targetPath="<%=sNextStep%>" returnPath="../workflow/wflow.jsp">
<%
		if(NextStep.intValue() == 0)
		{
				sGroupName="cumm";
				if (ARJspNew.getInput(sGroupName+".action",null) == null)
				{
					ARJspNew.setInput(sGroupName+".wflow","Y");
					ARJspNew.setInput(sGroupName+".func","A");
					ARJspNew.setInput(sGroupName+".custId","CUSTX12");				
					
					//custper
					ARJspNew.setInput(sGroupName+".custTitleCode","MR.");
					ARJspNew.setInput(sGroupName+".custName","WTEST");
					ARJspNew.setInput(sGroupName+".custShortName","WTEST");
					
					//custgen
					ARJspNew.setInput(sGroupName+".custIntrodCustId","D1705");
					ARJspNew.setInput(sGroupName+".tdsTblCode","ITAX");
					
					//custaddr
					ARJspNew.setInput(sGroupName+".address1","Y");
					ARJspNew.setInput(sGroupName+".cityCode","BANGA");
					ARJspNew.setInput(sGroupName+".stateCode","KA");
					ARJspNew.setInput(sGroupName+".postalCode","56000");
					ARJspNew.setInput(sGroupName+".cntryCode","IN");
					
					//ccydet
					ARJspNew.setInput(sGroupName+".crncyCode","INR");
					ARJspNew.setInput(sGroupName+".withHldTaxPcnt","3");
					ARJspNew.setInput(sGroupName+".flrLmtForWithHldTax","3.00");
					ARJspNew.setInput(sGroupName+".crCustPref","3");
					ARJspNew.setInput(sGroupName+".drCustPref","3");
					
				}
		}
		if(NextStep.intValue() == 1)
		{
				sGroupName="cumm";
				ARJspNew.flushInput();
				if (ARJspNew.getInput(sGroupName+".action",null) == null)
				{
					ARJspNew.setInput(sGroupName+".wflow","Y");
					ARJspNew.setInput(sGroupName+".func","V");
					ARJspNew.setInput(sGroupName+".custId","CUSTX12");
					String[] saVisitedStatus = {"1","1","1","1","1","1","1","1","1","1","1","1"};
					ARJspNew.setInput(sGroupName+".VisitedStatus",saVisitedStatus);					
					
				}	

		}
		if(NextStep.intValue() == 2)
		{
				sGroupName="sbacop";
				ARJspNew.flushInput();
				if (ARJspNew.getInput(sGroupName+".action",null) == null)
				{
					ARJspNew.setInput(sGroupName+".wflow","Y");
					ARJspNew.setInput(sGroupName+".permForacid","1231809");
					ARJspNew.setInput(sGroupName+".schmCode","SBGEN");
					ARJspNew.setInput(sGroupName+".custId","CUSTX12");
					ARJspNew.setInput(sGroupName+".glSubHeadCode","00010");
					
					//GENDTLS
					ARJspNew.setInput(sGroupName+".acctName","CUSTX12");
					ARJspNew.setInput(sGroupName+".acctShortName","CUST");
					ARJspNew.setInput(sGroupName+".acctOpenDate","22-11-2002");
					
					//INTEREST
					ARJspNew.setInput(sGroupName+".intCrAcctNum","SB1");
					ARJspNew.setInput(sGroupName+".intDrAcctNum","SB1");
					
					String[] saVisitedStatus = {"1","1","1","1","1","1","1","1","1","1","1"};
					ARJspNew.setInput(sGroupName+".VisitedStatus",saVisitedStatus);
				}	

		}
		if(NextStep.intValue() == 3)
		{
				sGroupName="sbacop";
				ARJspNew.flushInput();
				if (ARJspNew.getInput(sGroupName+".action",null) == null)
				{
					ARJspNew.setInput(sGroupName+".wflow","Y");
					ARJspNew.setInput(sGroupName+".verifyCancel","V");
					ARJspNew.setInput(sGroupName+".tempForacid","1231809");
					String[] saVisitedStatus = {"1","1","1","1","1","1","1","1","1","1","1"};
					ARJspNew.setInput(sGroupName+".VisitedStatus",saVisitedStatus);
				}	

		}

%>
		</arjsp:call>
<%
	}
	else
	{
	securityInfo = (SecurityInfo70)session.getAttribute("FinUserInfo");
	if(securityInfo != null)
	{
		securityInfo.sameUsrVfyFlg = ' ';
		session.setAttribute("FinUserInfo",securityInfo);
	}
	securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
	if(securityInfo != null)
	{
		securityInfo.sameUsrVfyFlg = ' ';
		session.setAttribute("UserInfo",securityInfo);
	}
	
	
%>
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
  <title>Work Flow</title> 
  <script language="javascript" src="../Renderer/javascripts/finbranchResource_<%= LocaleMapper.getLangCode(pageContext)%>.js" > </script> 
  <LINK href="../Renderer/stylesheets/services.css" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />
	<%-- PAGE LEVEL LINKS  --%>
  <script language="javascript" src="../Renderer/javascripts/dynamic_combo.js" > </script>
  <script language="javascript" src="../Renderer/javascripts/cust_functions.js" > </script>
  <script language="javascript" src="../Renderer/javascripts/login_common_functions.js" > </script>
  <script language="javascript" src="../Renderer/javascripts/common_functions.js" > </script>
  <script language="javascript" src="../Renderer/javascripts/hotkeyprocessor_link.js" > </script>
  <script language="javascript" src="../Renderer/javascripts/menuLayer.js" > </script>
  <%-- PAGE LEVEL INCLUDES  --%>
<%@ include file="../javascripts/time_out.js" %>
</head>
<body class="cbody">
	<form name="<%=sGroupName%>" onSubmit="return false;" method="post" action="../workflow/wflow.jsp">
	<%@ include file="../javascripts/header.js" %>
	<span class="cform">
	<table class="ctable">
	<tr><td class="ctext">
	<center><br><h3>End of workflow.</h3></center>
	</tr></td>
	</table>
	</span>
	</form>		
<%
	}
%>
</body>
</html>


