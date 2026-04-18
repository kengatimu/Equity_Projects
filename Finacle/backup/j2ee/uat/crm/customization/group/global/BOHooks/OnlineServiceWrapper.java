/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: OnlineServiceWrapper.java $
 *
 * Author: Aravinda
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/OnlineServiceWrapper.java $/FCRM62BASE/com/infy/cis/custom
 * TrackerID: 61729
 *
 * Changes: Added code for Handling new Service request
 * as well as change the existing code to support
 * new requirments
 *
 * Modified By:
 * Abhinav Srivastava
 *
 * Reviewed By:
 * Nixon.
 * * *****************  Version 2  *************************
 */


package com.infy.cis.custom;

//Changes for ticket id 596751 and recon for call id 306538 starts
import java.util.Date;
import java.text.ParseException;
//Changes for ticket id 596751 and recon for call id 306538 ends
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
/*Tracker 103058 : FI Call Change :Start
import com.infy.intl.adapter.RefCodeMapper;
import com.infy.intl.exception.*;
import com.infy.intl.crmdaemons.*;
import com.infosys.bankaway.accesslayer.bwyinterface.CIRemoteAccessInterface;
import com.infosys.bankaway.accesslayer.bwyinterface.CIHostMarker;
Tracker 103058 : FI Call Change :End*/
import com.infy.cis.adaptor.web.WebAdaptor;
import java.text.SimpleDateFormat;
import com.infy.cis.srmbo.*;
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.exception.*;
import com.infy.cis.custom.OnlineRequest;
import com.infy.cis.custom.CommonQueryFunctions;
import com.infy.cis.ui.common.CommonQueries;
import com.infosys.ci.common.Amount;//Fix for tracker 146668
import com.infosys.ci.common.*;
import com.infy.cis.ui.common.*;
import com.infosys.ci.ons.common.*;
import com.infosys.ci.ons.cistruct.*;
//import com.infosys.ci.ons.ejb.*;  //changes for Tracker ID 457945 - TOL 456055
import com.infosys.bankaway.accesslayer.bwyinterface.*;
import com.infy.cis.jndi.*;
import com.infy.cis.exception.FCRMGenericException;
// Begin of changes
import com.infosys.ci.ons.cistruct.CIDDMassIssueInputDetails;
import com.infosys.ci.ons.cistruct.CIDDMassIssueLL;
import com.infosys.ci.ons.cistruct.CIDDMassIssueOutDetails;
import com.infosys.bankaway.accesslayer.bwyinterface.OnsSrvRequestALImplementation;
import com.infosys.ci.ons.cistruct.CIDDMassIssueHdrDtl;
import com.infosys.ci.common.FIIncidentInfo;
import com.infosys.ci.ons.cistruct.CIAcctTitleInput;
import com.infosys.ci.ons.cistruct.CIRelatedPartyDetails;
import com.infosys.bankaway.accesslayer.bwyinterface.AccountRequestALImplementation;
import com.infosys.ci.cibancsconnect.accounts.common.ChequeBookInputVO;
import com.infosys.ci.ons.cistruct.CIStatementInput;
//import com.infosys.ci.ons.cistruct.CISimpleSIMsgDet;
//import com.infosys.ci.ons.cistruct.CIPartInstrLL;
//import com.infosys.ci.ons.cistruct.CIPartInstruct;
//import com.infosys.ci.ons.cistruct.CIPrDetail;
import com.infosys.ci.cibancsconnect.accounts.common.ChequeBookReqOutputVO;
import com.infosys.ci.ons.common.CustId;
import com.infosys.ci.ons.common.Freq;

import com.infosys.ci.cibancsconnect.accounts.common.*;
import java.text.DecimalFormat;
import java.text.FieldPosition;//Fix for callid 234861 Ticket: 454775 tracker: 275473
import com.infy.cis.common.SRMFormatter;

/* CRA10MSC - ARM - Begin of changes*/
import com.infy.cis.common.ARMTransHelper;
/* CRA10MSC - ARM - End of changes*/
//import com.infy.cis.common.ClientEditorUtil;
//Changes for ticket 297897
import com.infy.cis.common.EditorUtil;

/**
  @tvmFuncCat OnlineServiceWrapper
  @tvmSemantics
  * This class provides methods to processes the online service request based on
  * service request type and request mode. The same is called from process steps to handle semionline service requests
  * Methods defined fetches data from Channel Integrator which gets output values from Finacle Core according to service
  * request type.
  */

public class OnlineServiceWrapper /*Tracker 103058 : FI Call Change :Start
									implements IOnlineServiceWrapper
									Tracker 103058 : FI Call Change :End*/
{


	//path where the vales will be stored for approvalCheck required
	public static final String APPROVE_PATH = "System"+SRMJNDI.separator+"CIF"+SRMJNDI.separator+"Config";
	public static final String APPROVE_VAR = "approvalMech";
	public static String approvalCheck;
	static
	{
		try
		{
			SRMJNDI jndi=SRMJNDI.getInstance();
			Object obj = jndi.getObject(APPROVE_PATH);
		    Properties p = (Properties)obj;

			approvalCheck = p.getProperty(APPROVE_VAR);
		}
		catch(CISContextException e)
		{
		}

	}

	public OnlineServiceWrapper(){
	}

	/*
	 * The method fetches data from Channel Integrator
	 *
	 * @param reqBO - Request BO
	 * @param bc - SRMBusiness Context
	 * @param requestMode - Mode of Request Online or SemiOnline ( from Process steps )
	 * @return Hashtable - This Hashtable contains output values fetched from Channel Integrator
	 * @exception SRMPreWriteException
	 */

	public Hashtable proceedForOnlineRequests ( RequestBO reqBO, SRMBusinessContext bc,
												String requestMode) throws SRMPreWriteException {
	Hashtable htReturnVal = new Hashtable();

	CIDDMassIssueOutDetails ciDDMassIssueOutDetailsret =null;
	ChequeBookReqOutputVO chequeBookReqOutputVOret =null;
	CIAcctStmtOutputDtl CIAcctStmtOut = null;
	RecPmtAddRs recPmtAddRs = null;
	//CIStandingInstructionOutput cIStandInstOp = null;
	CIAccountTitleOutput ciAccTitleOut = null;



	Integer IncidentID = null;
	try {
			if( reqBO.getIncidentID() != null) {
				IncidentID = reqBO.getIncidentID();
			}else{
				Exception e = new FCRMGenericException(new Exception("The Incident Id inside prewrite method is null."));
				// tracker 65962: begin of changes
				// exception SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , e) changed
				throw new SRMPreWriteException(SRMBOException. ERROR_ATTRIB_IS_MANDATORY, e);
				// tracker 65962: end of changes
			}
			//get incident BO
			SRMQueryBuilder qbIncident = QueryAssist.singleObjectQuery("IncidentBO",IncidentBO.INCIDENTID);
			QueryAssist.addSimpleCondition(qbIncident, "IncidentBO",IncidentBO.INCIDENTID,IQuery.ComparisonOperation_EQ,IncidentID );
			SRMQueryResult qrIncident= qbIncident.runQuery(bc, true, -1);
			SRMRecordSet rsIncident = qrIncident.getRecordSet() ;
			IncidentBO incidentBO = (IncidentBO)((ArrayList)rsIncident.getNext()).get(0);

			//check for BackEndCustID,IncidentFor,ServiceRequestType

			String strIncidentFor = incidentBO.getIncidentFor();

			if(strIncidentFor == null){
					Exception e = new FCRMGenericException("MSGEXC0049",new Exception("IncidentFor cannot be null for any Incident."));
					throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , e);
			}else if(strIncidentFor.equalsIgnoreCase("SUSPECT") || strIncidentFor.equalsIgnoreCase("CONTACT")){
					Exception e = new FCRMGenericException("MSGEXC0050",new Exception("Incident will not be processed for prospect and contact."));
					throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , e);
			}else if(strIncidentFor.equalsIgnoreCase("CUSTOMER")){

					String strBackEnd = incidentBO.getBackEndCustID();

					/*if(strBackEnd != null){

						Exception e = new Exception("BackEndCustID can't be null for any Incident of Customer.");
						throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , e);
					}*/
			}

			String strRequestType = incidentBO.getServiceRequestType();
			if(strRequestType.equalsIgnoreCase("null")){
				Exception e = new FCRMGenericException("MSGEXC0051",new Exception("ServiceRequestType cannot be null for any Incident."));
				throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , e);
			}
			//check the request type and call the corresponding method on the basis of that
			if(strRequestType.equalsIgnoreCase("DD Request")){


				ciDDMassIssueOutDetailsret = proceedForDDRequest(incidentBO,reqBO,bc,requestMode);

			}else if(strRequestType.equalsIgnoreCase("TermDepositRepayment")){
				htReturnVal = proceedForTermDepositRequest(incidentBO,reqBO,bc,requestMode);
			}
			else if(strRequestType.equalsIgnoreCase("AccountTitle/ModeOfOperations")){
				ciAccTitleOut = proceedForAccountTitleRequest(incidentBO,reqBO,bc,requestMode);
			}
			else if(strRequestType.equalsIgnoreCase("ChequeBook Request")){

				chequeBookReqOutputVOret = proceedForChequeBookRequest(incidentBO,reqBO,bc,requestMode);
			}
			else if(strRequestType.equalsIgnoreCase("Bank Statement")){
				 htReturnVal = proceedForBankStatement(incidentBO,reqBO,bc,requestMode);
			}
			else if(strRequestType.equalsIgnoreCase("Standing Order Simple")){
				recPmtAddRs = proceedForStandingOrderSimple(incidentBO,reqBO,bc,requestMode);
			}
			else if(strRequestType.equalsIgnoreCase("Address Change")){
				htReturnVal = proceedForAddressChange(incidentBO,reqBO,bc,requestMode);
			}
			else if(strRequestType != null){
				new OnlineRequest().proceedForCustomisedRequest();
			}

		} catch(SRMPreWriteException e){
			//e.printStackTrace();
			throw e;
		} catch(SRMBCException e){
			//e.printStackTrace();
			throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , e);
		}
		catch(Exception e){
			//e.printStackTrace();
			throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
		}
		return htReturnVal;
    }

	/*
	 * The method fetches data from Channel Integrator for DD Request
	 *
 	 * @param incidentBO - Incident BO
	 * @param reqBO - Request BO
	 * @param bc - SRMBusiness Context
	 * @param requestMode - Mode of Request Online or SemiOnline ( from Process steps )
	 * @return Hashtable - This Hashtable contains output values fetched from Channel Integrator
	 * @exception SRMPreWriteException
	 */

public CIDDMassIssueOutDetails proceedForDDRequest ( IncidentBO incidentBO, RequestBO reqBO,
									   SRMBusinessContext bc,String requestMode )throws SRMPreWriteException,SRMBCException{
	try {

			CIUserInfo CIU = new CIUserInfo();
			CIDDMassIssueInputDetails ddIssInputDet = new CIDDMassIssueInputDetails();
			//FI Changes
			CIDDMassIssueLL[] ddMassIssDet = new CIDDMassIssueLL[1];
			CIDDMassIssueLL ddMassIssDet1 = new CIDDMassIssueLL();
			CIDDIssueDtl ciDDIssDet =new CIDDIssueDtl();
			CIDDIssChrgsDtl ddIssChrgsDtl =new CIDDIssChrgsDtl();
			CIDDChrgLL[] ciDDChrgLL = new CIDDChrgLL[1];
			CIDDChrgLL ciDDChrgLL1 =new CIDDChrgLL();
			FIIncidentInfo fiIncidentInfo = new FIIncidentInfo();
			CIDDMassIssueMiscDtl ciDDMiscDtl = new CIDDMassIssueMiscDtl();

			CIDDMassIssueOutDetails ciDDMassIssueOutDetails =new CIDDMassIssueOutDetails();
			OnsSrvRequestALImplementation onsSrvReqALImp = new OnsSrvRequestALImplementation();

			//FI Changes End
			 /* SIT10202 Change - BEGIN */
			ciDDIssDet.setDelFlg("N");
			ciDDIssDet.setTranSubType("CI");
			ciDDIssDet.setTranType("T");


			ciDDMiscDtl.setPurTranType("T");
			ciDDMiscDtl.setPurTranSubType("CI");
			 /* SIT10202 Change - END */
			ddIssInputDet.setMiscDtls(ciDDMiscDtl);
			CIDDMassIssueHdrDtl ciDDMasIssHdrDet = new CIDDMassIssueHdrDtl();//ddIssInputDet.getHeaderDtls();

			//ciDDMasIssHdrDet.setCommCrncy("INR");
			 /* SIT10202 Change - BEGIN */
			ciDDMasIssHdrDet.setPrntOption("L");
 			/* SIT10202 Change - END */
			//what
			ciDDMasIssHdrDet.setPurRateCode("NOR");

			ciDDMasIssHdrDet.setCommRateCode("NOR");
			//ciDDMasIssHdrDet.setPurCrncy("INR");
			//what

			String postTranId = null;
			String bankCode=null;
			String n="1";

			CIAcctId ddAcct = new CIAcctId();
			CIAcctId ddAcct1 = new CIAcctId();


			if(incidentBO.getAccountNumber()!=null){
				ddAcct.setForacid(incidentBO.getAccountNumber());
				if (reqBO.getUserStrField4()!=null){
				 /* SIT10202 Change - BEGIN */
				//	String solid=CommonQueryFunctions.getDataFromRefCodeMapper("SERVICE_OUTLET",reqBO.getUserStrField4().trim(),null);
						String solid = reqBO.getUserStrField4().trim();
						 /* SIT10202 Change - END */
					if(solid!=null){

						 ddAcct.setSolId(solid);
						 ddAcct1.setSolId(solid);
	          			}
				}

				ciDDChrgLL1.setChrgAcct(ddAcct);

				ciDDIssDet.setCommDebtAcct(ddAcct);
				ciDDIssDet.setDdAcct(ddAcct);
				ciDDIssDet.setPurAcct(ddAcct);

				ciDDMasIssHdrDet.setCommAcct(ddAcct);

				ciDDMasIssHdrDet.setPurAcct(ddAcct);


				//ddAcct1.setForacid("DDSCH4INR");
				ciDDMasIssHdrDet.setDdAcct(ddAcct1);
			 }
			else{
				 throw new FCRMGenericException("MSGEXCP0003",new Exception("DD Account number is null."));
			}

			if(reqBO.getUserStrField2()!=null){
			 /* SIT10202 Change - BEGIN */
			//bankCode = CommonQueryFunctions.getDataFromRefCodeMapper("BANK",reqBO.getUserStrField2().trim(), null);
			bankCode = reqBO.getUserStrField2();
			 /* SIT10202 Change - END */

			if( bankCode == null || bankCode.trim().equals("")){
			throw new FCRMGenericException("MSGEXC0053",new Exception("Bank does not exists in Backend."));
			} else {
					ciDDIssDet.setPayeeBankCode(bankCode);
				}
			}
			if(reqBO.getUserStrField1()!=null){
				ciDDIssDet.setPayeeName(reqBO.getUserStrField1());
			}
			else{
				  throw new FCRMGenericException("MSGEXCP0006",new Exception("BENEFICIARY NAME IS NOT MENTIONED."));
            }
			if(reqBO.getUserStrField15()!=null){
				ciDDIssDet.setDdCrncy(reqBO.getUserStrField15());
				ciDDMasIssHdrDet.setCommCrncy(reqBO.getUserStrField15());

			}
			else{
				  throw new FCRMGenericException("MSGEXCP0004",new Exception("DD Currency code is null."));
            }
            if(incidentBO.getAccCurrencyCode()!=null){
				ciDDMasIssHdrDet.setPurCrncy(incidentBO.getAccCurrencyCode());
			}
			else{
				throw new FCRMGenericException("MSGEXCP0002",new Exception("Purchaser currency code is null."));
            }
            if( incidentBO.getCaseID() != null){
				ciDDMasIssHdrDet.setRefNum(incidentBO.getCaseID());
				fiIncidentInfo.	setDccReqRefNum(incidentBO.getCaseID());
			}
			else{
				throw new FCRMGenericException("MSGEXCP0005",new Exception("CaseID is null"));
			}
            if(reqBO.getUserAmountField1()!=null){

				Amount ddAmt = new Amount();
				Double dAmt = new Double(reqBO.getUserAmountField1().toString());
				ddAmt.setAmountValue(dAmt.doubleValue());
				ddAmt.setCurrencyCode(reqBO.getUserStrField15());
				ciDDIssDet.setDdAmt(ddAmt);
			}
			else{
				throw new FCRMGenericException("MSGEXCP0001",new Exception("DD Amount is null."));
            }
            if(incidentBO.getPersonLastName()!=null){

				ciDDIssDet.setPurName(incidentBO.getPersonLastName());
			}



			ciDDIssDet.setDdNum("1");











			/*if(reqBO.getUserStrField14()!=null && bankCode!=null){
			//Tracker 103058 : FI Call Change :Start
			RefCodeMapper refMap=new RefCodeMapper();
			refMap.loadData();
			Tracker 103058 : FI Call Change :End
			//Tracker 103058 : FI Call Change :Start
			String branchCode =refMap.getBranchCode(bankCode,reqBO.getUserStrField14().trim());

			if( branchCode == null || branchCode.trim().equals("")){
			throw new FCRMGenericException("MSGEXC0054",new Exception("Branch does not exists in Backend."));
			}
			else {inputHash.put("br_code_"+n,branchCode);

			}
			//Tracker 103058 : FI Call Change :End
			}*/
			if(incidentBO.getAccBranchCode()!=null){
				 /* SIT10202 Change - BEGIN */
		//	String solid=CommonQueryFunctions.getDataFromRefCodeMapper("SERVICE_OUTLET",incidentBO.getAccBranchCode(),null);
				String solid = incidentBO.getAccBranchCode();
				 /* SIT10202 Change - END */
			if (solid!=null)
			{

					 ciDDIssDet.setInitSol(solid);

			}
			else{
				throw new FCRMGenericException("MSGEXC0055",new Exception("Selected SERVICE_OUTLET does not exists in Backend"));}
			}
			if (reqBO.getUserStrField4()!=null){
				 /* SIT10202 Change - BEGIN */
		//	String solid=CommonQueryFunctions.getDataFromRefCodeMapper("SERVICE_OUTLET",reqBO.getUserStrField4().trim(),null);
				String solid = reqBO.getUserStrField4().trim();
				 /* SIT10202 Change - END */
			if(solid!=null){

					 ciDDIssDet.setInitSol(solid);

			}
			else{throw new FCRMGenericException("MSGEXC0055",new Exception("Selected SERVICE_OUTLET does not exists in Backend"));}
			}

			if(reqBO.getUserTextField1()!=null){
            int num=reqBO.getUserTextField1().length();
			if (num>30){
				throw new FCRMGenericException("MSGEXC0057",new Exception("Remarks should not contain more than 30 characters"));}
			else{
					ciDDIssDet.setRmks(reqBO.getUserTextField1());
				}
			}

			ciDDIssDet.setPrntFlg("L");
			ciDDIssDet.setPrntSolSolId(reqBO.getUserStrField4().trim());

			 /* SIT10202 Change - BEGIN */
			//ciDDIssDet.setPayeeBrCode(incidentBO.getAccBranchCode());
			String payeeBrCode = reqBO.getUserStrField14().trim();
			ciDDIssDet.setPayeeBrCode(payeeBrCode);
			 /* SIT10202 Change - END */
			/*Tracker 103058 : FI Call Change :Start
			CIRemoteAccessInterface inter= null;
			inter = CIHostMarker.getCIHostForONS();
			Tracker 103058 : FI Call Change :End*/
			WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"Before Calling the bean");
// changes begin : tracker 65962



/* CRA10MSC - ARM - Begin of changes*/
// Setting Correlator ID for forced sub-trans in core
//byte CorrelatorID[]=ARMTransHelper.getCorrelator();
//CIU.setCorrelationId(CorrelatorID);
/* CRA10MSC - ARM - End of changes*/

//Tracker-67790 -Begin of change

//Tracker-67790 -end of change
// end of changes: tracker 65962


				CIU.setChannelType("CRM");
				String bankID = (String)com.infy.cis.common.SRMTLVar.bank_id.get();
				CIU.setBankId(bankID);

				/* 10.1 RECON Changes by mukundhan_santhanam (79625)*/
				/*SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss.S");
				Date currentTime_1 = new Date();
				String dateString = formatter.format(currentTime_1);
				fiIncidentInfo.	setDccReqOrigTime(dateString);*/
				fiIncidentInfo.setDccReqOrigTime(getDateFormatforFIServReq());





				ciDDChrgLL[0] = ciDDChrgLL1;
				ddIssChrgsDtl.setDdChrgLL(ciDDChrgLL);

				ddMassIssDet1.setChargesDtls (ddIssChrgsDtl);
				ddMassIssDet1.setDdIssueDtl(ciDDIssDet);
				ddMassIssDet[0] = ddMassIssDet1;
				ddIssInputDet.setDdDtls(ddMassIssDet);
				ddIssInputDet.setMiscDtls(ciDDMiscDtl);
				ddIssInputDet.setFiIncidentInfo(fiIncidentInfo);

				ddIssInputDet.setHeaderDtls(ciDDMasIssHdrDet);
				ciDDMassIssueOutDetails=(CIDDMassIssueOutDetails)onsSrvReqALImp.doDDMassIssue(CIU,ddIssInputDet);

			if(requestMode.equalsIgnoreCase("Online")){
					String notes = "Step completed successfully";

					if(ciDDMassIssueOutDetails.getPostTranId()!=null){
							postTranId = ciDDMassIssueOutDetails.getPostTranId().toString();
					notes = notes+" : BackEndReference Number = "+postTranId;
					}
	CommonQueries.UpdateIncident( bc ,incidentBO.getIncidentID() , "Closed" , null , notes , postTranId , false , null , null );
	WebAdaptor.log(com.infy.cis.log.LogType.MINOR,notes);

					return ciDDMassIssueOutDetails;

	}else{

					return ciDDMassIssueOutDetails;

					}
					}
			catch (CINonFatalException e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CINonFatalException - " + e.getMessage()),
									 null);
			}
		    catch (CIFatalException e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CIFatalException - " + e.getMessage()),
									 null);
		    }
		    catch (CIOnsNonFatalException confe) {
			String strErrMsg = "";
            WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"CIOnsNonFatalException");
			/*for (int i = 0; i < confe.getErrorLL().size(); i++) {
            WebAdaptor.log(com.infy.cis.log.LogType.MINOR," " + (i + 1) + ", " + confe.getErrorLL().get(i));
            CIOnsErr errObj = (CIOnsErr) confe.getErrorLL().get(i);
            if (errObj.ciErrFieldDesc == null || errObj.ciErrFieldDesc.length() < 1) {
            strErrMsg = strErrMsg +"(" + (i + 1) + ") " + errObj.errDesc;
            }
			else {strErrMsg = strErrMsg +"(" + (i + 1) + ") " + errObj.ciErrFieldDesc + "_" + errObj.errDesc;}
            WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"VALIDATION_ERROR"+strErrMsg);
            }*/
		    throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CIOnsNonFatalException - " + strErrMsg),
									 null);
			}
		    catch(Exception e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg(e.getMessage()),
							 null);
			}
	} // end of proceedForDDRequest

	/*
	 * The method fetches data from Channel Integrator for TermDepositRequest
	 *
 	 * @param incidentBO - Incident BO
	 * @param reqBO - Request BO
	 * @param bc - SRMBusiness Context
	 * @param requestMode - Mode of Request Online or SemiOnline ( from Process steps )
	 * @return Hashtable - This Hashtable contains output values fetched from Channel Integrator
	 * @exception SRMPreWriteException
	 */
