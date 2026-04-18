<%@ page contentType="text/html; charset=utf-8" %>
<%!
	public static final String _ARJSP_JSP_NAME = "custom/jsp/cust_fetch.jsp";
%>
<%@ include file="../../finbranch_common.jsp" %>
<% 
           response.setHeader("Pragma","No-Cache"); 
           response.setDateHeader("Expires",0); 
           response.setHeader("Cache-Control","no-Cache,no-store"); 
%> 
<%-- PAGE LEVEL IMPORTS  --%>
<%@ page import="FABInquiry.*" %>
<%@ page import="fabclasses.*,com.infy.bbu.context.ContextAdapter" %>
<%@ page import="com.infy.COTP.*, com.infy.finbranch.groups.CustomizeBean" %>
<%@ page import="applcommon.*" %>
<arjsp:init groupName="arjspmorph" isEntryPoint="false" />
<% 
fabclasses.FinSessionInit.validateMorphReq(pageContext, ARJspCurr); 
%> 


<html>

<head>
<META HTTP-EQUIV="PRAGMA" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache,no-store"> 
<META HTTP-EQUIV="Expires" CONTENT="-1"> 
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
 <%@ include file="../../javascripts/coredomain.js" %>
<LINK href="../Renderer/stylesheets/services.css" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />
</head>

<%

	String          inputs  = ParseValue.checkString(request.getParameter("inputs"));
	String          scrName = ParseValue.checkString(request.getParameter("scrName"));
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
			sb.append(rec.value);
			
			if (iCount != outListSize)
				sb.append("\\|");
		}
	}
	
%>

<script language ="javascript">

if (window.showModalDialog)
{
	window.returnValue = '<%=sb%>';
}
 else{
	 var outData = "<%=sb%>"
	 parent.window.opener.CommonCallBack_SDS(outData);
 }
top.close();

</script>

</html>
