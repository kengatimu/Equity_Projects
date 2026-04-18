<!----------------------------------------------------------------------------------------------------->
<!--   File                           : irmbilldet1_custom.jsp
<!--   Description                    : Custom jsp for remittance bill details tab (SWIFT 2023).
<!--   Author                         : Vanathi G.
<!--   SNo         Date                               Author Name                          Description
<!--   001         13 Apr 2023                       Vanathi.                    Initial Version
<!----------------------------------------------------------------------------------------------------->
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="com.infy.finbranch.groups.*"%>
<%@ page import="com.infy.bbu.jsputil.*,FABInquiry.*"%>
<%@ page import="applcommon.ParseValue" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.logging.*" %>
<%@ page import="com.infy.bbu.jsputil.*"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.ObjectInputStream" %>
<%@ page import="java.io.ObjectOutputStream" %>
<%@ page import="FABInquiry.TranMiscDtl" %>
<%@ page import="fabclasses.CommonFunctions" %>
<%@ page import="fabclasses.FinErrException" %>
<%@ page import="fabclasses.ServiceRoutines" %>
<%@ page import="java.util.Vector" %>
<%@ page import="FABCommon.SecurityInfo70" %>
<%@ page import="com.infy.COTP.LinkList" %>
<%@ page import="gcode.utils.ONSClassFactory" %>
<%@ page import="com.infy.bbu.context.IServiceContext" %>
<%@ page import="com.infy.bbu.context.ContextAdapter" %>
<%@ page import="com.infy.bbu.ons.common.CommonConstants" %>
<%@ page import="gcode.iface.IreportData" %>
<%@ page import="com.infy.finbranch.groups.FileOpertn" %>
<%@ page import="java.io.File" %>

<%@ page import="java.security.PrivilegedAction" %>
<%@ page import="java.security.AccessController" %>


<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<%@ include file="/custom/commonInclude.jsp" %>


<script language="javascript" src="../Renderer/javascripts/lists/<%=VRPKeys.getFile("showTextArea.js",sProfileId)%>"></script>
<%
       ContextManager ARJspCurr = (ContextManager) session.getAttribute("CustomARJspCurr");
       String sSubGrpName = (String) ARJspCurr.getInput("subGroupName", "");
       String sGrpName = ARJspCurr.getCurrentGroup();

       String hidden_goodsOrigin = (String) ARJspCurr.getInput("hidden_goodsOrigin", "");
       String screen_goodsOrigin = (String) ARJspCurr.getInput("screen_goodsOrigin", "");
       ARJspCurr.setInput("hidden_goodsOrigin", hidden_goodsOrigin);
       ARJspCurr.setInput("screen_goodsOrigin", hidden_goodsOrigin);


       String[] custData1 = (String[]) ARJspCurr.getInput(com.infy.bbu.ons.common.CommonConstants.KEY_CUSTOM_DATA, null);
       if (custData1 == null) {
           custData1 = new String[1];
           custData1[0] = "";
       } else {
           String[] result = CommonFunctions.split(custData1[0], '|');
           int remIndex = Arrays.asList(result).indexOf("~irmbilldet1");
           if (remIndex >= 0) {

               hidden_goodsOrigin = result[remIndex + 1];
               ARJspCurr.setInput("hidden_goodsOrigin", result[remIndex + 1]);
               ARJspCurr.setInput("screen_goodsOrigin", result[remIndex + 1]);
          
           }

       }
%>
	
	
<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("common_functions.js",sProfileId)%>" > </SCRIPT>
<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_post_evt.js",sProfileId)%>" > </SCRIPT>
<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_pre_evt.js",sProfileId)%>" > </SCRIPT>
	

<script language="javascript">

