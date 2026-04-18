/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: OnlineBalanceEnquiry.java $
 *
 * Author: Paritosh
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/OnlineBalanceEnquiry.java $
 *
 * **************************************************************************/
/**This class will be used when user wants to know the balance in his account.
    Related BankAway ejb wrpper methods will be called to fetch the balance from
    the Finacle database.
    In this class first all the necessary arguments for calling the bean wrapper methods are
    gathered.
    Then the bean is called.
    Now if the request is from a process step then the activity will be created and parent will be
    refreshed.
    If the request is from 360 degree views Accounts then the activity will not be created.
    Finally the html output is diaplayed to the bank rep.

*/

package com.infy.cis.custom;

import javax.servlet.*;
import javax.servlet.http.*;

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
import java.io.*;


import com.infy.cis.servletruntime.*;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.exception.*;
import com.infy.cis.ui.common.*;
import com.infy.cis.common.*;
import com.infy.cis.ui.sales.ActivityForm;
import com.infy.cis.custom.CommonQueryFunctions;
import com.infy.cis.common.BankAwayEJBCalls;
import com.infosys.ci.common.CIUserInfo;
import com.infosys.ci.cibancsconnect.accounts.common.*;
//import com.infosys.bankaway.accesslayer.accounts.*;
import com.infosys.ci.common.Amount;
import com.infosys.bankaway.accesslayer.user.*;
//import com.infosys.bankaway.accesslayer.bwyinterface.*;
//import com.infosys.bankaway.accesslayer.bwyinterface.BancsConnectRemoteInterface;
//import com.infosys.bankaway.accesslayer.bwyinterface.AccesLayerHostMarker;
//import com.//infosys.bankaway.accesslayer.accounts.AccessLayerAccountSummary;
import com.infosys.bankaway.accesslayer.bwyinterface.AccessLayerHostMarker;
import com.infosys.bankaway.accesslayer.bwyinterface.AccessLayerFatalException;
import com.infosys.bankaway.accesslayer.bwyinterface.AccessLayerNonFatalException;
import com.infosys.bankaway.accesslayer.bwyinterface.AccountInquiryALImplementation;
import com.infosys.ci.common.CINonFatalException;
import com.infosys.ci.common.FIIncidentInfo;
//import com.infosys.bankaway.accesslayer.bwyinterface.BancsConnectRemoteInterface;
/* Files to be imported to send messages to Op-Console */
import com.infy.cis.common.CRMOpConsoleErrCodes;
import com.infy.cis.common.CRMOpConsoleErrMessages;
import com.infy.cis.opc.BCOpConsoleLogMgr;

import com.infosys.bankaway.accesslayer.bwyinterface.*;
//Change for SIT10202 Tracker : 181186
import java.text.DecimalFormat;


public class OnlineBalanceEnquiry extends CISHttpServlet {

