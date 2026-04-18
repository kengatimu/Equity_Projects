<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : upmgendet_custom.jsp 
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 18-01-2013
<!--Author              : Prakash 
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : HUPM
<!--Modification History:
<!--	Version No.	      Date		         Author 	       	Description
<!--	-------        	----------         -----------        ------------------
<!--     0.1	    	18-01-2013	         Prakash           Original version
<!--	 0.2			27-06-2013			 Hari/Nithya		Added code related to Temp Role Maint
<!--	 0.3			22-07-2013			 Bharath			Removed include statement of commonInclude.jsp
<!--     0.4            20-08-2013           Nithya             code modifed as per TO - 366250 
<!--     0.5            21-08-2013           Vijaya V        	Modification done for TO - 366250 
<!--	 0.6			28-08-2013			 Venki				Removed customisation done to add temp role
<!---------------------------------------------------------------------------------------------------------------->
<%@ page import="com.infy.bbu.jsputil.*"%>
<%@ page import="java.util.*"%>
<%@ page session="true"%>
<%@ page import="fabclasses.*,FabServer.*,com.infy.bbu.*,applcommon.*" %>
<%@ page import="com.infy.bbu.jsputil.*,FABProcess.*,FABCommon.*,FABInquiry.*,java.util.*, java.lang.*,finbranchUtil.*"%>
<% response.setHeader("Cache-Control","no-cache");%>
<% response.setHeader("Pragma","no-cache");%>
<% response.setDateHeader ("Expires", 0);%>
<%
SecurityInfo70 securityInfo = (SecurityInfo70)session.getAttribute("FinUserInfo");
%>
<SCRIPT language="javascript" src="../../javascripts/common_functions.js"></SCRIPT>
<SCRIPT language="javascript" src="../../javascripts/cust_post_evt.js"></SCRIPT>
<SCRIPT language="javascript" src="../../javascripts/cust_pre_evt.js"></SCRIPT>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js"></script>
<script language="javascript" src="../Renderer/custom/javascripts/hotkeyprocessor_link.js"></script>
<script type="text/javascript">

var objForm = "";
var obj= "";
objForm=document.forms[0];
function post_ONLOAD() 
{		
	var inputNameValues = "";
	var outputNames     = "status|expfld";
	var scrName         = "upmWorkclassvaldp001.scr";
	var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var ret = retVal.split("|");
	if(ret[0] == "Error") 
	{
		alert(ret[1]);
		return false;
	}
	if(ret[1] == "P" )
	{
		document.forms[0].roleId.disabled = true;
		document.forms[0].usrApplName.disabled = true;
		document.forms[0].workClass.disabled = true;
		document.forms[0].virtualFlg.disabled = true;
		document.forms[0].proxyPostFlg.disabled = true;
		document.getElementById('sLnk5').style.visibility = "hidden"
		document.getElementById('sLnk6').style.visibility = "hidden"
		document.getElementById('sLnk7').style.visibility = "hidden"
		document.getElementById('sLnk8').style.visibility = "hidden"
		document.getElementById('anc_rlid').style.visibility = "hidden"
		fnEnableDisableRadioButtons(document.getElementsByName("virtualFlg"),'D');
		fnEnableDisableRadioButtons(document.getElementsByName("proxyPostFlg"),'D');
	}

	if(ret[3] == "Y")
	{
		document.forms[0].tmpWCEffUpto_ui.disabled = true;
		document.getElementById('sLnk9').style.visibility = "hidden"	
	}
}
</script>


