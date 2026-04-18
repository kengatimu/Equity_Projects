<%
/*-----------------------------------------------------------------------------------------
	NAME			: denomdp003.jsp
	Calling file	: cust_denom_functions.js
	Called JSP		: None
	Called Script	: denomdp010.scr
	Description		: This JSP retrieves denomination details from back end and sets in ARJspCurr.
					  (For Inquiry,Modify,Delete,Post,Verify mode)
	Output			: (Arrays) - groupName.ArrCrncy, groupName.ArrCrncyName, groupName.ArrNoDecPts
	Menu Option		: HCASHDEP
	Author			: Castro
	Module Code		: DENOM
	Modification History:
	====================
	Serial No.	DATE		Author			Description
------------------------------------------------------------------------------------------*/
/*----------------
sArrNoteDenomVal - The denominations as maintained in HDENOM
sArrNoteDenomCnt - Max count of denominations available with the teller 
sDenomNoteCnt,sDenomNoteValArr    - The denom count for a transaction,array of the same
----------------*/
%>
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
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("resource_functions.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getFile("common_functions.js",sProfileId)%>"> </script>

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
	String sNextPage 	= "jsp/denomdp003.jsp";
	String sRecCount 	= "";
	String sParam[]		= new String[10];
	String sTmpParam[]	= new String[8];
	String sValues[]	= new String[10];
	String sTmpValues[]	= new String[8];
	String aCountNames[], aCountVals[];
	String sCrncyDtls = null,sCrncy = null;
	String sCounts = "",sTotCount = "",sVscrFlg = "",sPageName = "",sPtranTypes = "";
	String sPBCount = "",sGBCount = "",sMessage = "",sDetails = "",sCurrency = "";
	String sDenomNoteVal="",sDenomNoteCnt="",sDenomCoinVal="",sDenomCoinCnt="",sDenomNoteValGB="";
	String sDenomNoteCntGB="",sDenomCoinValGB="",sDenomCoinCntGB="",sDenomNoteValPB="",sDenomNoteCntPB="",sDenomCoinValPB="",sDenomCoinCntPB="";
	String sCountName="",sRoundOffVal="",sRoundOffTyp="";
	String[] sTranValues=null,sRecTranValues=null,sPTTypes=null,sPTAmounts=null,sArrUniqCrncys=null,sNArrCrncyDtls=null,sPageCrncyInd=null,sDenomNoteValArr=null;
	String[] sDenomTot=null,sDenomNoteCntArr=null,sDenomCoinValArr=null,sDenomCoinCntArr=null,sDenomNoteCntPBArr=null,sDenomCoinCntPBArr=null,sDenomNoteCntGBArr=null,sDenomCoinCntGBArr=null;
	int iRecCount=0,iTotScreens=0,iArrIndex=0,iTotCount=0,iTmpCnt=0,iTmp,iLen=0,iPBtotCnt=0,iGBtotCnt=0;
	String sUniqCrncys	= (request.getParameter("uniqCrncys")!=null)?request.getParameter("uniqCrncys"):"";
	String sFunc		= (request.getParameter("Func")!=null)?request.getParameter("Func"):"";
	String sTranId		= (request.getParameter("tranId")!=null)?request.getParameter("tranId"):"";
	String sTranDate	= (request.getParameter("tranDate")!=null)?request.getParameter("tranDate"):"";
	String sReferralFlg	= (request.getParameter("referralFlg")!=null)?request.getParameter("referralFlg"):"N";
	String sDummy		= (request.getParameter("Dummy")!=null)?request.getParameter("Dummy"):"N";
	String sTranDtls	= (request.getParameter("TranDtls")!=null)?request.getParameter("TranDtls"):"";
	String sTranType	= (request.getParameter("tranType")!= null)?request.getParameter("tranType"):"";
	String sAcctIds		= (request.getParameter("acctIds")!= null)?request.getParameter("acctIds"):"";
	System.out.println("sFunc");
	System.out.println(sFunc);

	if(sFunc.equals("M"))
	{
		sArrUniqCrncys	= sUniqCrncys.split("!");
		sTranValues		= sTranDtls.split("!");
		iTotScreens		= sTranValues.length;
		sPTTypes		= new String[sTranValues.length];
		sPTAmounts		= new String[sTranValues.length];
		sPageCrncyInd	= new String[sTranValues.length];
		for(int i=0; i<sTranValues.length; i++)
		{
			sRecTranValues	= sTranValues[i].split("~");
			sPTTypes[i]	= sRecTranValues[0];
			sPTAmounts[i]	= sRecTranValues[2];
			if(sTranType.equals("CCT"))
				sPageCrncyInd[i]	= sRecTranValues[3];
		}
		ARJspCurr.setInput(sGrpName+".ArrPTranTypes",	sPTTypes	);
		ARJspCurr.setInput(sGrpName+".ArrPTranAmts",	sPTAmounts	);
		ARJspCurr.setInput(sGrpName+".ArrPageCrncyInd",	sPageCrncyInd	);
	}
	ARJspCurr.setInput(sGrpName+".TotScreens",String.valueOf(iTotScreens));
	TreeMap denomTM = new TreeMap();
	denomTM = (TreeMap)ARJspCurr.getInput("denomTM", new TreeMap());
	int iSizeTM = denomTM.size();
	sRecCount = (String)ARJspCurr.getInput(sGrpName+".RecCount", "1");
	//sRecCount will the the no of pages to be displayed.
	sRecCount = (String)ARJspCurr.getInput(sGrpName+".RecCount", "1");
	iRecCount = Integer.parseInt(sRecCount);
	if(!sDummy.equals("Y"))
		ARJspCurr.setInput(sGrpName+".AcctIds",sAcctIds);

	if(sDummy.equals("Y"))
	{
		String sAppNextPage = customBeanInst.getNextPage();
		sRecCount	= (request.getParameter("custom.RecCount")!=null)?request.getParameter("custom.RecCount"):"1";
		iRecCount 	= Integer.parseInt(sRecCount);
		sParam[0]	= "Message";
		sParam[1]	= "Details";
		sValues		= customBeanInst.getCustOutData(sParam);
		sMessage	= sValues[0];
		sDetails	= sValues[1];
		if(sMessage.equals("Y"))
		{
			sParam[0]	=	"counts";
			sParam[1]	=	"TotCount";
			sParam[2]	=	"ptranTypes";
			sParam[3]	=	"Crncy";
			sParam[4]	=	"CrncyDtls";
			sParam[5]	=	"tranType";
			sValues		=	customBeanInst.getCustOutData(sParam);
			sCounts		=	sValues[0];
			sTotCount	=	sValues[1];
			sPtranTypes	=	sValues[2];
			sCrncy		=	sValues[3];
			sCrncyDtls	=	sValues[4];
			if(sTranType=="") sTranType	=	sValues[5];
			iTotCount 	= Integer.parseInt(sTotCount);
			String[] sArrPTranTypes = sPtranTypes.split("~");
			String[] sArrCrncy		= sCrncy.split("~");
			String[] sArrCrncyDtls	= sCrncyDtls.split("~");
			String[] sArrCounts		= sCounts.split("~");
			String sCoinCount, sCoinTmp = "", sNoteTmp = "" ;
			String sDupArrCrncy[]		= new String[10];
			String sDupArrCrncyDtls[]	= new String[10];
			String sArrCoinDenomVal[]	= new String[10];
			String sArrNoteDenomVal[]	= new String[10];
			String sArrNoteDenomCnt[]	= new String[10];
			String sArrCoinDenomCnt[]	= new String[10];
			String setVarFlg[]          = new String[10];
			String sNoteCount;
			String[] sTemp = null;
			int iCount;
			int iTotDenomCount	= 0;
			int iStartPosGB		= 0;
			int iEndPosGB		= 0;
			sParam		= new String[iTotCount+10];
			sValues		= new String[iTotCount+10];
			aCountNames	= new String[iTotCount+10];
			aCountVals	= new String[iTotCount+10];
			if(sFunc.equals("M"))
			{
				iLen = iTotScreens;
				if(iTotScreens<(sArrCrncy.length))
					sVscrFlg="N";
			}
			else
			{
				iLen = sArrPTranTypes.length;
			}
			sDupArrCrncy		= new String[iLen];
			sDupArrCrncyDtls	= new String[iLen];
			sArrNoteDenomVal	= new String[iLen];
			sArrCoinDenomVal	= new String[iLen];
			sArrNoteDenomCnt	= new String[iLen];
			sArrCoinDenomCnt	= new String[iLen];
			
			for (int i=0; i < sArrCrncy.length; i++)
			{
				sDupArrCrncy[i]		= sArrCrncy[i];
				sDupArrCrncyDtls[i] = sArrCrncyDtls[i];
			}
			sDenomTot = new String[iLen];
			double dDenomTot = 0;
			for (int i=0; i < sArrPTranTypes.length; i++)
			{
				if(sFunc.equals("R"))
					if(sArrPTranTypes[i].equals("C"))
						sArrPTranTypes[i] = "D";
					else
						sArrPTranTypes[i] = "C";
				sTmpParam[0]	= "PBCount" + (i+1);
				sTmpParam[1]	= "GBCount" + (i+1);
				sTmpParam[2]	= "DenomNoteVal" + (i+1);
				sTmpParam[3]	= "DenomNoteCnt" + (i+1);
				sTmpParam[4]	= "DenomCoinVal" + (i+1);
				sTmpParam[5]	= "DenomCoinCnt" + (i+1);
				sTmpParam[6]	= "RoundOffVal" + (i+1);
				sTmpParam[7]	= "RoundOffTyp" + (i+1);
				sTmpValues	= customBeanInst.getCustOutData(sTmpParam);
				sPBCount	= sTmpValues[0];
				sGBCount	= sTmpValues[1];
				sDenomNoteVal	= sTmpValues[2];
				sDenomNoteCnt	= sTmpValues[3];
				sDenomCoinVal	= sTmpValues[4];
				sDenomCoinCnt	= sTmpValues[5];
				sRoundOffVal	= sTmpValues[6];
				sRoundOffTyp	= sTmpValues[7];
				sDenomNoteValArr= sDenomNoteVal.split("-");
				sDenomNoteCntArr= sDenomNoteCnt.split("-");
				sDenomCoinValArr= sDenomCoinVal.split("-");
				sDenomCoinCntArr= sDenomCoinCnt.split("-");
				sCoinTmp 	= "";
				sNoteTmp 	= "";
				sCurrency 	= sArrCrncy[i];
				sTemp 		= sArrCounts[i].split("@");
				sCoinCount 	= sTemp[0];
				sNoteCount 	= sTemp[1];
				setVarFlg[0] = "setVarFlg";
				setVarFlg                       = customBeanInst.getCustOutData(setVarFlg);
				System.out.println("DEBUG - SETVAR FLAG:" + setVarFlg[0]);

				if(sTranType.equals("CCT"))	{
					if(sFunc.equals("I") || sFunc.equals("R"))
					sPageName = sArrPTranTypes[i] + sCurrency + i;
					else
					sPageName = sArrPTranTypes[i] + sCurrency + sPageCrncyInd[i];
				}	else	{
					sPageName = sArrPTranTypes[i] + sCurrency;
				}
				int j = 0, k = 0, z = 0, DenomCount = Integer.parseInt(sCoinCount) + Integer.parseInt(sNoteCount);
				// The following 2 variables are for the Round off Amount and Round off type from backend.
				sParam[0]	= "MaxCoinDenom" + i;
				sParam[1]	= "MaxNoteDenom" + i;
				sValues = customBeanInst.getCustOutData(sParam);
				dDenomTot = 0;
				for(j=0; j < sDenomCoinValArr.length; j++)
				{
					sCountName = sPageName + "CoinDenomCount" + j; 
					denomTM.put(sCountName,sDenomCoinCntArr[j]);
					dDenomTot = dDenomTot + Double.parseDouble(sDenomCoinValArr[j])*Double.parseDouble(sDenomCoinCntArr[j]);
				}
				for(j=0; j < sDenomNoteValArr.length; j++)
				{
					sCountName = sPageName + "NoteDenomCount" + j; 
					denomTM.put(sCountName,sDenomNoteCntArr[j]);
					dDenomTot = dDenomTot + Double.parseDouble(sDenomNoteValArr[j])*Double.parseDouble(sDenomNoteCntArr[j]);
				}
				denomTM.put(sPageName+"TotalDenomAmt","0");
				denomTM.put(sPageName+"RoundOffVal",sRoundOffVal);
				denomTM.put(sPageName+"RoundOffTyp",sRoundOffTyp);
				sArrCoinDenomVal[i] = sDenomCoinVal; 
				sArrNoteDenomVal[i] = sDenomNoteVal;
				sArrCoinDenomCnt[i] = sValues[0];
				sArrNoteDenomCnt[i] = sValues[1];
				iTotDenomCount = iTotDenomCount + DenomCount + 2;
				iRecCount = i;
				// Initializing variables to capture the Pay Back and Get back details.
				int iPBCount = Integer.parseInt(sPBCount);
				int iGBCount = Integer.parseInt(sGBCount);
				int len = iPBCount + iGBCount;
				if(len>0)
				{
					sParam		= new String[len+10];
					sValues		= new String[len+10];
					aCountNames 	= new String[len+10];
					aCountVals	= new String[len+10];
				}
				iTmp = (sArrPTranTypes[i].equals("C"))?1:-1;
				if(iPBCount > 0)
				{
					sTmpParam[0]	= "PBDenomNoteCnt" + (i+1);
					sTmpParam[1]	= "PBDenomCoinCnt" + (i+1);
					sTmpValues	= customBeanInst.getCustOutData(sTmpParam);
					sDenomNoteCntPB	= sTmpValues[0];
					sDenomCoinCntPB	= sTmpValues[1];
					sDenomNoteCntPBArr = sDenomNoteCntPB.split("-");
					sDenomCoinCntPBArr = sDenomCoinCntPB.split("-");
					for(k=0; k < sDenomNoteValArr.length; k++)
					{
						sParam[k] = "PBDenomDtls" + k;
						sCountName = "PB" + sPageName + "NoteDenomCount" + k;
						denomTM.put(sCountName,sDenomNoteCntPBArr[k]);
						dDenomTot = dDenomTot - iTmp*Double.parseDouble(sDenomNoteValArr[k])*Double.parseDouble(sDenomNoteCntPBArr[k]);
					}
					for(k=0; k < sDenomCoinValArr.length; k++)
					{
						sParam[k] = "PBDenomDtls" + k;
						sCountName = "PB" + sPageName + "CoinDenomCount" + k;
						denomTM.put(sCountName,sDenomCoinCntPBArr[k]);
						dDenomTot = dDenomTot - iTmp*Double.parseDouble(sDenomCoinValArr[k])*Double.parseDouble(sDenomCoinCntPBArr[k]);
					}
				}
				if(iGBCount > 0)
				{
					sTmpParam[0]	= "GBDenomNoteCnt" + (i+1);
					sTmpParam[1]	= "GBDenomCoinCnt" + (i+1);
					sTmpValues	= customBeanInst.getCustOutData(sTmpParam);
					sDenomNoteCntGB	= sTmpValues[0];
					sDenomCoinCntGB	= sTmpValues[1];
					sDenomNoteCntGBArr = sDenomNoteCntGB.split("-");
					sDenomCoinCntGBArr = sDenomCoinCntGB.split("-");
					for(k=0; k < sDenomNoteValArr.length; k++)
					{
						sParam[k] = "GBDenomDtls" + k;
						sCountName = "GB" + sPageName + "NoteDenomCount" + k;
						denomTM.put(sCountName,sDenomNoteCntGBArr[k]);
						dDenomTot = dDenomTot + iTmp*Double.parseDouble(sDenomNoteValArr[k])*Double.parseDouble(sDenomNoteCntGBArr[k]);
					}
					for(k=0; k < sDenomCoinValArr.length; k++)
					{
						sParam[k] = "GBDenomDtls" + k;
						sCountName = "GB" + sPageName + "CoinDenomCount" + k;
						denomTM.put(sCountName,sDenomCoinCntGBArr[k]);
						dDenomTot = dDenomTot + iTmp*Double.parseDouble(sDenomCoinValArr[k])*Double.parseDouble(sDenomCoinCntGBArr[k]);
					}
				}
				iTmpCnt=i;
				if((sRoundOffTyp.equals("D")&& sArrPTranTypes[i].equals("C")) || (sRoundOffTyp.equals("C")&& sArrPTranTypes[i].equals("D")))
					sDenomTot[i] = String.valueOf(dDenomTot + Double.parseDouble(sRoundOffVal));
				else
					sDenomTot[i] = String.valueOf(dDenomTot - Double.parseDouble(sRoundOffVal));
			}
			iRecCount = iRecCount+1;
				sRecCount = String.valueOf(iRecCount);
			ARJspCurr.setInput("denomTM",denomTM);
			ARJspCurr.setInput(sGrpName+".RecCount",sRecCount);
			ARJspCurr.setInput(sGrpName+".TranType",sTranType);
			ARJspCurr.setInput(sGrpName+".setVarFlg", setVarFlg[0]);	
			System.out.println("DEBUG - SETVAR FLAG AGAIN:" + setVarFlg[0]);
			
			if(sFunc.equals("I") || sFunc.equals("M1") || sFunc.equals("R")) 
			{
				ARJspCurr.setInput(sGrpName+".ArrPTranTypes",sArrPTranTypes);
				ARJspCurr.setInput(sGrpName+".ArrDenomTot",sDenomTot);
			}
			for(int i=0; i<sArrCrncyDtls.length; i++)
			{
				sArrCrncyDtls[i] =  sArrCrncy[i] + "@" + sArrCrncyDtls[i];
			}
			ARJspCurr.setInput(sGrpName+".ArrCrncy",sArrCrncy);
			ARJspCurr.setInput(sGrpName+".ArrCrncyDtls",sArrCrncyDtls);
			ARJspCurr.setInput(sGrpName+".ArrCoinDenomVal",sArrCoinDenomVal);
			ARJspCurr.setInput(sGrpName+".ArrNoteDenomVal",sArrNoteDenomVal);
			if(sFunc.equals("M"))
				ARJspCurr.setInput(sGrpName+".ArrUniqCrncys",	sArrUniqCrncys);
			if(sFunc.equals("M1") || sFunc.equals("R"))
				ARJspCurr.setInput(sGrpName+".ArrUniqCrncys",	sArrCrncy);
			ARJspCurr.setInput(sGrpName+".ArrNoteDenomCnt",sArrNoteDenomCnt);
			ARJspCurr.setInput(sGrpName+".ArrCoinDenomCnt",sArrCoinDenomCnt);
			if(sFunc.equals("M"))
			{
				sParam			= new String[1];
				sParam[0]		= "newCrncyCnt";
				sValues			= customBeanInst.getCustOutData(sParam);
				int iNewCrncyCnt	= Integer.parseInt(sValues[0]);
				String sParamCrncy[]		= new String[iNewCrncyCnt+1];
				String sParamCrncyDtls[]	= new String[iNewCrncyCnt+1];
				String sParamNoteDenomVal[]	= new String[iNewCrncyCnt+1];
				String sParamCoinDenomVal[]	= new String[iNewCrncyCnt+1];
				String sParamNoteDenomCnt[]	= new String[iNewCrncyCnt+1];
				String sParamCoinDenomCnt[]	= new String[iNewCrncyCnt+1];
				String sValuesCrncy[]		= new String[iNewCrncyCnt+1];
				String sValuesCrncyDtls[]	= new String[iNewCrncyCnt+1];
				String sValuesNoteDenomVal[]= new String[iNewCrncyCnt+1];
				String sValuesCoinDenomVal[]= new String[iNewCrncyCnt+1];
				String sValuesNoteDenomCnt[]= new String[iNewCrncyCnt+1];
				String sValuesCoinDenomCnt[]= new String[iNewCrncyCnt+1];
//				String setVarFlg[]          = new String[iNewCrncyCnt+1];
				for(int i=0, j=0; i<=iNewCrncyCnt; i++)
				{
					sParamCrncy[i]			= "Crncy"			+ i;
					sParamCrncyDtls[i]		= "CrncyDtls"		+ i;
					sParamNoteDenomVal[i]	= "NoteDenomVal"	+ i;
					sParamCoinDenomVal[i]	= "CoinDenomVal"	+ i;
					sParamNoteDenomCnt[i]	= "NoteDenomCnt"	+ i;
					sParamCoinDenomCnt[i]	= "CoinDenomCnt"	+ i;
				}
//				 setVarFlg[0] = "setVarFlg";
				sValuesCrncy			= customBeanInst.getCustOutData(sParamCrncy);
				sValuesCrncyDtls		= customBeanInst.getCustOutData(sParamCrncyDtls);
				sValuesNoteDenomVal		= customBeanInst.getCustOutData(sParamNoteDenomVal);
				sValuesCoinDenomVal		= customBeanInst.getCustOutData(sParamCoinDenomVal);
				sValuesNoteDenomCnt		= customBeanInst.getCustOutData(sParamNoteDenomCnt);
				sValuesCoinDenomCnt		= customBeanInst.getCustOutData(sParamCoinDenomCnt);
//				 setVarFlg                       = customBeanInst.getCustOutData(setVarFlg);

				for(int i=0,j=iRecCount; j < iTotScreens; i++,j++)
				{
					sDupArrCrncy[j]		= sValuesCrncy[i];
					sDupArrCrncyDtls[j]	= sValuesCrncyDtls[i];
					sArrCoinDenomVal[j] = sValuesCoinDenomVal[i];
					sArrNoteDenomVal[j]	= sValuesNoteDenomVal[i];
					sArrNoteDenomCnt[j]	= sValuesNoteDenomCnt[i];
					sArrCoinDenomCnt[j]	= sValuesCoinDenomCnt[i];
				}
				for(int u=0; u < sDupArrCrncyDtls.length; u++)
				{
					sDupArrCrncyDtls[u] =  sDupArrCrncy[u] + "@" + sDupArrCrncyDtls[u];
				}
				ARJspCurr.setInput(sGrpName+".ArrCrncy",sDupArrCrncy);
				ARJspCurr.setInput(sGrpName+".ArrCrncyDtls",sDupArrCrncyDtls);
				ARJspCurr.setInput(sGrpName+".ArrCoinDenomVal",sArrCoinDenomVal);
				ARJspCurr.setInput(sGrpName+".ArrNoteDenomVal",sArrNoteDenomVal);
				ARJspCurr.setInput(sGrpName+".ArrNoteDenomCnt",sArrNoteDenomCnt);
				ARJspCurr.setInput(sGrpName+".ArrCoinDenomCnt",sArrCoinDenomCnt);
//				ARJspCurr.setInput(sGrpName+".setVarFlg", setVarFlg[0]);
			}
		}
	}
	if(sMessage.equals("Y"))
	{
		if(!sFunc.equals("I"))
		{
			if(iTotScreens > iRecCount)
			{
				if(sDummy.equals("Y"))
				{
					String[] sArrCrncy	= (String[])ARJspCurr.getInput(sGrpName+".ArrCrncy", null);
					String[] sArrCrncyDtls	= (String[])ARJspCurr.getInput(sGrpName+".ArrCrncyDtls", null);
					sNArrCrncyDtls		= new String[iTotScreens+10];
					for(int p=0 ; p<iTotScreens; p++)
					{
						if(p < iRecCount)
						{
							sNArrCrncyDtls[p] = sArrCrncyDtls[p];
						}
						else
						{
							sRecTranValues	= sTranValues[p].split("~");
							sCrncy		= sRecTranValues[1];
							iArrIndex	= indexOfArr(sArrCrncy,sCrncy);
							if(iArrIndex!= -1)
							{
								sNArrCrncyDtls[p] = sArrCrncyDtls[iArrIndex];	
							}
						}
					}
					ARJspCurr.setInput(sGrpName+".ArrCrncyDtls",sNArrCrncyDtls);
					sArrCrncyDtls = (String[])ARJspCurr.getInput(sGrpName+".ArrCrncyDtls", null);
				}
			}
		}
	}
%>

<HTML>
<SCRIPT>
var TranType = "<%=sTranType%>";

function fnPageLoad()
{
	
	var sizeTM 	= '<%=iSizeTM%>';
	var Message	= '<%=sMessage%>' ; 
	var Details	=  '<%=sDetails%>' ; 
	var vscrFlg	= '<%=sVscrFlg%>';
	if(Details == "DIS")
	{
		window.returnValue = "<%=sMessage%>|<%=sDetails%>";
		window.close();
	}
	if(Message=="N")
	{
		window.returnValue = "N|"+Details;
		window.close();
	}
	else
	{
		if(sizeTM > 0)
		{
			window.returnValue = "C";
			window.close();
		}
		var Dummy   = "<%=sDummy%>";
		window.name = "DenomPopup";
	
		if(Dummy!="Y")
		{
			
			document.forms[0].target = "DenomPopup";
			document.forms[0].action = "jsp/denomdp003.jsp?Dummy=Y&TranId=<%=sTranId%>&Func=<%=sFunc%>&TranDtls=<%=sTranDtls%>&uniqCrncys=<%=sUniqCrncys%>&tranType=<%=sTranType%>";
			

			document.forms[0].submit();
		}
		else
		{
			window.returnValue = "S|Success";
			window.close();
		}
	}
}

function fnWriteFields()
{
	var TranId			= "<%=sTranId%>";
	var TranDate		= "<%=sTranDate%>";
	var pTranType		= "<%=sPtranTypes%>".split("~");
	var ArrUniqCrncys	= "<%=sUniqCrncys%>".split("!");
	var iUniqCrncysLen	= ArrUniqCrncys.length;
	var writeAcctIds	= "Y";
	var AcctIds = [];
	if(TranType=="CNP"||TranType=="CNR"||TranType=="CPI"||TranType=="CRI")
		writeAcctIds = "N";
	(iUniqCrncysLen == 1) ? AcctIds[0] = "<%=sAcctIds%>": AcctIds = "<%=sAcctIds%>".split("@");
//	writeHeader("tmdet");
	with (document) 
	{
		write('<input type="hidden" name="custom.TranId" id="TranId" value="'+TranId+'">');
		write('<input type="hidden" name="custom.TranDate" id="TranDate" value="'+TranDate+'">');
		write('<input type="hidden" name="custom.UniqCrncysLen" id="UniqCrncysLen" value="'+iUniqCrncysLen+'">');
		write('<input type="hidden" name="custom.TranType" id="TranType" value="'+TranType+'">');
		for(var i=0; i<iUniqCrncysLen; i++)
		{
			write('<input type="hidden" name="custom.Crncy' + i +'" value="'+ArrUniqCrncys[i]+'">');
			write('<input type="hidden" name="custom.pTranType' + i +'" value="'+ pTranType[i] +'">');
			if(writeAcctIds=="Y")
			write('<input type="hidden" name="custom.AcctId' + i +'" value="'+AcctIds[i]+'">');
		}
	}
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
	}	%>

<BODY class="cbody">
<P>&nbsp;Processing......</P>
<img src="../Renderer/images/wait.gif">
</BODY>

<INPUT type="Hidden" name="submitform" value="Submit">
<INPUT type="Hidden" name="pagename" value="denomdp003.jsp">
<INPUT type="Hidden" name="scrName" value="denomdp010.scr" >
<INPUT type="Hidden" name="custom.Func" value="<%=sFunc%>">
<INPUT type="Hidden" name="custom.referralFlg" value="<%=sReferralFlg%>">

</FORM>
</BODY>
</HTML>

