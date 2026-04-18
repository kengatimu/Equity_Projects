package com.infy.cis.custom;

import java.util.Date;
import java.util.List;
import java.io.*;

import javax.servlet.http.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.exception.*;
import com.infy.cis.common.*;
import com.infy.cis.ui.common.*;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.servletruntime.*;

import com.infosys.bankaway.accesslayer.user.*;
/*Tracker 103058 : FI Call Change :Start
import com.infosys.bankaway.accesslayer.accounts.*;
import com.infosys.bankaway.accesslayer.bills.*;
Tracker 103058 : FI Call Change :End*/
import com.infosys.bankaway.accesslayer.bwyinterface.*;
/* Files to be imported to send messages to Op-Console */
import com.infy.cis.common.CRMOpConsoleErrCodes;
import com.infy.cis.common.CRMOpConsoleErrMessages;
import com.infy.cis.opc.BCOpConsoleLogMgr;


public class OnlinePlFundsSubs extends CISHttpServlet
{
    public static String CIS_COPYRIGHT_="Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.";
    public static String CIS_VERSION_="2.00 $Revision: 1.1.1.1.2.1 $";
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
		String strAccountNumber = (String)incilist.get(3);
		Date startDate = (Date)incilist.get(9);
		Integer stepID = (Integer)incilist.get(2);
		String crmcustid = (String)incilist.get(16);
		List saleslist = CommonQueryFunctions.getSalesData( strAccountNumber , bc );

		Integer isalesid = (Integer)saleslist.get(0);
		String accBranchCode = (String)saleslist.get(3);
		Integer prodCatID = (Integer)saleslist.get(4);
		//Integer orgID = (Integer)saleslist.get(5);
		List saleBackEndList = CommonQueryFunctions.getSaleBackEndData( isalesid , bc );

		String applCurrency = (String)saleBackEndList.get(1);

		accBranchCode = CommonQueryFunctions.getDataFromRefCodeMapper( "SERVICE_OUTLET"
																		, accBranchCode.trim()
																		, null);

		/*Getting Account Type Description from the ProductCategory table on the basis of
			ProdCatID -Start
		*/
		String  accountType= CommonQueryFunctions.getAccountType( prodCatID , bc ) ;

		accountType = CommonQueryFunctions.getDataFromRefCodeMapper( "PRODUCT_CATEGORY"
																	,	accountType.trim()
																	,	null );
		String html = proceedForFundPlacement(	incidentID ,
								strAccountNumber.trim() ,
								accBranchCode.trim() ,
								applCurrency.trim() ,
								accountType.trim()	,
								crmcustid ,
								reqBO ,
								bc	,
								startDate,
								stepID );

