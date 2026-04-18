<%@page import="com.infy.bbu.sso.admin.*,com.infy.bbu.sso.SSOModData,java.text.DateFormat,java.util.*,com.infy.bbu.sso.common.SSOConstants, com.infy.bbu.sso.config.SSOConfig,com.infy.bbu.sso.utils.*,com.infy.bbu.sso.SSOUserProfile" contentType="text/html; charset=utf-8"%>
<%
String langCode = (String)session.getAttribute(SSOAdminUtils.SSO_ADMIN_LANG_CODE);
SSOResourceManager manager = null;
if((manager = (SSOResourceManager)(application.getAttribute("adminmanager"))) == null)
{
	manager = new SSOResourceManager();
	application.setAttribute("adminmanager", manager);
}

ResourceBundle sso_res = manager.getResourceBundle(pageContext.getServletContext(), SSOAdminUtils.SSO_ADMIN_SERVICE_NAME,langCode);
String authType = null;
boolean isLDAP = false;

authType = (String)session.getAttribute(SSOConstants.PARAM_AUTH_TYPE);
if(null != authType && !authType.equals(SSOConstants.PARAM_CHALLENGE_RESPONSE))
{	
	isLDAP = true;
}

SSOAdminUIResponse ssoresp = (SSOAdminUIResponse)session.getAttribute(SSOAdminUIResponse.SSO_ADMIN_RESP);
if(null == ssoresp) ssoresp = new SSOAdminUIResponse();

String isVerifyReq = SSOConfig.get(SSOConstants.SSO_VERIFY_REQ);
String isTFAReq = SSOConfig.get(SSOConstants.SSO_TFA_REQ);
if(null == isTFAReq || isTFAReq.trim().equals(""))  
  isTFAReq = SSOConstants.SSO_TFA_REQ_DEFAULT;
 

String sReadOnly = (String)ssoresp.get(SSOConstants.IS_READ_ONLY);
String isCriteriaDisabled = (sReadOnly.equals(SSOConstants.IS_READ_ONLY)) ? "disabled" : "";

String isModSelected = "";
String isVerSelected = "";
// the value of sTwoFactorCheck will be Y for a TFA enable user ,it is ensured
// in SSOAdminUserManager's setUserCriteria method.
String sTwoFactorCheck = (String)ssoresp.get(SSOAdminUserManager.sReqTwoFactorAuth);

float tzOffset = Float.parseFloat((String)session.getAttribute(SSOConstants.PARAM_OFFSET)); 
String eventID = ssoresp.get(SSOAdminVerifyManager.sEventID);
String opCode = ssoresp.get(SSOConstants.PARAM_OP_CODE);
String sUserID= ssoresp.get(SSOConstants.USER_ID);

if(opCode.equals(SSOAdminUtils.ADMINISTER_USER_OPTION))  isModSelected = SSOAdminUtils.SELECTED;
else if(opCode.equals(SSOAdminUtils.SSO_VERIFY_OPTION)) isVerSelected = SSOAdminUtils.SELECTED;
String sAdminCommand =(String)ssoresp.get(SSOAdminUtils.SSO_ADMIN_COMMAND);
if((null == sAdminCommand)||(sAdminCommand.trim().length()==0))  sAdminCommand=SSOAdminUtils.SSO_START_ADMIN_USER_COMMAND;

String sEnableCheck = (String)ssoresp.get(SSOAdminUserManager.sEnableUser);
String isEnableChecked = ( (sEnableCheck.equals(SSOAdminUserManager.sChecked)) ||(sEnableCheck.trim().equals(""))) ? "checked" : "unchecked";
String isEnabledUnChecked = ( (sEnableCheck.equals(SSOAdminUserManager.sUnChecked)) ||(sEnableCheck.trim().equals(""))) ? "checked" : "unchecked";

String errorMsg = ssoresp.get(SSOAdminUtils.SSO_ADMIN_MSG);

String isSuccess = (String)ssoresp.get(SSOAdminUtils.SSO_ADMIN_SUCCESS);

SSOModData [] data= null ;
if (opCode.equals(SSOAdminUtils.SSO_VERIFY_OPTION))
{
	 sReadOnly=SSOConstants.IS_READ_ONLY;
	 data = (SSOModData[])ssoresp.getDataArrayFromResponse(SSOAdminVerifyManager.sVerifyList);
}
int startIndex = 0;
String sStartIndex = request.getParameter("startIndex");
if (null != sStartIndex && sStartIndex.trim().length() > 0)
{
	startIndex = Integer.parseInt(sStartIndex);
}

