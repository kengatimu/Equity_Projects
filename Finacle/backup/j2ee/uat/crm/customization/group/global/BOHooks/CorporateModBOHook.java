/******************************************************************************
* Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
*
* $Workfile: CorporateModBOHook.java $
*
* Author:
*
* $Archive:
*
* *********************************** */


package com.infy.cis.custom;
		//changes for tracker 336344
import java.util.concurrent.ConcurrentHashMap;
import com.infy.cis.exception.SRMPostDeleteException;
import com.infy.cis.exception.SRMPostFillException;
import com.infy.cis.exception.SRMPostWriteException;
import com.infy.cis.exception.SRMPreDeleteException;
import com.infy.cis.exception.SRMPreFillException;
import com.infy.cis.exception.SRMPreWriteException;
import com.infy.cis.common.EditorUtil;
import com.infy.cis.exception.CISContextException;
import com.infy.cis.exception.SRMBOException;
import com.infy.cis.exception.SRMTypeValidatorException;
import com.infy.cis.srmbo.CorporateModBO;
import com.infy.cis.srmbo.WFlowBO; //Changes for 'WFlow' POC
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.finacle.crypt.MsgDigest;
import com.infy.cis.srmbo.SRMCollection;
import java.util.Date;
import java.util.Properties;

import com.infy.cis.exception.SRMSecurityException;
import com.infy.cis.srmbo.AttrAccValidator;
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.SRMBase;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;

/* AdressLine changes: START */
import com.infy.cis.srmbo.CorporateModBO;
import com.infosys.insulate.util.HashMap;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.exception.SRMTypeValidatorException;
/* AdressLine changes: END */
import com.infy.cis.srmbo.Cif;
import com.infy.cis.srmbo.*;
import com.infy.cis.common.*;
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


public class CorporateModBOHook implements IHooks {

    public CorporateModBOHook() { }

