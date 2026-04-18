<%--  	View Status Report 

	This jsp file is hand coded and not generated. 
	This file can be customized at sites for View Status Report of EOD operations.
	The file name of this jsp should not be changed.
	This file should reside in finbranch/custom/jsp folder	--%>


<%--    This is the COMMON include for any custom tab/menu --%>
<%@ include file='../commonInclude.jsp'%>

<%@ page import="com.infy.bbu.ons.common.CommonConstants" %>

<%--    The GROUPNAME specified below should be same as the value of pagename HIDDEN field below  --%>
<arjsp:init groupName="batch" isEntryPoint="true" />

<html>
<head>
<title>View Status Report</title>
<!-- InstanceEndEditable -->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../css/finacle.css">
 <script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}
</script>
<script>

var frm = null;
var scriptName = "ebViewStatusReport.scr";
var refreshReqd = 'N';

function fnOnLoad() {

	frm = document.forms[0];
	var REFRESH_INTERVAL 	= 60000;
	var count 				= 2;
	var statusAreaStr 		= "";
	var token				= "";

	setTimeout("fnRefresh()",REFRESH_INTERVAL);
	if(refreshReqd == 'Y')
	{
		var outputEBdata 		= appFnExecuteScript(mopId.toUpperCase(),"",scriptName,false);
		if(!fnIsNull(outputEBdata)) {
			token 				= outputEBdata.split("|");
		}

		for (count = 3; count < token.length; count++)
		{ 
			statusAreaStr += token[count] + "\n";
			count++;
		}

		frm.statusArea.value = statusAreaStr;

		if(token[2] == "FAIL")
		{
			alert(token[3]);
		}
		else if(token[0] == "COMPLETED")
		{
			alert(token[1]);
			setTimeout("fnRefresh()",3000000);
		}
		/*else
		{
			setTimeout("fnRefresh()",REFRESH_INTERVAL);
		}*/
	}
	refreshReqd = 'Y';

}

function fnRefresh()
{
	fnOnLoad();
}

function printFooterBlock()
{
    with (document)
	{
		write('<input type="button" class="Button" id="Refresh" value="Refresh" onClick="javascript:return fnRefresh(this.id);" hotKeyId="Accept" >');
		write('<input type="button" class="Button" id="OK" value="OK" onClick="javascript:return fnCancelForm(this.id);" hotKeyId="OK" >');
	}
} 

function fnCancelForm(objButton)
{
	frm.submitform.value 	= objButton;	
	frm.actionCode.value 	= objButton;
	doSubmitForm(objButton); 	
	
	return true;
}

</script>
</head>

<TITLE>View Status Report</TITLE>
<META http-equiv="Content-Type" content="text/html;charset=utf-8">
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getResourceFile("finbranchResource_"+LocaleMapper.getLangCode(pageContext)+".js") %>"  > </script> 
<LINK href="../Renderer/stylesheets/services.css" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />
<custom:mbuild/>
<script language="javascript" src="../MenuRenderer/mtree/01_GU_BT_999_INFENG_FIN.js"></script>
<script language="javascript" src="../Renderer/mtree/precArray.js"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("core_banking.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("resource_functions.js",sProfileId)%>" > </script>
</head>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("common_functions.js",sProfileId)%>" > </script>
<body onLoad = "fnOnLoad();">
<form method="post" onsubmit="javascript:return false" action="../batch/batch_ctrl.jsp">
<span class="cform">
<%@ include file="../../javascripts/appl_inc.js" %>
<%@ include file="../../javascripts/header.js"%>
<BODY class="cbody" onKeyDown="fnKeyDownProcessor(event)" onLoad="fnPopulateFields()" onKeyUp="fnKeyUpProcessor(event)">
<table border="0" cellspacing="0" cellpadding="0" class="ctable">
<tr>
<td>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<script>
var menuId= "<%=ParseValue.checkString(((finbranchUtil.MenuMiscInfo)ARJspCurr.getInput(finbranchUtil.MenuMiscInfo.getObjectName(), null)).getMopId())%>";
menuId= menuId.toUpperCase(); 
document.write('<td class="page-heading"> View Status Report - '+menuId+'</td>');
</script>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td valign="top">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">
<tr>
<td>
<table width="100%" border="0" cellpadding="0" cellspacing="0"class="innertable">
<tr>
<td><table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr class="innertabletop1">
<td colspan="5" align="right"><table border="0" cellspacing="0" cellpadding="0">
</table></td>
</tr>
<%-- This HIDDEN field is required for the customized data to be populated/retrieved.** --%>
<input type="hidden" name="customData" id ="customData">
<input type="hidden" name="actionCode" id="actionCode">
<input type="Hidden" name="pagename" value="batch">
<input type="Hidden" name="submitform" value="">
<input type="Hidden" name="callPage" value="self">
<input type="hidden" name="uadinfo" id ="uadinfo">
<script>document.write('<input type="Hidden" name="rtId" id="rtId" value="'+rtId+'">') 
</script> 
<tr></tr>
<tr></tr>
<tr>
<td class="textfield">
<textarea  name="batch.statusArea" id="statusArea" value="" size="100" cols="163" rows="20" readonly="readonly"></textarea>
</td>
</tr>
</table>
</table>
</td>
</tr>
</table></td>
</tr>
</table></td>
</tr>
</table></td>
</tr></table>
<div class="ctable">
<script> printFooterBlock(); </script>
</div>
</form>
</span>
</body>
</html>