public Hashtable proceedForTermDepositRequest ( IncidentBO incidentBO, RequestBO reqBO,
									   SRMBusinessContext bc,String requestMode )throws SRMPreWriteException,SRMBCException{
	try {
			Hashtable inputHash = new Hashtable();
			CIUserInfo CIU = new CIUserInfo();
            CIU.setChannelType("CRM");
			String postTranId = null;
			int iCountOFCreditAcc=0;
			if(reqBO.getUserStrField1() != null){
				inputHash.put("repay_inst_flag", reqBO.getUserStrField1());
			}
			if (reqBO.getUserStrField1().equalsIgnoreCase("By Cheque")){
				if(reqBO.getUserStrField4() != null){
					inputHash.put("payee_name", reqBO.getUserStrField4());
				}
				if(reqBO.getUserStrField3()!=null){
					//String bankCode = CommonQueryFunctions.getDataFromRefCodeMapper
					//	( "BANK", reqBO.getUserStrField3().trim(), null);
					String bankCode = 	reqBO.getUserStrField3().trim();
					if( bankCode == null || bankCode.trim().equals("")){
						throw new FCRMGenericException("MSGEXC0053",new Exception("Bank does not exists in Backend."));
					} else {inputHash.put("bank_code",bankCode);}
				}
				if(reqBO.getUserStrField13() != null){
				//	String branchCode = CommonQueryFunctions.getDataFromRefCodeMapper
				//		( "SERVICE_OUTLET", reqBO.getUserStrField13().trim(), null);
					String branchCode = reqBO.getUserStrField13().trim();
					if( branchCode == null || branchCode.trim().equals("")){
						throw new FCRMGenericException("MSGEXC0054",new Exception("Branch does not exists in Backend."));
					} else {inputHash.put("br_Code",branchCode);}
				}
				if(reqBO.getUserStrField9() != null){
				//	String cityCode = CommonQueryFunctions.getDataFromRefCodeMapper
				//		( "CITY", reqBO.getUserStrField9().trim(), null);
						String cityCode = reqBO.getUserStrField9().trim();
					if( cityCode == null || cityCode.trim().equals("")){
						throw new FCRMGenericException("MSGEXC0060",new Exception("City does not exists in Backend."));
					} else {inputHash.put("city_code",cityCode);}
				}
			} else {
				if(reqBO.getUserStrField20() != null){
					inputHash.put("td_acct_num", reqBO.getUserStrField20());
				}

				if(reqBO.getUserStrField21() != null){
					inputHash.put("credit_acct_num_01", reqBO.getUserStrField21());
					iCountOFCreditAcc++;
				}
				if(reqBO.getUserStrField22() != null){
					inputHash.put("credit_acct_num_02", reqBO.getUserStrField22());
					iCountOFCreditAcc++;
				}
				if(reqBO.getUserStrField23() != null){
					inputHash.put("credit_acct_num_03", reqBO.getUserStrField23());
					iCountOFCreditAcc++;
				}
				if(reqBO.getUserStrField24() != null){
					inputHash.put("credit_acct_num_04", reqBO.getUserStrField24());
					iCountOFCreditAcc++;
				}
				if(reqBO.getUserStrField25() != null){
					inputHash.put("credit_acct_num_05", reqBO.getUserStrField25());
					iCountOFCreditAcc++;
				}
				if(reqBO.getUserStrField26() != null){
					inputHash.put("credit_acct_num_06", reqBO.getUserStrField26());
					iCountOFCreditAcc++;
				}
				inputHash.put("no_of_credit_accts", new Integer(iCountOFCreditAcc));
			}
// changes begin : tracker 65962
//inputHash.put("incident_id",incidentBO.getIncidentID().toString());
//Tracker-67790 -Begin of change
inputHash.put("incident_id",incidentBO.getCaseID());
//Tracker-67790 -End of change
//inputHash.put("DC_ID","CRM");
// outputHash = (Hashtable)inter.processServiceRequest(CIU,"DD_MASS_ISSUE",inputHash);
// end of changes: tracker 65962
			/*Tracker 103058 : FI Call Change :Start
			CIRemoteAccessInterface inter= null;
			inter = CIHostMarker.getCIHostForONS();
			Tracker 103058 : FI Call Change :End*/
			Hashtable	outputHash = new Hashtable();//(Hashtable)inter.processServiceRequest(CIU,incidentBO.getServiceRequestType(),inputHash);

			if(requestMode.equalsIgnoreCase("Online")){
				String notes = "Step completed successfully";
				if(outputHash.get("postTranId")!=null){
				postTranId = outputHash.get("postTranId").toString();
				notes = notes+" : BackEndReference Number = "+postTranId;
				}
				CommonQueries.UpdateIncident( bc , incidentBO.getIncidentID() , "Closed" , null , notes , postTranId , false , null , null );
				WebAdaptor.log(com.infy.cis.log.LogType.MINOR,notes);
				return outputHash;
			}else{
				return outputHash;
			}

		}
			catch (CINonFatalException e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CINonFatalException - " + e.getMessage()),
									 null);
			}
		    catch (CIFatalException e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CIFatalException - " + e.getMessage()),
									 null);
		    }
		    catch (CIOnsNonFatalException confe) {
			String strErrMsg = "";
            WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"CIOnsNonFatalException");
			/*for (int i = 0; i < confe.getErrorLL().size(); i++) {
            WebAdaptor.log(com.infy.cis.log.LogType.MINOR," " + (i + 1) + ", " + confe.getErrorLL().get(i));
            CIOnsErr errObj = (CIOnsErr) confe.getErrorLL().get(i);
            if (errObj.ciErrFieldDesc == null || errObj.ciErrFieldDesc.length() < 1) {
            strErrMsg = strErrMsg +"(" + (i + 1) + ") " + errObj.errDesc;
            }
			else {strErrMsg = strErrMsg +"(" + (i + 1) + ") " + errObj.ciErrFieldDesc + "_" + errObj.errDesc;}
            WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"VALIDATION_ERROR"+strErrMsg);
            }  */
		    throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CIOnsNonFatalException - " + strErrMsg),
									 null);
			}
		    catch(Exception e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg(e.getMessage()),
							 null);
			}
	} // end of proceedForTermDepositRequest


	/*
	 * The method fetches data from Channel Integrator for ChequeBookRequest
	 *
 	 * @param incidentBO - Incident BO
	 * @param reqBO - Request BO
	 * @param bc - SRMBusiness Context
	 * @param requestMode - Mode of Request Online or SemiOnline ( from Process steps )
	 * @return Hashtable - This Hashtable contains output values fetched from Channel Integrator
	 * @exception SRMPreWriteException
	 */

	public ChequeBookReqOutputVO proceedForChequeBookRequest ( IncidentBO incidentBO, RequestBO reqBO,
									   SRMBusinessContext bc,String requestMode )throws SRMPreWriteException,SRMBCException{
	try {

            Hashtable inputHash = new Hashtable();
            ChequeBookInputVO chqBReqInputVO = new ChequeBookInputVO();
			CIUserInfo CIU = new CIUserInfo();
            FIIncidentInfo fiIncidentInfo= new FIIncidentInfo();
			ChequeBookReqOutputVO chequeBookReqOutputVO = new ChequeBookReqOutputVO();
			AccountRequestALImplementation acctReqALImp = new AccountRequestALImplementation();
			String postTranId = null;

			if(incidentBO.getAccountNumber()==null || incidentBO.getAccountNumber().trim().equals("")){
				throw new FCRMGenericException("MSGEXC0052",new Exception("Account number is null for the incident."));
				} else {

                				chqBReqInputVO.setAcid(incidentBO.getAccountNumber());
                			}





				if(reqBO.getUserIntField1() != null){

                  Integer numLeaves = new Integer(reqBO.getUserIntField1().toString());

                  chqBReqInputVO.setNumberOfLeaves(numLeaves.intValue());
                }
                else{
                      throw new FCRMGenericException("MSGEXCP0005",new Exception("Number of cheque leaves is null."));
                }
				List saleslist = CommonQueryFunctions.getSalesData(incidentBO.getAccountNumber(), bc);

				if( saleslist == null ){
					Exception e = new FCRMGenericException(new Exception("The list retrieved inside prewrite method is null."));
					throw new SRMPreWriteException(SRMBOException.ERROR_RETRIEVINGDATA , e);
				}

				if( saleslist.get(3) == null || String.valueOf(saleslist.get(3)).trim() == "" ){
										Exception e = new FCRMGenericException("MSGEXC0016",new Exception("The account branch code is null for the account."));
										throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
									}

			 	String accBranchCode = (String)saleslist.get(3);
               chqBReqInputVO.setBranchId(accBranchCode);

               if( incidentBO.getCaseID() != null){
			   		fiIncidentInfo.	setDccReqRefNum(incidentBO.getCaseID());
			   	}else{
			   		throw new FCRMGenericException("MSGEXCP0005",new Exception("CaseID is null"));
				}

				// 10.1 Recon change
				/*SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss.S");
				Date currentTime_1 = new Date();
				String dateString = formatter.format(currentTime_1);
 				fiIncidentInfo.	setDccReqOrigTime(dateString);*/
 				fiIncidentInfo.setDccReqOrigTime(getDateFormatforFIServReq());
				//End of Recon Change

			/*Tracker 103058 : FI Call Change :Start
			CIRemoteAccessInterface inter= null;
			inter = CIHostMarker.getCIHostForONS();
			Tracker 103058 : FI Call Change :End*/

            CIU.setChannelType("CRM");
            String bankID = (String)com.infy.cis.common.SRMTLVar.bank_id.get();
            CIU.setBankId(bankID);
            chqBReqInputVO.setFIIncidentInfo(fiIncidentInfo);
            chequeBookReqOutputVO = (ChequeBookReqOutputVO)acctReqALImp.doChequeBookReq(CIU,chqBReqInputVO);
		if(requestMode.equalsIgnoreCase("Online")){

				String notes = "Step completed successfully";

				/*if(outputHash.get("postTranId")!=null){
					postTranId = outputHash.get("postTranId").toString();
					notes = notes+" : BackEndReference Number = "+postTranId;
				}*/
				CommonQueries.UpdateIncident( bc , incidentBO.getIncidentID() , "Closed" , null , notes , postTranId , false , null , null );

				return chequeBookReqOutputVO;
			}else{

				return chequeBookReqOutputVO;
			}
		}
			catch (CINonFatalException e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CINonFatalException - " + e.getMessage()),
									 null);
			}
		    catch (CIFatalException e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CIFatalException - " + e.getMessage()),
									 null);
		    }
		    catch (CIOnsNonFatalException confe) {
			String strErrMsg = "";
            WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"CIOnsNonFatalException");
			/*for (int i = 0; i < confe.getErrorLL().size(); i++) {
            WebAdaptor.log(com.infy.cis.log.LogType.MINOR," " + (i + 1) + ", " + confe.getErrorLL().get(i));
            CIOnsErr errObj = (CIOnsErr) confe.getErrorLL().get(i);
            if (errObj.ciErrFieldDesc == null || errObj.ciErrFieldDesc.length() < 1) {
            strErrMsg = strErrMsg +"(" + (i + 1) + ") " + errObj.errDesc;
            }
			else {strErrMsg = strErrMsg +"(" + (i + 1) + ") " + errObj.ciErrFieldDesc + "_" + errObj.errDesc;}
            WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"VALIDATION_ERROR"+strErrMsg);
            }  */
		    throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CIOnsNonFatalException - " + strErrMsg),
									 null);
			}
		    catch(Exception e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg(e.getMessage()),
							 null);
			}
	} // end of proceedForChequeBookRequest


	/*
	 * The method fetches data from Channel Integrator for BankStatement Request
	 * Added to handle BankStatement Service Request
 	 * @param incidentBO - Incident BO
	 * @param reqBO - Request BO
	 * @param bc - SRMBusiness Context
	 * @param requestMode - Mode of Request Online
	 * @return Hashtable - This Hashtable contains output values fetched from Channel Integrator
	 * @exception SRMPreWriteException
	 */

