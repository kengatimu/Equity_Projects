<%
/*-----------------------------------------------------------------------------------------
	NAME			: denomdp008.jsp
	Calling Js		: cust_denom_functions.js
	Called JSP		: None
	Called Script	: denomdp006.scr
	Module Code		: DENOM
	Date			: 24 Nov 2008
	Description		: This JSP retrieves denomination details from back end and sets in ARJspCurr.
	Input			: groupName - set in session repository, Currency code
	Output			: (Arrays) - groupName.ArrCrncy, groupName.ArrCrncyName, groupName.ArrNoDecPts
	Menu Option		: HCASHDEP,HCASWD,HTM,HCASHX,HDDMI(Add, Inquire mode only)
	Author			: Castro
	Modification History:	
	====================
	Serial No.	DATE		Author			Description
------------------------------------------------------------------------------------------*/
%>
<! DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" autoFlush="true" session="true"%>
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
	System.out.println("sProf008");
	System.out.println(sProfileId);
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
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("resource_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("common_functions.js",sProfileId)%>"> </script>

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
	String sRecCount = "";
	int iRecCount = 0;
	String sParam[] = new String[10];
	String sValues[] = new String[10];
	String sMessage="",sDetails="",sCrncy = "";
	String[] sTranValues=null,sRecTranValues=null,sPTTypes=null,sPTAmounts=null,sPageCrncyInd=null;

	String sDummy		= (request.getParameter("Dummy")!=null)?request.getParameter("Dummy"):"N";
	String sFunc		= (request.getParameter("Func")!=null)?request.getParameter("Func"):"";
	String sReferralFlg	= (request.getParameter("referralFlg")!=null)?request.getParameter("referralFlg"):"N";
	String sTranDtls	= (request.getParameter("TranDtls")!=null)?request.getParameter("TranDtls"):"";
	String sUniqCrncys	= (request.getParameter("uniqCrncys")!=null)?request.getParameter("uniqCrncys"):"";
	String sTranType	= (request.getParameter("tranType")!= null)?request.getParameter("tranType"):"";
	String sAcctIds		= (request.getParameter("acctIds")!= null)?request.getParameter("acctIds"):"";
	String sPbGb		= (request.getParameter("PbGb")!= null)?request.getParameter("PbGb"):"";
	String sTotPTranTypes= (request.getParameter("TotPTranTypes")!= null)?request.getParameter("TotPTranTypes"):"";
	String[] sArrUniqCrncys	= sUniqCrncys.split("!");

	sTranValues		= sTranDtls.split("!");
	sPTTypes		= new String[sTranValues.length];
	sPTAmounts		= new String[sTranValues.length];
	sPageCrncyInd	= new String[sTranValues.length];
	for(int i=0; i<sTranValues.length; i++)
	{
		sRecTranValues	= sTranValues[i].split("~");
		sPTTypes[i]	= sRecTranValues[0];
		sPTAmounts[i]	= sRecTranValues[2];
		if(sTranType.equals("CCT"))
			sPageCrncyInd[i] = sRecTranValues[3];
	}
	ARJspCurr.setInput(sGrpName+".ArrPTranTypes",sPTTypes);
	ARJspCurr.setInput(sGrpName+".ArrPTranAmts",sPTAmounts);
	ARJspCurr.setInput(sGrpName+".ArrPageCrncyInd",sPageCrncyInd);

	if(!sDummy.equals("Y"))
	{
		ARJspCurr.setInput(sGrpName+".AcctIds",	sAcctIds);
		ARJspCurr.setInput(sGrpName+".PbGb",	sPbGb	);
	}
	if(sDummy.equals("Y"))
	{
		String sAppNextPage = customBeanInst.getNextPage();
		sRecCount = (request.getParameter("custom.RecCount")!=null)?request.getParameter("custom.RecCount"):"1";
		iRecCount = Integer.parseInt(sRecCount);
		sParam[0]	= "Message";
		sParam[1]	= "Details";
		sValues		= customBeanInst.getCustOutData(sParam);
		sMessage	= sValues[0];
		sDetails	= sValues[1];
		if(sMessage.equals("Y"))
		{
			String sParamCrncy[]		= new String[iRecCount+1];
			String sParamCrncyDtls[]	= new String[iRecCount+1];
			String sParamNoteDenomVal[]	= new String[iRecCount+1];
			String sParamCoinDenomVal[]	= new String[iRecCount+1];
			String sParamNoteDenomCnt[]	= new String[iRecCount+1];
			String sParamCoinDenomCnt[]	= new String[iRecCount+1];
			String sValuesCrncy[]		= new String[iRecCount+1];
			String sValuesCrncyDtls[]	= new String[iRecCount+1];
			String sValuesNoteDenomVal[]= new String[iRecCount+1];
			String sValuesCoinDenomVal[]= new String[iRecCount+1];
			String sValuesNoteDenomCnt[]= new String[iRecCount+1];
			String sValuesCoinDenomCnt[]= new String[iRecCount+1];
			String sArrCrncyValues[]	= new String[iRecCount+1];
			String setVarFlg[] 			= new String[iRecCount+1];
			for(int i=0, j=0; i<=iRecCount; i++)
			{
				sParamCrncy[i]			= "Crncy"			+ i;
				sParamCrncyDtls[i]		= "CrncyDtls"		+ i;
				sParamNoteDenomVal[i]	= "NoteDenomVal"	+ i;
				sParamCoinDenomVal[i]	= "CoinDenomVal"	+ i;
				sParamNoteDenomCnt[i]	= "NoteDenomCnt"	+ i;
				sParamCoinDenomCnt[i]	= "CoinDenomCnt"	+ i;
			}
			setVarFlg[0] = "setVarFlg";
			sValuesCrncy		= customBeanInst.getCustOutData(sParamCrncy);
			sValuesCrncyDtls	= customBeanInst.getCustOutData(sParamCrncyDtls);
			sValuesNoteDenomVal	= customBeanInst.getCustOutData(sParamNoteDenomVal);
			sValuesCoinDenomVal	= customBeanInst.getCustOutData(sParamCoinDenomVal);
			sValuesNoteDenomCnt	= customBeanInst.getCustOutData(sParamNoteDenomCnt);
			sValuesCoinDenomCnt	= customBeanInst.getCustOutData(sParamCoinDenomCnt);
			setVarFlg 			= customBeanInst.getCustOutData(setVarFlg);
			
			//forming the ArrCrncyDtls which is of the same size as the no of pageNames.
			int iArrIndex = 0;
			for(int i=0; i<sTranValues.length; i++)
			{
				sRecTranValues		= sTranValues[i].split("~");
				sCrncy				= sRecTranValues[1];
				iArrIndex			= indexOfArr(sValuesCrncy,sCrncy);
				sArrCrncyValues[i] 	=  sValuesCrncy[iArrIndex] + "@" + sValuesCrncyDtls[iArrIndex];
			}
			//Setting the Note/Coin Denom count and till available details in ARJspCurr repository
			ARJspCurr.setInput(sGrpName+".ArrCrncyDtls",	sArrCrncyValues	);
			ARJspCurr.setInput(sGrpName+".ArrUniqCrncys",	sArrUniqCrncys);
			ARJspCurr.setInput(sGrpName+".ArrNoteDenomVal",	sValuesNoteDenomVal	);
			ARJspCurr.setInput(sGrpName+".ArrCoinDenomVal",	sValuesCoinDenomVal	);
			ARJspCurr.setInput(sGrpName+".ArrNoteDenomCnt",	sValuesNoteDenomCnt	);
			ARJspCurr.setInput(sGrpName+".ArrCoinDenomCnt",	sValuesCoinDenomCnt	);
			ARJspCurr.setInput(sGrpName+".TranType",	sTranType	);
			ARJspCurr.setInput(sGrpName+".RecCount",		sRecCount );
		 	ARJspCurr.setInput(sGrpName+".setVarFlg", setVarFlg[0]);

			//	------------------------------------------
			String[] sArrCrncyDtls		= (String[])ARJspCurr.getInput(sGrpName+".ArrCrncyDtls", null);
		}
	}
%>
<HTML>
<SCRIPT>
var TranType = "<%=sTranType%>";
function fnPageLoad()
{
	var Dummy	= "<%=sDummy%>";
	window.name	= "DenomPopup";
	if(Dummy!="Y")
	{
		document.forms[0].target="DenomPopup";
		document.forms[0].action="jsp/denomdp008.jsp?Dummy=Y&TranDtls=<%=sTranDtls%>&uniqCrncys=<%=sUniqCrncys%>&tranType=<%=sTranType%>";
		//document.forms[0].action="../jsp/denomdp008.jsp?Dummy=Y&TranDtls=<%=sTranDtls%>&uniqCrncys=<%=sUniqCrncys%>&tranType=<%=sTranType%>";
		//document.forms[0].action="/pamodule1/wasprofile/EQBK10X1WAS/installedApps/celleqbk10x1/finbranch_war.ear/finbranch.war/custom/jsp/denomdp008.jsp?Dummy=Y&TranDtls=<%=sTranDtls%>&uniqCrncys=<%=sUniqCrncys%>&tranType=<%=sTranType%>";
		document.forms[0].submit();
	}
	else
	{
		var mess="<%=sMessage%>";
		if(mess=="N"||mess=="F")
		{
			window.returnValue = "<%=sMessage%>|<%=sDetails%>";
			window.close();
		}
		else
		{
			window.returnValue = "true";
			window.close();
		}
	}
}

function fnWriteFields()
{
	var TranDtls		= "<%=sTranDtls%>";
	var TranValues		= TranDtls.split("!");
	var TranValuesCnt	= TranValues.length;
	var uniqCrncys		= "<%=sUniqCrncys%>";
	var AcctIds 		= [];
	var crncyValues		= uniqCrncys.split("!");
	var crncyCnt		= crncyValues.length;
	var writeAcctIds	= "Y";
	var pTranTypeStr	= "<%=sTotPTranTypes%>";
	var pTranType		= pTranTypeStr.split("@");
	var ptranLen		= pTranType.length;
	if(TranType=="CNP"||TranType=="CNR"||TranType=="CPI"||TranType=="CRI")
		writeAcctIds = "N";
	if(crncyCnt == 1)	AcctIds[0] = "<%=sAcctIds%>";
	else			AcctIds	= "<%=sAcctIds%>".split("@");
	with (document) 
	{
		write('<input type="hidden" name="custom.RecCount" id="RecCount" value="'+TranValuesCnt+'">');
		write('<input type="hidden" name="custom.CrncyCount" id="CrncyCount" value="'+crncyCnt+'">');
		write('<input type="hidden" name="custom.TranType" id="TranType" value="'+TranType+'">');
		for (i=0;i<ptranLen; i++)
		{
			write('<input type="hidden" name="custom.pTranType' + i +'"  id="pTranType" value="'+pTranType[i]+'">');
		}
		for (var i=0; i<crncyCnt; i++)
		{
			write('<input type="hidden" name="custom.Crncy' + i +'" value="'+crncyValues[i]+'">');
			if(writeAcctIds=="Y")
			write('<input type="hidden" name="custom.AcctId' + i +'" value="'+AcctIds[i]+'">');
		}
	}
}

function fnSubmit()
{
	window.returnValue = "true";
	window.close();
}

</SCRIPT>

<BODY class="cbody" onLoad= "fnPageLoad()">
<FORM name="form1" method="post">
<%
	if(sDummy.equals("N"))
	{ %>
		<script language="javascript">
		fnWriteFields();
		</script>
	<%
	}
%>


<INPUT type="Hidden" name="submitform" value="Submit">
<INPUT type="Hidden" name="pagename" value="denomdp003.jsp">
<INPUT type="Hidden" name="scrName" value="denomdp006.scr" >
<INPUT type="Hidden" name="custom.Func" value="<%=sFunc%>">
<INPUT type="Hidden" name="custom.referralFlg" value="<%=sReferralFlg%>">

</FORM>
</BODY>
</HTML>

