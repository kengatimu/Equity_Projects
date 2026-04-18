/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: AccountBOHook.java $
 *
 * Author: Jagadish
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/AccountBOHook.java $
 *
 * *********************************** */

/* CRM61SR:SRCIUHBO:TRACKER# 44231 **BEGIN  CHANGES** */
package com.infy.cis.custom;

                 /**** Alert server recon to 10.2.14 Start Tracker ID 378548 ****/

import java.io.PrintWriter;//Alert server recon to 10.2.14
import java.io.StringWriter;//Alert server recon to 10.2.14
import java.util.concurrent.ConcurrentHashMap;//Alert server recon to 10.2.14
//fix for PAF build issue

	/**** Alert server recon to 10.2.14 End    Tracker ID 378548 ****/
import com.infy.cis.alert.CRMAlert;//Alert server recon to 10.2.14
import com.infy.cis.common.Address;
//fix for PAF build issue
import com.infy.cis.common.EditorUtil;
import com.infy.cis.bus.client.JMSClient;
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.AccountBO;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.exception.*;
import com.infy.cis.srmbo.SRMBase;
import com.infy.cis.srmbo.AttrAccValidator;
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.cis.srmbo.*;
import com.infy.cis.common.*;
import com.infy.cis.ui.common.CIFSyncData;
import com.infy.cis.ui.common.*;
import com.infy.cis.log.*;
import com.infy.cis.adaptor.web.WebAdaptor;
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


import com.infy.cis.srmbo.Core;
import com.infy.finacle.crypt.MsgDigest;
import java.util.Date;
import com.infosys.insulate.util.HashMap;
import java.util.Properties;

public class AccountBOHook implements IHooks {

   public AccountBOHook(){}
/** CRM9.5 to CRM10.1  CIF - EBanking changes recon Start*/ //TrackerID: 97236
   public String  eBankFlag;
   public String apprFlag;
/** CRM9.5 to CRM10.1  CIF - EBanking changes recon End*/

// sample hook - postWrite

 /* public void preWrite (SRMBusinessContext bc, Object bo)
    //throws SRMPreWriteException {
	//    customized implementation place holder
   //AccountBO abo = (AccountBO)bo;
  	} */

  /* CRM61LR:TRACKER:44575:BEGINOFCHANGES */

