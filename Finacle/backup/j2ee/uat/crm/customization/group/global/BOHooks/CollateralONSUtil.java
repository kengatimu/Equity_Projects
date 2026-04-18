/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CollateralONSUtil.java $
 *
 * Author: Kishore Kalla $
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/CollateralONSUtil.java $
 *
 * $History: CollateralONSUtil.java $
/******************************************************************************/


package com.infy.cis.custom;

import java.util.*;

import com.infosys.insulate.util.HashMap;
import com.infosys.insulate.util.Vector;
import com.infosys.insulate.util.ArrayList;
import com.infosys.insulate.util.HashSet;
import com.infosys.insulate.util.TreeSet;
import com.infosys.insulate.util.IdentityHashMap;
import com.infosys.insulate.util.LinkedHashMap;
import com.infosys.insulate.util.LinkedHashSet;
import com.infosys.insulate.util.LinkedList;
import com.infosys.insulate.util.Stack;
import com.infosys.insulate.util.TreeMap;
import com.infosys.insulate.util.WeakHashMap;
import com.infosys.insulate.util.PriorityQueue;
import java.util.Date.*;
import java.text.DateFormat.*;
import java.text.DateFormat.*;
import java.lang.*;
import java.text.SimpleDateFormat;
import com.infosys.ci.common.CIUserInfo;
import com.infosys.ci.common.FIIncidentInfo; //10.1Recon Changes
import com.infosys.ci.ons.cistruct.*;
import com.infosys.bankaway.accesslayer.bwyinterface.CollateralALImplementation;
import com.infosys.ci.common.*;
import java.text.DateFormat.*; //10.1Recon Changes
import java.util.Date; //End of Recon Changes

/*Tracker 103058 : FI Call Change :Start
import com.infosys.bankaway.accesslayer.bwyinterface.CIHostMarker;
Tracker 103058 : FI Call Change :End*/


public class CollateralONSUtil {