public Hashtable proceedForBankStatement( IncidentBO incidentBO, RequestBO reqBO,
									   SRMBusinessContext bc,String requestMode )throws SRMPreWriteException,SRMBCException{
	try {

			//SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			String  strBackEnd = null;
			List    lSales=null;
			String  postTranId = null;
			String  dMode=null;
			String  pType=null;
			String  pHolder=null;

			String  strApplCurrency=null;
			String strAccBranch=null;
			String tempdate = null;

			CIUserInfo CIU = new CIUserInfo();
			/* Change for ticket 297897 : Begin */
			String sNoOfTrans = "";
			Hashtable hstTable1 =null;
			try{
				Properties prop = EditorUtil.getWebClientsSessionConfig();
				sNoOfTrans = prop.getProperty(EditorUtil.MAX_REC_RESULTSET);
			}catch(Exception e) {
				e.getMessage();
				sNoOfTrans = "100";
			}
			int  iNoOfTrans = 0;
			if((sNoOfTrans != null) || (!sNoOfTrans.equals("")) ){
				 iNoOfTrans = Integer.parseInt(sNoOfTrans);
			}
        	/* Change for ticket 297897 : End*/

        /*	CIStatementInput acctStmtInput = new CIStatementInput();
        	CIAcctStmtOutputDtl cIAcctStmtOutputDtl = new CIAcctStmtOutputDtl(); */
			/*Tracker 103058 : FI Call Change :Start
			CIRemoteAccessInterface inter= null;
			inter = CIHostMarker.getCIHostForONS();
			Tracker 103058 : FI Call Change :End*/
      //  	OnsSrvRequestALImplementation onsSrvReqALImp = new OnsSrvRequestALImplementation();
        AccountInquiryALImplementation ActReqAccess = AccountInquiryALImplementation.getInstance();
        AccountTransactionCriteria objStatReqInput =new  AccountTransactionCriteria();
        String obj[]=new String[10];
		obj[0]="CRM|34";
		obj[1]="one";
		FIObjectHash objFIObjHash = new FIObjectHash();
		objFIObjHash.put(obj[1],obj[0]);
		objStatReqInput.setCustomData(objFIObjHash);
		objFIObjHash.removeElement(obj[1]);
			String strIncidentFor = incidentBO.getIncidentFor();

			if(strIncidentFor == null){
					Exception e = new FCRMGenericException("MSGEXC0049",new Exception("IncidentFor cannot be null for any Incident."));
					throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , e);
			}else if(strIncidentFor.equalsIgnoreCase("SUSPECT") || strIncidentFor.equalsIgnoreCase("CONTACT")){
					Exception e = new FCRMGenericException("MSGEXC0050",new Exception("Incident will not be processed for prospect and contact."));
					throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , e);
			}else if(strIncidentFor.equalsIgnoreCase("CUSTOMER")){
					strBackEnd = incidentBO.getBackEndCustID();
					}
			SRMCollection serReqGenInfo = reqBO.getRequestGenInfo();
			short slength=(short)serReqGenInfo.size();
			for(int iCount=0;iCount < slength;iCount++)
					{
			RequestBO.RequestGenInfo reqGenInfo =(RequestBO.RequestGenInfo)serReqGenInfo.get(iCount);


	    /*         acctStmtInput.setPSHolderOnlyFlg("Y");
         		   acctStmtInput.setAdhocFlg("Y");

			acctStmtInput.setAcctHldrFlg("Principal Holder");*/
            /*if (reqGenInfo.getUserStrField4() != null) {
                pHolder=CommonQueryFunctions.getDataFromRefCodeMapper
				("PRINCIPAL_HOLDER",reqGenInfo.getUserStrField4().trim(), null
				);
				if(pHolder!=null){

                  acctStmtInput.setAcctHldrFlg(pHolder);
                } else {
                    throw new FCRMGenericException("MSGEXC0064", new Exception("PRINCIPAL HOLDER is not available in backend"));
                }
            }*/
           /* if (reqGenInfo.getUserStrField3() != null) {
				acctStmtInput.setStmtType(reqGenInfo.getUserStrField3());
			} else {
				throw new FCRMGenericException("MSGEXC0064", new Exception("Statement Type is not available.The Field is Mandatory"));
			}
            acctStmtInput.setStmtType("Pass Sheet"); */
				if(reqGenInfo.getUserStrField1() != null){
             //   acctStmtInput.setAcid(reqGenInfo.getUserStrField1());
                objStatReqInput.setAcid(reqGenInfo.getUserStrField1());
				lSales=CommonQueryFunctions.getSalesData(reqGenInfo.getUserStrField1().trim(),bc);
				Integer salesid=(Integer)lSales.get(0);
                if (salesid == null) {
                    throw new FCRMGenericException("MSGEXC0065", new Exception("No SalesId available for this Account"));
                }
				strAccBranch=(String)lSales.get(3);
				objStatReqInput.setBranchId(strAccBranch);

			/*	lSales=CommonQueryFunctions.getSaleBackEndData(salesid,bc);
				strApplCurrency=(String)lSales.get(1);
				if(strApplCurrency!=null){

                    acctStmtInput.setAcctCrncyCode(strApplCurrency);
                } else {
                    throw new FCRMGenericException("MSGEXC0066", new Exception("Currency for this Account is not available in backend"));
                }
                acctStmtInput.setAcctSetId("ALL");*/
                /*if (strAccBranch != null) {
			String soleid=CommonQueryFunctions.getDataFromRefCodeMapper
				("SERVICE_OUTLET",strAccBranch, null
				);
                    if (soleid != null) {

                        acctStmtInput.setAcctSetId(soleid);
                    } else {
                        throw new FCRMGenericException("MSGEXC0067", new Exception("SERVICE_OUTLET does not available in backend"));
                    }

                }*/
            }
			try{
				Date dAccountOpeningDate=(Date)lSales.get(2);

				GregorianCalendar gc=new GregorianCalendar();
				gc.setTime(dAccountOpeningDate);
				int d1=gc.get(Calendar.DATE);
				int m1=gc.get(Calendar.MONTH);
				int y1=gc.get(Calendar.YEAR);
				gc=new GregorianCalendar(y1,m1,d1);
				dAccountOpeningDate=gc.getTime();
				gc.setTime((Date)reqGenInfo.getUserDateField1());
				d1=gc.get(Calendar.DATE);
				m1=gc.get(Calendar.MONTH);
				y1=gc.get(Calendar.YEAR);
				gc=new GregorianCalendar(y1,m1,d1);
				Date startDate=gc.getTime();
				if(dAccountOpeningDate.after(startDate))
				{throw new FCRMGenericException("MSGEXC0068",new Exception("Start date should be greater than or equal to the A/c openinig date"));}

				}catch(Exception e) {


				}
				if(reqGenInfo.getUserDateField1() != null){
				Date dFromDate  = reqGenInfo.getUserDateField1();
				Calendar cFromDate = Calendar.getInstance();
				cFromDate.setTime(dFromDate);
				objStatReqInput.setFromDate(cFromDate);

            /*    SimpleDateFormat strtDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.S");
				String dateString = strtDate.format(reqGenInfo.getUserDateField1());
                SimpleDateFormat strtDate1 = new SimpleDateFormat(dateString);
                acctStmtInput.setStartDate(strtDate1.getCalendar());
			 */
				}
				if(reqGenInfo.getUserDateField2() != null){



              /*  SimpleDateFormat endDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.S");
				String dateString = endDate.format(reqGenInfo.getUserDateField2());
                SimpleDateFormat endDate1 = new SimpleDateFormat(dateString);
                acctStmtInput.setEndDate(endDate1.getCalendar()); */
                Date dToDate  = reqGenInfo.getUserDateField2();
				Calendar cToDate = Calendar.getInstance();
				cToDate.setTime(dToDate);
				objStatReqInput.setToDate(cToDate);
               // objStatReqInput.setToDate(endDate1.getCalendar());
            }
          /*  if (reqGenInfo.getUserStrField2() != null){
				acctStmtInput.setDespatchMode(reqGenInfo.getUserStrField2());
			} */
			//FI Changes End

           /* Change for ticket 297897 : Begin */
			   objStatReqInput.setNumOfTxns(iNoOfTrans);
		   /* Change for ticket 297897 : End */

            CIU.setChannelType("CRM");
            //Changes for Ticket id 451498 and Tracker id 273432 - Start
            String bankID = (String)com.infy.cis.common.SRMTLVar.bank_id.get();
			if( bankID != null && !bankID.equalsIgnoreCase("")){
				CIU.setBankId(bankID.trim());
				}
			else{
				CIU.setBankId("01");
							}
            //CIU.setBankId("01");
            //Changes for CTicket id 451498 and Tracker id 273432 - End
            FIIncidentInfo fiIncidentInfo= new FIIncidentInfo();

            if( incidentBO.getCaseID() != null){
				fiIncidentInfo.	setDccReqRefNum(incidentBO.getCaseID());
			}else{
				throw new FCRMGenericException("MSGEXCP0005",new Exception("CaseID is null"));
			}
			/*SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss.S");
			Date currentTime_1 = new Date();
			String dateString = formatter.format(currentTime_1);
			fiIncidentInfo.	setDccReqOrigTime(dateString);*/

			fiIncidentInfo.setDccReqRefNum(String.valueOf(System.currentTimeMillis()));
			fiIncidentInfo.setDccReqType("DEFAULTEJB");

			/*SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss.S");
			Date currentTime_1 = new Date();
			String dateString = formatter.format(currentTime_1);
			fiIncidentInfo.	setDccReqOrigTime(dateString);*/
 			//fiIncidentInfo.setDccReqOrigTime("2007-01-01 00:00:00.000");
 			fiIncidentInfo.setDccReqOrigTime(getDateFormatforFIServReq()); // 10.1 RECON Change

         //   acctStmtInput.setFiIncidentInfo(fiIncidentInfo);
            objStatReqInput.setFIIncidentInfo(fiIncidentInfo);

            //cIAcctStmtOutputDtl=(CIAcctStmtOutputDtl)onsSrvReqALImp.generateStmtofAcctRpt(CIU,acctStmtInput);
            AccountStatement objStatReqOutput= ActReqAccess.getFullAccountStatement(CIU,objStatReqInput);

			AccountSummary objAccSum=objStatReqOutput.getAccountBalances();

			/* Change for ticket 302684 : BEGIN */
		 java.util.Locale locale = ((com.infy.cis.servletruntime.CISSessionContext) com.infy.cis.common.SRMTLVar.sc
							.get()).getSessionLocale();
	       String strlocale = locale.toString();
	       /* Change for ticket 302684 : END */
			DecimalFormat df1 = new DecimalFormat("#,##0.00");
			StringBuffer sbfHtmlOutput = new StringBuffer();
			sbfHtmlOutput.append("<HTML>");
			sbfHtmlOutput.append("<Title>Bank Statement Request</Title><Head>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMTableDisplay.css'/>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/Popup.css'/>");
			sbfHtmlOutput.append("<link rel='stylesheet' type='text/css' href='../Branding/css/common/SRMListTemplate.css'/>");
			/* Change done for ticket 298876: Begin */
			/*Tracker id:275801 and Ticket Id: 455526 Scriptx latest version changes Start*/
		/*	sbfHtmlOutput.append(" <object id=\"factory\" >");
			sbfHtmlOutput.append("</object>");*/

			/* Change for ticket 302684 : BEGIN */
			//sbfHtmlOutput.append("<SCRIPT>");
			sbfHtmlOutput.append("<SCRIPT language=javascript src=\"../common/js/ClientResourceBundle_"+strlocale+".js\"></SCRIPT>");
			//sbfHtmlOutput.append("</SCRIPT>");
			sbfHtmlOutput.append("<SCRIPT>");
			sbfHtmlOutput.append("function closeWin(){");
//changes for Tracker ID 457945 - TOL 456055
            //sbfHtmlOutput.append("alert(\"Closing this window!!!!\");");
//changes for Tracker ID 457945 - TOL 456055
           sbfHtmlOutput.append("var msg = eval('MSG022');");
            sbfHtmlOutput.append("if(confirm(msg)){");
            sbfHtmlOutput.append("top.close();}");
            sbfHtmlOutput.append("else{return;}");
            sbfHtmlOutput.append("}");
            /* Change for ticket 302684 : END */
			//sbfHtmlOutput.append("function SetPrintSettings(){");
			//sbfHtmlOutput.append(" factory.printing.header = \"&b &w&b&b&d  &T\";");
			//sbfHtmlOutput.append(" factory.printing.footer = \"&b&b&p of &P\";");
			//sbfHtmlOutput.append("factory.printing.portrait = false;");
			//sbfHtmlOutput.append("factory.printing.leftMargin = .5;");
			//sbfHtmlOutput.append("factory.printing.topMargin = .5;");
			//sbfHtmlOutput.append("factory.printing.rightMargin = .5;");
			//sbfHtmlOutput.append("factory.printing.bottomMargin = .5;     }");
//changes for Tracker ID 457945 - TOL 456055
			sbfHtmlOutput.append("function PrintFrame(){");
//changes for Tracker ID 457945 - TOL 456055
			//sbfHtmlOutput.append("try{");
			/*sbfHtmlOutput.append("if(factory.classid!=\"clsid:1663ed61-23eb-11d2-b92f-008048fdd814\"){");
			 sbfHtmlOutput.append(   "factory.classid=\"clsid:1663ed61-23eb-11d2-b92f-008048fdd814\";");
			 sbfHtmlOutput.append(  "factory.codebase=\"http://www.meadroid.com/scriptx/ScriptX.cab#Version=5,60,0,375\";");
			 sbfHtmlOutput.append("}");*/
			 // sbfHtmlOutput.append( "SetPrintSettings();");
			// sbfHtmlOutput.append(  "}catch(e){");
			//sbfHtmlOutput.append("showUserMessage(\"MSG051\",\"\");");
		//	sbfHtmlOutput.append("alert(\"There was an error in printing. Please ensure that ScriptX is installed on your system\");");
			//sbfHtmlOutput.append("return false;");
		//	sbfHtmlOutput.append( "}");
		/*Tracker id:275801 and Ticket Id: 455526 Scriptx latest version changes End*/
			sbfHtmlOutput.append("try{");
			/*Tracker id:275801 and Ticket Id: 455526 Scriptx latest version changes Start*/
			//sbfHtmlOutput.append("factory.printing.Print(true, 'self');");
			sbfHtmlOutput.append("window.focus();");
			sbfHtmlOutput.append("window.print();");
			/*Tracker id:275801 and Ticket Id: 455526 Scriptx latest version changes End*/
			sbfHtmlOutput.append( "}catch(e){");
			//sbfHtmlOutput.append("showUserMessage(\"MSG051\",\"\");");
//changes for Tracker ID 457945 - TOL 456055
			sbfHtmlOutput.append("alert(\"There was an error in printing.\");");
//changes for Tracker ID 457945 - TOL 456055
			sbfHtmlOutput.append("return false;");
			sbfHtmlOutput.append(  "}");
			sbfHtmlOutput.append("return false;");
			sbfHtmlOutput.append("}");
			sbfHtmlOutput.append("</SCRIPT>");
			/* Change done for ticket 298876: End */
			sbfHtmlOutput.append("</Head><body class='popup'><br>");
			/* Fix for ticket 297594 : BEGIN */
			sbfHtmlOutput.append("<table cellPadding=0 cellSpacing=1 border=1  align=center class=\"background\" width=\"100%\">");
		//	sbfHtmlOutput.append("<tr> <td align=center class=\"tableHeader\" width=\"100%\">Statement for Account Number: "+ incidentBO.getAccountNumber().trim()+"</td></tr></table>");
			/* Fix for ticket 297594 : END */
			sbfHtmlOutput.append("<tr> <td align=center class=\"tableHeader\" width=\"100%\">Statement for Account Number: "+ reqGenInfo.getUserStrField1().trim()+"</td></tr></table>");
			sbfHtmlOutput.append("<table border=1 width=\"100%\" align=center>");
			sbfHtmlOutput.append("<tr><td align=left class=\"tableHeader\">CredAvailBal :</td>");
			Amount objAmmount=objAccSum.getAvailableBalance();
			sbfHtmlOutput.append("<td align=right class=\"fntColData\">"+df1.format(objAmmount.getAmountValue())+ "&nbsp;</td></tr>");
			sbfHtmlOutput.append("<tr><td align=left class=\"tableHeader\">CredBalCurrency :</td>");
			sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+objAccSum.getCurrencyCode()+ "&nbsp;</td></tr>");
			sbfHtmlOutput.append("<tr><td align=left class=\"tableHeader\">CredFloatBal :</td>");
			objAmmount=objAccSum.getFloatingBalance();
			sbfHtmlOutput.append("<td align=right class=\"fntColData\">"+df1.format(objAmmount.getAmountValue())+ "&nbsp;</td></tr>");
			sbfHtmlOutput.append("<tr><td align=left class=\"tableHeader\">CredLedgerBal :</td>");
			objAmmount=objAccSum.getLedgerBalance();
			sbfHtmlOutput.append("<td align=right class=\"fntColData\">"+df1.format(objAmmount.getAmountValue())+ "&nbsp;</td></tr>");
			sbfHtmlOutput.append("<tr><td align=left class=\"tableHeader\">CredUserDefBal :</td>");
			objAmmount=objAccSum.getUserDefinedBalance();
			sbfHtmlOutput.append("<td align=right class=\"fntColData\">"+df1.format(objAmmount.getAmountValue())+ "&nbsp;</td></tr>");
			sbfHtmlOutput.append("<tr><td align=left class=\"tableHeader\">RequestId :</td>");
			FIIncidentInfo objFIInciInfo=objAccSum.getFIIncidentInfo();
			sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+fiIncidentInfo.getDccReqRefNum()+ "&nbsp;</td></tr>");
			sbfHtmlOutput.append("<tr><td align=left class=\"tableHeader\">Value Date :</td>");
			objFIInciInfo=objAccSum.getFIIncidentInfo();
			String valuedata = fiIncidentInfo.getDccReqOrigTime();
			valuedata=valuedata.replace('T',' ');
			sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+valuedata+ "&nbsp;</td></tr>");
			sbfHtmlOutput.append("</table>");
			sbfHtmlOutput.append("<br></br>");
			/* Fix for ticket 297285 : Begin */
			/* Recon from CRM101101BR02R04R06BBR08 PDA*/
			/* Fix for ticket 243329 and tracker 146912*/
			/** Changes made for displaying the Transaction details: Starts **/
						sbfHtmlOutput.append("<table cellPadding=0 cellSpacing=1 border=true align=center class=\"background\" width=\"100%\">");
						sbfHtmlOutput.append("<tr> <td align=center class=\"tableHeader\" width=\"100%\">Transaction Details</td></tr></table>");
						sbfHtmlOutput.append("<table border=true width=\"100%\" align=center><tr><td align=left class=\"tableHeader\">Sl. No.</td>");
						sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Transaction ID</td>");
						sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Transaction Amount</td>");
						sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Credit/Debit</td>");
						sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Transaction Balance</td>");
						sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Transaction Date</td>");
						sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Transaction Description</td>");
						sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Tran Type</td>");
						sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Tran Sub Type</td>");
						sbfHtmlOutput.append("<td align=left class=\"tableHeader\">Transaction Type</td></tr>");
						Amount CurrentBalance = null;
						String strCurrBal = null;
						String strTransactionType = null;

						SRMFormatter srmf = SRMFormatter.getObjectInstance(locale);

						AccountTransaction objAccountTransaction[] = objStatReqOutput.getTransactionDetails();

						AccountTransactionSummary objAccountTransactionSummary[] = new AccountTransactionSummary[objAccountTransaction.length];
						int printIndex = 0;
						for (int index = 0 ; index<objAccountTransaction.length; index++)
						{
							objAccountTransactionSummary[index]= objAccountTransaction[index].getTransactionSummary();

							if(index == 0)
							{
								CurrentBalance = objAccountTransaction[index].getTxnBalance();
								strCurrBal = CurrentBalance.toString();
							}

							if(objAccountTransactionSummary[index].getTxnType().equals("C"))
							{
								 strTransactionType="CR";
							}
							else
							{
								 strTransactionType="DR";
							}
							printIndex = index +1;
							sbfHtmlOutput.append("<tr><td align=center class=\"fntColData\">"+printIndex + "&nbsp;</td>");
							String strTxnAmt = objAccountTransactionSummary[index].getTxnAmt().toString();
							String strTxnBalance = objAccountTransaction[index].getTxnBalance().toString();

							sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+objAccountTransaction[index].getTxnId()+ "&nbsp;</td>");
							double dbl = Double.valueOf(strTxnAmt.substring(1,strTxnAmt.indexOf("^"))).doubleValue();
							sbfHtmlOutput.append("<td align=right class=\"fntColData\">"+df1.format(dbl)+ "&nbsp;</td>");

							sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+strTransactionType+ "&nbsp;</td>");
							double db = Double.valueOf(strTxnBalance.substring(1,strTxnBalance.indexOf("^"))).doubleValue();
							sbfHtmlOutput.append("<td align=right class=\"fntColData\">"+df1.format(db)+ "&nbsp;</td>");

							int iYear=objAccountTransactionSummary[index].getTxnDate().get(1);
							int iMonth=objAccountTransactionSummary[index].getTxnDate().get(2);;
							int iDate=objAccountTransactionSummary[index].getTxnDate().get(5);
							Date temp=new Date((iYear-1900),iMonth,iDate);

							//Changes for ticket 394212, callid 234861 Ticket: 454775 tracker: 275473 starts

							SimpleDateFormat sdfTrans = new SimpleDateFormat("dd/MM/yyyy");
							StringBuffer strBufferDate = new StringBuffer();
							strBufferDate = sdfTrans.format(temp,strBufferDate,new FieldPosition(0));
							//sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+fiIncidentInfo.getDccReqOrigTime()+ "&nbsp;</td>");

							sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+strBufferDate.toString()+ "&nbsp;</td>");
							//Changes for ticket 394212, callid 234861 Ticket: 454775 tracker: 275473 end
							sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+objAccountTransactionSummary[index].getTxnDesc()+ "&nbsp;</td>");
								String txntype = objAccountTransactionSummary[index].getTxnType();
										String txncat = objAccountTransaction[index].getTxnCat();
										String txnsub = "";
										if(txncat != null && txncat.length()!=0){
										txnsub = txncat.substring(0,1);
										txncat = txncat.substring(1,3);
										}
										if (txnsub.equals("C"))
										{
											txnsub = "Cash";
										}
										else if (txnsub.equals("T"))
										{
											txnsub = "Transfer";
										}
										else if (txnsub.equals("L"))
										{
											txnsub = "Clearing ";
										}

										if (txntype.equals("C"))
										{
											txntype = "Credit";
										}

										else if (txntype.equals("D"))
										{
											txntype = "Debit";
										}

										sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+txncat+ "&nbsp;</td>");
										sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+txnsub+ "&nbsp;</td>");
										sbfHtmlOutput.append("<td align=left class=\"fntColData\">"+txntype+ "&nbsp;</td></tr>");
						}
						/* Fix for ticket 297285 : END */
			sbfHtmlOutput.append("</table>");
			sbfHtmlOutput.append("<br></br>");
			/* Change done for ticket 298876: Begin */
			sbfHtmlOutput.append("<table class=\"background\">");
			sbfHtmlOutput.append("<TR><TD align='left'><input class=\"frmBttns\" type='button' value='Print' onClick='PrintFrame();'>");
			 sbfHtmlOutput.append("</TD>");
			 sbfHtmlOutput.append("<TD align = 'center'><input class=\"frmBttns\" type='button' value='Close' onclick='closeWin();'>");
			sbfHtmlOutput.append("</TD></TR>");
			sbfHtmlOutput.append("</table>");
			/* Change done for ticket 298876: End */
			sbfHtmlOutput.append("</body></html>");
			reqBO.setOnlineAttribute("Display");
			reqBO.setUserTextField5(sbfHtmlOutput.toString());
				}
				Hashtable outputHash = new Hashtable();
				String notes = "Step completed successfully";
				CommonQueries.UpdateIncident( bc , incidentBO.getIncidentID() , "Closed" , null , notes , null , false , null , null );
				WebAdaptor.log(com.infy.cis.log.LogType.MINOR,notes);
		        return outputHash;
