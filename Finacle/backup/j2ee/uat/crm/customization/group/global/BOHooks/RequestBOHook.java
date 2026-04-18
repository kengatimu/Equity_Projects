/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: RequestBOHook.java $
 *
 * Author: Paritosh
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/RequestBOHook.java $
 *
 * **************************************************************************/
package com.infy.cis.custom;

import com.infy.cis.srmbo.*;
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.exception.*;
import com.infy.cis.custom.OnlineRequest;
import com.infy.cis.custom.CommonQueryFunctions;
import com.infy.cis.log.SRMLog;
import com.infy.cis.log.LogType;
import java.lang.*;
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
/* Files to be imported to send messages to Op-Console */
import com.infy.cis.common.CRMOpConsoleErrCodes;
import com.infy.cis.common.CRMOpConsoleErrMessages;
import com.infy.cis.opc.BCOpConsoleLogMgr;



public class RequestBOHook implements IHooks {


	public RequestBOHook(){}

	/*
	 * The method does all kind of presave processing of the BO.
	 *

	 * @param bc - SRMBusiness Context
	 * @param bo - Business object instance
	 * @return void
	 * @exception SRMPreWriteException - This exception is thrown from the prewrite method of the
	 *	business object hook  file.
	 */
	public void preWrite (SRMBusinessContext bc, Object bo)
    throws SRMPreWriteException {

	/*		This callBankAwayBeans method will be called before the saving of RequestBO to the
			database.
			It first takes the Invcident id from the passed requestControl BO.
			After that it checks for the Status (Open or not ),  Online status (is online or not) ,
			RequestID (for new Incident it will be null , for the editing of the service request it
			will be having some value ) , chec for the type of service request and finally calls
			the appropriate BankAway EJB wrapper methods to fectch the details from the
			Finacle core database.

	*/
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Whoever has to write code , just add it above the existing code inside the prewrite method.
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		       // tracker 65692:begin of changes


			try{

					if( !((RequestBO)bo).getErrorStatus() ){

						 callBankAwayBeans (bc, bo);
						//Exception e1 = new Exception("The Incident Id inside prewrite method is null.");
						//throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL,e1);
					}

//end of changes

		}catch(SRMPreWriteException srmPreWriteEx){
			throw srmPreWriteEx;
		}/*calling the BankAway bean ends*/
	}

	// sample hook - postWrite
	public void postWrite (SRMBusinessContext bc, Object bo)
	throws SRMPostWriteException {
		// customized implementation place holder
	}

	// sample hook - preDelete
	public void preDelete (SRMBusinessContext bc, Object bo)
	throws SRMPreDeleteException {
		// customized implementation place holder

	}

	// sample hook - postDelete
	public void postDelete (SRMBusinessContext bc, Object bo)
	throws SRMPostDeleteException {
		// customized implementation place holder
	 }
	// sample hook - preFill

	public void preFill (SRMBusinessContext bc, Object bo)
	throws SRMPreFillException {
		// customized implementation place holder

	}