	public void preWrite (SRMBusinessContext bc, Object bo)
	 throws SRMPreWriteException,SRMSecurityException {
 		/** CRM9.5 to CRM10.1  CIF - EBanking changes recon Start*/ //TrackerID: 97236
  		try
		{
			Properties keyProp = EditorUtil.getCIFGeneralInfo();
			apprFlag = keyProp.getProperty(EditorUtil.APPROVAL_MECHANISM).trim();
		}
		catch (CISContextException ex)
		{
			throw new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, ex);
		}
		catch(Exception e)
		{
 			throw new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, e);
		}
		/** CRM9.5 to CRM10.1  CIF - EBanking changes recon End*/
		AccountBO boAccount = (AccountBO)bo;
		//Tracker:90196: Changes for attibute masking
		try {
			AttrAccValidator.validatecreate((SRMBase) bo);
		} catch(SRMSecurityException e) {
			throw new SRMSecurityException(SRMSecurityException.ERROR_ATTR_MASK, null) ;
		}

        /** CRM9.5 to CRM10.1  CIF - EBanking changes recon Start*/ //TrackerID: 97236
         try
        {
        	CheckExternalSystemFields checkEBankingFields=new CheckExternalSystemFields();
        	eBankFlag=checkEBankingFields.checkChangedFields(bc,boAccount);
		 	if(eBankFlag.equals("C")||eBankFlag.equals("CE")){

				boAccount.setAlreadyCreatedInEBanking("Y");
			}
 		}
 		catch(SRMTypeValidatorException e)
		{
			throw new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, e);
		}
		catch(Exception e)
		{
			throw new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, e);
		}
		/** CRM9.5 to CRM10.1  CIF - EBanking changes recon End*/

        //Tracker:90196: End of Changes
		String GroupId = boAccount.getGroupID();
		Integer AccountId = boAccount.getAccountID();
		String AccountKey = boAccount.getAccountKey();
		/*Changes For setting Duedate*/
		String sRating =boAccount.getSegmentation_Class();


		try{
			if(GroupId == null)	{
			boAccount.setGroupID(AccountKey);
			}if((GroupId.trim()).equals(""))
			{
			boAccount.setGroupID(AccountKey);
		}else{
				boAccount.setGroupID(GroupId);
			}
		}catch(Exception e){

		}

		/*Changes For setting Duedate*/
		try{
			if(sRating != null)	{
				if( sRating.equals("Gold") ){
					boAccount.setSLALevel("SLA5");
				}
				else if( sRating.equals("Silver") ){
					boAccount.setSLALevel("SLA4");
				}
				else if( sRating.equals("High net worth") ){
					boAccount.setSLALevel("SLA3");
				}
				else if( sRating.equals("Class A") ){
					boAccount.setSLALevel("SLA2");
				}
				else{
					boAccount.setSLALevel("SLA1");
				}
			}
			else{
						boAccount.setSLALevel("SLA1");
			}
		}catch(Exception ex)
			{
				ex.printStackTrace();
			}



		Date dDueDate = null;
		try{
			dDueDate = boAccount.getDueDate();
			if(dDueDate == null){
				boAccount.setStartDate( SRMDate.getGMT());
				dDueDate = Cif.setDueDate(bc, boAccount,"Account");
			}
		}
		catch(Exception e){
			//WebAdaptor.log (LogType.EVENT, "Exception while Setting the dueDate for Customer" );
		}
		try{
		/*Changes for Setting Escalation Due Time*/
		Integer iProcessid = boAccount.getProcessID();
		Integer iStepKey = boAccount.getCurrentStep();
		Integer iEscMatID = null;
		Integer iProcEscMatID = null;
		ProcessBO processBO = null;
		Integer iOwnerID = null;
		Integer iLocnID		= null;
		Integer iGroupID 	= null;
		String tat[] = new String[2];
		String proctat[] = new String[2];
		iOwnerID 			= boAccount.getOwnedUserID();
		iLocnID				= boAccount.getOwnedLocationID();
		iGroupID			= boAccount.getOwnerGroup();
		int iTat=0;
		int iprocTat=0;
		boolean isFirstStep = false;
		Date iCurrStepDueDate	= boAccount.getCurrStepDueDate();
		int currentStepInt = 0;
		if(iStepKey !=null && !(iStepKey.equals(null)) && !(iStepKey.equals("")))
		currentStepInt = iStepKey.intValue();


		if (iProcessid != null && !(iProcessid.equals(null))) {
			processBO = Processes.findProcessBO(iProcessid, bc);
			iProcEscMatID=processBO.getEscalationMatrix();;
			SRMCollection procStepCollection = processBO.getProcessSteps();
			for (int i=0;i<procStepCollection.size();i++)
			{
				ProcessBO.ProcessSteps bo1 = (ProcessBO.ProcessSteps)procStepCollection.get(i);
				if(bo1.getStepKey().intValue() == iStepKey.intValue()) {
					isFirstStep = bo1.getIsFirstStep().booleanValue();
					iEscMatID = bo1.getEscalationMatrix();
				}
			}

			ArrayList aTatArray = new ArrayList();
			ArrayList aProcTatArray = new ArrayList();
			aTatArray = getEscTatDuration(bc, iEscMatID, boAccount.getAccountID(),"Account");
			aProcTatArray = getEscTatDuration(bc, iProcEscMatID, boAccount.getAccountID(),"Account");
			for( int i = 0; i < aTatArray.size(); i++){
				tat[i] = aTatArray.get( i ).toString();
			}
			for( int i = 0; i < aProcTatArray.size(); i++){
				proctat[i] = aProcTatArray.get( i ).toString();
			}

			if (tat[0] != null && !(tat[0].equals("null"))){
				iTat = Integer.parseInt(tat[0]);
				String sUnit = tat[1];
				ASGenerator asgen = new ASGenerator();
				String sAvailString = Utils.getAvailString(bc, iOwnerID, iLocnID, iGroupID);
				Date tempStepDueDate = asgen.findDueDate(sAvailString, iTat, sUnit, iCurrStepDueDate);
				String          strDate = tempStepDueDate.toGMTString();
                strDate = strDate.replaceFirst("GMT","");
                Date  strdate= new Date(strDate);
				boAccount.setEsc_Due_time(strdate);

			}


			if (proctat[0] != null && !(proctat[0].equals("null")) && (isFirstStep)){
				iprocTat = Integer.parseInt(proctat[0]);
				String sprocUnit = proctat[1];
				ASGenerator asprocgen = new ASGenerator();
				String sProcAvailString = Utils.getAvailString(bc, iOwnerID, iLocnID, iGroupID);
				Date tempDueDate = asprocgen.findDueDate(sProcAvailString, iprocTat, sprocUnit, dDueDate);
				String          strDate = tempDueDate.toGMTString();
                strDate = strDate.replaceFirst("GMT","");
                Date  strdate= new Date(strDate);
				boAccount.setProcEscDuetime(strdate);
			}

		}
	}catch(Exception e){
		e.printStackTrace();
		}

		/*Changes for Setting Escalation Due Time*/

		HashMap custcfg = SizeUtil.getCustConfig ("CUSTOMER");