    final public void preWrite(final SRMBusinessContext
    aBusiContxt, final Object aBoObj)
    throws SRMPreWriteException, SRMSecurityException {
        try {



			/* Changes for 'WFlow' POC -- start */
			String CorpKey= ((CorporateModBO)aBoObj).getCorp_Key();
			Integer IntWFID = ((CorporateModBO)aBoObj).getIntWFID();
			boolean boChanged = false;
			if (IntWFID != null) {
				try {
					Integer OwnedUserID = ((CorporateModBO)aBoObj).getOwner_User_ID();
					Integer AssignedTo = ((CorporateModBO)aBoObj).getAssigned_User_ID();
					Integer AssignedToGrp = ((CorporateModBO)aBoObj).getAssigned_Group_ID();
					SRMQueryBuilder qbWF = QueryAssist.singleObjectQuery("WFlowBO",WFlowBO.INTWFLOWID);
					QueryAssist.addSimpleCondition(qbWF,
													"WFlowBO",
													WFlowBO.ENTITYID,
													IQuery.ComparisonOperation_EQ,
													CorpKey);
					QueryAssist.addSimpleCondition(qbWF,
													"WFlowBO",
													WFlowBO.ENTITYTYPE,
													IQuery.ComparisonOperation_EQ,
													"Corporate_Mod");
					SRMQueryResult qrCount = qbWF.runQuery(aBusiContxt, true, -1);
					SRMRecordSet rs = qrCount.getRecordSet();
					if (rs.hasNext()) {
						WFlowBO Wfbo = (WFlowBO)(rs.getNext().get(0));

						if ((OwnedUserID != Wfbo.getOwnedUserId()) && (OwnedUserID != null)) {
							Wfbo.setOwnedUserId(OwnedUserID);
							boChanged = true;
						}

						if ((AssignedTo != Wfbo.getAssignedUserId()) && (AssignedTo != null)) {
							Wfbo.setAssignedUserId(AssignedTo);
							boChanged = true;
						}

						if ((AssignedToGrp != Wfbo.getAssignedGroupId()) && (AssignedToGrp != null)) {
							Wfbo.setAssignedGroupId(AssignedToGrp);
							boChanged = true;
						}

						if (boChanged == true) {
							Core.saveWFlowBO(aBusiContxt,Wfbo);
						}


					}
				} catch (Exception e) {
					WebAdaptor.log(com.infy.cis.log.LogType.DEBUG, "CorporateModBOHook : Exception in preWrite method "+e);
				}
			}
			/* Changes for 'WFlow' POC -- end */






            AttrAccValidator.validatecreate((SRMBase) aBoObj);
        } catch (SRMSecurityException e) {
            throw new SRMSecurityException(
                SRMSecurityException.ERROR_ATTR_MASK, null);
        }
   /* AdressLine changes: START */
   		CorporateModBO boCorpMod = (CorporateModBO)aBoObj;
   		HashMap addDetails = null;
   		HashMap addLines = null;
   		if (boCorpMod.getAddress() != null) {
   			SRMCollection addrColl = boCorpMod.getAddress();
   			CorporateModBO.Address address = null;
   			/*Changes for Ticketid:-317790 Start:-Changes for adding swift add Start date*/
   			Date currSwiftDate = SRMDate.getGMT();
   			/*Changes for Ticketid:-317790 End*/
   			for (int i = 0; i < addrColl.size(); ++i) {
   				addDetails = new HashMap();
   				address = (CorporateModBO.Address)addrColl.get(i);
   				try{
   					if(address.getPreferredFormat()!=null && address.getPreferredFormat().equals("STRUCTURED_FORMAT")){  /*TRACKER 105720 changes */
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
   					address.setAddress_Line1(address.getAddress_Line1());//Fix for ticket 325174

   					/*Changes for Ticketid:-317790 Start:-Changes for adding swift add Start date*/
   					if(address.getAddressCategory().equalsIgnoreCase("Swift")){
						address.setStart_Date(currSwiftDate);
						address.setEnd_Date(new Date("12/31/2099"));
					}
					/*Changes for Ticketid:-317790 End*/
   				}
   				catch(SRMTypeValidatorException typeException){
   					//System.out.println("typeException="+typeException);
   				}
   			}
   		}
/* AdressLine changes: END */



		/*Changes for Setting Escalation Due Time*/
		String sRating =boCorpMod.getSegment();
		try{
			if(sRating != null)	{
						if( sRating.equals("Gold") ){
							boCorpMod.setSLALevel("SLA5");
						}
						else if( sRating.equals("Silver") ){
							boCorpMod.setSLALevel("SLA4");
						}
						else if( sRating.equals("High net worth") ){
							boCorpMod.setSLALevel("SLA3");
						}
						else if( sRating.equals("Class A") ){
							boCorpMod.setSLALevel("SLA2");
						}
						else{
							boCorpMod.setSLALevel("SLA1");
						}
			}
			else{
						boCorpMod.setSLALevel("SLA1");
			}
		}catch(Exception ex)
			{
				ex.printStackTrace();
			}



		Date dDueDate = null;
		try{
			dDueDate = boCorpMod.getDueDate();
			if(dDueDate == null){
				boCorpMod.setStartDate( SRMDate.getGMT() );
				dDueDate = Cif.setDueDate(aBusiContxt, boCorpMod,"CorporateMod");
			}
		}
		catch(Exception e){
			}
		try{
		Integer iProcessid = boCorpMod.getProcessID();
		Integer iStepKey = boCorpMod.getCurrentStep();
		Integer iEscMatID = null;
		Integer iProcEscMatID = null;
		ProcessBO processBO = null;
		Integer iOwnerID = null;
		Integer iLocnID		= null;
		Integer iGroupID 	= null;
		String tat[] = new String[2];
		String proctat[] = new String[2];
		iOwnerID 			= boCorpMod.getOwner_User_ID();
		iLocnID				= boCorpMod.getOwnedLocationID();
		iGroupID			= boCorpMod.getOwnerGroup();
		int iTat=0;
		int iprocTat=0;
		boolean isFirstStep = false;
		Date iCurrStepDueDate	= boCorpMod.getCurrentStepDueDate();
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
			//Changes for tracker id 338371 Start
			if(iEscMatID!=null){
			aTatArray = getEscTatDuration(aBusiContxt, iEscMatID, boCorpMod.getCorp_Mod_ID(),"CorporateMod");
			}
			if(iProcEscMatID!=null){
			aProcTatArray = getEscTatDuration(aBusiContxt, iProcEscMatID, boCorpMod.getCorp_Mod_ID(),"CorporateMod");
			}
			//Changes for tracker id 338371 End
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
										String sAvailString = Utils.getAvailString(aBusiContxt, iOwnerID, iLocnID, iGroupID);
										/* Fix for recon TrackerID 303064 : begin */
										/* Fix for CallId 273106 : begin */
										//following changes where offsetting the esc_due_date which was not required
									//	int offset = - iCurrStepDueDate.getTimezoneOffset();
									//	iCurrStepDueDate.setMinutes(iCurrStepDueDate.getMinutes() + offset);
									//recon changes for ticket id 355252
										Date tempStepDueDate = asgen.findDueDate(sAvailString, iTat, sUnit, iCurrStepDueDate);
										/* Changes for ticket 325603 Start */
										   String s11 = tempStepDueDate.toGMTString();
										   s11 = s11.replaceFirst("GMT", "");
										   Date date7 = new Date(s11);
										   boCorpMod.setEsc_Due_time(date7);
										/* Changes for ticket 325603 End */

										//boCorpMod.setEsc_Due_time(SRMDate.getGMTFromServerDate(tempStepDueDate));
										boCorpMod.setCurrentStepDueDate(SRMDate.getGMTFromServerDate(iCurrStepDueDate));
										/* Fix for CallId 273106 : end */
										/* Fix for recon TrackerID 303064 : end */
									}


									if (proctat[0] != null && !(proctat[0].equals("null")) && (isFirstStep)){
										iprocTat = Integer.parseInt(proctat[0]);
										String sprocUnit = proctat[1];
										ASGenerator asprocgen = new ASGenerator();
										String sProcAvailString = Utils.getAvailString(aBusiContxt, iOwnerID, iLocnID, iGroupID);
										Date tempDueDate = asprocgen.findDueDate(sProcAvailString, iprocTat, sprocUnit, dDueDate);
										//boCorpMod.setProcEscDuetime(tempDueDate);
										/* Changes for ticket 331580 Start */
										    boCorpMod.setProcEscDuetime(SRMDate.getGMTFromServerDate(tempDueDate));

										/* Changes for ticket 331580 End */


			}

		}
	}catch(Exception e){
		e.printStackTrace();
		}
		/*Changes for Setting Escalation Due Time*/



// Changes for CheckSum : Start
 try
   {
	 String chkEnFlag1= null;
	//Check for Checksum enable flag
	//final Properties keyProp = EditorUtil.getCIFGeneralInfo();
	//String chkEnFlag1 = keyProp.getProperty(EditorUtil.CHECKSUM_ENABLE);
	/* changes for tracker 336344 start*/
	ConcurrentHashMap hmCifGenInfo = EditorUtil.getCIFGenInfo();
	if(hmCifGenInfo.get(EditorUtil.CHECKSUM_ENABLE) != null)
	 chkEnFlag1 = ((String)hmCifGenInfo.get(EditorUtil.CHECKSUM_ENABLE)).trim();
	/* 		//changes for tracker 336344 end */
	String chkEnFlag = "false";
	if (chkEnFlag1 != null) {
	chkEnFlag = chkEnFlag1.trim();
	}
	if (chkEnFlag.equalsIgnoreCase("True")) {

	final CorporateModBO aBoCorp  =  (CorporateModBO) aBoObj;
	String isTampered = aBoCorp.getIsTampered();
	if (isTampered == null) {
				isTampered = "";
		}
	if (!(isTampered.equals("Y"))) {
	 String[] aString = new String[6];
   	 //aString[0] =  aBoCorp.getCorp_ID().toString();
   	 aString[1] =  aBoCorp.getCorp_Key();
   	 aString[2] =  aBoCorp.getCorporate_Name();
   	 aString[3] =  aBoCorp.getStatus();
   	 CorporateModBO.Address newAddr = null;
	 final SRMCollection addNew = aBoCorp.getAddress();
	 for (int i = 0; i < addNew.size(); ++i)
	 {
		 newAddr = (CorporateModBO.Address) addNew.get(i);
		 final String newAddrType = newAddr.getAddressCategory();
		 if (!newAddrType.equalsIgnoreCase("Registered"))
		 {continue;
		 }
    	 final Date strtDate = newAddr.getStart_Date();
		 final Date endDate = newAddr.getEnd_Date();
		 final Date today = new Date();
		 /*TRACKER 105720 changes */
		 if(strtDate==null || endDate==null ){
			  continue;
		 }/*TRACKER 105720 changes */
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
		 aString[4] = newAddr.getCity();
		 aString[5] = newAddr.getZip();
	 }
	 for(int i = 1; i<= 5;i++){
		 if (aString[i] == null){
		 aString[i] = "";
	     }
	 }
	 // Input String to CheckSum API : CorporateModBO
	 StringBuffer chkSumCorp = new StringBuffer(256);
	 for(int iAppend = 1; iAppend <= 5 ; iAppend++)
	 {
		chkSumCorp.append(aString[iAppend]);
		chkSumCorp.append("|");
	 }
		 final String chkSumCalc1 = MsgDigest.getDigestToken(chkSumCorp.toString());
		 		aBoCorp.setIsTampered("N");

		 aBoCorp.setCheckSum(chkSumCalc1);
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
				if((sResult != null)){
					eMatBO = eTempMatBO;
					break;
				}
			}
			if((sResult != null)){
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




