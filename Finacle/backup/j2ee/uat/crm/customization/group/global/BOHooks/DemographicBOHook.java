/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: DemographicBOHook.java $
 *
 * $Author: greety_varghese $
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/DemographicBOHook.java $
 *
 * $History: DemographicBOHook.java $
 *
 * *****************  Version 1  *****************
 * User: Raghunathrn  Date: 5/27/03    Time: 7:56p
 * Created in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 * Added for size check - tracker 52327
 *
 *****************************************************************************/
package  com.infy.cis.custom;

import  com.infosys.insulate.util.HashMap;
import  com.infy.cis.srmbo.IHooks;
import  com.infy.cis.srmbo.DemographicBO;
import  com.infy.cis.srmbo.SRMCollection;
import  com.infy.cis.srmbo.security.user.SRMBusinessContext;
import  com.infy.cis.exception.*;
import com.infy.cis.srmbo.SRMBase;
import com.infy.cis.srmbo.AttrAccValidator;
import com.infy.cis.common.EditorUtil;
import com.infy.cis.common.Address;
import com.infy.cis.common.ClientName;
import com.infy.cis.bus.client.JMSClient;
import com.infy.cis.common.NameValue;

import com.infy.cis.srmbo.DemographicBO;
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.finacle.crypt.MsgDigest;
import com.infy.cis.srmbo.SRMCollection;
import java.util.Date;
import java.util.Properties;