// Tracker 137636 Bank Satement changes end, called proper API methods to get statement

				}
				catch (CINonFatalException e){

				if((e.getMessage().indexOf("No record could be retrieved") != -1))
					{
			//			//System.out.println("Invalid***********************");
						throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , new FCRMGenericException(new Exception("No record could be retrieved")));
					}
					else {
					throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
								SRMBCException.MakeReplaceableArg("CINonFatalException - " + e.getMessage()),
					null);
				}

	    		}
		        catch (CIFatalException e){

				if((e.getMessage().indexOf("No record could be retrieved") != -1))
					{
			//			//System.out.println("Invalid***********************");
						throw new SRMPreWriteException(SRMBOException.ERROR_CI_FATAL , new FCRMGenericException(new Exception("No record could be retrieved")));
					}
					else {
				    throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CIFatalException - " + e.getMessage()),
									 null);
					}
		         }
		       catch (CIOnsNonFatalException confe) {

			   String strErrMsg = "";
               WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"CIOnsNonFatalException");
			   /*for (int i = 0; i < confe.getErrorLL().size(); i++) {
               WebAdaptor.log(com.infy.cis.log.LogType.MINOR," " + (i + 1) + ", " + confe.getErrorLL().get(i));
               CIOnsErr errObj = (CIOnsErr) confe.getErrorLL().get(i);
               if (errObj.ciErrFieldDesc == null || errObj.ciErrFieldDesc.length() < 1) {
                strErrMsg = strErrMsg +"(" + (i + 1) + ") " + errObj.errDesc;
			   } else {
               strErrMsg = strErrMsg +"(" + (i + 1) + ") " + errObj.ciErrFieldDesc + "_" + errObj.errDesc;
               }
               WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"VALIDATION_ERROR"+strErrMsg);
               }   */
			   throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CIOnsNonFatalException - " + strErrMsg),
									 null);
			   }
    		   catch(Exception e){
		       throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg(e.getMessage()),
				        			 null);
			   }

	}
// end of proceedForBankStatement Method


	/*
	 * The method fetches data from Channel Integrator for Standing Order Simple Request
	 * Added to handle Standing Order Simple Service Request
 	 * @param incidentBO - Incident BO
	 * @param reqBO - Request BO
	 * @param bc - SRMBusiness Context
	 * @param requestMode - Mode of Request Online
	 * @return Hashtable - This Hashtable contains output values fetched from Channel Integrator
	 * @exception SRMPreWriteException
	 */
public RecPmtAddRs proceedForStandingOrderSimple( IncidentBO incidentBO, RequestBO reqBO,
									   SRMBusinessContext bc,String requestMode )throws SRMPreWriteException,SRMBCException{
	try {
			String strBackEnd=null;
			String strAccBranch=null;
			String	strApplCurrency=null;
			List lSales=null;
			String strDate=null;
			String	postTranId=null;
			String sBranch=null;

			CIUserInfo CIU = new CIUserInfo();
			CIU.setChannelType("CRM");
			String bankID = (String)com.infy.cis.common.SRMTLVar.bank_id.get();
		    CIU.setBankId(bankID);
            //CIStandingInstructionOutput cIStandInstrOp =new CIStandingInstructionOutput();
            //FI related changes by Mukundhan
            //CISimpleSIMsgDet siInputMsgDet = new CISimpleSIMsgDet();
            RecPmtAddRq recPmtAddRq = new RecPmtAddRq();
            RecPmtAddRs recPmtAddRs = new RecPmtAddRs();
			CustId custId =new CustId();

			/* Change for tracker 181613 : SIT10202 Changes Begin */
			//Freq freq_Type = new Freq();
			//Freq freq_StDt = new Freq();
			//Freq freq_Hldy = new Freq();
		//	Freq freq_WeekNum = new Freq();
		//	Freq freq_WeekDay = new Freq();
			Freq objFreq = new Freq();
			/* Change for tracker 181613 : SIT10202 Changes End */
			com.infosys.ci.ons.common.AcctId psAcct1 = new com.infosys.ci.ons.common.AcctId();
			com.infosys.ci.ons.common.AcctId psAcct2 = new com.infosys.ci.ons.common.AcctId();

            //CIPartInstrLL[] partInstrLL =new CIPartInstrLL[1];
            //CIPartInstrLL partInstrLL1 = new CIPartInstrLL();
            //CIPrDetail prDetail = new CIPrDetail();
            //CIPartInstruct partInstruction = new CIPartInstruct();
            /* SIT10202 Change - END */
  	  		OnsSrvRequestALImplementation onsSrvReqALImp = new OnsSrvRequestALImplementation();
            FIIncidentInfo fiIncidentInfo = new FIIncidentInfo();

			/*siInputMsgDet.setAutoPostFlg("Y");
            siInputMsgDet.setCarryFwdAlwdFlg("Y");
            siInputMsgDet.setDelTranIfNotPstd("Y");
            siInputMsgDet.setValidateCrncyHldy("Y");*/

            //prDetail.setFeeCollectFlg("Y");

			/* CRA10MSC - ARM - Begin of changes*/
			// Setting Correlator ID for forced sub-trans in core
			//byte CorrelatorID[]=ARMTransHelper.getCorrelator();
			//CIU.setCorrelationId(CorrelatorID);
			/* CRA10MSC - ARM - End of changes*/
			/*Tracker 103058 : FI Call Change :Start
			CIRemoteAccessInterface inter= null;
			inter = CIHostMarker.getCIHostForONS();
			Tracker 103058 : FI Call Change :End*/

			String strIncidentFor = incidentBO.getIncidentFor();
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			if(strIncidentFor == null){
					Exception e = new FCRMGenericException("MSGEXC0049",new Exception("IncidentFor cannot be null for any Incident."));
					throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , e);
			}else if(strIncidentFor.equalsIgnoreCase("SUSPECT") || strIncidentFor.equalsIgnoreCase("CONTACT")){
					Exception e = new FCRMGenericException("MSGEXC0050",new Exception("Incident will not be processed for prospect and contact."));
					throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , e);
			}else if(strIncidentFor.equalsIgnoreCase("CUSTOMER")){
					strBackEnd = incidentBO.getBackEndCustID();
					}
			lSales=CommonQueryFunctions.getSalesData(incidentBO.getAccountNumber(),bc);
			strAccBranch=(String)lSales.get(3);
			if (strAccBranch==null)
			{throw new FCRMGenericException("MSGEXC0071",new Exception("BranchId is Not available for the selected  Account"));
			}
			//if(strBackEnd != null){
			String Accid=getAccountId(incidentBO.getCrmCustID(),bc);
			String Backendcustid =getCustomerId(incidentBO.getAccountNumber(),Accid,bc);
			custId.setCustId(Backendcustid);
       		  	recPmtAddRq.setCustId(custId);
			//}
			if(strAccBranch!= null){
			/* SIT10202 Change - BEGIN */
			//sBranch=CommonQueryFunctions.getDataFromRefCodeMapper("SERVICE_OUTLET",strAccBranch, null);
			sBranch = strAccBranch;
			/* SIT10202 Change - END */
			if (sBranch!=null){

              //recPmtAddRq.setSolsolId(sBranch);
			}else{throw new FCRMGenericException("MSGEXC0054",new Exception("Branch does not exists in Backend."));}
			}
			if(reqBO.getUserStrField5()!= null){
			/* SIT10202 Change - BEGIN */
			//String freqType=CommonQueryFunctions.getDataFromRefCodeMapper("LOAN_FREQ",reqBO.getUserStrField5().trim(), null);
				String freqType = reqBO.getUserStrField5().trim();
			//freqType = "D";
			/* SIT10202 Change - END */
			/* Change for tracker 181613 : SIT10202 Changes Begin */
			objFreq.setType(freqType);
			//if(freqType!=null)

            //  recPmtAddRq.setFreq(freq_Type);
            }
            /* Change for tracker 181613 : SIT10202 Changes End */
			else{ throw new FCRMGenericException("MSGEXC0073",new Exception("loan frequncy is not available in Backend"));}
			if(reqBO.getUserStrField6()!= null){

               Long freqStrt = new Long(reqBO.getUserStrField6().toString());
             	/* Change for tracker 181613 : SIT10202 Changes Begin */
             	objFreq.setStartDt(freqStrt);
             	// recPmtAddRq.setFreq(objFreq);
             	/* Change for tracker 181613 : SIT10202 Changes End */
            }
			if(reqBO.getUserStrField7()!= null){
			/* SIT10202 Change - BEGIN */
			//String freqHDayStart=CommonQueryFunctions.getDataFromRefCodeMapper("HOLIDAY_START",reqBO.getUserStrField7().trim(), null);
				String freqHDayStart = reqBO.getUserStrField7().trim();
				//freqHDayStart="N";
				/* Change for tracker 181613 : SIT10202 Changes Begin */
				objFreq.setHolStat(freqHDayStart);
				if(freqHDayStart!=null){

           // recPmtAddRq.setFreq(freq_Hldy);
            }
            /* Change for tracker 181613 : SIT10202 Changes End */
			else{throw new FCRMGenericException("MSGEXC0074",new Exception("Holiday Frequency is not available in Backend"));}
			}
			if(reqBO.getUserStrField4()!= null){
			/* SIT10202 Change - BEGIN */
			//String freqECode=CommonQueryFunctions.getDataFromRefCodeMapper("EXEC_TIME",reqBO.getUserStrField4().trim(), null);
				String freqECode = reqBO.getUserStrField4().trim();
			//freqECode="After Business Hours";
			/* SIT10202 Change - END */
			if(freqECode!=null){

            //recPmtAddRq.setExecCodecode(freqECode);
            }
			else{throw new FCRMGenericException("MSGEXC0075",new Exception("Frequency execution code  is not available in Backend"));}
			}
			if(reqBO.getUserDateField1()!= null){

			/* Change for tracker 181613 : SIT10202 Changes Begin */
			//SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.S");
				//Date tempStDate = new Date("15/07/2002");
				//String strStartDate = formatter.format(reqBO.getUserDateField1());
				//String strStartDate = formatter.format(tempStDate);
           //  SimpleDateFormat startDate = new SimpleDateFormat(strStartDate);
             //recPmtAddRq.setSiStartDate(startDate.getCalendar());


			 	SimpleDateFormat endDate1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.S");
				String dateString1 = endDate1.format(reqBO.getUserDateField1());
			 	Date startDate1 = reqBO.getUserDateField1();
         		Calendar cal = Calendar.getInstance();
         	//	Date tempStDate = new Date("07/11/2002");
//Changes for ticket id 596751 and recon for call id 306538 starts
        		//Date tempStDate = new Date(dateString1);
				try
				{
					Date tempStDate=endDate1.parse(dateString1);
        	     cal.setTime(tempStDate);
				}
				catch(ParseException e)
				{
					e.printStackTrace();
				}
//Changes for ticket id 596751 and recon for call id 306538 ends
			 	//int startMonth =startDate1.getMonth();
			 	//startMonth++;
			 	//startDate1.setMonth(startMonth);
				//String NextExec1 = formatter.format(startDate1);
				//SimpleDateFormat NextExecDate = new SimpleDateFormat(NextExec1);
			 	recPmtAddRq.setNextPrcDate(cal);
			 //	recPmtAddRq.setNextPrcDate(startDate);
			}
			if(reqBO.getUserDateField2()!= null){


			//SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.S");
				Calendar cal1 = Calendar.getInstance();
				//String strEndDate = formatter.format(reqBO.getUserDateField2());
				SimpleDateFormat strEndDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.S");
				String dateString2 = strEndDate.format(reqBO.getUserDateField2());
//Changes for ticket id 596751 and recon for call id 306538 starts
				try{
				Date tempEdDate = strEndDate.parse(dateString2);
				//Date tempEdDate = new Date("07/12/2002");

				//String strEndDate = formatter.format(tempEdDate);
           // SimpleDateFormat endDate = new SimpleDateFormat(strEndDate);
           cal1.setTime(tempEdDate);
		   		}
		   		catch(ParseException e)
		   		{
		   			e.printStackTrace();
				}
//Changes for ticket id 596751 and recon for call id 306538 ends
            recPmtAddRq.setFinalPrcDate(cal1);
			}
			/* Change for tracker 181613 : SIT10202 Changes End */
			if(reqBO.getUserStrField1()!= null){
			/* SIT10202 Change - BEGIN */
            //  partInstruction.setRefCrncycrncyCode(reqBO.getUserStrField1());
            /* SIT10202 Change - END */
			}
			/* SIT10202 Change - BEGIN */
			if(incidentBO.getAccountNumber()!= null){

				psAcct1.setAcctId(incidentBO.getAccountNumber());
				recPmtAddRq.setDrAcct(psAcct1);
			}
			/* SIT10202 Change - END */
			if(incidentBO.getAccCurrencyCode()!= null){
				/* SIT10202 Change - BEGIN */
                 //prDetail.setAcctcrncyCode(incidentBO.getAccCurrencyCode());
                 /* SIT10202 Change - END */
			}
			if(strAccBranch!= null){
				/* SIT10202 Change - BEGIN */
                //prDetail.setAcctsolId(sBranch);
                /* SIT10202 Change - END */
			}
    		if(reqBO.getUserStrField3()!= null){

			lSales=CommonQueryFunctions.getSalesData(reqBO.getUserStrField3().trim(),bc);
			Integer salesid=(Integer)lSales.get(0);
			if (salesid==null)
			{throw new FCRMGenericException("MSGEXC0076",new Exception("Sales Id for the selected Account in not Available"));
			}
			strAccBranch=(String)lSales.get(3);
			lSales=CommonQueryFunctions.getSaleBackEndData(salesid,bc);
			strApplCurrency=(String)lSales.get(1);
			if (strApplCurrency==null || strAccBranch==null)
			{throw new FCRMGenericException("MSGEXC0077",new Exception("Invalid Account Data for Branch or Currency for the selected account"));
			}
			/* SIT10202 Change - BEGIN */
			//sBranch=CommonQueryFunctions.getDataFromRefCodeMapper("SERVICE_OUTLET",strAccBranch, null);
			sBranch = strAccBranch;
			/* SIT10202 Change - END */
			if(strApplCurrency!= null){

			}
			/*if(sBranch!= null){
			inputHash.put("contra_acct_num_sol_id",sBranch);}
			else{throw new FCRMGenericException("MSGEXC0078",new Exception("Service Outlet is not available in Backend"));}
			*/
			/* SIT10202 Change - BEGIN */
			psAcct2.setAcctId(reqBO.getUserStrField3().trim());
			recPmtAddRq.setBeneficiaryAcct(psAcct2);
			/* SIT10202 Change - END */
			}
			String strInstruction=reqBO.getUserTextField1();
			//Ticket 479442 tracker 291302 recon for Call id: 262684 changes starts
			/*if(strInstruction!= null){
				if (strInstruction.length()>30)
				{
					// Tracker 185776 starts
					throw new FCRMGenericException("MSGEXC0079");
					// Tracker 185776 ends
				}
				else{
				// SIT10202 Change - BEGIN
                //  prDetail.setTranRemarks(strInstruction);
                // SIT10202 Change - END
                }
            }*/
            //Ticket 479442 tracker 291302 recon for Call id: 262684 changes ends
			/*if(reqBO.getUserAmountField1()!= null){
			inputHash.put("ref_amt",reqBO.getUserAmountField1().toString()+"|"+reqBO.getUserStrField1());

            }*/
            /* SIT10202 Change - BEGIN */
            Amount fixedAmt3 = new Amount();
			fixedAmt3.setAmountValue(reqBO.getUserAmountField1().doubleValue());
         //	fixedAmt3.setCurrencyCode("INR");
            fixedAmt3.setCurrencyCode(reqBO.getUserStrField1().trim());
           //  prDetail.setFixedAmt(fixedAmt3);
             //partInstruction.setFixedAmt(fixedAmt3);
            recPmtAddRq.setRemitAmt(fixedAmt3);
            recPmtAddRq.setRecPmtType("C");
           // partInstruction.setAmtIndcode("F");
          //  if(reqBO.getUserStrField8() == null){

		//		Exception e = new FCRMGenericException(new Exception("The Amount Indicator is Mandatory"));
		//		throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
		//	}
		//	else{
			//	partInstruction.setAmtIndcode(reqBO.getUserStrField8());
		//	}
           // partInstruction.setPartTranType("D");
         // if(reqBO.getUserStrField9() == null){
		//		Exception e = new FCRMGenericException(new Exception("The Part Transaction Type is Mandatory"));
		//		throw new SRMPreWriteException(SRMBOException.ERROR_ATTRIB_IS_MANDATORY , e);
		//	}
		//	else{
            	//partInstruction.setPartTranType(reqBO.getUserStrField9());
		//	}

		/* SIT10202 Change - END */
			String sWeekNum = reqBO.getUserStrField11();

			String sWeekDay = reqBO.getUserStrField12();
			if( sWeekNum != null){
				/* Change for tracker 181613 : SIT10202 Changes Begin */
				//long weekNum = Long.parseLong(sWeekNum);
				objFreq.setWeekNum(sWeekNum);
				//recPmtAddRq.setFreq(freq_WeekNum);
			}
			if( sWeekDay != null){
				long weekDay = Long.parseLong(sWeekDay);
				objFreq.setWeekDay(weekDay);
				//recPmtAddRq.setFreq(freq_WeekDay);
			}
			recPmtAddRq.setFreq(objFreq);
			/* Change for tracker 181613 : SIT10202 Changes End */
// changes begin : tracker 65962
//inputHash.put("incident_id",incidentBO.getIncidentID().toString());
//Tracker-67790 -Begin of change

 	if( incidentBO.getCaseID() != null){
		fiIncidentInfo.	setDccReqRefNum(incidentBO.getCaseID());
		fiIncidentInfo.setBackEndReqRefNum(incidentBO.getCaseID());
	}else{
		throw new FCRMGenericException("MSGEXCP0005",new Exception("CaseID is null"));
	}
	/*SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss.S");
	Date currentTime_1 = new Date();
	String dateString = formatter.format(currentTime_1);
	fiIncidentInfo.	setDccReqOrigTime(dateString);*/
	fiIncidentInfo.setDccReqOrigTime(getDateFormatforFIServReq()); //10.1 RECON change
