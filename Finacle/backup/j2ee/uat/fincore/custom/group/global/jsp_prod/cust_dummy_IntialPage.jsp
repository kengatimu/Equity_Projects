<%@ page import="com.infy.finbranch.groups.CustomizeBean" %>
<%@ page import="applcommon.ParseValue" %>
<%@ page import="com.infy.bbu.jsputil.*"%>
<%@ page import="java.util.Vector"%>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="Customize" isEntryPoint="false" />
<arjsp:init groupName="arjspmorph" isEntryPoint="false" />

<%
	String sNextPage;
	String sGroupName = ARJspCurr.getCurrentGroup();
	
	CustomizeBean CustomizeBeanInst;
	CustomizeBeanInst = (CustomizeBean)ARJspCurr.getInput("CUSTOMIZATION_BEAN_INST", null);
	
	
	sNextPage = CustomizeBeanInst.getPageNameFromXML("DETAILS");	
	sNextPage = "../../"+sGroupName+"/"+sNextPage;
%>

<jsp:forward page="<%=sNextPage %>" />
