<%@ page contentType="text/html; charset=utf-8" %>
<%!
	public static final String _ARJSP_JSP_NAME = "custom/jsp/cust_fetch_list.jsp";
%>
<%@ include file="../../finbranch_common.jsp" %>
<%
        response.setHeader("Pragma","No-Cache");
        response.setDateHeader("Expires",0);
        response.setHeader("Cache-Control","no-Cache");
%>
	<%-- PAGE LEVEL IMPORTS  --%>
<%@ page import="FABInquiry.*" %>
<%@ page import="fabclasses.*,com.infy.bbu.context.ContextAdapter,com.infy.bbu.jsputil.CustomMapper" %>
<%@ page import="com.infy.COTP.*, com.infy.finbranch.groups.CustomizeBean" %>
<%@ page import="com.infy.COTP.*, com.infy.finbranch.groups.customBean" %>

<arjsp:init groupName="arjspmorph" isEntryPoint="false" />

<%
	String pageTitle = request.getParameter("pageTitle");	
	String sBaseHref = (String)pageContext.getAttribute("_ARJspApplicationBaseHref_", PageContext.SESSION_SCOPE);
	String sProfileId   = ProfilesManager.getProfileInSession(session);
%>

<html>

<head>

<% if (null != sBaseHref) { %>
<base href="<%=sBaseHref+"/finbranch/custom/"%>">
<% } %>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><%=pageTitle%></title> 

<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("finbranchResource_"+LocaleMapper.getLangCode(pageContext)+".js",sProfileId) %>" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getFile("cust_fetch_list.js",sProfileId)%>"></script>
<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type="text/css" />

</head>

<%
	String 		inputs		= request.getParameter("inputs");
	String 		outputs		= request.getParameter("outputs");
	String 		scrName		= request.getParameter("scrName");
	String 		literalNames	= request.getParameter("literalNames");
	String 		hyperLnkCols	= request.getParameter("hyperLnkCols");

	LinkList 	inList 		= new LinkList("FABInquiry.CustomList");
	LinkList 	outList		= new LinkList("FABInquiry.CustomList");
	LinkList	errList		= new LinkList("FABInquiry.Err");
	
	String [] 	outputsBuff 	= null;
	int 		outputsBuffLen 	= 0;	
	int 		iTotRecs 	= 0;
	int 		errRecs 	= 0;
	boolean 	displayRecs 	= true;		
	int 		pageNumber	= 0;
	boolean 	isPageWiseListReq = false;	
	
	if(inputs != null)
	{
		/*
			inputs are expected to pass as Name-Value pairs separated by pipe (|).
			This is because the back-end (app-server) will always get 
			the values by using names.
		*/

		int recCount = 1;
		String inputBuff[] = inputs.split("\\|");
		int paramsLen = inputBuff.length;

		for(int iCount=0; iCount<paramsLen; iCount++,recCount++)
		{
			CustomList rec = new CustomList();
			rec.serialNo = String.valueOf(recCount);				
			rec.name  = inputBuff[iCount];
			// if the input parameters contains pageNumber then populate pageNumber variable
			if(rec.name.equals("pageNumber"))
			{
				// set the variable true to indicate page wise list is required
				isPageWiseListReq = true;
				pageNumber = Integer.parseInt(inputBuff[iCount + 1]);
			}
			iCount++;
			rec.value = "";
			if (iCount < paramsLen && !("").equals(inputBuff[iCount]))
				rec.value = inputBuff[iCount];
			inList.add(rec);
		}
	}
	ServiceRoutines srvcRoutines = (ServiceRoutines)session.getAttribute("SrvcRoutines");
    if (null == srvcRoutines) {
        srvcRoutines = (fabclasses.ServiceRoutines)CustomMapper.fetchClassInstance("fabclasses.ServiceRoutines");
        session.setAttribute("SrvcRoutines", srvcRoutines);
    }
	srvcRoutines.init(new ContextAdapter(ARJspCurr));
	CustomizeBean.executeScript(session, scrName , inList, outList, errList);

	errRecs	= errList.size();
	if (errRecs > 0)
	{
		displayRecs = false;
	}
	else if (outList.size() > 0)
	{
		/*
			The first record in the outList will indicate the total number of records 
			fetched.
		*/

		CustomList rec = (CustomList)outList.elementAt(0);
		iTotRecs = Integer.parseInt(rec.value);
		
		outputsBuff 	= outputs.split("\\|");
		outputsBuffLen 	= outputsBuff.length;	
	}
%>

<script langauge="javascript">

	var isPageWiseListReq   = '<%=isPageWiseListReq%>';
	var pageNumber		= <%=pageNumber%>;
	var totRecs 		= <%=iTotRecs%>;
	var colsLen 		= <%=outputsBuffLen%>;
	var literalsBuff 	= '<%=literalNames%>'.split("|");
	var hyperLnksBuff 	= '<%=hyperLnkCols%>'.split("|");
	var hyperLnksLen 	= hyperLnksBuff.length;
	var pageTitle 		= '<%=pageTitle%>';
	var displayRecs 	= <%=displayRecs%>;
	
	var errCode 		= new Array(<%=errRecs%>);
	var errType 		= new Array(<%=errRecs%>);
	var errDesc 		= new Array(<%=errRecs%>);
<%
	for (int i=0; i<outputsBuffLen; i++)
	{
		/*
			Javascript Array definition for Columns are starting with 1.
		*/
%>
		var col<%=(i+1)%> = new Array(totRecs);
<%
	}

	/*
		Now, populate javascript arrays with fetched values.
	*/
	
	if (!displayRecs)
	{
		/*
			Got Errors...!
		*/
		
		int loop = 0;		
		java.util.Enumeration errEnum = errList.elements();
		while (errEnum.hasMoreElements())
		{
		    FABInquiry.Err err = (FABInquiry.Err)errEnum.nextElement();
%>
		    errCode[<%=loop%>] = '<%=err.errCode%>';
		    errType[<%=loop%>] = '<%=err.type%>';
		    errDesc[<%=loop%>] = '<%=err.errDesc%>';
<%
		    loop++;
		}
        }		
        else if (iTotRecs > 0)
	{
		for(int i=0; i<iTotRecs; i++)
		{
			/*
				The number of records to be displayed will start withh (i+1),
				because the first record will contain the count of total number of
				records fetched after excuting the script.
			*/
			
			String colNames[] = new String[outputsBuffLen];
			for (int j=0; j<outputsBuffLen; j++)
			{
				colNames[j] = outputsBuff[j] + "_" + (i+1);
			}

			String colValues[] = customBean.getRecordFromList(outList,colNames);

			for (int k=0; k<outputsBuffLen; k++)
			{
%>
				col<%=(k+1)%>[<%=i%>] = escape('<%=ParseValue.checkString(colValues[k])%>');
<%
			}
		}
	}
%>

</script>

<body class="cbody">
<form name="customlist" class="cform" action = "../custom/jsp/cust_fetch_list.jsp" method="post">
	
	<input type ="hidden" name="inputs" value="<%=inputs%>" >
	<input type ="hidden" name="outputs" value="<%=outputs%>" >
	<input type ="hidden" name="scrName" value="<%=scrName%>" >
	<input type ="hidden" name="literalNames" value="<%=literalNames%>" >
	<input type ="hidden" name="hyperLnkCols" value="<%=hyperLnkCols%>" >
	<input type ="hidden" name="pageTitle" value="<%=pageTitle%>" >
	
<script language="JavaScript">
	window.name = "listWindow";
	printHTML();
</script>

</form>
</body>

</html>