//Tracker-67790 -End of change
//inputHash.put("DC_ID","CRM");
// outputHash = (Hashtable)inter.processServiceRequest(CIU,"DD_MASS_ISSUE",inputHash);
// end of changes: tracker 65962

		/* SIT10202 Change - BEGIN */
	    	//	partInstruction.setCreateMpEntryFlg("N");
			//partInstrLL1.setPrDetail(prDetail);
            //partInstrLL1.setPartInstruction(partInstruction);
	    	//partInstrLL[0] = partInstrLL1;
			//recPmtAddRq.setPartInstrLL(partInstrLL);
			/* SIT10202 Change - END */
			recPmtAddRq.setFiIncidentInfo(fiIncidentInfo);
	    	// Fi changes start
	    	recPmtAddRs=onsSrvReqALImp.RecPmtAdd(CIU,recPmtAddRq);
	    	//cIStandInstrOp = (CIStandingInstructionOutput)onsSrvReqALImp.processSimpleSI(CIU,siInputMsgDet);
	    	if(requestMode.equalsIgnoreCase("Online")){
			String notes = "Step completed successfully";
			if(recPmtAddRs.getRecPmtId()!=null){
			postTranId = recPmtAddRs.getRecPmtId();
			notes = notes+" : BackEndReference Number = "+postTranId;
			CommonQueries.UpdateIncident( bc , incidentBO.getIncidentID() , "Closed" , null , notes , postTranId , false , null , null );
			}
			WebAdaptor.log(com.infy.cis.log.LogType.MINOR,notes);
			}

			return recPmtAddRs;
			}
			catch (CINonFatalException e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CINonFatalException - " + e.getMessage()),
									 null);
			}
		    catch (CIFatalException e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CIFatalException - " + e.getMessage()),
									 null);
		    }
		    catch (CIOnsNonFatalException confe) {
			String strErrMsg = "";
            WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"CIOnsNonFatalException");
			/*for (int i = 0; i < confe.getErrorLL().size(); i++) {
            WebAdaptor.log(com.infy.cis.log.LogType.MINOR," " + (i + 1) + ", " + confe.getErrorLL().get(i));
            CIOnsErr errObj = (CIOnsErr) confe.getErrorLL().get(i);
            if (errObj.ciErrFieldDesc == null || errObj.ciErrFieldDesc.length() < 1) {
            strErrMsg = strErrMsg +"(" + (i + 1) + ") " + errObj.errDesc;
            }
			else {strErrMsg = strErrMsg +"(" + (i + 1) + ") " + errObj.ciErrFieldDesc + "_" + errObj.errDesc;}
            WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"VALIDATION_ERROR"+strErrMsg);
            }	*/
		    throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CIOnsNonFatalException - " + strErrMsg),
									 null);
			}
		    catch(Exception e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg(e.getMessage()),
							 null);
			}
	}

	// end of proceedForStandingOrderSimple Met hod


/*
	 * The method fetches data from Channel Integrator for Standing Order Simple Request
	 * Added to handle Standing Order Simple Service Request
 	 * @param incidentBO - Incident BO
	 * @param reqBO - Request BO
	 * @param bc - SRMBusiness Context
	 * @param requestMode - Mode of Request Online
	 * @return Hashtable - This Hashtable contains output values fetched from Channel Integrator
	 * @exception SRMPreWriteException
	 */