String pwdAttemptsCheck = (isLDAP) ? "" : "checked";
String loginStatusCheck = (isLDAP) ? "checked" : "";
String pwdResetCheck = "";
String mpinResetCheck = "";

String updType = ssoresp.get(SSOAdminUserManager.UPD_TYPE).trim();
if(updType.length() > 0)
{
	if(updType.equals(SSOAdminUserManager.MOD_PW_ATTEMPT)) { pwdAttemptsCheck = "checked"; pwdResetCheck = ""; loginStatusCheck="";mpinResetCheck="";}
	else if(updType.equals(SSOAdminUserManager.MOD_USER_PW)) { pwdAttemptsCheck=""; pwdResetCheck = "checked"; loginStatusCheck="";mpinResetCheck="";}
	else if(updType.equals(SSOAdminUserManager.MOD_LOGIN_STATUS)) { pwdAttemptsCheck=""; pwdResetCheck = ""; loginStatusCheck = "checked";mpinResetCheck="";}
	else if(updType.equals(SSOAdminUserManager.MOD_USER_MPIN)) { pwdAttemptsCheck=""; pwdResetCheck = ""; loginStatusCheck = "";mpinResetCheck="checked";}
}
String visibility;
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script> var pageDomain = '<%=SSOConfig.get(SSOConstants.SSO_DOMAIN_NAME)%>'; </script>
<title><%=sso_res.getString("ADMIN_WINDOW_TITLE_HEADER")%> - <%=sso_res.getString("ADMIN_WINDOW_TITLE_CREATE_USER")%></title>
<link rel="stylesheet" href="ui/finacle.css">
<script type='text/javascript' src='ui/javascripts/ssodomain.js'></script>
<script type='text/javascript' src='ui/javascripts/cbe_core.js'></script>
<script language='javascript' src='ui/javascripts/SSOAdminResource_<%=langCode%>.js'></script>
<script language='javascript' src='ui/javascripts/ssoadmin.js'></script>
<script type='text/javascript' src='ui/javascripts/structure.js'></script>

<script language=JavaScript1.2>
setEncodedURL('<%=response.encodeURL("SSOAdmin")%>');
setIfGlobalAdmin('<%=((String)session.getAttribute(SSOAdminUtils.PARAM_GLOBAL_ADMIN))%>');
var imgFile = setHTMLDir('<%=langCode%>');
function showResetSubDetails()
{
	var spanFields = cbeGetElementsByTagName("SPAN");
	var divs = cbeGetElementsByTagName("DIV");

	var val = document.useradminform.updateType.value;

	var mpinBlock="";
	  mpinBlock+='<table width="100%" border="0" cellpadding="0" cellspacing="0"><tr id="enable2">';
		 mpinBlock+='<td class="textlabel"><%=sso_res.getString("ADMIN_TXT_NEW_MPIN")%> <span class="mandatory_indicator">*</span></td>';
		 mpinBlock+='<td class="textfield"><input name="<%=SSOAdminUserManager.sMPIN%>" type="password" value="<%=ssoresp.get(SSOAdminUserManager.sMPIN)%>" class="textfieldfont1" size="18" maxlength="<%=SSOConstants.SSO_CHNG_MPIN_LEN%>"></td>';
		 mpinBlock+='<td  class="coloumnwidth">&nbsp;</td>';
		 mpinBlock+='<td class="textlabel"><%=sso_res.getString("ADMIN_TXT_CMPIN")%> <span class="mandatory_indicator">*</span></td>';
		 mpinBlock+='<td  class="textfield"><input name="<%=SSOAdminUserManager.sConfMPIN%>" type="password" value="<%=ssoresp.get(SSOAdminUserManager.sMPIN)%>" class="textfieldfont1" size="18" maxlength="<%=SSOConstants.SSO_CHNG_MPIN_LEN%>"></td>';
	  mpinBlock+='</tr></table>';

 var pwdBlock="";
	pwdBlock+='<table width="100%" border="0" cellpadding="0" cellspacing="0"><tr id="enable1">';
         pwdBlock+='<td class="textfield"><input type="hidden" name="<%=SSOAdminUserManager.sPassword%>" value="" class="textfieldfont1" maxlength="<%=SSOConfig.get(SSOConstants.SSO_MAX_PWD_LENGTH)%>" size="25"></td>';
	 pwdBlock+='<td  class="coloumnwidth">&nbsp;</td>';
pwdBlock+='<td class="textfield"><input type="hidden" name="<%=SSOAdminUserManager.sConfPassword%>" value="" class="textfieldfont1" maxlength="<%=SSOConfig.get(SSOConstants.SSO_MAX_PWD_LENGTH)%>" size="25"></td>';
	 pwdBlock+='</tr></table>';


	if(val == "modPwAttempt"){
		divs["mpinPwdDiv"].innerHTML = "";

		spanFields["enableLabelSpan"].cbe.show();
		spanFields["enableFieldSpan"].cbe.show();
	}
	else if(val == "modLoginStatus"){

		spanFields["enableLabelSpan"].cbe.hide();
		spanFields["enableFieldSpan"].cbe.hide();

		divs["mpinPwdDiv"].innerHTML = "";

	}
	else if(val == "modUserPw"){
		spanFields["enableLabelSpan"].cbe.hide();
		spanFields["enableFieldSpan"].cbe.hide();

		divs["mpinPwdDiv"].innerHTML = pwdBlock;

	}
	else if(val == "modUserMpin"){
		spanFields["enableLabelSpan"].cbe.hide();
		spanFields["enableFieldSpan"].cbe.hide();

		divs["mpinPwdDiv"].innerHTML = mpinBlock;
	}
}
var strVerifyOptionVal = '<%=SSOAdminUtils.SSO_VERIFY_OPTION%>';
function doCheckCriteria()
{
	var spanElements = cbeGetElementsByTagName("SPAN");
	if(document.useradminform.op_code.value == strVerifyOptionVal)
	{	
		document.useradminform.user_id.disabled = true;
		document.useradminform.user_id.readOnly = true;
		document.useradminform.user_id.value="";
		spanElements["mandatorySpan"].cbe.hide();
		spanElements["srchSpan"].cbe.hide();
	}
	else
	{
		document.useradminform.user_id.disabled = false;
		document.useradminform.user_id.readOnly = false;
		spanElements["mandatorySpan"].cbe.show();
		spanElements["srchSpan"].cbe.show();
	}
}

