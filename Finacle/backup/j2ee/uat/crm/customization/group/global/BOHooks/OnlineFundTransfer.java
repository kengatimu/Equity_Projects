package com.infy.cis.custom;

import java.util.Date;
import java.util.List;
import java.io.*;
//10.4SPE Changes :BEGIN
import java.util.Locale;
//10.4SPE Changes :END

import javax.servlet.http.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.exception.*;
import com.infy.cis.common.*;
import com.infy.cis.ui.common.*;

import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.servletruntime.*;
/*Tracker 103058 : FI Call Change :Start
import com.infosys.bankaway.accesslayer.accounts.*;
Tracker 103058 : FI Call Change :End*/
import com.infosys.bankaway.accesslayer.user.*;
//import com.infosys.bankaway.accesslayer.fundstransfer.*;
import com.infosys.bankaway.accesslayer.bwyinterface.*;
/* Files to be imported to send messages to Op-Console */
import com.infy.cis.common.CRMOpConsoleErrCodes;
import com.infy.cis.common.CRMOpConsoleErrMessages;
import com.infy.cis.opc.BCOpConsoleLogMgr;

public class OnlineFundTransfer extends CISHttpServlet
{
    public static String CIS_COPYRIGHT_="Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.";
    public static String CIS_VERSION_="2.00 $Revision: 1.5 $";
    /* $NoKeywords: $ */

	protected void serviceRequest(HttpServletRequest req, HttpServletResponse res)
    throws Exception {

		CISSessionContext sc = context.getSessionContext(req);

        HttpServletResponse resp = res ;
        SRMBusinessContext bc = null;
        bc = Utils.getBusinessContext(req);
        PrintWriter out = resp.getWriter();
        setContentType("text/html", resp);
		String strIncidentID = req.getParameter( "objectId" );
		Integer incidentID = new Integer(strIncidentID);
		List incilist = CommonQueryFunctions.getInciData(incidentID , bc );
		RequestBO reqBO = CommonQueryFunctions.getRequestData(bc,incidentID,false);

		String strStatus = (String)incilist.get(4);
		String frAccNumber = (String)incilist.get(3);
		Date startDate = (Date)incilist.get(9);
		Integer stepID = (Integer)incilist.get(2);
		String crmcustid = (String)incilist.get(16);
		List saleslist = CommonQueryFunctions.getSalesData( frAccNumber , bc );
		Integer isalesid = (Integer)saleslist.get(0);
		String frAccBranchCode = (String)saleslist.get(3);
		Integer prodCatID = (Integer)saleslist.get(4);
		//Integer orgID = (Integer)saleslist.get(5);
		String frAccountCat = (String)saleslist.get(1);
		List saleBackEndList = CommonQueryFunctions.getSaleBackEndData( isalesid , bc );
		String frAccCurrency = (String)saleBackEndList.get(1);
		frAccBranchCode = CommonQueryFunctions.getDataFromRefCodeMapper( "SERVICE_OUTLET"
																		, frAccBranchCode.trim()
																		, null);
		String  frAccountType= CommonQueryFunctions.getAccountType( prodCatID , bc ) ;
		frAccountType = CommonQueryFunctions.getDataFromRefCodeMapper( "PRODUCT_CATEGORY"
																	,	frAccountType.trim()
																	,	null );
		String toAccNumber = reqBO.getUserStrField3();
		saleslist = CommonQueryFunctions.getSalesData( toAccNumber , bc );
		isalesid = (Integer)saleslist.get(0);
		String toAccBranchCode = (String)saleslist.get(3);
		prodCatID = (Integer)saleslist.get(4);
		String toAccountCat = (String)saleslist.get(1);
		saleBackEndList = CommonQueryFunctions.getSaleBackEndData( isalesid , bc );
		String toAccCurrency = (String)saleBackEndList.get(1);
		toAccBranchCode = CommonQueryFunctions.getDataFromRefCodeMapper( "SERVICE_OUTLET"
																		, toAccBranchCode.trim()
																		, null);

		String  toAccountType= CommonQueryFunctions.getAccountType( prodCatID , bc ) ;
		toAccountType = CommonQueryFunctions.getDataFromRefCodeMapper( "PRODUCT_CATEGORY"
																	,	toAccountType.trim()
																	,	null );
		String Txn_Crncy = 	reqBO.getUserStrField1();
		Double Txn_Amount = reqBO.getUserAmountField1();
		String isThirdParty = reqBO.getUserStrField11();

		String html = doFundTransfer(	incidentID ,
										frAccNumber ,
										frAccBranchCode ,
										Txn_Crncy ,
										frAccountType ,
										frAccountCat ,
										frAccCurrency ,
										toAccNumber ,
										toAccBranchCode ,
										toAccountType ,
										toAccountCat ,
										toAccCurrency ,
										Txn_Amount ,
										crmcustid ,
										isThirdParty ,
										reqBO ,
										bc ,
										startDate ,
										stepID
									 );

		out.println(html);
	}