public Hashtable proceedForAddressChange( IncidentBO incidentBO, RequestBO reqBO,
									   SRMBusinessContext bc,String requestMode )throws SRMPreWriteException,SRMBCException
{
	try {
			String tempdate=null;
			String strCity=null;
			String strState=null;
			String strBackEnd=null;
			String	strCountry=null;
			String	schemeCode=null;
			String	schemeType=null;
			String	postTranId=null;
			Hashtable outputHash=null;
			Integer prodCatID=null;
			Hashtable inputHash = new Hashtable();
			CIUserInfo CIU = new CIUserInfo();
			String strIncidentFor = incidentBO.getIncidentFor();
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			/*Tracker 103058 : FI Call Change :Start
			CIRemoteAccessInterface inter= null;
			inter = CIHostMarker.getCIHostForONS();
			Tracker 103058 : FI Call Change :End*/
			if(strIncidentFor == null){
					Exception e = new FCRMGenericException("MSGEXC0049",new Exception("IncidentFor cannot be null for any Incident."));
					throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , e);
			}else if(strIncidentFor.equalsIgnoreCase("SUSPECT") || strIncidentFor.equalsIgnoreCase("CONTACT")){
					Exception e = new FCRMGenericException("MSGEXC0050",new Exception("Incident will not be processed for prospect and contact."));
					throw new SRMPreWriteException(SRMBOException.ERROR_CI_NONFATAL , e);
			}else if(strIncidentFor.equalsIgnoreCase("CUSTOMER")){
					strBackEnd = incidentBO.getBackEndCustID();
			}
			String strAccountLevel=reqBO.getUserStrField30().trim();
			if(strAccountLevel.equals("Y"))
				{
					if(incidentBO.getAccountNumber()!= null){
					inputHash.put("acct_num",incidentBO.getAccountNumber());
					}
					List salelist = CommonQueryFunctions.getSalesData(incidentBO.getAccountNumber() , bc );
					schemeCode  = (String)salelist.get(1);
					WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"schemeCode"+schemeCode);
					prodCatID	 = (Integer)salelist.get(4);
					WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"prodCatID"+prodCatID);
					switch(prodCatID.intValue())
					{
					  case  1 : 	schemeType = "SBA";
									break;
					  case  2 : 	schemeType = "TDA";
									break;
					  case  3 :  	schemeType = "CAA";
									break;
					  case  4 :		schemeType = "CCA";
									break;
					  case  5 :		schemeType = "HOC";
									break;
					  case  6 :		schemeType = "LAA";
									break;
					  //Left for customised schemetype
					  //case  7 :		schemeType = ;
					  //				break;
					  //case  8 :		schemeType = ;
					  //				break;
					  //case  9 :		schemeType = ;
					  //				break;
					  //case  10:		schemeType = ;
					  //				break;
					}

					if( schemeCode == null || schemeCode.trim().equals("")){
					throw new FCRMGenericException("MSGEXC0082",new Exception("Scheme code does not exist in Backend."));
					} else {
					inputHash.put("scheme_code",schemeCode);
					}
					if( schemeType == null || schemeType.trim().equals("")){
					throw new FCRMGenericException("MSGEXC0083",new Exception("Scheme type does not exist in Backend."));
					} else {
					inputHash.put("scheme_type",schemeType);
					}
					/*code changed to include new address fields in CIF*/
					SRMCollection serReqGenInfo = reqBO.getRequestGenInfo();
					RequestBO.RequestGenInfo reqGenInfo =(RequestBO.RequestGenInfo)serReqGenInfo.get(0);

					String address1,address2;
					address1 = "";
					address2 = "";

					if(reqGenInfo.getUserStrField2()!= null){
						address1 = address1 + reqGenInfo.getUserStrField2() + ",";
					}
					if(reqGenInfo.getUserStrField3()!= null){
						address1 = address1 + reqGenInfo.getUserStrField3() + ",";
					}

					if(reqGenInfo.getUserStrField4()!= null){
						address1 = address1 + reqGenInfo.getUserStrField35() + ",";
					}

					if(reqGenInfo.getUserStrField34()!= null){
						address1 = address1 + reqGenInfo.getUserStrField34() + ",";
					}



					if(reqGenInfo.getUserStrField35()!= null){
						address2 = address2 + reqGenInfo.getUserStrField4() + ",";
					}
					if(reqGenInfo.getUserStrField36()!= null){
						address2 = address2 + reqGenInfo.getUserStrField36() + ",";
					}
					if(reqGenInfo.getUserStrField37()!= null){
						address2 = address2 + reqGenInfo.getUserStrField37() + ",";
					}
					if(reqGenInfo.getUserStrField38()!= null){
						address2 = address2 + reqGenInfo.getUserStrField38() + ",";
					}

					//finally inserting the address fields in hash table
					if(address1!=null)
					{
						inputHash.put("address1",address1);
					}

					if(address2!=null)
					{
						inputHash.put("address2",address2);
					}
					/*end of changes*/
					if(reqGenInfo.getUserStrField5()!= null){
				//	strCity=CommonQueryFunctions.getDataFromRefCodeMapper
				//	("CITY",reqGenInfo.getUserStrField5().trim(), null
				//	);
						strCity = reqGenInfo.getUserStrField5().trim();
					if(strCity!=null){
					inputHash.put("city_code",strCity);}
					else{throw new FCRMGenericException("MSGEXC0084",new Exception("City is not available in Backend"));}
					}
					if(reqGenInfo.getUserStrField6()!= null){
					//strState=CommonQueryFunctions.getDataFromRefCodeMapper
					//("STATE",reqGenInfo.getUserStrField6().trim(), null
					//);
						strState = reqGenInfo.getUserStrField6().trim();
					if(strState!=null){
					inputHash.put("state_code",strState);}
					else{throw new FCRMGenericException("MSGEXC0085",new Exception("State is not available in Backend"));}
					}
					if(reqGenInfo.getUserStrField7()!= null){
					//strCountry=CommonQueryFunctions.getDataFromRefCodeMapper
					//("COUNTRY",reqGenInfo.getUserStrField7().trim(), null
					//);
						strCountry = reqGenInfo.getUserStrField7().trim();
					if(strCountry!=null){
					inputHash.put("country_code",strCountry);}
					else{throw new FCRMGenericException("MSGEXC0086",new Exception("Country is not available in Backend"));}
					}
					if(reqGenInfo.getUserStrField8()!= null){
					inputHash.put("postal_code",reqGenInfo.getUserStrField8());
					}
					if(reqGenInfo.getUserStrField10()!= null){
					inputHash.put("phone_num",reqGenInfo.getUserStrField10());
					}
					/*
					if(reqGenInfo.getUserStrField14()!= null){
					inputHash.put("tlx_num",reqGenInfo.getUserStrField10());
					}
					*/

					if(reqGenInfo.getUserStrField11()!= null){
					inputHash.put("fax_num",reqGenInfo.getUserStrField11());
					}
					if(reqGenInfo.getUserStrField13()!= null){
					inputHash.put("email_id",reqGenInfo.getUserStrField13());
					}

						outputHash = new Hashtable();//(Hashtable)inter.processServiceRequest(CIU,"CHANGE_OF_ADDRESS",inputHash);
					String notes = "Step completed successfully";
					if(outputHash.get("postTranId")!=null){
					postTranId = outputHash.get("postTranId").toString();
					notes = notes+" : BackEndReference Number = "+postTranId;
					}
					if(approvalCheck.equals("false"))
						CommonQueries.UpdateIncident( bc , incidentBO.getIncidentID() , "Closed" , null , notes , postTranId , false , null , null );
					return outputHash;
				}
			else{

					SRMQueryBuilder qbAccount = QueryAssist.singleObjectQuery("AccountBO",AccountBO.ACCOUNTID);
					QueryAssist.addSimpleCondition(qbAccount, "AccountBO",AccountBO.ACCOUNTID,	IQuery.ComparisonOperation_EQ,incidentBO.getOrgID());
					SRMQueryResult qrAccount= qbAccount.runQuery(bc, true, -1);
					SRMRecordSet rsAccount = qrAccount.getRecordSet();
					AccountBO accountBO = (AccountBO)((ArrayList)rsAccount.getNext()).get(0);
					String recordStatus = accountBO.getRecordStatus();
					if(!recordStatus.equals("A"))
					{
						String msg="Address change request cannot be completed as record is already being used or is due for an update";
						SRMBCException ex = new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,null,new Exception(msg),true);
						throw ex;
					}
					/*changes start for 149763
					Approval check was throwing null pointer as it was not set in the application
					i.e approvalCheck check box is not checked in CRMAdmin Applet
					So Defaulted it to false for the below logic. */
					if(approvalCheck == null)
					{
						approvalCheck = "false";
					}
					/*changes End for 149763  */
					if(approvalCheck.equals("false"))
					{
						RequestBO.RequestGenInfo mailAddress=null;
						RequestBO.RequestGenInfo workAddress =null;
						RequestBO.RequestGenInfo homeAddress = null;
						SRMCollection colAddress = accountBO.getAddress();
						SRMCollection serReqGenInfo = reqBO.getRequestGenInfo();
						boolean AddrHome = false;
						boolean AddrWork = false;
						for(int iCount = 0; iCount < serReqGenInfo.size(); iCount++)
						{
						RequestBO.RequestGenInfo reqGenInfo =(RequestBO.RequestGenInfo)serReqGenInfo.get(iCount);
						if (reqGenInfo.getUserStrField1().equals("Mailing"))   { mailAddress=reqGenInfo; }
						else if (reqGenInfo.getUserStrField1().equals("Work")) { workAddress=reqGenInfo; }
						else if (reqGenInfo.getUserStrField1().equals("Home")) { homeAddress=reqGenInfo; }
						}
						//CICustMainDetStruct custInfo= new CICustMainDetStruct();
						/*Tracker 103058 : FI Call Change :Start
						RefCodeMapper rcMapper=new RefCodeMapper();
						Tracker 103058 : FI Call Change :End*/
						for(int iCount = 0; iCount < colAddress.size(); iCount++) {
							AccountBO.Address add = (AccountBO.Address)colAddress.get(iCount);
							if (add.getAddressCategory()==null)
							{
								continue;
							}


							//second check added to verify the addressID being updated

							if((mailAddress!=null && add.getAddressCategory().equalsIgnoreCase("Mailing")))

							/*	changes start for 149763
							 * 	mailAddress.getUserStrField39() was throwing null pointer
							 * 	As this value was not set during request creation in request table.
							 * 	Also this addressID comparision check is redundant as the address is
							 * 	going to get updated ONLY for the Entity/Account selected
							 */

							//	&& (mailAddress.getUserStrField39()).equals((add.getAddressID()).toString()))

							/*	changes End for 149763  */
							{

							if(mailAddress.getUserStrField2()!=null){
							add.setHouse_no(mailAddress.getUserStrField2().trim());
							//custInfo.AddrDet.commAddrDet.address1 = mailAddress.getUserStrField2().trim();
							}
							if(mailAddress.getUserStrField3()!=null){
							add.setBuilding_level(mailAddress.getUserStrField3().trim());
							//custInfo.AddrDet.commAddrDet.address2 = mailAddress.getUserStrField3().trim();
								}
							if(mailAddress.getUserStrField4()!=null){
							add.setStreet_name(mailAddress.getUserStrField4().trim());
							}

							if(mailAddress.getUserStrField34()!=null){
								add.setStreet_no(mailAddress.getUserStrField34().trim());
							}

							if(mailAddress.getUserStrField35()!=null){
								add.setPremise_name(mailAddress.getUserStrField35().trim());
							}

							if(mailAddress.getUserStrField36()!=null){
								add.setLocality_name(mailAddress.getUserStrField36().trim());
							}

							if(mailAddress.getUserStrField37()!=null){
								add.setSuburb(mailAddress.getUserStrField37().trim());
							}

							if(mailAddress.getUserStrField38()!=null){
								add.setTown(mailAddress.getUserStrField38().trim());
							}

							if(mailAddress.getUserStrField5()!=null){
							add.setCity(mailAddress.getUserStrField5().trim());
							}
							if(mailAddress.getUserStrField6()!=null){
							add.setState(mailAddress.getUserStrField6().trim());
							}
							if(mailAddress.getUserStrField7()!=null){

							add.setCountry(mailAddress.getUserStrField7().trim());
							}
							if(mailAddress.getUserStrField8()!=null){
							add.setZip(mailAddress.getUserStrField8().trim());
							//custInfo.AddrDet.commAddrDet.postalCode = mailAddress.getUserStrField8().trim();
							}
							if(mailAddress.getUserDateField1()!=null){
							add.setStart_Date(mailAddress.getUserDateField1());
							}
							if(mailAddress.getUserDateField2()!=null){
							add.setEnd_Date(mailAddress.getUserDateField2());
							}
							if(mailAddress.getUserStrField10()!=null){
							add.setPhoneNo1(mailAddress.getUserStrField10());// phone no set to Account Bo
							//custInfo.AddrDet.commAddrDet.phone1=mailAddress.getUserStrField10();
							}
							if(mailAddress.getUserStrField11()!=null){
							add.setFaxNo(mailAddress.getUserStrField11()); // Fax is set to Account BO
							//custInfo.AddrDet.commAddrDet.faxNo=mailAddress.getUserStrField11();
							}
							if(mailAddress.getUserStrField12()!=null){
							//custInfo.GenDet.swiftCode=mailAddress.getUserStrField12();
							//custInfo.GenDet.isSwiftCodeofBank='N';
							}
							if (mailAddress.getUserStrField13()!=null)
							{
								add.setEmail(mailAddress.getUserStrField13());
								//custInfo.AddrDet.commAddrDet.emailId=mailAddress.getUserStrField13();
							}
							if(mailAddress.getUserStrField14()!=null){

							add.setCellNo(mailAddress.getUserStrField14()); //Cell is set to Account BO
							//custInfo.PerDet.mobileNo=mailAddress.getUserStrField14();
							}
							}

							else if((workAddress!=null && add.getAddressCategory().equalsIgnoreCase("Work")) &&
								(workAddress.getUserStrField39()).equals((add.getAddressID()).toString())) {
							AddrWork = true;

							if(workAddress.getUserStrField2()!=null)
							{
								add.setHouse_no(workAddress.getUserStrField2().trim());
								//custInfo.AddrDet.EmpAddrDet.address1 = workAddress.getUserStrField2().trim();
							}

							if(workAddress.getUserStrField3()!=null)
							{
								add.setBuilding_level(workAddress.getUserStrField3().trim());
								//custInfo.AddrDet.EmpAddrDet.address2 = workAddress.getUserStrField3().trim();
							}

							if(workAddress.getUserStrField4()!=null)
							{
								add.setStreet_name(workAddress.getUserStrField4().trim());
							}

							if(workAddress.getUserStrField34()!=null)
							{
								add.setStreet_no(workAddress.getUserStrField34().trim());
							}

							if(workAddress.getUserStrField35()!=null)
							{
								add.setPremise_name(workAddress.getUserStrField35().trim());
							}

							if(workAddress.getUserStrField36()!=null)
							{
								add.setLocality_name(workAddress.getUserStrField36().trim());
							}

							if(workAddress.getUserStrField37()!=null)
							{
								add.setSuburb(workAddress.getUserStrField37().trim());
							}

							if(workAddress.getUserStrField38()!=null)
							{
								add.setTown(workAddress.getUserStrField38().trim());
							}

							if(workAddress.getUserStrField5()!=null){
							add.setCity(workAddress.getUserStrField5().trim() );

							}
							if(workAddress.getUserStrField6()!=null){
							add.setState(workAddress.getUserStrField6().trim());

							}
							if(workAddress.getUserStrField7()!=null){
							add.setCountry(workAddress.getUserStrField7().trim());
							}
							if(workAddress.getUserStrField8()!=null){
							add.setZip(workAddress.getUserStrField8().trim());
							//custInfo.AddrDet.EmpAddrDet.postalCode = workAddress.getUserStrField8().trim();
							}
							if(workAddress.getUserDateField1()!=null){
							add.setStart_Date(workAddress.getUserDateField1());
							}
							if(workAddress.getUserDateField2()!=null){
							add.setEnd_Date(workAddress.getUserDateField2());
							}
							if(workAddress.getUserStrField10()!=null){
							add.setPhoneNo1(workAddress.getUserStrField10());
							//custInfo.AddrDet.EmpAddrDet.phone1=workAddress.getUserStrField10();
							}
							if(workAddress.getUserStrField11()!=null){
							//custInfo.AddrDet.EmpAddrDet.faxNo=workAddress.getUserStrField11();
							add.setFaxNo(workAddress.getUserStrField11());
							}
							if(workAddress.getUserStrField12()!=null){
							//custInfo.GenDet.swiftCode=workAddress.getUserStrField12();
							//custInfo.GenDet.isSwiftCodeofBank='N';
							}
							if (workAddress.getUserStrField13()!=null)
							{
								add.setEmail(workAddress.getUserStrField13());
								//custInfo.AddrDet.EmpAddrDet.emailId=workAddress.getUserStrField13();
							}
							if(workAddress.getUserStrField14()!=null){
								add.setCellNo(mailAddress.getUserStrField14());
							//custInfo.PerDet.mobileNo=workAddress.getUserStrField14();
							}
							}

							else if((homeAddress!=null && add.getAddressCategory().equalsIgnoreCase("Home")) &&
								(homeAddress.getUserStrField39()).equals((add.getAddressID()).toString())) {
							AddrHome = true;
							if(homeAddress.getUserStrField2()!=null)
							{
								add.setHouse_no(homeAddress.getUserStrField2().trim());
								//custInfo.AddrDet.EmpAddrDet.address1 = homeAddress.getUserStrField2().trim();
							}

							if(homeAddress.getUserStrField3()!=null)
							{
								add.setBuilding_level(workAddress.getUserStrField3().trim());
								//custInfo.AddrDet.EmpAddrDet.address2 = homeAddress.getUserStrField3().trim();
							}

							if(homeAddress.getUserStrField4()!=null)
							{
								add.setStreet_name(homeAddress.getUserStrField4().trim());
							}

							if(homeAddress.getUserStrField34()!=null)
							{
								add.setStreet_no(homeAddress.getUserStrField34().trim());
							}

							if(homeAddress.getUserStrField35()!=null)
							{
								add.setPremise_name(homeAddress.getUserStrField35().trim());
							}

							if(homeAddress.getUserStrField36()!=null)
							{
								add.setLocality_name(homeAddress.getUserStrField36().trim());
							}

							if(homeAddress.getUserStrField37()!=null)
							{
								add.setSuburb(homeAddress.getUserStrField37().trim());
							}

							if(homeAddress.getUserStrField38()!=null)
							{
								add.setTown(homeAddress.getUserStrField38().trim());
							}

							if(homeAddress.getUserStrField5()!=null){
							add.setCity(homeAddress.getUserStrField5().trim());

							}
							if(homeAddress.getUserStrField6()!=null){
							add.setState(homeAddress.getUserStrField6().trim());

							}
							if(homeAddress.getUserStrField7()!=null){
							add.setCountry(homeAddress.getUserStrField7().trim());

							}
							if(homeAddress.getUserStrField8()!=null){
							add.setZip(homeAddress.getUserStrField8().trim());
							//custInfo.AddrDet.PerAddrDet.postalCode = homeAddress.getUserStrField8().trim();
							}
							if(homeAddress.getUserDateField1()!=null){
							add.setStart_Date(homeAddress.getUserDateField1());
							}
							if(homeAddress.getUserDateField2()!=null){
							add.setEnd_Date(homeAddress.getUserDateField2());
							}
							if(homeAddress.getUserStrField10()!=null){
							add.setPhoneNo1(homeAddress.getUserStrField10());
							//custInfo.AddrDet.PerAddrDet.phone1=homeAddress.getUserStrField10();
							}
							if(homeAddress.getUserStrField11()!=null){
							add.setFaxNo(mailAddress.getUserStrField11());
							//custInfo.AddrDet.PerAddrDet.faxNo=homeAddress.getUserStrField11();
							}
							if(homeAddress.getUserStrField12()!=null){
							//custInfo.GenDet.swiftCode=homeAddress.getUserStrField12();
							//custInfo.GenDet.isSwiftCodeofBank='N';
							}
							if (homeAddress.getUserStrField13()!=null)
							{
								add.setEmail(homeAddress.getUserStrField13());
								//custInfo.AddrDet.PerAddrDet.emailId=homeAddress.getUserStrField13();

							}
							if(homeAddress.getUserStrField14()!=null){
							add.setCellNo(mailAddress.getUserStrField14());
							//custInfo.PerDet.mobileNo=homeAddress.getUserStrField14();
							}
							}
							}// for loop
							if(homeAddress != null && AddrHome == false)
							{
							AccountBO.Address addr = (AccountBO.Address)accountBO.getInstance("Address");
							addr.setAddressCategory("Home");
							if(homeAddress.getUserStrField2()!=null){
							addr.setHouse_no(homeAddress.getUserStrField2().trim());
							//custInfo.AddrDet.commAddrDet.address1 = homeAddress.getUserStrField2().trim();
							}
							if(homeAddress.getUserStrField3()!=null){
							addr.setBuilding_level(homeAddress.getUserStrField3().trim());
							//custInfo.AddrDet.commAddrDet.address2 = homeAddress.getUserStrField3().trim();
								}
							if(homeAddress.getUserStrField4()!=null){
							addr.setStreet_name(homeAddress.getUserStrField4().trim());
							}

							if(homeAddress.getUserStrField34()!=null){
								addr.setStreet_no(homeAddress.getUserStrField34().trim());
							}

							if(homeAddress.getUserStrField35()!=null){
								addr.setPremise_name(homeAddress.getUserStrField35().trim());
							}

							if(homeAddress.getUserStrField36()!=null){
								addr.setLocality_name(homeAddress.getUserStrField36().trim());
							}

							if(homeAddress.getUserStrField37()!=null){
								addr.setSuburb(homeAddress.getUserStrField37().trim());
							}

							if(homeAddress.getUserStrField38()!=null){
								addr.setTown(homeAddress.getUserStrField38().trim());
							}

							if(homeAddress.getUserStrField5()!=null){
							addr.setCity(homeAddress.getUserStrField5().trim());

							}
							if(homeAddress.getUserStrField6()!=null){
							addr.setState(homeAddress.getUserStrField6().trim());

							}
							if(homeAddress.getUserStrField7()!=null){
							addr.setCountry(homeAddress.getUserStrField7().trim());
							}
							if(homeAddress.getUserStrField8()!=null){
							addr.setZip(homeAddress.getUserStrField8().trim());
							//custInfo.AddrDet.PerAddrDet.postalCode = homeAddress.getUserStrField8().trim();
							}
							if(homeAddress.getUserDateField1()!=null){
							addr.setStart_Date(homeAddress.getUserDateField1());
							}
							if(homeAddress.getUserDateField2()!=null){
							addr.setEnd_Date(homeAddress.getUserDateField2());
							}
							if(homeAddress.getUserStrField10()!=null){
							addr.setPhoneNo1(homeAddress.getUserStrField10());
							//custInfo.AddrDet.PerAddrDet.phone1=homeAddress.getUserStrField10();
							}
							if(homeAddress.getUserStrField11()!=null){
							addr.setFaxNo(mailAddress.getUserStrField11());
							//custInfo.AddrDet.PerAddrDet.faxNo=homeAddress.getUserStrField11();
							}
							if(homeAddress.getUserStrField12()!=null){
							//custInfo.GenDet.swiftCode=homeAddress.getUserStrField12();
							//custInfo.GenDet.isSwiftCodeofBank='N';
							}
							if (homeAddress.getUserStrField13()!=null)
							{
								addr.setEmail(homeAddress.getUserStrField13());
								//custInfo.AddrDet.PerAddrDet.emailId=homeAddress.getUserStrField13();
							}
							if(homeAddress.getUserStrField14()!=null){
							addr.setCellNo(mailAddress.getUserStrField14());
							//custInfo.PerDet.mobileNo=homeAddress.getUserStrField14();
							}
							colAddress.add(addr);
							}
							if (workAddress != null && AddrWork ==  false )
							{
							AccountBO.Address addr = (AccountBO.Address)accountBO.getInstance("Address");
							addr.setAddressCategory("Work");
							if(workAddress.getUserStrField2()!=null){
							addr.setHouse_no(workAddress.getUserStrField2().trim());
							//custInfo.AddrDet.commAddrDet.address1 = workAddress.getUserStrField2().trim();
							}
							if(workAddress.getUserStrField3()!=null){
							addr.setBuilding_level(workAddress.getUserStrField3().trim());
							//custInfo.AddrDet.commAddrDet.address2 = workAddress.getUserStrField3().trim();
								}
							if(workAddress.getUserStrField4()!=null){
							addr.setStreet_name(workAddress.getUserStrField4().trim());
							}

							if(workAddress.getUserStrField34()!=null){
								addr.setStreet_no(workAddress.getUserStrField34().trim());
							}

							if(workAddress.getUserStrField35()!=null){
								addr.setPremise_name(workAddress.getUserStrField35().trim());
							}

							if(workAddress.getUserStrField36()!=null){
								addr.setLocality_name(workAddress.getUserStrField36().trim());
							}

							if(workAddress.getUserStrField37()!=null){
								addr.setSuburb(workAddress.getUserStrField37().trim());
							}

							if(workAddress.getUserStrField38()!=null){
								addr.setTown(workAddress.getUserStrField38().trim());
							}
							if(workAddress.getUserStrField5()!=null){
							addr.setCity(workAddress.getUserStrField5().trim() );

							}
							if(workAddress.getUserStrField6()!=null){
							addr.setState(workAddress.getUserStrField6().trim());

							}
							if(workAddress.getUserStrField7()!=null){
							addr.setCountry(workAddress.getUserStrField7().trim());

							}
							if(workAddress.getUserStrField8()!=null){
							addr.setZip(workAddress.getUserStrField8().trim());
							//custInfo.AddrDet.EmpAddrDet.postalCode = workAddress.getUserStrField8().trim();
							}
							if(workAddress.getUserDateField1()!=null){
							addr.setStart_Date(workAddress.getUserDateField1());
							}
							if(workAddress.getUserDateField2()!=null){
							addr.setEnd_Date(workAddress.getUserDateField2());
							}
							if(workAddress.getUserStrField10()!=null){
							addr.setPhoneNo1(workAddress.getUserStrField10());
							//custInfo.AddrDet.EmpAddrDet.phone1=workAddress.getUserStrField10();
							}
							if(workAddress.getUserStrField11()!=null){
							addr.setFaxNo(mailAddress.getUserStrField11());
							//custInfo.AddrDet.EmpAddrDet.faxNo=workAddress.getUserStrField11();
							}
							if(workAddress.getUserStrField12()!=null){
							//custInfo.GenDet.swiftCode=workAddress.getUserStrField12();
							//custInfo.GenDet.isSwiftCodeofBank='N';
							}
							if (workAddress.getUserStrField13()!=null)
							{
							addr.setEmail(workAddress.getUserStrField13());
								//custInfo.AddrDet.EmpAddrDet.emailId=workAddress.getUserStrField13();
							}
							if(workAddress.getUserStrField14()!=null){
							addr.setCellNo(mailAddress.getUserStrField14());
							//custInfo.PerDet.mobileNo=workAddress.getUserStrField14();
							}
							colAddress.add(addr);
							}

							//CreateCustomerInCore CCIC=new CreateCustomerInCore();
		    				DemographicBO demoBO =getDemoBOInfo(bc, accountBO.getAccountID().intValue());
						   	PsychographicBO psycBO =getPsychoBOInfo(bc, accountBO.getAccountID().intValue());

						   Integer  salesId=incidentBO.getSalesID();

							   com.infy.cis.srmbo.Core.SaveAccount(bc,(AccountBO)accountBO,AgentGroupMgr.getLoggedonUser(bc),
                               (DemographicBO) demoBO,(PsychographicBO) psycBO );
								//com.infy.cis.srmbo.Core.SaveAccount(bc,(AccountBO)accountBO);

						   String notes = "Step completed successfully";
						   CommonQueries.UpdateIncident( bc , incidentBO.getIncidentID(),"Closed" , null , notes , postTranId , false , null , null );
						   WebAdaptor.log(com.infy.cis.log.LogType.MINOR,notes);
						   return outputHash;
					}//end of approvalcheck if

					else //if approval check is required
					{

						AccountModBO accModBO = com.infy.cis.srmbo.Core.copyFromMaintoModeGeneral(accountBO,bc);

						RequestBO.RequestGenInfo mailAddress=null;
						RequestBO.RequestGenInfo workAddress =null;
						RequestBO.RequestGenInfo homeAddress = null;
						SRMCollection colAddress = accModBO.getAddress();
						SRMCollection serReqGenInfo = reqBO.getRequestGenInfo();
						boolean AddrHome = false;
						boolean AddrWork = false;
						for(int iCount = 0; iCount < serReqGenInfo.size(); iCount++)
						{
						RequestBO.RequestGenInfo reqGenInfo =(RequestBO.RequestGenInfo)serReqGenInfo.get(iCount);
						if (reqGenInfo.getUserStrField1().equals("Mailing"))   { mailAddress=reqGenInfo; }
						else if (reqGenInfo.getUserStrField1().equals("Work")) { workAddress=reqGenInfo; }
						else if (reqGenInfo.getUserStrField1().equals("Home")) { homeAddress=reqGenInfo; }
						}
						//CICustMainDetStruct custInfo= new CICustMainDetStruct();
						/*Tracker 103058 : FI Call Change :Start
						RefCodeMapper rcMapper=new RefCodeMapper();
						Tracker 103058 : FI Call Change :End*/
						for(int iCount = 0; iCount < colAddress.size(); iCount++) {
							AccountModBO.Address add = (AccountModBO.Address)colAddress.get(iCount);
							if (add.getAddressCategory()==null)
							{
								continue;
							}
							//second check added to verify the addressID being updated
							if((mailAddress!=null && add.getAddressCategory().equalsIgnoreCase("Mailing")) &&
								(mailAddress.getUserStrField39()).equals((add.getAddressID()).toString())) {
							if(mailAddress.getUserStrField2()!=null){
							add.setHouse_no(mailAddress.getUserStrField2().trim());
							//custInfo.AddrDet.commAddrDet.address1 = mailAddress.getUserStrField2().trim();
							}
							if(mailAddress.getUserStrField3()!=null){
							add.setBuilding_level(mailAddress.getUserStrField3().trim());
							//custInfo.AddrDet.commAddrDet.address2 = mailAddress.getUserStrField3().trim();
								}
							if(mailAddress.getUserStrField4()!=null){
							add.setStreet_name(mailAddress.getUserStrField4().trim());
							}

							if(mailAddress.getUserStrField34()!=null){
								add.setStreet_no(mailAddress.getUserStrField34().trim());
							}

							if(mailAddress.getUserStrField35()!=null){
								add.setPremise_name(mailAddress.getUserStrField35().trim());
							}

							if(mailAddress.getUserStrField36()!=null){
								add.setLocality_name(mailAddress.getUserStrField36().trim());
							}

							if(mailAddress.getUserStrField37()!=null){
								add.setSuburb(mailAddress.getUserStrField37().trim());
							}

							if(mailAddress.getUserStrField38()!=null){
								add.setTown(mailAddress.getUserStrField38().trim());
							}

							if(mailAddress.getUserStrField5()!=null){
							add.setCity(mailAddress.getUserStrField5().trim());
							}
							if(mailAddress.getUserStrField6()!=null){
							add.setState(mailAddress.getUserStrField6().trim());
							}
							if(mailAddress.getUserStrField7()!=null){
							add.setCountry(mailAddress.getUserStrField7().trim());
							}
							if(mailAddress.getUserStrField8()!=null){
							add.setZip(mailAddress.getUserStrField8().trim());
							//custInfo.AddrDet.commAddrDet.postalCode = mailAddress.getUserStrField8().trim();
							}
							if(mailAddress.getUserDateField1()!=null){
							add.setStart_Date(mailAddress.getUserDateField1());
							}
							if(mailAddress.getUserDateField2()!=null){
							add.setEnd_Date(mailAddress.getUserDateField2());
							}
							if(mailAddress.getUserStrField10()!=null){
							add.setPhoneNo1(mailAddress.getUserStrField10());// phone no set to Account Bo
							//custInfo.AddrDet.commAddrDet.phone1=mailAddress.getUserStrField10();
							}
							if(mailAddress.getUserStrField11()!=null){
							add.setFaxNo(mailAddress.getUserStrField11()); // Fax is set to Account BO
							//custInfo.AddrDet.commAddrDet.faxNo=mailAddress.getUserStrField11();
							}
							if(mailAddress.getUserStrField12()!=null){
							//custInfo.GenDet.swiftCode=mailAddress.getUserStrField12();
							//custInfo.GenDet.isSwiftCodeofBank='N';
							}
							if (mailAddress.getUserStrField13()!=null)
							{
								add.setEmail(mailAddress.getUserStrField13());
								//custInfo.AddrDet.commAddrDet.emailId=mailAddress.getUserStrField13();
							}
							if(mailAddress.getUserStrField14()!=null){
							add.setCellNo(mailAddress.getUserStrField14()); //Cell is set to Account BO
							//custInfo.PerDet.mobileNo=mailAddress.getUserStrField14();
							}
							}


							else if((workAddress!=null && add.getAddressCategory().equalsIgnoreCase("Work")) &&
								(workAddress.getUserStrField39()).equals((add.getAddressID()).toString())) {
							AddrWork = true;

							if(workAddress.getUserStrField2()!=null)
							{
								add.setHouse_no(workAddress.getUserStrField2().trim());
								//custInfo.AddrDet.EmpAddrDet.address1 = workAddress.getUserStrField2().trim();
							}

							if(workAddress.getUserStrField3()!=null)
							{
								add.setBuilding_level(workAddress.getUserStrField3().trim());
								//custInfo.AddrDet.EmpAddrDet.address2 = workAddress.getUserStrField3().trim();
							}

							if(workAddress.getUserStrField4()!=null)
							{
								add.setStreet_name(workAddress.getUserStrField4().trim());
							}

							if(workAddress.getUserStrField34()!=null)
							{
								add.setStreet_no(workAddress.getUserStrField34().trim());
							}

							if(workAddress.getUserStrField35()!=null)
							{
								add.setPremise_name(workAddress.getUserStrField35().trim());
							}

							if(workAddress.getUserStrField36()!=null)
							{
								add.setLocality_name(workAddress.getUserStrField36().trim());
							}

							if(workAddress.getUserStrField37()!=null)
							{
								add.setSuburb(workAddress.getUserStrField37().trim());
							}

							if(workAddress.getUserStrField38()!=null)
							{
								add.setTown(workAddress.getUserStrField38().trim());
							}

							if(workAddress.getUserStrField5()!=null){
							add.setCity(workAddress.getUserStrField5().trim() );
							}
							if(workAddress.getUserStrField6()!=null){
							add.setState(workAddress.getUserStrField6().trim());
							}
							if(workAddress.getUserStrField7()!=null){
							add.setCountry(workAddress.getUserStrField7().trim());
							}
							if(workAddress.getUserStrField8()!=null){
							add.setZip(workAddress.getUserStrField8().trim());
							//custInfo.AddrDet.EmpAddrDet.postalCode = workAddress.getUserStrField8().trim();
							}
							if(workAddress.getUserDateField1()!=null){
							add.setStart_Date(workAddress.getUserDateField1());
							}
							if(workAddress.getUserDateField2()!=null){
							add.setEnd_Date(workAddress.getUserDateField2());
							}
							if(workAddress.getUserStrField10()!=null){
							add.setPhoneNo1(workAddress.getUserStrField10());
							//custInfo.AddrDet.EmpAddrDet.phone1=workAddress.getUserStrField10();
							}
							if(workAddress.getUserStrField11()!=null){
							//custInfo.AddrDet.EmpAddrDet.faxNo=workAddress.getUserStrField11();
							add.setFaxNo(workAddress.getUserStrField11());
							}
							if(workAddress.getUserStrField12()!=null){
							//custInfo.GenDet.swiftCode=workAddress.getUserStrField12();
							//custInfo.GenDet.isSwiftCodeofBank='N';
							}
							if (workAddress.getUserStrField13()!=null)
							{
								add.setEmail(workAddress.getUserStrField13());
								//custInfo.AddrDet.EmpAddrDet.emailId=workAddress.getUserStrField13();
							}
							if(workAddress.getUserStrField14()!=null){
								add.setCellNo(mailAddress.getUserStrField14());
							//custInfo.PerDet.mobileNo=workAddress.getUserStrField14();
							}
							}

							else if((homeAddress!=null && add.getAddressCategory().equalsIgnoreCase("Home")) &&
								(homeAddress.getUserStrField39()).equals((add.getAddressID()).toString())) {
							AddrHome = true;
							if(homeAddress.getUserStrField2()!=null)
							{
								add.setHouse_no(homeAddress.getUserStrField2().trim());
								//custInfo.AddrDet.EmpAddrDet.address1 = homeAddress.getUserStrField2().trim();
							}

							if(homeAddress.getUserStrField3()!=null)
							{
								add.setBuilding_level(workAddress.getUserStrField3().trim());
								//custInfo.AddrDet.EmpAddrDet.address2 = homeAddress.getUserStrField3().trim();
							}

							if(homeAddress.getUserStrField4()!=null)
							{
								add.setStreet_name(homeAddress.getUserStrField4().trim());
							}

							if(homeAddress.getUserStrField34()!=null)
							{
								add.setStreet_no(homeAddress.getUserStrField34().trim());
							}

							if(homeAddress.getUserStrField35()!=null)
							{
								add.setPremise_name(homeAddress.getUserStrField35().trim());
							}

							if(homeAddress.getUserStrField36()!=null)
							{
								add.setLocality_name(homeAddress.getUserStrField36().trim());
							}

							if(homeAddress.getUserStrField37()!=null)
							{
								add.setSuburb(homeAddress.getUserStrField37().trim());
							}

							if(homeAddress.getUserStrField38()!=null)
							{
								add.setTown(homeAddress.getUserStrField38().trim());
							}

							if(homeAddress.getUserStrField5()!=null){
							add.setCity(homeAddress.getUserStrField5().trim());
							}
							if(homeAddress.getUserStrField6()!=null){
							add.setState(homeAddress.getUserStrField6().trim());
							}
							if(homeAddress.getUserStrField7()!=null){
							add.setCountry(homeAddress.getUserStrField7().trim());
							}
							if(homeAddress.getUserStrField8()!=null){
							add.setZip(homeAddress.getUserStrField8().trim());
							//custInfo.AddrDet.PerAddrDet.postalCode = homeAddress.getUserStrField8().trim();
							}
							if(homeAddress.getUserDateField1()!=null){
							add.setStart_Date(homeAddress.getUserDateField1());
							}
							if(homeAddress.getUserDateField2()!=null){
							add.setEnd_Date(homeAddress.getUserDateField2());
							}
							if(homeAddress.getUserStrField10()!=null){
							add.setPhoneNo1(homeAddress.getUserStrField10());
							//custInfo.AddrDet.PerAddrDet.phone1=homeAddress.getUserStrField10();
							}
							if(homeAddress.getUserStrField11()!=null){
							add.setFaxNo(mailAddress.getUserStrField11());
							//custInfo.AddrDet.PerAddrDet.faxNo=homeAddress.getUserStrField11();
							}
							if(homeAddress.getUserStrField12()!=null){
							//custInfo.GenDet.swiftCode=homeAddress.getUserStrField12();
							//custInfo.GenDet.isSwiftCodeofBank='N';
							}
							if (homeAddress.getUserStrField13()!=null)
							{
								add.setEmail(homeAddress.getUserStrField13());
								//custInfo.AddrDet.PerAddrDet.emailId=homeAddress.getUserStrField13();

							}
							if(homeAddress.getUserStrField14()!=null){
							add.setCellNo(mailAddress.getUserStrField14());
							//custInfo.PerDet.mobileNo=homeAddress.getUserStrField14();
							}
							}
							}// for loop
							if(homeAddress != null && AddrHome == false)
							{
							AccountModBO.Address addr = (AccountModBO.Address)accModBO.getInstance("Address");
							addr.setAddressCategory("Home");
							if(homeAddress.getUserStrField2()!=null){
							addr.setHouse_no(homeAddress.getUserStrField2().trim());
							//custInfo.AddrDet.commAddrDet.address1 = homeAddress.getUserStrField2().trim();
							}
							if(homeAddress.getUserStrField3()!=null){
							addr.setBuilding_level(homeAddress.getUserStrField3().trim());
							//custInfo.AddrDet.commAddrDet.address2 = homeAddress.getUserStrField3().trim();
								}
							if(homeAddress.getUserStrField4()!=null){
							addr.setStreet_name(homeAddress.getUserStrField4().trim());
							}

							if(homeAddress.getUserStrField34()!=null){
								addr.setStreet_no(homeAddress.getUserStrField34().trim());
							}

							if(homeAddress.getUserStrField35()!=null){
								addr.setPremise_name(homeAddress.getUserStrField35().trim());
							}

							if(homeAddress.getUserStrField36()!=null){
								addr.setLocality_name(homeAddress.getUserStrField36().trim());
							}

							if(homeAddress.getUserStrField37()!=null){
								addr.setSuburb(homeAddress.getUserStrField37().trim());
							}

							if(homeAddress.getUserStrField38()!=null){
								addr.setTown(homeAddress.getUserStrField38().trim());
							}

							if(homeAddress.getUserStrField5()!=null){
							addr.setCity(homeAddress.getUserStrField5().trim());
							}
							if(homeAddress.getUserStrField6()!=null){
							addr.setState(homeAddress.getUserStrField6().trim());
							}
							if(homeAddress.getUserStrField7()!=null){
							addr.setCountry(homeAddress.getUserStrField7().trim());
							}
							if(homeAddress.getUserStrField8()!=null){
							addr.setZip(homeAddress.getUserStrField8().trim());
							//custInfo.AddrDet.PerAddrDet.postalCode = homeAddress.getUserStrField8().trim();
							}
							if(homeAddress.getUserDateField1()!=null){
							addr.setStart_Date(homeAddress.getUserDateField1());
							}
							if(homeAddress.getUserDateField2()!=null){
							addr.setEnd_Date(homeAddress.getUserDateField2());
							}
							if(homeAddress.getUserStrField10()!=null){
							addr.setPhoneNo1(homeAddress.getUserStrField10());
							//custInfo.AddrDet.PerAddrDet.phone1=homeAddress.getUserStrField10();
							}
							if(homeAddress.getUserStrField11()!=null){
							addr.setFaxNo(mailAddress.getUserStrField11());
							//custInfo.AddrDet.PerAddrDet.faxNo=homeAddress.getUserStrField11();
							}
							if(homeAddress.getUserStrField12()!=null){
							//custInfo.GenDet.swiftCode=homeAddress.getUserStrField12();
							//custInfo.GenDet.isSwiftCodeofBank='N';
							}
							if (homeAddress.getUserStrField13()!=null)
							{
								addr.setEmail(homeAddress.getUserStrField13());
								//custInfo.AddrDet.PerAddrDet.emailId=homeAddress.getUserStrField13();
							}
							if(homeAddress.getUserStrField14()!=null){
							addr.setCellNo(mailAddress.getUserStrField14());
							//custInfo.PerDet.mobileNo=homeAddress.getUserStrField14();
							}
							colAddress.add(addr);
							}
							if (workAddress != null && AddrWork ==  false )
							{
							AccountModBO.Address addr = (AccountModBO.Address)accModBO.getInstance("Address");
							addr.setAddressCategory("Work");
							if(workAddress.getUserStrField2()!=null){
							addr.setHouse_no(workAddress.getUserStrField2().trim());
							//custInfo.AddrDet.commAddrDet.address1 = workAddress.getUserStrField2().trim();
							}
							if(workAddress.getUserStrField3()!=null){
							addr.setBuilding_level(workAddress.getUserStrField3().trim());
							//custInfo.AddrDet.commAddrDet.address2 = workAddress.getUserStrField3().trim();
								}
							if(workAddress.getUserStrField4()!=null){
							addr.setStreet_name(workAddress.getUserStrField4().trim());
							}

							if(workAddress.getUserStrField34()!=null){
								addr.setStreet_no(workAddress.getUserStrField34().trim());
							}

							if(workAddress.getUserStrField35()!=null){
								addr.setPremise_name(workAddress.getUserStrField35().trim());
							}

							if(workAddress.getUserStrField36()!=null){
								addr.setLocality_name(workAddress.getUserStrField36().trim());
							}

							if(workAddress.getUserStrField37()!=null){
								addr.setSuburb(workAddress.getUserStrField37().trim());
							}

							if(workAddress.getUserStrField38()!=null){
								addr.setTown(workAddress.getUserStrField38().trim());
							}
							if(workAddress.getUserStrField5()!=null){
							addr.setCity(workAddress.getUserStrField5().trim() );
							}
							if(workAddress.getUserStrField6()!=null){
							addr.setState(workAddress.getUserStrField6().trim());
							}
							if(workAddress.getUserStrField7()!=null){
							addr.setCountry(workAddress.getUserStrField7().trim());
							}
							if(workAddress.getUserStrField8()!=null){
							addr.setZip(workAddress.getUserStrField8().trim());
							//custInfo.AddrDet.EmpAddrDet.postalCode = workAddress.getUserStrField8().trim();
							}
							if(workAddress.getUserDateField1()!=null){
							addr.setStart_Date(workAddress.getUserDateField1());
							}
							if(workAddress.getUserDateField2()!=null){
							addr.setEnd_Date(workAddress.getUserDateField2());
							}
							if(workAddress.getUserStrField10()!=null){
							addr.setPhoneNo1(workAddress.getUserStrField10());
							//custInfo.AddrDet.EmpAddrDet.phone1=workAddress.getUserStrField10();
							}
							if(workAddress.getUserStrField11()!=null){
							addr.setFaxNo(mailAddress.getUserStrField11());
							//custInfo.AddrDet.EmpAddrDet.faxNo=workAddress.getUserStrField11();
							}
							if(workAddress.getUserStrField12()!=null){
							//custInfo.GenDet.swiftCode=workAddress.getUserStrField12();
							//custInfo.GenDet.isSwiftCodeofBank='N';
							}
							if (workAddress.getUserStrField13()!=null)
							{
							addr.setEmail(workAddress.getUserStrField13());
								//custInfo.AddrDet.EmpAddrDet.emailId=workAddress.getUserStrField13();
							}
							if(workAddress.getUserStrField14()!=null){
							addr.setCellNo(mailAddress.getUserStrField14());
							//custInfo.PerDet.mobileNo=workAddress.getUserStrField14();
							}
							colAddress.add(addr);
							}
						   Integer  salesId=incidentBO.getSalesID();
						 com.infy.cis.srmbo.Core.SaveAccountModForMove(bc,accModBO,AgentGroupMgr.getLoggedonUser(bc),
						 	null,null,"N","Y");
						   String notes = "Step completed successfully";
						   //CommonQueries.UpdateIncident( bc , incidentBO.getIncidentID(),"Closed" , null , notes , postTranId , false , null , null );
						   WebAdaptor.log(com.infy.cis.log.LogType.MINOR,notes);
						   return outputHash;
					}//end of else for approval check
			   }
		      }
			catch (CINonFatalException e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CINonFatalException - " + e.getMessage()),
									 null);
			}
		    catch (CIFatalException e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CIFatalException - " + e.getMessage()),
									 null);
		    }
		    catch (CIOnsNonFatalException confe) {
			String strErrMsg = "";
            WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"CIOnsNonFatalException");
			/*for (int i = 0; i < confe.getErrorLL().size(); i++) {
            WebAdaptor.log(com.infy.cis.log.LogType.MINOR," " + (i + 1) + ", " + confe.getErrorLL().get(i));
            CIOnsErr errObj = (CIOnsErr) confe.getErrorLL().get(i);
            if (errObj.ciErrFieldDesc == null || errObj.ciErrFieldDesc.length() < 1) {
            strErrMsg = strErrMsg +"(" + (i + 1) + ") " + errObj.errDesc;
            }
			else {strErrMsg = strErrMsg +"(" + (i + 1) + ") " + errObj.ciErrFieldDesc + "_" + errObj.errDesc;}
            WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"VALIDATION_ERROR"+strErrMsg);
            }	*/
		    throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CIOnsNonFatalException - " + strErrMsg),
									 null);
			}
		    catch(Exception e){
		    	e.printStackTrace();
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg(e.getMessage()),
							 null);
			}

	}
