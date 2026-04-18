/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: ContactBOHook.java $
 *
 * Author:
 *
 * $Archive:
 *
 * *********************************** */

/* CRM61SR:SRCIUHBO:TRACKER# 44231 **BEGIN  CHANGES** */
package com.infy.cis.custom;

import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.ContactBO;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.exception.*;
import com.infy.cis.srmbo.SRMBase;
import com.infy.cis.srmbo.AttrAccValidator;
import com.infy.cis.common.EditorUtil;
import com.infy.cis.srmbo.ContactBO;
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.finacle.crypt.MsgDigest;

import com.infy.cis.srmbo.Core;
import java.util.Date;
import com.infosys.insulate.util.HashMap;
import com.infy.cis.srmbo.SRMCollection;
import java.util.Date;
import java.util.Properties;
import com.infy.cis.srmbo.*;
import com.infy.cis.common.*;
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



public class ContactBOHook implements IHooks {

   public ContactBOHook(){}

// sample hook - postWrite

 /* public void preWrite (SRMBusinessContext bc, Object bo)
    //throws SRMPreWriteException {
	//    customized implementation place holder
   //ContactBO abo = (ContactBO)bo;
  	} */

  /* CRM61LR:TRACKER:44575:BEGINOFCHANGES */

	public void preWrite (SRMBusinessContext bc, Object bo)
	 throws SRMPreWriteException,SRMSecurityException {
		/*
		ContactBO boAccount = (ContactBO)bo;
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

		ContactBO boCont = (ContactBO)bo;

		//Tracker:90196: Changes for attibute masking
		try {
			AttrAccValidator.validatecreate((SRMBase) bo);
		} catch(SRMSecurityException e) {
			throw new SRMSecurityException(SRMSecurityException.ERROR_ATTR_MASK, null) ;
		}
		//Tracker:90196: End of Changes


		/*Change for Setting DueDate*/
		String sRating =boCont.getSegmentation_Class();
		try{
			if(sRating != null)	{
				if( sRating.equals("Gold") ){
					boCont.setSLALevel("SLA5");
				}
				else if( sRating.equals("Silver") ){
					boCont.setSLALevel("SLA4");
				}
				else if( sRating.equals("High net worth") ){
					boCont.setSLALevel("SLA3");
				}
				else if( sRating.equals("Class A") ){
					boCont.setSLALevel("SLA2");
				}
				else{
					boCont.setSLALevel("SLA1");
				}
			}
			else{
						boCont.setSLALevel("SLA1");
			}
		}catch(Exception ex)
			{
				ex.printStackTrace();
			}



		Date dDueDate = null;
		try{
			dDueDate = boCont.getDueDate();
			if(dDueDate == null){
				boCont.setStartDate( SRMDate.getGMT() );
				dDueDate = Cif.setDueDate(bc, boCont,"Contact");
			}
		}
		catch(Exception e){
			}
		try{
		Integer iProcessid = boCont.getProcessID();
		Integer iStepKey = boCont.getCurrentStep();
		Integer iEscMatID = null;
		Integer iProcEscMatID = null;
		ProcessBO processBO = null;
		Integer iOwnerID = null;
		Integer iLocnID		= null;
		Integer iGroupID 	= null;
		String tat[] = new String[2];
		String proctat[] = new String[2];
		iOwnerID 			= boCont.getOwnedUserID();
		iLocnID				= boCont.getOwnedLocationID();
		iGroupID			= boCont.getOwnerGroup();
		int iTat=0;
		int iprocTat=0;
		boolean isFirstStep = false;
		Date iCurrStepDueDate	= boCont.getCurrStepDueDate();
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
				if(bo1.getStepKey().intValue() == iStepKey.intValue()) {isFirstStep = bo1.getIsFirstStep().booleanValue();
					iEscMatID = bo1.getEscalationMatrix();
				}
			}

			ArrayList aTatArray = new ArrayList();
			ArrayList aProcTatArray = new ArrayList();
			aTatArray = getEscTatDuration(bc, iEscMatID, boCont.getContactID(),"Contact");
			aProcTatArray =getEscTatDuration(bc, iProcEscMatID, boCont.getContactID(),"Contact"); //10.1 Recon Changes by Mukundhan (79625)
			for( int i = 0; i < aTatArray.size(); i++){
				tat[i] = aTatArray.get( i ).toString();
			}

			for( int i = 0; i < aProcTatArray.size(); i++){
				proctat[i] = aProcTatArray.get( i ).toString();
			}


	if (tat[0] != null && !(tat[0].equals("null"))){//10.1 Recon Changes by Mukundhan
		iTat = Integer.parseInt(tat[0]);
		String sUnit = tat[1];
		ASGenerator asgen = new ASGenerator();
		String sAvailString = Utils.getAvailString(bc, iOwnerID, iLocnID, iGroupID);
		Date tempStepDueDate = asgen.findDueDate(sAvailString, iTat, sUnit, iCurrStepDueDate);
		String          strDate = tempStepDueDate.toGMTString();
        strDate = strDate.replaceFirst("GMT","");
        Date  strdate= new Date(strDate);
		boCont.setEsc_Due_time(strdate);

	}


	if (proctat[0] != null && !(proctat[0].equals("null")) && (isFirstStep)){//10.1 Recon Changes by Mukundhan
		iprocTat = Integer.parseInt(proctat[0]);
		String sprocUnit = proctat[1];
		ASGenerator asprocgen = new ASGenerator();
		String sProcAvailString = Utils.getAvailString(bc, iOwnerID, iLocnID, iGroupID);
		Date tempDueDate = asprocgen.findDueDate(sProcAvailString, iprocTat, sprocUnit, dDueDate);
		String          strDate = tempDueDate.toGMTString();
        strDate = strDate.replaceFirst("GMT","");
        Date  strdate= new Date(strDate);
		boCont.setProcEscDuetime(strdate);
					}

		}
	}catch(Exception e){
		e.printStackTrace();
		}
		/*Changes for Setting Escalation Due Time*/





		HashMap custcfg = SizeUtil.getCustConfig ("CONTACT");
