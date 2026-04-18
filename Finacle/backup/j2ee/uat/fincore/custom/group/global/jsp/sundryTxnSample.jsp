<%-- This jsp file is hand coded and not generated. This menu option is developed using customization framework --%>
<%-- This is the COMMON include for any custom tab/menu which will written  --%>
<%@ include file='../commonInclude.jsp'%>
<%--    The GROUPNAME specified below should be same as the value of pagename HIDDEN field below  --%>
<arjsp:init groupName="tm" isEntryPoint="false" />
<%
	FABCommon.SecurityInfo70 	securityInfo	= (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
	String 				sGroupName	= (String)ARJspCurr.getCurrentGroup();
	gcode.iface.ImenuDtl 		menuDtl 	= ((finbranchUtil.MenuMiscInfo)ARJspCurr.getInput(finbranchUtil.MenuMiscInfo.getObjectName(), null)).getMenuDtl();
	String sMenuTitle = null;
	if (menuDtl != null)
	{
		sMenuTitle = menuDtl.getmenuTitle();
	}
%>
<html>
<head>

<script>
<%-- Page level variables declaration --%>
var	frm 			= null;
var	sPopUpExceptionWindow	= '<%=ARJspCurr.getInputWithGroup("PopUpExceptionWindow", null)%>';
var	xcpnMode		= '<%=ARJspCurr.getInputWithGroup("xcpnMode","")%>';
var	funcCode		= '<%=ARJspCurr.getInputWithGroup("funcCode","")%>';
var	sReferralMode		= '<%=ARJspCurr.getInput("refSubMode" ,"")%>';	
var	BODDate			= '<%=(securityInfo.bodDate).substring(0,10)%>';
var	initSolId		= '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("initSolId",""))%>';
var	initSolDesc		= '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("initSolDesc",""))%>';
var	tranId			= '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("tranId",""))%>';
var	tranDate		= '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("tranDate",""))%>';
var	remarks			= '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("remarks",""))%>';
var	tmplId			= '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("tmplId",""))%>';
var	tranType		= '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("tranType",""))%>';
var	tranSubType		= '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("tranSubType",""))%>';
var	tranStatus		= '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("tranStatus",""))%>';
var	isAcctValid 		= '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("isAcctValid",""))%>';
var	menuTitle		= '<%=sMenuTitle%>';
var	group			= '<%=sGroupName%>';

function fnPopulateControlValues()
{	
	frm = document.forms[0];
		
	frm.valueDate.value 		= BODDate;
	frm.glDate.value		= BODDate;
	frm.acctId.value		= '<%=ARJspCurr.getInputWithGroup("acctId","")%>';
	frm.refAmt.value		= '<%=ARJspCurr.getInputWithGroup("refAmt","")%>';
	frm.pTranType.value		= '<%=ARJspCurr.getInputWithGroup("pTranType","")%>';
	frm.refCrncy.value		= '<%=ARJspCurr.getInputWithGroup("refCrncy","")%>';
	frm.rateCode.value		= '<%=ARJspCurr.getInputWithGroup("rateCode","")%>';
	frm.rate.value			= '<%=ARJspCurr.getInputWithGroup("rate","")%>';
	frm.valueDate.value		= '<%=ARJspCurr.getInputWithGroup("valueDate","")%>';
	frm.glDate.value		= '<%=ARJspCurr.getInputWithGroup("glDate","")%>';
	frm.acctLabelCrncy.value	= '<%=ARJspCurr.getInputWithGroup("acctLabelCrncy","")%>';
}

</script>

<TITLE>Finacle 10.0</TITLE>
<META http-equiv="Content-Type" content="text/html;charset=utf-8">
<LINK href="../../Renderer/stylesheets/services.css" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />
<script language="javascript" src='../Renderer/javascripts/<%=VRPKeys.getFile("core_banking.js",sProfileId)%>' > </script>

<script language="javascript" src='../Renderer/javascripts/lists/<%=VRPKeys.getFile("showRefCode.js",sProfileId)%>' > </script>
<script language="javascript" src='../Renderer/custom/javascripts/<%=VRPKeys.getFile("sundryTxnSample.js",sProfileId)%>' > </script>
<script language="javascript" src='../Renderer/javascripts/<%=VRPKeys.getFile("tm_validations.js",sProfileId)%>' > </script>
<script language="javascript" src='../Renderer/javascripts/<%=VRPKeys.getFile("tm_functions.js",sProfileId)%>' > </script>
</head>

<body onLoad = "fnOnLoad()">
<form method="post" action="../tm/tm_ctrl.jsp" name="test">
<span class="cform">

<%@ include file="../../javascripts/appl_inc.js" %>
<%@ include file="../../javascripts/header.js"%>
<%@ include file="../../javascripts/display_err.js" %>

<script>
printBlock();	
</script>

<div class="ctable">

<script>
printFooterBlock();
</script>

<input type="hidden" 	name="tm.acctCrncyAmt" 			id="acctCrncyAmt">
<input type="hidden" 	name="tm.acctCrncy" 			id="acctCrncy">
<input type="hidden" 	name="tm.delFlg" 			id="delFlg">
<input type="hidden" 	name="submitform" 			id="submitform">
<input type="hidden" 	name="FocusField" 			id="FocusField" >
<input type="hidden" 	name="tm.serialNo" 			id="serialNo">
<input type="hidden" 	name="tm.partTranDetail.direction"	id="direction">
<input type="hidden" 	name="tm.partTranDetail.IsPageEmpty"	id="IsPageEmpty">

</div>

</form>
</span>
</body>
</html>
