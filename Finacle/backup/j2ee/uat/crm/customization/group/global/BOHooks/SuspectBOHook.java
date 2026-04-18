/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: SuspectBOHook.java $
 *
 * Author: Jagadish
 *
 * $Archive:
 *
 * *********************************** */

/* CRM61SR:SRCIUHBO:TRACKER# 44231 **BEGIN  CHANGES** */
package com.infy.cis.custom;

import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.SuspectBO;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.exception.*;
import com.infy.cis.srmbo.SRMBase;
import com.infy.cis.srmbo.AttrAccValidator;

import com.infy.cis.srmbo.Core;
import java.util.Date;
import com.infosys.insulate.util.HashMap;

import com.infy.finacle.crypt.MsgDigest;
import java.util.Properties;
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.SRMDataObject;
import com.infy.cis.common.EditorUtil;
import com.infy.cis.srmbo.Cif;
import com.infy.cis.srmbo.*;
import com.infy.cis.common.*;
import com.infy.cis.ui.common.CIFSyncData;
import com.infy.cis.ui.common.*;
import com.infy.cis.log.*;
import com.infy.cis.adaptor.web.WebAdaptor;
import com.infy.cis.alert.CRMAlert;
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
public class SuspectBOHook implements IHooks {

   public SuspectBOHook(){}

// sample hook - postWrite

 /* public void preWrite (SRMBusinessContext bc, Object bo)
    //throws SRMPreWriteException {
	//    customized implementation place holder
   //SuspectBO abo = (SuspectBO)bo;
  	} */

  /* CRM61LR:TRACKER:44575:BEGINOFCHANGES */

