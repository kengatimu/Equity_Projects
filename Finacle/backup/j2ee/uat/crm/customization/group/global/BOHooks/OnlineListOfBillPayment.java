/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: OnlineListOfBillPayment.java $
 *
 * Author: Paritosh
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/OnlineListOfBillPayment.java $
 * *******************  Version 1 *****************
 * User: balaji_bk Date: 13/11/06    Time: 10:06
 * Updated in $/CRM10095/com/infy/cis/custom/BOHooks/
 * Tracker Id : 101563
 * Modified By : Balaji.B.K.
 * Reviewed By : Karthisathasivan.M.K
 * **************************************************************************/
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
import com.infy.cis.common.BankAwayEJBCalls;

import com.infosys.bankaway.accesslayer.user.*;
/*Tracker 103058 : FI Call Change :Start
import com.infosys.bankaway.accesslayer.bills.*;
Tracker 103058 : FI Call Change :End*/
import com.infosys.bankaway.accesslayer.bwyinterface.*;
/* Files to be imported to send messages to Op-Console */
import com.infy.cis.common.CRMOpConsoleErrCodes;
import com.infy.cis.common.CRMOpConsoleErrMessages;
import com.infy.cis.opc.BCOpConsoleLogMgr;


public class OnlineListOfBillPayment extends CISHttpServlet {

