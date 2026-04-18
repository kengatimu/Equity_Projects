<!----------------------------------------------------------------------------------------------------->
<!--   File                           : midaddtnldet_custom.jsp
<!--   Description                    : Custom jsp for MID additional details tab (SWIFT 2023).
<!--   Author                         : Ekta Shrivastava
<!--   SNo         Date                               Author Name                          Description
<!--   001         13 Apr 2023                       Vanathi G.                    Initial Version
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
	   
	   String hidden_placeOfDest = (String) ARJspCurr.getInput("hidden_placeOfDest", "");
       String screen_placeOfDest = (String) ARJspCurr.getInput("screen_placeOfDest", "");
       ARJspCurr.setInput("hidden_placeOfDest", hidden_placeOfDest);
       ARJspCurr.setInput("screen_placeOfDest", hidden_placeOfDest);
	   
	   String hidden_portOfDept = (String) ARJspCurr.getInput("hidden_portOfDept", "");
       String screen_portOfDept = (String) ARJspCurr.getInput("screen_portOfDept", "");
       ARJspCurr.setInput("hidden_portOfDept", hidden_portOfDept);
       ARJspCurr.setInput("screen_portOfDept", hidden_portOfDept);

       String hidden_portOfDest = (String) ARJspCurr.getInput("hidden_portOfDest", "");
       String screen_portOfDest = (String) ARJspCurr.getInput("screen_portOfDest", "");
       ARJspCurr.setInput("hidden_portOfDest", hidden_portOfDest);
       ARJspCurr.setInput("screen_portOfDest", hidden_portOfDest);
 


       String[] custData1 = (String[]) ARJspCurr.getInput(com.infy.bbu.ons.common.CommonConstants.KEY_CUSTOM_DATA, null);
		if (custData1 == null) {
           custData1 = new String[1];
           custData1[0] = "";
		} else {
			String[] result = CommonFunctions.split(custData1[0], '|');
			int midIndex = Arrays.asList(result).indexOf("~midaddtnldet");
			if (midIndex >= 0) {

				hidden_goodsOrigin = result[midIndex + 1];
				ARJspCurr.setInput("hidden_goodsOrigin", result[midIndex + 1]);
				ARJspCurr.setInput("screen_goodsOrigin", result[midIndex + 1]);
			   	
				hidden_placeOfDest = result[midIndex + 3];
				ARJspCurr.setInput("hidden_placeOfDest", result[midIndex + 3]);
				ARJspCurr.setInput("screen_placeOfDest", result[midIndex + 3]);
				
				hidden_portOfDept = result[midIndex + 5];
				ARJspCurr.setInput("hidden_portOfDept", result[midIndex + 5]);
				ARJspCurr.setInput("screen_portOfDept", result[midIndex + 5]);
				
				hidden_portOfDest = result[midIndex + 7];
				ARJspCurr.setInput("hidden_portOfDest", result[midIndex + 7]);
				ARJspCurr.setInput("screen_portOfDest", result[midIndex + 7]);

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
	write('<input type="hidden" id="hidden_placeOfDest"   name="hidden_placeOfDest">');	
	write('<input type="hidden" id="hidden_portOfDept"   name="hidden_portOfDept">');	
	write('<input type="hidden" id="hidden_portOfDest"   name="hidden_portOfDest">');	
	
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
							write('<td class="textlabel" >Origin of Goods </td>');
							write('<td class="textfield">');
							write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_goodsOrigin" maxlength = "140"  name="screen_goodsOrigin" >');
							write("&nbsp;");
							write('<a id="cLnik2"  href="javascript:showTextAreaTemp(cLnik2);">');
							write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
							write('</td>');
							write('<td class="columnwidth">&nbsp;</td>');
							write('<td class="textlabel" >Place of Final Destination</td>');
							write('<td class="textfield">');
							write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_placeOfDest" maxlength = "140"  name="screen_placeOfDest" >');
							write("&nbsp;");
							write('<a id="cLnik3"  href="javascript:showTextAreaTemp(cLnik3);">');
							write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
							write('</td>');
						write('</tr>');
						write('<tr>');
							write('<td class="textlabel" >Port of Loading/Airport of Departure</td>');
							write('<td class="textfield">');
							write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_portOfDept" maxlength = "140"  name="screen_portOfDept" >');
							write("&nbsp;");
							write('<a id="cLnik4"  href="javascript:showTextAreaTemp(cLnik4);">');
							write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
							write('</td>');
							write('<td class="columnwidth">&nbsp;</td>');
							write('<td class="textlabel" >Port of Discharge/Airport of Destination</td>');
							write('<td class="textfield">');
							write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_portOfDest" maxlength = "140"  name="screen_portOfDest" >');
							write("&nbsp;");
							write('<a id="cLnik5"  href="javascript:showTextAreaTemp(cLnik5);">');
							write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
							write('</td>');
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
	
	setFieldsToCustomData("screen_goodsOrigin", "hidden_goodsOrigin","screen_placeOfDest", "hidden_placeOfDest","screen_portOfDept", "hidden_portOfDept","screen_portOfDest", "hidden_portOfDest");
}

var glb_portOfDest;


function showTextAreaTemp(objButton) 
{

    if ((mopId == "MID") || (mopId == "mid")) 
	{
        if (funcCode == "L" || funcCode == "C" || funcCode == "M" )
        {
            if (objButton.id == "cLnik2") 
			{
               var ret = showTextArea('hidden_goodsOrigin', '', 'N', 'left', 'U', 'N',140,1, 'string', 'Y', 'Y', 'C'); 
		  	} 
			 if (objButton.id == "cLnik3") 
			{
               var ret = showTextArea('hidden_placeOfDest', '', 'N', 'left', 'U', 'N',140,1, 'string', 'Y', 'Y', 'C'); 
		  	} 
			if (objButton.id == "cLnik4") 
			{
               var ret = showTextArea('hidden_portOfDept', '', 'N', 'left', 'U', 'N',140,1, 'string', 'Y', 'Y', 'C'); 
		  	} 
			if (objButton.id == "cLnik5") 
			{
               var ret = showTextArea('hidden_portOfDest', '', 'N', 'left', 'U', 'N',140,1, 'string', 'Y', 'Y', 'C'); 
		  	} 
		} 
		else 
		{
            if (objButton.id == "cLnik2")
			{
				 var ret = showTextArea('hidden_goodsOrigin', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'N', 'Y', 'C');
			}
			if (objButton.id == "cLnik3")
			{
				 var ret = showTextArea('hidden_placeOfDest', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'N', 'Y', 'C');
			}
			if (objButton.id == "cLnik4")
			{
				 var ret = showTextArea('hidden_portOfDept', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'N', 'Y', 'C');
			}
			if (objButton.id == "cLnik5")
			{
				 var ret = showTextArea('hidden_portOfDest', '', 'N', 'left', 'U', 'N', 140, 1, 'string', 'N', 'Y', 'C');
			}
        }

		if (ret != null && ret != undefined) 
		{
			
			ret = decodeURIComponent(ret);
			
		}

        if (objButton.id == "cLnik2") 
		{
			if (window.showModalDialog) 
			{
				
				if (ret != null && ret != undefined) 
				{
					document.forms[0].screen_goodsOrigin.value = ret;
					document.forms[0].hidden_goodsOrigin.value = ret;
					setToCustom();
				}
			} 
			
		} 
		else if (objButton.id == "cLnik3") 
		{
			if (window.showModalDialog) 
			{
				if (ret != null && ret != undefined) 
				{
					document.forms[0].screen_placeOfDest.value = ret;
					document.forms[0].hidden_placeOfDest.value = ret;
					setToCustom();
				}
			} 
		} 
		else if (objButton.id == "cLnik4") 
		{
			if (window.showModalDialog) 
			{
				if (ret != null && ret != undefined) 
				{
					document.forms[0].screen_portOfDept.value = ret;
					document.forms[0].hidden_portOfDept.value = ret;
					setToCustom();
				}
			} 
		} 
		else if (objButton.id == "cLnik5") 
		{
			if (window.showModalDialog) 
			{
				if (ret != null && ret != undefined) 
				{
					document.forms[0].screen_portOfDest.value = ret;
					document.forms[0].hidden_portOfDest.value = ret;
					setToCustom();
				}
			} 
		} 
    }
    doSubmit("Validate");
}

function getJavaValue() 
{
	var funcCode = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("funcCode",""))%>';
 	glb_goodsOrigin = "<%=ParseValue.checkString(hidden_goodsOrigin)%>";
	glb_placeOfDest = "<%=ParseValue.checkString(hidden_placeOfDest)%>";
	glb_portOfDept = "<%=ParseValue.checkString(hidden_portOfDept)%>";
	glb_portOfDest = "<%=ParseValue.checkString(hidden_portOfDest)%>";
}

