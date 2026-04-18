/******************************************************************************
* Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
*
* $Workfile: CorporateBOHook.java $
*
* Author:
*
* $Archive:
*
* *********************************** */


package com.infy.cis.custom;

//fix for PAF build issue
import com.infy.cis.common.Address;
//fix for PAF build issue
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
import com.infy.cis.srmbo.CorporateBO;
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.finacle.crypt.MsgDigest;

import com.infy.cis.srmbo.SRMCollection;
import java.util.Date;
import java.util.Properties;
import com.infy.cis.exception.SRMSecurityException;
import com.infy.cis.srmbo.AttrAccValidator;
import com.infy.cis.srmbo.IHooks;
/* AdressLine changes: START */
import com.infy.cis.srmbo.CorporateBO;
import com.infosys.insulate.util.HashMap;
import com.infy.cis.exception.*;
import com.infy.cis.srmbo.SRMCollection;
/* AdressLine changes: END */
import com.infy.cis.srmbo.SRMBase;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.srmbo.Cif;
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
import com.infy.cis.bus.client.JMSClient;



public class CorporateBOHook implements IHooks {

    public CorporateBOHook() { }
/** CRM9.5 to CRM10.1  CIF - EBanking changes recon Start*/ //TrackerID: 97236
    //public String  eBankFlag;
      public String eBankFlag="";

/** CRM9.5 to CRM10.1  CIF - EBanking changes recon End*/

    final public void preWrite(final SRMBusinessContext
    aBusiContxt, final Object aBoObj)
    throws SRMPreWriteException, SRMSecurityException {
        try {
            AttrAccValidator.validatecreate((SRMBase) aBoObj);
        } catch (SRMSecurityException e) {
            throw new SRMSecurityException(
                SRMSecurityException.ERROR_ATTR_MASK, null);
        }








       /* AdressLine changes: START */
		CorporateBO boCorp = (CorporateBO)aBoObj;
		HashMap addDetails = null;
		HashMap addLines = null;

		/* 10.1 RECON Changes by mukundhan_santhanam (79625)*/
		try{
			 // Change as a part of tracker 205344 Starts
			   SRMCollection corpAddrColl       = boCorp.getAddress();
			   /* changes for ticket 361046 start */
			   if(corpAddrColl != null){
			   int addrSize = corpAddrColl.size();
			   for (int i =0;i<addrSize;i++) {
					   CorporateBO.Address corpAddr = (CorporateBO.Address)corpAddrColl.get(i);
					   //Changes for call id 404169-recon of 402928 starts
					   corpAddr.setSalutation("M/S");
					   //Changes for call id 404169-recon of 402928 ends

			   }
		   }
		   /* changes for ticket 361046 end */
			   // Change as a part of tracker 205344 Ends

		/** CRM9.5 to CRM10.1  recon Start uday*/
		   if(boCorp.getEntity_Type().equals("Customer"))
			{
				CheckExternalSystemFields checkEBankingFields=new CheckExternalSystemFields();
				eBankFlag=checkEBankingFields.checkChangedFields(aBusiContxt,boCorp);
				if(eBankFlag.equals("C")){
					boCorp.setAlreadyCreatedInEBanking("Y");
				}
			}
			else
			{
				eBankFlag = "N";
			}
		}catch(Exception e){
			ExceptThrow.Throw(new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, e));
		}
	 	/** CRM9.5 to CRM10.1  recon End uday*/
		// End of 10.1 RECON Changes

		if (boCorp.getAddress() != null) {
			SRMCollection addrColl = boCorp.getAddress();
			CorporateBO.Address address = null;
			/*Changes for Ticketid:-317790 Start:-Changes for adding swift add Start date*/
			Date currSwiftDate = SRMDate.getGMT();
			/*Changes for Ticketid:-317790 End*/
			for (int i = 0; i < addrColl.size(); ++i) {
				addDetails = new HashMap();
				address = (CorporateBO.Address)addrColl.get(i);
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
					/*Changes for Ticketid:-317790 Start:-Changes for adding swift add Start date*/
					if(address.getAddressCategory().equalsIgnoreCase("Swift")){
						address.setStart_Date(currSwiftDate);
						address.setEnd_Date(new Date("12/31/2099"));
					}
					/*Changes for Ticketid:-317790 End*/
				}
				catch(SRMTypeValidatorException typeException){
				}
			}
		}