    public void serviceRequest ( HttpServletRequest req, HttpServletResponse resp)
    throws Exception{
        setContentType("text/html", resp);
        PrintWriter out = resp.getWriter();
        //getting bc

        SRMBusinessContext bc = Utils.getBusinessContext(req , java.sql.Connection.TRANSACTION_READ_UNCOMMITTED);
        /* ABNGC6206:TRACKER#    68406**BEGIN   CHANGES** */
		CISSessionContext sc = context.getSessionContext(req);
		SRMFormatter srmf = sc.getFormatter();
		/* ABNGC6206:TRACKER#    68406**END   CHANGES** */
        StringBuffer sbfOutput = new StringBuffer();
        final String strAccountTypeTDA = "TDA";
        final String strAccountTypeLAA = "LAA";

        String url =    req.getParameter("srmUrl");

        CIUserInfo  cUserInfo = new CIUserInfo ();

				//set channel id to CRM
		cUserInfo.setChannelType("CRM");
		/* Change for DBS Ticket 319931 by BADRI : BEGIN */
		String bankID = (String)com.infy.cis.common.SRMTLVar.bank_id.get();

			if( bankID != null || !bankID.equalsIgnoreCase("")){
					cUserInfo.setBankId(bankID);
				}else{
					cUserInfo.setBankId("01");
		}
		/* Change for DBS Ticket 319931 by BADRI : END */
		cUserInfo.setAccessChannelId("CRM");
		cUserInfo.setUserId("ABCD");
		AccountListElement accountData = new AccountListElement();
		//System.out.println(" test");


        if(url.startsWith("srmBOObj:IncidentBO")){
            try{
                /*Chopping the url and getting the Incident ID out of it.*/
                Integer  inciID =  CommonQueryFunctions.getIDFromURL(url);
                if(inciID == null){
                    throw new FCRMGenericException("MSGEXC0008",new Exception("Incident id is null in url."));
                }
                /*Getting different values from the Incident table - Start*/
                //Integer  iProcessID                   =   null;
                Integer  currentStepID              =   null;
                String  strAccountNumber        =   null;
                String strStatus                        =   null;
                Integer iSalesID                        =   null;

                List incilist = CommonQueryFunctions.getInciData(inciID,bc);
                if (incilist == null){
                    throw new FCRMGenericException("MSGEXC0009",new Exception("The incident does not exist in the database."));
                }

                if(incilist.get(2) == null ){
                    Exception e = new FCRMGenericException("MSGEXC0010",new Exception("Current step id is null for the incident"));
                    throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
                }

                if( incilist.get(3) == null || String.valueOf(incilist.get(3)).trim() == "" ){
                    Exception e = new FCRMGenericException("MSGEXC0011",new Exception("Account number is null for the incident"));
                    throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
                }

                if( incilist.get(4) == null || String.valueOf(incilist.get(4)).trim() == "" ){
                    Exception e = new FCRMGenericException("MSGEXC0012",new Exception("Status is null for the incident"));
                    throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
                }

                if( incilist.get(5) == null ){
                    Exception e = new FCRMGenericException("MSGEXC0013",new Exception("Sales id is null for the incident"));
                    throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
                }

                    //iProcessID = (Integer)incilist.get(1);
                    currentStepID = (Integer)incilist.get(2);
                    strAccountNumber = (String)incilist.get(3);
                    strStatus = (String)incilist.get(4);
                    iSalesID = (Integer)incilist.get(5);
                /*Getting different values from the Incident table - End*/

                if( !strStatus.trim().equalsIgnoreCase("Open")){
                    throw new FCRMGenericException("MSGEXC0014",new Exception("Incident is not in Open state."));
                }

                List saleslist = CommonQueryFunctions.getSalesData( strAccountNumber.trim() , bc );
                if( saleslist == null ){
                    throw new FCRMGenericException("MSGEXC0015",new Exception("The record does not exist in the database."));
                }

                //String productsKey                    = null;
                String accBranchCode                = null;
                Integer prodCatID                   = null;
                Integer orgID                           = null;

                if( saleslist.get(3) == null || String.valueOf(saleslist.get(3)).trim() == "" ){
                    Exception e = new FCRMGenericException("MSGEXC0016",new Exception("The account branch code is null for the account."));
                    throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
                }

                if( saleslist.get(4) == null ){
                    Exception e = new FCRMGenericException("MSGEXC0017",new Exception("The prod cat id is null for the account"));
                    throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
                }

                if( saleslist.get(5) == null ){
                    Exception e = new FCRMGenericException("MSGEXC0018",new Exception("The org id  is null for the account."));
                    throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
                }

                //productsKey = (String)saleslist.get(1);
                accBranchCode = (String)saleslist.get(3);
                prodCatID = (Integer)saleslist.get(4);
                orgID = (Integer)saleslist.get(5);

                /*Getting account currency from the table SaleBackEnd on the basis of SalesID - Start*/
                List saleBackEndList = CommonQueryFunctions.getSaleBackEndData( iSalesID , bc );
                if( saleBackEndList == null ){
                    Exception e = new FCRMGenericException(new Exception("The list retrieved inside prewrite method is null."));
                    throw new SRMPreWriteException(SRMBOException.ERROR_RETRIEVINGDATA , e);
                }
                String  applCurrency = null;
                if( saleBackEndList.get(1) == null || String.valueOf(saleBackEndList.get(1)).trim() == "" ){
                    Exception e = new FCRMGenericException("MSGEXC0020",new Exception("The account currency is null for the account."));
                    throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
                }
                applCurrency = (String)saleBackEndList.get(1);
                /*Getting account currency from the table SaleBackEnd on the basis of SalesID - End*/

                /*accBranchCode = CommonQueryFunctions.getDataFromRefCodeMapper( "SERVICE_OUTLET"             					, accBranchCode.trim(), null);

                if( accBranchCode == null || accBranchCode.trim().equals("")){
	                    throw new FCRMGenericException(new Exception("Account branch code retrieved from RefCodeMapper is null."));
                }
                /*getting Account type description from Prodcat table on the basis of ProdCatId-start*/
                String  accountType = CommonQueryFunctions.getAccountType( prodCatID , bc );

                if (accountType == null || accountType.trim().equals("")){
                    throw new FCRMGenericException("MSGEXC0022",new Exception("Account type description is null."));
                }
                /*accountType = CommonQueryFunctions.getDataFromRefCodeMapper( "PRODUCT_CATEGORY"             ,  accountType.trim(), null );

                if( accountType == null || accountType.trim().equals("")){
                    throw new FCRMGenericException(new Exception("Account type retrieved from RefCodeMapper is null."));
                }
                //accountType = CommonQueryFunctions.getStrWithoutSpace(accountType);

                /// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
                String orgKey = CommonQueryFunctions.getOrgKey (orgID, bc);
                /// NCB_226, TRACKER# 51444, END OF CHANGES

                //contacting the account balance ejb - start
                /*AccessAccountSummaryVO acctSummary = BankAwayEJBCalls.getAccountBalanceFromBean( strAccountNumber.trim(),   accBranchCode.trim(),   applCurrency.trim()                                ,   accountType.trim()                                                                                     /// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
                            ///         ,   orgID.toString()) ;
                                   ,   orgKey  );
			/// NCB_226, TRACKER# 51444, END OF CHANGES*/

                int iProdCatID = prodCatID.intValue();
				if(iProdCatID == Constants.PROD_CAT_LO || iProdCatID == Constants.PROD_CAT_HLO){
					accountType = Constants.LOANS1;
				} else if(iProdCatID == Constants.PROD_CAT_SB){
						//iProdCatID == Constants.PROD_CAT_CA){
					    accountType = Constants.SBCACCOD;
						accountType = Constants.SBA;
				}else if(iProdCatID == Constants.PROD_CAT_CA){
						accountType = Constants.SBA;
				} else if(iProdCatID == Constants.PROD_CAT_TDA){
						accountType = Constants.TDA;
			    }
				accountData.setBranchId(accBranchCode);
				accountData.setAcid(strAccountNumber);

				//accountData.setCrnCode(applCurrency);
				//accountData.setAcType(accountType);

				/*AccessLayerAccountSummary acctSummary = BankAwayEJBCalls.getOnlineAcctBalance(strAccountNumber.trim()
						,   accBranchCode.trim()
						,   applCurrency.trim()
						,   accountType.trim()
						,   orgKey  );*/
                String  str = new String();
              //  AccessLayerAccountSummary acctSummary = new AccessLayerAccountSummary();
               // BancsConnectRemoteInterface test = AccessLayerHostMarker.getHostForBankaway(str);

                 AccountSummary acctSummary = new AccountSummary();

				AccountInquiryALImplementation   test = new AccountInquiryALImplementation();
				acctSummary = test.getOnlineAcctBalance(cUserInfo,accountData);

				GeneralAcctInquiryInputVO accInquiryInput = new GeneralAcctInquiryInputVO();
				accInquiryInput.setAcid(strAccountNumber);
				accInquiryInput.setBranchId(accBranchCode);

				FIIncidentInfo objFIIncidentInfo2 = new FIIncidentInfo();
				objFIIncidentInfo2.setDccReqRefNum(String.valueOf(System.currentTimeMillis()));
				objFIIncidentInfo2.setDccReqOrigTime(getDateFormatforFIServReq());
				objFIIncidentInfo2.setDccReqType("DEFAULTEJB");
				accInquiryInput.setFIIncidentInfo(objFIIncidentInfo2);


				/* for getting account status and type*/
				GeneralAcctInquiryOutputVO accInquiryOutput = test.doGeneralAcctInquiry(cUserInfo, accInquiryInput);

				/*For deposit amount and maturity amount*/
//				DepositAccountDetailsOutput depositAccDetails = test.getDepositAccountDetails(cUserInfo, accountData);
               // AccountInquiryALImplementation  test = AccountInquiryALImplementation();
                //AccountInquiryALImplementation  test = AccountInquiryALImplementation();
              //  acctSummary =  test.getOnlineAcctBalance(cUserInfo,accountData);

                sbfOutput.append("<HTML>");
                sbfOutput.append("<Title>"+ this.getSystemString("Default", "Title") +"</Title><Head>");
                sbfOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMTableDisplay_en_US.css'/>");
                sbfOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/Popup_en_US.css'/>");
                sbfOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMListTemplate_en_US.css'/>");
               	sbfOutput.append("<style> .displaydata{font-family:Arial;font-size:9pt;margin-bottom:1px;} </style>");

                sbfOutput.append("</Head><body class='popup'>");
                sbfOutput.append("<SCRIPT>");
                sbfOutput.append("function refreshparent(){");
                sbfOutput.append("var url = window.opener.location.href;");
                sbfOutput.append("window.opener.location.href=url;");
                sbfOutput.append("top.close();}");
                sbfOutput.append("</SCRIPT>");


                //sbfOutput.append("<br>");
                //sbfOutput.append("<br>");

				sbfOutput.append("<table class=\"table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">");
				sbfOutput.append("<tr>");
				sbfOutput.append("<td>");
				sbfOutput.append("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"innertable\" width=\"100%\" vspace=\"0\" hspace=\"0\">");
				sbfOutput.append("<tr>");
				sbfOutput.append("<td>");
				sbfOutput.append("<table cellPadding=\"0\" cellSpacing=\"0\" width=\"100%\">");
				sbfOutput.append("<tr>");
				sbfOutput.append("<th class=\"header\" align=\"left\">Account Balance Details</th>");
				sbfOutput.append("</tr>");
				sbfOutput.append("</table>");
				sbfOutput.append("<table cellPadding=\"0\" cellSpacing=\"0\" class=\"background\" width=\"100%\">");
				sbfOutput.append("<tr>");

				//Change for SIT10202 Tracker : 181186
				DecimalFormat df1 = new DecimalFormat("#,##0.00");
				//such Amount Ledgerbal = acctSummary.getBalance1();
                //such Amount FFDbal  = acctSummary.getBalance2();
                Amount Ledgerbal = acctSummary.getLedgerBalance();
                Amount FFDbal  = acctSummary.getFFDBalance();

                String AccStatus  = accInquiryOutput.getAcctStatus();

                String AccType = accInquiryOutput.getAcctType();

                sbfOutput.append("<td class=\"d1\">Account Number</td><td class=\"displaydata\">"+ strAccountNumber);
                sbfOutput.append("</td><td class=\"d1\">Currency</td><td class=\"displaydata\">"+ applCurrency+"</td></tr>");
                /*TRACKER ID : 68283 BEGIN OF CHANGES*/
                //sbfOutput.append("<br>");
                sbfOutput.append("<tr><td class=\"d1\">Account Status</td><td class=\"displaydata\">"+ AccStatus+"</td></tr></table><br/>");
                /*TRACKER ID : 68283 END OF CHANGES*/
                //sbfOutput.append("<br><br>");
                sbfOutput.append("<table cellPadding=\"0\" cellSpacing=\"0\" width=\"100%\">");
                sbfOutput.append("<tr><th colspan=\"4\" class=\"header\" align=\"left\">Account Balance</th></tr>");
                sbfOutput.append("<tr><td class=\"C36\">Ledger Balance</td>");
                //Change for SIT10202 Tracker : 181186
                sbfOutput.append("<td class=\"C35\">"+df1.format(Ledgerbal.getAmountValue())+ "</td>");
                sbfOutput.append("<td class=\"C36\">Avail + FFD Balance</td>");
                //Change for SIT10202 Tracker : 181186
                sbfOutput.append("<td class=\"C35\">"+df1.format(FFDbal.getAmountValue())+ "</td></tr>");

                if(AccType.equalsIgnoreCase(strAccountTypeTDA)){
					DepositAccountDetailsOutput depositAccDetails = test.getDepositAccountDetails(cUserInfo, accountData);
                    Amount MaturityAmount  = depositAccDetails.getMaturityAmount();
                    Amount DepositAmount  = depositAccDetails.getDepositAmount();
                    sbfOutput.append("<tr><tr><td class=\"C36\">Maturity Amount</td>");
                    //Change for SIT10202 Tracker : 181186
                    sbfOutput.append("<td class=\"C35\">"+df1.format(MaturityAmount.getAmountValue())+ "</td>");
                    sbfOutput.append("<td class=\"C36\">Deposit Amount</td>");
                    //Change for SIT10202 Tracker : 181186
                    sbfOutput.append("<td class=\"C35\">"+df1.format(DepositAmount.getAmountValue())+ "</td></tr></table>");

                }else{
                    if(AccType.equalsIgnoreCase(strAccountTypeLAA)){
						LoanAccountDetails loanAccDetails = test.getLoanAccountDetails(cUserInfo, accountData);
	                    Amount SanctionLimit  =  loanAccDetails.getLoanSanctionLimit();
                        sbfOutput.append("<tr><td class=\"C36\">Sanction Limit</td>");
                        //Change for SIT10202 Tracker : 181186
                        sbfOutput.append("<td class=\"C35\">"+df1.format(SanctionLimit.getAmountValue())+ "</td>");
						sbfOutput.append("<td class=\"C36\">&nbsp;</td><td class=\"C35\">&nbsp;</td></tr></table>");
                    }else{
                    	Amount Floatbal = acctSummary.getFloatingBalance();
                    	Amount FFDbalance = acctSummary.getFFDBalance();
                        sbfOutput.append("<tr><td class=\"C36\">Float Balance</td>");
                        //Change for SIT10202 Tracker : 181186
                        sbfOutput.append("<td class=\"C35\">"+df1.format(Floatbal.getAmountValue())+ "</td>");
                        sbfOutput.append("<td class=\"C36\">FFD Balance</td>");
                        //Change for SIT10202 Tracker : 181186
                        sbfOutput.append("<td class=\"C35\">"+df1.format(FFDbalance.getAmountValue())+ "</td></tr></table>");
                    }
                }

                sbfOutput.append("<br/></td></tr></table></td></tr></table>");

                sbfOutput.append("<table class=\"background\">");
                sbfOutput.append("<TR><TD align='left'><input class=\"sbttn\" type='button' value=' Close ' onClick='refreshparent()'>");
                sbfOutput.append("</td> </tr></table></body></html>");
                //Updating the Additional Notes Attributes of IncidentBO -Start
                StringBuffer notes = new  StringBuffer();
                String strLineSeparator      = System.getProperty("line.seperator");
                notes.append("Account Number: "+ strAccountNumber);
                notes.append(strLineSeparator);
                notes.append("Currency: "+ applCurrency);
/*TRACKER ID : 68283 BEGIN OF CHANGES*/
                notes.append(strLineSeparator);
                notes.append("Account Status: "+ AccStatus);
/*TRACKER ID : 68283 END OF CHANGES*/
                notes.append(strLineSeparator);
                notes.append(strLineSeparator);
                notes.append("Ledger Balance:"+Ledgerbal);
                notes.append(strLineSeparator);
                notes.append("Avail + FFD Balance:"+FFDbal);
                notes.append(strLineSeparator);

                if(AccType.equalsIgnoreCase(strAccountTypeTDA)){

					DepositAccountDetailsOutput depositAccDetails = test.getDepositAccountDetails(cUserInfo, accountData);
                    Amount MaturityAmount  = depositAccDetails.getMaturityAmount();
                    Amount DepositAmount  = depositAccDetails.getDepositAmount();
                    notes.append("Maturity Amount:"+MaturityAmount);
                    notes.append(strLineSeparator);
                    notes.append("Deposit Amount:"+DepositAmount);
                    notes.append(strLineSeparator);

                }else{
                    if(AccType.equalsIgnoreCase(strAccountTypeLAA)){
						LoanAccountDetails loanAccDetails = test.getLoanAccountDetails(cUserInfo, accountData);
	                    Amount SanctionLimit  =  loanAccDetails.getLoanSanctionLimit();
                        notes.append("Sanction Limit:"+SanctionLimit );
                        notes.append(strLineSeparator);

                    }else{
                        Amount Floatbal = acctSummary.getFloatingBalance();
                        Amount FFDbalance = acctSummary.getFFDBalance();
                        notes.append("Float Balance:"+Floatbal );
                        notes.append(strLineSeparator);
                        notes.append("FFD Balance:"+FFDbalance);
                    }
                }
                //Setting te Additional Notes attribute of the Incident with the response from Bean
                CommonQueries.UpdateIncident(   bc ,
                                                                        inciID
                                                                        , "Open"
                                                                        , currentStepID
                                                                        , notes.toString()
                                                                        , null
                                                                        , true
                                                                        , null
                                                                        , null );

                out.println(sbfOutput);
            }catch(AccessLayerNonFatalException e){
				/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
					BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_BALENQ_FETCH,'W',CRMOpConsoleErrMessages.ERR_ONLINE_BALENQ_FETCH + e.getMessage(),'L',bc);
				/* Message has been sent to Op-Console */
                throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBNONFATAL , e);
            }catch(AccessLayerFatalException e){
				/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
					BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_BALENQ_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_ONLINE_BALENQ_INTERNAL + e.getMessage(),'L',bc);
				/* Message has been sent to Op-Console */
                throw new SRMBOException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
            }catch (Exception e){
				/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
					BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_BALENQ_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_ONLINE_BALENQ_INTERNAL + e.getMessage(),'L',bc);
				/* Message has been sent to Op-Console */
                throw new SRMBOException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
            }catch (Throwable e){
                out.println("Either Interface or BankAway jars are not in the classpath." + e.getMessage());
            }
        } /*If Request is from processSteps- end */


        /*If Request is from 360 degree views-Start*/
        if(url.startsWith("srmBOObj:SaleBO")){
            try{
                /*Chopping the url and getting the Sales ID out of it.*/
                Integer  iSalesID =  CommonQueryFunctions.getIDFromURL(url);

                if( iSalesID == null ){

                    throw new FCRMGenericException(new Exception("Sales id is null."));
                }

                List saleslist = CommonQueryFunctions.getSalesData( iSalesID, bc );

                if(saleslist == null){

                    throw new FCRMGenericException("MSGEXC0015",new Exception("The record does not exist in the database."));
                }

                //String productsKey                        = null;
                String accBranchCode                    = null;
                Integer prodCatID                       = null;
                Integer orgID                               = null;
                String strAccountNumber             = null;

                if( saleslist.get(3) == null || String.valueOf(saleslist.get(3)).trim() == "" ){

                    Exception e = new FCRMGenericException("MSGEXC0016",new Exception("The account branch code is null for the account."));
                    throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
                }

                if( saleslist.get(4) == null ){

                    Exception e = new FCRMGenericException("MSGEXC0017",new Exception("The prod cat id is null for the account"));
                    throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
                }

                if( saleslist.get(5) == null ){

                    Exception e = new FCRMGenericException("MSGEXC0018",new Exception("The org id  is null for the account."));
                    throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
                }

                if( saleslist.get(6) == null || String.valueOf(saleslist.get(6)).trim() == "" ){

                    Exception e = new FCRMGenericException("MSGEXC0029",new Exception("The account number is null for the account."));
                    throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
                }


                //productsKey = (String)saleslist.get(1);
                accBranchCode = (String)saleslist.get(3);
                prodCatID = (Integer)saleslist.get(4);
                orgID = (Integer)saleslist.get(5);
                strAccountNumber = (String)saleslist.get(6);

                /*Getting account currency from the table SaleBackEnd on the basis of SalesID - Start*/

                ////System.out.println("Account No:"+strAccountNumber);
                ////System.out.println("Brach Code: "+accBranchCode);

				//accBranchCode = "102";
				/*Added for getting BranchCode from BranchName BEGIN*/

				/* Recon changes for Tracker Id 273092 : begin */
				/* Fix for callid 235635 : begin */
				/* Commented out since branch code is already available from SaleBO.ACCBRANCHCODE */
				/*ArrayList attrId 			= new ArrayList();
				attrId.add(BankBO.BRANCH_BRANCHCODE);

				SRMQueryBuilder qb	= new SRMQueryBuilder();
				qb=QueryAssist.singleObjectQuery("BankBO",BankBO.BRANCH_BRANCHID);
				QueryAssist.addSimpleCondition(qb,"BankBO",BankBO.BRANCH_BRANCHNAME,IQuery.ComparisonOperation_EQ,""+accBranchCode);
				QueryAssist.selectAttr(qb, "BankBO", attrId);
				qb.setDistinct(true);
				SRMQueryResult qr 	= qb.runQuery(bc, false, -1);
				SRMRecordSet rs 	= qr.getRecordSet();

				if(rs.hasNext()){
					ArrayList rowObj = (ArrayList)rs.getNext();
					if(rowObj.get(0)!=null){
						 accBranchCode=rowObj.get(0).toString().trim();
					}
				}*/
				/* Commented out since branch code is already available from SaleBO.ACCBRANCHCODE */
				/* Fix for callid 235635 : end */
				/* Recon changes for Tracker Id 273092 : end */

				/*Added for getting BranchCode from BranchName END*/

                ////System.out.println(" after resetting Brach Code: "+accBranchCode);
                List saleBackEndList = CommonQueryFunctions.getSaleBackEndData( iSalesID , bc );
                if( saleBackEndList == null ){
                    Exception e = new FCRMGenericException(new Exception("The list retrieved inside prewrite method is null."));
                    throw new SRMPreWriteException(SRMBOException.ERROR_RETRIEVINGDATA , e);
                }

                String  applCurrency = null;
                if( saleBackEndList.get(1) == null || String.valueOf(saleBackEndList.get(1)).trim() == "" ){
                    Exception e = new FCRMGenericException("MSGEXC0020",new Exception("The account currency is null for the account."));
                    throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
                }
                applCurrency = (String)saleBackEndList.get(1);
                /*Getting account currency from the table SaleBackEnd on the basis of SalesID - End*/

                /*accBranchCode = CommonQueryFunctions.getDataFromRefCodeMapper( "SERVICE_OUTLET"
                                                , accBranchCode.trim()
                                                , null);

                if( accBranchCode == null || accBranchCode.trim().equals("")){
                    throw new FCRMGenericException(new Exception("Account branch code retrieved from RefCodeMapper is null."));
                }

                /*getting Account type description from Prodcat table on the basis of ProdCatId-start*/
                String  accountType = CommonQueryFunctions.getAccountType( prodCatID , bc );
                if (accountType == null || accountType.trim().equals("")){
                        throw new FCRMGenericException("MSGEXC0022",new Exception("Account type description is null."));
                }

                //accountType = CommonQueryFunctions.getStrWithoutSpace(accountType);
               /* accountType = CommonQueryFunctions.getDataFromRefCodeMapper( "PRODUCT_CATEGORY",  accountType.trim(), null );

                if( accountType == null || accountType.trim().equals("")){
                    throw new FCRMGenericException(new Exception("Account type retrieved from RefCodeMapper is null."));
                }

                /// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
                String orgKey = CommonQueryFunctions.getOrgKey (orgID, bc);
                /// NCB_226, TRACKER# 51444, END OF CHANGES

                //contacting the account balance ejb - start
               /* AccessAccountSummaryVO acctSummary = BankAwayEJBCalls.getAccountBalanceFromBean( strAccountNumber.trim()                                                                        ,   accBranchCode.trim() ,   applCurrency.trim() ,   accountType.trim()
			   /// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
                 ///         , orgID.toString()) ;
                            ,   orgKey  );

                /*AccessLayerAccountSummary acctSummary = BankAwayEJBCalls.getAccountBalanceFromBean(strAccountNumber.trim()
							,   accBranchCode.trim()
							,   applCurrency.trim()
							,   accountType.trim()
							,   orgKey  );*/

                //contacting the accountbalance balance ejb - end

               int iProdCatID = prodCatID.intValue();
				if(iProdCatID == Constants.PROD_CAT_LO || iProdCatID == Constants.PROD_CAT_HLO){
					accountType = Constants.LOANS1;

				} else if(iProdCatID == Constants.PROD_CAT_SB){
						//iProdCatID == Constants.PROD_CAT_CA){
						accountType = Constants.SBA;
						accountType = Constants.SBCACCOD;
				}else if(iProdCatID == Constants.PROD_CAT_CA){
						accountType = Constants.SBCACCOD;
				} else if(iProdCatID == Constants.PROD_CAT_TDA){
						accountType = Constants.TDA;
				}
				//AccountListElement
                accountData.setBranchId(accBranchCode);
				accountData.setAcid(strAccountNumber);

				String  str = new String();
				AccountSummary acctSummary = new AccountSummary();

				AccountInquiryALImplementation   test = new AccountInquiryALImplementation();

                FIIncidentInfo objFIIncidentInfo2 = new FIIncidentInfo();
												objFIIncidentInfo2.setDccReqRefNum(String.valueOf(System.currentTimeMillis()));
												objFIIncidentInfo2.setDccReqOrigTime(getDateFormatforFIServReq());
												objFIIncidentInfo2.setDccReqType("DEFAULTEJB");
				accountData.setFIIncidentInfo(objFIIncidentInfo2);

				acctSummary = test.getOnlineAcctBalance(cUserInfo,accountData);

				GeneralAcctInquiryInputVO accInquiryInput = new GeneralAcctInquiryInputVO();
				accInquiryInput.setAcid(strAccountNumber);
				accInquiryInput.setBranchId(accBranchCode);
				/* for getting account status and type*/
				FIIncidentInfo objFIIncidentInfo3 = new FIIncidentInfo();
								objFIIncidentInfo3.setDccReqRefNum(String.valueOf(System.currentTimeMillis()));
								objFIIncidentInfo3.setDccReqOrigTime(getDateFormatforFIServReq());
							    objFIIncidentInfo3.setDccReqType("DEFAULTEJB");
								accInquiryInput.setFIIncidentInfo(objFIIncidentInfo3);

				GeneralAcctInquiryOutputVO accInquiryOutput = test.doGeneralAcctInquiry(cUserInfo, accInquiryInput);

                //added by uday to set unique Ref Numbers start
                FIIncidentInfo objFIIncidentInfo = new FIIncidentInfo();
		        objFIIncidentInfo.setDccReqRefNum(String.valueOf(System.currentTimeMillis()));
                accountData.setFIIncidentInfo(objFIIncidentInfo);
				//added by uday to set unique Ref Numbers end

				//Change for SIT10202 Tracker : 181186
				DecimalFormat df2 = new DecimalFormat("#,##0.00");
                sbfOutput.append("<HTML>");
                sbfOutput.append("<Title>"+ this.getSystemString("Default", "Title") +"</Title><Head>");
                sbfOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMTableDisplay_en_US.css'/>");
                sbfOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/Popup_en_US.css'/>");
                sbfOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMListTemplate_en_US.css'/>");
               	sbfOutput.append("<style> .displaydata{font-family:Arial;font-size:9pt;margin-bottom:1px;} </style>");
                sbfOutput.append("</Head><body class='popup'>");
                //sbfOutput.append("<br>");
                //sbfOutput.append("<br>");
				sbfOutput.append("<table class=\"table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">");
				sbfOutput.append("<tr>");
				sbfOutput.append("<td>");
				sbfOutput.append("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"innertable\" width=\"100%\" vspace=\"0\" hspace=\"0\">");
				sbfOutput.append("<tr>");
				sbfOutput.append("<td>");
				sbfOutput.append("<table cellPadding=\"0\" cellSpacing=\"0\" width=\"100%\">");
				sbfOutput.append("<tr>");
				sbfOutput.append("<th class=\"header\" align=\"left\">Account Balance Details</th>");
				sbfOutput.append("</tr>");
				sbfOutput.append("</table>");
				sbfOutput.append("<table cellPadding=\"0\" cellSpacing=\"0\" class=\"background\" width=\"100%\">");
				sbfOutput.append("<tr>");

                //sbfOutput.append("<table cellPadding=0 cellSpacing=1  align=center class=\"background\" width=\"100%\">");
                //sbfOutput.append("<tr> <td align=center class=\"tableHeader\" width=\"100%\">Account Balance Details</td></tr></table><br>");

                //such Amount Ledgerbal = acctSummary.getBalance1();
               // such Amount FFDbal  = acctSummary.getBalance2();
                Amount Ledgerbal = acctSummary.getLedgerBalance();
                Amount FFDbal  = acctSummary.getFFDBalance();
                String AccType = accInquiryOutput.getAcctType();
/*TRACKER ID : 68283 BEGIN OF CHANGES*/
                String AccStatus  = accInquiryOutput.getAcctStatus();
/*TRACKER ID : 68283 END OF CHANGES*/
                sbfOutput.append("<td class=\"d1\">Account Number</td><td class=\"displaydata\">"+ strAccountNumber);
				sbfOutput.append("</td><td class=\"d1\">Currency</td><td class=\"displaydata\">"+ applCurrency+"</td></tr>");
/*TRACKER ID : 68283 BEGIN OF CHANGES*/
				sbfOutput.append("<tr><td class=\"d1\">Account Status</td><td class=\"displaydata\">"+ AccStatus+"</td></tr></table><br/>");
/*TRACKER ID : 68283 END OF CHANGES*/
                //sbfOutput.append("<br><br>");
                sbfOutput.append("<table cellPadding=\"0\" cellSpacing=\"0\" width=\"100%\">");
				sbfOutput.append("<tr><th colspan=\"4\" class=\"header\" align=\"left\">Account Balance</th></tr>");
				//Change for SIT10202 Tracker : 181186
				sbfOutput.append("<tr><td class=\"C36\">Ledger Balance</td>");
                sbfOutput.append("<td class=\"C35\">"+df2.format(Ledgerbal.getAmountValue())+ "</td>");
                sbfOutput.append("<td class=\"C36\">Avail + FFD Balance</td>");
                sbfOutput.append("<td class=\"C35\">"+df2.format(FFDbal.getAmountValue())+ "</td></tr>");

                /* ABNGC6206:TRACKER#    68406**BEGIN   CHANGES** */

				//System.out.println(" \n\n strAccountTypeTDA " +strAccountTypeTDA);
				//System.out.println(" \n\n AccType " +AccType);


                if(AccType.equalsIgnoreCase(strAccountTypeTDA)){
				/*For deposit amount and maturity amount*/
				        FIIncidentInfo objFIIncidentInfo5 = new FIIncidentInfo();
                        objFIIncidentInfo5.setDccReqRefNum(String.valueOf(System.currentTimeMillis()));
                        objFIIncidentInfo5.setDccReqType("DEFAULTEJB");
				        objFIIncidentInfo5.setDccReqOrigTime(getDateFormatforFIServReq());
						accountData.setFIIncidentInfo(objFIIncidentInfo5);
					DepositAccountDetailsOutput depositAccDetails = test.getDepositAccountDetails(cUserInfo, accountData);
                	Amount MaturityAmount  = depositAccDetails.getMaturityAmount();
                    Amount DepositAmount  = depositAccDetails.getDepositAmount();
					//Change for SIT10202 Tracker : 181186
					sbfOutput.append("<tr><tr><td class=\"C36\">Maturity Amount</td>");
					sbfOutput.append("<td class=\"C35\">"+df2.format(MaturityAmount.getAmountValue())+ "</td>");
					sbfOutput.append("<td class=\"C36\">Deposit Amount</td>");
					sbfOutput.append("<td class=\"C35\">"+df2.format(DepositAmount.getAmountValue())+ "</td></tr></table>");

                }else{
                    if(AccType.equalsIgnoreCase(strAccountTypeLAA)){
                        FIIncidentInfo objFIIncidentInfo4 = new FIIncidentInfo();
                        objFIIncidentInfo4.setDccReqRefNum(String.valueOf(System.currentTimeMillis()));
                        objFIIncidentInfo4.setDccReqType("DEFAULTEJB");
                        objFIIncidentInfo4.setDccReqOrigTime(getDateFormatforFIServReq());
						accountData.setFIIncidentInfo(objFIIncidentInfo4);
						LoanAccountDetails loanAccDetails = test.getLoanAccountDetails(cUserInfo, accountData);
	                    Amount SanctionLimit  =  loanAccDetails.getLoanSanctionLimit();
                        //Change for SIT10202 Tracker : 181186
                        sbfOutput.append("<tr><td class=\"C36\">Sanction Limit</td>");
                        sbfOutput.append("<td class=\"C35\">"+df2.format(SanctionLimit.getAmountValue())+ "</td>");
                        sbfOutput.append("<td class=\"C36\">&nbsp;</td><td class=\"C35\">&nbsp;</td></tr></table>");

                    }else{
                        Amount Floatbal = acctSummary.getFloatingBalance();
                        Amount FFDbalance = acctSummary.getFFDBalance();
                        sbfOutput.append("<tr><tr><td class=\"C36\">Float Balance</td>");
                        //Change for SIT10202 Tracker : 181186
                        sbfOutput.append("<td class=\"C35\">"+df2.format(Floatbal.getAmountValue())+ "</td>");
                        sbfOutput.append("<td class=\"C36\">FFD Balance</td>");
                        sbfOutput.append("<td class=\"C35\">"+df2.format(FFDbalance.getAmountValue())+ "</td></tr></table>");
                    }
                }
                /* ABNGC6206:TRACKER#    68406**END   CHANGES** */
                sbfOutput.append("</body></html>");
                out.println(sbfOutput);

            }catch(AccessLayerNonFatalException e){
            	////System.out.println("Exception M ");
            	//e.printStackTrace();
				/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
					BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_BALENQ_FETCH,'W',CRMOpConsoleErrMessages.ERR_ONLINE_BALENQ_FETCH + e.getMessage(),'L',bc);
				/* Message has been sent to Op-Console */
                throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBNONFATAL , e);
            }catch(AccessLayerFatalException e){
            	////System.out.println("Exception M1 ");
            	//e.printStackTrace();
				/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
					BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_BALENQ_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_ONLINE_BALENQ_INTERNAL + e.getMessage(),'L',bc);
				/* Message has been sent to Op-Console */
                throw new SRMBOException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
            }
            catch(CINonFatalException e){
                     	//e.printStackTrace();
				/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
					BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_BALENQ_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_ONLINE_BALENQ_INTERNAL + e.getMessage(),'L',bc);
				/* Message has been sent to Op-Console */
				//System.out.println(" Standard message "+ e.getStdMessage());
				//System.out.println(" host message "+e.getHostMessage());