		out.println(html);
	}

	/*
	 * The method calls the BankAway beans for online bill payment.
	 *
	 * @param IncidentID - Incident Id
	 * @param strAccountNumber - Finacle Account number
 	 * @param accBranchCode - Finacle Branch Code
	 * @param applCurrency - Finacle Currency
	 * @param accountType - Finacle Account Type (ex. TDA , LAA)
	 * @param crmcustid - CRM Cust Id
	 * @param reqBO - Request BO object
	 * @param bc - SRMBusiness Context
	 * @param startDate - Start date of the incident/Service Request
	 * @param stepID -Current Step
	 * @return void
	 * @exception SRMPreWriteException - This exception is thrown from the prewrite method of the bo hook  file.
	 */
	public static String proceedForFundPlacement(	Integer IncidentID ,
												String strAccountNumber ,
												String accBranchCode ,
												String applCurrency ,
												String accountType ,
												String crmcustid ,
												RequestBO reqBO ,
												SRMBusinessContext bc ,
												Date startDate ,
												Integer stepID
												) throws Exception{
		String strLineSeparator			= System.getProperty("line.separator");
		String strHyphen						= "-";

		String strMakeHotPayment = reqBO.getUserStrField5();

		if( reqBO.getUserStrField1() == null || String.valueOf(reqBO.getUserStrField1()).trim() == "" ){
			return getHTML("The Pay to field is null.");
			//Exception e = new Exception("The Pay to field method is null.");
			//throw(e);
		}

		String strPayTo = reqBO.getUserStrField1();

		int indexOfHyphen = strPayTo.trim().lastIndexOf(strHyphen) + 1;
		strPayTo = strPayTo.trim().substring(indexOfHyphen);

		if( reqBO.getUserAmountField1() == null){
			return getHTML("The funds amount is null.");
			//Exception e = new Exception("The bill payment amount method is null.");
			//throw e;
		}

		String strTxnCurrency = 	applCurrency;
		Double BillPayAmt = reqBO.getUserAmountField1();


		if( reqBO.getUserStrField2() == null || String.valueOf(reqBO.getUserStrField2()).trim() == "" ){
			//Exception e = new Exception("The consumer code  method is null.");
			//throw e;
			return getHTML("The credit card number is null.");
		}

		String strConsumerCode = 	reqBO.getUserStrField2();


		String strPaymentRemarks = reqBO.getUserTextField1();
		//	Output object from EJB wrapper class
		//OnlinePaymentsOutputVO payOutputVO = new OnlinePaymentsOutputVO();

		try{
			//payOutputVO = new OnlinePaymentsOutputVO();

			//CRM70SIT Commented temporariy as the signature changes are not yet done
			/*BankAwayEJBCalls.PaymentThroughBean( strAccountNumber ,
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
		}catch(Exception e){
			//throw e;
			/* Calling the static method writeToOPConsole() of BCOpConsoleLogMgr for sending message to Op-Console */
				BCOpConsoleLogMgr.writeToOPConsole("BOHOK",CRMOpConsoleErrCodes.ERR_FUNDS_TRANSFER,'E',CRMOpConsoleErrMessages.ERR_FUNDS_TRANSFER + e.getMessage(),'L',bc);
			/* Message has been sent to Op-Console */
			//CommonQueries.UpdateIncident( bc , IncidentID , "Error" , stepID , e.getMessage() , "" + payOutputVO.getReferenceId() , false , null , null );
			return getHTML(e.getMessage());
		}

		StringBuffer notes = new  StringBuffer();
		//notes.append("Payee List Id:"+payOutputVO.getPayeeListId());
		notes.append(strLineSeparator);
		//notes.append("Reference Id:"+payOutputVO.getReferenceId());
		notes.append(strLineSeparator);
		//notes.append("Schedule Id:"+payOutputVO.getScheduleId());
		//Setting te Additional Notes attribute of the Incident with the response from Bean
		try{
			//CommonQueries.UpdateIncident( bc , IncidentID , "Open" , stepID , notes.toString() , "" + payOutputVO.getReferenceId() , true , null , null );
			//Setting  the UserStrField100 to the value "Display" so that after the saving the main form should not close
			//reqBO.setOnlineAttribute("Display");

			StringBuffer sbfHtmlOutput = new StringBuffer();
			sbfHtmlOutput.append("<HTML>");
			sbfHtmlOutput.append("<Title>Fund Placement Details</Title><Head>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMTableDisplay.css'/>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/Popup.css'/>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMListTemplate.css'/>");
			sbfHtmlOutput.append("<script type=\"text/javascript\" src=\"../custom/js/online.js\" language=\"javascript\"></script>");
			sbfHtmlOutput.append("</Head><body class='popup' onload='init()'><br>");
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
			sbfHtmlOutput.append("<script>refreshParent()</script></body></html>");
			//Forming the html string for out put - end
			reqBO.setUserTextField5(sbfHtmlOutput.toString());
			return sbfHtmlOutput.toString();
		}catch(Exception e){
			//e.printStackTrace();
			//throw e;
			return getHTML(e.getMessage());
		}
	}

	private static String getHTML(String message) {
		StringBuffer sbfHtmlOutput = new StringBuffer();
		sbfHtmlOutput.append("<HTML>");
		sbfHtmlOutput.append("<Title>Online Fund Transfer </Title><Head>");
		sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMTableDisplay.css'/>");
		sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/Popup.css'/>");
		sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMListTemplate.css'/>");
		sbfHtmlOutput.append("</Head><body class='popup' onload='init()'><br>");
		sbfHtmlOutput.append("<br>");
		sbfHtmlOutput.append("<br>");
		sbfHtmlOutput.append("<b> "+message+"</b>");
		sbfHtmlOutput.append("<br>");
		return sbfHtmlOutput.toString();
	}


}