/* AdressLine changes: END */



		/*Changes for Setting Escalation Due Time*/
		String sRating =boCorp.getSegment();
		try{
			if(sRating != null)	{
				if( sRating.equals("Gold") ){
					boCorp.setSLALevel("SLA5");
				}
				else if( sRating.equals("Silver") ){
					boCorp.setSLALevel("SLA4");
				}
				else if( sRating.equals("High net worth") ){
					boCorp.setSLALevel("SLA3");
				}
				else if( sRating.equals("Class A") ){
					boCorp.setSLALevel("SLA2");
				}
				else{
					boCorp.setSLALevel("SLA1");
				}
			}
			else{
						boCorp.setSLALevel("SLA1");
			}
		}catch(Exception ex)
			{
				ex.printStackTrace();
			}



		Date dDueDate = null;
		try{
			dDueDate = boCorp.getDueDate();
			if(dDueDate == null){
				boCorp.setStartDate( SRMDate.getGMT() );
				dDueDate = Cif.setDueDate(aBusiContxt, boCorp,"Corporate");
			}
		}
		catch(Exception e){
			}
		try{
		Integer iProcessid = boCorp.getProcessID();
		Integer iStepKey = boCorp.getCurrentStep();
		Integer iEscMatID = null;
		Integer iProcEscMatID = null;
		ProcessBO processBO = null;
		Integer iOwnerID = null;
		Integer iLocnID		= null;
		Integer iGroupID 	= null;
		String tat[] = new String[2];
		String proctat[] = new String[2];
		iOwnerID 			= boCorp.getOwner_User_ID();
		iLocnID				= boCorp.getOwnedLocationID();
		iGroupID			= boCorp.getOwnerGroup();
		int iTat=0;
		int iprocTat=0;
		boolean isFirstStep = false;
		Date iCurrStepDueDate	= boCorp.getCurrentStepDueDate();
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
			if(iEscMatID!=null){
			aTatArray = getEscTatDuration(aBusiContxt, iEscMatID, boCorp.getCorp_ID(),"Corporate");
			}
			if(iProcEscMatID!=null){
			aProcTatArray = getEscTatDuration(aBusiContxt, iProcEscMatID, boCorp.getCorp_ID(),"Corporate");
			}
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
				Date tempStepDueDate = asgen.findDueDate(sAvailString, iTat, sUnit, iCurrStepDueDate);
				//Date tempStepDueDate = asgen.findDueDate(sAvailString, iTat, sUnit);
				String          strDate = tempStepDueDate.toGMTString(); 
                strDate = strDate.replaceFirst("GMT",""); 
                Date  strdate= new Date(strDate); 
				boCorp.setEsc_Due_time(strdate);

			}


			if (proctat[0] != null && !(proctat[0].equals("null")) && (isFirstStep)){
				iprocTat = Integer.parseInt(proctat[0]);
				String sprocUnit = proctat[1];
				ASGenerator asprocgen = new ASGenerator();
				String sProcAvailString = Utils.getAvailString(aBusiContxt, iOwnerID, iLocnID, iGroupID);
				Date tempDueDate = asprocgen.findDueDate(sProcAvailString, iprocTat, sprocUnit, dDueDate);
				//Date tempDueDate = asprocgen.findDueDate(sProcAvailString, iprocTat, sprocUnit);
				String          strDate = tempDueDate.toGMTString(); 
                strDate = strDate.replaceFirst("GMT",""); 
                Date  strdate= new Date(strDate);
				boCorp.setProcEscDuetime(strdate);

					}

		}
	}catch(Exception e){
		e.printStackTrace();
		}
	/*Changes for Setting Escalation Due Time*/



   // Changes for CheckSum : Start
   try
   {
             /** CRM9.5 to CRM10.1  recon Start*/
	       if(boCorp.getEntity_Type().equals("Customer"))
			{
        		CheckExternalSystemFields checkEBankingFields=new CheckExternalSystemFields();
        		eBankFlag=checkEBankingFields.checkChangedFields(aBusiContxt,boCorp);
 				if(eBankFlag.equals("C")){
 					boCorp.setAlreadyCreatedInEBanking("Y");
				}
			}
			else
			{
				eBankFlag = "N";
			}
	 /** CRM9.5 to CRM10.1  recon End*/

	//Check for Checksum enable flag
	final Properties keyProp = EditorUtil.getCIFGeneralInfo();
	String chkEnFlag1 = keyProp.getProperty(EditorUtil.CHECKSUM_ENABLE);
	String chkEnFlag = "false";
	if (chkEnFlag1 != null) {
	chkEnFlag = chkEnFlag1.trim();
	}
	if (chkEnFlag.equalsIgnoreCase("True")) {

	final CorporateBO aBoCorp  =  (CorporateBO) aBoObj;
    // Changes for CheckSum : Greety
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
   	 CorporateBO.Address newAddr = null;
	 final SRMCollection addNew = aBoCorp.getAddress();
	 for (int i = 0; i < addNew.size(); ++i)
	 {
		 newAddr = (CorporateBO.Address) addNew.get(i);
		 final String newAddrType = newAddr.getAddressCategory();
		 if (!newAddrType.equalsIgnoreCase("Registered"))
		 {continue;
		 }
    	 final Date strtDate = newAddr.getStart_Date();
		 final Date endDate = newAddr.getEnd_Date();
		 final Date today = new Date();
		 /*TRACKER 104007 changes*/
		 if(strtDate==null || endDate==null ){
			  continue;
		 }/*TRACKER 104007 changes*/
		  // To calculate checksum when start date is today
		  boolean fToday = true;
		  if(today.getYear() == strtDate.getYear() &&
			 today.getMonth() == strtDate.getMonth() &&
			 today.getDate() == strtDate.getDate()){
					fToday = false;
				}
		 if(fToday)
		 if (!(today.after(strtDate) && today.before(endDate)))
		 {
			 continue;
		 }
		 aString[4] = newAddr.getCity();
		 aString[5] = newAddr.getZip();
	 }
	 for(int i = 1; i<= 5;i++){
		 if (aString[i] == null){
		 aString[i] = "";
	     }
	 }
	 // Input String to CheckSum API : CORPORATEBO
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
	 {ExceptThrow.Throw(
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

/** CRM9.5 to CRM10.1  CIF - EBanking changes recon Start*/ //TrackerID: 97236
 		CorporateBO corpBO = (CorporateBO)aBoObj;
		if(eBankFlag.equals("C") || eBankFlag.equals("E"))
		{
	 			String id = ClientName.CRMQD;
				String root = System.getProperty("SIMPLERM_ROOT");
				JMSClient cl = new JMSClient(id, root);
				NameValue[] nv = {new NameValue("cifId", corpBO.getCorp_ID()),new NameValue("cifType", "Corporate"),new NameValue("modifyFlag",eBankFlag)};
				com.infy.cis.common.message.Message msg =
   				new com.infy.cis.common.message.Message();
 			    msg.setNV(nv);
 			    try
 			    {
                	cl.send(id,             // sender id
			  				Address.CRMQD, // destination
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
/** CRM9.5 to CRM10.1  CIF - EBanking changes recon End*/
		// changes by vikas starts for IBK
		
		try {
			Properties genProp = EditorUtil.getCIFGeneralInfo();
			String syncUpFlag = genProp.getProperty(EditorUtil.CIFSYNCUP).trim();
			if(syncUpFlag.equalsIgnoreCase("TRUE")){
				CIFSyncData.syncCorporate(aBusiContxt, corpBO);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//System.out.println("Inside CorporateBOHook.CIFSyncData..catch block..exception.message.."+e.getMessage());
			e.printStackTrace();
		}
		// changes by vikas ends for IBK

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









