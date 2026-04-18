<%
/*-----------------------------------------------------------------------------------------
	NAME			: denomdp007.jsp
	Calling Jsp		: denommn001.jsp
	Called JSP		: None
	Called Script	: denomdp001.scr
	Description		: This JSP receives denomination details from user and submits it to
						backend for performing Modify Operation.
	Menu Option  	: HCASHDEP,HTM,HCASHWD,HDDMI,HDDII,HCASHX,HCASHDX
	Author			: Castro
	Module Code		: DENOM
	Modification History:
	====================
	Srl No.	DATE	Author	Description
	1	28 Jun 2008	Castro	Function loadTI for storing field objects in order is used and array stored.
							This is done for enabling arrow keys navigation on the denomination screen.
------------------------------------------------------------------------------------------*/
%>

<%@ page import="java.util.*"%>
<! DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" autoFlush="true" session="true" %>

<%--
/*******************************************************************/
/*** Customization Include for DENOM module
/*** Should be included at the top of any DENOM module file
/*******************************************************************/
--%> 
<%-- SETTING RESPONSE HEADER --%>
<%
	response.setHeader("Pragma","No-Cache");
	response.setDateHeader("Expires",0);
	response.setHeader("Cache-Control","no-Cache");
%>
<%@ page language="java" %>
<%@ page import="java.util.TreeMap,java.util.Collection,java.util.Enumeration,java.util.SortedMap,com.infy.bbu.jsputil.*"%>
<%@ page contentType="text/html; charset=utf-8" %>

<%@ page import="java.util.*" %>

<%-- Setting the charset in request and response --%>
<% 
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8"); 
%>
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
	String sBaseHref = (String)pageContext.getAttribute("_ARJspApplicationBaseHref_", PageContext.SESSION_SCOPE);
	String appContextPath = request.getContextPath();
	String sProfileId = ProfilesManager.getProfileInSession(session);
%>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<%@ page errorPage="../../arjspmorph/error_page.jsp" %>

<% if (null != sBaseHref) { %>
  <base href="<%=sBaseHref + appContextPath + "/custom/jsp"%>">
<% } %>

<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("finbranchResource_"+LocaleMapper.getLangCode(pageContext)+".js",sProfileId) %>" > </script>

<arjsp:init groupName="arjspmorph" isEntryPoint="false" />
<jsp:useBean id="customBeanInst" class="com.infy.finbranch.groups.customBean" scope="session" />
<%
        fabclasses.FinSessionInit sessInit;
        synchronized(session) {
                sessInit = (fabclasses.FinSessionInit) session.getAttribute("FinSessionInit");
                if (sessInit == null) {
                        sessInit = (fabclasses.FinSessionInit)CustomMapper.fetchClassInstance("fabclasses.FinSessionInit");
                        session.setAttribute("FinSessionInit", sessInit);
                }
        }
        String outErrorPage[] = new String[1];
        boolean isInitSuccessful = true;

        if(sessInit.InitializeSession(pageContext, ARJspCurr, outErrorPage) != 0)
        {
                String sNextPage = outErrorPage[0] != null ? outErrorPage[0] : "../arjspmorph/error_page.jsp";
                isInitSuccessful = false;
        }

	if (isInitSuccessful) {
		customBeanInst.Refresh(pageContext, ARJspCurr, ARJspRet);
		customBeanInst.populateFields(finbranch, PropertyManager.getProperties(session), ResourceManager.getResourceBundle(pageContext, "finbranch"));
		//Initialising the ContextManager for ARJspCurr repository
		//ContextManager custARJspCurr = (ContextManager) session.getAttribute("CustomARJspCurr");
	}
	String sGrpName = ((String)session.getAttribute("groupName")!=null)?(String)session.getAttribute("groupName"):"tm";
%>
<custom:getRepository/>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("common_functions.js",sProfileId)%>" > </script>


<%!
	public String arrayToString(Object[] stringarray){
		String str = "";
		for (int i = 0; i < stringarray.length; i++) {
			if(stringarray[i]==null) stringarray[i]="0";
			str = str + stringarray[i] + "!";
		}
		return str.substring(0,str.length()-1);
	}
%>
<%!
	public int indexOfArr(String[] Arr,String sElement)
	{
		int l = Arr.length;
		for( int i = 0; i < l; i++ )	{
			if( Arr[i].equals(sElement) )
				 return i;
		}
		return -1;
	}
