/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: PsychographicBOHook.java $
 *
 * $Author: saritha_manohar $
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/PsychographicBOHook.java $
 *
 * $History: PsychographicBOHook.java $
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
import  com.infy.cis.srmbo.PsychographicBO;
import  com.infy.cis.srmbo.SRMCollection;
import  com.infy.cis.srmbo.security.user.SRMBusinessContext;
import  com.infy.cis.exception.*;
import com.infy.cis.srmbo.SRMBase;
import com.infy.cis.srmbo.AttrAccValidator;

import com.infy.finacle.crypt.MsgDigest;
import java.util.Date;
import java.util.Properties;
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.cis.srmbo.PsychographicBO;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.SRMDataObject;
import com.infy.cis.common.EditorUtil;
/** CRM9.5 to CRM10.1 recon Start*/
import com.infy.cis.common.Address;
import com.infy.cis.common.ClientName;
import com.infy.cis.bus.client.JMSClient;
import com.infy.cis.common.NameValue;
/** CRM9.5 to CRM10.1 recon End*/

public class  PsychographicBOHook
implements IHooks  {

	public String eBankFlag;
/** CRM9.5 to CRM10.1  CIF - EBanking changes  recon Start*/ //TrackerID: 97236
	public String flag="N";
	public String apprFlag;
	/* ***** Tracker# 97236 CIF - EBanking changes : End ***** */
	public void preWrite (SRMBusinessContext bc, Object bo)
	throws SRMPreWriteException,SRMSecurityException {
		PsychographicBO boPsco = (PsychographicBO)bo;
/** CRM9.5 to CRM10.1  CIF - EBanking changes  recon Start*/ //TrackerID: 97236
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
/** CRM9.5 to CRM10.1  CIF - EBanking changes  recon End*/
		 //Tracker:90196: Changes for attibute masking
				try {
					AttrAccValidator.validatecreate((SRMBase) bo);
				} catch(SRMSecurityException e) {
					throw new SRMSecurityException(SRMSecurityException.ERROR_ATTR_MASK, null) ;
				}
		//Tracker:90196: End of Changes

		HashMap custcfg = null;
		if (boPsco.getAccountID() != null)      custcfg = SizeUtil.getCustConfig ("CUSTOMER");
		else if (boPsco.getContactID() != null) custcfg = SizeUtil.getCustConfig ("CONTACT");
		else if (boPsco.getSuspectID() != null) custcfg = SizeUtil.getCustConfig ("PROSPECT");

		if (custcfg != null)  {
			try {
				String parent = "PsychographicBO";
				SizeUtil.checkFieldSizes (boPsco, custcfg);
				if (boPsco.getMiscellaneousInfo() != null) {
					SRMCollection miscColl = boPsco.getMiscellaneousInfo();
					PsychographicBO.MiscellaneousInfo info = null;
					for (int i = 0; i < miscColl.size(); ++i) {
						info = (PsychographicBO.MiscellaneousInfo)miscColl.get(i);
						SizeUtil.checkFieldSizes (info, parent, info.getType(), custcfg);
					}
				}
				SizeUtil.checkFieldSizes (boPsco.getInterests(), parent, custcfg);
			} catch (SRMBaseException be) {
				throw new SRMPreWriteException (be.getErrorCode(), be);
			} catch (Exception ge) {
				throw new SRMPreWriteException (SRMBOException.ERROR_INTERNAL, ge);
			}
		}
   // Changes for CheckSum : Start
  try
   {
/** CRM9.5 to CRM10.1  CIF - EBanking changes  recon Start*/ //TrackerID: 97236
		if(boPsco.getPsychographicID()!=null && boPsco.getAccountID()!=null)
		{
        		if(apprFlag.equals("true")){
					flag=(String)CheckExternalSystemFields.hmJMSEntry.get(boPsco.getAccountID());
					if(flag==null){
						CheckExternalSystemFields checkEBankingFields=new CheckExternalSystemFields();
						eBankFlag=checkEBankingFields.checkChangedFields(bc,boPsco);
					}else {
						eBankFlag=flag;
					}
				}else{
				CheckExternalSystemFields checkEBankingFields=new CheckExternalSystemFields();
				eBankFlag=checkEBankingFields.checkChangedFields(bc,boPsco);
				}
		}
		else
		{
			eBankFlag="N";
		}
/** CRM9.5 to CRM10.1  CIF - EBanking changes  recon End*/




	//Check for Checksum enable flag
	final Properties keyProp = EditorUtil.getCIFGeneralInfo();
	String chkEnFlag1 = keyProp.getProperty(EditorUtil.CHECKSUM_ENABLE);
	String chkEnFlag = "false";
	if (chkEnFlag1 != null) {
	chkEnFlag = chkEnFlag1.trim();
	}
	if (chkEnFlag.equalsIgnoreCase("True")) {

		//final PsychographicBO boPsco  =  (PsychographicBO) bo;
  final PsychographicBO aBoNew = (PsychographicBO) bo;
  final Integer psychoAccId  = aBoNew.getAccountID();
  final Integer psychoContId = aBoNew.getContactID();
  final Integer psychoSuspId = aBoNew.getSuspectID();
  final String aAccount = "AccountBO";
  final String aContact = "ContactBO";
  final String aSuspect = "SuspectBO";
  final String aNone = "None";
  String aPsychoType = aAccount;
	if (psychoAccId == null)
	 {
			if (psychoContId !=  null)
			 {
				aPsychoType = aContact;
			 }
			else if (psychoSuspId !=  null)
			 {
				aPsychoType = aSuspect;
			 }
			else
			 {
				aPsychoType = aNone;
			 }
	 }
  String[] aString = new String[3];
  aString[0] = aBoNew.getBehavioural_Score();
  if (aBoNew.getPreferred_Rep() != null) {
  aString[1] = aBoNew.getPreferred_Rep().toString();}
  else { aString[1] = "";}
  if (aBoNew.getNumberofDependants() != null) {
  aString[2] = aBoNew.getNumberofDependants().toString();}
  else { aString[2] = "";}
  for(int i=0; i<=2 ; i++){
	if(aString[i] == null){
		aString[i] = "";
		}
	}
  // Same Fields for Account, Contact and Suspect
  StringBuffer chkSumPsycho = new StringBuffer(256);
  for(int iAppend = 0; iAppend <= 2 ; iAppend++)
 	{
   		chkSumPsycho.append(aString[iAppend]);
		chkSumPsycho.append("|");
	}
		final String chkSumCalc1 = MsgDigest.getDigestToken(chkSumPsycho.toString());
		aBoNew.setCheckSum(chkSumCalc1);
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
		PsychographicBO boPsycho = (PsychographicBO)bo; // CRM9.5 to CRM10.1  recon
		// customized implementation place holder
/* ***** Tracker# 97236 CIF - EBanking changes : Start ***** */
		//Changes for Ticket id 432732 and Tracker id 260191 Recon for call id 221085 starts
		if(("CE").equals(eBankFlag)||("C").equals(eBankFlag))
		{	if(apprFlag.equals("true")){
		//Changes for Ticket id 432732 and Tracker id 260191 Recon for call id 221085 ends
	 			String id = ClientName.CRMQD; /* EBanking CR changes */
				String root = System.getProperty("SIMPLERM_ROOT");
				JMSClient cl = new JMSClient(id, root);
				/* EBanking CR changes -- start */
				try{
				String sOrgKey = CheckExternalSystemFields.getOrgKey(bc,boPsycho.getAccountID());
				NameValue[] nv = {new NameValue("cifId",sOrgKey),new NameValue("cifType", "Retail"),new NameValue("modifyFlag",eBankFlag)};/* EBanking CR changes -- end */
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

				if(flag!=null){
 					CheckExternalSystemFields.hmJMSEntry.remove(boPsycho.getAccountID());
 				}
			}else{
 		 			String id = ClientName.CRMQD;/* EBanking CR changes */
					String root = System.getProperty("SIMPLERM_ROOT");
					JMSClient cl = new JMSClient(id, root);
					/* EBanking CR changes -- start */

					try{
						String sOrgKey = CheckExternalSystemFields.getOrgKey(bc,boPsycho.getAccountID());
					NameValue[] nv = {new NameValue("cifId", sOrgKey),new NameValue("cifType", "Retail"),new NameValue("modifyFlag",eBankFlag)};/* EBanking CR changes -- end */
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
					catch(Exception e){
						throw new SRMPostWriteException(SRMPostWriteException.ERROR_INTERNAL, e);
					}

				}
		}//Changes for Ticket id 432732 and Tracker id 260191 Recon for call id 221085 starts
		else if( ("E").equals(eBankFlag)){
		if(flag!=null){
		 					CheckExternalSystemFields.hmJMSEntry.remove(boPsycho.getAccountID());
 				}
 				}
		//Changes for Ticket id 432732 and Tracker id 260191 Recon for call id 221085 ends
/** CRM9.5 to CRM10.1  CIF - EBanking changes  recon End*/
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


