/******************************************************************************
* Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
*
* $Workfile: AccountModBOHook.java $
*
* Author:
*
* $Archive:
*
* *********************************** */


package com.infy.cis.custom;

import com.infy.cis.adaptor.web.WebAdaptor;
import com.infy.cis.common.EditorUtil;
import com.infy.cis.exception.CISContextException;
import com.infy.cis.exception.SRMBOException;
import com.infy.cis.exception.SRMTypeValidatorException;
import com.infy.cis.exception.SRMPostDeleteException;
import com.infy.cis.exception.SRMPostFillException;
import com.infy.cis.exception.SRMPostWriteException;
import com.infy.cis.exception.SRMPreDeleteException;
import com.infy.cis.exception.SRMPreFillException;
import com.infy.cis.exception.SRMPreWriteException;

import com.infy.cis.exception.SRMSecurityException;
import com.infy.cis.srmbo.AccountModBO;
import com.infy.cis.srmbo.Core;
import com.infy.cis.srmbo.WFlowBO; //Changes for 'WFlow' POC
import com.infy.cis.srmbo.AttrAccValidator;
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.SRMBase;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
/* AdressLine changes: START */
import com.infosys.insulate.util.HashMap;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.exception.SRMTypeValidatorException;
/* AdressLine changes: END */
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.srmbo.SRMQueryResult;
import com.infy.cis.srmbo.SRMRecordSet;
import com.infy.cis.srmbo.SRMQueryBuilder;
import com.infy.cis.srmbo.IQuery;
import com.infy.cis.ui.common.QueryAssist;

import com.infy.finacle.crypt.MsgDigest;
import java.util.Date;
import com.infosys.insulate.util.HashMap;
import java.util.Properties;
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



public class AccountModBOHook implements IHooks {

    public AccountModBOHook() { }

    final public void preWrite(final SRMBusinessContext
    aBusiContxt, final Object aBoObj)
    throws SRMPreWriteException, SRMSecurityException {
		try {

			/* Changes for 'WFlow' POC -- start */
			String AcctKey= ((AccountModBO)aBoObj).getAccountKey();
			Integer IntWFID = ((AccountModBO)aBoObj).getIntWFID();
			boolean boChanged = false;
			if (IntWFID != null) {
				try {
					Integer OwnedUserID = ((AccountModBO)aBoObj).getOwnedUserID();
					Integer AssignedTo = ((AccountModBO)aBoObj).getAssignedTo();
					Integer AssignedToGrp = ((AccountModBO)aBoObj).getAssignedToGroup();
					SRMQueryBuilder qbWF = QueryAssist.singleObjectQuery("WFlowBO",WFlowBO.INTWFLOWID);
					QueryAssist.addSimpleCondition(qbWF,
													"WFlowBO",
													WFlowBO.ENTITYID,
													IQuery.ComparisonOperation_EQ,
													AcctKey);
					QueryAssist.addSimpleCondition(qbWF,
													"WFlowBO",
													WFlowBO.ENTITYTYPE,
													IQuery.ComparisonOperation_EQ,
													"Accounts_Mod");
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
					WebAdaptor.log(com.infy.cis.log.LogType.DEBUG, "AccountModBOHook : Exception in preWrite method "+e);
				}
			}
			/* Changes for 'WFlow' POC -- end */


			/*Changes For setting due date */

			AccountModBO boAccountMod = (AccountModBO)aBoObj;

			String sRating =boAccountMod.getSegmentation_Class();


				try{
					if(sRating != null)	{
						if( sRating.equals("GOLD") ){
							boAccountMod.setSLALevel("SLA5");
						}
						else if( sRating.equals("SILV") ){
							boAccountMod.setSLALevel("SLA4");
						}
						else if( sRating.equals("HNW") ){
							boAccountMod.setSLALevel("SLA3");
						}
						else if( sRating.equals("CLSA") ){
							boAccountMod.setSLALevel("SLA2");
						}
						else{
							boAccountMod.setSLALevel("SLA1");
						}
					}
					else{
								boAccountMod.setSLALevel("SLA1");
					}
				}catch(Exception ex)
					{
						ex.printStackTrace();
					}



				Date dDueDate = null;
				try{
					dDueDate = boAccountMod.getDueDate();
					if(dDueDate == null){
						boAccountMod.setStartDate( SRMDate.getGMT() );
						dDueDate = Cif.setDueDate(aBusiContxt, boAccountMod,"AccountMod");
					}
				}
				catch(Exception e){
					}
				try{

				Integer iProcessid = boAccountMod.getProcessID();
				Integer iStepKey = boAccountMod.getCurrentStep();
				Integer iEscMatID = null;
				Integer iProcEscMatID = null;
				ProcessBO processBO = null;
				Integer iOwnerID = null;
				Integer iLocnID		= null;
				Integer iGroupID 	= null;
				String tat[] = new String[2];
				String proctat[] = new String[2];
				iOwnerID 			= boAccountMod.getOwnedUserID();
				iLocnID				= boAccountMod.getOwnedLocationID();
				iGroupID			= boAccountMod.getOwnerGroup();
				int iTat=0;
				int iprocTat=0;
				boolean isFirstStep = false;
				Date iCurrStepDueDate	= boAccountMod.getCurrStepDueDate();
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
					if(iEscMatID!=null)
					aTatArray = getEscTatDuration(aBusiContxt, iEscMatID, boAccountMod.getAccountID(),"AccountMod");
					if(iProcEscMatID != null)
					aProcTatArray = getEscTatDuration(aBusiContxt, iProcEscMatID, boAccountMod.getAccountID(),"AccountMod");
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
						/* Fix for recon TrackerId 303062 : begin */
						/* Fix for CallId 272575 : begin */
						int offset = - iCurrStepDueDate.getTimezoneOffset();
						iCurrStepDueDate.setMinutes(iCurrStepDueDate.getMinutes() + offset);
						Date tempStepDueDate = asgen.findDueDate(sAvailString, iTat, sUnit, iCurrStepDueDate);
						//boAccountMod.setEsc_Due_time(SRMDate.getGMTFromServerDate(tempStepDueDate));
						//recon for ticket 324993 starts
						String          strDate = tempStepDueDate.toGMTString();
                        strDate = strDate.replaceFirst("GMT","");
                        Date  strdate= new Date(strDate);
                        boAccountMod.setEsc_Due_time(strdate);
                        //recon for ticket 324993 ends
						boAccountMod.setCurrStepDueDate(SRMDate.getGMTFromServerDate(iCurrStepDueDate));
						/* Fix for CallId 272575 : end */
						/* Fix for recon TrackerId 303062 : end */
					}


					if (proctat[0] != null && !(proctat[0].equals("null")) && (isFirstStep)){
						iprocTat = Integer.parseInt(proctat[0]);
						String sprocUnit = proctat[1];
						ASGenerator asprocgen = new ASGenerator();
						String sProcAvailString = Utils.getAvailString(aBusiContxt, iOwnerID, iLocnID, iGroupID);
						Date tempDueDate = asprocgen.findDueDate(sProcAvailString, iprocTat, sprocUnit, dDueDate);

						//fix for ticket 600943 starts
						String          strDate = tempDueDate.toGMTString();
                        strDate = strDate.replaceFirst("GMT","");
                        Date  strdate= new Date(strDate);
                        boAccountMod.setProcEscDuetime(strdate);
						  // fix for ticket 600943 ends

					}



				}
			}catch(Exception e){
				e.printStackTrace();
				}
		/*Changes for setting duedate */