/* AdressLine changes: START */
		HashMap addDetails = null;
		HashMap addLines = null;

/* AdressLine changes: END */
			if (boAccount.getAddress() != null) {
				SRMCollection addrColl = boAccount.getAddress();
				AccountBO.Address address = null;
				/*Changes for Ticketid:-317790 Start:-Changes for adding swift add Start date*/
				Date startSwiftDate = SRMDate.getGMT();
				/*Changes for Ticketid:-317790 End*/
				for (int i = 0; i < addrColl.size(); ++i) {
/* AdressLine changes: START */
					addDetails = new HashMap();
/* AdressLine changes: END */
					address = (AccountBO.Address)addrColl.get(i);

/* AdressLine changes: START */
					try{
						if(address.getPreferredFormat()!=null && address.getPreferredFormat().equals("STRUCTURED_FORMAT")){
							addDetails.put("HouseNo",address.getHouse_no());
							addDetails.put("BldgLevel",address.getBuilding_level());
							addDetails.put("PremiseNo",address.getPremise_name());
							addDetails.put("StreetNo",address.getStreet_no());
							addDetails.put("StreetName",address.getStreet_name());
							addDetails.put("Locality",address.getLocality_name());
							addDetails.put("Suburb",address.getSuburb());
							addDetails.put("Town",address.getTown());

							addLines = BOHookUtil.setAddLines(addDetails);
							if(addLines.get("AddressLine1") != null){
								address.setAddress_Line1(addLines.get("AddressLine1").toString());
							}
							if(addLines.get("AddressLine2") != null){
								address.setAddress_Line2(addLines.get("AddressLine2").toString());
							}
							if(addLines.get("AddressLine3") != null){
								address.setAddress_Line3(addLines.get("AddressLine3").toString());
							}
						}
						/*Changes for Ticketid:-317790 Start
						Changes for adding swift address start and end date*/
						if(address.getAddressCategory().equalsIgnoreCase("Swift")){
							address.setStart_Date(startSwiftDate);
							address.setEnd_Date(new Date("12/31/2099"));
						}
						/*Changes for Ticketid:-317790 End*/
					}
					catch(SRMTypeValidatorException typeException){
						System.out.println("typeException="+typeException);
					}
/* AdressLine changes: END */
			}
		}
	// Changes for CheckSum : Start
   try
   {
	//Check for Checksum enable flag
	final Properties keyProp = EditorUtil.getCIFGeneralInfo();
	String chkEnFlag1 = keyProp.getProperty(EditorUtil.CHECKSUM_ENABLE);
	String chkEnFlag = "false";
	if (chkEnFlag1 != null) {
	chkEnFlag = chkEnFlag1.trim();
	}
	if (chkEnFlag.equalsIgnoreCase("True")) {

	final String aGroupId = boAccount.getGroupID();
	String isTampered = boAccount.getIsTampered();
	//If isTampered flag is set to Y, do not calculate new CheckSum
	if (isTampered == null) {
				isTampered = "";
		}

	if (!(isTampered.equals("Y"))) {
     final String[] aString = new String[6];
	 //aString[0] = boAccount.getAccountID().toString();
	 aString[1] = boAccount.getAccountKey();
	 aString[2] = boAccount.getCust_Last_Name();
	 final SRMCollection addNew = boAccount.getAddress();
	 for (int iFor = 0; iFor < addNew.size(); iFor = iFor + 1)
	 {
	  AccountBO.Address newAddr = (AccountBO.Address) addNew.get(iFor);
	  final String newAddrType = newAddr.getAddressCategory();
	  if (!newAddrType.equalsIgnoreCase("Mailing"))
	  { continue;
	  }
	  final Date strtDate = newAddr.getStart_Date();
	  final Date endDate = newAddr.getEnd_Date();
	  final Date today = new Date();
	  /*Tracker:104838-Fix for Bulk Customer creation*/
				 if(strtDate==null || endDate==null ){
						  continue;
				 }

	  /*Tracker:104838-Fix for Bulk Customer creation*/
	  // To calculate checksum when start date is today
	  boolean fToday = true;
	  if(today.getYear() == strtDate.getYear() &&
		 today.getMonth() == strtDate.getMonth() &&
	 	 today.getDate() == strtDate.getDate()){
				fToday = false;
			}
	 if(fToday)
	 if (!(today.after(strtDate) && today.before(endDate)))
	  { continue;
	  	}
	  aString[3] = newAddr.getAddress_Line1();
	  aString[4] = newAddr.getCity();
	  aString[5] = newAddr.getZip();
	 }
	 for (int iForNull = 1; iForNull <= 5; iForNull = iForNull + 1) {
	 if (aString[iForNull] == null) {
		 aString[iForNull] = "";
		}
	 }
	 // Input String to CheckSum API : ACCOUNTBO
	 final StringBuffer chkSumAcc = new StringBuffer(256);
	 for (int iAppend = 1; iAppend <= 5; iAppend = iAppend + 1)
	 {
		chkSumAcc.append(aString[iAppend]);
		chkSumAcc.append("|");
	 }
		final String chkSumCalc1 = MsgDigest.getDigestToken(
										chkSumAcc.toString());
		boAccount.setIsTampered("N");

		boAccount.setCheckSum(chkSumCalc1);

	}
	}
	}
	 catch (SRMBOException e)
	 { ExceptThrow.Throw(
		new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, e));
	 }
	 catch (SRMSecurityException e)
	 { ExceptThrow.Throw(
		 new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, e));
	 }
	 catch (SRMTypeValidatorException e)
	 { ExceptThrow.Throw(
		 new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, e));
	 }
	catch (CISContextException e)
	{ExceptThrow.Throw(
		 new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, e));
		}
	catch (Exception e)
	 { ExceptThrow.Throw(
		 new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, e));
	 }
		// Changes for CheckSum : End
	 }

 /* CRM61LR:TRACKER:44575:ENDOFCHANGES */


	/*Function  for CIF Escalation*/
	public static ArrayList getEscTatDuration(SRMBusinessContext bc, Integer iEscMatID, Integer iAccountID,String sEntity) throws Exception{

	   ArrayList newEscTat = new ArrayList();
	   String sExpr                = null;
	   EscalationMatrixBO eMatBO   = null;
	   String sReturnType          = "boolean";
	   EscalationMatrixBO eTempMatBO   = null;
	   String sResult				= null;


	   int iaccountID				    = iAccountID.intValue();

	   try {
			SRMQueryBuilder qb = QueryAssist.singleObjectQuery(
									"EscalationMatrixBO", EscalationMatrixBO.EMID);
			QueryAssist.addSimpleCondition(qb, "EscalationMatrixBO", EscalationMatrixBO.EMID,
								IQuery.ComparisonOperation_EQ, iEscMatID);

			SRMQueryResult qr 		= qb.runQuery(bc, true, -1);
			SRMRecordSet rs1 		= qr.getRecordSet();
			while(rs1.hasNext()) {
				eTempMatBO 			= (EscalationMatrixBO)rs1.getNext().get(0);
				sExpr           	= eTempMatBO.getExpression();
				try{
					EvaluateCIFExpression ee = new EvaluateCIFExpression();
					sResult 			= ee.evaluateCIFExpression(sExpr, sReturnType, iaccountID,sEntity, bc);
				} catch(Exception e) {}
				if(sResult.trim().equalsIgnoreCase("True")){
					eMatBO = eTempMatBO;
					break;
				}
			}
			if((sResult != null) && (sResult.trim().equalsIgnoreCase("True"))){
				EscalationMatrixBO.EscalationDetails escDetails = null;
				SRMCollection esclDetailsColl = eMatBO.getEscalationDetails();
				for(int i=0;i<esclDetailsColl.size(); i++){
					escDetails = (EscalationMatrixBO.EscalationDetails) esclDetailsColl.get(i);

					/* 10.1 RECON Changes by mukundhan_santhanam (79625)*/
					String sEscLevel = escDetails.getEscLevel();
					if(sEscLevel.equalsIgnoreCase("1")){
						break;
					}
					else{
						continue;
					}
				}
				// End of 10.1 RECON Changes
				newEscTat.add(escDetails.getTat());
				newEscTat.add(escDetails.getTatUnits());
			}
		} catch (Exception e){
			e.printStackTrace();
		}
		return newEscTat;
	}/*Function  for CIF Escalation*/