	public static String fetchColtrlDetails(String CollateralRefNo, CIUserInfo ciUserInfo, String[] inputstrarr) {


		String onsresult = "";
		String colRefno="";
		String colCode="";
		String colValue="";
		String mktValue=""; //10.1 Recon Changes
		String marginPercentage="";
		String totalapportionedvalue="";
		String lastAppraisalDate="";
		String mortgagedAmount="";
		String drvValFrmInd = "";
		String strGrossVal = "";
		String strInvoiceVal = "";
		String strLTVPercent = "";
		String strMrktValue = "";
		String strMrtgedAmt = "";
		long lNoOfUnits = 0;
		String strPolicyVal = "";
		String strSurndrVal = "";
		String strUnitVal = "";
		String strWrittenDownVal = "";
			//changes for Ticket 704477 begins
		String strAssessedValue = "";
			//changes for Ticket 704477 ends
		CIColtrlDistinctNumbers  disnums=null;
		/*Tracker 103058 : FI Call Change :Start*/
		CollateralALImplementation ciRAI = null;
		try{
			ciRAI = new CollateralALImplementation() ;
		}catch(Exception e){
			//System.out.println("Error in getting CIHost for ONS :"+e);
		}
		CIColtrlDtlsInStruct colDtlsStruct = new CIColtrlDtlsInStruct();
		colDtlsStruct.setColtrlId(CollateralRefNo);

		ciUserInfo.setChannelType("CRM");
		FIIncidentInfo objFIIncidentInfo = new FIIncidentInfo();
		String xx = String.valueOf(System.currentTimeMillis());
		objFIIncidentInfo.setDccReqRefNum(xx);

		//String xy = new java.text.SimpleDateFormat("MM-dd-yyyy HH:MM:ss.ms").format(new Date());
		String xy = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(new Date());
		objFIIncidentInfo.setDccReqOrigTime(xy);
		objFIIncidentInfo.setDccReqType("DEFAULTEJB");
		/*Start of changes for Tracker Id:193542 */
		//ciUserInfo.setDccReqVersion("VER1");
		/*End of changes for Tracker Id:193542 */
		ciUserInfo.setAccessChannelId("CRM");
		ciUserInfo.setUserId("FIVUSR");
		colDtlsStruct.setFiIncidentInfo(objFIIncidentInfo);
		String bankID = (String)com.infy.cis.common.SRMTLVar.bank_id.get();
		if( bankID != null || !bankID.equalsIgnoreCase("")){
					ciUserInfo.setBankId(bankID);
				}
				else{
					ciUserInfo.setBankId("01");
		}
		try
		{
			/* 10.1 RECON Changes by mukundhan_santhanam (79625)*/
			CIColtrlDtlsInStruct instruct = new CIColtrlDtlsInStruct();

			//CIColtrlDistinctNumbers disnums =null;

			FIIncidentInfo FIInci = instruct.getFiIncidentInfo();

			FIInci.setDccReqRefNum(String.valueOf(System.currentTimeMillis()));
			//FIInci.setDccReqOrigTime(new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss.sss").format(new Date()));
			FIInci.setDccReqOrigTime(new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(new Date()));

			instruct.setColtrlId(CollateralRefNo);
			instruct.setInputstr(inputstrarr);
			instruct.setFiIncidentInfo(FIInci);
			// End of 10.1 RECON Changes

			//CIColtrlDtlsOutputStruct outstruct=ciCAI.fetchColtrlDtls(ciUserInfo,colDtlsStruct);
			CIColtrlDtlsOutputStruct outstruct=ciRAI.fetchColtrlDtls(ciUserInfo,colDtlsStruct);

			colRefno=outstruct.getColtrlId();
			if(null==colRefno)
			{
				colRefno="";
			}

			colCode=outstruct.getColtrlCode();
			if(null==colCode)
			{
				colCode="";
			}

			colValue=outstruct.getColtrlvalue();
			if(null==colValue)
			{
				colValue="";
			}

			marginPercentage=outstruct.getMarginPercentage();
			if(null==marginPercentage)
			{
				marginPercentage="";
			}
			
			//changes for Ticket 704477 begins
			strAssessedValue=outstruct.getAssessedValue();
			if(null==strAssessedValue)
			{
				strAssessedValue="";
			}
			//changes for Ticket 704477 ends

			totalapportionedvalue=outstruct.getTotalapportionedvalue();
			if(null==totalapportionedvalue)
			{
				totalapportionedvalue="";
			}

			lastAppraisalDate=outstruct.getLastAppraisalDate();
			if(null==lastAppraisalDate)
			{
				lastAppraisalDate="";
			}

			drvValFrmInd = outstruct.getDeriveValueFromIndicator();
			if (null == drvValFrmInd )
			{
				drvValFrmInd = "";
			}

			strGrossVal = outstruct.getGrossValue();
			if (null == strGrossVal )
			{
				strGrossVal = "";
			}

			strInvoiceVal = outstruct.getInvoiceValue();
			if ( null == strInvoiceVal )
			{
				strInvoiceVal = "";
			}

			strLTVPercent = outstruct.getLtvPercent();
			if ( null == strLTVPercent )
			{
				strLTVPercent = "";
			}

			strMrktValue = outstruct.getMarketValue();
			if ( null == strMrktValue )
			{
				strMrktValue = "";
			}

			strMrtgedAmt = outstruct.getMortgagedAmount();
			if ( null == strMrtgedAmt )
			{
				strMrtgedAmt = "";
			}

			lNoOfUnits = outstruct.getNoOfUnits();

			strPolicyVal = outstruct.getPolicyValue();
			if ( null == strPolicyVal )
			{
				strPolicyVal = "";
			}

			strSurndrVal = outstruct.getSurrenderValue();
			if ( null == strSurndrVal )
			{
				strSurndrVal = "";
			}

			strUnitVal = outstruct.getUnitValue();
			if ( null == strUnitVal )
			{
				strUnitVal = "";
			}

			strWrittenDownVal = outstruct.getWrittenDownValue();
			if ( null == strWrittenDownVal )
			{
				strWrittenDownVal = "";
			}

			disnums=outstruct.getDistinctNumbers();

			String disnum = "";

			if ( (disnums != null) && disnums.getPrptyDocumentNo() != null) {//10.1 Recon Changes
				if(disnums.getPrptyDocumentNo().length() != 0)
				disnum = disnums.getPrptyDocumentNo();
			}

			if ( (disnums != null) && disnums.getMachineNum() != null) {//10.1 Recon Changes
				if(disnums.getMachineNum().length() != 0){
					if ( disnum != "" )
						disnum = disnum + ",";
					}
				disnum = disnum + disnums.getMachineNum();
			}

			if ( (disnums != null) && disnums.getChassisNo() != null){//10.1 Recon Changes
				if(disnums.getChassisNo().length() != 0){
					if ( disnum != "" )
						disnum = disnum + ",";
					}
				disnum = disnum + disnums.getChassisNo();
			}

			if ( (disnums != null) && disnums.getRegnNo() != null){//10.1 Recon Changes
				if(disnums.getRegnNo().length() != 0){
					if ( disnum != "" )
						disnum = disnum + ",";
					}
				disnum = disnum + disnums.getRegnNo();
			}

			if ( (disnums != null) && disnums.getEngineNo() != null){//10.1 Recon Changes
				if(disnums.getEngineNo().length() != 0){
					if ( disnum != "" )
						disnum = disnum + ",";
					}
				disnum = disnum + disnums.getEngineNo();
			}

			if ( (disnums != null) && disnums.getModel() != null){//10.1 Recon Changes
				if(disnums.getModel().length() != 0){
					if ( disnum != "" )
						disnum = disnum + ",";
					}
				disnum = disnum + disnums.getModel();
			}

			//changes for Ticket 704477 begin
			onsresult = "SaleBO.SaleGenInfo.shortstr4=" +colCode+ ":"+
				"3_SaleBO.SaleGenInfo.amount1=" + colValue+ ":"+
				"3_SaleBO.SaleGenInfo.MarketVal=" + strMrktValue+ ":"+ //10.1 Recon Changes
				//"SaleBO.SaleGenInfo.shortstr7=" + cur_MortAmt + ":" +
				"3_SaleBO.SaleGenInfo.amount4=" +totalapportionedvalue+ ":" +
				"SaleBO.SaleGenInfo.shortstr5=" +marginPercentage+ ":" +
				"3_SaleBO.SaleGenInfo.amount5=" + mortgagedAmount+ ":" +
				"SaleBO.SaleGenInfo.date2=" +lastAppraisalDate + ":" +
				"SaleBO.SaleGenInfo.longstr1=" + disnum + ":"+
				"3_SaleBO.SaleGenInfo.InvoiceVal=" + strInvoiceVal + ":"+
				"3_SaleBO.SaleGenInfo.WrittenDownVal=" + strWrittenDownVal + ":" +
				"3_SaleBO.SaleGenInfo.amount6=" + strAssessedValue + ":";
			//changes for Ticket 704477 ends


		}catch(Exception e)
		{
			//System.out.println("Exception in CollateralONSUtil.java ---> "+e);
			e.printStackTrace();
			onsresult="";
		}
		/*Tracker 103058 : FI Call Change :End*/
		return onsresult;
	}
}



