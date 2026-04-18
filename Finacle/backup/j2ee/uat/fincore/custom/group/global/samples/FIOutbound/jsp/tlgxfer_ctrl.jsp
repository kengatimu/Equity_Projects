<%@ page language="java" %>
	<%-- DEFAULT IMPORTS OF JSP SKEL GEN --%>
<%@ page import="com.infy.bbu.jsputil.*" %>
<%@ page import="com.infy.finbranch.groups.CustomizeBean" %>

<%@ page import="com.infy.finbranch.groups.*" %>

	<%-- CONTEXT BEAN  --%>
<%
	com.infy.finbranch.groups.finbranch_sessionBean finbranch;
	synchronized(session) {
		finbranch = (com.infy.finbranch.groups.finbranch_sessionBean) session.getAttribute("finbranch");
		if (finbranch == null) {
			finbranch = (com.infy.finbranch.groups.finbranch_sessionBean)CustomMapper.fetchClassInstance("com.infy.finbranch.groups.finbranch_sessionBean");
			session.setAttribute("finbranch", finbranch);
		}
	}

%>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
	<%-- APPLICATION LEVEL IMPORTS --%>
<%@ page import="fabclasses.*,FabServer.*,com.infy.bbu.*,applcommon.*" %>
	<%-- APP AND GROUP LEVEL BEANS  --%>
<%
	FabServer.FabService FabService;
	synchronized(session) {
		FabService = (FabServer.FabService) session.getAttribute("FabService");
		if (FabService == null) {
			FabService = (FabServer.FabService)CustomMapper.fetchClassInstance("FabServer.FabService");
			session.setAttribute("FabService", FabService);
		}
	}

	fabclasses.ServiceRoutines SrvcRoutines;
	synchronized(session) {
		SrvcRoutines = (fabclasses.ServiceRoutines) session.getAttribute("SrvcRoutines");
		if (SrvcRoutines == null) {
			SrvcRoutines = (fabclasses.ServiceRoutines)CustomMapper.fetchClassInstance("fabclasses.ServiceRoutines");
			session.setAttribute("SrvcRoutines", SrvcRoutines);
		}
	}

%>
	<%-- ERROR PAGE --%>
<%@ page errorPage="../arjspmorph/error_page.jsp" %>

<arjsp:init groupName="tlgxfer" isEntryPoint="true" />

<%  
	String sNextPage;
	CustomizeBean CustomizeBeanInst;
	
	if ( null == (CustomizeBeanInst = (CustomizeBean)ARJspCurr.getInput("CUSTOMIZATION_BEAN_INST", null)) ) {
		CustomizeBeanInst = (CustomizeBean)CustomMapper.fetchClassInstance("com.infy.finbranch.groups.CustomizeBean");
		ARJspCurr.setInput("CUSTOMIZATION_BEAN_INST", CustomizeBeanInst);

		CustomizeBeanInst.Refresh(pageContext, ARJspCurr, ARJspRet);
		CustomizeBeanInst.populateFields(finbranch, PropertyManager.getProperties(),ResourceManager.getResourceBundle(pageContext, "finbranch"));
	}
	else {
		CustomizeBeanInst.Refresh(pageContext, ARJspCurr, ARJspRet);
	}
	
	sNextPage = CustomizeBeanInst.procRequest();

%>

<jsp:forward page="<%=sNextPage %>" />

