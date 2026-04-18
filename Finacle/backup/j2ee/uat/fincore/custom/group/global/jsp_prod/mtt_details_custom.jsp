<!----------------------------------------------------------------------------->
<!--Name                :   mtt_details_custom.jsp
    Menu                :   MTT
    Called Jsp          :   None   
    Calling Jsp         :   None
    Called script       :   
    Description         :     
    Author              :   Lakshmi K 
    Modification History:
    <Serial No>     <Date>       <Author>             <Description>
		001		 30-AUG-2018    Lakshmi       Added code for Custom fields
		
------------------------------------------------------------------------------->
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

        ContextManager ARJspCurr =(ContextManager)session.getAttribute("CustomARJspCurr");
        String sSubGrpName = (String)ARJspCurr.getInput("subGroupName","");
        String sGrpName = ARJspCurr.getCurrentGroup();
		
		
		String hidden_ctextarea = (String)ARJspCurr.getInput("hidden_ctextarea","") ;
        String screen_ctextarea = (String)ARJspCurr.getInput("screen_ctextarea","") ;
		
        ARJspCurr.setInput("hidden_ctextarea",hidden_ctextarea);
        ARJspCurr.setInput("screen_ctextarea",screen_ctextarea);
		
		
	String [] custData1 = (String [])ARJspCurr.getInput(com.infy.bbu.ons.common.CommonConstants.KEY_CUSTOM_DATA, null);
	if(custData1 == null) {
				custData1 = new String[1];
				custData1[0] = "";
	}
	else
	{
		String[] result = CommonFunctions.split(custData1[0], '|');
                System.out.println("mtt details... "+custData1[0]);
				 int  mttIndex = Arrays.asList(result).indexOf("~mtt_details");
                System.out.println("mttIndex.... "+ mttIndex);
				
				          if(mttIndex >= 0)
		{

		        	hidden_ctextarea=result[mttIndex+1];
		        	ARJspCurr.setInput("hidden_ctextarea",result[mttIndex+1]);
		        	ARJspCurr.setInput("screen_ctextarea",result[mttIndex+1]);
				
					
		}

    }
		
%>

<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("common_functions.js",sProfileId)%>" > </SCRIPT>
<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_post_evt.js",sProfileId)%>" > </SCRIPT>
<SCRIPT language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("cust_pre_evt.js",sProfileId)%>" > </SCRIPT>

<script language="javascript">
with(document)
{
	
		write('<input type="hidden" id="hidden_ctextarea"   name="hidden_ctextarea">');
		
		
	
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
		
/*	write('<tr>');
	write('<td class="textlabel"  colSpan="2">Custom Text Description</td>');
   write('<td class="textfield"  colSpan="2">');
	write('<input type="text" class ="textfieldfont" id="c_textdesc" maxlength = "60"  name="c_textdesc" >&nbsp;');
	write("&nbsp;");
	write('<a id="sLnk2" href="javascript:fnShowTextArea()">');
	write('<img src="../images/'+applangcode+'/misc_popup.gif" alt="'+jspResArr.get("FLT022710")+'" width="16" height="16" border="0"></a>');
	write('</td>');
	write('</tr>');
*/		write("<tr>");
		write('<td class="textlabel">Custom Text Description</td>');
        write('<td>');
        write('<input type="text" class ="textfieldfont" disabled = "true" hotKeyId="search1" id="screen_ctextarea" maxlength = "45500"  name="screen_ctextarea" >&nbsp;');
		write('<a id="sLnik25"  href="javascript:showTextAreaTemp(sLnik25);">');
		write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
        write('</td>'); 
		write("</tr>");
		write("<tr>");
		write('<td class="textlabel">(To Be Entered For SWIFT message only)</td>');
		write("</tr>");

	
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
        write("</td>");
        write("</tr>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write('</table>');

		write('<br>');
}

var glb_addConditions;
var glb_addConditions1;


function showTextAreaTemp(objButton)
{
	 if(objButton.id == "sLnik25")
	 {
		
	    var ret= showTextArea('hidden_ctextarea','','N','left','U','N',65,800,'string','Y','Y');
		
	 }
	 
	 
	  if(objButton.id == "sLnik25")
		{
			if(window.showModalDialog)
			{
				
				if (ret != null && ret != undefined )
				{ 
					
					document.forms[0].screen_ctextarea.value  = ret;
					//alert("inside "+document.forms[0].screen_ctextarea.value);
					document.forms[0].hidden_ctextarea.value  = ret;
					setFieldsToCustomData("screen_ctextarea","hidden_ctextarea");
					//alert("inside "+document.forms[0].hidden_ctextarea.value);
		            
				}
				
			}
		}
	
}
function getJavaValue()
{
  
  //alert("inside getJavaValue");
   glb_addConditions = "<%=hidden_ctextarea%>";
   //alert(glb_addConditions);

  
   
}
function mtt_details_post_ONLOAD()
{
	
	//alert("inside postonload");
	objForm = document.forms[0];
	getJavaValue();
	document.forms[0].screen_ctextarea.value  = glb_addConditions;
	//alert(document.forms[0].screen_ctextarea.value);
   document.forms[0].hidden_ctextarea.value  = glb_addConditions;
   //alert(document.forms[0].hidden_ctextarea.value);
 
  
   setFieldsToCustomData("screen_ctextarea","hidden_ctextarea");
   getFieldsFromCustomData("screen_ctextarea","hidden_ctextarea");
   
}

</script>
