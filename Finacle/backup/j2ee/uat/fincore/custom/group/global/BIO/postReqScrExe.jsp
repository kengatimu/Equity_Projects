<%@ page import="applcommon.ParseValue" %>
<%@ page import="com.infy.bbu.jsputil.*"%>
<%@ page import="java.util.Vector"%>
<%@ page import="FABInquiry.*" %>
<%@ page import="fabclasses.*"%>
<%@ page import="com.infy.bbu.context.*" %>
<%@ page import="FABCommon.SecurityInfo70" %>
<%@ page import="com.infy.COTP.*, com.infy.finbranch.groups.CustomizeBean" %>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>

<% 
	response.setHeader("Pragma","No-Cache"); 
	response.setDateHeader("Expires",0); 
	response.setHeader("Cache-Control","no-Cache,no-store"); 
%> 
<%
	String sProfileId = ProfilesManager.getProfileInSession(session);
	SecurityInfo70  securityInfo = (SecurityInfo70)session.getAttribute("FinUserInfo");
	ServiceRoutines srvcRoutines = (ServiceRoutines)session.getAttribute("SrvcRoutines");
String v;
String v1;
if(request.getParameter("cif") == null)
		v1 = "NA";
	else
		v1 = request.getParameter("cif");	

	if(request.getParameter("sign") == null)
		v = "NA";
	else
		v = request.getParameter("sign");


	
	String 		inputNameValues	= "foracid|"+v+"|cifId|"+v1;
	String 		scrName	= "coreBioVerifyReq.scr";
	
	LinkList 	inList 	= new LinkList("FABInquiry.CustomList");
	LinkList 	outList	= new LinkList("FABInquiry.CustomList");
	LinkList	errList	= new LinkList("FABInquiry.Err");
	
	int recCount = 0;
	String inputBuff[] = inputNameValues.split("\\|");
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
	srvcRoutines.processCustomScr(securityInfo, scrName, inList, outList, errList);
	
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
			sb.append(ParseValue.checkString(rec.errDesc));
			
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
<%=sb%>