// end of proceedForAddressChange Method

	/*
	 * The method fetches data from Channel Integrator for AccountTitleRequest
	 *
 	 * @param incidentBO - Incident BO
	 * @param reqBO - Request BO
	 * @param bc - SRMBusiness Context
	 * @param requestMode - Mode of Request Online or SemiOnline ( from Process steps )
	 * @return Hashtable - This Hashtable contains output values fetched from Channel Integrator
	 * @exception SRMPreWriteException
	 */
public CIAccountTitleOutput proceedForAccountTitleRequest ( IncidentBO incidentBO, RequestBO reqBO,
									   SRMBusinessContext bc,String requestMode )throws SRMPreWriteException,SRMBCException{
	try {

        CIAcctTitleInput ciAcctTitleInp = new CIAcctTitleInput();
        CIAccountTitleOutput cIAccountTitleOutput = new CIAccountTitleOutput();
        CIRelatedPartyDetails[] relatedParty = new CIRelatedPartyDetails[1];
        CIRelatedPartyDetails relatedParty1 = new CIRelatedPartyDetails();
        FIIncidentInfo fiIncidentInfo = new FIIncidentInfo();
		CIUserInfo CIU = new CIUserInfo();
		String postTranId = null;
		Integer prodCatID = null;
		String schemeCode = null;
		String schemeType = null;
		String tempdate=null;
		String perSal=null;
		String recordType = null; //10.1 Recon Changes By Mukundhan
		int no=0;
		int num=1;
		SRMCollection serReqGenInfo = reqBO.getRequestGenInfo();
		no=serReqGenInfo.size();
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");

		String Accid=getAccountId(incidentBO.getCrmCustID(),bc);
		String backendid=getCustomerId(incidentBO.getAccountNumber(),Accid,bc);

		        if (backendid==null){
                throw new FCRMGenericException("MSGEXC0087",new Exception("Customer id  is null for the incident."));
		        }
			    if(incidentBO.getAccountNumber()==null || incidentBO.getAccountNumber().trim().equals("")){
				throw new FCRMGenericException("MSGEXC0052",new Exception("Account number is null for the incident."));
			    } else {


					 ciAcctTitleInp.setAcctNum(incidentBO.getAccountNumber());
				List salelist = CommonQueryFunctions.getSalesData(incidentBO.getAccountNumber(),bc);
				schemeCode  = (String)salelist.get(1);
				prodCatID  = (Integer)salelist.get(4);
				if (schemeCode==null || prodCatID==null ){
				throw new FCRMGenericException("MSGEXC0089",new Exception("Invalid Account data for Product Id of SchemeCode"));}
				switch(prodCatID.intValue())
				{
				  case  1 : 	schemeType = "SBA";
								break;
				  case  2 : 	schemeType = "TDA";
								break;
				  case  3 :  	schemeType = "CAA";
								break;
				  case  4 :		schemeType = "CCA";
								break;
				  case  5 :		schemeType = "ODA";
								break;
				  case  6 :		schemeType = "LAA";
								break;

				  //Left for customised schemetype
				  //case  7 :		schemeType = ;
				  //				break;
				  //case  8 :		schemeType = ;
				  //				break;
				  //case  9 :		schemeType = ;
				  //				break;
				  //case  10:		schemeType = ;
				  //				break;
					}
			}
 			/*if( schemeCode == null || schemeCode.trim().equals("")){
			throw new FCRMGenericException("MSGEXC0082",new Exception("Scheme code does not exist in Backend."));
			}
			else {
			inputHash.put("scheme_code",schemeCode);
			}
			if( schemeType == null || schemeType.trim().equals("")){
			throw new FCRMGenericException("MSGEXC0083",new Exception("Scheme type does not exist in Backend."));
			} else {
			inputHash.put("scheme_type",schemeType);
			}*/
			if(reqBO.getUserStrField1() != null){
			 /* SIT10202 Change - BEGIN */
			//String modeofOperCode =  CommonQueryFunctions.getDataFromRefCodeMapper( "MODE_OF_OPERATION", reqBO.getUserStrField1().trim(), null);

			//hard
				//String modeofOperCode = "BI";
				String modeofOperCode = reqBO.getUserStrField1();

				 /* SIT10202 Change - END */
			if( modeofOperCode != null ){

					ciAcctTitleInp.setModeOfOper(modeofOperCode);
				}
				else{throw new FCRMGenericException("MSGEXC0092",new Exception("Mode of Operation in not available in Backend"));
				}
			}
			if(reqBO.getUserStrField2() != null){
			//10.1 Recon Changes by Mukundhan
            //perSal = CommonQueryFunctions.getDataFromRefCodeMapper("PERSONSALUTATION", reqBO.getUserStrField2().trim(), null);
			//hard
			        //SIT FIX Tracker 126434
					perSal = reqBO.getUserStrField2();
            //End of Recon Changes
			if( perSal != null ){
					relatedParty1.setCustTitle(perSal);
				}
			else{throw new FCRMGenericException("MSGEXC0093",new Exception("Salutation is not available in Backend"));}
            }
				relatedParty1.setAddModFlag("M");
			/*Round2 ITPT Defect No:16 added by Sonia Kar Begin of Changes*/
				 Accid=getAccountId(incidentBO.getCrmCustID(),bc);
			String custid =getCustomerId(incidentBO.getAccountNumber(),Accid,bc);
			/*Round2 ITPT Defect No:16 added by Sonia Kar End of Changes*/


			no++;
			num++;

            relatedParty1.setTableSerialNum(String.valueOf(no));

			for(int iCount=0;iCount < serReqGenInfo.size();iCount++){
			RequestBO.RequestGenInfo reqGenInfo =(RequestBO.RequestGenInfo)serReqGenInfo.get(iCount);
			if(reqGenInfo.getUserStrField20() == null || reqGenInfo.getUserStrField20().trim().equals("")){
			throw new FCRMGenericException("MSGEXC0094",new Exception("Add / Modify flag does not exist in Backend."));
			} else {
			if(reqGenInfo.getUserStrField20().trim().equals("ADD")){

					relatedParty1.setAddModFlag("A");
				}
			else{

					relatedParty1.setAddModFlag("M");
				}
			}
			if(reqBO.getUserStrField1() != null){
			//10.1 Recon Chnages by Mukundhan
            //String recordType = CommonQueryFunctions.getDataFromRefCodeMapper( "ROLEINACCOUNT", reqGenInfo.getUserStrField1().trim(), null);

			//hard
			//SIT FIX Tracker 126434
			if(reqBO.getUserStrField1().equalsIgnoreCase("Joint"))
			{
					recordType ="J";
			}
			else
			{
					recordType ="M";
		    }
            //End of Recon Changes

			if( recordType == null || recordType.trim().equals("")){
			throw new FCRMGenericException("MSGEXC0095",new Exception("Record Type does not exist in Backend."));}
			else {

				relatedParty1.setRelnType(recordType);//10.1 Recon Change
            	}
            }
			if(reqGenInfo.getUserStrField2() != null){
			/*String relationCode = CommonQueryFunctions.getDataFromRefCodeMapper( "RELATION", reqGenInfo.getUserStrField2().trim(), null);
			//System.out.println("relationCode"+relationCode);
			if( relationCode == null || relationCode.trim().equals("")){
			throw new FCRMGenericException("MSGEXC0096",new Exception("Relation code does not exist in Backend."));}
			else {


				  relatedParty1.setRelnCode(relationCode);
				}*/
             relatedParty1.setRelnCode(reqGenInfo.getUserStrField2());
			}
			if(reqGenInfo.getUserStrField3() != null){
			/*String desigCode = CommonQueryFunctions.getDataFromRefCodeMapper( "DESG_CODE", reqGenInfo.getUserStrField3().trim(), null);
			if(desigCode == null){
			throw new FCRMGenericException("MSGEXC0097",new Exception("Design code does not exist in Backend."));}
			else{

					relatedParty1.setDesigCode(desigCode);
				}*/
                  relatedParty1.setDesigCode(reqGenInfo.getUserStrField3());
			}
			if(reqGenInfo.getUserStrField4()!=null){
			String personType=reqGenInfo.getUserStrField4().trim();
			if(personType.equals("CUSTOMER") && reqGenInfo.getUserStrField6() != null){
			//CreateCustomerInCore CCIC=new CreateCustomerInCore();
					Accid=getAccountId(incidentBO.getCrmCustID(),bc);
					custid =getCustomerId(incidentBO.getAccountNumber(),Accid,bc);
			if((custid != null) && (custid != "")){
						 /* SIT10202 Change - BEGIN */
						  relatedParty1.setCifId(reqGenInfo.getUserStrField6().trim());
						   /* SIT10202 Change - END */
					}
				}
			}
			if(reqGenInfo.getUserStrField7() != null){

               relatedParty1.setCustName(reqGenInfo.getUserStrField7());
			}
            //10.1 Recon Changes By Mukundhan
			//SIT FIX Tracker 126434
			if(reqGenInfo.getUserStrField21() != null){
			//perSal = CommonQueryFunctions.getDataFromRefCodeMapper("PERSONSALUTATION", reqGenInfo.getUserStrField21().trim(), null);
			//hard
				perSal = reqGenInfo.getUserStrField21();
			if( perSal != null ){

					relatedParty1.setCustTitle(perSal);
             //End of Recon Changes
				}
			else{throw new FCRMGenericException("MSGEXC0093",new Exception("Salutation is not available in Backend"),num+"");}

			}
			if(reqGenInfo.getUserStrField8() != null){

                 relatedParty1.setCustAddrLine1(reqGenInfo.getUserStrField8());
			}
			if(reqGenInfo.getUserStrField9() != null){

                relatedParty1.setCustAddrLine2(reqGenInfo.getUserStrField9().trim());
			}
			if(reqGenInfo.getUserStrField11() != null){
			 /* SIT10202 Change - BEGIN */
			//String cityCode = CommonQueryFunctions.getDataFromRefCodeMapper( "CITY", reqGenInfo.getUserStrField11().trim(), null);

			//hard
				//cityCode = "BANGA";
				String cityCode = reqGenInfo.getUserStrField11().trim();
				 /* SIT10202 Change - END */
			if( cityCode == null || cityCode.trim().equals("")){
			    	throw new FCRMGenericException("MSGEXC0098",new Exception("City does not exist in Backend."));
             			   }
			    else {
                    relatedParty1.setCustCityCode(cityCode);
              			  }
			}
			if(reqGenInfo.getUserStrField12() != null){
			 /* SIT10202 Change - BEGIN */
			//String stateCode = CommonQueryFunctions.getDataFromRefCodeMapper
			//( "State", reqGenInfo.getUserStrField12().trim(), null);

			//hard
				//stateCode = "01";
				String stateCode = reqGenInfo.getUserStrField12().trim();
				 /* SIT10202 Change - END */
			if( stateCode == null || stateCode.trim().equals("")){
			throw new FCRMGenericException("MSGEXC0099",new Exception("State does not exist in Backend."));}
			else {
					relatedParty1.setCustStateCode(stateCode);
		    }}
			if(reqGenInfo.getUserStrField13() != null){

			 /* SIT10202 Change - BEGIN */
			//String cntryCode = CommonQueryFunctions.getDataFromRefCodeMapper( "Country", reqGenInfo.getUserStrField13().trim(), null);

			//hard
				//cntryCode ="02";
				String cntryCode =reqGenInfo.getUserStrField13().trim();
				 /* SIT10202 Change - END */
			if( cntryCode == null || cntryCode.trim().equals("")){
			throw new FCRMGenericException("MSGEXC0100",new Exception("Country does not exist in Backend."));}
			else {

				  relatedParty1.setCustCntryCode(cntryCode);
				}
			}
			if(reqGenInfo.getUserStrField14() != null){
                relatedParty1.setCustPostalCode(reqGenInfo.getUserStrField14());
			}
			if(reqGenInfo.getUserStrField5() != null){
				relatedParty1.setPrintAcctStmt("N");
			}
			if(reqGenInfo.getUserStrField17() != null){

				relatedParty1.setPrintAdvStndOrd("N");
			}
			if(reqGenInfo.getUserStrField18() != null){
			 /* SIT10202 Change - BEGIN */
			//String dnf = CommonQueryFunctions.getDataFromRefCodeMapper( "Flag", reqGenInfo.getUserStrField18().trim(), null);
			//HARD
				String dnf = reqGenInfo.getUserStrField18().trim();
				 /* SIT10202 Change - END */
				dnf = "N";
			if( dnf != null ){
					relatedParty1.setPrintDepNotice(dnf);
			}}
			if(reqGenInfo.getUserStrField19() != null){
			 /* SIT10202 Change - BEGIN */
			//String lnf = CommonQueryFunctions.getDataFromRefCodeMapper( "Flag", reqGenInfo.getUserStrField19().trim(), null);
			//HARD
				String lnf = reqGenInfo.getUserStrField19().trim();
				 /* SIT10202 Change - END */
				lnf = "N";
			if( lnf != null ){
					relatedParty1.setPrintLoanNotice(lnf);
	    	}}
			if(reqGenInfo.getUserDateField1() != null){

				java.util.Calendar strtDate = new java.util.GregorianCalendar();
				strtDate.setTime((Date)reqGenInfo.getUserDateField1());
              //SimpleDateFormat strtDate = new SimpleDateFormat(tempdate);
              relatedParty1.setStartDate(strtDate.getInstance());
			}
			if(reqGenInfo.getUserDateField2() != null){

                //SimpleDateFormat endDate = new SimpleDateFormat(tempdate);
				java.util.Calendar endDate = new java.util.GregorianCalendar();
				endDate.setTime((Date)reqGenInfo.getUserDateField1());
                relatedParty1.setEndDate(endDate.getInstance());
			}
    		if(reqGenInfo.getUserAmountField1() != null){
	    	String curr=reqGenInfo.getUserAmountField1()+"|"+reqGenInfo.getUserStrField15();

                Amount titleReqAmt = new Amount();
                Double dAmt = new Double(reqGenInfo.getUserAmountField1().toString());
                titleReqAmt.setAmountValue(dAmt.doubleValue());
                titleReqAmt.setCurrencyCode(reqGenInfo.getUserStrField15());
                relatedParty1.setAmount(titleReqAmt);
			}
			if(reqGenInfo.getUserTextField1() != null){

              relatedParty1.setRemarks(reqGenInfo.getUserTextField1());
			}
			if(reqGenInfo.getUserStrField16() != null){
			 /* SIT10202 Change - BEGIN */
			//String xfcsf = CommonQueryFunctions.getDataFromRefCodeMapper( "Flag", reqGenInfo.getUserStrField16().trim(), null);
				String xfcsf = reqGenInfo.getUserStrField16().trim();
				 /* SIT10202 Change - END */
			xfcsf = "N";
			if( xfcsf != null ){

              relatedParty1.setXcldCombStmt(xfcsf);
			}
			}
			num++;
			}
			WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"Before Calling the bean");
			/*Tracker 103058 : FI Call Change :Start
			CIRemoteAccessInterface inter= null;
			inter = CIHostMarker.getCIHostForONS();
			Tracker 103058 : FI Call Change :End*/

            CIU.setChannelType("CRM");
          //  CIU.setDccReqVersion("VERSION1");
            String bankID = (String)com.infy.cis.common.SRMTLVar.bank_id.get();
            CIU.setBankId(bankID);
		   if( incidentBO.getCaseID() != null){
				fiIncidentInfo.	setDccReqRefNum(incidentBO.getCaseID());
			}else{
				throw new FCRMGenericException("MSGEXCP0005",new Exception("CaseID is null"));
			}
			fiIncidentInfo.setDccReqRefNum(String.valueOf(System.currentTimeMillis()));
			fiIncidentInfo.setDccReqType("DEFAULTEJB");
			/*SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss.S");
			Date currentTime_1 = new Date();
			String dateString = formatter.format(currentTime_1);
 			fiIncidentInfo.	setDccReqOrigTime(dateString);*/
 			//fiIncidentInfo.setDccReqOrigTime("2007-01-01 00:00:00.000");	//10.1 Recon Changes
 			fiIncidentInfo.setDccReqOrigTime(getDateFormatforFIServReq());	//10.1 Recon Changes
           OnsSrvRequestALImplementation onsSrvReqALImp = new OnsSrvRequestALImplementation();
			relatedParty[0] = relatedParty1;
			ciAcctTitleInp.setRelatedParty(relatedParty);
			ciAcctTitleInp.setFiIncidentInfo(fiIncidentInfo);
			cIAccountTitleOutput=(CIAccountTitleOutput)onsSrvReqALImp.doAcctTitleModeOperation(CIU,ciAcctTitleInp);
			String notes = "Step completed successfully";

			/*if(outputHash.get("postTranId")!=null){
					postTranId = outputHash.get("postTranId").toString();
					notes = notes+" : BackEndReference Number = "+postTranId;
					}*/
			CommonQueries.UpdateIncident( bc , incidentBO.getIncidentID() , "Closed" , null , notes , postTranId , false , null , null );

			WebAdaptor.log(com.infy.cis.log.LogType.MINOR,notes);

			return cIAccountTitleOutput;
			}
			catch (CINonFatalException e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CINonFatalException - " + e.getMessage()),
									 null);
			}
		    catch (CIFatalException e){
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg("CIFatalException - " + e.getMessage()),
									 null);
		    }
		    catch (CIOnsNonFatalException confe) {
				//Tracker 187456 Starts
				String strErrMsg = "";
            	WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"CIOnsNonFatalException");
				for (int i = 0; i < confe.getErrorLL().length; i++)
				{
					WebAdaptor.log(com.infy.cis.log.LogType.MINOR," " + (i + 1) + ", " + confe.getErrorLL()[i]);
					CIOnsErr errObj = (CIOnsErr) confe.getErrorLL()[i];
				if (errObj.ciErrFieldDesc == null || errObj.ciErrFieldDesc.length() < 1) {
					strErrMsg = strErrMsg +"(" + (i + 1) + ") " + errObj.errDesc;
				}
				else {strErrMsg = strErrMsg +"(" + (i + 1) + ") " + errObj.ciErrFieldDesc + "_" + errObj.errDesc;}
					WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"VALIDATION_ERROR"+strErrMsg);
            	}
		    	throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg(strErrMsg),
									 null);
			//Tracker 187456 Ends
			}
		    catch(Exception e){
		    	e.printStackTrace();
			throw new SRMBCException(SRMBCException.ONLINE_SERVICEREQUEST_EXCEPTION,
									 SRMBCException.MakeReplaceableArg(e.getMessage()),
							 null);
			}
	} // end of proceedForAccountTitleRequest
