/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: GetInterestRateFromCore.java $
 *
 * Author: APAC
 *
 * $Archive: GetInterestRateFromCore.java $
 *
 * $History: GetInterestRateFromCore.java $
 *
 *****************************************************************************/


package com.infy.cis.custom;

import com.infosys.ci.ons.cistruct.*;
import com.infosys.ci.hostinterface.common.*;
import com.infosys.ci.common.CIFatalException;
import com.infosys.ci.common.CINonFatalException;
import com.infosys.bankaway.accesslayer.bwyinterface.*;
import com.infosys.ci.ons.common.CIOnsNonFatalException;
import com.infosys.bankaway.accesslayer.bwyinterface.*;
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
import java.lang.*;
import java.text.SimpleDateFormat;
import com.infosys.ci.ons.common.*;
import com.infosys.ci.common.*;
import com.infy.cis.exception.*;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.ui.common.QueryAssist;
/*Tracker 89161 Begin of Changes */
import java.math.*;
/*Tracker 89161 End of Changes */

public class GetInterestRateFromCore
{
	//CIUserInfo  ciUserInfo = new CIUserInfo();


/********************************************************************************************

		*           Method name    : fetchInterestRate

		*           parameters     : SRMBusinessContext bc, String ProducsKey,String Currency,Integer TenorDays, Integer TenorMonths, Double LoanAmount

		*           Return Values  : ArrayList

		*           Description    : This Method takes in parameters required to calculate interest and calls CORE API's.
									 It takes output returned by CORE APIs and customizes  it into an ArrayList which is returned

*********************************************************************************************/
/*** Start 110899****/
public ArrayList fetchInterestRate(SRMBusinessContext bc, String ProductsKey, String Currency, Integer TenorDays, Integer TenorMonths, BigDecimal LoanAmount,String InterestCode, String sOriginDate) throws SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException,Exception
{
	return fetchInterestRate(bc,ProductsKey,Currency,TenorDays,TenorMonths,LoanAmount,InterestCode,sOriginDate,null);
}

public ArrayList fetchInterestRate(SRMBusinessContext bc, String ProductsKey, String Currency, Integer TenorDays, Integer TenorMonths, BigDecimal LoanAmount,String InterestCode, String sOriginDate, Integer salesID) throws SRMBOException, SRMSecurityException, CISInvalidArgumentException, CISConfigException, ClassNotFoundException, SRMBCException,Exception
{

	ArrayList Tenor = new ArrayList();

	String strEffIntRate = null;
	String strBaseIntRate = null;
 	String sLoanAmount = null;
	String [] inputstr = new String[0];
	CIUserInfo  ciUserInfo = new CIUserInfo();
	InterestDetailsMsgInput interestDetails = new InterestDetailsMsgInput();
	Amount amount	= interestDetails.getLoanAmt();
	InterestTableCode tblCode = interestDetails.getIntTblCode();
	ciUserInfo.setChannelType("CRM");


	FIIncidentInfo objFIIncidentInfo = new FIIncidentInfo();
	String xx = String.valueOf(System.currentTimeMillis());
	if (salesID != null)
	xx = xx + salesID.toString();
	objFIIncidentInfo.setDccReqRefNum(xx);
	String xy = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(new Date());
	objFIIncidentInfo.setDccReqOrigTime(xy);
	objFIIncidentInfo.setDccReqType("DEFAULTEJB");

	/*Start of changes for Tracker Id:193542 */
	//ciUserInfo.setDccReqVersion("VER1");
	/*End of changes for Tracker Id:193542 */

	ciUserInfo.setAccessChannelId("CRM");
	ciUserInfo.setUserId("FIVUSR");

	interestDetails.setFIIncidentInfo(objFIIncidentInfo);

	String bankID = (String)com.infy.cis.common.SRMTLVar.bank_id.get();
	if((null!= bankID)  && (!bankID.equalsIgnoreCase(""))){
		ciUserInfo.setBankId(bankID);
	}
	else{
		ciUserInfo.setBankId("01");
	}


	if(null != LoanAmount)
		amount.setAmountValue(LoanAmount.doubleValue());
		amount.setCurrencyCode(Currency);
		interestDetails.setLoanAmt(amount);

    /*Checking null for TenorDays and TenorMonths*/
    if(TenorDays != null){
		interestDetails.setLoanPerdDays(TenorDays.intValue());
	    //ciIntDetMsg.setLoanPerdDays(TenorDays.intValue());
    }
    if(TenorMonths != null){

	    interestDetails.setLoanPerdMnths(TenorMonths.intValue());
    }
    /*Checking null for TenorDays and TenorMonths*/
	interestDetails.setCrncyCode(Currency);

	tblCode.setTblCode(InterestCode);
	interestDetails.setIntTblCode(tblCode);
	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	java.util.Date originDate = sdf.parse(sOriginDate);
	Calendar  cal = Calendar.getInstance();
	cal.setTime(originDate);
	interestDetails.setOriginationDate(cal);
	    try
		{

			LoanAccountInquiryALImplementation inter = LoanAccountInquiryALImplementation.getInstance();
			InterestDetailsMsgOutput ciIntRate = inter.getInterestDetails(ciUserInfo,interestDetails);
			if(ciIntRate.getBaseIntRate().getValue() != 0.0)
			{
				strBaseIntRate = String.valueOf(ciIntRate.getBaseIntRate().getValue());
			}else{
				strBaseIntRate = "";
			}
			if(ciIntRate.getEffctIntRate().getValue() != 0.0)
			{
				strEffIntRate = String.valueOf(ciIntRate.getEffctIntRate().getValue());
			}else{
				strEffIntRate = "";
			}

			Tenor.add(strEffIntRate);
			Tenor.add(strBaseIntRate);
		}catch (CINonFatalException e){
			try{
				logError("An Internal error occured.Check the interface logs", salesID, bc);
			}catch(Exception ex){}
			throw new CIFatalException("Error Meassage(a): " + e.getMessage());
		}
		catch (CIOnsNonFatalException confe){
		try{
			logError(confe, salesID, bc);
		}catch(Exception ex){}
		String strErrMsg = "";
		for (int i = 0; i < confe.getErrorLL().length; i++)
		{
			CIOnsErr errObj = (CIOnsErr) confe.getErrorLL()[i];

			if (errObj.ciErrFieldDesc == null || errObj.ciErrFieldDesc.length() < 1)
			{
				strErrMsg = strErrMsg + "(" + (i + 1) + ") " + errObj.errDesc;
			}
			else
			{
				strErrMsg = strErrMsg + "(" + (i + 1) + ") " + errObj.ciErrFieldDesc + "_" + errObj.errDesc;
			}
		}

		throw new CIFatalException("Error Meassage(b): " + strErrMsg);
		}
		catch (CIFatalException e)
		{
			try{
				logError("An Internal error occured.Check the interface logs", salesID, bc);
			}catch(Exception ex){}
			throw new CIFatalException("Error Meassage(c): " + e.getMessage());
		}
		catch (Throwable e)
		{
			throw new CIFatalException(
			"Runtime errror occured during EISchedule. Please refer to server log",e);
		}
		return Tenor;
}