	// sample hook - postFill
	public void postFill (SRMBusinessContext bc, Object bo)
	throws SRMPostFillException {
		// customized implementation place holder
	}

/*
 * The method calls the BankAway beans for different type of online service requests.
 *
 * @param bc - Business context
 * @param bo - SRMBO object , later it may be typecasted to respective BO
 * @return void
 * @exception SRMPreWriteException - This exception is thrown from the prewrite method of the bo hook  file.
 */
private void callBankAwayBeans (SRMBusinessContext bc, Object bo)
    throws SRMPreWriteException {
try{

			//Getting the RequestBO object
			RequestBO reqBO = (RequestBO)bo;
			/*If RequestID is null then it is a new service request.*/
			//if(reqBO.getRequestID() == null){
				if( reqBO.getIncidentID() == null){
					Exception e = new FCRMGenericException(new Exception("The Incident Id inside prewrite method is null."));
					throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
				}
				Integer IncidentID = reqBO.getIncidentID();

				final String OnlineBalanceEnquiry				= "OnlineBalanceEnquiry";
				final String OnlineTransactionEnquiry		= "OnlineTransactionEnquiry";
				final String OnlineBillPayment					= "OnlineBillPayment";

				/*TRACKER# 60196 BEGIN CHANGES*/
				final String PlacingFundsAtSubsidaries		= "Place Fund At Subsidiaries";
				/*TRACKER# 60196 END CHANGES*/

				/*TRACKER# 60197***BEGIN OF CHANGES****/
				final String FundsTransfer					= "Account To Account Transfer";
				final String StopCheckPayment				= "Stop Payment On Cheque";
				/*TRACKER# 60197***END OF CHANGES***/

				String strLineSeparator							= System.getProperty("line.separator");


				/*Getting Status , Service Request 	Type , Product Processor , Back End Processor ,
					Account Number and Sales id from the Incidentts table on the basis of Incident ID - Start
				*/

				List incilist=null;
				try{
				incilist = CommonQueryFunctions.getInciData(IncidentID,bc);
			}catch(Exception e){
				e.printStackTrace();
			}
				String  strStatus = null;
				String  strServiceRequestType = null;
				String strAccountNumber= null;
				String strFrontEndProcessor = null;
				String strProductProcessor = null;
				Integer iSalesID = null;
				Date startDate = null;
				Integer orgID = null;
				String  strLink = null;
				String  strRequestClassification = null;


				/*TRACKER# 60196 BEGIN CHANGES*/
				String crmcustid = null;
				/*TRACKER# 60196 END CHANGES*/

				/*TRACKER# 60197***BEGIN OF CHANGES***/
				Integer stepID = null;
				String futureFlag = null;
				String frAccountCat = null;
				/*TRACKER# 60197***END OF CHANGES***/

				if( incilist == null ){
					Exception e = new FCRMGenericException(new Exception("The list retrieved inside prewrite method is null."));
					throw new SRMPreWriteException(SRMBOException.ERROR_RETRIEVINGDATA , e);
				}

				if(incilist.get(4) == null || String.valueOf(incilist.get(4)).trim() == "" ){
					Exception e = new FCRMGenericException("MSGEXC0012",new Exception("Status is null for the incident"));
					throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
				}

				if( incilist.get(6) == null || String.valueOf(incilist.get(6)).trim() == "" ){
					Exception e = new FCRMGenericException("MSGEXC0117",new Exception("Service request type is null for the incident"));
					throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
				}

				 if( incilist.get(7) == null || String.valueOf(incilist.get(7)).trim() == ""  ){
					Exception e = new FCRMGenericException("MSGEXC0118",new Exception("Front End Processor value is null for the incident."));
					throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
				}

				 if( incilist.get(8) == null || String.valueOf(incilist.get(8)).trim() == "" ){
					Exception e = new FCRMGenericException("MSGEXC0119",new Exception("Product processor value is null for the incident."));
					throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
				}

				strStatus = (String)incilist.get(4);
				strServiceRequestType = (String)incilist.get(6);
				strFrontEndProcessor  = (String)incilist.get(7);
				strProductProcessor   = (String)incilist.get(8);
				String caseid =(String)incilist.get(18);
				/*TRACKER# 60197***BEGIN OF CHANGES***/
				futureFlag = (String)incilist.get(17);
				/*TRACKER# 60197***END OF CHANGES***/

				//**CRM62ENH-ONS** Tracker- 58813 change started
				strLink				  = (String)incilist.get(14);
				strRequestClassification   = (String)incilist.get(15);

				RequestControlBO rcbo = Support.getRequestControl(bc,strServiceRequestType,strProductProcessor,strFrontEndProcessor,strLink,strRequestClassification);

				String  strOnlineUpdate = null;
				if( rcbo != null ){
					if( rcbo.getOnlineUpdate() != null ){
						strOnlineUpdate = rcbo.getOnlineUpdate();
					}
					else if(!(rcbo.getProductProcessor().equalsIgnoreCase("ANY"))){
						Exception e = new FCRMGenericException("MSGEXC0120",new Exception("The Online Update value inside prewrite method is null."));
						throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
					}
				}
				else{
						Exception e = new FCRMGenericException("MSGEXC0121",new Exception("The recodset retrieved inside prewrite method is null."));
						throw new SRMPreWriteException(SRMBOException.ERROR_RETRIEVINGDATA , e);
				}

				/* Changes for tracker 181574 -SIT10202 */
				/* Added this logic to enable saving the online request in Draft Mode. */
				if(strStatus.trim().equalsIgnoreCase("Draft")) {
						return;
				}

				/* End of changes for tracker 181574 */

				//**CRM62ENH-ONS** Tracker- 58813 change ended

			/* ***** TRACKER# 46597 ** BEGIN OF CHANGES ***** */
			/*	if(!strStatus.trim().equalsIgnoreCase("Open"))	{
					Exception e = new Exception(" The Incident is not in open state.");
					throw new SRMPreWriteException(SRMBOException.ERROR_INCI_NOT_OPEN , e);
				} */
			/* ***** TRACKER# 46597 ** END OF CHANGES ***** */
				if( strServiceRequestType.trim().equalsIgnoreCase(OnlineBalanceEnquiry)
					|| strServiceRequestType.trim().equalsIgnoreCase(OnlineTransactionEnquiry)
					|| strServiceRequestType.trim().equalsIgnoreCase(OnlineBillPayment)
					|| strServiceRequestType.trim().equalsIgnoreCase(PlacingFundsAtSubsidaries)
					|| strServiceRequestType.trim().equalsIgnoreCase(FundsTransfer)
					|| strServiceRequestType.trim().equalsIgnoreCase(StopCheckPayment)){

					/*If Service Request is online then only proceed*/
					if( strOnlineUpdate.trim().equalsIgnoreCase("N")){
						Exception e = new FCRMGenericException("MSGEXC0122",new Exception("The Service Request  is not online."));
						throw new SRMPreWriteException(SRMBOException.ERROR_SERREQ_NOT_ONLINE , e);
					}
					/* ***** TRACKER# 46597 ** BEGIN OF CHANGES ***** */
					// Only "Open" online incidents will be processed....
					/* FIX FOR TICKET - 263444 CHANGES BEGIN
					* This condition was getting failed when we were saving
					* theincident as the status to be passed is Draft
					* so the condition is modified.
					*/
					if(!(strStatus.trim().equalsIgnoreCase("Open") || strStatus.trim().equalsIgnoreCase("Draft")) )	{
				   /* FIX FOR TICKET - 263444 CHANGES END  */
						Exception e = new FCRMGenericException("MSGEXC0123",new Exception("The Incident is not in open state."));
						throw new SRMPreWriteException(SRMBOException.ERROR_INCI_NOT_OPEN , e);

					}
					/* ***** TRACKER# 46597 ** END OF CHANGES ***** */



						 //Doing processing  for the open state of the Incident only
						 if( incilist.get(3) == null || String.valueOf(incilist.get(3)).trim() == ""  ){

							Exception e = new FCRMGenericException("MSGEXC0052");
						throw new SRMPreWriteException(SRMBOException.ERROR_BANKAWAY_EJBNONFATAL, e);

						}


					 if( incilist.get(9) == null ){
						Exception e = new FCRMGenericException("MSGEXC0125",new Exception("Start date value is null for the incident."));
						throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
					}


					if( incilist.get(13) == null ){
						Exception e = new FCRMGenericException("MSGEXC0018",new Exception("The org id  is null for the account."));
						throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
					}

					strAccountNumber = (String)incilist.get(3);
					startDate = (Date)incilist.get(9);
					orgID = (Integer)incilist.get(13);
					/*Getting Status , Service Request 	Type , Product Processor , Back End Processor ,
						Account Number and Sales id from the Incidents table on the basis of Incident ID - End
					*/



					Integer incidentID=   IncidentID;//got from RequestBO
					/*Getting different values from the Sales table on the basis of Account Number- Start*/

					List saleslist = CommonQueryFunctions.getSalesData( strAccountNumber , bc );

					if( saleslist == null ){
						Exception e = new FCRMGenericException(new Exception("The list retrieved inside prewrite method is null."));
						throw new SRMPreWriteException(SRMBOException.ERROR_RETRIEVINGDATA , e);
					}
					Integer isalesid = null;
					String productsKey = null;
					String accBranchCode = null;
					Integer prodCatID = null;

					if( saleslist.get(0) == null ){
						Exception e = new FCRMGenericException("MSGEXC0128",new Exception("The sales id is null for the account."));
						throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
					}
					if( saleslist.get(3) == null || String.valueOf(saleslist.get(3)).trim() == "" ){
						Exception e = new FCRMGenericException("MSGEXC0016",new Exception("The account branch code is null for the account."));
						throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
					}

					if( saleslist.get(4) == null ){
						Exception e = new FCRMGenericException("MSGEXC0017",new Exception("The prod cat id is null for the account"));
						throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
					}
			/*		if( saleslist.get(5) == null ){
						Exception e = new Exception("The org id  is null for the account.");
						throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
					} */
					isalesid = (Integer)saleslist.get(0);
					accBranchCode = (String)saleslist.get(3);
					prodCatID = (Integer)saleslist.get(4);
	//				orgID = (Integer)saleslist.get(5);

					/*TRACKER# 60196 BEGIN CHANGES */
					crmcustid = (String)incilist.get(16);
					/*TRACKER# 60196 END CHANGES */

					/****TRACKER# 60197 ***BEGIN OF CHANGES****/
					frAccountCat = (String)saleslist.get(1);
					stepID = (Integer)incilist.get(2);
					/****TRACKER# 60197 ***END OF CHANGES****/

					/*Getting different values from the Sales table on the basis of Account Number- End*/

					/*Getting account currency from the table SaleBackEnd on the basis of SalesID - Start*/
					List saleBackEndList = CommonQueryFunctions.getSaleBackEndData( isalesid , bc );
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


					/*applCurrency = CommonQueryFunctions.getDataFromRefCodeMapper( "CURRENCY"
																																	,	applCurrency
																																	,	null);
					*/

/*					accBranchCode = CommonQueryFunctions.getDataFromRefCodeMapper( "SERVICE_OUTLET"
																																		, accBranchCode.trim()
																																		, null);

*/					if( accBranchCode == null || accBranchCode.trim().equals("")){
						Exception e = new FCRMGenericException(new Exception("Account branch code retrieved from RefCodeMapper is null."));
						throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
					}

					/*Getting Account Type Description from the ProductCategory table on the basis of
						ProdCatID -Start
					*/
					String  accountType= CommonQueryFunctions.getAccountType( prodCatID , bc ) ;
					if( accountType == null || accountType.trim().equals("") ){
						Exception e = new FCRMGenericException("MSGEXC0134",new Exception("Account type description inside prewrite method is null."));
						throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
					}
					/*Getting Account Type Description from the ProductCategory table on the basis of
					ProdCatID -End
					*/
/*					accountType = CommonQueryFunctions.getDataFromRefCodeMapper( "PRODUCT_CATEGORY"
																																	,	accountType.trim()
																																	,	null );
*/					if( accountType == null || accountType.trim().equals("")){
						Exception e = new FCRMGenericException(new Exception("Account type retrieved from RefCodeMapper is null."));
						throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
					}


					/*Getting the values from EJB for the Account balance - Start
					*/
					if(strServiceRequestType!= null && strServiceRequestType.equalsIgnoreCase(OnlineBalanceEnquiry) ){

						OnlineRequest.proceedForAccountBalance(	IncidentID
																	,	strAccountNumber.trim()
																	,	accBranchCode.trim()
																	,	applCurrency.trim()
																	,	accountType.trim()
																	,	orgID
																	,	reqBO
																	,	bc
																	);

					}/*Getting the values from EJB for the Account balance - End	*/


							/*Checking  the type of service request and if it relates to Last n Transaction Enquiry,
							then calling the appropriate EJB wrapper methods to get the data. - Start
							*/
					if(strServiceRequestType!= null
						&& strServiceRequestType.equalsIgnoreCase(OnlineTransactionEnquiry) ){
						OnlineRequest.proceedForLast10Txn(	IncidentID
															,	strAccountNumber.trim()
															,	accBranchCode.trim()
															,	applCurrency.trim()
															,	accountType.trim()
															,	orgID
															,	reqBO
															,	bc
															);

					}/*Check to determine the Last n transaction enquiry  - End */

							/*Getting the values from EJB for the Hot Payment of the bill- Start
							*/
					if(strServiceRequestType!= null && strServiceRequestType.equalsIgnoreCase(OnlineBillPayment) ){

						OnlineRequest.proceedForBillPayment(	IncidentID
															,	strAccountNumber.trim()
															,	accBranchCode.trim()
															,	applCurrency.trim()
															,	accountType.trim()
															,	orgID
															,	reqBO
															,	bc
															,	startDate
															,   caseid
															);

					}/*Getting the values from EJB for the Hot Payment of the bill - End	*/

					/*TRACKER 60196 BEGIN CHANGES*/
					if(strServiceRequestType!= null && strServiceRequestType.equalsIgnoreCase(PlacingFundsAtSubsidaries) ){

											OnlineRequest.proceedForFundsPlacement(	IncidentID ,
																					strAccountNumber.trim() ,
																					accBranchCode.trim() ,
																					applCurrency.trim() ,
																					accountType.trim() ,
																					crmcustid ,
																					reqBO ,
																					bc ,
																					startDate
																				  );
					}
					/*TRACKER 60196 END CHANGES*/

					/*TRACKER# 60197 ***BEGIN OF CHANGES ****/
					if(strServiceRequestType!= null && strServiceRequestType.equalsIgnoreCase(StopCheckPayment) ){

											if(futureFlag.equalsIgnoreCase("Y")) {
												return;
											}
											OnlineRequest.stopCheck(	IncidentID ,
																		strAccountNumber.trim() ,
																		accBranchCode.trim() ,
																		crmcustid ,
																		reqBO ,
																		bc ,
																		stepID,
																		caseid
																	  );

				}
					if(strServiceRequestType!= null && strServiceRequestType.equalsIgnoreCase(FundsTransfer) ){

						OnlineRequest.proceedForFundsTransfer(	IncidentID ,
																strAccountNumber.trim() ,
																accBranchCode.trim() ,
																accountType.trim() ,
																frAccountCat.trim() ,
																applCurrency.trim() ,
																crmcustid ,
																reqBO ,
																bc ,
																startDate
															);
					}
					/*TRACKER# 60197 ***END OF CHANGES ****/


				}
				//**CRM62ENH-ONS** Tracker- 58813 change started
				else {
					if(strOnlineUpdate != null && strOnlineUpdate.trim().equalsIgnoreCase("Y")){

					 	new OnlineServiceWrapper().proceedForOnlineRequests(reqBO,bc,"Online");

					}

				}
				//**CRM62ENH-ONS** 58813 change ended
				/*service Rquest Type check -End*/
			//}/*Request id null check - End*/
		}catch(SRMPreWriteException pr){
			throw pr;
		}catch(CISInvalidArgumentException invalidArgument){
			throw new SRMPreWriteException( SRMBOException.ERROR_INVALID_ATTRIB_VALUE , invalidArgument);
		}catch(Exception e){
			throw new SRMPreWriteException( SRMBOException.ERROR_INSIDE_HOOK , e);
		}catch(Throwable e){
			String strMessage = e.getMessage();
			Exception exp = new FCRMGenericException(new Exception("BankAway or Interface jars are not in the classpath. Unable to find the class "+strMessage));
			/* SPE Changes - logging changes */
			SRMLog logger = new SRMLog("Support",LogType.getLogType(SRMLog.sysLogLevel));
			/* SPE Changes - logging changes */
			logger.write ( LogType.DEBUG, exp.getMessage() );
			//throw new SRMPreWriteException( SRMBOException.ERROR_INSIDE_HOOK , exp);
		}
	}

}/* End of the class*/




