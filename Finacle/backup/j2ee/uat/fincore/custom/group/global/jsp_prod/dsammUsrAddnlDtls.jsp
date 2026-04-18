<%--
/*
 *	DSA Master Maintenance - User Additional Details.
 *
 *	This jsp file is hand coded and not generated.
 *	This file can be customized at sites for User Additional Details sub option in HDSAMM.
 *	The file name of this jsp should not be changed.
 *	This file should reside in finbranch/custom/jsp folder
 *	*/
--%>


<%-- This is the COMMON include for any custom tab/menu --%>
<%@ include file='../commonInclude.jsp'%>
<% 
	response.setHeader("Pragma","No-Cache"); 
	response.setDateHeader("Expires",0); 
	response.setHeader("Cache-Control","no-Cache,no-store"); 
%> 


<%@ page import="com.infy.bbu.ons.common.CommonConstants" %>
<%@ page import="fabclasses.*" %>

<%-- The GROUPNAME specified below should be same as the value of pagename HIDDEN field below  --%>
<arjsp:init groupName="custom" isEntryPoint="false"/>
<% 
   fabclasses.FinSessionInit.validateMorphReq(pageContext, ARJspCurr); 
%> 


<html>
<head>

<title>Finacle 10.0</title>
<META HTTP-EQUIV="PRAGMA" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache,no-store">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<!-- InstanceEndEditable -->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../css/finacle.css">
 <script language="JavaScript" type="text/JavaScript">
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
<script language="JavaScript1.2" src="../scripts/calendar.js"></script>
<script language="JavaScript1.2" src="../scripts/tjmlib.js"></script>
<script language="JavaScript1.2" src="../scripts/textfield.js"></script>
<script language="JavaScript1.2" src="../scripts/FrequencyIndicator.js"></script>
<SCRIPT LANGUAGE="JavaScript1.2" FOR="document" EVENT="onkeyup"> </SCRIPT>


<script>
var frm = null;
var sPopUpExceptionWindow = null;
var funcCode = null;

function fnOnLoad() {
	frm = document.forms[0];
	sPopUpExceptionWindow = '<%=ARJspCurr.getInputWithGroup("PopUpExceptionWindow", null)%>';
	funcCode = '<%=ARJspCurr.getInputWithGroup("funcCode", null)%>';
	initFocusHandler();
	frm.customData.value = '<%=(String)ARJspCurr.getInputWithGroup("custData", null)%>';
	getCustomFieldValue("freeFld1","freeFld2","freeFld3","freeFld4");

	if (funcCode == Const.ADD_MODE || funcCode == Const.MODIFY_MODE || funcCode == Const.COPY_MODE) {
		frm.freeFld1.focus();
	} else {
		frm.endMenu.focus();
		disableFormElements(4);
		frm.Accept.focus();
	}
}

function fnValidateForm(btnObjId) {
	//Used to set the custom data in the hidden field
	setCustomFieldValue("freeFld1","freeFld2","freeFld3","freeFld4");
	frm.submitform.value = btnObjId;
	return true;
}

function fnOnButtonClick(btnObjId) {
	if (btnObjId == Const.ACTION_ACCEPT) {
		if (!fnValidateForm(btnObjId))
			return false;
		frm.submitform.value = "submitUAD";
		frm.actionCode.value = "submitUAD";
		doSubmitForm("submitUAD");
	} else if (btnObjId == Const.ACTION_CANCEL) {
		if (funcCode == Const.ADD_MODE || funcCode == Const.MODIFY_MODE || funcCode == Const.COPY_MODE) {
			if (!confirm(finbranchResource.FAT000925))
				return false;
		}
		frm.submitform.value = btnObjId;
		frm.actionCode.value = btnObjId;
		doSubmitForm(btnObjId);
	}
	return true;
}

function printFooterBlock() {
	if (funcCode == Const.INQUIRE_MODE) {
		with (document) {
			write('<input type="button" class="Button" id="endMenu" value="Ok" onClick="javascript:return fnLastButtonClick();" hotKeyId="endMenu">');
		}
	} else {
		with (document) {
			write('<input type="button" class="Button" id="Accept" value="Submit" onClick="javascript:return fnOnButtonClick(this.id);" hotKeyId="Accept">');
			write('<input type="button" class="Button" id="Cancel" value="Cancel" onClick="javascript:return fnOnButtonClick(this.id);" hotKeyId="Cancel">');
		}
	}
}
</script>
<link href="../Renderer/stylesheets/services.css" rel="stylesheet"  title="Finacle Stylesheet" type=text/css />
<custom:mbuild/>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("core_banking.js",sProfileId)%>" > </script>
</head>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("common_constants.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("resource_functions.js",sProfileId)%>" > </script>
<%@ include file="../../javascripts/appl_inc.js" %>
<body onLoad = "fnOnLoad();">
<form method="post" action="./custom_ctrl.jsp">
<span class="cform">
<%@ include file="../../javascripts/header.js"%>
<%@ include file="../../javascripts/dsammtabheading_inc.js" %>
<%@ include file="../../javascripts/tabgen_inc.js" %>
<%-- These HIDDEN fields are required for the customized data to be populated/retrieved.** --%>
<input type="hidden" name="customData" id ="customData">
<input type="hidden" name="pagename" value="custom">
<input type="hidden" name="submitform" value="">
<input type="hidden" name="callPage" value="self">
<script>writeHeader("dsammUsrAddnlDtls");</script>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
			<tr>
			<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">
              	<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr class="innertabletop1">
						<td colspan="5" align="right">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
							<td align="right">
								<a href="javascript:showHelpFile('dsammUsrAddnlDtls_help.htm');">
									<img src="../Renderer/images/help.gif" width="47" height="21" vspace="1" border="0">
								</a>
							</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="textlabel">Free Field 1<script>setMandatory("N")</script></td>
						<td class="textfield">
							<input type="text" class="textfieldfont" name="custom.freeFld1" id="freeFld1" value="" size="16" maxlength = "30">
						</td>
						<td class="textlabel">Free Field 2<script>setMandatory("N")</script></td>
						<td class="textfield">
							<input type="text" class="textfieldfont" name="custom.freeFld2" id="freeFld2" value="" size="16" maxlength = "30">
						</td>
					</tr>
					<tr>
						<td class="textlabel">Free Field 3<script>setMandatory("N")</script></td>
						<td class="textfield">
							<input type="text" class="textfieldfont" name="custom.freeFld3" id="freeFld3" value="" size="16" maxlength = "30">
						</td>
						<td class="textlabel">Free Field 4<script>setMandatory("N")</script></td>
						<td class="textfield">
							<input type="text" class="textfieldfont" name="custom.freeFld4" id="freeFld4" value="" size="16" maxlength = "30">
						</td>
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
	</td>
	</tr>
</table>
<div class="ctable">
<script>printFooterBlock();</script>
</div>
</form>
</span>
</body>
</html>