</script>
</head>


<body leftmargin="0" topmargin="0" rightmargin="0" class="cbody" id="body" onFocus='setPageFocus(document.useradminform, "user_id");return;'>

<table width="100%" border="0" cellspacing="0" cellpadding="0" background="ui/images/toptile.gif">
  <tr> 
  	<script>
		document.write('<td background="ui/images/toptile.gif" width="27%" height="22"><img src="ui/images/'+imgFile+'" vspace="0" hspace="0" border="0"></td>');     
  	</script>
  </tr>
  
</table>
<script>document.write('<table width="100%" height='+getMenuHeight()+' border="0" cellspacing="0" cellpadding="0">');
</script>
<tr>
<td width="<%=SSOAdminUtils.SSO_MENUBAR_WIDTH_PERCENT%>" valign="top" class="menubgTd">
		<script>
			setSelectedMenu("mainMenu","<%=SSOAdminUtils.USER_ADMIN_MENU%>");
			printMenu(<%=isLDAP%>,'<%=langCode%>');
		</script>	
</td>
	<td valign="top">
	<form action='<%=response.encodeURL("SSOAdmin")%>' method='post' name='useradminform' id='useradminform' >
	<input type='hidden' name='SSO_ADMIN_COMMAND' value='<%=sAdminCommand%>'>
	<input type='hidden' name='<%=SSOAdminUserManager.sUserTSFieldName%>' value='<%=ssoresp.get(SSOAdminUserManager.sUserTSFieldName)%>'>
	<table border="0" cellspacing="0" cellpadding="0" class="ctable">
		<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			<td class="page-heading"><%=sso_res.getString("ADMIN_TITLE_RESET")%></td>
			</tr>
			<%
				if ( (null != errorMsg) && 
				(errorMsg.trim().length() != 0)){
			%>
			<tr>
			<td>
			<%
			if(SSOConstants.YES.equals(isSuccess)) 
			{
			%>
				<table width="100%" border="0" cellspacing="2" cellpadding="0" class="errortableborder">
				<tr>
				<td width="3%"align="center"><img src="ui/images/info.gif" width="25" height="25"></td>
				<td width="97%"><%=errorMsg%></td>
			<%
			}else{
			%>
				<table width="100%" border="0" cellspacing="2" cellpadding="0" class="errortableborder">
				<tr>
				<td width="3%"align="center"><img src="ui/images/error.gif" width="19" height="17"></td>
				<td width="97%" class="alert"><%=errorMsg%></td>
			<%}%>
			</tr>
			</table>
			</td>
			</tr>
			<tr class="rowspacing">
			<td  colspan="5" height="8"><spacer type="block" width="1" height="1"></spacer></td>
			</tr>
			<%}%>
		</table>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">
		<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">
			<tr>
			<td colspan="5" align="right">
				 <table width="100%" border="0" cellpadding="0" cellspacing="0">
				  <tr class="innertabletop1">	
					<td colspan="5" align="<%="ARABIC".equals(langCode) ? "left" : "right"%>">
					<table border="0" cellspacing="0" cellpadding="2">
					<tr>
					<td align="right" ><SPAN class="textlabel"><%=sso_res.getString("ADMIN_LBL_HELP")%></SPAN>					
					<a href="javascript:showHelp('showResetUserAdminHelp');"><img src="ui/images/help1.gif" border="0"></a>
					</td>					
				  </tr>
				</table>
			</td>
			</tr>
			<tr>
			  <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_FUNCTION")%> <span class="mandatory_indicator">*</span></td>
			  <td  class="textfield">
				<select id='<%=SSOConstants.PARAM_OP_CODE%>' name='<%=SSOConstants.PARAM_OP_CODE%>' class='textfieldfont1' <%=isCriteriaDisabled%> onchange='javascript:doCheckCriteria();'>
				 <option value="" selected><%=sso_res.getString("ADMIN_TXT_SEL")%></option>
				 <option value="<%=SSOAdminUtils.ADMINISTER_USER_OPTION%>" <%=isModSelected%>><%=sso_res.getString("ADMIN_TXT_MOD")%></option>	
				 
				<%if((null != isVerifyReq && isVerifyReq.trim().equals("true"))) {%>
				 <option value="<%=SSOAdminUtils.SSO_VERIFY_OPTION%>" <%=isVerSelected%>><%=sso_res.getString("ADMIN_TXT_VER")%></option>	
	 		         <%}%>	
	 		        </select>
			  </td>
			  <td  class="coloumnwidth">&nbsp;</td>
			  <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_USER_ID")%>
			  <%if(!sReadOnly.equals(SSOConstants.IS_READ_ONLY) || !opCode.equals(SSOAdminUtils.SSO_VERIFY_OPTION))
			  {%>
			  	<SPAN id="mandatorySpan" style="visibility:visible" class="mandatory_indicator"><%}
			  else {%>
			  	<SPAN id="mandatorySpan" style="visibility:hidden" class="mandatory_indicator">
			  <%}%>*</span></td>			  
			  <td  class="textfield">
				<input type='text'class="textfieldfont1" name='<%=SSOAdminUserManager.sUserID%>' value='<%=sUserID%>'  maxlength='15' onChange='this.value=this.value.toUpperCase()' <%=sReadOnly%> >
				<%if((!isLDAP)&&(!sReadOnly.equals(SSOConstants.IS_READ_ONLY))){%>
			  		<SPAN id="srchSpan" style="visibility:visible">
			  	<%}
			  	else {%>
			  		<SPAN id="srchSpan" style="visibility:hidden">
			  	<%}%>
			  	<a href="javascript:doSearchUserForForm(useradminform_object,'user_id',0)">
			  	<img src="ui/images/search_icon.gif" width="16" height="17" border="0"></a>
			  	</span>
			  </td>
			</tr>
			<tr class="rowspacing">
				  <td  colspan="5"><spacer type="block" width="1" height="1"></spacer></td>
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

