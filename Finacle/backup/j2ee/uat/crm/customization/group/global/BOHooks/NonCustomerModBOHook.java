/******************************************************************************
* Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
*
* $Workfile: NonCustomerModBOHook.java $
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
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.SRMBase;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;

// AdressLine changes: START  */
import com.infosys.insulate.util.HashMap;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.exception.SRMTypeValidatorException;
// AdressLine changes: END
import com.infy.cis.common.EditorUtil;
import com.infy.cis.exception.CISContextException;
import com.infy.cis.exception.SRMBOException;
import com.infy.cis.exception.SRMTypeValidatorException;
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.cis.srmbo.NonCustomerModBO;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.SRMDataObject;
import com.infy.finacle.crypt.MsgDigest;
import java.util.Date;
import java.util.Properties;
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


public class NonCustomerModBOHook implements IHooks {

    public NonCustomerModBOHook() { }

    final public void preWrite(final SRMBusinessContext
    aBusiContxt, final Object aBoObj)
    throws SRMPreWriteException, SRMSecurityException {
        try {
            AttrAccValidator.validatecreate((SRMBase) aBoObj);
        } catch (SRMSecurityException e) {
            throw new SRMSecurityException(
                SRMSecurityException.ERROR_ATTR_MASK, null);
        }

        /* Changes for 'WFlow' POC -- start */
		String OrgKey= ((NonCustomerModBO)aBoObj).getOrgKey();
		Integer IntWFID = ((NonCustomerModBO)aBoObj).getIntWFID();
		boolean boChanged = false;
		if (IntWFID != null) {
			try {
				Integer OwnedUserID = ((NonCustomerModBO)aBoObj).getOwnedUserID();
				Integer AssignedTo = ((NonCustomerModBO)aBoObj).getAssignedTo();
				Integer AssignedToGrp = ((NonCustomerModBO)aBoObj).getAssignedToGroup();
				SRMQueryBuilder qbWF = QueryAssist.singleObjectQuery("WFlowBO",WFlowBO.INTWFLOWID);
				QueryAssist.addSimpleCondition(qbWF,
												"WFlowBO",
												WFlowBO.ENTITYID,
												IQuery.ComparisonOperation_EQ,
												OrgKey);
				QueryAssist.addSimpleCondition(qbWF,
												"WFlowBO",
												WFlowBO.ENTITYTYPE,
												IQuery.ComparisonOperation_EQ,
												"NonCustomers_Mod");
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
				WebAdaptor.log(com.infy.cis.log.LogType.DEBUG, "NonCustomerModBOHook : Exception in preWrite method "+e);
			}
		}
		/* Changes for 'WFlow' POC -- end */

       // AdressLine changes: START
	   		NonCustomerModBO boNonCustMod = (NonCustomerModBO)aBoObj;
	   		HashMap addDetails = null;
	   		HashMap addLines = null;
	   		if (boNonCustMod.getAddress() != null) {
	   			SRMCollection addrColl = boNonCustMod.getAddress();
	   			NonCustomerModBO.Address address = null;
	   			for (int i = 0; i < addrColl.size(); ++i) {
	   				addDetails = new HashMap();
	   				address = (NonCustomerModBO.Address)addrColl.get(i);
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
	   					address.setAddress_Line1(address.getAddress_Line1());//Fix for ticket 325174

	   				}
	   				catch(SRMTypeValidatorException typeException){
	   					//System.out.println("typeException="+typeException);
	   				}
	   			}
	   		}
// AdressLine changes: END


/*Changes for Setting Duedate*/

		Date dDueDate = null;
		try{
			boNonCustMod.setSLALevel("SLA1");
			dDueDate = boNonCustMod.getDueDate();
			if(dDueDate == null){
				boNonCustMod.setStartDate( SRMDate.getGMT() );
				dDueDate = Cif.setDueDate(aBusiContxt, boNonCustMod,"NonCustomerMod");
			}
		}
		catch(Exception e){
			}
		try{
		Integer iProcessid = boNonCustMod.getProcessId();
		Integer iStepKey = boNonCustMod.getCurrentStep();
		Integer iEscMatID = null;
		Integer iProcEscMatID = null;
		ProcessBO processBO = null;
		Integer iOwnerID = null;
		Integer iLocnID		= null;
		Integer iGroupID 	= null;
		String tat[] = new String[2];
		String proctat[] = new String[2];
		iOwnerID 			= boNonCustMod.getOwnedUserID();
		iLocnID				= boNonCustMod.getOwnedLocationID();
		iGroupID			= boNonCustMod.getOwnerGroup();
		int iTat=0;
		int iprocTat=0;
		boolean isFirstStep = false;
		Date iCurrStepDueDate	= boNonCustMod.getCurrentStepDueDate();
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
			aTatArray = getEscTatDuration(aBusiContxt, iEscMatID, boNonCustMod.getNonCustomerID(),"NonCustomerMod");
			aProcTatArray = getEscTatDuration(aBusiContxt, iProcEscMatID, boNonCustMod.getNonCustomerID(),"NonCustomerMod"); //10.1 Recon change by 79625
			for( int i = 0; i < aTatArray.size(); i++){
				tat[i] = aTatArray.get( i ).toString();
			}


			for( int i = 0; i < aProcTatArray.size(); i++){
				proctat[i] = aProcTatArray.get( i ).toString();
			}

			if (tat[0] != null && !(tat[0].equals("null"))){//10.1 Recon change by 79625
				iTat = Integer.parseInt(tat[0]);
				String sUnit = tat[1];
				ASGenerator asgen = new ASGenerator();
				String sAvailString = Utils.getAvailString(aBusiContxt, iOwnerID, iLocnID, iGroupID);
				Date tempStepDueDate = asgen.findDueDate(sAvailString, iTat, sUnit, iCurrStepDueDate);
				//recon for ticket 324993 starts
				 String          strDate = tempStepDueDate.toGMTString();
                 strDate = strDate.replaceFirst("GMT","");
                 Date  strdate = new Date(strDate);
                 boNonCustMod.setEsc_Due_time(strdate);
               //recon for ticket 324993 ends


			}


			if (proctat[0] != null && !(proctat[0].equals("null")) && (isFirstStep)){//10.1 Recon change by 79625
				iprocTat = Integer.parseInt(proctat[0]);
				String sprocUnit = proctat[1];
				ASGenerator asprocgen = new ASGenerator();
				String sProcAvailString = Utils.getAvailString(aBusiContxt, iOwnerID, iLocnID, iGroupID);
				Date tempDueDate = asprocgen.findDueDate(sProcAvailString, iprocTat, sprocUnit, dDueDate);
				//Recon for ticket 331260 begins
				//boNonCustMod.setProcEscDuetime(tempDueDate);
				 boNonCustMod.setProcEscDuetime(SRMDate.getGMTFromServerDate(tempDueDate));

				 //Recon for ticket 331260 ends

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

	final NonCustomerModBO aBoNonCust = (NonCustomerModBO) aBoObj;
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
		final NonCustomerModBO.Ident_Details identNew  =
			 (NonCustomerModBO.Ident_Details) idDetNew.get(i);
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
					//break;
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