	public void serviceRequest ( HttpServletRequest req, HttpServletResponse resp)
	throws Exception
    {
		setContentType("text/html", resp);
		PrintWriter out = resp.getWriter();

		StringBuffer sbfHtmlOutput = new StringBuffer();
		/** CRM9.5 to CRM10.1  CRM95ST CHANGES  recon Start*/ //TrackerID: 101563
		final java.util.Locale locale1 =
				((com.infy.cis.servletruntime.CISSessionContext)
				com.infy.cis.common.SRMTLVar.sc.get()).getSessionLocale();
	    final String fcrmlocale = locale1.toString();
		/** CRM9.5 to CRM10.1  CRM95ST CHANGES  recon End*/
		/*Getting bc */
		SRMBusinessContext bc = Utils.getBusinessContext(req,
		java.sql.Connection.TRANSACTION_READ_UNCOMMITTED);
		try{
			/*getting account id */
			String strAccountID = 	req.getParameter("accountId");
			if( strAccountID == null || strAccountID.trim() == "" ){
				throw new FCRMGenericException("MSGEXC0035",new Exception("The requested Account id  is null."));
			}

			/// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
			String orgKey = CommonQueryFunctions.getOrgKey (new Integer(strAccountID), bc);
			/// NCB_226, TRACKER# 51444, END OF CHANGES

			int index = 0;
			int printIndex = 0;
			sbfHtmlOutput.append("<HTML>");
			sbfHtmlOutput.append("<Title>"+ this.getSystemString("Default", "Title") +"</Title><Head>");
			/** CRM9.5 to CRM10.1  CRM95ST CHANGES  recon Start*/ //TrackerID: 101563
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMTableDisplay_"+fcrmlocale +".css'/>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/Popup_"+fcrmlocale +".css'/>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMListTemplate_"+fcrmlocale +".css'/>");
			/** CRM9.5 to CRM10.1  CRM95ST CHANGES  recon End*/
			sbfHtmlOutput.append("</Head><body class='popup'><br>");
			sbfHtmlOutput.append("<br>");

			/*Contacting the  Hot Bill Payment ejb - start*/
			//PaymentsMadeOutputAccessVO paymentsMadeOutput = new	PaymentsMadeOutputAccessVO();

			/// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
			/// Vector paymentsMadeList = BankAwayEJBCalls.getHotPaymentList(strAccountID.trim()) ;
			Vector paymentsMadeList = new Vector();
			//CRM70SIT - Commented temporarily as the signature change is not yet complete
			//BankAwayEJBCalls.getHotPaymentList(orgKey) ;


			/// NCB_226, TRACKER# 51444, END OF CHANGES

			if ( paymentsMadeList != null ){
				sbfHtmlOutput.append("<table cellPadding=0 cellSpacing=1 border=true align=center class=\"background\" width=\"100%\">");
				sbfHtmlOutput.append("<tr> <td align=center class=\"tableHeader\" width=\"100%\">List of Hot Payments Done</td></tr></table>");
				/** CRM9.5 to CRM10.1  CRM95ST CHANGES  recon Start*/ //TrackerID: 101563
				sbfHtmlOutput.append("<table border=true align=center><tr><td align=left class=\"colHeader\">Sl. No.</td>");
				sbfHtmlOutput.append("<td align=left class=\"colHeader\">Payment Id</td>");
				sbfHtmlOutput.append("<td align=left class=\"colHeader\">Payee Name</td>");
				sbfHtmlOutput.append("<td align=left class=\"colHeader\">Payment Date</td>");
				sbfHtmlOutput.append("<td align=left class=\"colHeader\">Payment Amount</td>");
				sbfHtmlOutput.append("<td align=left class=\"colHeader\">Currency</td>");
				sbfHtmlOutput.append("<td align=left class=\"colHeader\">Payment Status</td></tr>");
				/** CRM9.5 to CRM10.1  CRM95ST CHANGES  recon End*/
				/*for ( index = 0; index < paymentsMadeList.size();index++){
					paymentsMadeOutput = (PaymentsMadeOutputAccessVO)paymentsMadeList.get(index);
					printIndex = index+1;
					sbfHtmlOutput.append("<tr><td align=center class=\"tableHeader\">"+ printIndex + "</td>");

					sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+paymentsMadeOutput.getPaymentId()+ "</td>");
					sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+paymentsMadeOutput.getPayeeName() + "</td>");
					sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+paymentsMadeOutput.getPaymentDate()+ "</td>");
					sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+paymentsMadeOutput.getPaymentAmount()+ "</td>");
					sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+paymentsMadeOutput.getCurrency()+ "</td>");
					sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+paymentsMadeOutput.getPaymentStatus()+ "</td></tr>");
				}*/
					sbfHtmlOutput.append("</table><br><br>");
			}else{
			   sbfHtmlOutput.append("<br><P align=center \"fntColData\">There is no Hot Payment associated" +
			   "with the customer.");
			}

			/*Contacting the Hot Bill Payment ejb - end*/

			/*Contacting the Scheduled  Bill Payment ejb - start*/
			//PaymentsScheduledOutputAccessVO schedOutputAccessVO = new PaymentsScheduledOutputAccessVO();
			/// NCB_226, TRACKER# 51444, BEGIN OF CHANGES
			/// Vector schedPaymentsList = BankAwayEJBCalls.getScheduledPaymentList(strAccountID.trim()) ;
			Vector schedPaymentsList = new Vector();

			//CRM70SIT Commented temporariy as the signature changes are not yet done
			//BankAwayEJBCalls.getScheduledPaymentList(orgKey);
			/// NCB_226, TRACKER# 51444, END OF CHANGES

			if ( schedPaymentsList != null ){
				sbfHtmlOutput.append("<table cellPadding=0 cellSpacing=1 border=true align=center class=\"background\" width=\"100%\">");
				sbfHtmlOutput.append("<tr> <td align=center class=\"tableHeader\" width=\"100%\">List of Scheduled Payments Done</td></tr></table>");
			/** CRM9.5 to CRM10.1  CRM95ST CHANGES  recon Start*/ //TrackerID: 101563
				sbfHtmlOutput.append("<table border=true align=center><tr><td align=left class=\"colHeader\">Sl. No.</td>");
				sbfHtmlOutput.append("<td align=left class=\"colHeader\">Schedule Id</td>");
				sbfHtmlOutput.append("<td align=left class=\"colHeader\">Consumer Code</td>");
				sbfHtmlOutput.append("<td align=left class=\"colHeader\">Payee Name</td>");
				sbfHtmlOutput.append("<td align=left class=\"colHeader\">Instance Amount</td>");
				sbfHtmlOutput.append("<td align=left class=\"colHeader\">Currency</td>");
				sbfHtmlOutput.append("<td align=left class=\"colHeader\">Schedule Status</td>");
				sbfHtmlOutput.append("<td align=left class=\"colHeader\">Instance Payment Date</td></tr>");
			/** CRM9.5 to CRM10.1  CRM95ST CHANGES  recon End*/
				/*for ( index = 0; index < schedPaymentsList.size();index++){
					schedOutputAccessVO = (PaymentsScheduledOutputAccessVO) schedPaymentsList.get(index);
					printIndex = index+1;
					sbfHtmlOutput.append("<tr><td align=center class=\"tableHeader\">"+printIndex + "</td>");

					sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+schedOutputAccessVO.getScheduleId()+ "</td>");
					sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+schedOutputAccessVO.getConsumerCode()+ "</td>");
					sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+schedOutputAccessVO.getPayeeName() + "</td>");
					sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+schedOutputAccessVO.getInstanceAmount()+ "</td>");
					sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+schedOutputAccessVO.getCurrency()+ "</td>");
					sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+schedOutputAccessVO.getScheduleStatus()+ "</td>");
					sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+schedOutputAccessVO.getInstancePaymentDate()+ "</td></tr>");
				}*/
					sbfHtmlOutput.append("</table><br>");
			}/*Contacting the Scheduled Bill payment ejb - end*/
			else{
			   sbfHtmlOutput.append("<br><P align=center \"fntColData\">There is no Scheduled Payment associated" +
			   "with the customer.");
			}
			sbfHtmlOutput.append("</body></html>");
			out.println(sbfHtmlOutput.toString());
			bc.terminate(false);
		}catch(AccessLayerNonFatalException e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_BILPAY_FETCH,'W',CRMOpConsoleErrMessages.ERR_ONLINE_BILPAY_FETCH + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
			throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBNONFATAL , e);
		}catch(AccessLayerFatalException e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_BILPAY_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_ONLINE_BILPAY_FETCH + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
			throw new SRMBOException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
		}catch (Exception e){
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_ONLINE_BILPAY_INTERNAL,'E',CRMOpConsoleErrMessages.ERR_ONLINE_BILPAY_FETCH + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
			throw new SRMBOException(SRMBOException.ERROR_BANKAWAY_EJBFATAL , e);
		}catch (Throwable e){
			out.println("Either Interface or BankAway jars are not in the classpath." + e.getMessage());
		}


	}
}//End of Class

