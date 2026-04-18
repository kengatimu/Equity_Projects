/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: OnlineRequest.java $
 *
 * Author: Paritosh
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/OnlineRequest.java $
 *
 * **************************************************************************/
package com.infy.cis.custom;

import com.infy.cis.srmbo.*;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.exception.*;
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
import com.infy.cis.common.BankAwayEJBCalls;
import com.infy.cis.ui.common.CommonQueries;
import com.infy.cis.ui.common.QueryAssist;
import com.infy.cis.common.SRMDate;
import java.sql.Timestamp;
import com.infosys.bankaway.accesslayer.user.*;
/*Tracker 103058 : FI Call Change :Start
import com.infosys.bankaway.accesslayer.accounts.*;
import com.infosys.bankaway.accesslayer.bills.*;
Tracker 103058 : FI Call Change :End*/
import com.infosys.bankaway.accesslayer.bwyinterface.*;
import com.infosys.ci.common.CIUserInfo;
import com.infosys.ci.common.Fees;
import com.infosys.ci.common.FIIncidentInfo;
import com.infosys.ci.cibancsconnect.accounts.common.*;

/*TRACKER# 60197*** BEGIN OF CHANGES ***/
//import com.infosys.bankaway.accesslayer.fundstransfer.*;
/*TRACKER# 60197*** END OF CHANGES ***/
/* Files to be imported to send messages to Op-Console */
import com.infy.cis.common.CRMOpConsoleErrCodes;
import com.infy.cis.common.CRMOpConsoleErrMessages;
import com.infy.cis.opc.BCOpConsoleLogMgr;
import java.text.SimpleDateFormat;
import com.infosys.ci.ons.cistruct.CIPayPresentedBillOutputVO;

import com.infosys.bankaway.accesslayer.bwyinterface.*;
import com.infosys.ci.ons.cistruct.*;
import com.infosys.ci.common.Amount;
 /* SIT10202 Change - BEGIN */
import java.util.Date;
import java.util.Calendar;
import com.infy.cis.common.SRMFormatter;
 /* SIT10202 Change - END */

public class OnlineRequest{

	/*
	 * The method calls the BankAway beans for online account balance details.
	 *
	 * @param IncidentID - Incident Id
	 * @param strAccountNumber - Finacle Account number
 	 * @param accBranchCode - Finacle Branch Code
	 * @param applCurrency - Finacle Currency
	 * @param accountType - Finacle Account Type (ex. TDA , LAA)
	 * @param orgID - Org Id
	 * @param reqBO - Request BO object
	 * @param bc - SRMBusiness Context
	 * @return void
	 * @exception SRMPreWriteException - This exception is thrown from the prewrite method of the BO hook file.
	 */
	public static void proceedForAccountBalance(		Integer IncidentID
																	,	String strAccountNumber
																	,	String accBranchCode
																	,	String applCurrency
																	,	String accountType
																	,	Integer orgID
																	,	RequestBO reqBO
																	,	SRMBusinessContext bc
																	) throws SRMPreWriteException{

		//	Output object from EJB wrapper class
		//AccessAccountSummaryVO  acctSummary=new AccessAccountSummaryVO ();

		try{
			/// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
			String orgKey = CommonQueryFunctions.getOrgKey (orgID, bc);
			/// NCB_226, TRACKER# 51444, END OF CHANGES
			//CRM70SIT Commented temporariy as the signature changes are not yet done
			/*acctSummary = BankAwayEJBCalls.getAccountBalanceFromBean( strAccountNumber
																													,  accBranchCode
																													,	applCurrency
																													,	 accountType
																										/// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
																										///			,	orgID.toString());
																													,	orgKey	);
			*/																							/// NCB_226, TRACKER# 51444, END OF CHANGES
		}catch(AccessLayerNonFatalException e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_GENERAL_FETCH,'W',CRMOpConsoleErrMessages.ERR_ONLINE_GENERAL_FETCH + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
			throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBNONFATAL , e);
		}catch(AccessLayerFatalException e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_GENERAL_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_ONLINE_GENERAL_INTERNAL + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
			throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
		}catch(Exception e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_GENERAL_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_ONLINE_GENERAL_INTERNAL + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
			throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
		}