	public void logError(CIOnsNonFatalException confe,Integer iSalesID, SRMBusinessContext bc)
				throws SRMBOException, SRMTypeValidatorException, SRMSecurityException{

		try{

		Calendar cal = Calendar.getInstance();
		java.util.Date sysDate = cal.getTime();

		ErrorReportBO errRptBO = null;
		SRMQueryBuilder qb =  QueryAssist.singleObjectQuery("ErrorReportBO",ErrorReportBO.SALES_STATUS_ID);
		QueryAssist.addSimpleCondition(qb,"ErrorReportBO",ErrorReportBO.SALESID,IQuery.ComparisonOperation_EQ,""+iSalesID);
		SRMQueryResult qr = qb.runQuery(bc,true,-1);
		SRMRecordSet rs = qr.getRecordSet();
		if(rs.hasNext())
		{
			errRptBO = (ErrorReportBO)rs.getNext().get(0);

		}
		if ( errRptBO == null ) {

			errRptBO = new ErrorReportBO();
			errRptBO.setSalesId(iSalesID);
		}
		SRMCollection errStatHisList = errRptBO.getSales_Status_History();



           for (int i = 0; i < confe.getErrorLL().length; i++) {
               String strErrMsg = "";
               CIOnsErr errObj =  confe.getErrorLL()[i];

               if (errObj.ciErrFieldDesc == null || errObj.ciErrFieldDesc.length() < 1) {

                   strErrMsg = "(" + (i + 1) + ") " + errObj.errDesc;
               } else {

                   strErrMsg = "(" + (i + 1) + ") " + errObj.ciErrFieldDesc + "_" + errObj.errDesc;
               }

          		ErrorReportBO.Sales_Status_History  InstanceOfSales_Status_History_Y = null;
				InstanceOfSales_Status_History_Y = (ErrorReportBO.Sales_Status_History)errRptBO.getInstance("Sales_Status_History");
				InstanceOfSales_Status_History_Y.setBriefDesc("CIOnsNonFatalException");
				InstanceOfSales_Status_History_Y.setStatus_Desc(strErrMsg);
				InstanceOfSales_Status_History_Y.setDateOfError(sysDate);

				errStatHisList.add(InstanceOfSales_Status_History_Y);
           }

		Core.SaveErrorReport(bc,errRptBO);
	}
	catch(Exception ee)
	{
		ee.printStackTrace();
	}
	}


	public void logError(String errMsg, Integer iSalesID, SRMBusinessContext bc)
				throws SRMBOException, SRMTypeValidatorException, SRMSecurityException{

		Calendar cal = Calendar.getInstance();
		java.util.Date sysDate = cal.getTime();
		try{

		ErrorReportBO errRptBO = null;
		SRMQueryBuilder qb =  QueryAssist.singleObjectQuery("ErrorReportBO",ErrorReportBO.SALES_STATUS_ID);
		QueryAssist.addSimpleCondition(qb,"ErrorReportBO",ErrorReportBO.SALESID,IQuery.ComparisonOperation_EQ,""+iSalesID);
		SRMQueryResult qr = qb.runQuery(bc,true,-1);
		SRMRecordSet rs = qr.getRecordSet();
		if(rs.hasNext())
		{
			errRptBO = (ErrorReportBO)rs.getNext().get(0);

		}
		if ( errRptBO == null ) {

			errRptBO = new ErrorReportBO();
			errRptBO.setSalesId(iSalesID);
		}
		SRMCollection errStatHisList = errRptBO.getSales_Status_History();
		ErrorReportBO.Sales_Status_History  InstanceOfSales_Status_History_Y = null;
		InstanceOfSales_Status_History_Y = (ErrorReportBO.Sales_Status_History)errRptBO.getInstance("Sales_Status_History");
		InstanceOfSales_Status_History_Y.setBriefDesc("Fatal Error.");
		InstanceOfSales_Status_History_Y.setStatus_Desc(errMsg);
		InstanceOfSales_Status_History_Y.setDateOfError(sysDate);
		errStatHisList.add(InstanceOfSales_Status_History_Y);

		Core.SaveErrorReport(bc,errRptBO);

		}catch(Exception ee){
			ee.printStackTrace();
		}
	 /*** End 110899****/
	}

}