public class  DemographicBOHook
implements IHooks  {

    public String  eBankFlag;
/** CRM9.5 to CRM10.1  CIF - EBanking changes recon Start*/ //TrackerID: 97236
    public String flag="N";
    public String apprFlag;
/** CRM9.5 to CRM10.1  CIF - EBanking changes recon End*/

	public void preWrite (SRMBusinessContext bc, Object bo)
	throws SRMPreWriteException,SRMSecurityException{
		DemographicBO boDemo = (DemographicBO)bo;
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
		//Tracker:90196: Changes for attibute masking
				try {
					AttrAccValidator.validatecreate((SRMBase) bo);
				} catch(SRMSecurityException e) {
					throw new SRMSecurityException(SRMSecurityException.ERROR_ATTR_MASK, null) ;
				}
		//Tracker:90196: End of Changes

		HashMap custcfg = null;
		if (boDemo.getAccountID() != null)      custcfg = SizeUtil.getCustConfig ("CUSTOMER");
		else if (boDemo.getContactID() != null) custcfg = SizeUtil.getCustConfig ("CONTACT");
		else if (boDemo.getSuspectID() != null) custcfg = SizeUtil.getCustConfig ("PROSPECT");

		if (custcfg != null)  {
			try {
				SizeUtil.checkFieldSizes (boDemo, custcfg);
				SRMCollection miscColl = boDemo.getMiscellaneousInfo();
				if (miscColl != null) {
					DemographicBO.MiscellaneousInfo info = null;
					String parent = "DemographicBO";
					for (int i = 0; i < miscColl.size(); ++i) {
						info = (DemographicBO.MiscellaneousInfo)miscColl.get(i);
						SizeUtil.checkFieldSizes (info, parent, info.getType(), custcfg);
					}
				}
			} catch (SRMBaseException be) {
				throw new SRMPreWriteException (be.getErrorCode(), be);
			} catch (Exception ge) {
				throw new SRMPreWriteException (SRMBOException.ERROR_INTERNAL, ge);
			}
		}



/** CRM9.5 to CRM10.1  CIF - EBanking changes recon Start*/ //TrackerID: 97236
		if(boDemo.getDemographicID()!=null && boDemo.getAccountID()!=null)
		{
			if(apprFlag.equals("true")){
					flag=(String)CheckExternalSystemFields.hmJMSEntry.get(boDemo.getAccountID());

					if(flag==null){
						CheckExternalSystemFields checkEBankingFields=new CheckExternalSystemFields();
						eBankFlag=checkEBankingFields.checkChangedFields(bc,boDemo);

					}else {
						eBankFlag=flag;

					}
			}else{
				CheckExternalSystemFields checkEBankingFields=new CheckExternalSystemFields();
				eBankFlag=checkEBankingFields.checkChangedFields(bc,boDemo);
			}
		}
		else
		{
			eBankFlag="N";
		}
/** CRM9.5 to CRM10.1  CIF - EBanking changes recon End*/



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
	final Integer demoAccId  = boDemo.getAccountID();
	final Integer demoContId = boDemo.getContactID();
	final Integer demoSuspId = boDemo.getSuspectID();
	final String aAccount = "AccountBO";
	final String aContact = "ContactBO";
	final String aSuspect = "SuspectBO";
	final String aNone = "None";
	String aDemoType = aAccount;
	if (demoAccId == null)
	{
		if (demoContId !=  null)
		{
			aDemoType = aContact;
		}
		else if (demoSuspId !=  null)
		{
			aDemoType = aSuspect;
		}
		else
		{
			aDemoType = aNone;
		}
	}
	String[] aString = new String[3];
	aString[0] = boDemo.getEmployment_Status();
	if (boDemo.getTotalHouseholdIncm() != null) {
	aString[1] = boDemo.getTotalHouseholdIncm().toString(); }
	else { aString[1] = ""; }
	if (boDemo.getAnnual_Salary_Income() != null) {
	aString[2] = boDemo.getAnnual_Salary_Income().toString();}

	for(int i=0; i<=2 ; i++){
		if(aString[i] == null){
		  aString[i] = "";
		}
	}
	if (aDemoType.equalsIgnoreCase(aAccount))
	{
	  StringBuffer chkSumAcc = new StringBuffer(256);
	  for(int iAppend = 0; iAppend <= 1 ; iAppend++)
		{
		  chkSumAcc.append(aString[iAppend]);
		  chkSumAcc.append("|");
		}

		 final String chkSumCalc2 = MsgDigest.getDigestToken(
			 							chkSumAcc.toString());
		 boDemo.setCheckSum(chkSumCalc2);

	    }
	else
	{
	  // Same Fields for Contact And Suspect
	  StringBuffer chkSumDemo = new StringBuffer(256);
	  for(int iAppend = 0; iAppend <= 2 ; iAppend++)
	   {
		chkSumDemo.append(aString[iAppend]);
		chkSumDemo.append("|");
	   }
		   final String chkSumCalc1 = MsgDigest.getDigestToken(chkSumDemo.toString());
		   boDemo.setCheckSum(chkSumCalc1);

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


	public void postWrite (SRMBusinessContext bc, Object bo)
	throws SRMPostWriteException {
		DemographicBO boDemo = (DemographicBO)bo;
		// customized implementation place holder
/** CRM9.5 to CRM10.1  CIF - EBanking changes recon Start*/ //TrackerID: 97236
		if(("E").equals(eBankFlag)||("C").equals(eBankFlag))
		{
			if(apprFlag.equals("true")){
				if(flag==null){
					CheckExternalSystemFields.hmJMSEntry.put(boDemo.getAccountID(),eBankFlag);
				}
			}else{
 	 				String id = ClientName.CRMQD; //EBanking changes
					String root = System.getProperty("SIMPLERM_ROOT");
					JMSClient cl = new JMSClient(id, root);
					/* EBanking CR changes -- start */
					try{
						String sOrgKey = CheckExternalSystemFields.getOrgKey(bc,boDemo.getAccountID());
					NameValue[] nv = {new NameValue("cifId", sOrgKey),new NameValue("cifType", "Retail"),new NameValue("modifyFlag",eBankFlag)}; /* EBanking CR changes -- end */
					com.infy.cis.common.message.Message msg =
   					new com.infy.cis.common.message.Message();
 			    	msg.setNV(nv);
                		cl.send(id,             // sender id
			  					Address.CRMQD, // destination /* EBanking CR changes */
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
		}
/** CRM9.5 to CRM10.1  CIF - EBanking changes recon End*/
	}


	public void preDelete (SRMBusinessContext bc, Object bo)
	throws SRMPreDeleteException {
		// customized implementation place holder
	}


	public void postDelete (SRMBusinessContext bc, Object bo)
	throws SRMPostDeleteException {
		// customized implementation place holder
	}


	public void preFill (SRMBusinessContext bc, Object bo)
	throws SRMPreFillException {
		// customized implementation place holder
	}


	public void postFill (SRMBusinessContext bc, Object bo)
	throws SRMPostFillException {
		// customized implementation place holder
	}

}



