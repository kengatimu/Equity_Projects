<%@ page contentType="text/html; charset=utf-8" %>

<%!
	public static final String _ARJSP_JSP_NAME = "custom/jsp/cust_fetch_fi.jsp";
%>
<%@ include file="../../finbranch_common.jsp" %>





	<%-- PAGE LEVEL IMPORTS  --%>
<%@ page import="FABInquiry.*" %>
<%@ page import="com.infy.COTP.*, com.infy.finbranch.groups.CustomizeBean,java.util.LinkedHashMap" %>
<%@ page import="com.infy.bbu.ons.util.*" %>

<%@ taglib uri="taglib.tld" prefix="arjsp" %>

<arjsp:init groupName="arjspmorph" isEntryPoint="false" />
<%
         String sProfileId   = ProfilesManager.getProfileInSession(session);
%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">

<LINK href="../../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />

</head>

<%
	CustomizeBean CustomizeBeanInst;
	if ( null == (CustomizeBeanInst = (CustomizeBean)ARJspCurr.getInput("CUSTOMIZE_BEAN_INST", null)) ) 
	{	
		CustomizeBeanInst = (CustomizeBean)FCCustomMapper.fetchClassInstance("com.infy.finbranch.groups.CustomizeBean");
		
		ARJspCurr.setInput("CUSTOMIZE_BEAN_INST", CustomizeBeanInst);			
	}
	
	String inputs	= request.getParameter("inputs");  
	String classname	= request.getParameter("classname");
	
	LinkList	errList	= new LinkList("FABInquiry.Err");
	HashMap hmInput= new LinkedHashMap();
	String varName="";
	String varValue="";
	String output="";
	
	if(inputs != null)
	{
		/*
			Inputs are expected to be passed as Name-Value pairs separated by pipe (|).
			This is because the back-end (app-server) will always get 
			the values by using names. Null Input values are also handled here...!
		*/

		int recCount = 0;
		String inputBuff[] = inputs.split("\\|");
		int paramsLen = inputBuff.length;

		for(int iCount=0; iCount<paramsLen; iCount++,recCount++)
		{

			varName  = inputBuff[iCount];
			iCount++;
			varValue = "";
			if (iCount < paramsLen && !("").equals(inputBuff[iCount]))
				varValue = inputBuff[iCount];


			hmInput.put(varName,varValue);
		}
	}
	
	

	output=CustomizeBeanInst.executeInterface(session,classname,hmInput,errList);
	

	
%>

<script language ="javascript">

window.returnValue = '<%=output%>';
top.close();

</script>

</html>
