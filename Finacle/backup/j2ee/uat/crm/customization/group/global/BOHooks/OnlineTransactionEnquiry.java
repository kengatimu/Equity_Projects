/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: OnlineTransactionEnquiry.java $
 *
 * Author: Paritosh
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/OnlineTransactionEnquiry.java $
 *
 * **************************************************************************/
/**This class will be used when user wants to know the last few transaction happened
	for his account.
	Related BankAway ejb wrapper methods will be called to fetch the details from
	the Finacle database.
	In this class first all the necessary arguments for calling the bean wrapper methods are
	gathered.
	Then the bean is called.
	Here the request can be only from 360 degree views Accounts.
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
import java.lang.*;

import com.infy.cis.servletruntime.*;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.exception.*;
import com.infy.cis.ui.common.*;
import com.infy.cis.common.*;
import com.infy.cis.custom.CommonQueryFunctions;
import com.infy.cis.common.BankAwayEJBCalls;
import com.infosys.ci.common.Amount;
import com.infosys.ci.common.CIUserInfo;
import com.infosys.ci.cibancsconnect.accounts.common.AccountListElement;
import com.infosys.ci.cibancsconnect.accounts.common.AccountStatement;
import com.infosys.ci.cibancsconnect.accounts.common.AccountTransaction;
import com.infosys.ci.cibancsconnect.accounts.common.AccountTransactionList;
import com.infosys.ci.cibancsconnect.accounts.common.AccountTransactionSummary;
import com.infosys.ci.cibancsconnect.accounts.common.GeneralAcctInquiryInputVO;
import com.infosys.ci.cibancsconnect.accounts.common.GeneralAcctInquiryOutputVO;
import com.infosys.ci.cibancsconnect.accounts.common.AccountSummary;

import com.infosys.ci.common.FIIncidentInfo;
//import com.infosys.bankaway.accesslayer.accounts.*;
import com.infosys.bankaway.accesslayer.user.*;
import com.infosys.bankaway.accesslayer.bwyinterface.*;

/* Files to be imported to send messages to Op-Console */
import com.infy.cis.common.CRMOpConsoleErrCodes;
import com.infy.cis.common.CRMOpConsoleErrMessages;
import com.infy.cis.opc.BCOpConsoleLogMgr;
/* Change for DBS Ticket 319931 by BADRI : BEGIN */
import com.infosys.ci.common.CINonFatalException;
/* Change for DBS Ticket 319931 by BADRI : END */
//Change for SIT10202 Tracker : 181186
import java.text.DecimalFormat;
public class OnlineTransactionEnquiry extends CISHttpServlet {

