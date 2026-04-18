<%@page import="com.infy.bbu.sso.admin.*,com.infy.bbu.sso.*,com.infy.bbu.sso.SSOResource,com.infy.bbu.sso.SSOModData,java.util.*,com.infy.bbu.sso.common.SSOConstants, com.infy.bbu.sso.config.SSOConfig,com.infy.bbu.sso.utils.*,java.text.DateFormat,com.infy.bbu.sso.config.SSOConfig"%>
<%@ page contentType="text/html; charset=utf-8" %>
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
boolean isKerberos = false;
boolean isNotDBLogin = false;
boolean isExternalSSO = false;

String homeEntity = (String)session.getAttribute(SSOAdminUtils.PARAM_ADMIN_HOME_ENTITY);
String homeTimeZone = (String)session.getAttribute(SSOConstants.PARAM_DEF_TIME_ZONE_ID);
float tzOffset = Float.parseFloat((String)session.getAttribute(SSOConstants.PARAM_OFFSET));

authType = (String)session.getAttribute(SSOConstants.PARAM_AUTH_TYPE);
if(null != authType && !authType.equals(SSOConstants.PARAM_CHALLENGE_RESPONSE))
{	
	isNotDBLogin = true;
	if(authType.equals(SSOConstants.PARAM_KRB_AUTH))
	{	
		isKerberos = true;
	}
	else if(authType.equals(SSOConstants.PARAM_EXTERNAL_SSO_AUTH))
	{
		isExternalSSO = true;
	}
}


SSOAdminUIResponse ssoresp = (SSOAdminUIResponse)session.getAttribute(SSOAdminUIResponse.SSO_ADMIN_RESP);
if(null == ssoresp) ssoresp = new SSOAdminUIResponse();

String isVerifyReq = SSOConfig.get(SSOConstants.SSO_VERIFY_REQ);
String isTFAReq = SSOConfig.get(SSOConstants.SSO_TFA_REQ);
if(null == isTFAReq || isTFAReq.trim().equals(""))  
  isTFAReq = SSOConstants.SSO_TFA_REQ_DEFAULT;
String tfaType = SSOConfig.get(SSOConstants.SSO_TFA_TYPE);
if(null == tfaType || tfaType.trim().equals(""))  
  tfaType = SSOConstants.SSO_TFA_TYPE_DEFAULT;  
  
String sReadOnly = (String)ssoresp.get(SSOConstants.IS_READ_ONLY);

String isDisabled = "";
String isCriteriaDisabled = (sReadOnly.equals(SSOConstants.IS_READ_ONLY)) ? "disabled" : "";

String isAddSelected = "";
String isModSelected = "";
String isDelSelected = "";
String isVerSelected = "";
String isInqSelected = "";
String eventID = ssoresp.get(SSOAdminVerifyManager.sEventID);
String defaultCalendar = ssoresp.get(SSOAdminUserManager.sDefaultCalendar);
String defaultTZ = ssoresp.get(SSOAdminUserManager.sDefaultTimeZone);
String errorMsg = ssoresp.get(SSOAdminUtils.SSO_ADMIN_MSG);
boolean isError = false;
String isSuccess = (String)ssoresp.get(SSOAdminUtils.SSO_ADMIN_SUCCESS);
	
String opCode = ssoresp.get(SSOConstants.PARAM_OP_CODE);
String sUserID= ssoresp.get(SSOConstants.USER_ID);
if(opCode.equals(SSOConstants.EVENT_ADD_USER_CREDS)) { 
	isAddSelected = SSOAdminUtils.SELECTED;
	if((errorMsg == null) || (errorMsg.trim().length() == 0)){
		defaultCalendar = String.valueOf(SSOConstants.GREG_CAL);
		defaultTZ = homeTimeZone;
	}
} 


else if(opCode.equals(SSOConstants.EVENT_MOD_USER_CREDS))  isModSelected = SSOAdminUtils.SELECTED;
else if(opCode.equals(SSOConstants.EVENT_DEL_USER_CREDS)) { isDelSelected = SSOAdminUtils.SELECTED;isDisabled = "disabled";}
else if(opCode.equals(SSOAdminUtils.SSO_VERIFY_OPTION)) isVerSelected = SSOAdminUtils.SELECTED;
else if(opCode.equals(SSOAdminUtils.SSO_INQUIRE_OPTION)) { isInqSelected = SSOAdminUtils.SELECTED;isDisabled = "disabled";} 
String sAdminCommand =(String)ssoresp.get(SSOAdminUtils.SSO_ADMIN_COMMAND);
if((null == sAdminCommand)||(sAdminCommand.trim().length()==0))  sAdminCommand=SSOAdminUtils.SSO_START_CREATE_USER_COMMAND;

String isPwdReadOnly  = "";
if(ssoresp.get(SSOAdminUserManager.sPassword).trim().length() > 0) isPwdReadOnly = "readOnly";

if(isPwdReadOnly.trim().length() > 0) { 
	if(opCode.equals(SSOConstants.EVENT_ADD_USER_CREDS)) isAddSelected = SSOAdminUtils.SELECTED;
	else if(opCode.equals(SSOConstants.EVENT_MOD_USER_CREDS)) isModSelected = SSOAdminUtils.SELECTED;
	else if(opCode.equals(SSOConstants.EVENT_DEL_USER_CREDS)) isDelSelected = SSOAdminUtils.SELECTED;
}

SSOModData [] data= null ;

if (opCode.equals(SSOAdminUtils.SSO_VERIFY_OPTION))
{
	sReadOnly=SSOConstants.IS_READ_ONLY;	
	data = (SSOModData[])ssoresp.getDataArrayFromResponse(SSOAdminVerifyManager.sVerifyList);
}

int startIndex = 0;
int hours=0;
int minutes=0;
int seconds=0;
String sStartIndex = request.getParameter("startIndex");
if (null != sStartIndex && sStartIndex.trim().length() > 0)
{
	startIndex = Integer.parseInt(sStartIndex);
}
String focusField = (String)ssoresp.get("FOCUS_FIELD");
String sNewUserFlag = ssoresp.get(SSOAdminUserManager.sNewUserFlag);
String sNewUserChecked = ((null == sNewUserFlag) || 0 == sNewUserFlag.trim().length() || Character.toString(SSOUserCreds.NEW_USER).equals(sNewUserFlag.trim())) ? "checked" : ""; 