	public static String doFundTransfer	(	Integer incidentID ,
											String fromAccNumber ,
											String fromAccBranchCode ,
											String Txn_Crncy ,
											String fromAccountType ,
											String fromAccountCat ,
											String fromAccountCurrency ,
											String toAccNumber ,
											String toAccBranchCode ,
											String toAccountType ,
											String toAccountCat ,
											String toAccountCurrency ,
											Double Txn_Amount ,
											String crmcustid ,
											String isThirdParty ,
											RequestBO reqBO ,
											SRMBusinessContext bc ,
											Date startDate ,
											Integer stepID
										) {

		//	Output object from EJB wrapper class
		//FtOutputAccessVO opAccessVO = new FtOutputAccessVO();
		StringBuffer notes = new  StringBuffer();

		try{
			//CRM70SIT - Commented temporarily as the signature change is not yet complete
			/*opAccessVO = BankAwayEJBCalls.doFundTransfer( fromAccNumber ,
														fromAccBranchCode ,
														Txn_Crncy ,
														fromAccountType ,
														fromAccountCat ,
														fromAccountCurrency ,
														toAccNumber ,
														toAccBranchCode,
														toAccountType ,
														toAccountCat ,
														toAccountCurrency ,
														Txn_Amount.doubleValue() ,
														crmcustid ,
														isThirdParty
													) ;
													*/
		}catch(Exception e){
			notes.append(e.getMessage());
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_FUNDS_TRANSFER,'E',CRMOpConsoleErrMessages.ERR_FUNDS_TRANSFER + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
			return getHTML("Error :"+e.getMessage());
		}
		try{
			/*if(opAccessVO.getResCode().equals("000")) {
				notes.append("Fund Transfer from account number "+fromAccNumber);
				notes.append(" to account number "+toAccNumber + " successfull!");
				CommonQueries.UpdateIncident( bc , incidentID , "Open" , stepID , notes.toString() , "" + opAccessVO.getRequestId() , true , null , null );
			} else {
				notes.append("Error ");
				CommonQueries.UpdateIncident( bc , incidentID , "Error" , stepID , "Error :"+notes.toString() , "" + opAccessVO.getRequestId() , false , null , null );
			}*/

			//Forming the html string for out put - end
			reqBO.setUserTextField5(getHTML(notes.toString()));
			return getHTML(notes.toString());
		}catch(Exception e){
			e.printStackTrace();
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_FUNDS_TRANSFER,'E',CRMOpConsoleErrMessages.ERR_FUNDS_TRANSFER + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
			return getHTML("Error :"+e.getMessage());
		}
	}

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
		sbfHtmlOutput.append("</Head><body class='popup' onload='init()'><br>");
		sbfHtmlOutput.append("<br>");
		sbfHtmlOutput.append("<br>");
		sbfHtmlOutput.append("<b><font color=\"red\"> "+message+"</font></b>");
		sbfHtmlOutput.append("<br>");
		return sbfHtmlOutput.toString();
	}

}