	public void serviceRequest ( HttpServletRequest req, HttpServletResponse resp)
	throws Exception
    {
		setContentType("text/html", resp);
		PrintWriter out = resp.getWriter();

		StringBuffer sbfHtmlOutput = new StringBuffer();

		/*Getting bc */
		SRMBusinessContext bc = Utils.getBusinessContext(req,
		java.sql.Connection.TRANSACTION_READ_UNCOMMITTED);
		/* ABNGC6206:TRACKER#    68406**BEGIN   CHANGES** */
		CISSessionContext sc = context.getSessionContext(req);

				/* PRASHANT'S ML CHANGES : BEGIN*/
				java.util.Locale locale = ((com.infy.cis.servletruntime.CISSessionContext)com.infy.cis.common.SRMTLVar.sc.get()).getSessionLocale();
				String strLocale = locale.toString();
				SRMResourceLoader locale_message = SRMResourceLoader.getInstance();
				ResourceBundle resourceBundle = locale_message.getBundles("cis.ui.common", "UI").getBundle(locale);
				/* PRASHANT'S ML CHANGES : END*/


		SRMFormatter srmf = sc.getFormatter();
		CIUserInfo  cUserInfo = new CIUserInfo();
		//Fix for setting unique transaction Ref numbers
		FIIncidentInfo objFIIncidentInfo = new FIIncidentInfo();
		objFIIncidentInfo.setDccReqRefNum(String.valueOf(System.currentTimeMillis()));
		//objFIIncidentInfo.setDccReqOrigTime(new java.text.SimpleDateFormat("MM-dd-yyyy HH:MM:ss.ms").format(new Date()));	//10.1 Recon Changes
		objFIIncidentInfo.setDccReqOrigTime(getDateFormatforFIServReq());//10.1 Recon Changes
		objFIIncidentInfo.setDccReqType("DEFAULTEJB");

		AccountListElement accountData = new AccountListElement();
		AccountStatement accStatement=new AccountStatement();
		String str = new String();
		/* ABNGC6206:TRACKER#    68406**END   CHANGES** */
		/* Change for DBS Ticket 319931 by BADRI : BEGIN */
		String strAccountNumber				= null;
		/* Change for DBS Ticket 319931 by BADRI : END */
		try{
			/*getting Sales ID from the srmurl*/
			String url = 	req.getParameter("srmUrl");
			if( url == null){
				throw new FCRMGenericException("MSGEXC0101",new Exception("The requested URL is null."));
			}

			/*Chopping the url and getting the Sales ID out of it.*/
			Integer  iSalesID =  CommonQueryFunctions.getIDFromURL(url);
			if( iSalesID == null){
					throw new FCRMGenericException("MSGEXC0102",new Exception("Sales id is null in the url."));
			}

			List saleslist = CommonQueryFunctions.getSalesData( iSalesID  , bc );
			if(saleslist  == null){
				throw new FCRMGenericException("MSGEXC0015",new Exception("The record does not exist in the database."));
			}

			String accBranchCode					= null;
			Integer prodCatID						= null;
			Integer orgID								= null;


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
			accBranchCode = (String)saleslist.get(3);
			prodCatID = (Integer)saleslist.get(4);
			orgID = (Integer)saleslist.get(5);
			strAccountNumber = (String)saleslist.get(6);

			////System.out.println("Customer No"+strAccountNumber);
			////System.out.println("Branch Code"+accBranchCode);

			/* Recon changes for Tracker Id 273104 : begin */
			/* Fix for callid 235636 : begin */
			/* Commented out since branch code is already available from SaleBO.ACCBRANCHCODE */
			/* Added for getting BranchCode from BranchName BEGIN*/
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
			/* Added for getting BranchCode from BranchName END*/
			/* Commented out since branch code is already available from SaleBO.ACCBRANCHCODE */
			/* Fix for callid 235636 : begin */
			/* Recon changes for Tracker Id 273104 : begin */

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

			//accBranchCode = CommonQueryFunctions.getDataFromRefCodeMapper( "SERVICE_OUTLET"												//, accBranchCode.trim()																		//, null);

			/*if( accBranchCode == null || accBranchCode.trim().equals("")){
				throw new Exception("Account branch code retrieved from RefCodeMapper is null.");
			}*/
			/*getting Account type from Prodcat table on the basis of ProdCatId-start*/
			String  accountType = CommonQueryFunctions.getAccountType( prodCatID , bc );
			if (accountType == null || accountType.trim().equals("")){
				throw new FCRMGenericException("MSGEXC0022",new Exception("Account type description is null."));
			}
			//accountType = CommonQueryFunctions.getDataFromRefCodeMapper( "PRODUCT_CATEGORY"										//, accountType.trim()																			//, null );
			/*if( accountType == null || accountType.trim().equals("")){
				throw new Exception("Account type retrieved from RefCodeMapper is null.");
			}*/
			/*getting Account type from Prodcat table on the basis of ProdCatId-end*/

			/// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
			String orgKey = CommonQueryFunctions.getOrgKey (orgID, bc);
			/// NCB_226, TRACKER# 51444, END OF CHANGES

			/*Contacting the  Transaction Enquiry ejb - start*/
/*			AccessAccountStatementVO transactionHistoryVect = BankAwayEJBCalls.getLast10TxnFromBean(
														strAccountNumber.trim()
														,	accBranchCode.trim()
														,	applCurrency.trim()
														,	accountType.trim()
														/// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
														///			,	orgID.toString()) ;
														,	orgKey	);
														/// NCB_226, TRACKER# 51444, END OF CHANGES*/

			//set channel id to CRM
			cUserInfo.setChannelType("CRM");
			//Fix for setting version and bankid
			//cUserInfo.setDccReqVersion("VERSION1");

						String bankID = (String)com.infy.cis.common.SRMTLVar.bank_id.get();

							if( bankID != null || !bankID.equalsIgnoreCase("")){
									cUserInfo.setBankId(bankID);
								}else{
									cUserInfo.setBankId("01");
								}

			int iProdCatID = prodCatID.intValue();
			if(iProdCatID == Constants.PROD_CAT_LO || iProdCatID == Constants.PROD_CAT_HLO){
					accountType = Constants.LOANS1;
			} else if(iProdCatID == Constants.PROD_CAT_SB){
					//iProdCatID == Constants.PROD_CAT_CA){
					accountType = Constants.SBA;
			}else if(iProdCatID == Constants.PROD_CAT_CA){
					accountType = Constants.SBCACCOD;
			} else if(iProdCatID == Constants.PROD_CAT_TDA){
					accountType = Constants.TDA;
			}

				//accBranchCode = "102";
                ////System.out.println(" after resetting Brach Code: "+accBranchCode);
			accountData.setBranchId(accBranchCode);
			accountData.setAcid(strAccountNumber);

			AccountInquiryALImplementation   test = new AccountInquiryALImplementation();
			GeneralAcctInquiryInputVO accInquiryInput = new GeneralAcctInquiryInputVO();
			accInquiryInput.setAcid(strAccountNumber);
			accInquiryInput.setBranchId(accBranchCode);
            accInquiryInput.setFIIncidentInfo(objFIIncidentInfo);
			/* for getting account status and type*/
			GeneralAcctInquiryOutputVO accInquiryOutput = test.doGeneralAcctInquiry(cUserInfo, accInquiryInput);

			accInquiryOutput.setAcctType(accountType);

			int lastNTxns = 10;

			/*AccessLayerAccountStatement transactionHistoryVect = BankAwayEJBCalls.getLast10TxnFromBean(strAccountNumber.trim()
															,accBranchCode.trim()
															,	applCurrency.trim()
															,	accountType.trim()
															,	orgKey	);*/
			//AccessLayerAccountStatement	accStatement = getLastNTransactions(cUserInfo, accountData, lastNTxns);

			//BancsConnectRemoteInterface test = AccessLayerHostMarker.getHostForBankaway(str);

			AccountTransactionList accTransactionList = new AccountTransactionList();
			accTransactionList.setLastNTransactions(lastNTxns);
			accTransactionList.setAccountListElement(accountData);
            objFIIncidentInfo.setDccReqRefNum(String.valueOf(System.currentTimeMillis()));
            accTransactionList.setFIIncidentInfo(objFIIncidentInfo);
			accStatement=test.getLastNTransactions(cUserInfo,accTransactionList);
			/*Contacting the  Transaction Enquiry ejb - end*/
			//AccessAccountTransactionVO transactionSummary=new AccessAccountTransactionVO(); Praveena
			//AccountTransaction transactionSummary = new AccountTransaction();
			//Fix for calling getAccountBalances method from AccountStatement API
			 AccountSummary acctSummary = accStatement.getAccountBalances();
			 AccountTransaction transactionSummary[]=accStatement.getTransactionDetails();

			/* ABNGC6206:TRACKER#    68406**BEGIN   CHANGES** */
			String strTransactionType = null;
			String ScrLayout = "";
			ScrLayout = sc.getScreenLayout();
			if(ScrLayout.equalsIgnoreCase(SRMUICommon.RTL)){
					sbfHtmlOutput.append("<HTML dir='rtl'>");
			}
			else{
			sbfHtmlOutput.append("<HTML>");
			}
			sbfHtmlOutput.append("<Title>"+ this.getSystemString("Default", "Title") +"</Title><Head>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMTableDisplay_"+strLocale+".css'/>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/Popup_"+strLocale+".css'/>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMListTemplate_"+strLocale+".css'/>");
			sbfHtmlOutput.append("</Head><body class='popup'>");

			sbfHtmlOutput.append("<table class=\"table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">");
			sbfHtmlOutput.append("<tr>");
			sbfHtmlOutput.append("<td>");
			sbfHtmlOutput.append("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"innertable\" width=\"100%\" vspace=\"0\" hspace=\"0\">");
			sbfHtmlOutput.append("<tr>");
			sbfHtmlOutput.append("<td>");
			sbfHtmlOutput.append("<table cellPadding=\"0\" cellSpacing=\"0\" width=\"30%\">");
			sbfHtmlOutput.append("<tr>");
			/* PRASHANT'S ML CHANGES : BEGIN*/
			sbfHtmlOutput.append("<td class=\"d1\" align=\"left\">"+resourceBundle.getString("MSGJAVA50135")+"</td>");
			sbfHtmlOutput.append("<td class=\"d1\" align=\"left\">"+ strAccountNumber.trim()+"</td>");

			sbfHtmlOutput.append("</tr>");
			sbfHtmlOutput.append("</table>");
			sbfHtmlOutput.append("<table cellPadding=\"0\" cellSpacing=\"0\" class=\"background\" width=\"100%\">");
			sbfHtmlOutput.append("<tr>");

//			sbfHtmlOutput.append("<b>Account Number: "+ strAccountNumber.trim());
//			sbfHtmlOutput.append("</b><br>");

//			sbfHtmlOutput.append("<table cellPadding=0 cellSpacing=1 border=true align=center class=\"background\" width=\"100%\">");
			sbfHtmlOutput.append("<td align=\"left\" colspan=\"11\" class=\"header\" width=\"100%\">"+resourceBundle.getString("MSGJAVA50316")+"</td></tr>");
			sbfHtmlOutput.append("<tr><td class=\"searcheaderleft\">"+resourceBundle.getString("MSGJAVA50317")+"</td>");
			sbfHtmlOutput.append("<td class=\"searcheaderleft\">"+resourceBundle.getString("MSGJAVA50136")+"</td>");
			sbfHtmlOutput.append("<td class=\"searcheaderleft\">"+resourceBundle.getString("MSGJAVA50137")+"</td>");
			sbfHtmlOutput.append("<td class=\"searcheaderleft\">"+resourceBundle.getString("MSGJAVA50138")+"</td>");
			sbfHtmlOutput.append("<td class=\"searcheaderleft\">"+resourceBundle.getString("MSGJAVA50139")+"</td>");
			sbfHtmlOutput.append("<td class=\"searcheaderleft\">"+resourceBundle.getString("MSGJAVA50140")+"</td>");
			/* TRACKER 67504 BEGIN OF CHANGES */
			sbfHtmlOutput.append("<td class=\"searcheaderleft\">"+resourceBundle.getString("MSGJAVA50141")+"</td>");
			sbfHtmlOutput.append("<td class=\"searcheaderleft\">"+resourceBundle.getString("MSGJAVA50142")+"</td>");
			/* TRACKER 67504 END OF CHANGES */
			/* TRACKER 68282 BEGIN OF CHANGES */
			sbfHtmlOutput.append("<td class=\"searcheaderleft\">"+resourceBundle.getString("MSGJAVA50143")+"</td>");
			sbfHtmlOutput.append("<td class=\"searcheaderleft\">"+resourceBundle.getString("MSGJAVA50144")+"</td>");
			sbfHtmlOutput.append("<td class=\"searcheaderleft\">"+resourceBundle.getString("MSGJAVA50145")+"</td></tr>");
			/* TRACKER 68282 END OF CHANGES */
			//double
			Amount CurrentBalance = null;
			String strCurrBal = null;
			//CurrentBalance = accStatement.getClosingBalance();

                String tempCurBal = "";
                //Changes for tracker id 242208 begin
                DecimalFormat df1 = new DecimalFormat("#,##0.00");
				//strCurrBal= acctSummary.getAvailableBalance().toString();
				strCurrBal = df1.format(acctSummary.getAvailableBalance().getAmountValue());
				//Changes for tracker id 242208 end
			for (int index = 0 ; index<transactionSummary.length; index++){
				AccountTransactionSummary accTransactionSummary = transactionSummary[index].getTransactionSummary();
				if(index == 0) {
					CurrentBalance = transactionSummary[index].getTxnBalance();
				}
				//Changes for tracker id 242208 begin, Transaction type is returned as "C" or "D" from Core
				//if(accTransactionSummary.getTxnType().equals("04")){
				if(accTransactionSummary.getTxnType().equals("C")){
                //Changes for tracker id 242208 end
					  strTransactionType=resourceBundle.getString("MSGJAVA50322");
				} else {
					 strTransactionType=resourceBundle.getString("MSGJAVA50323");
				}
				//Change for SIT10202 Tracker : 181186
				//Changes for tracker id 242208 begin, moved outside for loop
                //DecimalFormat df1 = new DecimalFormat("#,##0.00");
                //Changes for tracker id 242208 end
				sbfHtmlOutput.append("<tr><td class=\"fntColData\"> "+(index+1) + "</td>");
                sbfHtmlOutput.append("<td class=\"fntColData\"> "+transactionSummary[index].getTxnId()+ "</td>");
				//Change for SIT10202 Tracker : 181186
				sbfHtmlOutput.append("<td class=\"fntColData\"> "+ df1.format(accTransactionSummary.getTxnAmt().getAmountValue())+ "</td>");
				sbfHtmlOutput.append("<td class=\"fntColData\"> "+strTransactionType+ "</td>");
				//Change for SIT10202 Tracker : 181186
				sbfHtmlOutput.append("<td class=\"fntColData\"> "+df1.format(transactionSummary[index].getTxnBalance().getAmountValue())+ "</td>");
				sbfHtmlOutput.append("<td class=\"fntColData\"> "+(accTransactionSummary.getTxnDate()).getTime().toString()+ "</td>");
				/* TRACKER 67504 BEGIN OF CHANGES */
				sbfHtmlOutput.append("<td class=\"fntColData\"> "+accTransactionSummary.getTxnDesc()+ "</td>");
				sbfHtmlOutput.append("<td class=\"fntColData\">&nbsp</td>");
				//sbfHtmlOutput.append("<td class=\"fntColData\"> "+transactionSummary.getTxnOrgn()+ "</td></tr>"); //Praveena
				/* TRACKER 67504 END OF CHANGES */
				/* TRACKER 68282 BEGIN OF CHANGES */
							try{
							String txntype =accTransactionSummary.getTxnType();
							String txncat = transactionSummary[index].getTxnCat();
							String txnsub = "";
							if(txncat != null && txncat.length()!=0){
							txnsub = txncat.substring(0,1);
							txncat = txncat.substring(1,3);
							}
							if (txnsub.equals("C"))
							{
								txnsub = resourceBundle.getString("MSGJAVA50318");
							}
							else if (txnsub.equals("T"))
							{
								txnsub = resourceBundle.getString("MSGJAVA50324");
							}
							else if (txnsub.equals("L"))
							{
								txnsub = resourceBundle.getString("MSGJAVA50319");
							}
                            //Changes for tracker id 242208 begin, Transaction type is returned as "C" or "D" from Core
							//if (txntype.equals("04"))
							if (txntype.equals("C"))
                            //Changes for tracker id 242208 end
							{
								txntype = resourceBundle.getString("MSGJAVA50320");
							}
                            //Changes for tracker id 242208 begin, Transaction type is returned as "C" or "D" from Core
							//else if (txntype.equals("05"))
							else if (txntype.equals("D"))
                            //Changes for tracker id 242208 end
							{
								txntype = resourceBundle.getString("MSGJAVA50321");
							}

							sbfHtmlOutput.append("<td class=\"fntColData\"> "+txncat+ "</td>");
							sbfHtmlOutput.append("<td class=\"fntColData\"> "+txnsub+ "</td>");
							sbfHtmlOutput.append("<td class=\"fntColData\"> "+txntype+ "</td></tr>");
							}catch(Exception e){}
			/* TRACKER 68282 END OF CHANGES */
			}
			sbfHtmlOutput.append("</table>");
			sbfHtmlOutput.append("<br/></td></tr></table></td></tr></table>");

			sbfHtmlOutput.append("<table class=\"background\" width=\"30%\">");
            //Changes for tracker id 242208 begin
			sbfHtmlOutput.append("<TR><TD align='left' class=\"d1\">"+resourceBundle.getString("MSGJAVA50146")+" </TD><td class=\"d1\">"+ strCurrBal +" " +applCurrency +"</td></tr></table>");
            //Changes for tracker id 242208 end
            sbfHtmlOutput.append("</body></html>");
			/* PRASHANT'S ML CHANGES : END*/
			/* ABNGC6206:TRACKER#    68406**END   CHANGES** */
			bc.terminate(false);
			out.println(sbfHtmlOutput.toString());
		}catch(AccessLayerNonFatalException e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_TRANSENQ_INTERNAL,'W',CRMOpConsoleErrMessages.ERR_ONLINE_TRANSENQ_INTERNAL + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
			throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBNONFATAL , e);
		}catch(AccessLayerFatalException e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_TRANSENQ_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_ONLINE_TRANSENQ_INTERNAL + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
			throw new SRMBOException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
		}
		/* Change for DBS Ticket 319931 by BADRI : BEGIN */
		catch(CINonFatalException e){
				//System.out.println("\n\n\n\n\n\n Error message:"+e.getMessage());
				if((e.getMessage().indexOf("No record could be retrieved") != -1)){
					sbfHtmlOutput.append("<HTML>");
					sbfHtmlOutput.append("<body>");
					sbfHtmlOutput.append("<align = \"Left\"> No record could be retrieved for the account number : <b>"+strAccountNumber.trim()+"</b>");
					sbfHtmlOutput.append("</body>");
					sbfHtmlOutput.append("</HTML>");
					out.println(sbfHtmlOutput.toString());
				}
		}
		/* Change for DBS Ticket 319931 by BADRI : END */
		catch (Exception e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_TRANSENQ_CIS_UNAVAILABLE,'E',CRMOpConsoleErrMessages.ERR_ONLINE_TRANSENQ_CIS_UNAVAILABLE + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
			//	TRACKER:62101:BEGIN OF CHANGES
			throw new SRMBOException(SRMBOException.ERROR_BANKAWAY_SETUP , e);
		}catch (Throwable e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_TRANSENQ_CIS_UNAVAILABLE,'E',CRMOpConsoleErrMessages.ERR_ONLINE_TRANSENQ_CIS_UNAVAILABLE + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
						//out.println("Set up not Available");
						//out.println("Either Interface or BankAway jars are not in the classpath." + e.getMessage());
			throw new SRMBOException(SRMBOException.ERROR_BANKAWAY_SETUP );

		}
			//	TRACKER:62101:END OF CHANGES
	}
//10.1 Recon Chnages by Mukundhan

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
 //End of Recon Chnages
}
//End of Class