if(!isNotDBLogin && sNewUserChecked.equals("checked")) {
	String tempVal = (String)ssoresp.get(SSOAdminUserManager.sPwExpiryDate);
	if(null == tempVal || 0 == tempVal.trim().length())
		ssoresp.putInResponse(session, SSOAdminUserManager.sPwExpiryDate, SSOUtils.DateToString(new Date(), SSOConstants.DATEFORMAT));
	tempVal = (String)ssoresp.get(SSOAdminUserManager.sMaxAcctInactive);
	if(null == tempVal || 0 == tempVal.trim().length())
		ssoresp.putInResponse(session, SSOAdminUserManager.sMaxAcctInactive , SSOConstants.DEF_INACTIVE_DAYS);	
}

String maxInactiveTime = (String)ssoresp.get(SSOAdminUserManager.sMaxInactiveTime);
if(null == maxInactiveTime || 0 == maxInactiveTime.trim().length()) {
	ssoresp.putInResponse(session, SSOAdminUserManager.sMaxInactiveTime, SSOConstants.DEF_INACTIVE_TIME);
}
String sTwoFactorValOld = (String)ssoresp.get(SSOAdminUserManager.sReqTFAPrevVal);
if(sTwoFactorValOld == null || sTwoFactorValOld.trim().length() == 0)
	sTwoFactorValOld = String.valueOf(SSOUserProfile.TWO_FACTOR_AUTH_NOT_REQ);
String sTwoFactorCheck = (String)ssoresp.get(SSOAdminUserManager.sReqTwoFactorAuth);
String isCurrTFA = (String)ssoresp.get(SSOConstants.PARAM_IS_USER_CURR_TFA);
// the value of the "enableMpinText" will be "" if some error occured while creating a TFA user or
//while making a nonTFA user to TFA user.Otherwise the value will be"disabled".
String enableMpinText = 
	(ssoresp.get(SSOAdminUserManager.sEnableMpinText).equals(SSOConstants.YES)) ? "" : "disabled";
String isTFAChecked = ( (sTwoFactorCheck.equals(String.valueOf(SSOUserProfile.TWO_FACTOR_AUTH_REQ))) || 
	(sTwoFactorCheck.equals(String.valueOf(SSOUserProfile.TWO_FACTOR_NEEDS_CHG))))  ? "checked" : "";
String isTFAUnChecked = ( isTFAChecked.equals("checked")) ? "" : "checked";
char cIsGlobalAdm = ((String)session.getAttribute(SSOAdminUtils.PARAM_GLOBAL_ADMIN)).charAt(0);

String sGlobalAdminCheck = (String)ssoresp.get(SSOAdminUserManager.sIsGlobalAdmin);

String isGlobalAdminChecked = ( (sGlobalAdminCheck.equals(String.valueOf(SSOUserProfile.IS_GLOBAL_ADMIN))))  ? "checked" : "";

String isGlobalAdminUnChecked = (isGlobalAdminChecked.trim().equals("")) ? "checked" : "";
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
var strVerifyOptionVal = '<%=SSOAdminUtils.SSO_VERIFY_OPTION%>';
function doCheckCriteria()
{	
	var spanFields = cbeGetElementsByTagName("SPAN");
	if(document.usercreateform.op_code.value == strVerifyOptionVal)
	{		
		document.usercreateform.user_id.readOnly = true;
		document.usercreateform.user_id.value="";
		
		spanFields["mandatorySpan"].cbe.hide();
		spanFields["srchSpan"].cbe.hide();
	}
	else
	{
		document.usercreateform.user_id.readOnly = false;
		spanFields["mandatorySpan"].cbe.show();
		spanFields["srchSpan"].cbe.show();
	}
	
}
</script>

</head>