%>
<%
	//From ArjspCurr - set in denomdp008.jsp
	String[] sArrPTranTypes		= null;
	String[] sArrPTranAmts		= null;
	String[] sArrCrncyDtls		= null;

	String[] sArrUniqCrncys		= null;
	String[] sArrNoteDenomVal	= null;
	String[] sArrCoinDenomVal	= null;
	String[] sArrNoteDenomCnt	= null;
	String[] sArrCoinDenomCnt	= null;
	//-----------------------------------
	String sCurrency="",sPageName="",sPartTranType="",sPartTranAmt="";
	String[] sCrncyDtls = null,sArrPageCrncyInd=null,sArrAcctId=null;
	String sPageCrncyInd="",sTranType="",sAcctIds="",sAcctId="";
	int iCurrCrncyInd=0,sPayBackLen=0,sGetBackLen=0;
	String sNextPageName="",sCrncyName="",sMessage="",sDetails="";
	String[] sNoteValueArray = null,sCoinValueArray = null;	//Denomination values as stored in C_DENM
	String[] sNoteCountArray = null,sCoinCountArray = null;	//Available values in the till
	String sFieldValues="",sFieldValuesPB="",sFieldValuesGB="";
	String sTotDenomDtls= "";
	String sNoteCount	= "";	//will hv max Notedenomnation avl
	String sCoinCount	= "";	//will hv max Coindenomnation avl
	String sRecCount	= "";
	String sTotScreens	= "";
	String sNumOfDecPoints	= "";
	String sParamName="",sTempName="",sParamValue="";

	String sSuccessOrFailure= ((request.getParameter("SuccessOrFailure")!= null)?request.getParameter("SuccessOrFailure"):"");
	String sPrevPageName 	= ((request.getParameter("custom.PageName")!= null)?request.getParameter("custom.PageName"):"");
	String sCurrPageName 	= "";
	String sFunc = ((request.getParameter("Func")!= null)?request.getParameter("Func"):"");
	String sArrayPtr= (request.getParameter("arrayPtr")!=null)?request.getParameter("arrayPtr"):"0";
	String sDummy	= ((request.getParameter("sDummy")!= null)?request.getParameter("sDummy"):"");
	String sVstdFlg	= ((request.getParameter("vstdFlg")!= null)?request.getParameter("vstdFlg"):"E");
	String sPayBack	= ((request.getParameter("payBack")!= null)?request.getParameter("payBack"):"N");
	String sGetBack	= ((request.getParameter("getBack")!= null)?request.getParameter("getBack"):"N");
	String sAllDenomCntsCr = ((request.getParameter("allDenomCntsCr")!= null)?request.getParameter("allDenomCntsCr"):"0");
	String sAllDenomCntsDr = ((request.getParameter("allDenomCntsDr")!= null)?request.getParameter("allDenomCntsDr"):"0");
	String sBufValues	= ((request.getParameter("bufValues")!= null)?request.getParameter("bufValues"):"");
	String sRefFlg	= ((request.getParameter("refFlg")!= null)?request.getParameter("refFlg"):"N");
	String	sTAmt	=	 ((request.getParameter("tAmt")!= null)?request.getParameter("tAmt"):"0");
	String setVarFlg = "";

	int iArrayPtr 		= Integer.parseInt(sArrayPtr);
	int iPageCount		= Integer.parseInt(sArrayPtr);
	int NoteIndex=0,CoinIndex=0,NoteCount=0,CoinCount=0,NoteCoinCount=0,iRecCount=0,iTotScreens=0;

	TreeMap denomTM = new TreeMap();
	SortedMap subPbGbDenomTM;
	denomTM = (TreeMap)ARJspCurr.getInput("denomTM", new TreeMap());

	Object[] ValuesList		= new Object[0];
	Object[] ValuesListPB	= new Object[0];
	Object[] ValuesListGB	= new Object[0];
	String sVals		= "";
	String sValsPB		= "";
	String sValsGB		= "";
	String currPbGb		= "";
	String payBackAmt	= "0";
	String getBackAmt	= "0";
	if(!sDummy.equals(""))
	{
		Enumeration htmlParams = request.getParameterNames();
		while(htmlParams.hasMoreElements())
		{
			sParamName = (String)htmlParams.nextElement();
			if(sParamName.indexOf("denom.") != -1)
			{
				sTempName = sParamName.substring((sParamName.indexOf(".")+1),sParamName.length());
				sParamValue = request.getParameter(sParamName);
				denomTM.put(sTempName,sParamValue);
			}
			else if(sParamName.indexOf("custom.PageName") != -1)
			{
				sPrevPageName =	request.getParameter(sParamName);
			}
		}
		payBackAmt = ((request.getParameter("denom.PB"+sPrevPageName+"TotalDenomAmt")!= null)?request.getParameter("denom.PB"+sPrevPageName+"TotalDenomAmt"):"0");
		getBackAmt = ((request.getParameter("denom.GB"+sPrevPageName+"TotalDenomAmt")!= null)?request.getParameter("denom.GB"+sPrevPageName+"TotalDenomAmt"):"0");
		if(payBackAmt.equals("0.00"))	{
			subPbGbDenomTM = denomTM.subMap("PB"+sPrevPageName+"CoinDenomCount0","PB"+sPrevPageName+"TotalDenomAmt" + "\0");
			subPbGbDenomTM.clear();
		}
		if(getBackAmt.equals("0.00"))	{
			subPbGbDenomTM = denomTM.subMap("GB"+sPrevPageName+"CoinDenomCount0","GB"+sPrevPageName+"TotalDenomAmt" + "\0");
			subPbGbDenomTM.clear();
		}
		//	Setting the TreeMap in ARJspCurr repository
		ARJspCurr.setInput("denomTM",denomTM);
	}
	sTranType		= (String)ARJspCurr.getInput(sGrpName+".TranType", "");
	sAcctIds		= (String)ARJspCurr.getInput(sGrpName+".AcctIds", null);
	sArrPageCrncyInd= (String[])ARJspCurr.getInput(sGrpName+".ArrPageCrncyInd", null);
	if(!sDummy.equals("Y"))
	{
		sMessage = ((request.getParameter("Message")!= null)?request.getParameter("Message"):"");
		sDetails = ((request.getParameter("Details")!= null)?request.getParameter("Details"):"");
		sNoteCount		= ((request.getParameter("NoteCount")!= null)?request.getParameter("NoteCount"):"");
		sCoinCount		= ((request.getParameter("CoinCount")!= null)?request.getParameter("CoinCount"):"");
		
		sRecCount		= (String)ARJspCurr.getInput(sGrpName+".RecCount", "1");
		sTotScreens		= (String)ARJspCurr.getInput(sGrpName+".TotScreens", "1");
		iRecCount 		= Integer.parseInt(sRecCount);
		iTotScreens 	= Integer.parseInt(sTotScreens);
		sArrPTranTypes	= (String[])ARJspCurr.getInput(sGrpName+".ArrPTranTypes", null);
		sArrPTranAmts	= (String[])ARJspCurr.getInput(sGrpName+".ArrPTranAmts", null);
		sArrCrncyDtls	= (String[])ARJspCurr.getInput(sGrpName+".ArrCrncyDtls", null);
		setVarFlg = (String)ARJspCurr.getInput(sGrpName+".setVarFlg","Y");

		sArrNoteDenomVal	= (String[])ARJspCurr.getInput(sGrpName+".ArrNoteDenomVal", null);
		sArrCoinDenomVal	= (String[])ARJspCurr.getInput(sGrpName+".ArrCoinDenomVal", null);
		if(sFunc.equals("A") || sFunc.equals("M"))
		{
			sArrNoteDenomCnt	= (String[])ARJspCurr.getInput(sGrpName+".ArrNoteDenomCnt", null);
			sArrCoinDenomCnt	= (String[])ARJspCurr.getInput(sGrpName+".ArrCoinDenomCnt", null);
			sArrUniqCrncys		= (String[])ARJspCurr.getInput(sGrpName+".ArrUniqCrncys", null);
		}
		sCrncyDtls		= sArrCrncyDtls[iArrayPtr].split("@");
		sCurrency		= sCrncyDtls[0];
		sCrncyName		= sCrncyDtls[1];
		sNumOfDecPoints	= sCrncyDtls[2];
		//Searching for the current page Crncy Code in sArrUniqCrncys using indexOf in array.js
		if((sFunc.equals("A") || sFunc.equals("M")) && !sTranType.equals("CCT"))
		{
			iCurrCrncyInd = indexOfArr(sArrUniqCrncys,sCurrency);
			if(iCurrCrncyInd < 0)	iCurrCrncyInd = iArrayPtr;
		}
		else
		{
			iCurrCrncyInd = iArrayPtr;
		}
		sPartTranAmt	= sArrPTranAmts[iArrayPtr];
		sPartTranType	= sArrPTranTypes[iArrayPtr];
		sPageCrncyInd	= sArrPageCrncyInd[iArrayPtr];
		if(sTranType.equals("CCT"))	{
			sArrAcctId	= sAcctIds.split("@");
			if(sArrAcctId.length > 1)
				sAcctId = sArrAcctId[iArrayPtr];
			else
				sAcctId = sAcctIds;
		}
		if(sFunc.equals("I"))
			sPartTranType	= sArrPTranTypes[iArrayPtr];
		if(sFunc.equals("M"))
		{
			if((iArrayPtr+1) > sArrUniqCrncys.length)
			{
				sNoteValueArray = sArrNoteDenomVal[iCurrCrncyInd].split("-");
				sCoinValueArray = sArrCoinDenomVal[iCurrCrncyInd].split("-");
			}
			else
			{
				sNoteValueArray = sArrNoteDenomVal[iArrayPtr].split("-");
				sCoinValueArray = sArrCoinDenomVal[iArrayPtr].split("-");
			}
		}
		if(sFunc.equals("A") || sFunc.equals("M"))
		{
			if((iArrayPtr+1) > sArrUniqCrncys.length)
			{
				sNoteCountArray = sArrNoteDenomCnt[iCurrCrncyInd].split("-");
				sCoinCountArray = sArrCoinDenomCnt[iCurrCrncyInd].split("-");
			}
			else
			{
				sNoteCountArray = sArrNoteDenomCnt[iArrayPtr].split("-");
				sCoinCountArray = sArrCoinDenomCnt[iArrayPtr].split("-");
			}
		}
		NoteCount = sNoteValueArray.length;
		CoinCount = sCoinValueArray.length;
		NoteCoinCount = NoteCount + CoinCount;
		if(sTranType.equals("CCT"))
			sCurrPageName = sPartTranType + sCurrency + sPageCrncyInd;
		else
			sCurrPageName = sPartTranType + sCurrency;
				
		// Submap for the denomination details to form Values List
		denomTM = (TreeMap)ARJspCurr.getInput("denomTM", new TreeMap());
		SortedMap subDenomTM = denomTM.subMap(sCurrPageName+"CoinDenomCount0",sCurrPageName+"TotalDenomAmt" + "\0");
		ValuesList = new Object[CoinCount+NoteCount+3];
		Collection e = subDenomTM.values();	//obtain an Iterator for Collection
		if(subDenomTM.size()>0)
		{
			ValuesList = e.toArray();
			sFieldValues = arrayToString(ValuesList);
		}
		// Submap for the Pay Back denomination details to form Values List
		denomTM = (TreeMap)ARJspCurr.getInput("denomTM", new TreeMap());
		subDenomTM = denomTM.subMap("PB"+sCurrPageName+"CoinDenomCount0","PB"+sCurrPageName+"TotalDenomAmt" + "\0");
		sPayBackLen = subDenomTM.size();
		
		ValuesListPB = new Object[CoinCount+NoteCount+1];
		e = subDenomTM.values();	//obtain an Iterator for Collection
		if(subDenomTM.size()>0)
		{
			ValuesListPB = e.toArray();
			
			sFieldValuesPB = arrayToString(ValuesListPB);
		}

		// Submap for the Get Back denomination details to form Values List
		denomTM = (TreeMap)ARJspCurr.getInput("denomTM", new TreeMap());
		subDenomTM = denomTM.subMap("GB"+sCurrPageName+"CoinDenomCount0","GB"+sCurrPageName+"TotalDenomAmt" + "\0");
		sGetBackLen = subDenomTM.size();

		ValuesListGB = new Object[CoinCount+NoteCount+1];
		e = subDenomTM.values();	//obtain an Iterator for Collection
		if(subDenomTM.size()>0)
		{
			ValuesListGB = e.toArray();
			sFieldValuesGB = arrayToString(ValuesListGB);
		}
	}
	if(sTranType.equals("CCT"))
		sCurrPageName = sPartTranType + sCurrency + sPageCrncyInd;
	else
		sCurrPageName = sPartTranType + sCurrency;
	if(sDummy.equals("Y"))
	{
		sRecCount		= (String)ARJspCurr.getInput(sGrpName+".RecCount", "1");
		sTotScreens		= (String)ARJspCurr.getInput(sGrpName+".TotScreens", "1");
		iRecCount		= Integer.parseInt(sRecCount);
		iTotScreens		= Integer.parseInt(sTotScreens);
		sArrPTranTypes		= (String[])ARJspCurr.getInput(sGrpName+".ArrPTranTypes", null);
		sArrCrncyDtls		= (String[])ARJspCurr.getInput(sGrpName+".ArrCrncyDtls", null);
		sArrNoteDenomVal	= (String[])ARJspCurr.getInput(sGrpName+".ArrNoteDenomVal", null);
		sArrCoinDenomVal	= (String[])ARJspCurr.getInput(sGrpName+".ArrCoinDenomVal", null);
		if(sFunc.equals("A") || sFunc.equals("M"))
		{
			sArrNoteDenomCnt	= (String[])ARJspCurr.getInput(sGrpName+".ArrNoteDenomCnt", null);
			sArrCoinDenomCnt	= (String[])ARJspCurr.getInput(sGrpName+".ArrCoinDenomCnt", null);
			sArrUniqCrncys		= (String[])ARJspCurr.getInput(sGrpName+".ArrUniqCrncys", null);
		}
		setVarFlg = (String)ARJspCurr.getInput(sGrpName+".setVarFlg","N");
		sCrncyDtls		= sArrCrncyDtls[iArrayPtr].split("@");
		sCurrency		= sCrncyDtls[0];
		if(sFunc.equals("A") || sFunc.equals("M"))	{
			iCurrCrncyInd = indexOfArr(sArrUniqCrncys,sCurrency);
			if(iCurrCrncyInd < 0)
				iCurrCrncyInd = iArrayPtr;
		}
		if(sFunc.equals("M"))
		{
			if((iArrayPtr+1) > sArrUniqCrncys.length)
			{
				sNoteValueArray = sArrNoteDenomVal[iCurrCrncyInd].split("-");
				sCoinValueArray = sArrCoinDenomVal[iCurrCrncyInd].split("-");
			}
			else
			{
				sNoteValueArray = sArrNoteDenomVal[iArrayPtr].split("-");
				sCoinValueArray = sArrCoinDenomVal[iArrayPtr].split("-");
			}
		}
		if(sFunc.equals("A") || sFunc.equals("M"))
		{
			if((iArrayPtr+1) > sArrUniqCrncys.length)
			{
				sNoteCountArray = sArrNoteDenomCnt[iCurrCrncyInd].split("-");
				sCoinCountArray = sArrCoinDenomCnt[iCurrCrncyInd].split("-");
			}
			else
			{
				sNoteCountArray = sArrNoteDenomCnt[iArrayPtr].split("-");
				sCoinCountArray = sArrCoinDenomCnt[iArrayPtr].split("-");
			}
		}
		NoteCount = sNoteValueArray.length;
		CoinCount = sCoinValueArray.length;

		//Getting the values from all currency TreeMaps and forming sTotDenomDtls string
		SortedMap subOutDenomTM;
		TreeMap TM = (TreeMap)ARJspCurr.getInput("denomTM", new TreeMap());

		//Setting the denom values from denomTM in sTotDenomDtls to be sent to the backend
		if(sFunc.equals("M"))
			sTotDenomDtls = sTotScreens;
		else
			sTotDenomDtls = sRecCount;
		for(int i=0; i<iTotScreens; i++)
		{
			sCrncyDtls	= sArrCrncyDtls[i].split("@");
			sCurrency	= sCrncyDtls[0];
			sPartTranType	= sArrPTranTypes[i];
			sArrAcctId	= sAcctIds.split("@");	
			if(sArrAcctId.length > 1)
				sAcctId	= sArrAcctId[i];
			else
				sAcctId	= sAcctIds;
			if(sTranType.equals("CCT"))	{
				sPageCrncyInd	= sArrPageCrncyInd[i];
				sPageName = sPartTranType + sCurrency + sPageCrncyInd;;
			}	else	{
				sPageName = sPartTranType + sCurrency;
			}
			denomTM = (TreeMap)ARJspCurr.getInput("denomTM", new TreeMap());
			subOutDenomTM = denomTM.subMap(sPageName+"CoinDenomCount0",sPageName+"RoundOffVal\0");
			Collection cValList = subOutDenomTM.values();
			Collection p = subOutDenomTM.values();
			if(subOutDenomTM.size()>0)
				ValuesList = cValList.toArray();
			else
				ValuesList = new Object[CoinCount+NoteCount+3];
			if((i+1) > sArrUniqCrncys.length)
			{
				sVals = sArrCoinDenomVal[iCurrCrncyInd] + "|" + sArrNoteDenomVal[iCurrCrncyInd] + "|" + arrayToString(ValuesList);
			}
			else
			{
				sVals = sArrCoinDenomVal[i] + "|" + sArrNoteDenomVal[i] + "|" + arrayToString(ValuesList);
			}
			//Getting the Pay Back and Get Back values form TreeMap
			subOutDenomTM = denomTM.subMap("PB"+sPageName+"CoinDenomCount0","PB"+sPageName+"TotalDenomAmt");
			cValList = subOutDenomTM.values();
			if(subOutDenomTM.size()>0)
			{
				ValuesList = cValList.toArray();
				sValsPB = arrayToString(ValuesList);
			}
			else
			{
				sValsPB = "";
			}
			subOutDenomTM = denomTM.subMap("GB"+sPageName+"CoinDenomCount0","GB"+sPageName+"TotalDenomAmt");
			cValList = subOutDenomTM.values();
			if(subOutDenomTM.size()>0)
			{
				ValuesList = cValList.toArray();
				sValsGB = arrayToString(ValuesList);
			}
			else
			{
				sValsGB = "";
			}
			sTotDenomDtls = sTotDenomDtls + "|" + sPartTranType + "-" + sAcctId + "|" + sCurrency + "|" + sVals + "|" + sValsPB + "|" + sValsGB;
		}
	}