<%if(null == opCode || opCode.trim().length() == 0 || isCriteriaDisabled.trim().length() == 0){%>
<div class="cdiv" id="criteriaDiv" style="position:absolute">
  <input type="button" name="Submit2" value='<%=sso_res.getString("ADMIN_BTN_GO")%>' class="button" onClick='javascript:doCheckUserAdmin();'>
  <input type="button" name="Submit3" value='<%=sso_res.getString("ADMIN_BTN_CLEAR")%>' class="button" onClick='javascript:doCancel(document.useradminform, "cancelAdministerUser");'>
</div>
<%}
else if(!opCode.equals(SSOAdminUtils.SSO_VERIFY_OPTION)){%>

<div class="cdiv" id="detailsDiv" style="position:absolute;z-index:10">
<input type="button" name="Submit2" value='<%=sso_res.getString("ADMIN_BTN_GO")%>' class="button" disabled>
<input type="button" name="Submit3" value='<%=sso_res.getString("ADMIN_BTN_CLEAR")%>' class="button" disabled>

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
	<td valign="top">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">
	<tr>
	<td>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">
	  <tr>
	  <td colspan="5" align="right">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
		  <tr class="rowspacing">
			<td  colspan="5"><spacer type="block" width="1" height="1"></spacer></td>
		  </tr>
		  <tr>
			<td class="textlabel"><%=sso_res.getString("ADMIN_LBL_RESET_TYPE")%></td>
			<td  class="textfielddisplaylabel">
					<select id='<%=SSOAdminUserManager.UPD_TYPE%>' name='<%=SSOAdminUserManager.UPD_TYPE%>' class="textfieldfont1" onChange="showResetSubDetails()">
					  <option selected value="<%=SSOAdminUserManager.MOD_LOGIN_STATUS%>"><%=sso_res.getString("ADMIN_TXT_RESET_LOGIN_STATUS")%></option>
					  <%if(!isLDAP) { %>
					  <option value="<%=SSOAdminUserManager.MOD_PW_ATTEMPT%>"><%=sso_res.getString("ADMIN_TXT_RESET_LOGIN_ATTEMPTS")%></option>
					  <option value="<%=SSOAdminUserManager.MOD_USER_PW%>"><%=sso_res.getString("ADMIN_TXT_RESET_PASSWORD")%></option>
					  <%}%>
					  <%if( (null != isTFAReq && isTFAReq.trim().equals("true")) &&
					  	(sTwoFactorCheck.equals(String.valueOf(SSOUserProfile.TWO_FACTOR_AUTH_REQ)))) {%>
					  <option value="<%=SSOAdminUserManager.MOD_USER_MPIN%>"><%=sso_res.getString("ADMIN_TXT_RESET_MPIN")%></option>
					  <%}%>
					</select>
			</td>
			<td  class="coloumnwidth">&nbsp;</td>
			<td class="textlabel"><SPAN id="enableLabelSpan" style="visibility:hidden"><%=sso_res.getString("ADMIN_LBL_ENABLE_STATUS")%></SPAN>
			</td>
			<td class="textfield">
			<SPAN id="enableFieldSpan" style="visibility:hidden">
			  <input name="<%=SSOAdminUserManager.sEnableUser%>" type="radio" value="<%=SSOAdminUserManager.sChecked%>" <%=isEnableChecked%>><%=sso_res.getString("ADMIN_LBL_YES")%>	
			  <input name="<%=SSOAdminUserManager.sEnableUser%>" type="radio" value="<%=SSOAdminUserManager.sUnChecked%>" <%=isEnabledUnChecked%>><%=sso_res.getString("ADMIN_LBL_NO")%> 
			</SPAN>
			</td>
		 </tr>
		 </table>
		 <div id="mpinPwdDiv" style="position:relative;visibility:visible;z-index:30">&nbsp;
		 </div>
		</td>
 	</tr>
	</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr class="rowspacing">
	  <td style="height:5px"><spacer type="block" width="1" height="1"></spacer></td>
	</tr>
</table>
<%
 String sVerify = isVerifyReq.trim().equals("true") ? sso_res.getString("login_reset"): SSOConstants.NO;
%>
<input type="button" name="Submit2" value='<%=sso_res.getString("ADMIN_BTN_SUBMIT")%>' class="button" onClick='javascript:doAdminUser("<%=sVerify%>");'>
<input type="button" name="Submit3" value='<%=sso_res.getString("ADMIN_BTN_CANCEL")%>' class="button" onClick='javascript:doCancel(document.useradminform, "cancelAdministerUser");'>
</div>
<%}else{
if(null != data && data.length > 0 ){
	
%>
	<div class="cdiv" id="verifyDiv" style="position:absolute;z-index:20">
	  <input type="button" value="Go" class="button" disabled>
	  <input type="button" value="Clear" class="button" disabled>

	  <table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
	<td valign="top">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">
	<tr>
	<td>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">
	<tr>
	<td>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop1">
	<tr>
	  <td colspan="5" align="right">
		  <table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr class="subhdrbg">
			  <td align="right">
				<table border="0" cellpadding="0" cellspacing="0">
				  <tr>
					<td align="right">
					  <% if(startIndex >= 10){ 
					  %>
					  <a href='javascript:showVerifyPage(<%=(startIndex)%>,"<%=SSOAdminUtils.USER_ADMIN_MENU%>",-10)'>
					  <img src="ui/images/arrowpre.gif" width="7" height="14" border="0"></a></td>
					<%}
					else{%>
					&nbsp;&nbsp;</td>
					<%}%>
					<td><%=sso_res.getString("ADMIN_LBL_PAGE")%>&nbsp;&nbsp;<%=(startIndex/10+1)%>&nbsp;&nbsp;
						<%=sso_res.getString("ADMIN_LBL_OF")%>&nbsp;&nbsp;<%=(data.length%10 == 0) ?
						(data.length/10) : (data.length/10+1)%>&nbsp;&nbsp;</td>
					<td>
					<% if (startIndex < data.length-10){
					%>
					  <a href='javascript:showVerifyPage(<%=(startIndex)%>,"<%=SSOAdminUtils.USER_ADMIN_MENU%>",10)'>
					  <img src="ui/images/arrownext.gif" width="7" height="14" border="0" align="absmiddle"></a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<%}
					else{%>
					&nbsp;&nbsp;</td>
					<%}%>
				  </tr>
				</table>
			  </td>
			</tr>
			<tr>
			  <td colspan="5">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				  <tr>
					<td width="6%" class="searcheader1a">&nbsp;</td>
					<td width="21%" class="searcheader"><%=sso_res.getString("ADMIN_LBL_EVENT_ID")%></td>
					<td width="20%" class="searcheader"><%=sso_res.getString("ADMIN_LBL_KEY_VALUE")%></td>
					<td width="20%" class="searcheader"><%=sso_res.getString("ADMIN_LBL_LOGGED_USER")%></td>
					<td width="33%" class="searcheader"><%=sso_res.getString("ADMIN_LBL_EVENT_TIME")%></td>
				  </tr>
				  <%
				  for (int iIndex=startIndex; (null != data) && (iIndex < data.length) && (iIndex < startIndex+10); iIndex++) {
				  SSOModData dataElemet = data[iIndex]; 

					     if(0==(iIndex %2)){
				   %>
				  <tr class="searclist1a" onMouseOver="this.className='searclist1arow';" onMouseOut="this.className='searclist1a';">
				  <%}
					     else{
				  %>
				  <tr class="searclist2a" onMouseOver="this.className='searclist1arow';" onMouseOut="this.className='searclist2a';">
				  <%}%>
					<td>
					  <input type='radio' name='mod_data_sel' onchange='setSelectedEvent("<%=data[iIndex].event_id%>", "<%=data[iIndex].logged_in_user_id%>", "<%=data[iIndex].key_value%>");'>
					</td>
					<td>
					<a href='javascript:showModData("<%=iIndex%>")' class="url"> <%=sso_res.getString(data[iIndex].event_id)%> </a>
					</td>
					<td><%=data[iIndex].key_value%></td>
					<td><%=data[iIndex].logged_in_user_id%></td>
					<td><%=SSOUtils.DateToString(data[iIndex].event_time, DateFormat.LONG, tzOffset)%></td>
				  </tr>
				   <%}%>
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
	</td>
	</tr>
	</table>

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr class="rowspacing">
		  <td style="height:5px"><spacer type="block" width="1" height="1"></spacer></td>
		</tr>
	</table>
	<input type="button" name="Submit" value='<%=sso_res.getString("ADMIN_BTN_SUBMIT")%>' class="button" onClick='javascript:setVerifyMenu("<%=SSOAdminUtils.USER_ADMIN_MENU%>");'>
	<input type="button" name="Reject" value='<%=sso_res.getString("ADMIN_BTN_REJECT")%>' class="button" onClick='javascript:deleteModData(document.verifyForm,"<%=SSOAdminUtils.USER_ADMIN_MENU%>")'>
	<input type="button" name="Cancel" value='<%=sso_res.getString("ADMIN_BTN_CANCEL")%>' class="button" onClick='javascript:doCancel(document.useradminform, "cancelAdministerUser");'>
	<%}%>
</div>

<%}%>
</td>
</tr>
</table>
</form>
<script language='javascript'>
    useradminform_object = document.useradminform;
    verifyform_object = document.verifyForm;
</script>
</body>
</html>		  
			
		