<body leftmargin="0" topmargin="0" rightmargin="0" class="cbody" id="body" onFocus='setPageFocusWithDefault(document.usercreateform, "<%=focusField%>","user_id");return;'>


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
			setSelectedMenu("mainMenu","<%=SSOAdminUtils.USER_CREATE_MENU%>");
			printMenu(<%=isNotDBLogin%>,'<%=langCode%>');
		</script>	
		
	</td>
	<td valign="top">
		<form action='<%=response.encodeURL("SSOAdmin")%>' method='post' name='usercreateform' id='usercreateform' >
		<input type='hidden' name='SSO_ADMIN_COMMAND' value='<%=sAdminCommand%>'>
		<input type='hidden' name='<%=SSOAdminUserManager.sUserTSFieldName%>' value='<%=ssoresp.get(SSOAdminUserManager.sUserTSFieldName)%>'>
		<input type='hidden' name='<%=SSOAdminUserManager.slLastAccessTime%>' value='<%=ssoresp.get(SSOAdminUserManager.slLastAccessTime)%>'>
		<input type='hidden' name='<%=SSOAdminUserManager.sNewUserFlag%>' value='<%=sNewUserFlag%>'>
		<input type='hidden' name='mPinEnabled' value='<%=sTwoFactorValOld%>'> 
	
		<table border="0" cellspacing="0" cellpadding="0" class="ctable">
		<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			<td class="page-heading"><%=sso_res.getString("ADMIN_WINDOW_TITLE_USER_ADMIN")%></td>
			</tr>
			<%
				if((null != errorMsg) && 
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
					<a href="javascript:showHelp('showUserAdminHelp');"><img src="ui/images/help1.gif" border="0"></a>
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
				 <option value="<%=SSOConstants.EVENT_ADD_USER_CREDS%>" <%=isAddSelected%>><%=sso_res.getString("ADMIN_TXT_ADD")%></option>
				 <option value="<%=SSOConstants.EVENT_MOD_USER_CREDS%>" <%=isModSelected%>><%=sso_res.getString("ADMIN_TXT_MOD")%></option>	
				 <option value="<%=SSOConstants.EVENT_DEL_USER_CREDS%>" <%=isDelSelected%>><%=sso_res.getString("ADMIN_TXT_DEL")%></option>	
				 <option value="<%=SSOAdminUtils.SSO_INQUIRE_OPTION%>" <%=isInqSelected%>><%=sso_res.getString("ADMIN_TXT_INQ")%></option>
				
				<%if((null != isVerifyReq && isVerifyReq.trim().equals("true"))) {%>
				 <option value="<%=SSOAdminUtils.SSO_VERIFY_OPTION%>" <%=isVerSelected%> ><%=sso_res.getString("ADMIN_TXT_VER")%></option>	
	 		         <%}%>	
	 		        </select>
			  </td>
			  <td  class="coloumnwidth">&nbsp;</td>
			  <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_USER_ID")%> 
			  <%if(!opCode.equals(SSOAdminUtils.SSO_VERIFY_OPTION))
			  {%>
				<SPAN id="mandatorySpan" style="visibility:visible" class="mandatory_indicator"><%}
			  else {%>
				<SPAN id="mandatorySpan" style="visibility:hidden" class="mandatory_indicator">
			  <%}%>*</span></td>
			  <td  class="textfield">
			  <input type='text'class="textfieldfont1" name='<%=SSOAdminUserManager.sUserID%>' value='<%=sUserID%>'  maxlength='15' onChange='this.value=this.value.toUpperCase()' <%=sReadOnly%> >
			   <%if(!sReadOnly.equals(SSOConstants.IS_READ_ONLY)){%>
			  	<SPAN id="srchSpan" style="visibility:visible">
			   <%} else {%>
				<SPAN id="srchSpan" style="visibility:hidden">
			   <%}%>
			   <a href="javascript:doSearchUserForForm(usercreateform_object,'user_id',0)">
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
  <input type="button" name="Submit2" value='<%=sso_res.getString("ADMIN_BTN_GO")%>' class="button" onClick='javascript:doCheckUser();'>
  <input type="button" name="Submit3" value='<%=sso_res.getString("ADMIN_BTN_CLEAR")%>' class="button" onClick='javascript:doCancel(document.usercreateform, "cancelUser");'> 
</div>
<%}
else if(!opCode.equals(SSOAdminUtils.SSO_VERIFY_OPTION)){%>

<div class="cdiv" id="detailsDiv" style="position:absolute;z-index:10">
<input type="button" name="Submit2" value='<%=sso_res.getString("ADMIN_BTN_GO")%>' class="button" disabled>
<input type="button" name="Submit3" value='<%=sso_res.getString("ADMIN_BTN_CLEAR")%>' class="button" disabled>

	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">
	<tr>
	<td>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">
	  <tr>
		<td>
		  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop">
			<tr>
			  <td colspan="5" align="right">
				  <table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr class="rowspacing">
					  <td  colspan="5"><spacer type="block" width="1" height="1"></spacer></td>
					</tr>
					<tr>
					  <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_USER_NAME")%> </td>
					  <td  class="textfield">
						<input name='<%=SSOAdminUserManager.sUserName%>' value='<%=ssoresp.get(SSOAdminUserManager.sUserName)%>' type="text" class="textfieldfont1" maxlength='80' size='25' <%=isDisabled%>>
					  </td>
					  <td  class="coloumnwidth">&nbsp;</td>
					   <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_HOME_ENTITY")%> <span class="mandatory_indicator">*</span></td>
					  <td  class="textfield">
						<% if(opCode.equals(SSOConstants.EVENT_ADD_USER_CREDS))
						{%>
						<input name='<%=SSOAdminUserManager.sHomeEntity%>' value='<%=homeEntity%>' type="text" class="textfieldfont1" readOnly <%=isDisabled%>>
						<%}else{%>
						<input name='<%=SSOAdminUserManager.sHomeEntity%>' value='<%=ssoresp.get(SSOAdminUserManager.sHomeEntity)%>' type="text" class="textfieldfont1" readOnly>
						<%}%>
					   </td>					  
					</tr>
					<%if(!isNotDBLogin) { %>
						<input type="hidden" name='<%=SSOAdminUserManager.sPassword%>' value='<%=ssoresp.get(SSOAdminUserManager.sPassword)%>'  maxlength='<%=SSOConfig.get(SSOConstants.SSO_MAX_PWD_LENGTH)%>' size='25' class="textfieldfont1" <%=isPwdReadOnly%> <%=isDisabled%>>
						<input type="hidden" name='<%=SSOAdminUserManager.sConfPassword%>' value='<%=ssoresp.get(SSOAdminUserManager.sConfPassword)%>'  maxlength='<%=SSOConfig.get(SSOConstants.SSO_MAX_PWD_LENGTH)%>' size='25' class="textfieldfont1" <%=isPwdReadOnly%> <%=isDisabled%>>
					<tr>
					  <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_LOGINTIME_LOW")%> <span class="mandatory_indicator">*</span></td>
					  <td  class="textfield">
						 <input type='hidden' name='<%=SSOAdminUserManager.sLoginTimeLow%>' id='<%=SSOAdminUserManager.sLoginTimeLow%>' value=''>
						 <select id='sLowHours' name='sLowHours' class='threetextfieldsinarow1' <%=isDisabled%>>
						 <% if((opCode.equals(SSOConstants.EVENT_ADD_USER_CREDS)) && ((errorMsg == null) || (errorMsg.trim().length() == 0)))
						    {	for(int lhour=0;lhour<24;lhour++)
							{ if (lhour == 8)
							{%>
								
								<option value='<%=lhour%>'selected>0<%=lhour%></option>
							<%}else
							{
								if(lhour <10)
								{%>
								<option value='<%=lhour%>'>0<%=lhour%></option>
								<%}else{%>
								<option value='<%=lhour%>'><%=lhour%></option>
								<%}%>	
							<%}}
						    }
						  else
						    {   
						    	String [] timesplit= ssoresp.get(SSOAdminUserManager.sLoginTimeLow).split(":");
						    	for(int lhour=0;lhour<24;lhour++)
							{ if (lhour == Integer.parseInt(timesplit[0]))
							{
								if(lhour <10)
								{%>
								<option value='<%=lhour%>'selected>0<%=lhour%></option>
								<%}else{%>
								<option value='<%=lhour%>'selected><%=lhour%></option>
								<%}%>
							<%}else{
								if(lhour <10)
								{%>
								<option value='<%=lhour%>'>0<%=lhour%></option>
								<%}else{%>
								<option value='<%=lhour%>'><%=lhour%></option>
								<%}%>
							<%}}
						    }
						  	
						%>	
                         			</select>
                         			<select id='sLowMinutes' name='sLowMinutes' class='threetextfieldsinarow1' <%=isDisabled%>>
						<% if((opCode.equals(SSOConstants.EVENT_ADD_USER_CREDS)) && ((errorMsg == null) || (errorMsg.trim().length() == 0)))
						   {	for(int lminutes=0;lminutes<60;lminutes++)
						   	{ if (lminutes == 0)
							{%>
								<option value='<%=lminutes%>'selected>0<%=lminutes%></option>
							<%}else{
								if(lminutes <10)
								{%>
								<option value='<%=lminutes%>'>0<%=lminutes%></option>
								<%}else{%>
								<option value='<%=lminutes%>'><%=lminutes%></option>
								<%}%>
							<%}}
						   }
						  else
						    {   
						    	String [] timesplit= ssoresp.get(SSOAdminUserManager.sLoginTimeLow).split(":");
						    	for(int lminutes=0;lminutes<60;lminutes++)
							{ if (lminutes == Integer.parseInt(timesplit[1]))
							{
								if(lminutes <10)
								{%>
								<option value='<%=lminutes%>'selected>0<%=lminutes%></option>
								<%}else{%>
								<option value='<%=lminutes%>'selected><%=lminutes%></option>
								<%}%>
							<%}else{
								if(lminutes <10)
								{%>
								<option value='<%=lminutes%>'>0<%=lminutes%></option>
								<%}else{%>
								<option value='<%=lminutes%>'><%=lminutes%></option>
								<%}%>
							<%}}
						    }
						  
						%>	
                         	   		</select>
                         	   		<select id='sLowSeconds' name='sLowSeconds' class='threetextfieldsinarow1' <%=isDisabled%>>
                         	   		<% if((opCode.equals(SSOConstants.EVENT_ADD_USER_CREDS)) && ((errorMsg == null) || (errorMsg.trim().length() == 0)))
						   {	for(int lseconds=0;lseconds<60;lseconds++)
						   	{ if (lseconds == 0)
							{	if(lseconds <10)
								{%>
								<option value='<%=lseconds%>'selected>0<%=lseconds%></option>
								<%}else{%>
								<option value='<%=lseconds%>'selected><%=lseconds%></option>
								<%}%>
							<%}else{
								if(lseconds <10)
								{%>
								<option value='<%=lseconds%>'>0<%=lseconds%></option>
								<%}else{%>
								<option value='<%=lseconds%>'><%=lseconds%></option>
								<%}%>
							<%}}
						   }
						  else
						    {   
						    	String [] timesplit= ssoresp.get(SSOAdminUserManager.sLoginTimeLow).split(":");
						    	for(int lseconds=0;lseconds<60;lseconds++)
							{ if (lseconds == Integer.parseInt(timesplit[2]))
							{	if(lseconds <10)
								{%>
								<option value='<%=lseconds%>'selected>0<%=lseconds%></option>
								<%}else{%>
								<option value='<%=lseconds%>'selected><%=lseconds%></option>
								<%}%>
							<%}else{
								if(lseconds <10)
								{%>
								<option value='<%=lseconds%>'>0<%=lseconds%></option>
								<%}else{%>
								<option value='<%=lseconds%>'><%=lseconds%></option>
								<%}%>
							<%}}
						    }
						  
						%>                         	   		
                         	   		</select>
                         	   		
		 				
					  </td>
					  <td  class="coloumnwidth">&nbsp;</td>
					  <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_LOGINTIME_HIGH")%> <span class="mandatory_indicator">*</span> </td>
					  <td  class="textfield">
						<input type='hidden' name='<%=SSOAdminUserManager.sLoginTimeHigh%>' id='<%=SSOAdminUserManager.sLoginTimeHigh%>' value=''>
						<select id='sHighHours' name='sHighHours' class='threetextfieldsinarow1' <%=isDisabled%>>
						<% if((opCode.equals(SSOConstants.EVENT_ADD_USER_CREDS)) && ((errorMsg == null) || (errorMsg.trim().length() == 0)))
						    {	for(int hhour=0;hhour<24;hhour++)
							{ if (hhour == 18)
							{	if(hhour <10)
								{%>
								<option value='<%=hhour%>'selected>0<%=hhour%></option>
								<%}else{%>
								<option value='<%=hhour%>'selected><%=hhour%></option>
								<%}%>
							<%}else{
								if(hhour <10)
								{%>
								<option value='<%=hhour%>'>0<%=hhour%></option>
								<%}else{%>
								<option value='<%=hhour%>'><%=hhour%></option>
								<%}%>
							<%}}
						    }
						  else
						    {   
						    	String [] timesplit= ssoresp.get(SSOAdminUserManager.sLoginTimeHigh).split(":");
						    	for(int hhour=0;hhour<24;hhour++)
							{ if (hhour == Integer.parseInt(timesplit[0]))
							{
								if(hhour <10)
								{%>
								<option value='<%=hhour%>'selected>0<%=hhour%></option>
								<%}else{%>
								<option value='<%=hhour%>'selected><%=hhour%></option>
								<%}%>
							<%}else{
								if(hhour <10)
								{%>
								<option value='<%=hhour%>'>0<%=hhour%></option>
								<%}else{%>
								<option value='<%=hhour%>'><%=hhour%></option>
								<%}%>
							<%}}
						    }
						  	
						%>
						</select>
						<select id='sHighMinutes' name='sHighMinutes' class='threetextfieldsinarow1' <%=isDisabled%>>
						<% if((opCode.equals(SSOConstants.EVENT_ADD_USER_CREDS)) && ((errorMsg == null) || (errorMsg.trim().length() == 0)))
						    {	for(int hminutes=0;hminutes<60;hminutes++)
							{ if (hminutes == 0)
							{	if(hminutes <10)
								{%>
								<option value='<%=hminutes%>'selected>0<%=hminutes%></option>
								<%}else{%>
								<option value='<%=hminutes%>'selected><%=hminutes%></option>
								<%}%>
							<%}else{
								if(hminutes <10)
								{%>
								<option value='<%=hminutes%>'>0<%=hminutes%></option>
								<%}else{%>
								<option value='<%=hminutes%>'><%=hminutes%></option>
								<%}%>
							<%}}
						    }
						  else
						    {   
						    	String [] timesplit= ssoresp.get(SSOAdminUserManager.sLoginTimeHigh).split(":");
						    	for(int hminutes=0;hminutes<60;hminutes++)
							{ if (hminutes == Integer.parseInt(timesplit[1]))
							{	if(hminutes <10)
								{%>
								<option value='<%=hminutes%>'selected>0<%=hminutes%></option>
								<%}else{%>
								<option value='<%=hminutes%>'selected><%=hminutes%></option>
								<%}%>
							<%}else{
								if(hminutes <10)
								{%>
								<option value='<%=hminutes%>'>0<%=hminutes%></option>
								<%}else{%>
								<option value='<%=hminutes%>'><%=hminutes%></option>
								<%}%>
							<%}}
						    }
						  	
						%>
						</select>
						<select id='sHighSeconds' name='sHighSeconds' class='threetextfieldsinarow1' <%=isDisabled%>>
						<% if((opCode.equals(SSOConstants.EVENT_ADD_USER_CREDS)) && ((errorMsg == null) || (errorMsg.trim().length() == 0)))
						    {	for(int hseconds=0;hseconds<60;hseconds++)
							{ if (hseconds == 0)
							{	if(hseconds <10)
								{%>
								<option value='<%=hseconds%>'selected>0<%=hseconds%></option>
								<%}else{%>
								<option value='<%=hseconds%>'selected><%=hseconds%></option>
								<%}%>
							<%}else{
								if(hseconds <10)
								{%>
								<option value='<%=hseconds%>'>0<%=hseconds%></option>
								<%}else{%>
								<option value='<%=hseconds%>'><%=hseconds%></option>
								<%}%>
							<%}}
						    }
						  else
						    {   
						    	String [] timesplit= ssoresp.get(SSOAdminUserManager.sLoginTimeHigh).split(":");
						    	for(int hseconds=0;hseconds<60;hseconds++)
							{ if (hseconds == Integer.parseInt(timesplit[2]))
							{	if(hseconds <10)
								{%>
								<option value='<%=hseconds%>'selected>0<%=hseconds%></option>
								<%}else{%>
								<option value='<%=hseconds%>'selected><%=hseconds%></option>
								<%}%>
							<%}else{
								if(hseconds <10)
								{%>
								<option value='<%=hseconds%>'>0<%=hseconds%></option>
								<%}else{%>
								<option value='<%=hseconds%>'><%=hseconds%></option>
								<%}%>
							<%}}
						    }
						  	
						%>
						</select>
						
					  </td>
					</tr>
					<tr>
					  <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_DISABLED_FROM")%> <span class="mandatory_indicator">*</span> </td>
					  <td  class="textfield">
						<input dir="LTR" type="text" name='<%=SSOAdminUserManager.sUserDisabledFromDt%>' id='<%=SSOAdminUserManager.sUserDisabledFromDt%>' class="textfieldfont1" size="18"  maxlength="10" value='<%=ssoresp.get(SSOAdminUserManager.sUserDisabledFromDt)%>' <%=isDisabled%>>
						<%
						if(isDisabled.trim().length() == 0){ 
						%>
						<a href="javascript:openDateWin('<%=SSOAdminUserManager.sUserDisabledFromDt%>');">
						<img width="24" height="19" src="ui/images/calendar.gif" align="absmiddle" border="0" alt="Date picker">						
						</a>
						<%} 
						else{%>
						<img width="24" height="19" src="ui/images/calendar.gif" align="absmiddle" border="0" alt="Date picker">
						<%}%>
					 </td>
					  <td  class="coloumnwidth">&nbsp;</td>
					  <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_DISABLED_TO")%> <span class="mandatory_indicator">*</span></td>
					  <td  class="textfield">
						<input dir="LTR" type="text" name='<%=SSOAdminUserManager.sUserDisabledToDt%>' id='<%=SSOAdminUserManager.sUserDisabledToDt%>' class="textfieldfont1" size="18"  maxlength="10" value='<%=ssoresp.get(SSOAdminUserManager.sUserDisabledToDt)%>' <%=isDisabled%>>
						<%if(isDisabled.trim().length() == 0){ 
						%>
						<a href="javascript:openDateWin('<%=SSOAdminUserManager.sUserDisabledToDt%>');">
						<img width="24" height="19" src="ui/images/calendar.gif" align="absmiddle" border="0" alt="Date picker">						
						</a>
						<%} 
						else{%>
						<img width="24" height="19" src="ui/images/calendar.gif" align="absmiddle" border="0" alt="Date picker">
						<%}%>
						
					  </td>
					</tr>
					<tr>
					  <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_PW_EXPY_DATE")%> <span class="mandatory_indicator">*</span></td>
					  <td  class="textfield">
					  	<%if(!sNewUserChecked.equals("checked") && isDisabled.trim().length() == 0){ 
						%>
						<input type="text" name='<%=SSOAdminUserManager.sPwExpiryDate%>' id='<%=SSOAdminUserManager.sPwExpiryDate%>' class="textfieldfont1" dir="LTR" size="18"  maxlength="10" value='<%=ssoresp.get(SSOAdminUserManager.sPwExpiryDate)%>'  <%=isDisabled%>>
						<a href="javascript:openDateWin('<%=SSOAdminUserManager.sPwExpiryDate%>');">
						<img width="24" height="19" src="ui/images/calendar.gif" align="absmiddle" border="0" alt="Date picker">						
						</a>
						<%} 
						else{%>
						<input type="text" name='<%=SSOAdminUserManager.sPwExpiryDate%>' id='<%=SSOAdminUserManager.sPwExpiryDate%>' class="textfieldfont1" dir="LTR" size="18"  maxlength="10" value='<%=ssoresp.get(SSOAdminUserManager.sPwExpiryDate)%>' readonly <%=isDisabled%>>
						<img width="24" height="19" src="ui/images/calendar.gif" align="absmiddle" border="0" alt="Date picker">
						<%}%> 
					  </td>
					  <td  class="coloumnwidth">&nbsp;</td>
					  <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_ACCT_EXPY_DATE")%> <span class="mandatory_indicator">*</span></td>
					  <td  class="textfield"><input type="text" name='<%=SSOAdminUserManager.sAcctExpiryDate%>' id='<%=SSOAdminUserManager.sAcctExpiryDate%>' class="textfieldfont1" dir="LTR" size="18"  maxlength="10" value='<%=ssoresp.get(SSOAdminUserManager.sAcctExpiryDate)%>' <%=isDisabled%>>
						<%if(isDisabled.trim().length() == 0){ 
						%>
						<a href="javascript:openDateWin('<%=SSOAdminUserManager.sAcctExpiryDate%>');">
						<img width="24" height="19" src="ui/images/calendar.gif" align="absmiddle" border="0" alt="Date picker">						
						</a>
						<%} 
						else{%>
						<img width="24" height="19" src="ui/images/calendar.gif" align="absmiddle" border="0" alt="Date picker">
						<%}%>
					</td>
					</tr>						
					<tr>
					  <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_ROLE_ID")%></td>
					  <td  class="textfield">
						<select id='<%=SSOAdminUserManager.sRoleID%>' name='<%=SSOAdminUserManager.sRoleID%>' class="textfieldfont1" <%=isDisabled%>>
						  <option value="" selected><%=sso_res.getString("ADMIN_TXT_SEL")%></option>
							<%
							String[] roles = SSOAdminRoleManager.getRoles();
							String isSelected = "";
							for(int i = 0; null != roles && i < roles.length; i++)
							{
								roles[i] = SSOUtils.htmlEncode(roles[i]);
							   if(roles[i].equals(ssoresp.get(SSOAdminUserManager.sRoleID)))
								isSelected = SSOAdminUtils.SELECTED;
							   else isSelected = "";
							%>
							<option value="<%=roles[i]%>" <%=isSelected%>><%=roles[i]%></option>
							<%}%>
						</select>
					  </td>
					  <td  class="coloumnwidth">&nbsp;</td>
					  <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_INACTIVE_DAYS")%> <span class="mandatory_indicator">*</span> </td>
					  <td  class="textfield">
						<input type="text" name='<%=SSOAdminUserManager.sMaxAcctInactive%>' id='<%=SSOAdminUserManager.sMaxAcctInactive%>' class="textfieldfont1" maxlength="3" value='<%=ssoresp.get(SSOAdminUserManager.sMaxAcctInactive)%>' <%=isDisabled%>>
					  </td>
					</tr>
					<%}
					if(isKerberos) { %>
					<tr>
					  <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_ROLE_ID")%></td>
					  <td  class="textfield">
						<select id='<%=SSOAdminUserManager.sRoleID%>' name='<%=SSOAdminUserManager.sRoleID%>' class="textfieldfont1" <%=isDisabled%>>
						  <option value="" selected><%=sso_res.getString("ADMIN_TXT_SEL")%></option>
							<%
							String[] roles = SSOAdminRoleManager.getRoles();
							String isSelected = "";
							for(int i = 0; null != roles && i < roles.length; i++)
							{
								roles[i] = SSOUtils.htmlEncode(roles[i]);
							   if(roles[i].equals(ssoresp.get(SSOAdminUserManager.sRoleID)))
								isSelected = SSOAdminUtils.SELECTED;
							   else isSelected = "";
							%>
							<option value="<%=roles[i]%>" <%=isSelected%>><%=roles[i]%></option>
							<%}%>
						</select>
					  </td>
				  	  <td  class="coloumnwidth" colspan="4">&nbsp;</td> 
					</tr>
					<%}%>
					<tr>
					<td class="textlabel"><%=sso_res.getString("ADMIN_LBL_IS_GLOBAL_ADMIN")%></td>
					  <td  class="textfield">
                            <%
								 String isGlobalAdmDisabled = isDisabled;
								if(SSOUserProfile.IS_NOT_GLOBAL_ADMIN == cIsGlobalAdm)
								//If Local Admin - Disable Global Admin Radio Buttons
								isGlobalAdmDisabled	= "disabled";																										   %>
					   <input name="<%=SSOAdminUserManager.sIsGlobalAdmin%>" type="radio" value="Y" <%=isGlobalAdminChecked%> <%=isGlobalAdmDisabled%>><%=sso_res.getString("ADMIN_LBL_YES")%>	
					   <input name="<%=SSOAdminUserManager.sIsGlobalAdmin%>" type="radio" value="N" <%=isGlobalAdminUnChecked%> <%=isGlobalAdmDisabled%>><%=sso_res.getString("ADMIN_LBL_NO")%>	
					 </td>						  
					  <td  class="coloumnwidth">&nbsp;</td>
					<td class="textlabel"><%=sso_res.getString("ADMIN_LBL_MAX_INACTIVE_TIME")%> <span class="mandatory_indicator">*</span> </td>
					  <td  class="textfield">
						<input type="text" name='<%=SSOAdminUserManager.sMaxInactiveTime%>' id='<%=SSOAdminUserManager.sMaxInactiveTime%>' class="textfieldfont1" maxlength="17" value='<%=ssoresp.get(SSOAdminUserManager.sMaxInactiveTime)%>' onChange="javascript:checkIfInteger(this);" <%=isDisabled%>>
					  </td>				 					  
					</tr>			
					<tr>
					<td class="textlabel"><%=sso_res.getString("ADMIN_LBL_CALENDAR_FORMAT")%></td>
					  <td  class="textfield">
						<select id='<%=SSOAdminUserManager.sDefaultCalendar%>' name='<%=SSOAdminUserManager.sDefaultCalendar%>' class="textfieldfont1" <%=isDisabled%>>
						   <%
						   	SSOCalendar[] allCalendars = SSOAdminUtils.getCalendarList();
						   	for (int j = 0 ; j < allCalendars.length ; j++)
							{
								SSOCalendar calObj = allCalendars[j];
								if(String.valueOf(calObj.calType).equals(defaultCalendar)){%>	
									<option selected value='<%=calObj.calType%>'> <%=calObj.calDesc%> </option>
								<%}
								else{%>		
									<option value='<%=calObj.calType%>'> <%=calObj.calDesc%> </option>	
								<%}
							}
							%>
						</select> 
					  </td>

							
					  <td  class="coloumnwidth">&nbsp;</td>
					  <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_DEFAULT_TZ")%> </td>
					 <td  class="textfield"><input type="text" name='<%=SSOAdminUserManager.sDefaultTimeZone%>' id='<%=SSOAdminUserManager.sDefaultTimeZone%>' class="textfieldfont1" size="18"  maxlength="5" value='<%=defaultTZ%>' <%=isDisabled%>>
						<%if(isDisabled.trim().length() == 0){ 
						%>
						<a href="javascript:getTZDetails(0,usercreateform_object.default_tz);">
						<img width="16" height="17" src="ui/images/search_icon.gif" align="absmiddle" border="0" alt="<%=sso_res.getString("ADMIN_TZ_SRCH")%>">						
						</a>
						<%} 
						else{%>
						<img width="16" height="17" src="ui/images/search_icon.gif" align="absmiddle" border="0" alt="<%=sso_res.getString("ADMIN_TZ_SRCH")%>">
						<%}%>
					</td> 
					</tr>
					<%if((!isExternalSSO)&&(null != isTFAReq && isTFAReq.trim().equals("true"))) {
						//doMpinEnable will not be called on onclick case in Biometrics case
						String sMPIN = (String)ssoresp.get(SSOAdminUserManager.sMPIN);
                        if("checked".equals(isTFAChecked) && (SSOConstants.EVENT_ADD_USER_CREDS.equals(opCode) && !isError))
                            sMPIN = SSOAdminUserManager.DEFAULT_MPIN;
                        String sOnClick = (!"B".equals(tfaType)) ? "onClick=\'doMpinEnable(\""+SSOAdminUserManager.DEFAULT_MPIN+"\",\""+isCurrTFA+"\")\'" : "";
					%>
					<tr>					  
					  <td class="textlabel"><%=sso_res.getString("ADMIN_LBL_TWO_FACTOR_AUTH")%></td>
					  <td  class="textfield">
						<input name="<%=SSOAdminUserManager.sReqTwoFactorAuth%>" type="radio" value=<%=String.valueOf(SSOUserProfile.TWO_FACTOR_NEEDS_CHG)%> <%=isTFAChecked%> onClick='doMpinEnable("<%=SSOAdminUserManager.DEFAULT_MPIN%>");' <%=isDisabled%>><%=sso_res.getString("ADMIN_LBL_YES")%>	
						<input name="<%=SSOAdminUserManager.sReqTwoFactorAuth%>" type="radio" value=<%=String.valueOf(SSOUserProfile.TWO_FACTOR_AUTH_NOT_REQ)%> <%=isTFAUnChecked%> onClick='doMpinEnable("<%=SSOAdminUserManager.DEFAULT_MPIN%>");' <%=isDisabled%>><%=sso_res.getString("ADMIN_LBL_NO")%>	
			  		  </td>	
			  		  <td  colspan="3">&nbsp;</td>
			  		</tr>
			  		<% if (!"B".equals(tfaType)) {%>
					<DIV  id='mpinDiv' style='position:absolute;visibility:hidden;'>
					<tr>
					  <td class="textlabel"><%=sso_res.getString("ADMIN_TXT_MPIN")%></td>
					  <td  class="textfield">
					  <input name="<%=SSOAdminUserManager.sMPIN%>" type="password" value="<%=ssoresp.get(SSOAdminUserManager.sMPIN)%>" class="textfieldfont1" size="18" maxlength='<%=sso_res.getString("SSO_CHNG_MPIN_LEN")%>' <%=enableMpinText%>>
					  </td>
					  <td  class="coloumnwidth">&nbsp;</td>
					  <td class="textlabel"><%=sso_res.getString("ADMIN_TXT_CMPIN")%></td>
					  <td  class="textfield">
					  <input name="<%=SSOAdminUserManager.sConfMPIN%>" type="password" value="<%=ssoresp.get(SSOAdminUserManager.sMPIN)%>" class="textfieldfont1" size="18" maxlength='<%=sso_res.getString("SSO_CHNG_MPIN_LEN")%>' <%=enableMpinText%>>
					  </td>
					</tr>			
					</DIV>					
					<%}}%>
		   										
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
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr class="rowspacing">
		  <td style="height:5px"><spacer type="block" width="1" height="1"></spacer></td>
		</tr>
	</table>
	<% if(opCode.equals(SSOAdminUtils.SSO_INQUIRE_OPTION)) 
	{%>
	<input type="button" name="Submit3" value='<%=sso_res.getString("ADMIN_BTN_OK")%>' class="button" onClick='javascript:doCancel(document.usercreateform, "cancelUser");'>
	<%}
	else{
	 String sVerify = isVerifyReq.trim().equals("true") ? sso_res.getString("user_creds_delete"): SSOConstants.NO;
	 if((opCode.equals(SSOConstants.EVENT_DEL_USER_CREDS)) && (sVerify.equals("NO"))){
		HashMap hmUserResList = (HashMap)ssoresp.getObject(SSOConstants.USER_RES_LIST);
		%>
		<script language='javascript'>
			userResListForDel = new Object();
		</script>
		<%
		String sUserResListArr = "";
		String [] aStr = (hmUserResList!=null)?
			(String [])(hmUserResList.get(sUserID)) : null;
		if(aStr != null && aStr.length != 0) {
			StringBuffer sb = new StringBuffer();
			for(int i=0;i<aStr.length;i++){
				sb.append("\"").append(aStr[i]).append("\",");
			}
			sUserResListArr = sb.substring(0, sb.length()-1);
		}
		%>
		<script language='javascript'>
		userResListForDel['<%=sUserID%>'] = 
				new Array(<%=sUserResListArr%>);
		</script>					
	<%}%>	
	<input type="button" name="Submit2" value='<%=sso_res.getString("ADMIN_BTN_SUBMIT")%>' class="button" onClick='javascript:doCreateUser("<%=sVerify%>");'>
	<input type="button" name="Submit3" value='<%=sso_res.getString("ADMIN_BTN_CANCEL")%>' class="button" onClick='javascript:doCancel(document.usercreateform, "cancelUser");'>
	<%}%>
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
					  <SPAN name="arrowSpan1" id="arrowSpan1">
					  <a href='javascript:showVerifyPage(<%=(startIndex)%>,"<%=SSOAdminUtils.USER_CREATE_MENU%>",-10)'>
					  <img src="ui/images/arrowpre.gif" width="7" height="14" border="0"></a></td>
					  </SPAN>
					<%}
					else{%>
					&nbsp;&nbsp;</td>
					<%}%>
					<td><%=sso_res.getString("ADMIN_LBL_PAGE")%>&nbsp;&nbsp;<%=(startIndex/10+1)%>&nbsp;&nbsp;<%=sso_res.getString("ADMIN_LBL_OF")%>&nbsp;&nbsp;<%=(data.length/10+1)%>&nbsp;&nbsp;</td>
					<td>
					<% if (startIndex <= data.length-10){
					%>
					<SPAN name="arrowSpan2" id="arrowSpan2">
					  <a href='javascript:showVerifyPage(<%=(startIndex)%>,"<%=SSOAdminUtils.USER_CREATE_MENU%>",10)'>
					  <img src="ui/images/arrownext.gif" width="7" height="14" border="0" align="absmiddle"></a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					</SPAN>
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
			  <SPAN name="modSpan" id="modSpan">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				  <tr>
					<td width="6%" class="searcheader1a">&nbsp;</td>
					<td width="21%" class="searcheader"><%=sso_res.getString("ADMIN_LBL_EVENT_ID")%></td>
					<td width="20%" class="searcheader"><%=sso_res.getString("ADMIN_LBL_KEY_VALUE")%></td>
					<td width="20%" class="searcheader"><%=sso_res.getString("ADMIN_LBL_LOGGED_USER")%></td>
					<td width="33%" class="searcheader"><%=sso_res.getString("ADMIN_LBL_EVENT_TIME")%></td>
				  </tr>
					<script language='javascript'>
						userResListForDel = new Object();
					</script>	

				  <%
				  HashMap hmUserResList = (HashMap)ssoresp.getObject(SSOConstants.USER_RES_LIST);
				  for (int iIndex=startIndex; (null != data) && (iIndex < data.length) && (iIndex < startIndex+10); iIndex++) {
				  SSOModData dataElemet = data[iIndex]; 

					     if(0==(iIndex %2)){
				   %>
				  <tr class="searclist1a" onMouseOver="this.className='searclist1arow';" onMouseOut="this.className='searclist1a';">
				  <%}
					     else{
				  %>
				  <tr class="searclist2a" onMouseOver="this.className='searclist1arow';" onMouseOut="this.className='searclist2a';">
				  <%}
				  if("DEL_USER_CREDS".equals(data[iIndex].event_id)){

				  	String sUserResListArr = "";
				  	String [] aStr = (hmUserResList!=null)?
				  		(String [])(hmUserResList.get(data[iIndex].key_value)) : null;
				  	if(aStr != null && aStr.length != 0) {
				  		StringBuffer sb = new StringBuffer();
						for(int i=0;i<aStr.length;i++){
							sb.append("\"").append(aStr[i]).append("\",");
						}
						sUserResListArr = sb.substring(0, sb.length()-1);
					}
				  %>
					<script language='javascript'>
					userResListForDel['<%=data[iIndex].key_value%>'] = 
							new Array(<%=sUserResListArr%>);
					</script>
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
				 </SPAN>
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
	<input type="button" name="Submit" value='<%=sso_res.getString("ADMIN_BTN_SUBMIT")%>' class="button" onClick='javascript:setVerifyMenu("<%=SSOAdminUtils.USER_CREATE_MENU%>");'>
	<input type="button" name="Reject" value='<%=sso_res.getString("ADMIN_BTN_REJECT")%>' class="button" onClick='javascript:deleteModData(document.verifyForm,"<%=SSOAdminUtils.USER_CREATE_MENU%>")'>
	<input type="button" name="Cancel" value='<%=sso_res.getString("ADMIN_BTN_CANCEL")%>' class="button" onClick='javascript:doCancel(document.usercreateform, "cancelUser");'>
	<%}%>
</div>

<%}%>
</td>
</tr>
</table>
</form>
<script language='javascript'>
    usercreateform_object = document.usercreateform;
    verifyform_object = document.verifyForm;
    <%
	if(SSOConstants.YES.equals(isSuccess)){
	   String installType = SSOConfig.get(SSOConstants.FINACLE_TYPE);
	   if(SSOConstants.FINACLE_LITE.equals(installType) && SSOConstants.EVENT_ADD_USER_CREDS.equals(ssoresp.get("event_id"))){%>
	       var spans = cbeGetElementsByTagName("SPAN");
	       alert(SSOAdminResource.CONTEXT_SWITCH_MSG);
	       usercreateform_object.Submit.disabled = true;
	       usercreateform_object.Reject.disabled = true;
	       usercreateform_object.Cancel.disabled = true;
	       if(spans["arrowSpan1"]) spans["arrowSpan1"].disabled = true;
	       if(spans["arrowSpan2"]) spans["arrowSpan2"].disabled = true;
	       if(spans["modSpan"]) spans["modSpan"].disabled = true;
	       verifyform_object.user_id.value= '<%=ssoresp.get(SSOConstants.USER_ID)%>';
	       switchToApplProfile('CoreServer','A','<%=homeEntity%>',verifyform_object);
	       usercreateform_object.Submit.disabled = false;
	       usercreateform_object.Reject.disabled = false;
	       usercreateform_object.Cancel.disabled = false;
	       if(spans["arrowSpan1"]) spans["arrowSpan1"].disabled = false;
	       if(spans["arrowSpan2"]) spans["arrowSpan2"].disabled = false;
	       if(spans["modSpan"]) spans["modSpan"].disabled = false;
	      
	 <%}	    
	}%>
</script>
</body>
</html>