		try{
			String strLineSeparator			= System.getProperty("line.separator");
			String strAccountTypeTDA			= "TDA";
			String strAccountTypeLAA			= "LAA";
			double Ledgerbal = 0.0;//acctSummary.getBalance1();
			double FFDbal  = 0.0;//acctSummary.getBalance2();
			StringBuffer notes = new  StringBuffer();


			String AccType = "";//acctSummary.getAccountType();
			notes.append("Account Number: "+ strAccountNumber);
			notes.append(strLineSeparator);
			notes.append("Currency: "+ applCurrency);
			notes.append(strLineSeparator);
			notes.append(strLineSeparator);
			notes.append("Ledger Balance:"+Ledgerbal);
			notes.append(strLineSeparator);
			notes.append("Avail + FFD Balance:"+FFDbal);
			notes.append(strLineSeparator);

			if(AccType.equalsIgnoreCase(strAccountTypeTDA)){
				double MaturityAmount  = 0.0;//acctSummary.getUserDefinedBalance1();
				double DepositAmount  = 0.0;//acctSummary.getUserDefinedBalance3();
				notes.append("Maturity Amount:"+MaturityAmount);
				notes.append(strLineSeparator);
				notes.append("Deposit Amount:"+DepositAmount);
				notes.append(strLineSeparator);
			}else{
				if(AccType.equalsIgnoreCase(strAccountTypeLAA)){
				double SanctionLimit  = 0.0;//acctSummary.getUserDefinedBalance1();
				notes.append("Sanction Limit:"+SanctionLimit );
				notes.append(strLineSeparator);
			}else{
				double Floatbal = 0.0;//acctSummary.getUserDefinedBalance4();
				double FFDbalance = 0.0;//acctSummary.getUserDefinedBalance5();
				notes.append("Float Balance:"+Floatbal );
				notes.append(strLineSeparator);
				notes.append("FFD Balance:"+FFDbalance);
			}
			}


			//Setting te Additional Notes attribute of the Incident with the response from Bean
			CommonQueries.UpdateIncident( bc , IncidentID , "Closed" , null , notes.toString() , null , false , null , null );
			//Setting  the UserStrField100 to the value "Display" so that after the saving the main form should not close
			reqBO.setOnlineAttribute("Display");

			StringBuffer sbfOutput = new StringBuffer();
			sbfOutput.append("<HTML>");
			sbfOutput.append("<Title>Account Balance</Title><Head>");
			sbfOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMTableDisplay.css'/>");
			sbfOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/Popup.css'/>");
			sbfOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMListTemplate.css'/>");

			sbfOutput.append("</Head><body class='popup'><br>");
			sbfOutput.append("<br>");
			sbfOutput.append("<br>");


			sbfOutput.append("<table cellPadding=0 cellSpacing=1  align=center class=\"background\" width=\"100%\">");
			sbfOutput.append("<tr> <td align=center class=\"tableHeader\" width=\"100%\">Account Balance Details</td></tr></table><br>");

			sbfOutput.append("Account Number: "+ strAccountNumber);
			sbfOutput.append("<br>");
			sbfOutput.append("Currency: "+ applCurrency);
			sbfOutput.append("<br><br>");
			sbfOutput.append("<table cellPadding=0 cellSpacing=1 border=true align=center class=\"background\">");
			sbfOutput.append("<tr><td align=left class=\"tableHeader\">Ledger Balance</td>");
			sbfOutput.append("<td align=left class=\"fntColData\">"+Ledgerbal+ "</td></tr>");
			sbfOutput.append("<tr><td align=left class=\"tableHeader\">Avail + FFD Balance</td>");
			sbfOutput.append("<td align=left class=\"fntColData\">"+FFDbal+ "</td></tr>");

			if(AccType.equalsIgnoreCase(strAccountTypeTDA)){
				double MaturityAmount  = 0.0;//acctSummary.getUserDefinedBalance1();
				double DepositAmount  = 0.0;//acctSummary.getUserDefinedBalance3();
				sbfOutput.append("<tr><td align=left class=\"tableHeader\">Maturity Amount</td>");
				sbfOutput.append("<td align=left class=\"fntColData\">"+MaturityAmount+ "</td></tr>");
				sbfOutput.append("<tr><td align=left class=\"tableHeader\">Deposit Amount</td>");
				sbfOutput.append("<td align=left class=\"fntColData\">"+DepositAmount+ "</td></tr></table>");
			}else{
				if(AccType.equalsIgnoreCase(strAccountTypeLAA)){
				double SanctionLimit  = 0.0;//acctSummary.getUserDefinedBalance1();
				sbfOutput.append("<tr><td align=left class=\"tableHeader\">Sanction Limit</td>");
				sbfOutput.append("<td align=left class=\"fntColData\">"+SanctionLimit+ "</td></tr></table>");
			}else{
				double Floatbal = 0.0;//acctSummary.getUserDefinedBalance4();
				double FFDbalance =0.0;// acctSummary.getUserDefinedBalance5();
				sbfOutput.append("<tr><td align=left class=\"tableHeader\">Float Balance</td>");
				sbfOutput.append("<td align=left class=\"fntColData\">"+Floatbal+ "</td></tr>");
				sbfOutput.append("<tr><td align=left class=\"tableHeader\">FFD Balance</td>");
				sbfOutput.append("<td align=left class=\"fntColData\">"+FFDbalance+ "</td></tr></table>");
			}
			}
			reqBO.setUserTextField5(sbfOutput.toString());
		}catch(Exception e){
			throw new SRMPreWriteException( SRMBOException.ERROR_INSIDE_HOOK , e);
		}
	}

	/*
	 * The method calls the BankAway beans for online last 10 transaction details.
	 *
	 * @param IncidentID - Incident Id
	 * @param strAccountNumber - Finacle Account number
 	 * @param accBranchCode - Finacle Branch Code
	 * @param applCurrency - Finacle Currency
	 * @param accountType - Finacle Account Type (ex. TDA , LAA)
	 * @param orgID - Org Id
	 * @param reqBO - Request BO object
	 * @param bc - SRMBusiness Context
	 * @return void
	 * @exception SRMPreWriteException - This exception is thrown from the prewrite method of the bo hook  file.
	 */

	public static void  proceedForLast10Txn(		Integer IncidentID
																,	String strAccountNumber
																,	String accBranchCode
																,	String applCurrency
																,	String accountType
																,	Integer orgID
																,	RequestBO reqBO
																,	SRMBusinessContext bc
																) throws SRMPreWriteException{
		//AccessAccountStatementVO transactionHistoryVect = null;//new AccessAccountStatementVO();
		//AccessAccountTransactionVO transactionSummary = null;//new AccessAccountTransactionVO();
		try{
			/// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
			String orgKey = CommonQueryFunctions.getOrgKey (orgID, bc);
			/// NCB_226, TRACKER# 51444, END OF CHANGES
			//CRM70SIT Commented temporariy as the signature changes are not yet done
			/*transactionHistoryVect = BankAwayEJBCalls.getLast10TxnFromBean( strAccountNumber
																														, accBranchCode
																														,	applCurrency
																														,	accountType
																											/// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
																											///			,	orgID.toString());
																														,	orgKey	);
																											/// NCB_226, TRACKER# 51444, END OF CHANGES
			*/
		}catch(AccessLayerNonFatalException e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_GENERAL_FETCH,'W',CRMOpConsoleErrMessages.ERR_ONLINE_GENERAL_FETCH + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
			throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBNONFATAL , e);
		}catch(AccessLayerFatalException e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_GENERAL_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_ONLINE_GENERAL_INTERNAL + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
			throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
		}catch(Exception e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_GENERAL_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_ONLINE_GENERAL_INTERNAL + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
			throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
		}

		try{

			String strLineSeparator			=	 System.getProperty("line.separator");
			StringBuffer notes = new  StringBuffer();
			int index;
			int printIndex;
			StringBuffer sbfHtmlOutput = new StringBuffer();
			//Forming the html string for out put - start
			sbfHtmlOutput.append("<HTML>");
			sbfHtmlOutput.append("<Title>last 10 Transaction</Title><Head>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMTableDisplay.css'/>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/Popup.css'/>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMListTemplate.css'/>");
			sbfHtmlOutput.append("</Head><body class='popup'><br>");
			sbfHtmlOutput.append("<br>");
			sbfHtmlOutput.append("<br>");
			sbfHtmlOutput.append("<b>Account Number: "+ strAccountNumber+"</b>");
			sbfHtmlOutput.append("<br>");

			sbfHtmlOutput.append("<table cellPadding=0 cellSpacing=1 border=true align=center class=\"background\" width=\"100%\">");
			sbfHtmlOutput.append("<tr> <td align=center class=\"tableHeader\" width=\"100%\">Last Ten Transaction Details</td></tr></table>");
			sbfHtmlOutput.append("<table border=true><tr><td align=left class=\"tableHeader\">Sl. No.</td>");
			sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Transaction Serial Number</td>");
			sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Original Amount</td>");
			sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Transaction Amount</td>");
			sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Transaction Balance</td>");
			sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Transaction Date</td></tr>");

			notes.append("Account Number: "+ strAccountNumber);
			notes.append(strLineSeparator);
			notes.append("Currency: "+ applCurrency);
			notes.append(strLineSeparator);
			notes.append(strLineSeparator);

			/*for ( index = 0 ; index<transactionHistoryVect.size() ; index++){
				transactionSummary=(AccessAccountTransactionVO)transactionHistoryVect.get(index);
				printIndex = index + 1;
				notes.append("Sl. No.: "+ printIndex );
				notes.append(strLineSeparator);
				notes.append("Original Amount:"+transactionSummary.getOrgAmt());
				notes.append("    , ");
				notes.append("Transaction Amount:"+transactionSummary.getTxnAmt());
				notes.append("    , ");
				notes.append("Transaction Balance:"+transactionSummary.getTxnBalance());
				notes.append("    , ");
				notes.append("Transaction Date:"+transactionSummary.getTxnDate());
				notes.append("    , ");
				notes.append("Transaction Serial Number:"+transactionSummary.getTxnSrlNo());
				notes.append(strLineSeparator);
				notes.append(strLineSeparator);

				sbfHtmlOutput.append("<tr><td align=center class=\"tableHeader\">"+printIndex+ "</td>");

				sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+transactionSummary.getTxnSrlNo()+ "</td>");
				sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+transactionSummary.getOrgAmt() + "</td>");
				sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+transactionSummary.getTxnAmt()+ "</td>");
				sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+transactionSummary.getTxnBalance()+ "</td>");
				sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+transactionSummary.getTxnDate()+ "</td></tr>");
			}*/
			sbfHtmlOutput.append("</table></br>");
			//Forming the html string for out put - end
			//Setting te Additional Notes attribute of the Incident with the response from Bean
			CommonQueries.UpdateIncident( bc , IncidentID , "Closed" , null , notes.toString() , null , false , null , null );
			//Setting  the UserStrField100 to the value "Display" so that after the saving the main form should not close
			reqBO.setOnlineAttribute("Display");

			reqBO.setUserTextField5(sbfHtmlOutput.toString());
		}catch(Exception e){
			throw new SRMPreWriteException( SRMBOException.ERROR_INSIDE_HOOK , e);
		}
	}

	/*
	 * The method calls the BankAway beans for online bill payment.
	 *
	 * @param IncidentID - Incident Id
	 * @param strAccountNumber - Finacle Account number
 	 * @param accBranchCode - Finacle Branch Code
	 * @param applCurrency - Finacle Currency
	 * @param accountType - Finacle Account Type (ex. TDA , LAA)
	 * @param orgID - Org Id
	 * @param reqBO - Request BO object
	 * @param bc - SRMBusiness Context
	 * @param startDate - Start date of the incident/Service Request
	 * @return void
	 * @exception SRMPreWriteException - This exception is thrown from the prewrite method of the bo hook  file.
	 */
	public static void proceedForBillPayment(	Integer IncidentID
																,	String strAccountNumber
																,	String accBranchCode
																,	String applCurrency
																,	String accountType
																,	Integer orgID
																,	RequestBO reqBO
																,	SRMBusinessContext bc
																,	Date startDate
																	,   String caseID
																) throws SRMPreWriteException{
			CIAdhocPaymentOutputVO payOutputVO=new CIAdhocPaymentOutputVO();
		String strLineSeparator			= System.getProperty("line.separator");
		String strHyphen						= "-";

		String strMakeHotPayment = reqBO.getUserStrField16();
		String strAddtoPayeeList = reqBO.getUserStrField17();
		if(reqBO.getUserStrField17() == null)
		{
			strAddtoPayeeList = "N";
		}
		if( reqBO.getUserStrField1() == null || String.valueOf(reqBO.getUserStrField1()).trim() == "" ){
			Exception e = new FCRMGenericException(new Exception("The Pay to field inside prewrite method is null."));
			throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
		}

		String strPayTo = reqBO.getUserStrField1();

		int indexOfHyphen = strPayTo.trim().lastIndexOf(strHyphen) + 1;
		strPayTo = strPayTo.trim().substring(indexOfHyphen);

		if( reqBO.getUserAmountField1() == null){
			Exception e = new FCRMGenericException(new Exception("The bill payment amount inside prewrite method is null."));
			throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
		}

		 if( reqBO.getUserStrField18() == null || reqBO.getUserStrField18().trim() == "" ){
			Exception e = new FCRMGenericException(new Exception("The currency field inside prewrite method is null."));
			throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
		}





		if( reqBO.getUserStrField2() == null || String.valueOf(reqBO.getUserStrField2()).trim() == "" ){
			Exception e = new FCRMGenericException(new Exception("The consumer code  inside prewrite method is null."));
			throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
		}

		String strConsumerCode = 	reqBO.getUserStrField2();
		String strNoOfPayments = null;
		String strPaymentFreq = null;
		java.sql.Timestamp ScheduledDate = null;


		if ( reqBO.getUserStrField16() == null ){

			if( reqBO.getUserStrField14() == null || reqBO.getUserStrField14().trim() == "" ){
				Exception e = new FCRMGenericException(new Exception("The No. of Payments inside prewrite method is null."));
				throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
			}
			strNoOfPayments = reqBO.getUserStrField14();

				if( reqBO.getUserStrField13() == null || reqBO.getUserStrField13().trim() == "" ){
				Exception e = new FCRMGenericException(new Exception("The Payment Frequency  inside prewrite method is null."));
				throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
			}

			strPaymentFreq = reqBO.getUserStrField13();

			Date SchDate = SRMDate.getLocaltimeFromGMT( startDate );
			long time = SchDate.getTime();
			ScheduledDate = new java.sql.Timestamp(time);
			strMakeHotPayment = "N";

		}
			String strTxnCurrency = 	reqBO.getUserStrField18();
			Double BillPayAmt = reqBO.getUserAmountField1();




		try{
			/// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
			String orgKey = CommonQueryFunctions.getOrgKey (orgID, bc);



				payOutputVO = BankAwayEJBCalls.PaymentThroughBean( strAccountNumber
																										,	accBranchCode
																										,	strTxnCurrency
																										,	BillPayAmt.doubleValue()
																										,	strPayTo.trim()
																							/// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
																							///			,	orgID.toString()
																										,	orgKey
																							/// NCB_226, TRACKER# 51444, END OF CHANGES
																										,	strNoOfPayments
																										,	strPaymentFreq
																,	startDate
																										,	strConsumerCode
																										,	strMakeHotPayment
																, 	strAddtoPayeeList
																,   caseID);
		}catch(AccessLayerNonFatalException e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_BANKAWAY_FETCH,'E',CRMOpConsoleErrMessages.ERR_BANKAWAY_FETCH,'L',bc);
			/* Message has been sent to Op-Console */
			throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBNONFATAL , e);
		}catch(AccessLayerFatalException e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_BANKAWAY_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_BANKAWAY_INTERNAL,'L',bc);
			/* Message has been sent to Op-Console */
			throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
		}catch(Exception e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_BANKAWAY_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_BANKAWAY_INTERNAL,'L',bc);
			/* Message has been sent to Op-Console */
			throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
		}

		StringBuffer notes = new  StringBuffer();
		//notes.append("Payee List Id:"+payOutputVO.getPayeeListId());
		notes.append(strLineSeparator);
		//notes.append("Reference Id:"+payOutputVO.getReferenceId());
		notes.append(strLineSeparator);
		//notes.append("Schedule Id:"+payOutputVO.getScheduleId());
		//Setting te Additional Notes attribute of the Incident with the response from Bean
		try{
			CommonQueries.UpdateIncident( bc , IncidentID , "Closed" , null , notes.toString() , null , false , null , null );
			//Setting  the UserStrField100 to the value "Display" so that after the saving the main form should not close
			reqBO.setOnlineAttribute("Display");

			StringBuffer sbfHtmlOutput = new StringBuffer();
			sbfHtmlOutput.append("<HTML>");
			sbfHtmlOutput.append("<Title>Bill Payment Details</Title><Head>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMTableDisplay.css'/>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/Popup.css'/>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMListTemplate.css'/>");
			sbfHtmlOutput.append("</Head><body class='popup'><br>");
			sbfHtmlOutput.append("<br>");
			sbfHtmlOutput.append("<br>");
			sbfHtmlOutput.append("<b>Debit Account Number: "+ strAccountNumber+"</b>");
			sbfHtmlOutput.append("<br>");

			sbfHtmlOutput.append("<table cellPadding=0 cellSpacing=1 border=true align=center class=\"background\" width=\"100%\">");
			sbfHtmlOutput.append("<tr> <td align=center class=\"tableHeader\" width=\"100%\">Bill Payment Details</td></tr></table>");
			sbfHtmlOutput.append("<table border=true align=center>");
			sbfHtmlOutput.append("<tr><td align=left class=\"tableHeader\">Payee List Id</td>");
			sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Reference Id</td>");
			sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Schedule Id</td></tr>");

			//sbfHtmlOutput.append("<tr><td align=left class=\"fntColData\">"+payOutputVO.getPayeeListId()+ "</td>");
			//sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+payOutputVO.getReferenceId()+ "</td>");
			//sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+payOutputVO.getScheduleId()+ "</td></tr>");

			sbfHtmlOutput.append("</table></br>");
			//Forming the html string for out put - end
			reqBO.setUserTextField5(sbfHtmlOutput.toString());
		}catch(Exception e){
			throw new SRMPreWriteException( SRMBOException.ERROR_INSIDE_HOOK , e);
		}
	}


		/*TRACKER# 60196 BEGIN CHANGES*/

		/*
		 * The method calls the BankAway beans for online placing funds .
		 *
		 * @param IncidentID - Incident Id
		 * @param strAccountNumber - Finacle Account number
	 	 * @param accBranchCode - Finacle Branch Code
		 * @param applCurrency - Finacle Currency
		 * @param accountType - Finacle Account Type (ex. TDA , LAA)
		 * @param crmcustid - CRM Cust ID
		 * @param reqBO - Request BO object
		 * @param bc - SRMBusiness Context
		 * @param startDate - Start date of the incident/Service Request
		 * @return void
		 * @exception SRMPreWriteException - This exception is thrown from the prewrite method of the bo hook  file.
		 */
		public static void proceedForFundsPlacement(	Integer IncidentID ,
														String strAccountNumber ,
														String accBranchCode ,
														String applCurrency ,
														String accountType ,
														String crmcustid ,
														RequestBO reqBO ,
														SRMBusinessContext bc ,
														Date startDate
													 ) throws SRMPreWriteException{
			//OnlinePaymentsOutputVO payOutputVO = new OnlinePaymentsOutputVO();

			String strLineSeparator			= System.getProperty("line.separator");
			String strHyphen						= "-";
			if( reqBO.getUserStrField1() == null || String.valueOf(reqBO.getUserStrField1()).trim() == "" ){
				Exception e = new FCRMGenericException(new Exception("The pay to field is null."));
				throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
			}

			String strPayTo = reqBO.getUserStrField1();
			String strMakeHotPayment = reqBO.getUserStrField5();
			String strPaymentRemarks = reqBO.getUserTextField1();

			int indexOfHyphen = strPayTo.trim().lastIndexOf(strHyphen) + 1;
			strPayTo = strPayTo.trim().substring(indexOfHyphen);

			if( reqBO.getUserAmountField1() == null){
				Exception e = new FCRMGenericException(new Exception("The funds amount is null."));
				throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
			}

			 if( reqBO.getUserStrField4() == null || reqBO.getUserStrField4().trim() == "" ){
				Exception e = new FCRMGenericException(new Exception("The currency field is null."));
				throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
			}
			String strTxnCurrency = 	reqBO.getUserStrField4();

			Double BillPayAmt = reqBO.getUserAmountField1();


			if( reqBO.getUserStrField2() == null || String.valueOf(reqBO.getUserStrField2()).trim() == "" ){
				Exception e = new FCRMGenericException(new Exception("The for account number is null."));
				throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
			}

			String strConsumerCode = 	reqBO.getUserStrField2();
			String isThirdParty = reqBO.getUserStrField3();
			try{
				if(isThirdParty.equals("N")){
					/*IncidentBO inciBO = null;
					try{
						SRMQueryBuilder qb = QueryAssist.singleObjectQuery("IncidentBO", IncidentBO.INCIDENTID);
						QueryAssist.addSimpleCondition(qb, "IncidentBO", IncidentBO.INCIDENTID,
																 IQuery.ComparisonOperation_EQ, ""+IncidentID);
						SRMQueryResult qr = qb.runQuery(bc, -1);
						SRMRecordSet rs = qr.getRecordSet();
						if(rs.size() > 0 ) {
							inciBO = (IncidentBO)rs.getNext().get(0);
						}
					}catch(Exception e){
						throw new SRMPreWriteException(SRMBOException.ERROR_INVALID_ATTRIB_VALUE , e);
					}*/


					/*payOutputVO = BankAwayEJBCalls.PaymentThroughBean( strAccountNumber ,
																		 accBranchCode ,
																		 strTxnCurrency ,
																		 BillPayAmt.doubleValue() ,
																		 strPayTo.trim() ,
																		 crmcustid ,
																		 strConsumerCode ,
																		 strMakeHotPayment ,
																		 strPaymentRemarks
																		);

					*/
					//Setting te Additional Notes attribute of the Incident with the response from Bean
					StringBuffer notes = new  StringBuffer();
					//notes.append("Payee List Id:"+payOutputVO.getPayeeListId());
					notes.append(strLineSeparator);
					//notes.append("Reference Id:"+payOutputVO.getReferenceId());
					notes.append(strLineSeparator);
					//notes.append("Schedule Id:"+payOutputVO.getScheduleId());
					/*
					ProcessBO onlineProcess = Processes.findProcessBO("Process for Online Request",bc);
					inciBO.setProcessID(onlineProcess.getProcessID());
					inciBO.setCurrentStep( new Integer(1));
					SRMDataObject.write(inciBO, bc);
					*/
					CommonQueries.UpdateIncident( bc , IncidentID , "Closed" , null , notes.toString() , null , false , null , null );
					//Setting  the UserStrField100 to the value "Display" so that after the saving the main form should not close
					reqBO.setOnlineAttribute("Display");

					StringBuffer sbfHtmlOutput = new StringBuffer();
					sbfHtmlOutput.append("<HTML>");
					sbfHtmlOutput.append("<Title>Fund Placement Details</Title><Head>");
					sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMTableDisplay.css'/>");
					sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/Popup.css'/>");
					sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMListTemplate.css'/>");
					sbfHtmlOutput.append("</Head><body class='popup'><br>");
					sbfHtmlOutput.append("<br>");
					sbfHtmlOutput.append("<br>");
					sbfHtmlOutput.append("<b>Debit Account Number: "+ strAccountNumber+"</b>");
					sbfHtmlOutput.append("<br>");

					sbfHtmlOutput.append("<table cellPadding=0 cellSpacing=1 border=true align=center class=\"background\" width=\"100%\">");
					sbfHtmlOutput.append("<tr> <td align=center class=\"tableHeader\" width=\"100%\">Fund Placement Details</td></tr></table>");
					sbfHtmlOutput.append("<table border=true align=center>");
					sbfHtmlOutput.append("<tr><td align=left class=\"tableHeader\">Payee List Id</td>");
					sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Reference Id</td>");
					sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Schedule Id</td></tr>");

					//sbfHtmlOutput.append("<tr><td align=left class=\"fntColData\">"+payOutputVO.getPayeeListId()+ "</td>");
					//sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+payOutputVO.getReferenceId()+ "</td>");
					//sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+payOutputVO.getScheduleId()+ "</td></tr>");

					sbfHtmlOutput.append("</table></br>");
					//Forming the html string for out put - end
					reqBO.setUserTextField5(sbfHtmlOutput.toString());
				}
			}catch(AccessLayerNonFatalException e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_BANKAWAY_FETCH,'E',CRMOpConsoleErrMessages.ERR_BANKAWAY_FETCH,'L',bc);
			/* Message has been sent to Op-Console */
				throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBNONFATAL , e);
			}catch(AccessLayerFatalException e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_BANKAWAY_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_BANKAWAY_INTERNAL,'L',bc);
			/* Message has been sent to Op-Console */
				throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
			}catch(Exception e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_BANKAWAY_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_BANKAWAY_INTERNAL,'L',bc);
			/* Message has been sent to Op-Console */
				throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
			}
	}

	/*TRACKER# 60196 END CHANGES*/



	/*TRACKER# 60197*** BEGIN OF CHANGES ***/

	/*
	 * The method calls the BankAway beans for online bill payment.
	 *
	 * @param IncidentID - Incident Id
	 * @param strAccountNumber - Finacle Account number
	 * @param accBranchCode - Finacle Branch Code
	 * @param applCurrency - Finacle Currency
	 * @param accountType - Finacle Account Type (ex. TDA , LAA)
	 * @param crmcustid - CRM Cust ID
	 * @param reqBO - Request BO object
	 * @param bc - SRMBusiness Context
	 * @param startDate - Start date of the incident/Service Request
	 * @return void
	 * @exception SRMPreWriteException - This exception is thrown from the prewrite method of the bo hook  file.
	 */

	public static void proceedForFundsTransfer	(	Integer incidentID ,
													String fromAccNumber ,
													String fromAccBranchCode ,
													String fromAccountType ,
													String fromAccountCat ,
													String fromAccountCurrency ,
													String crmcustid ,
													RequestBO reqBO ,
													SRMBusinessContext bc ,
													Date startDate
													) throws SRMPreWriteException{

		try{
			//	Output object from EJB wrapper class
			 /* SIT10202 Change - BEGIN */
			Calendar ValueDate = Calendar.getInstance();
			//startDate = new Date("06/10/2002");
			ValueDate.setTime(startDate);
			 /* SIT10202 Change - END */
			StringBuffer notes = new  StringBuffer();

			String toAccNumber = reqBO.getUserStrField3();
			List saleslist = CommonQueryFunctions.getSalesData( toAccNumber , bc );
			if(saleslist.size() == 0){
				Exception e = new FCRMGenericException("MSGEXC0162",new Exception("Account Number {0} does not exist."),toAccNumber);
				throw new SRMPreWriteException(SRMBOException.ERROR_INSIDE_HOOK , e);
			}

			Integer isalesid = (Integer)saleslist.get(0);
			String toAccBranchCode = (String)saleslist.get(3);
			Integer prodCatID = (Integer)saleslist.get(4);
			String toAccountCat = (String)saleslist.get(1);
			List saleBackEndList = CommonQueryFunctions.getSaleBackEndData( isalesid , bc );
			String toAccCurrency = (String)saleBackEndList.get(1);
			toAccBranchCode = toAccBranchCode.trim();
			 /* SIT10202 Change - BEGIN */
			/*toAccBranchCode = CommonQueryFunctions.getDataFromRefCodeMapper( "SERVICE_OUTLET"
																			, toAccBranchCode.trim()
																			, null);*/

			String  toAccountType= CommonQueryFunctions.getAccountType( prodCatID , bc ) ;
			toAccountType = toAccountType.trim();
			 /* SIT10202 Change - END */
			/* Change for ticket : 297220 */
			SRMQueryBuilder qb1 =  new SRMQueryBuilder();
			String resultSql1="select bank_code from tbaadm.sol where sol_id = (select accbranchcode from sales where accountnumber like '"+toAccNumber+"')";
			ArrayList arrDum = new ArrayList();
			String toBankID = "";
			arrDum.add("String");
			SRMQueryResult qr1 = qb1.runQuery(bc,resultSql1,arrDum);
			SRMRecordSet rs1 = qr1.getRecordSet();
			while (rs1!=null && rs1.hasNext()) {
						toBankID=((ArrayList)rs1.getNext()).get(0).toString();
			}
			 /* Change for ticket 297220 : END */
			saleslist = CommonQueryFunctions.getSalesData( fromAccNumber , bc );
			isalesid = (Integer)saleslist.get(0);
			saleBackEndList = CommonQueryFunctions.getSaleBackEndData( isalesid , bc );
			Date d1 = (Date)saleBackEndList.get(3);

			String Txn_Crncy = 	reqBO.getUserStrField1();
			Double Txn_Amount = reqBO.getUserAmountField1();
			String isThirdParty = reqBO.getUserStrField11();

			if(isThirdParty.equals("N")){
				IncidentBO inciBO = null;
				try{
					SRMQueryBuilder qb = QueryAssist.singleObjectQuery("IncidentBO", IncidentBO.INCIDENTID);
					QueryAssist.addSimpleCondition(qb, "IncidentBO", IncidentBO.INCIDENTID,
															 IQuery.ComparisonOperation_EQ, ""+incidentID);
					SRMQueryResult qr = qb.runQuery(bc, -1);
					SRMRecordSet rs = qr.getRecordSet();
					if(rs.size() > 0 ) {
						inciBO = (IncidentBO)rs.getNext().get(0);
					}
				}catch(Exception e){
					throw new SRMPreWriteException(SRMBOException.ERROR_INVALID_ATTRIB_VALUE , e);
				}
				 /* SIT10202 Change - BEGIN */
				ProcessFTOutputVO opProc = BankAwayEJBCalls.doFundTransfer( fromAccNumber ,
															fromAccBranchCode ,
															Txn_Crncy ,
															fromAccountType ,
															fromAccountCat ,
															fromAccountCurrency ,
															toAccNumber ,
															toAccBranchCode,
															toAccountType ,
															toAccountCat ,
															toAccCurrency ,
															Txn_Amount.doubleValue() ,
															crmcustid ,
															isThirdParty,
															inciBO.getCaseID(),
															ValueDate,
															toBankID
														) ;
				//Tracker id 149452 starts
				ProcessBO onlineProcess = Processes.findProcessBO("Account To Account Transfer-10.2",bc);
				/* SIT10202 Change - END */
				//Tracker id 149452 ends
				inciBO.setProcessID(onlineProcess.getProcessID());
				inciBO.setCurrentStep( new Integer(1));
				SRMDataObject.write(inciBO, bc);

				FIIncidentInfo fIIncidentInfo =  opProc.getFIIncidentInfo();
					notes.append("Fund Transfer from account number "+fromAccNumber);
					notes.append(" to account number "+toAccNumber + " successfull!");
					CommonQueries.UpdateIncident( bc , incidentID , "Closed" , null , notes.toString() , null , false , null , null );
					/*FIN71SIT :64314 Tracker
					CommonQueries.UpdateIncident(bc, incidentID, "Closed", new Integer(1), notes.toString() , "" + fIIncidentInfo.getDccReqRefNum(), false, null, null);

				} else {
				notes.append("Error ");
					CommonQueries.UpdateIncident( bc , incidentID , "Closed" , null , "Error :"+notes.toString() , null , false , null , null );
					/*FIN71SIT :64314 Tracker
					CommonQueries.UpdateIncident(bc, incidentID, "Closed", new Integer(1), notes.toString() , "" + fIIncidentInfo.getDccReqRefNum(), false, null, null);
				}	 */

				//Forming the html string for out put - end
				//Setting te Additional Notes attribute of the Incident with the response from Bean
				//Setting  the UserStrField100 to the value "Display" so that after the saving the main form should not close
				reqBO.setOnlineAttribute("Display");
				reqBO.setUserTextField5(getHTML(notes.toString()));
			}
		}catch(AccessLayerFatalException e){
			BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_BANKAWAY_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_BANKAWAY_INTERNAL,'L',bc);
			throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
		}catch(Exception e){
			/* Change for ticket 297283 : Begin */
			if((e.getMessage().indexOf("Insufficient Funds") != -1)){
				throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , new FCRMGenericException(new Exception("Insufficient Funds")));
			}else{
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_BANKAWAY_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_BANKAWAY_INTERNAL,'L',bc);
				throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
			}
		}
		/* Change for ticket 297283 : End */

	}

	/*
	 * The method calls the BankAway beans for stop payment on Cheque
	 *
	 * @param IncidentID - Incident Id
	 * @param strAccountNumber - Account number
	 * @param accBranchCode - Branch Code
	 * @param crmcustid - CRM Cust ID
	 * @param reqBO - Request BO object
	 * @param bc - SRMBusiness Context
	 * @param stepID - Step ID
	 * @return void
	 * @exception SRMPreWriteException - This exception is thrown from the prewrite method of the bo hook  file.
	 */
	public static void stopCheck(	Integer IncidentID ,
									String strAccountNumber ,
									String accBranchCode ,
									String crmcustid ,
									RequestBO reqBO ,
									SRMBusinessContext bc ,
									Integer stepID,
									String CaseID
								) throws SRMPreWriteException {

		String strLineSeparator			= System.getProperty("line.separator");
		String strHyphen						= "-";


		if( reqBO.getUserStrField1() == null || String.valueOf(reqBO.getUserStrField1()).trim() == "" ){
			Exception e = new FCRMGenericException(new Exception("The Reason Code field is null."));
			throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
		}

		if( reqBO.getUserStrField2() == null || String.valueOf(reqBO.getUserStrField2()).trim() == "" ){
			Exception e = new FCRMGenericException(new Exception("The Cheque Number field is null."));
			throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
		}

		String reasonCode = reqBO.getUserStrField1();
		String checkNumber = reqBO.getUserStrField2();

		try{
			/* SIT10202 Change - BEGIN */
			//reasonCode = CommonQueryFunctions.getDataFromRefCodeMapper( "STOP_PAYMENT_REASON_CODE",
					//													reasonCode.trim(),
				//														null);
			/* SIT10202 Change - END */
			reasonCode = reasonCode.trim();
		}catch(Exception e) {
			System.err.println(e.getMessage());
			e.printStackTrace();
			throw new SRMPreWriteException( SRMBOException.ERROR_INSIDE_HOOK , e);
		}
		//BankAwayRemoteAccess actacess = new BankAwayRemoteAccess();
        AccountTransactionALImplementation acctTranALImp = new AccountTransactionALImplementation();
		//StopChequeDetailsInputVO stopChequeDetails=new StopChequeDetailsInputVO();
        StopChequeDetails stopChequeDetails = new StopChequeDetails();
        Fees fees = new Fees();//stopChequeDetails.getFees();
        com.infosys.ci.common.Amount feesAmt = new com.infosys.ci.common.Amount();
		feesAmt.setAmountValue(0.0);
        fees.setFeesamount(feesAmt);

		//AccessLayerUserInfo userInfo = new AccessLayerUserInfo();
        CIUserInfo CIU = new CIUserInfo();
        CIU.setChannelType("CRM");

		String bankID = (String)com.infy.cis.common.SRMTLVar.bank_id.get();

        	CIU.setBankId(bankID);




        stopChequeDetails.setAcid(strAccountNumber);
		stopChequeDetails.setBranchId(accBranchCode);
		stopChequeDetails.setBeginChequeNumber(checkNumber);
		stopChequeDetails.setReasonCode(reasonCode);
		stopChequeDetails.setFees(fees);
		/* SIT10202 Change - BEGIN */
		stopChequeDetails.setNumberOfCheques(1);
		/* SIT10202 Change - END */
		FIIncidentInfo fiIncidentInfo= new FIIncidentInfo();

		fiIncidentInfo.	setDccReqRefNum(CaseID);

		/* 10.1 RECON Changes by mukundhan_santhanam (79625)*/

		/*SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss.S");
		 Date currentTime_1 = new Date();
		String dateString = formatter.format(currentTime_1);
		fiIncidentInfo.	setDccReqOrigTime(dateString);*/
		fiIncidentInfo.setDccReqOrigTime(getDateFormatforFIServReq());
		// End of 10.1 RECON Changes

		try{
			/*userInfo.setAccessChannelId("P");
			userInfo.setAccessCorpId(crmcustid);;
			userInfo.setAccessUserId("CRM");
			userInfo.setCorpId(crmcustid);
			userInfo.setUserId(crmcustid);
			userInfo.setApplicationId("BWY");
			userInfo.setCertificateMatched(true);
			userInfo.setCertificatePresented(true);
			userInfo.setUserDateFormat(03);*/

			stopChequeDetails.setFIIncidentInfo(fiIncidentInfo);
			acctTranALImp.stopCheque(CIU,stopChequeDetails);
		// Tracker 181580 - Starts
		}catch(Exception e){
					if((e.getMessage().indexOf("Invalid Cheque Number") != -1))
					{
						throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , new FCRMGenericException(new Exception("Invalid Cheque Number")));
					}
					else if((e.getMessage().indexOf("Transaction Not Allowed") != -1))
					{
						throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , new FCRMGenericException(new Exception("Transaction Not Allowed")));
					}
					else
						throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
		}
		// Tracker 181580 - Ends
		StringBuffer notes = new  StringBuffer();
		notes.append("Payment for cheque Number "+checkNumber);
		notes.append(" stopped successfully!");
		//Setting te Additional Notes attribute of the Incident with the response from Bean
		try{
			//CommonQueries.UpdateIncident( bc , IncidentID , "Open" , stepID , notes.toString() , null , true , null , null );
			/* FIN71SIT:63667 TRACKER START CHANGE */
			CommonQueries.UpdateIncident( bc , IncidentID , "Closed" , stepID , notes.toString() , null , false , null , null );
			/* FIN71SIT:63667 TRACKER START CHANGE*/
			//Setting  the UserStrField100 to the value "Display" so that after the saving the main form should not close
			reqBO.setOnlineAttribute("Display");

			StringBuffer sbfHtmlOutput = new StringBuffer();
			sbfHtmlOutput.append("<HTML>");
			sbfHtmlOutput.append("<Title>Stop Cheque Payment</Title><Head>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMTableDisplay.css'/>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/Popup.css'/>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMListTemplate.css'/>");
			sbfHtmlOutput.append("</Head><body class='popup'><br>");
			sbfHtmlOutput.append("<br>");
			sbfHtmlOutput.append("<br>");
			sbfHtmlOutput.append("<b>Account Number: "+ strAccountNumber+"</b>");
			sbfHtmlOutput.append("<br>");
			sbfHtmlOutput.append("<b> Payment for Cheque Number "+checkNumber);
			sbfHtmlOutput.append("stopped successfully!</b>");
			sbfHtmlOutput.append("</body></html>");

			//Forming the html string for out put - end
			reqBO.setUserTextField5(sbfHtmlOutput.toString());




		}catch(Exception e){
			throw new SRMPreWriteException( SRMBOException.ERROR_INSIDE_HOOK , e);
		}
	}

	/*TRACKER# 60197*** END OF CHANGES ***/


	//**CRM62ENH-ONS** Tracker- 58813 change started
	public static void proceedForCustomisedRequest() throws SRMPreWriteException{
		// customised implementation place holder
	}
	//**CRM62ENH-ONS** Tracker- 58813 change ended

	/*TRACKER#60197 ***BEGIN OF CHANGES ***/
	private static String getHTML(String message) {
		/***************************10.4SPE Changes :BEGIN********************************************/
		java.util.Locale locale = ((com.infy.cis.servletruntime.CISSessionContext)com.infy.cis.common.SRMTLVar.sc.get()).getSessionLocale();
		String strLocale = locale.toString();
		/***************************10.4SPE Changes :END********************************************/
		StringBuffer sbfHtmlOutput = new StringBuffer();
		sbfHtmlOutput.append("<HTML>");
		sbfHtmlOutput.append("<Title>Online Fund Transfer </Title><Head>");
		/******************10.4SPE Changes to remove 404 error:BEGIN********************************************/
		sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMTableDisplay_"+strLocale+".css'/>");
		sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/Popup_"+strLocale+".css'/>");
		sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMListTemplate_"+strLocale+".css'/>");
		sbfHtmlOutput.append("<script type=\"text/javascript\" src=\"../Customization/js/online.js\" language=\"javascript\"></script>");
		/******************10.4SPE Changes to remove 404 error:END********************************************/
		sbfHtmlOutput.append("</Head><body class='popup'><br>");
		sbfHtmlOutput.append("<br>");
		sbfHtmlOutput.append("<br>");
		sbfHtmlOutput.append("<b><font color=\"red\"> "+message+"</font></b>");
		sbfHtmlOutput.append("<br>");
		return sbfHtmlOutput.toString();
	}
	/***CRM62ENH***TRACKER#60197 ***END OF CHANGES ***/

/* 10.1 RECON Changes by mukundhan_santhanam (79625)*/
//Function to get the DateTime format compatible with the FI call
	public static String getDateFormatforFIServReq (){
		String DateFormat= "";
		String DateFormat1= "";
		 try
			{
				////System.out.println("calling getDateFormatforFIServReq");
				//DateFormat = new java.text.SimpleDateFormat("MM-dd-yyyy HH:MM:ss.ms").format(new Date());
				DateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(new Date());
				////System.out.println("calling getDateFormatforFIServReq inside "+DateFormat);
				DateFormat1 = DateFormat.replace(' ','T');

	 	}
		catch(Exception e)
		{
			////System.out.println("inside catch block");
			//System.out.println("Exception : " + e.getMessage());
		}
		////System.out.println("returning DateFormat=="+DateFormat1);
		return DateFormat1;
	}
	// End of 10.1 RECON Changes
}




