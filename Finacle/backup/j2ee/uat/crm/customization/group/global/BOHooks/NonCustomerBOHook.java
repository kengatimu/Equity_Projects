/******************************************************************************
* Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
*
* $Workfile: NonCustomerBOHook.java $
*
* Author:
*
* $Archive:
*
* *********************************** */


package com.infy.cis.custom;

import com.infy.cis.exception.SRMPostDeleteException;
import com.infy.cis.exception.SRMPostFillException;
import com.infy.cis.exception.SRMPostWriteException;
import com.infy.cis.exception.SRMPreDeleteException;
import com.infy.cis.exception.SRMPreFillException;
import com.infy.cis.exception.SRMPreWriteException;

import com.infy.cis.exception.SRMSecurityException;
import com.infy.cis.srmbo.AttrAccValidator;
// AdressLine changes: START
import com.infy.cis.srmbo.NonCustomerBO;
import com.infosys.insulate.util.HashMap;
import com.infy.cis.exception.*;
import com.infy.cis.srmbo.SRMCollection;
// AdressLine changes: END
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.SRMBase;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;

import com.infy.cis.common.EditorUtil;
import com.infy.cis.exception.CISContextException;
import com.infy.cis.exception.SRMBOException;
import com.infy.cis.exception.SRMTypeValidatorException;
import com.infy.cis.srmbo.NonCustomerBO;
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.finacle.crypt.MsgDigest;
import com.infy.cis.srmbo.SRMCollection;
import java.util.Date;
import java.util.Properties;
import com.infy.cis.srmbo.Cif;
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

public class NonCustomerBOHook implements IHooks {

    public NonCustomerBOHook() { }