	public void preWrite (SRMBusinessContext bc, Object bo)
	 throws SRMPreWriteException,SRMSecurityException {
		/*
		SuspectBO boAccount = (SuspectBO)bo;
		String GroupId = boAccount.getGroupID();
		Integer AccountId = boAccount.getAccountID();
		String AccountKey = boAccount.getAccountKey();

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
		*/

		SuspectBO boPspt = (SuspectBO)bo;
		//Tracker:90196: Changes for attibute masking
		try {
			AttrAccValidator.validatecreate((SRMBase) bo);
		} catch(SRMSecurityException e) {
			throw new SRMSecurityException(SRMSecurityException.ERROR_ATTR_MASK, null) ;
		}
		//Tracker:90196: End of Changes



								String sRating =boPspt.getSegmentation_Class();

		/*Changes for setting duedate*/
		try{
			if(sRating != null)	{
				if( sRating.equals("Gold") ){
					boPspt.setSLALevel("SLA5");
				}
				else if( sRating.equals("Silver") ){
					boPspt.setSLALevel("SLA4");
				}
				else if( sRating.equals("High net worth") ){
					boPspt.setSLALevel("SLA3");
				}
				else if( sRating.equals("Class A") ){
					boPspt.setSLALevel("SLA2");
				}
				else{
					boPspt.setSLALevel("SLA1");
				}
			}
			else{
						boPspt.setSLALevel("SLA1");
			}
		}catch(Exception ex)
			{
				ex.printStackTrace();
			}



		Date dDueDate = null;
		try{
			dDueDate = boPspt.getDueDate();
			if(dDueDate == null){
				boPspt.setStartDate( SRMDate.getGMT() );
				dDueDate = Cif.setDueDate(bc, boPspt,"Suspect");
			}
		}
		catch(Exception e){}
		try{
		/*Changes for Setting Escalation Due Time*/
		Integer iProcessid = boPspt.getProcessID();
		Integer iStepKey = boPspt.getCurrentStep();
		Integer iEscMatID = null;
		Integer iProcEscMatID = null;
		ProcessBO processBO = null;
		Integer iOwnerID = null;
		Integer iLocnID		= null;
		Integer iGroupID 	= null;
		String tat[] = new String[2];
		String proctat[] = new String[2];
		iOwnerID 			= boPspt.getOwneduserid();
		iLocnID				= boPspt.getOwnedLocationID();
		iGroupID			= boPspt.getOwnerGroup();
		int iTat=0;
		int iprocTat=0;
		boolean isFirstStep = false;
		Date iCurrStepDueDate	= boPspt.getCurrStepDueDate();
		int currentStepInt = 0;
		if(iStepKey !=null && !(iStepKey.equals(null)) && !(iStepKey.equals("")))
		currentStepInt = iStepKey.intValue();


		if (iProcessid != null && !(iProcessid.equals(null))) {
			processBO = Processes.findProcessBO(iProcessid, bc);
			iProcEscMatID=processBO.getEscalationMatrix();
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
			aTatArray = getEscTatDuration(bc, iEscMatID, boPspt.getSuspectID(),"Suspect");
			aProcTatArray = getEscTatDuration(bc, iProcEscMatID, boPspt.getSuspectID(),"Suspect"); //10.1 RECON Change
			for( int i = 0; i < aTatArray.size(); i++){
				tat[i] = aTatArray.get( i ).toString();
			}

			for( int i = 0; i < aProcTatArray.size(); i++){
									proctat[i] = aProcTatArray.get( i ).toString();
								}
			if (tat[0] != null && !(tat[0].equals("null"))){//10.1 RECON Change
				iTat = Integer.parseInt(tat[0]);
				String sUnit = tat[1];
				ASGenerator asgen = new ASGenerator();
				String sAvailString = Utils.getAvailString(bc, iOwnerID, iLocnID, iGroupID);
				Date tempStepDueDate = asgen.findDueDate(sAvailString, iTat, sUnit, iCurrStepDueDate);
				String          strDate = tempStepDueDate.toGMTString();
                strDate = strDate.replaceFirst("GMT","");
                Date  strdate= new Date(strDate);
				boPspt.setEsc_Due_time(strdate);

			}


			if (proctat[0] != null && !(proctat[0].equals("null")) && (isFirstStep)){//10.1 RECON Change
				iprocTat = Integer.parseInt(proctat[0]);
				String sprocUnit = proctat[1];
				ASGenerator asprocgen = new ASGenerator();
				String sProcAvailString = Utils.getAvailString(bc, iOwnerID, iLocnID, iGroupID);
				Date tempDueDate = asprocgen.findDueDate(sProcAvailString, iprocTat, sprocUnit, dDueDate);
				String          strDate = tempDueDate.toGMTString();
                strDate = strDate.replaceFirst("GMT","");
                Date  strdate= new Date(strDate);
				boPspt.setProcEscDuetime(strdate);

			}

		}
	}catch(Exception e){
		e.printStackTrace();
		}
		/*Changes for Setting Escalation Due Time*/







		HashMap custcfg = SizeUtil.getCustConfig ("PROSPECT");
					// AdressLine changes: START
				HashMap addDetails = null;
				HashMap addLines = null;
		// AdressLine changes: END
					if (boPspt.getAddress() != null) {
						SRMCollection addrColl = boPspt.getAddress();
						SuspectBO.Address address = null;
						for (int i = 0; i < addrColl.size(); ++i) {
		// AdressLine changes: START
							addDetails = new HashMap();
		// AdressLine changes: END
							address = (SuspectBO.Address)addrColl.get(i);
		// AdressLine changes: START
							try{
								//TrackerID:157847,Changes Begin
								if(!(address.getAddressCategory()==null || address.getAddressCategory().equals("Swift"))){
									//TrackerID:157847,Changes End
									if(address.getPreferredFormat().equals("STRUCTURED_FORMAT")){
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
							}


							}
							catch(SRMTypeValidatorException typeException){
								//System.out.println("typeException="+typeException);
							}
// AdressLine changes: END
			}
		}
	// Changes for CheckSum :Start
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

	String isTampered = boPspt.getIsTampered();
	if (isTampered == null) {
				isTampered = "";
		}
	if (!(isTampered.equals("Y"))) {
	 String[] aString = new String[6];
     //aString[0] =  boPspt.getSuspectID().toString();
	 aString[1] =  boPspt.getSuspectsKey();
	 aString[2] =  boPspt.getLastName();
     SuspectBO.Address newAddr = null;
     final SRMCollection addNew = boPspt.getAddress();
	 for (int i = 0; i < addNew.size(); ++i)
	  {
	 	newAddr = (SuspectBO.Address) addNew.get(i);
		final String newAddrType = newAddr.getAddressCategory();
		if (!newAddrType.equalsIgnoreCase("Mailing"))
		 {continue;
			 }
		final Date strtDate = newAddr.getStart_Date();
		final Date endDate = newAddr.getEnd_Date();
		final Date today = new Date();
		  // To calculate checksum when start date is today
		  boolean fToday = true;
		  if(today.getYear() == strtDate.getYear() &&
			 today.getMonth() == strtDate.getMonth() &&
			 today.getDate() == strtDate.getDate()){
					fToday = false;
				}
		 if(fToday)
		if (!(today.after(strtDate) && today.before(endDate)))
		 {continue;
		 }
		aString[3] = newAddr.getAddress_Line1();
		aString[4] = newAddr.getCity();
		aString[5] = newAddr.getZip();
	  }
	for(int i= 1; i<= 5;i++){
		if (aString[i] == null){
				aString[i] = "";
				}
			}
	// Input String to CheckSum API : SUSPECTBO
	StringBuffer chkSumSus = new StringBuffer(256);
	for(int iAppend = 1; iAppend <= 5 ; iAppend++)
	{
	   chkSumSus.append(aString[iAppend]);
	   chkSumSus.append("|");
	 }
 		final String chkSumCalc1 = MsgDigest.getDigestToken(chkSumSus.toString());
		boPspt.setIsTampered("N");
		boPspt.setCheckSum(chkSumCalc1);
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
					//break;
					/* 10.1 RECON Changes by mukundhan_santhanam (79625)*/
					String sEscLevel = escDetails.getEscLevel();
					if(sEscLevel.equalsIgnoreCase("1")){
						break;
					}
					else{
						continue;
					}
					// End of 10.1 RECON Changes
				}
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
	   // customized implementation place holder
/* CRM61SR:SREVNTBO:TRACKER# 44228 **BEGIN  CHANGES** */

	/*try{

		SuspectBO boSuspect = (SuspectBO)bo;
		Integer SuspectId = boSuspect.getSuspectID();
		String sEventFor = "Prospect";
		String sEventType = "DOB";
		Date dEventDate = boSuspect.getSuspects_DOB();
		if(dEventDate != null){
			String sEventDesc = "Date of Birth";
			boolean bEditable = false;
			Core.CreateNewEvent(bc,sEventFor,SuspectId,sEventType,dEventDate,sEventDesc,bEditable);
		}
		}catch(Exception e){
		throw new SRMPostWriteException(SRMPostWriteException.ERROR_EVENT_WRITEFAILURE,e);
		}
		*/

 /* CRM61SR:SREVNTBO:TRACKER# 44228 **END OF CHANGES** */
   //SuspectBO abo = (SuspectBO)bo;

		// changes starts for IBK for ticket 636652
		try {
			Properties genProp = EditorUtil.getCIFGeneralInfo();
			String syncUpFlag = genProp.getProperty(EditorUtil.CIFSYNCUP).trim();
			if(syncUpFlag.equalsIgnoreCase("TRUE")){
				CIFSyncData.syncRetailPros(bc, bo);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//System.out.println("Inside SuspectBOHook.CIFSyncData..catch block..exception.message.."+e.getMessage());
			e.printStackTrace();
		}
		// changes ends for IBK for ticket 636652
	  
                 /**** Alert server recon to 10.2.14 Start Tracker ID 378548 ****/
   /* Changes for 10.5 Alert Server Starts */
   SuspectBO suspBO = (SuspectBO)bo;
   /* Changes for 10.5 Alert Server Ends */

				StackTraceElement[] stackTraceElements = Thread.currentThread().getStackTrace();
				////System.out.println("System Call Stact Trace prospect");
					for (int i=2 ; i<stackTraceElements.length; i++)
					{
						StackTraceElement ste = stackTraceElements[i];
						String classname = ste.getClassName();
						String methodName = ste.getMethodName();
						int lineNumber = ste.getLineNumber();
						////System.out.println(classname+"."+methodName+":"+lineNumber);
			}


	  try {
		  /*****************************Fix for 318996- START************************************/
		  	Throwable t = new Throwable();
			t.fillInStackTrace();
			StringWriter sw = new StringWriter();
			PrintWriter pw = new PrintWriter(sw);
			t.printStackTrace(pw);
			String stackTrace = sw.toString();
			boolean isAlertReq = Boolean.parseBoolean(EditorUtil.getAlertDetails());
			/*****************************Fix for 318996- END************************************/
			WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: SuspectBO Hook isAlertReq " +isAlertReq);
			////System.out.println("Alertserver: SuspectBO Hook isAlertReq " +isAlertReq);

			if (isAlertReq) {
				/* Changes for 10.5 Alert Server Starts */
				//SuspectBO suspBO = (SuspectBO)bo;
				/* Changes for 10.5 Alert Server Ends */
				String strRecordStatus = suspBO.getRecordStatus();
				WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: SuspectBO postWrite() RecordStatus="+strRecordStatus);
				////System.out.println("Alertserver: SuspectBO postWrite() RecordStatus="+strRecordStatus);
				NameValue[] nv = new NameValue[8];
				NameValue nv1 = new NameValue();
				NameValue nv2 = new NameValue();
				NameValue nv3 = new NameValue();
				NameValue nv4 = new NameValue();
				NameValue nv5 = new NameValue();
				NameValue nv6 = new NameValue();
				NameValue nv7 = new NameValue();
				NameValue nv8 = new NameValue();

				int iboID = suspBO.getSuspectID();
				String bankID = (String)SRMTLVar.bank_id.get();
				// Changes for 10.5 Alert Server Starts
				bc.setBank_id(bankID);
				// Changes for 10.5 Alert Server Ends
				SuspectBO oldBO = (SuspectBO)Core.getBOClone(suspBO);
				Integer iAssignee = suspBO.getAssignedTo();
                Integer iOwner= suspBO.getOwneduserid();

				Integer iProcessid = suspBO.getProcessID();
				String processStatus = suspBO.getProcessStatus();

				/*
				 * If oldBO !=null it means Edit , else Create
				 * Alert Triggering needed  only for Edit.
				 */
				 ////System.out.println("Old BO &&&&&&&&&&&&&& "+oldBO);
				 ////System.out.println("strRecordStatus &&&&&&&&&&&&&& "+strRecordStatus);
				 ////System.out.println("stackTrace &&&&&&&&&&&&&& "+ stackTrace.indexOf("com.infy.cis.srmbo.BLUtil.RegisterABO"));
				/* Changes for 10.5 Alert Server Starts */
				if(oldBO!=null && "A".equalsIgnoreCase(strRecordStatus) && (iProcessid == null || processStatus == null || processStatus == "")){   //&& stackTrace.indexOf("com.infy.cis.srmbo.BLUtil.RegisterABO") != -1){
				/* Changes for 10.5 Alert Server Ends */
					WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: SuspectBO postWrite() CIF edit triggering starts");
					////System.out.println("Alertserver: SuspectBO postWrite() CIF edit triggering starts");
					 ArrayList arrChangedAlertAttribs = new CheckModifiedFields().getChangedAttributes(suspBO, bc);
					////System.out.println("Suspect BO coming here &&&&&&&&&&&&&& "+arrChangedAlertAttribs);
					/*Changes for getting changed values -End*/
				   if(!arrChangedAlertAttribs.isEmpty()){
						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: SuspectBO Hook postWrite() arrChangedAlertAttribs not empty");
						////System.out.println("Alertserver: SuspectBO Hook postWrite() arrChangedAlertAttribs not empty");

						nv1.setName("BO");
						nv1.setValue("SuspectBO");

						nv2.setName("BOid");
						nv2.setValue(iboID);

						nv3.setName("ID");
						nv3.setValue(2);

						/*nv4 is for setting Changed Attributes*/
						nv4.setName("ChangedAttribs");
						nv4.setValue(arrChangedAlertAttribs);

						/*nv5 is for setting ProcessFlag
						 * If flag is true it means its a process related operation*/
						nv5.setName("ProcessFlag");
						nv5.setValue("false");

						nv6.setName("Param");
						nv6.setValue("CIF_ID");
						nv7.setName("Assignee");
						nv7.setValue(iAssignee);
						nv8.setName("Owner");
						nv8.setValue(iOwner);
						/*nv[0] = nv1;
						nv[1] = nv2;
						nv[2] = nv3;
						nv[3] = nv4;
						nv[4] = nv5;
						nv[5] = nv6;

						//Setting Dummy Value
						nv[2] = nv3;*/
						//alert changes
						NameValue[] alertNV = new NameValue[8];
						/* Changes for 10.4.02 Alert Server starts */
						//alertNV = new NameValue[8];
						/* Changes for 10.4.02 Alert Server ends */
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

						NameValue[] mergedNV1 = null;
						mergedNV1 = new NameValue[2];
						mergedNV1[0] = nvAlert;
						mergedNV1[1] = null;

						boolean status = new CRMAlert().insertToAlertProcessingQueue(bc, mergedNV1, "CRM", bankID);
						//boolean status = new CRMAlert().insertToAlertProcessingQueue(bc, nv, "CRM", bankID);
						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: AccountBOHook postWrite() CIF edit triggering queueStatus"+status);
						////System.out.println("Alertserver: AccountBOHook postWrite() CIF edit triggering queueStatus"+status);
				   }
					WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: SuspectBOHook postWrite() CIF edit triggering starts");
					////System.out.println("Alertserver: SuspectBOHook postWrite() CIF edit triggering starts");
				}

				/*Process Related Changes -Karthi*/
				WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: SuspectBOHook postWrite() Process completion triggering starts"+iProcessid+"Status "+processStatus);
				////System.out.println("Alertserver: SuspectBOHook postWrite() Process completion triggering starts"+iProcessid+"Status "+processStatus);
				Properties keyProp = EditorUtil.getCIFGeneralInfo();
				String apprMech = keyProp.getProperty(EditorUtil.APPROVAL_MECHANISM);

				if("true".equals(apprMech)){
					SuspectModBO suspModBO = (SuspectModBO)Utils.getBOFromID( bc, "SuspectModBO",SuspectModBO.SUSPECTSKEY, ""+ suspBO.getSuspectsKey(), false );
					//fix for multiple alerts triggering issue
					//alert changes
					NameValue[] alertNV = new NameValue[8];

						alertNV = new NameValue[7];
					if(suspModBO != null){
						iProcessid = suspModBO.getProcessID();
					}
				}
				try{
					/*if (strRecordStatus.equalsIgnoreCase("A")){
				/*Tracker id: 247549. CRM104BIT42 to Baseline - Recon Wave1 changes Begin. */
				//if(iProcessid != null && ((processStatus != null && "Closed".equals(processStatus))||"true".equals(apprMech))){
					/*
						This code has been modified since alert is not getting triggered for approval enbaled/disabled
						if the process status is not updated as CLOSED. This has been done after having the discussion with the alert server 10.3 team.
					*/
					/* Changes for 10.5 Alert Server Starts */
					if(iProcessid != null && ((processStatus == null || processStatus == ""  || "CLOSED".equalsIgnoreCase(processStatus)))||"true".equals(apprMech)){
 				/*Tracker id: 247549. CRM104BIT42 to Baseline - Recon Wave1 changes Ends. */

					if (isAlertReq){
					WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: SuspectBOHook postWrite() Process completion triggering starts");
/*Changes from IT2 to IT3 : starts*/
					Integer iProcAssignee = oldBO.getAssignedTo();
/*Changes from IT2 to IT3 : End*/
					Integer iProcOwner= suspBO.getOwneduserid();

					/*
					 *Getting internal and external alertids and putting inside nv
					 */
					ProcessBO processBO = Processes.findProcessBO(iProcessid, bc);
					/* Changes for 10.5 Alert Server Ends */
					ArrayList suspectAlertList = new ArrayList();
					String internalAlert = processBO.getInternalAlert();
					String externalAlert = processBO.getExternalAlert();
					if(internalAlert != null)
						suspectAlertList.add(internalAlert);
					if(externalAlert != null)
						suspectAlertList.add(externalAlert);
					if(suspectAlertList.size() > 0) {
						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: SuspectBOHook postWrite() Process completion triggering AlertListsize > 0");
						//alert changes
						NameValue[] alertNV = new NameValue[8];

						alertNV = new NameValue[8];

						nv1.setName("BO");
						nv1.setValue("SuspectBO");

						nv2.setName("BOid");
						nv2.setValue(iboID);

						nv3.setName("suspectAlertList");
						nv3.setValue(suspectAlertList);

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
						//nv[3]-is used for arrChangedAlertAttribs,so its not set here to avoid conflict
						alertNV[4] = nv4;
						alertNV[5] = nv5;
						alertNV[6] = nv6;
						alertNV[7] = nv7;
/*Changes from IT2 to IT3 : starts*/
						/* changes made as part of ticket 569240*/
						//alert changes
						NameValue[] mergedNV = new NameValue[8];

						mergedNV = new NameValue[2];
						NameValue nvAlert = new NameValue();
						boolean queueStatus;
						nvAlert.setName("alert");
						nvAlert.setValue(alertNV);
						mergedNV[0] = nvAlert;
						mergedNV[1] = null;
						queueStatus = new CRMAlert().insertToAlertProcessingQueue(bc, mergedNV, "CRM", bc.getBank_id());
						/* changes made as part of ticket 569240*/
/*Changes from IT2 to IT3 : End*/
					}


				}
					WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: SuspectBOHook postWrite() Process completion triggering ends");

			}
/*Changes from IT2 to IT3 : starts*/
				/* changes made as part of ticket 569240, commenting the CXPS changes*/
				/*mergedNV = new NameValue[2];
				if (isAlertReq && isCXPSEnabled && alertNV!=null) {
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
					try {
						queueStatus = new CRMAlert().insertToAlertProcessingQueue(bc, mergedNV, "CRM", bc.getBank_id());
					} catch (Exception e) {
						// Exception while inserting to the queue. Re-trying again.
                        queueStatus = new CRMAlert()
                        .insertToAlertProcessingQueue(bc, mergedNV, "CRM",
                                    bc.getBank_id());

					}
					WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: SuspectBOHook postWrite() Process completion triggering queueStatus"+queueStatus);
					*/
					/* changes made as part of ticket 569240, commenting the CXPS changes*/
/*Changes from IT2 to IT3 : End*/
				}catch(Exception e){
					WebAdaptor
					.log(
							com.infy.cis.log.LogType.DEBUG,
							"Alertserver: AccountBOHook postWrite() Exception occured while processing alertserver block");
					//e.printStackTrace();
				}
		}

//			 *************************Alert Server Changes End *********************
	  		} catch (Exception e) {
				WebAdaptor
						.log(
								com.infy.cis.log.LogType.DEBUG,
				"Alertserver: AccountBOHook postWrite() Exception occured while processing alertserver block");
	  			//e.printStackTrace();
		}

	/**** Alert server recon to 10.2.14 End    Tracker ID 378548 ****/
	//Tracker ID :224398 Changes for CRM-CXPS integration.   END
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