// sample hook - postWrite

  public void postWrite (SRMBusinessContext bc, Object bo)
    throws SRMPostWriteException {

                 /**** Alert server recon to 10.2.14 Start Tracker ID 378548 ****/
		NameValue[] alertNV = null;//Alert server recon to 10.2.14
		NameValue[] mergedNV = null;//Alert server recon to 10.2.14
		NameValue[] mergedNV1 = null;//Alert server recon to 10.2.14

	/**** Alert server recon to 10.2.14 End    Tracker ID 378548 ****/
	   // customized implementation place holder
/* CRM61SR:SREVNTBO:TRACKER# 44228 **BEGIN  CHANGES** */

//	try{

//		AccountBO boAccount = (AccountBO)bo;
//		Integer AccountId = boAccount.getAccountID();
//		String sEventFor = "Customer";
//		String sEventType = "DOB";
//		Date dEventDate = boAccount.getCust_DOB();
//		if(dEventDate != null){
//			String sEventDesc = "Date of Birth";
//			boolean bEditable = false;
//			Core.CreateNewEvent(bc,sEventFor,AccountId,sEventType,dEventDate,sEventDesc,bEditable);
//		}
//		}catch(Exception e){
//		throw new SRMPostWriteException(SRMPostWriteException.ERROR_EVENT_WRITEFAILURE,e);
//	}

 /* CRM61SR:SREVNTBO:TRACKER# 44228 **END OF CHANGES** */
   //AccountBO abo = (AccountBO)bo;



   /** CRM9.5 to CRM10.1  CIF - EBanking changes recon Start*/ //TrackerID: 97236
   	   AccountBO acctBO=(AccountBO)bo;

	   if(("C").equals(eBankFlag)){
		  if(apprFlag.equals("true")){
		   //pass Create/Modify flag as "C"
		   CheckExternalSystemFields.hmJMSEntry.put(acctBO.getAccountID(),"C");
			}else{
 	 			String id = ClientName.CRMQD; //10.1 Recon Changes by mukundhan_santhanam
				String root = System.getProperty("SIMPLERM_ROOT");
				JMSClient cl = new JMSClient(id, root);
				NameValue[] nv = {new NameValue("cifId", acctBO.getAccountKey()),new NameValue("cifType", "Retail"),new NameValue("modifyFlag",eBankFlag)}; //10.1 Recon
				com.infy.cis.common.message.Message msg =
   				new com.infy.cis.common.message.Message();
 			    msg.setNV(nv);
 			    try
 			    {
                	cl.send(id,             // sender id
			  				Address.CRMQD, // destination //10.1 Recon Changes by mukundhan_santhanam
              				msg);
				}
				catch(CISMessagingException e)
				{
					throw new SRMPostWriteException(SRMPostWriteException.ERROR_INTERNAL, e);
				}
				catch(Exception e)
				{
					throw new SRMPostWriteException(SRMPostWriteException.ERROR_INTERNAL, e);
				}
			}
		}else if(("E").equals(eBankFlag)){
		//pass Create/Modify flag as "E"
		    if(apprFlag.equals("true")){
		   		CheckExternalSystemFields.hmJMSEntry.put(acctBO.getAccountID(),"E");
			}else{
 	 			String id = ClientName.CRMQD; //10.1 Recon Changes by mukundhan_santhanam
				String root = System.getProperty("SIMPLERM_ROOT");
				JMSClient cl = new JMSClient(id, root);
				NameValue[] nv = {new NameValue("cifId", acctBO.getAccountKey()),new NameValue("cifType", "Retail"),new NameValue("modifyFlag",eBankFlag)}; //10.1 Recon
				com.infy.cis.common.message.Message msg =
   				new com.infy.cis.common.message.Message();
 			    msg.setNV(nv);
 			    try
 			    {
                	cl.send(id,             // sender id
			  				Address.CRMQD, // destination //10.1 Recon Changes by mukundhan_santhanam
              				msg);
				}
				catch(CISMessagingException e)
				{
					throw new SRMPostWriteException(SRMPostWriteException.ERROR_INTERNAL, e);
				}
				catch(Exception e)
				{
					throw new SRMPostWriteException(SRMPostWriteException.ERROR_INTERNAL, e);
				}
			}


		}else if(("CE").equals(eBankFlag)){
 	 			String id = ClientName.CRMQD; //10.1 Recon Changes by mukundhan_santhanam
				String root = System.getProperty("SIMPLERM_ROOT");
				JMSClient cl = new JMSClient(id, root);
				NameValue[] nv = {new NameValue("cifId", acctBO.getAccountKey()),new NameValue("cifType", "Retail"),new NameValue("modifyFlag","C")};
				com.infy.cis.common.message.Message msg =
   				new com.infy.cis.common.message.Message();
 			    msg.setNV(nv);
 			    try
 			    {
                	cl.send(id,             // sender id
			  				Address.CRMQD, // destination //10.1 Recon Changes by mukundhan_santhanam
              				msg);
				}
				catch(Exception e)
				{
					throw new SRMPostWriteException(SRMPostWriteException.ERROR_INTERNAL, e);
				}
		}
	/** CRM9.5 to CRM10.1  CIF - EBanking changes recon End*/
	// changes by vikas starts for IBK
			try {
				Properties genProp = EditorUtil.getCIFGeneralInfo();
				String syncUpFlag = genProp.getProperty(EditorUtil.CIFSYNCUP).trim();
				if(syncUpFlag.equalsIgnoreCase("TRUE")){
					CIFSyncData.syncRetailCust(bc, acctBO);
				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				//System.out.println("Inside AccountBOHook.CIFSyncData..catch block..exception.message.."+e.getMessage());
				e.printStackTrace();
			}
	// changes by vikas ends for IBK


                 /**** Alert server recon to 10.2.14 Start Tracker ID 378548 ****/
		//Alert server recon to 10.2.14 starts
		// *************************Alert Server Changes Start-Abhilash_Mohandas,Suthyev_S *********************
		//Tracker ID :224398 Changes for CRM-CXPS integration.   START
		try {
			boolean isAlertReq = Boolean.parseBoolean(EditorUtil.getAlertDetails());
			WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: AccountBOHook strIsAlertReq " +isAlertReq);
//System.out.println("isAlertReq:"+isAlertReq);
			if(isAlertReq) {
			   Throwable t = new Throwable();
			   t.fillInStackTrace();
			   StringWriter sw = new StringWriter();
			   PrintWriter pw = new PrintWriter(sw);
			   t.printStackTrace(pw);
			   String stackTrace = sw.toString();
				String strRecordStatus = acctBO.getRecordStatus();
				WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: AccountBOHook postWrite() RecordStatus="+strRecordStatus);
				NameValue nv[] = new NameValue[8];
				NameValue nv1 = new NameValue();
				NameValue nv2 = new NameValue();
				NameValue nv3 = new NameValue();
				NameValue nv4 = new NameValue();
				NameValue nv5 = new NameValue();
				NameValue nv6 = new NameValue();
				NameValue nv7 = new NameValue();
				NameValue nv8 = new NameValue();
				int iboID = 0;
				Integer iId=1;
				iboID = acctBO.getAccountID();

				String bankID = (String)SRMTLVar.bank_id.get();
				/*Changes for getting changed values -Start*/
				bc.setBank_id(bankID);
				/* Gets the list of attributes that are changed*/
				AccountBO oldBO = (AccountBO)Core.getBOClone(acctBO);

				/*
				 * If oldBO !=null it means Edit , else Create
				 * Alert Triggering needed  only for Edit.
				 */
				//System.out.println(">>>>>>>>>>>>>>>acctBO.getAlertAssignedTo():"+acctBO.getAlertAssignedTo());
				Integer iProcessid = acctBO.getProcessID();
				/* Changes for 10.5 Alert Server Starts */
				String processStatus = acctBO.getProcessStatus();
				//Integer iAlertAssignee = acctBO.getAlertAssignedTo();
				Integer iAssignee = acctBO.getAssignedTo();
                Integer iOwner= acctBO.getOwnedUserID();
				/* Changes for 10.5 Alert Server Ends */
				//System.out.println(">>>>>>>>>>>>>>>iAlertAssignee :"+iAlertAssignee);
				//System.out.println("strRecordStatus:"+strRecordStatus);
				/* Changes for 10.5 Alert Server Starts */
				if(oldBO!=null && "A".equalsIgnoreCase(strRecordStatus) && (iProcessid == null || processStatus == null || processStatus == "")){
				/* Changes for 10.5 Alert Server Ends */
				WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: AccountBOHook postWrite() CIF edit triggering starts");
					ArrayList arrChangedAlertAttribs = new CheckModifiedFields().getChangedAttributes(acctBO, bc);
					//System.out.println("**arrChangedAlertAttribs:"+arrChangedAlertAttribs);
					/*Changes for getting changed values -End*/
					if(!arrChangedAlertAttribs.isEmpty()){
						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: AccountBOHook postWrite() arrChangedAlertAttribs not empty");
						/*nv1 is used to set the BO Name*/
						nv1.setName("BO");
						nv1.setValue("AccountBO");

						/*nv2 is used to set the BOId*/
						nv2.setName("BOid");
						nv2.setValue(iboID);

						/*nv3 is used to set the ID- this is an index used for identifying the entity
						 * 'ID = 0' mean its CUSTOMER*/
						nv3.setName("ID");
						nv3.setValue(0);

						/*nv4 is for setting Changed Attributes*/
						nv4.setName("ChangedAttribs");
						nv4.setValue(arrChangedAlertAttribs);

						/*nv5 is for setting ProcessFlag
						 * If flag is true it means its a process related operation*/
						nv5.setName("ProcessFlag");
						nv5.setValue("false");
						/*nv6 is for setting the 'parameter' that should be passed for template execution*/
						nv6.setName("Param");
						nv6.setValue("CIF_ID");

						nv7.setName("Assignee");
						nv7.setValue(iAssignee);
						nv8.setName("Owner");
						nv8.setValue(iOwner);
						//System.out.println("\n******** after setting nv7 value************* ");
						/*nv[0] = nv1;
						nv[1] = nv2;
						nv[2] = nv3;
						nv[3] = nv4;
						nv[4] = nv5;
						nv[5] = nv6;*/

						alertNV = new NameValue[8];
						alertNV[0] = nv1;
						alertNV[1] = nv2;
						alertNV[2] = nv3;
						alertNV[3] = nv4;
						alertNV[4] = nv5;
						alertNV[5] = nv6;
						alertNV[6] = nv7;
						alertNV[7] = nv8;

						NameValue nvAlert = new NameValue();
						nvAlert.setName("alert");
						nvAlert.setValue(alertNV);

						mergedNV1 = new NameValue[2];
						mergedNV1[0] = nvAlert;
					    mergedNV1[1] = null;

						boolean status = new CRMAlert().insertToAlertProcessingQueue(bc, mergedNV1, "CRM", bankID);

						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: AccountBOHook postWrite() CIF edit triggering queueStatus"+status);
					}
					WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: AccountBOHook postWrite() CIF edit triggering ends");

				}

				/*Process Related Changes -Karthi*/
				/* Changes for 10.5 Alert Server Starts */
				//String processStatus = acctBO.getProcessStatus();
				//Integer iAlertAssignee = acctBO.getAlertAssignedTo();
				/* Changes for 10.5 Alert Server Ends */

                //10.4.02 SPE Changes - begin
				/*Properties keyProp = EditorUtil.getCIFGeneralInfo();
				String apprMech = keyProp.getProperty(EditorUtil.APPROVAL_MECHANISM);*/
				ConcurrentHashMap chmCifGenInfo = EditorUtil.getCIFGenInfo();
				String apprMech = (String)chmCifGenInfo.get(EditorUtil.APPROVAL_MECHANISM);
                //10.4.02 SPE Changes - end

				if("true".equals(apprMech)){
					AccountModBO acctModBO = (AccountModBO)Utils.getBOFromID( bc, "AccountModBO",AccountModBO.ACCOUNTKEY, ""+ acctBO.getAccountKey(), false );
						//fix for multiple alerts issue
					  alertNV = new NameValue[7];
					if(acctModBO != null){
					iProcessid = acctModBO.getProcessID();
					}
				}

				try {
 				/*Tracker id: 247549. CRM104BIT42 to Baseline - Recon Wave1 changes Begin. */
				//if(iProcessid != null && ((processStatus != null && "Closed".equals(processStatus))||"true".equals(apprMech))){
					/*
							This peice of code has been added since alert is not getting triggered for approval enbaled/disabled
							if the process status is not updated as CLOSED .
							This has been done after having the discussion with the alert server 10.3 team.
					*/
				  /* Fix for 556218 Changing condition as bulk customer creation is failing */
				 if(iProcessid != null){
				 if (((processStatus == null || processStatus == ""  || "CLOSED".equalsIgnoreCase(processStatus)))||"true".equals(apprMech)){
 				/*Tracker id: 247549. CRM104BIT42 to Baseline - Recon Wave1 changes Ends. */

					if(isAlertReq){
					WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: AccountBOHook postWrite() Process completion triggering starts");
					//System.out.println("*******************acctBO.getAlertAssignedTo():"+acctBO.getAlertAssignedTo());

/*Changes from IT2 to IT3 : start*/
					Integer iProcAssignee = oldBO.getAssignedTo();
					//System.out.println("*******************iProcAssignee :"+iProcAssignee);
/*Changes from IT2 to IT3 : End*/
					Integer iProcOwner= acctBO.getOwnedUserID();
					//System.out.println("*******************iAlertProcAssignee :"+iAlertProcAssignee);
					/*
					 *Getting internal and external alertids and putting inside nv
					 */
					ProcessBO processBO = Processes.findProcessBO(iProcessid, bc);
					ArrayList accountAlertList = new ArrayList();
					String internalAlert = processBO.getInternalAlert();
					String externalAlert = processBO.getExternalAlert();
					if(internalAlert != null)
						accountAlertList.add(internalAlert);
					if(externalAlert != null)
						accountAlertList.add(externalAlert);
					if(accountAlertList.size() > 0) {
						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: AccountBOHook postWrite() Process completion triggering AlertListsize > 0");
						alertNV = new NameValue[8];

						nv1.setName("BO");
						nv1.setValue("AccountBO");

						nv2.setName("BOid");
						nv2.setValue(iboID);

						nv3.setName("accountAlertList");
						nv3.setValue(accountAlertList);

						//Added for Process triggering
						/*nv5 is for setting ProcessFlag
						 * If flag is true it means its a process related operation*/
						nv4.setName("ProcessFlag");
						nv4.setValue("true");

						/*nv5 is for setting the 'parameter' that should be passed for template execution*/
						nv5.setName("Param");
						nv5.setValue("CIF_ID");


						nv6.setName("Assignee");
						nv6.setValue(iProcAssignee);

						nv7.setName("Owner");
						nv7.setValue(iProcOwner);
						alertNV[0] = nv1;
						alertNV[1] = nv2;
						alertNV[2] = nv3;
						//alertNV[3]-is used for arrChangedAlertAttribs,so its not set here to avoid conflict
						alertNV[4] = nv4;
						alertNV[5] = nv5;
						alertNV[6] = nv6;//to set assigneeid
						alertNV[7] = nv7;//to set owner
						//System.out.println("\n*************** for process alert* after setting nv6");
/*Changes from IT2 to IT3 : starts*/
						/* changes made as part of ticket 569240*/
						mergedNV = new NameValue[2];
						boolean queueStatus;
						NameValue nvAlert = new NameValue();
						nvAlert.setName("alert");
						nvAlert.setValue(alertNV);
						mergedNV[0] = nvAlert;
						mergedNV[1] = null;
						queueStatus = new CRMAlert().insertToAlertProcessingQueue(bc, mergedNV, "CRM", bc.getBank_id());
						/* changes made as part of ticket 569240*/
/*Changes from IT2 to IT3 : End*/
					}
				}
				WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: AccountBOHook postWrite() Process completion triggering ends");

		}
		}
/*Changes from IT2 to IT3 : starts*/
				/* changes made as part of ticket 569240, commenting the CXPS changes*/
				/*if (isAlertReq && isCXPSEnabled && alertNV!=null) {
				// namevalue pairs
					// as both are
					// available
					NameValue nvAlert = new NameValue();
					nvAlert.setName("alert");
					nvAlert.setValue(alertNV);
					mergedNV[0] = nvAlert;
					NameValue nvCxps = new NameValue();
					nvCxps.setName("cxps");
					nvCxps.setValue(cxpsNV);
					mergedNV[1] = nvCxps;
				} else if (isAlertReq && alertNV!=null) { // only Alert Server is enabled
					NameValue nvAlert = new NameValue();
					nvAlert.setName("alert");
					nvAlert.setValue(alertNV);
					mergedNV[0] = nvAlert;
					mergedNV[1] = null;
				} else if (isCXPSEnabled) {// only CXPS is enabled
					mergedNV[0] = null;
					NameValue nvCxps = new NameValue();
					nvCxps.setName("cxps");
					nvCxps.setValue(cxpsNV);
					mergedNV[1] = nvCxps;
				}
				boolean queueStatus;
				try{
				queueStatus = new CRMAlert().insertToAlertProcessingQueue(bc, mergedNV, "CRM", bc.getBank_id());
				WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: AccountBOHook postWrite() Process completion triggering queueStatus"+queueStatus);
				}catch(Exception e){
					e.printStackTrace();
					// Exception while inserting to the queue. Re-trying again.
                    queueStatus = new CRMAlert()
                    .insertToAlertProcessingQueue(bc, mergedNV, "CRM",
                                bc.getBank_id());


				}*/
				/* changes made as part of ticket 569240, commenting the CXPS changes*/
				}
		catch(Exception e){
/*Changes from IT2 to IT3 : End*/
					WebAdaptor
					.log(
							com.infy.cis.log.LogType.DEBUG,
							"Alertserver: AccountBOHook postWrite() Exception occured in process related alertserver block");
					e.printStackTrace();
		}
		}
	//			 *************************Alert Server Changes End -Abhilash_Mohandas,Suthyev_S*********************
			} catch (Exception e) {
				WebAdaptor
									.log(
											com.infy.cis.log.LogType.DEBUG,
							"Alertserver: Exception occured while processing alertserver block");
				e.printStackTrace();
		}
		//Tracker ID :224398 Changes for CRM-CXPS integration.   END

	/**** Alert server recon to 10.2.14 End    Tracker ID 378548 ****/
		//Alert server recon to 10.2.14 ends


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



}








