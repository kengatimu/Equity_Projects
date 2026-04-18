<%--  	User Additional Details.

	This jsp file is hand coded and not generated. 
	This file can be customized at sites for User Additional Details sub option in HTM.
	The file name of this jsp should not be changed.
	This file should reside in finbranch/custom/jsp folder	--%>


<%--    This is the COMMON include for any custom tab/menu --%>
<%@ include file='../commonInclude.jsp'%>
<% 
	response.setHeader("Pragma","No-Cache"); 
	response.setDateHeader("Expires",0); 
	response.setHeader("Cache-Control","no-Cache,no-store"); 
%> 

<%@ page import="com.infy.bbu.ons.common.CommonConstants" %>

<%--    The GROUPNAME specified below should be same as the value of pagename HIDDEN field below  --%>
<arjsp:init groupName="custom" isEntryPoint="false" />
<% 
	String sFinContextPath  = request.getContextPath();
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
<script language="JavaScript1.2" src="../scripts/calendar.js"></script>
<script language="JavaScript1.2" src="../scripts/tjmlib.js"></script>
<script language="JavaScript1.2" src="../scripts/textfield.js"></script>
<script language="JavaScript1.2" src="../scripts/FrequencyIndicator.js"></script>
<SCRIPT LANGUAGE="JavaScript1.2" FOR="document" EVENT="onkeyup"> </SCRIPT>

<% if (null != sBaseHref) { %>
<base href="<%=sBaseHref + sFinContextPath + "/custom/"%>">
<% } %>

<script>

var frm = null;
var sPopUpExceptionWindow = null;
var funcCode = null;	

function fnOnLoad() {
	frm = document.forms[0];
	sPopUpExceptionWindow = '<%=ARJspCurr.getInputWithGroup("PopUpExceptionWindow", null)%>';
	funcCode = '<%=ARJspCurr.getInputWithGroup("funcCode", null)%>';
	tranSubType = '<%=ARJspCurr.getInputWithGroup("tranSubType", null)%>';
	initFocusHandler();
	frm.uadinfo.value = '<%=(String)ARJspCurr.getInputWithGroup("uadinfo",null) %>';
	getCustomFieldValueTM("freeFld1","freeFld2","freeFld3","freeFld4");
	if (profileId==54)
	{
		if (funcCode == 'A' || funcCode == 'D' || funcCode == 'V' || funcCode == 'P'){
		alert("add page");	
		alert(tranSubType);
		if(tranSubType=='NP' || tranSubType=='NR'){
			e1 = document.getElementById("freeFld1");
			e2 = e1.parentNode;
			e2.previousSibling.innerText = "Vino";	
		}
		}
	}
	
	if (funcCode == 'I' || funcCode == 'D' || funcCode == 'V' || funcCode == 'P')
	{
		disableFormElements(4);
		frm.Accept.disabled = true;
	}
	else if (funcCode == 'A' || funcCode == 'M' || funcCode == 'C' || funcCode == 'T')
	{
		enableFormElements(4);
		frm.freeFld1.focus();
		frm.Accept.disabled = false;
		frm.Cancel.disabled = false;
	}
}

function getCustomFieldValueTM() {
    getFromHiddenDataTM(document.forms[0].pagename,arguments);
}

//Sets the Custom Data to individual fields
function getFromHiddenDataTM() {
    var strValue = document.forms[0].uadinfo.value;
    var name = arguments[0].value;
    if(strValue.indexOf(name) != -1){
        strFirst = strValue.substring(0,(strValue.indexOf(name)));
        intlen = strFirst.length - name.length;
        strFirst = strFirst.substring(0,intlen);
        strTemp = strValue.substring((strValue.indexOf(name)+(name.length+1)),strValue.length);
        if(strTemp.indexOf("~") != -1)
            strLast = strTemp.substring(0,strTemp.indexOf("~"));
        else
            strLast = strTemp;

        strValue = strLast;
    }
    else{
        strValue = "";
    }

    for(i=0;i<arguments[1].length;i++){
        if(eval("document.forms[0]."+arguments[1][i]) != undefined){
            var fieldObj = eval("document.forms[0]."+arguments[1][i]);
            var isArray = (typeof(fieldObj.length)=="undefined")?false:true;
			if(strValue.indexOf("|") != -1){
				if(isArray)
				{
					if(fieldObj.type == "radio") 
					setRadioValue(arguments[1][i],strValue.substring(0,strValue.indexOf("|")));  
                    	else  
                    fieldObj.value = strValue.substring(0,strValue.indexOf("|"));  
				}
				else
				{
        	        var fldVal = strValue.substring(0,strValue.indexOf("|"));  
                        if(fieldObj.type == "checkbox")  
                        {  
                            if(fldVal == 'Y')  
                            fieldObj.checked = true;          
                        }  
                    else  
                             fieldObj.value = fldVal; 

                }
			   	strValue = strValue.substring((strValue.indexOf("|")+1),strValue.length);
            }
            else{
					 if(isArray)
					 {
						if(fieldObj.type == "radio")  
                        setRadioValue(arguments[1][i],strValue);  
                        	else  
                        fieldObj.value = strValue 
					}
					else
					{
            		    var fldVal = strValue;  
                        if(fieldObj.type == "checkbox")  
                        {  
                            if(fldVal == 'Y')  
                                fieldObj.checked = true;          
                        }  
                        else  
                        	fieldObj.value = fldVal 
					}
                strValue = "";
            }
        }
    }
}