    final public void preWrite(final SRMBusinessContext
    aBusiContxt, final Object aBoObj)
    throws SRMPreWriteException, SRMSecurityException {
        try {
            AttrAccValidator.validatecreate((SRMBase) aBoObj);
        } catch (SRMSecurityException e) {
            throw new SRMSecurityException(
                SRMSecurityException.ERROR_ATTR_MASK, null);
        }
        // AdressLine changes: START
		NonCustomerBO boNonCust = (NonCustomerBO)aBoObj;
		HashMap addDetails = null;
		HashMap addLines = null;
		if (boNonCust.getAddress() != null) {
			SRMCollection addrColl = boNonCust.getAddress();
			NonCustomerBO.Address address = null;
			for (int i = 0; i < addrColl.size(); ++i) {
				addDetails = new HashMap();
				address = (NonCustomerBO.Address)addrColl.get(i);
				try{

					/* TRACKER ID: 165846 CHANGES BEGIN
					* This if condition is commented out because AddressLine fields
					* are required to have the values for mailing and other address also.
					*/
					//if(address.getAddressCategory().equals("SwiftAddress")){


					/* TRACKER ID: 165846 CHANGES BEGIN
					* This if condition was modified in reference with AccountBOHook.java
					*/
					if((address.getPreferredFormat()!=null) && address.getPreferredFormat().equals("STRUCTURED_FORMAT")){
					/* TRACKER ID: 165846 CHANGES END */
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
						//}/* TRACKER ID: 165846 CHANGES END */
					}
				}
				catch(SRMTypeValidatorException typeException){
					//System.out.println("typeException="+typeException);
				}
			}
		}

// AdressLine changes: END


/*Changes For setting Duedate*/
		Date dDueDate = null;
		try{
			boNonCust.setSLALevel("SLA1");
			dDueDate = boNonCust.getDueDate();
			if(dDueDate == null){
				boNonCust.setStartDate( SRMDate.getGMT() );
				dDueDate = Cif.setDueDate(aBusiContxt, boNonCust,"NonCustomer");
			}
		}
		catch(Exception e){
			}
		try{

		Integer iProcessid = boNonCust.getProcessId();
		Integer iStepKey = boNonCust.getCurrentStep();
		Integer iEscMatID = null;
		Integer iProcEscMatID = null;
		ProcessBO processBO = null;
		Integer iOwnerID = null;
		Integer iLocnID		= null;
		Integer iGroupID 	= null;
		String tat[] = new String[2];
		String proctat[] = new String[2];
		iOwnerID 			= boNonCust.getOwnedUserID();
		iLocnID				= boNonCust.getOwnedLocationID();
		iGroupID			= boNonCust.getOwnerGroup();
		int iTat=0;
		int iprocTat=0;
		boolean isFirstStep = false;
		Date iCurrStepDueDate	= boNonCust.getCurrentStepDueDate();
		int currentStepInt = 0;
		if(iStepKey !=null && !(iStepKey.equals(null)) && !(iStepKey.equals("")))
		currentStepInt = iStepKey.intValue();


		if (iProcessid != null && !(iProcessid.equals(null))) {
			processBO = Processes.findProcessBO(iProcessid, aBusiContxt);
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
			aTatArray = getEscTatDuration(aBusiContxt, iEscMatID, boNonCust.getNonCustomerID(),"NonCustomer");
			aProcTatArray = getEscTatDuration(aBusiContxt, iProcEscMatID, boNonCust.getNonCustomerID(),"NonCustomer"); //10.1 Recon Changes by 79625
			for( int i = 0; i < aTatArray.size(); i++){
				tat[i] = aTatArray.get( i ).toString();
			}
			for( int i = 0; i < aProcTatArray.size(); i++){
									proctat[i] = aProcTatArray.get( i ).toString();
								}
			if (tat[0] != null && !(tat[0].equals("null"))){//10.1 RECON Changes by 79625
				iTat = Integer.parseInt(tat[0]);
				String sUnit = tat[1];
				ASGenerator asgen = new ASGenerator();
				String sAvailString = Utils.getAvailString(aBusiContxt, iOwnerID, iLocnID, iGroupID);
				Date tempStepDueDate = asgen.findDueDate(sAvailString, iTat, sUnit, iCurrStepDueDate);
				String          strDate = tempStepDueDate.toGMTString();
                strDate = strDate.replaceFirst("GMT","");
                Date  strdate= new Date(strDate);
				boNonCust.setEsc_Due_time(strdate);

			}


			if (proctat[0] != null && !(proctat[0].equals("null")) && (isFirstStep)){//10.1 RECON Changes by 79625
				iprocTat = Integer.parseInt(proctat[0]);
				String sprocUnit = proctat[1];
				ASGenerator asprocgen = new ASGenerator();
				String sProcAvailString = Utils.getAvailString(aBusiContxt, iOwnerID, iLocnID, iGroupID);
				Date tempDueDate = asprocgen.findDueDate(sProcAvailString, iprocTat, sprocUnit, dDueDate);
				String          strDate = tempDueDate.toGMTString();
                strDate = strDate.replaceFirst("GMT","");
                Date  strdate= new Date(strDate);
				boNonCust.setProcEscDuetime(strdate);
			}

		}
	}catch(Exception e){
		e.printStackTrace();
		}
		/*Changes for Setting Escalation Due Time*/





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

 	final NonCustomerBO aBoNonCust = (NonCustomerBO) aBoObj;
 	String isTampered = aBoNonCust.getIsTampered();
 	if (isTampered == null) {
 				isTampered = "";
 		}
 	if (!(isTampered.equals("Y"))) {
 	String[] aString = new String[11];
 	//aString[0]  =  aBoNonCust.getNonCustomerID().toString();
 	aString[1]  =  aBoNonCust.getOrgKey();
 	aString[2]  =  aBoNonCust.getLast_Name();
 	aString[3]  =  aBoNonCust.getWork_premise_name();
 	aString[4]  =  aBoNonCust.getWork_town();
 	aString[5]  =  aBoNonCust.getWorkAddPinCode();
 	aString[6]  =  aBoNonCust.getEmployerName();
 	aString[7]  =  aBoNonCust.getOccupation();
 	if (aBoNonCust.getAnnualIncome() != null) {
 	aString[10]  =  aBoNonCust.getAnnualIncome().toString();}
 	else {aString[10] = ""; }
 	final SRMCollection idDetNew =  aBoNonCust.getIdent_Details();
 	final String drivLic = "Driving Licence";
 	final String passNum = "Passport Number";
 	final int idDetSize = idDetNew.size();
 	for (int i = 0; i < idDetSize ; ++i)
 	 {
 		final NonCustomerBO.Ident_Details identNew  =
 			 (NonCustomerBO.Ident_Details) idDetNew.get(i);
 		final String newIdentType  =  identNew.getIdentifierType();
 		if ((!(newIdentType.equalsIgnoreCase(drivLic)))    &&
 		   (!(newIdentType.equalsIgnoreCase(passNum))))
 		 {
 		 	continue;
 		 }
 		else if (newIdentType.equalsIgnoreCase(drivLic))   {
 				aString[8] =  identNew.getID();
 		 }
 		else if (newIdentType.equalsIgnoreCase(passNum))   {
 				aString[9] =  identNew.getID();
 		 }
 	 }
 	for(int i = 1; i<= 10;i++){
 		if (aString[i] == null){
 			aString[i] = "";
 		}
 	}
 	StringBuffer sChkSumNonCust = new StringBuffer(256);
 	for(int iAppend = 1; iAppend <= 10 ; iAppend++)
 	{
 		sChkSumNonCust.append(aString[iAppend]);
 		sChkSumNonCust.append("|");
 	}
 		final String chkSumCalc1 = MsgDigest.getDigestToken(sChkSumNonCust.toString());
 		aBoNonCust.setIsTampered("N");

 		aBoNonCust.setCheckSum(chkSumCalc1);

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
	//Changes for CheckSum : End
    }

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

    public void postWrite(final SRMBusinessContext aBusiContxt,
    final Object aBoObj)
    throws SRMPostWriteException {

                 /**** Alert server recon to 10.2.14 Start Tracker ID 378548 ****/
	//Alert server recon to 10.2.14 starts
    	try {
			NameValue[] alertNV = null;
			NameValue[] mergedNV = null;
			NameValue[] mergedNV1 = null;

			//String strIsAlertReq = EditorUtil.getAlertDetails();
			boolean isAlertReq = Boolean.parseBoolean(EditorUtil.getAlertDetails());
			WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: NonCustomerBOHook strIsAlertReq " +isAlertReq);
			//if ("true".equalsIgnoreCase(strIsAlertReq)) {
				if(isAlertReq){
				NonCustomerBO nonCustBO=(NonCustomerBO)aBoObj;
				String strRecordStatus = nonCustBO.getRecordStatus();
				WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: NonCustomerBOHook postWrite() RecordStatus="+strRecordStatus);
				NameValue[] nv = new NameValue[8];
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
				iboID = nonCustBO.getNonCustomerID();

				String bankID = (String)SRMTLVar.bank_id.get();
				/*Changes for getting changed values -Start*/
				aBusiContxt.setBank_id(bankID);
				/* Gets the list of attributes that are changed*/
				NonCustomerBO oldBO = (NonCustomerBO)Core.getBOClone(nonCustBO);
				/* Changes for 10.5 Alert Server Starts */
				Integer iProcessid = nonCustBO.getProcessId();
				String processStatus = nonCustBO.getProcessStatus();
				/* Changes for 10.5 Alert Server Ends */
				//Integer iAlertAssignee = nonCustBO.getAlertAssignedTo();
				Integer iAssignee = nonCustBO.getAssignedTo();
				Integer iOwner= nonCustBO.getOwnedUserID();

				/*
				 * If oldBO !=null it means Edit , else Create
				 * Alert Triggering needed  only for Edit.
				 */
				/* Changes for 10.5 Alert Server Starts */
				if(oldBO!=null && "A".equalsIgnoreCase(strRecordStatus) && (iProcessid == null || processStatus == null || processStatus == "")){
				/* Changes for 10.5 Alert Server Ends */
				WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: NonCustomerBOHook postWrite() CIF edit triggering starts");
					ArrayList arrChangedAlertAttribs = new CheckModifiedFields().getChangedAttributes(nonCustBO, aBusiContxt);

					/*Changes for getting changed values -End*/
					if(!arrChangedAlertAttribs.isEmpty()){
						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: NonCustomerBOHook postWrite() arrChangedAlertAttribs not empty");
						/*nv1 is used to set the BO Name*/
						nv1.setName("BO");
						nv1.setValue("NonCustomerBO");

						/*nv2 is used to set the BOId*/
						nv2.setName("BOid");
						nv2.setValue(iboID);

						/*nv3 is used to set the ID- this is an index used for identifying the entity
						 * 'ID = 0' mean its CUSTOMER*/
						nv3.setName("ID");
						nv3.setValue(3);

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

						boolean status = new CRMAlert().insertToAlertProcessingQueue(aBusiContxt, mergedNV1, "CRM", aBusiContxt.getBank_id());

						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: NonCustomerBOHook postWrite() CIF edit triggering queueStatus"+status);
					}
					WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: NonCustomerBOHook postWrite() CIF edit triggering ends");

				}

				/*Process Related Changes -Karthi*/
				/* Changes for 10.5 Alert Server Starts */
				//Integer iProcessid = nonCustBO.getProcessId();
				//String processStatus = nonCustBO.getProcessStatus();
				/* Changes for 10.5 Alert Server Ends */

				Properties keyProp = EditorUtil.getCIFGeneralInfo();
				String apprMech = keyProp.getProperty(EditorUtil.APPROVAL_MECHANISM);

				if("true".equals(apprMech)){
					NonCustomerModBO nonCustModBO = (NonCustomerModBO)Utils.getBOFromID( aBusiContxt, "NonCustomerModBO",NonCustomerModBO.ORGKEY, ""+ nonCustBO.getOrgKey(), false );
                    if(nonCustModBO != null)
					iProcessid = nonCustModBO.getProcessId();
				}

				/*Tracker id: 247549. CRM104BIT42 to Baseline - Recon Wave1 changes Begin. */
				//if(iProcessid != null && ((processStatus != null && "Closed".equals(processStatus))||"true".equals(apprMech))){
					/*
						This code has been modified since alert is not getting triggered for approval enbaled/disabled
						if the process status is not updated as CLOSED. This has been done after having the discussion with the alert server 10.3 team.
					*/
				if(iProcessid != null && ((processStatus == null || processStatus == ""  || "CLOSED".equalsIgnoreCase(processStatus)))||"true".equals(apprMech)){
				/*Tracker id: 247549. CRM104BIT42 to Baseline - Recon Wave1 changes Ends. */
					WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: NonCustomerBOHook postWrite() Process completion triggering starts");
					//Integer iAlertProcAssignee = nonCustBO.getAlertAssignedTo();
					if (isAlertReq){
					Integer iProcAssignee = oldBO.getAssignedTo();
					Integer iProcOwner= nonCustBO.getOwnedUserID();
					/*
					 *Getting internal and external alertids and putting inside nv
					 */
					ProcessBO processBO = Processes.findProcessBO(iProcessid, aBusiContxt);
					ArrayList nonCustAlertList = new ArrayList();
					String internalAlert = processBO.getInternalAlert();
					String externalAlert = processBO.getExternalAlert();
					if(internalAlert != null)
						nonCustAlertList.add(internalAlert);
					if(externalAlert != null)
						nonCustAlertList.add(externalAlert);
					if(nonCustAlertList.size() > 0) {
						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: NonCustomerBOHook postWrite() Process completion triggering AlertListsize > 0");

						nv1.setName("BO");
						nv1.setValue("NonCustomerBO");

						nv2.setName("BOid");
						nv2.setValue(iboID);

						nv3.setName("nonCustomerAlertList");
						nv3.setValue(nonCustAlertList);

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
						alertNV[6] = nv6;
						alertNV[7] = nv7;

						NameValue nvAlert = new NameValue();
						nvAlert.setName("alert");
						nvAlert.setValue(alertNV);

						mergedNV = new NameValue[2];
						mergedNV[0] = nvAlert;
						mergedNV[1] = null;

						boolean queueStatus = new CRMAlert().insertToAlertProcessingQueue(aBusiContxt, mergedNV, "CRM", aBusiContxt.getBank_id());
						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: NonCustomerBOHook postWrite() Process completion triggering queueStatus"+queueStatus);
				}
				}
				WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: NonCustomerBOHook postWrite() Process completion triggering ends");

			}
		}
	//			 *************************Alert Server Changes End -Abhilash_Mohandas,Suthyev_S*********************
			} catch (Exception e) {
				e.printStackTrace();
		}

	/**** Alert server recon to 10.2.14 End    Tracker ID 378548 ****/
	//Alert server recon to 10.2.14 ends
    }

    public void preDelete(final SRMBusinessContext aBusiContxt,
    final Object aBoObj)
    throws SRMPreDeleteException {
    }

    public void postDelete(final SRMBusinessContext aBusiContxt,
    final Object aBoObj)
    throws SRMPostDeleteException {
    }

    public void preFill(final SRMBusinessContext aBusiContxt,
    final Object aBoObj)
    throws SRMPreFillException {
    }

    public void postFill(final SRMBusinessContext aBusiContxt,
    final Object aBoObj)
    throws SRMPostFillException {
    }

}