with (document)
{
	write('<input type="hidden" id="hidden_goodsOrigin"   name="hidden_goodsOrigin">');	

	write('<br>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
		write("<tr>");
			write('<td valign="top">	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
			write("<tr>");
				write('<td>	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
				write("<tr>");
					write('<td>	<table name="TABLE1" width="100%" border="0" cellpadding="0" cellspacing="0">');
						write('<tr class="innertabletop1">');
							write('<td height="25" colspan="5" align="right">	<table border="0" cellspacing="0" cellpadding="0">');
								write("</table>");
							write("</td>");
						write("</tr>");
											
						write('<tr>');
							write('<td class="textlabel">Origin of Goods</td>');
							write('<td class="textfield">');
							write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_goodsOrigin" maxlength = "140"  name="screen_goodsOrigin" >');
							write("&nbsp;");
							write('<a id="cLnik2"  href="javascript:showTextAreaTemp(cLnik2);">');
							write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
							write('</td>');
							write('<td class="columnwidth">&nbsp;</td>');
							write('<td class="textlabel">&nbsp;</td>');
							write('<td class="textfield">&nbsp;</td>');

						write('</tr>');
					write("</table>");
					write('</td>');
				write('</tr>');
				write('<tr class="rowspacing">');
					write('<td colspan="5"><spacer type="block" height="1" width="1"></spacer></td>');
				write("</tr>");
				write("</table>");
				write("</td>");
			write("</tr>");
			write("</table>");
			write("</td>");
		write("</tr>");
		write("</table>");
	
		
	write('<tr>');
	write('<td>');
	write('</td>');
	write('</tr>');
	write('<br>');
	
 }

function setToCustom() {
	
	setFieldsToCustomData("screen_goodsOrigin", "hidden_goodsOrigin");
}

var glb_goodsOrigin;
var glb_objButtonId;

function showTextAreaTemp_callback(ret)
{
	if (ret != null && ret != undefined)
	{
		ret = decodeURIComponent(ret);
	}

	if (glb_objButtonId == "cLnik2")
	{
		if (ret != null && ret != undefined)
		{
			document.forms[0].screen_goodsOrigin.value = ret;
			document.forms[0].hidden_goodsOrigin.value = ret;
			glb_goodsOrigin = ret;
			setToCustom();
		}
	}
	doSubmit("Validate");
}


function showTextAreaTemp(objButton) 
{
	glb_objButtonId = objButton.id;

	if ((mopId == "HIRM") || (mopId == "HORM") || (mopId == "hirm") || (mopId == "horm")) 
	{

		if(!(window.showModalDialog))
		{
			callBackFn = "showTextAreaTemp_callback";
		}

		if ((funcCode == "G" || funcCode == "J" ||funcCode == "M" || funcCode == "C" || funcCode == "S" || funcCode == "W"  ) && (checkEventType == "G"  || checkEventType == "J" || checkEventType == "M" ||checkEventType == "R"|| checkEventType == ""))
		{
			if (objButton.id == "cLnik2") 
			{
				var ret = showTextArea('hidden_goodsOrigin', '', 'N', 'left', 'U', 'N',140,1, 'string', 'Y', 'Y', 'C'); 
			} 
		} 
		else 
		{
			if (objButton.id == "cLnik2")
			{
				var ret = showTextArea('hidden_goodsOrigin', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'N', 'Y', 'C');
			}
		}

		if (window.showModalDialog)
		{

			if (ret != null && ret != undefined) 
			{
				ret = decodeURIComponent(ret);
			}

			if (objButton.id == "cLnik2") 
			{
				if (ret != null && ret != undefined) 
				{
					document.forms[0].screen_goodsOrigin.value = ret;
					document.forms[0].hidden_goodsOrigin.value = ret;
					setToCustom();
				}
			} 
			doSubmit("Validate");
		}
	}
}

function getJavaValue() 
{
	var funcCode = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("funcCode",""))%>';
 	glb_goodsOrigin = "<%=ParseValue.checkString(hidden_goodsOrigin)%>";
}

function irmbilldet1_post_ONLOAD() 
{
    
	var inputNameValues = "";
	var outputNames = "";
    var scrName = "swift2023_switch.scr";
	
	// Do not remove the plus symbol and the two single quotes
    var retVal = appFnExecuteScript(inputNameValues, outputNames,scrName, false) + '';
    var ret = retVal.split("|");
	
	if(ret[1] == "N")
    {
        var SWIFT2023_enabled = "N";
		
		document.forms[0].screen_goodsOrigin = "";
		document.forms[0].hidden_goodsOrigin = "";
		document.forms[0].screen_goodsOrigin.disabled = true;
		hideImage("cLnik2");
	}

    objForm = document.forms[0];
    getJavaValue();
    
    document.forms[0].screen_goodsOrigin.value = glb_goodsOrigin;
    document.forms[0].hidden_goodsOrigin.value = glb_goodsOrigin;


    setToCustom();

    getFieldsFromCustomData("screen_goodsOrigin","hidden_goodsOrigin");
	
}




function irmbilldet1_pre_ONCLICK(obj) 
{
	
    objForm = document.forms[0];
    
	getJavaValue();

    document.forms[0].screen_goodsOrigin.value = glb_goodsOrigin;
    var screen_goodsOrigin = document.forms[0].screen_goodsOrigin.value;
    
	setToCustom();
	

}

function irmbilldet1_pre_TAB_SWITCH(obj) 
{

    getJavaValue();

    document.forms[0].screen_goodsOrigin.value = glb_goodsOrigin;
    document.forms[0].hidden_goodsOrigin.value = glb_goodsOrigin;
    var screen_goodsOrigin = document.forms[0].screen_goodsOrigin.value;
    
	setToCustom();
	
    return true;


}


</SCRIPT>