function fnValidateForm(objButton){
	//Used to set the custom data in the hidden field.
	setCustomFieldValueTM("freeFld1","freeFld2","freeFld3","freeFld4");
	//vp 12/09/2019
	if (profileId==54)
	{
		if(document.forms[0].freeFld1.value == ""){
                alert("Enter FULL NAME");
                return false;
        }
	if(document.forms[0].freeFld2.value == ""){
                alert("Enter ID/PP/ALIEN");
                return false;
        }
	if(document.forms[0].freeFld3.value == ""){
                alert("Enter NATIONALITY");
                return false;
        }
	if(document.forms[0].freeFld4.value == ""){
                alert("Enter SOURCE/PURPOSE");
                return false;
        }
	}
	
	//vp 12/09/2019	
	frm.submitform.value= objButton;	
	frm.actionCode.value = objButton;
	
	frm.rtId.value = rtId; 
	frm.reqId.value = reqId; 
	doSubmitForm(objButton); 	
	return true;
}
function fnCancelForm(objButton){
	frm.submitform.value= objButton;	
	frm.actionCode.value = objButton;
	frm.rtId.value = rtId; 
	frm.reqId.value = reqId; 
	doSubmitForm(objButton); 	
	return true;
}

function setCustomFieldValueTM() {
    setInHiddenDataTM(document.forms[0].pagename,arguments);
}

function setInHiddenDataTM(){
    var sFieldValues = "";
    var strValue = document.forms[0].uadinfo.value;
    var name = arguments[0].value;
    if(strValue.indexOf(name) != -1){
        strFirst = strValue.substring(0,(strValue.indexOf(name)));
        intlen = strFirst.length - 1;
        strFirst = strFirst.substring(0,intlen);
        strTemp = strValue.substring((strValue.indexOf(name)+1),strValue.length);
        if(strTemp.indexOf("~") != -1)
        strLast = strTemp.substring(strTemp.indexOf("~"),strTemp.length);
        else
        strLast = "";

        strValue = strFirst + strLast;

    }

    for(i=0;i<arguments[1].length;i++){
        if(eval("document.forms[0]."+arguments[1][i]) != undefined){
            var fieldObj = eval("document.forms[0]."+arguments[1][i]);
			var fieldVal = "";  
        	if(fieldObj.type == "radio")  
                fieldVal = getRadioValue(fieldObj);  
            else  
            	fieldVal = fieldObj.value; 
	

            if(i == 0)
                sFieldValues= sFieldValues + fieldVal + "|";
            else
                sFieldValues= sFieldValues + fieldVal + "|";
        }
    }
    if(sFieldValues.length > 0){
        strValue= strValue+"~"+name+"|";
        strValue = strValue+sFieldValues;
    }
    document.forms[0].uadinfo.value = strValue ;
}


function printFooterBlock()
{
    with (document) {
    write('<input type="button" class="Button" id="Accept" value="Accept" onClick="javascript:return fnValidateForm(this.id);" hotKeyId="Go" >'); 
     write('<input type="button" class="Button" id="Cancel" value="Cancel" onClick="javascript:return fnCancelForm(this.id);" hotKeyId="Cancel" >');
  }
} 

</script>
</head>

<TITLE>User Additional Details</TITLE>
<META http-equiv="Content-Type" content="text/html;charset=utf-8">
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getResourceFile("finbranchResource_"+LocaleMapper.getLangCode(pageContext)+".js") %>"  > </script> 
<LINK href="../Renderer/stylesheets/services.css" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />
<script language="javascript" src="../MenuRenderer/mtree/01_GU_BT_999_INFENG_FIN.js"></script>
<script language="javascript" src="../Renderer/mtree/precArray.js"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("core_banking.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("resource_functions.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("hotkeyprocessor_link.js",sProfileId)%>"> </script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("hotkeydata_link.js",sProfileId)%>"> </script>
</head>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("common_functions.js",sProfileId)%>" > </script>
<body onLoad = "fnOnLoad();">
<form method="post" action="./custom_ctrl.jsp">
<span class="cform">
<%@ include file="../../javascripts/appl_inc.js" %>
<%@ include file="../../javascripts/header.js"%>
<BODY class="cbody" onKeyDown="fnKeyDownProcessor(event)" onLoad="fnPopulateFields()" onKeyUp="fnKeyUpProcessor(event)">
<table border="0" cellspacing="0" cellpadding="0" class="ctable">
<tr>
<td>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td class="page-heading">User Additional Details
</td>
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
<input type="Hidden" name="pagename" value="custom">
<input type="Hidden" name="submitform" value="">
<input type="Hidden" name="callPage" value="self">
<input type="hidden" name="uadinfo" id ="uadinfo">
<script>document.write('<input type="Hidden" name="rtId" id="rtId" value="'+rtId+'">') 
</script> 
<script>document.write('<input type="Hidden" name="reqId" id="reqId" value="'+reqId+'">') 
</script> 
<tr></tr>
<tr>
<td class="textlabel">FULL NAME<script>setMandatory("Y")</script></td>	
<td class="textfield">
<input type="text" class="textfieldfont" name="custom.freeFld1" id="freeFld1" value="" size="16" maxlength = "30">
</td>
<td class="textlabel">ID/PP/ALIEN<script>setMandatory("Y")</script></td>	
<td class="textfield">
<input type="text" class="textfieldfont" name="custom.freeFld2" id="freeFld2" value="" size="16" maxlength = "30">
</td>
</tr>
<tr>
<td class="textlabel">NATIONALITY<script>setMandatory("Y")</script></td>	
<td class="textfield">
<input type="text" class="textfieldfont" name="custom.freeFld3" id="freeFld3" value="" size="16" maxlength = "30">
</td>
<td class="textlabel">SOURCE/PURPOSE<script>setMandatory("Y")</script></td>	
<td class="textfield">
<input type="text" class="textfieldfont" name="custom.freeFld4" id="freeFld4" value="" size="16" maxlength = "30">
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