function midaddtnldet_post_ONLOAD() 
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
		document.forms[0].screen_placeOfDest = "";
		document.forms[0].hidden_placeOfDest = "";
		document.forms[0].screen_placeOfDest.disabled = true;
		hideImage("cLnik3");
		document.forms[0].screen_portOfDept = "";
		document.forms[0].hidden_portOfDept = "";
		document.forms[0].screen_portOfDept.disabled = true;
		hideImage("cLnik4");
		document.forms[0].screen_portOfDest = "";
		document.forms[0].hidden_portOfDest = "";
		document.forms[0].screen_portOfDest.disabled = true;
		hideImage("cLnik5");
	}

    objForm = document.forms[0];
    getJavaValue();
    
    document.forms[0].screen_goodsOrigin.value = glb_goodsOrigin;
    document.forms[0].hidden_goodsOrigin.value = glb_goodsOrigin;
    document.forms[0].screen_placeOfDest.value = glb_placeOfDest;
    document.forms[0].hidden_placeOfDest.value = glb_placeOfDest;
    document.forms[0].screen_portOfDept.value = glb_portOfDept;
    document.forms[0].hidden_portOfDept.value = glb_portOfDept;
    document.forms[0].screen_portOfDest.value = glb_portOfDest;
    document.forms[0].hidden_portOfDest.value = glb_portOfDest;
    setToCustom();

    getFieldsFromCustomData("screen_goodsOrigin","hidden_goodsOrigin","screen_placeOfDest","hidden_placeOfDest","screen_portOfDept","hidden_portOfDept","screen_portOfDest","hidden_portOfDest");
	
}