            AttrAccValidator.validatecreate((SRMBase) aBoObj);
        } catch (SRMSecurityException e) {
            throw new SRMSecurityException(
                SRMSecurityException.ERROR_ATTR_MASK, null);
        }
/* AdressLine changes: START */
		AccountModBO boAccountMod = (AccountModBO)aBoObj;
		HashMap addDetails = null;
		HashMap addLines = null;
		if (boAccountMod.getAddress() != null) {
			SRMCollection addrColl = boAccountMod.getAddress();
			AccountModBO.Address address = null;
			/*Changes for Ticketid:-317790 Start
			Changes for adding swift address start and end date*/
			Date startSwiftDate = SRMDate.getGMT();
			/*Changes for Ticketid:-317790 End*/

			for (int i = 0; i < addrColl.size(); ++i) {
				addDetails = new HashMap();
				address = (AccountModBO.Address)addrColl.get(i);

				try{
					if((address.getPreferredFormat()!=null) && address.getPreferredFormat().equals("STRUCTURED_FORMAT")){
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
					/*Changes for Ticketid:-317790 Start
					Changes for adding swift address start and end date*/
					if(address.getAddressCategory().equalsIgnoreCase("Swift")){
						address.setStart_Date(startSwiftDate);
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
	final AccountModBO boAccount = (AccountModBO) aBoObj;
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
	  AccountModBO.Address newAddr = (AccountModBO.Address) addNew.get(iFor);
	  final String newAddrType = newAddr.getAddressCategory();
	  if (!newAddrType.equalsIgnoreCase("Mailing"))
	  { continue;
	  }
	  final Date strtDate = newAddr.getStart_Date();
	  final Date endDate = newAddr.getEnd_Date();
	  final Date today = new Date();
	  if(strtDate==null || endDate==null ){
		 continue;
	  }
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
	 // Input String to CheckSum API : AccountModBO
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





