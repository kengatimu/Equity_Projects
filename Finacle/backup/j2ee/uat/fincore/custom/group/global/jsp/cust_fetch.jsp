<%@ page contentType="text/html; charset=utf-8" %>
<%!
	public static final String _ARJSP_JSP_NAME = "custom/jsp/cust_fetch.jsp";
%>
<%@ include file="../../finbranch_common.jsp" %>
<%
    String sProfileId   = ProfilesManager.getProfileInSession(session);
%>

	<%-- PAGE LEVEL IMPORTS  --%>
<%@ page import="FABInquiry.*" %>
<%@ page import="fabclasses.*,com.infy.bbu.context.ContextAdapter" %>
<%@ page import="com.infy.COTP.*, com.infy.finbranch.groups.CustomizeBean" %>

<arjsp:init groupName="arjspmorph" isEntryPoint="false" />

<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<LINK href="../../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />
</head>

<%

	String 		inputs	= request.getParameter("inputs");  
	String 		scrName	= request.getParameter("scrName");
	LinkList 	inList 	= new LinkList("FABInquiry.CustomList");
	LinkList 	outList	= new LinkList("FABInquiry.CustomList");
	LinkList	errList	= new LinkList("FABInquiry.Err");

	if(inputs != null)
	{
		/*
			Inputs are expected to pass as Name-Value pairs separated by pipe (|).
			This is because the back-end (app-server) will always get 
			the values by using names. Null Input values are also handled here...!
		*/

		int recCount = 0;
		String inputBuff[] = inputs.split("\\|");
		int paramsLen = inputBuff.length;

		for(int iCount=0; iCount<paramsLen; iCount++,recCount++)
		{
			CustomList rec = new CustomList();
			rec.serialNo = String.valueOf(recCount);				
			rec.name  = inputBuff[iCount];
			iCount++;
			rec.value = "";
			if (iCount < paramsLen && !("").equals(inputBuff[iCount]))
				rec.value = inputBuff[iCount];
			inList.add(rec);
		}
	}

	ServiceRoutines srvcRoutines = (ServiceRoutines)session.getAttribute("SrvcRoutines");
	if (SrvcRoutines == null) {
		SrvcRoutines = (fabclasses.ServiceRoutines)CustomMapper.fetchClassInstance("fabclasses.ServiceRoutines");            
        	session.setAttribute("SrvcRoutines", SrvcRoutines);
	}
	srvcRoutines.init(new ContextAdapter(ARJspCurr));
	CustomizeBean.executeScript(session, scrName , inList, outList, errList);

	StringBuffer sb = new StringBuffer();
	if (errList.size() > 0)
	{
		/*
			Got Errors..!
			Return description of the errors separated by pipe(|).
			To identify the return value in the parent screen, the first value of the 
			return value is populated with "Err".
		*/
		
		int errSize = errList.size();
		sb.append("Err|");
		for (int iCount=0; iCount<errSize; iCount++)
		{
			Err rec = (Err)errList.elementAt(iCount);
			sb.append(rec.errDesc);
			
			if (iCount != errSize)
				sb.append("\\|");
		}
	}
	else 
	{
		int outListSize = outList.size();
		
		/*
			Return output values in the form of Name-Value Pair separated by pipe(|).
		*/
	
		for(int iCount=0; iCount<outListSize; iCount++) 
		{
			CustomList rec = (CustomList)outList.elementAt(iCount);
			sb.append(rec.name);
			sb.append("\\|");
			sb.append(ParseValue.checkString(rec.value));
			
			if (iCount != outListSize)
				sb.append("\\|");
		}
	}
	
%>

<script language ="javascript">

window.returnValue = '<%=sb%>';
top.close();

</script>

</html>