function midaddtnldet_pre_ONCLICK(obj) 
{
	
    objForm = document.forms[0];
    
	getJavaValue();

    document.forms[0].screen_goodsOrigin.value = glb_goodsOrigin;
    var screen_goodsOrigin = document.forms[0].screen_goodsOrigin.value;
    document.forms[0].screen_placeOfDest.value = glb_placeOfDest;
    var screen_placeOfDest = document.forms[0].screen_placeOfDest.value;
    document.forms[0].screen_portOfDept.value = glb_portOfDept;
    var screen_portOfDept = document.forms[0].screen_portOfDept.value;
    document.forms[0].screen_portOfDest.value = glb_portOfDest;
    var screen_portOfDest = document.forms[0].screen_portOfDest.value;
	setToCustom();
	

}

function midaddtnldet_pre_TAB_SWITCH(obj) 
{

    getJavaValue();

    document.forms[0].screen_goodsOrigin.value = glb_goodsOrigin;
    document.forms[0].hidden_goodsOrigin.value = glb_goodsOrigin;
    var screen_goodsOrigin = document.forms[0].screen_goodsOrigin.value;
 
	document.forms[0].screen_placeOfDest.value = glb_placeOfDest;
    document.forms[0].hidden_placeOfDest.value = glb_placeOfDest;
    var screen_placeOfDest = document.forms[0].screen_placeOfDest.value;

    document.forms[0].screen_portOfDept.value = glb_portOfDept;
    document.forms[0].hidden_portOfDept.value = glb_portOfDept;
    var screen_portOfDept = document.forms[0].screen_portOfDept.value;
 
	document.forms[0].screen_portOfDest.value = glb_portOfDest;
    document.forms[0].hidden_portOfDest.value = glb_portOfDest;
    var screen_portOfDest = document.forms[0].screen_portOfDest.value;

	setToCustom();
	
    return true;


}


</SCRIPT>