//                throw new SRMBOException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
		    	throw new FCRMGenericException("MSG50089",new Exception("The following error we are getting while calling the FI Service : {0}"),e.getStdMessage());
            }
			catch (Exception e){
				/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
					BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_BALENQ_CIS_UNAVAILABLE,'E',CRMOpConsoleErrMessages.ERR_ONLINE_BALENQ_CIS_UNAVAILABLE + e.getMessage(),'L',bc);
				/* Message has been sent to Op-Console */
                        //TRACKER:62101:BEGIN OF CHANGES
                throw new SRMBOException(SRMBOException.ERROR_BANKAWAY_SETUP, e);
            }catch (Throwable e){

				/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
					BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_BALENQ_CIS_UNAVAILABLE,'E',CRMOpConsoleErrMessages.ERR_ONLINE_BALENQ_CIS_UNAVAILABLE + e.getMessage(),'L',bc);
				/* Message has been sent to Op-Console */
                    //out.println("Either Interface or BankAway jars are not in the classpath." + e.getMessage());
                    //out.println("Set up not Available" );
                throw new SRMBOException(SRMBOException.ERROR_BANKAWAY_SETUP );

          }

                    //  TRACKER:62101:END OF CHANGES
        }
        /*If Request is from 360 degree views-end*/

    }
    //End of ServiceRequest Method

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

    }
//End of Class