/* AdressLine changes: START */
		HashMap addDetails = null;
		HashMap addLines = null;
/* AdressLine changes: END */
			if (boCont.getAddress() != null) {
				SRMCollection addrColl = boCont.getAddress();
				ContactBO.Address address = null;
				for (int i = 0; i < addrColl.size(); ++i) {
/* AdressLine changes: START */
					addDetails = new HashMap();
/* AdressLine changes: END */
					address = (ContactBO.Address)addrColl.get(i);
/* AdressLine changes: START */
					try{
						if(!address.getAddressCategory().equals("Swift")){
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
/* AdressLine changes: END */
				}
			}


	 //Changes for CheckSum : Start
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

	String isTampered = boCont.getIsTampered();
	if (isTampered == null) {
				isTampered = "";
		}
	if (!(isTampered.equals("Y"))) {
	String[] aString = new String[6];
	//aString[0] = boCont.getContactID().toString();
   	aString[1] = boCont.getContactsKey();
	aString[2] = boCont.getLastName();
	ContactBO.Address newAddr = null;
	final SRMCollection addNew = boCont.getAddress();
	for (int i = 0; i < addNew.size(); ++i)
	 {
		newAddr = (ContactBO.Address) addNew.get(i);
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
	for(int i=1; i<= 5;i++){
			if (aString[i] == null){
				aString[i] = "";
				}
			}
	StringBuffer sChkSumCont = new StringBuffer(256);
	for(int iAppend = 1; iAppend <= 5 ; iAppend++)
	{
		sChkSumCont.append(aString[iAppend]);
		sChkSumCont.append("|");
	}
		final String chkSumCalc1 =
		MsgDigest.getDigestToken(sChkSumCont.toString());
		boCont.setIsTampered("N");

		boCont.setCheckSum(chkSumCalc1);
     }
  	}
  	} catch (SRMBOException e)
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
					//10.1 Recon Changes by Mukundhan
                    //break;
					String sEscLevel = escDetails.getEscLevel();
					if(sEscLevel.equalsIgnoreCase("1")){
					break;
					}
					else{
						continue;
					}
                    //End of Recon Changes
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
 /**** Alert server recon to 10.2.14 Start Tracker ID 378548 ****/
		//Alert server recon to 10.2.14 starts
		// *************************Alert Server Changes Start *********************
		//Calling the queue for alert processing
		try {
			NameValue[] alertNV = null;
			NameValue[] mergedNV = null;
			NameValue[] mergedNV1 = null;
			//String strIsAlertReq = EditorUtil.getAlertDetails();
			boolean isAlertReq = Boolean.parseBoolean(EditorUtil.getAlertDetails());
			WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: ContactBOHook strIsAlertReq " +isAlertReq);
			//if ("true".equalsIgnoreCase(strIsAlertReq)) {
				if(isAlertReq){
				ContactBO contBO = (ContactBO) bo;
				String strRecordStatus = contBO.getRecordStatus();
				WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: ContactBOHook postWrite() RecordStatus="+strRecordStatus);
				NameValue[] nv = new NameValue[8];
				NameValue nv1 = new NameValue();
				NameValue nv2 = new NameValue();
				NameValue nv3 = new NameValue();
				NameValue nv4 = new NameValue();
				NameValue nv5 = new NameValue();
				NameValue nv6 = new NameValue();
				NameValue nv7 = new NameValue();
				NameValue nv8 = new NameValue();

				int  iboID = contBO.getContactID();
				String bankID = (String)SRMTLVar.bank_id.get();
				// Changes for 10.5 Alert Server Starts
				bc.setBank_id(bankID);
				// Changes for 10.5 Alert Server Ends
				ContactBO oldBO = (ContactBO)Core.getBOClone(contBO);
				/*
				 * If oldBO !=null it means Edit , else Create
				 * Alert Triggering needed  only for Edit.
				 */
				/* Changes for 10.5 Alert Server Starts */
				Integer iProcessid = contBO.getProcessID();
				String processStatus = contBO.getProcessStatus();
				/* Changes for 10.5 Alert Server Ends */
				//Integer iAlertAssignee = contBO.getAlertAssignedTo();
				Integer iAssignee = contBO.getAssignedTo();
                		Integer iOwner= contBO.getOwnedUserID();

				//if(oldBO!=null && "A".equalsIgnoreCase(strRecordStatus)){
				/* Changes for 10.5 Alert Server Starts */
				if(oldBO!=null && "A".equalsIgnoreCase(strRecordStatus) && (iProcessid == null || processStatus == null || processStatus == "")){
				/* Changes for 10.5 Alert Server Ends */
				WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: ContactBOHook postWrite() CIF edit triggering starts");
					ArrayList arrChangedAlertAttribs =new CheckModifiedFields().getChangedAttributes(contBO, bc);

					/*Changes for getting changed values -End*/
				   if(!arrChangedAlertAttribs.isEmpty()){
						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: ContactBOHook postWrite() arrChangedAlertAttribs not empty");

						nv1.setName("BO");
						nv1.setValue("ContactBO");

						nv2.setName("BOid");
						nv2.setValue(iboID);

						nv3.setName("ID");
						nv3.setValue(1);

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
						nv[5] = nv6;*/

						//Setting Dummy Value
						//nv[2] = nv3;
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
						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: ContactBOHook postWrite() CIF edit triggering queueStatus"+status);


				   }
				WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: ContactBOHook postWrite() CIF edit triggering ends");

				}

				/*Process Related Changes -Karthi*/
				/* Changes for 10.5 Alert Server Starts */
				//Integer iProcessid = contBO.getProcessID();
				//String processStatus = contBO.getProcessStatus();
				/* Changes for 10.5 Alert Server Ends */
				/*Process Related Changes -Karthi*/
				Properties keyProp = EditorUtil.getCIFGeneralInfo();
				String apprMech = keyProp.getProperty(EditorUtil.APPROVAL_MECHANISM);

				if("true".equals(apprMech)){
					ContactModBO contModBO = (ContactModBO)Utils.getBOFromID( bc, "ContactModBO",ContactModBO.CONTACTSKEY, ""+ contBO.getContactsKey(), false );
                    if(contModBO != null)
					iProcessid = contModBO.getProcessID();
				}

		/*Tracker id: 247549. CRM104BIT42 to Baseline - Recon Wave1 changes Begin. */
			//	if(iProcessid != null && ((processStatus != null && "Closed".equals(processStatus))||"true".equals(apprMech))){
					/*
						This code has been modified since alert is not getting triggered for approval enbaled/disabled
							if the process status is not updated as CLOSED. This has been done after having the discussion with the alert server 10.3 team.
					*/
				if(iProcessid != null && ((processStatus == null || processStatus == ""  || "CLOSED".equalsIgnoreCase(processStatus)))||"true".equals(apprMech)){
 		/*Tracker id: 247549. CRM104BIT42 to Baseline - Recon Wave1 changes Ends. */
					WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: ContactBOHook postWrite() Process completion triggering starts");
					//Integer iAlertProcAssignee = contBO.getAlertAssignedTo();
					if (isAlertReq){
					Integer iProcAssignee = contBO.getAssignedTo();
					Integer iProcOwner= contBO.getOwnedUserID();
					/*
					 *Getting internal and external alertids and putting inside nv
					 */
					ProcessBO processBO = Processes.findProcessBO(iProcessid, bc);
					ArrayList contactAlertList = new ArrayList();
					String internalAlert = processBO.getInternalAlert();
					String externalAlert = processBO.getExternalAlert();
					if(internalAlert != null)
						contactAlertList.add(internalAlert);
					if(externalAlert != null)
						contactAlertList.add(externalAlert);
					if(contactAlertList.size() > 0) {
						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: ContactBOHook postWrite() Process completion triggering AlertListsize > 0");

						nv1.setName("BO");
						nv1.setValue("ContactBO");

						nv2.setName("BOid");
						nv2.setValue(iboID);

						nv3.setName("contactAlertList");
						nv3.setValue(contactAlertList);

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

						/*nv[0] = nv1;
						nv[1] = nv2;
						nv[2] = nv3;
						//nv[3]-is used for arrChangedAlertAttribs,so its not set here to avoid conflict
						nv[4] = nv4;
						nv[5] = nv5;*/

						alertNV = new NameValue[8];
						alertNV[0] = nv1;
						alertNV[1] = nv2;
						alertNV[2] = nv3;
						//alertNV[3]-is used for arrChangedAlertAttribs,so its not set here to avoid conflict
						alertNV[4] = nv4;
						alertNV[5] = nv5;
						alertNV[6] = nv6;//to set assigneeid
						alertNV[7] = nv7;//to set owner

						NameValue nvAlert = new NameValue();
						nvAlert.setName("alert");
						nvAlert.setValue(alertNV);

						mergedNV = new NameValue[2];
						mergedNV[0] = nvAlert;
						mergedNV[1] = null;

						boolean queueStatus = new CRMAlert().insertToAlertProcessingQueue(bc, mergedNV, "CRM", bankID);
						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: ContactBOHook postWrite() Process completion triggering queueStatus"+queueStatus);
				}
				}
					WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: ContactBOHook postWrite() Process completion triggering ends");
			}

			}

//			 *************************Alert Server Changes End *********************
		} catch (Exception e) {
			WebAdaptor.log(com.infy.cis.log.LogType.MINOR,"Alertserver: ContactBOHook postWrite() Exception::"+e.getMessage());
		}

	/**** Alert server recon to 10.2.14 End    Tracker ID 378548 ****/
		//Alert server recon to 10.2.14 ends
	   // customized implementation place holder
/* CRM61SR:SREVNTBO:TRACKER# 44228 **BEGIN  CHANGES** */

/*	try{

		ContactBO boContact = (ContactBO)bo;
		Integer ContactId = boContact.getContactID();
		String sEventFor = "Contact";
		String sEventType = "DOB";
		Date dEventDate = boContact.getDOB();
		if(dEventDate != null){
			String sEventDesc = "Date of Birth";
			boolean bEditable = false;
			Core.CreateNewEvent(bc,sEventFor,ContactId,sEventType,dEventDate,sEventDesc,bEditable);
		}
		}catch(Exception e){
		throw new SRMPostWriteException(SRMPostWriteException.ERROR_EVENT_WRITEFAILURE,e);
		}*/

 /* CRM61SR:SREVNTBO:TRACKER# 44228 **END OF CHANGES** */
   //ContactBO abo = (ContactBO)bo;

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