%>
<script>
var MANTISSA_SEPARATOR = ',';
var DECIMAL_SEPARATOR = '.';
</script>
<HTML>
<HEAD>
<BASE TARGET="_self"> 
<script>
window.name	= "DenomPopup";
var literalContext = 'C';
var Dummy	= "<%=sDummy%>";
</script>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<LINK href="../Renderer/stylesheets/<%=VRPKeys.getFile("services.css",sProfileId)%>" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("array.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("denom_glink.js",sProfileId)%>" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>" > </script>


<script language="javascript">

var Func = "<%=sFunc%>";
var arrayPtr = parseInt("<%=sArrayPtr%>");
var recCount = parseInt("<%=sRecCount%>");
var totScreens = parseInt("<%=sTotScreens%>");
var NoteCount = parseInt("<%=NoteCount%>");
var CoinCount = parseInt("<%=CoinCount%>");
var NoteCoinCount = CoinCount + NoteCount;
var payBack = "<%=sPayBack%>";
var getBack = "<%=sGetBack%>";
var getBackLen = "<%=sGetBackLen%>";
var payBackLen = "<%=sPayBackLen%>";
var acctCrncyAmt = "<%=sPartTranAmt%>";
if (totScreens > recCount) recCount = totScreens;
var currency = "<%=sCurrency%>";
var partTranAmt = "<%=sPartTranAmt%>";
var numOfDecPoints = "<%=sNumOfDecPoints%>";
var PartTranType = "<%=sPartTranType%>";
var vstdFlg = "<%=sVstdFlg%>";
var refFlg = "<%=sRefFlg%>";
var tAmt = "<%=sTAmt%>";
var arrayTI = [];
if (vstdFlg == "E") {
    var arrVstdFlg = new Array();
    for (var cnt = 0; cnt < recCount; cnt++)
        arrVstdFlg[cnt] = "N";
} else
    arrVstdFlg = vstdFlg.split("@");
var allDenomCntsCr = [];
var allDenomCntsDr = [];
var currDenomCntsCr = [];
var currDenomCntsDr = [];
var currDenomCnts = [];
var sAllDenomCntsCr = "";
var sCurrDenomCntsCr = "";
var sAllDenomCntsDr = "";
var tmpNoteCnt = 0;
var tmpNoteCntPB = 0;
var tmpNoteCntGB = 0;

sAllDenomCntsCr = "<%=sAllDenomCntsCr%>";
sAllDenomCntsDr = "<%=sAllDenomCntsDr%>";
if (sAllDenomCntsCr == "0") {
    allDenomCntsCr = new Array(NoteCoinCount);
    allDenomCntsDr = new Array(NoteCoinCount);
    for (var i = 0; i < NoteCoinCount; i++) {
        allDenomCntsCr[i] = 0;
        allDenomCntsDr[i] = 0;
    }
} else {
    allDenomCntsCr = sAllDenomCntsCr.split("!");
    allDenomCntsDr = sAllDenomCntsDr.split("!");
}

for (var i = 0; i < NoteCoinCount; i++) {
    currDenomCntsCr[i] = 0;
    currDenomCntsDr[i] = 0;
}

function fnPageLoad() {
    // loadTI - to form an array with the text field objects in order of the TABINDEX values set
    if (Func == "A" || Func == "M" || Func == "C") {
        loadTI(arrayTI);
        if (arrayTI[1] != undefined && arrayTI[1].type == "text") arrayTI[1].select();
    }
    window.name = "DenomPopup";
    var Dummy = "<%=sDummy%>";
    var arrayPtr = "<%=sArrayPtr%>";
    if (Dummy != "Y") {
        fnSetRoundOffTot();
        var rType = document.forms[0].RoundOffTyp.value;
        (rType == "C") ? fnSetRoundOffPType(0): fnSetRoundOffPType(1);
        if (arrayPtr == 0)
            hideImage("sPrev");
        if (arrayPtr == (recCount - 1))
            hideImage("sNext");
    }

    if (Dummy != "Y")
        var ValuesList = fieldValues.split("!");
    if (Dummy == "Y") {
        window.returnValue = "<%=sTotDenomDtls%>";
        window.close();
        return true;
    }
    if (Func != "A" && Func != "M")
        fnFieldsReadOnly();
}

function fnPayBack() {
    var frm = document.forms[0];
    frm.target = "DenomPopup";
    acctCrncyAmt = removeCommas(frm.partTranAmt.value);
    frm.action = "jsp/denomdp007.jsp?sDummy=N&Func=<%=sFunc%>&arrayPtr=<%=sArrayPtr%>&getBack=<%=sGetBack%>&payBack=Y&vstdFlg=" + vstdFlg + "&tAmt=" + acctCrncyAmt + "&refFlg=" + refFlg;
    frm.submit();
}

function fnGetBack() {
    var frm = document.forms[0];
    frm.target = "DenomPopup";
    acctCrncyAmt = removeCommas(frm.partTranAmt.value);
    frm.action = "jsp/denomdp007.jsp?sDummy=N&Func=<%=sFunc%>&arrayPtr=<%=sArrayPtr%>&getBack=Y&payBack=<%=sPayBack%>&vstdFlg=" + vstdFlg + "&tAmt=" + acctCrncyAmt + "&refFlg=" + refFlg;
    frm.submit();
}
</script>

<TITLE>Currency Denomination Maintenance</TITLE>
</HEAD>
<BODY class="cbody" onload="fnPageLoad()" onKeyDown="fnKeyDown(event)" onKeyUp="fnKeyUp(event)">
<FORM name="form1" method="post">

<%
if(!sDummy.equals("Y"))
{	%>
<script>
menuTitle			= "CURRENCY DENOMINATION MAINTENANCE";
var pageName		= "<%=sCurrPageName%>";
var TranType		= "<%=sTranType%>";
var bufValues		= "<%=sBufValues%>";
var fieldValues		= "<%=sFieldValues%>";
var fieldValuesPB	= "<%=sFieldValuesPB%>";
var fieldValuesGB	= "<%=sFieldValuesGB%>";
var CurrCrncyInd	= "<%=iCurrCrncyInd%>";
var CurrCrncyInd	= "<%=iCurrCrncyInd%>";
var isPbGb			= "<%=currPbGb%>";
var Func			= "<%=sFunc%>";
var NoteCount		= parseInt("<%=NoteCount%>");
var CoinCount		= parseInt("<%=CoinCount%>");
var lenNoteValArr	= "<%=sNoteValueArray.length%>";
var lenCoinValArr	= "<%=sCoinValueArray.length%>";
var setVarFlg           = "<%=setVarFlg%>";

<%	if(sFunc.equals("M"))
	{
		if((iArrayPtr+1) > sArrUniqCrncys.length)
		{	%>
			var CurrNoteValues	= "<%=sArrNoteDenomVal[iCurrCrncyInd]%>".split("-");
			var CurrCoinValues	= "<%=sArrCoinDenomVal[iCurrCrncyInd]%>".split("-");
<%		}
		else
		{	%>
			var CurrNoteValues	= "<%=sArrNoteDenomVal[iArrayPtr]%>".split("-");
			var CurrCoinValues	= "<%=sArrCoinDenomVal[iArrayPtr]%>".split("-");
<%		}
	}
%>

<%	if(sFunc.equals("M"))
	{
		if((iArrayPtr+1) > sArrUniqCrncys.length)
		{	%>
			var CurrNoteCounts = "<%=sArrNoteDenomCnt[iCurrCrncyInd]%>".split("-");
			var CurrCoinCounts = "<%=sArrCoinDenomCnt[iCurrCrncyInd]%>".split("-");
<%		}
		else
		{	%>
			var CurrNoteCounts = "<%=sArrNoteDenomCnt[iArrayPtr]%>".split("-");
			var CurrCoinCounts = "<%=sArrCoinDenomCnt[iArrayPtr]%>".split("-");
<%		}
	}
%>

printFunctionBlock();
var ValuesList = fieldValues.split("!");
printDenomBlock(pageName,fieldValues,'Denomination Details','');
if(Func != "A")	fnCalcTotalAmount('');
if(refFlg == "DX" && Func=="M"){
	var frm =document.forms[0];
	if(tAmt==0){ 
		frm.partTranAmt.value = frm.TotalDenomAmt.value;
		acctCrncyAmt = 	removeCommas(frm.partTranAmt.value);
	}
	else
	{
		frm.partTranAmt.value = tAmt;
		acctCrncyAmt = tAmt;
	}
}
printRoundOffBlock(pageName);

if((payBack == "Y" || payBackLen > 0) && TranType!="CCT")
{
	payBack = "Y";
	printDenomBlock(('PB'+pageName),fieldValuesPB,'Pay Back Details','PB');
	if(Func != "A")	fnCalcTotalAmount('PB');
}
if((getBack == "Y" || getBackLen > 0) && TranType!="CCT")
{
	getBack = "Y";
	printDenomBlock(('GB'+pageName),fieldValuesGB,'Get Back Details','GB');
	if(Func != "A")	fnCalcTotalAmount('GB');
}

printButtonBlock();

if(Func == "I")
{
	TotAmt	= parseFloat(document.forms[0].TotalDenomAmt.value);
	if(PartTranType=="D")
		TotAmt = -parseFloat(TotAmt);
	else
		TotAmt = parseFloat(TotAmt);
	var objPBAmt	= document.getElementById("PBTotalDenomAmt");
	var objGBAmt	= document.getElementById("GBTotalDenomAmt");
	if(objPBAmt!=undefined)	{
		payBackAmt = -parseFloat(objPBAmt.value);
		TotAmt = TotAmt + payBackAmt;
	}
	if(objGBAmt!=undefined)	{
		getBackAmt = parseFloat(objGBAmt.value);
		TotAmt =TotAmt + getBackAmt;
	}
	document.forms[0].partTranAmt.value = Math.abs(TotAmt);
}
</script>
<%
}	%>

<!-- *********************** Hidden Fields ******************** -->
<INPUT type="Hidden" name="submitform" value="Submit">
<INPUT type="Hidden" name="pagename" value="jsp/denomdp007.jsp">
<INPUT type="Hidden" id="SuccessOrFailure" name="custom.SuccessOrFailure" value="<%=sSuccessOrFailure%>">
<INPUT type="hidden" id="sPageName" name="custom.PageName" value="<%=sPartTranType + sCurrency%>">
<INPUT type="hidden" id="allDenomCntsCr" name="custom.allDenomCntsCr" value="<%=sAllDenomCntsCr%>">
<INPUT type="hidden" id="allDenomCntsDr" name="custom.allDenomCntsDr" value="<%=sAllDenomCntsDr%>">

<script>

<%
if(!sDummy.equals("Y"))
{	%>
	if(TranType == "CCT")
		fnCalcCCTchk('ONLOAD');
<%
}	%>
arrVstdFlg[arrayPtr] = "Y";
vstdFlg = arrVstdFlg.join("@");

</script>
</FORM>
</HTML>