public static String getAccountId(String orgkey,SRMBusinessContext bc) throws Exception
			{
    		    ArrayList docAttrList = new ArrayList();
				docAttrList.add(QueryAssist.getTransformFn("AccountBO", AccountBO.ACCOUNTID));
				SRMQueryBuilder qbAccount =	QueryAssist.singleObjectQuery("AccountBO",AccountBO.ACCOUNTID);
			    QueryAssist.addSimpleCondition(qbAccount,"AccountBO",AccountBO.ACCOUNTKEY,IQuery.ComparisonOperation_EQ,""+orgkey);
			   	qbAccount.addAttribScope((TransFormFn) docAttrList.get(0));
				SRMQueryResult qrChecklist = qbAccount.runQuery(bc, false, -1);
				SRMRecordSet rsChecklist = qrChecklist.getRecordSet();

				Integer cusId=new Integer(0);
					if(rsChecklist.hasNext() )
					{
						cusId = (Integer)(rsChecklist.getNext().get(0));
					}
				String custId = cusId.toString();
				return custId;
			} // end of getAccountId

/*Round2 ITPT Defect No:16 added by Sonia Kar Begin of Changes*/
public static String getCustomerId(String sAccNo,String sAccId,SRMBusinessContext bc) throws Exception
{
	ArrayList salAttrList = new ArrayList();
	salAttrList.add(QueryAssist.getTransformFn("SaleBO",SaleBO.SALESID));
	SRMQueryBuilder qbSales = QueryAssist.singleObjectQuery("SaleBO",SaleBO.SALESID);
	QueryAssist.addSimpleCondition(qbSales,"SaleBO",SaleBO.ACCOUNTNUMBER,IQuery.ComparisonOperation_EQ,"" +sAccNo);
	qbSales.addAttribScope((TransFormFn) salAttrList.get(0));
	SRMQueryResult qrSalesList = qbSales.runQuery(bc,false,-1);
	SRMRecordSet rsSalesList = qrSalesList.getRecordSet();
	Integer iSalId =new Integer(0);
	if(rsSalesList.hasNext() )
	{
		iSalId = (Integer)(rsSalesList.getNext().get(0));
	}
	String sSalesId = iSalId.toString();
	ArrayList custAttrList = new ArrayList();
	//10.1 Recon Changes By Mukundhan
    //custAttrList.add(QueryAssist.getTransformFn("SaleBO",SaleBO.SALECUSTOMER_PRODUCTKEYVALUE));
	//SIT FIX Tracker 126434
	custAttrList.add(QueryAssist.getTransformFn("SaleBO",SaleBO.SALECUSTOMER_CIF_ID));
    //Endof Changes
	SRMQueryBuilder qbCust = QueryAssist.singleObjectQuery("SaleBO",SaleBO.SALESID);
	QueryAssist.addSimpleCondition(qbCust,"SaleBO",SaleBO.SALESID,IQuery.ComparisonOperation_EQ,""+sSalesId);
	QueryAssist.addSimpleCondition(qbCust,"SaleBO",SaleBO.SALECUSTOMER_ORGID,IQuery.ComparisonOperation_EQ,""+sAccId);
	qbCust.addAttribScope((TransFormFn) custAttrList.get(0));
	SRMQueryResult qrCustList = qbCust.runQuery(bc,-1);
	SRMRecordSet rsCustList = qrCustList.getRecordSet();
	String sCustId = null;
	if(rsCustList.hasNext() )
	{
		sCustId = (String)(rsCustList.getNext().get(0));
	}
	return sCustId;
}
/*Round2 ITPT Defect No:16 added by Sonia Kar End of Changes*/

		public String getCustid(SRMBusinessContext bc,int AccID)
		throws CISInvalidArgumentException, SRMSecurityException, SRMBOException,
					CISConfigException,ClassNotFoundException {
		String cusid = null;
		if(AccID > 0)
		{
			ArrayList attr1 = new ArrayList();
			SRMQueryBuilder qb = new SRMQueryBuilder();
			QueryAssist.addJoin(qb,"SaleBO", SaleBO.SALECUSTOMER_ORGID, "MappingBO", MappingBO.ACCOUNTID,IQuery.JoinType_Left_Outer);
			QueryAssist.addSimpleCondition(qb,"MappingBO",MappingBO.MAPPING_DETAILS_PRODUCTCODE,IQuery.ComparisonOperation_EQ,"FINACLECORE");
			QueryAssist.addSimpleCondition(qb,"SaleBO",SaleBO.SALECUSTOMER_ORGID,IQuery.ComparisonOperation_EQ,""+AccID);
			attr1.add(MappingBO.MAPPING_DETAILS_PRODUCTKEYVALUE);
			QueryAssist.selectAttr(qb,"MappingBO",attr1);
			SRMQueryResult qr = qb.runQuery(bc,false,-1);
			SRMRecordSet rs = qr.getRecordSet();
			List groupsId= new ArrayList();
			ArrayList rowObj = new ArrayList();

			if(rs.hasNext())
			{
				rowObj=(ArrayList)rs.getNext();
				if (rowObj.get(0)!= null){ cusid=rowObj.get(0).toString(); }
			}
			rs.resetIndex();
		}
		return cusid;
	}

	public PsychographicBO getPsychoBOInfo(SRMBusinessContext bc,
													int value)
		throws CISInvalidArgumentException, SRMSecurityException, SRMBOException,
			CISConfigException,ClassNotFoundException {

		PsychographicBO psyBO  = null;
		SRMQueryBuilder qb = QueryAssist.singleObjectQuery("PsychographicBO",
														PsychographicBO.PSYCHOGRAPHICID);

		QueryAssist.addSimpleCondition(qb, "PsychographicBO",
									PsychographicBO.ACCOUNTID,
								   IQuery.ComparisonOperation_EQ,
								   ""+value);

		SRMQueryResult qr = qb.runQuery(bc , -1 );
		SRMRecordSet rs	  = qr.getRecordSet();
		if(rs.hasNext()) {
			psyBO = (PsychographicBO)rs.getNext().get(0);
		}
		return psyBO;
    }

	public DemographicBO getDemoBOInfo(SRMBusinessContext bc,
													int value)
		throws CISInvalidArgumentException, SRMSecurityException, SRMBOException,
			CISConfigException,ClassNotFoundException {

		DemographicBO demoBO  = null;
		SRMQueryBuilder qb = QueryAssist.singleObjectQuery("DemographicBO",
														DemographicBO.DEMOGRAPHICID);

		QueryAssist.addSimpleCondition(qb, "DemographicBO",
									DemographicBO.ACCOUNTID,
								   IQuery.ComparisonOperation_EQ,
								   ""+value);

		SRMQueryResult qr = qb.runQuery(bc ,true, -1 );
		SRMRecordSet rs	  = qr.getRecordSet();
		if(rs.hasNext()) {
			demoBO = (DemographicBO)rs.getNext().get(0);
		}
		return demoBO;
    }
  //10.1 Recon Changes
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
     //End of Recon Changes

}//end of class






