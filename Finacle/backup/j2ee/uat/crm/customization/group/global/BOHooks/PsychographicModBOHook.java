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
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.SRMBase;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;

import com.infy.cis.exception.SRMTypeValidatorException;
import com.infy.cis.exception.CISContextException;
import com.infy.cis.exception.SRMBOException;
import com.infy.cis.common.EditorUtil;
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.cis.srmbo.PsychographicModBO;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.SRMDataObject;
import com.infy.finacle.crypt.MsgDigest;
import java.util.Date;
import java.util.Properties;


public class PsychographicModBOHook implements IHooks {

    public PsychographicModBOHook() { }

    final public void preWrite(final SRMBusinessContext
    aBusiContxt, final Object aBoObj)
    throws SRMPreWriteException, SRMSecurityException {
        try {
            AttrAccValidator.validatecreate((SRMBase) aBoObj);
        } catch (SRMSecurityException e) {
            throw new SRMSecurityException(
                SRMSecurityException.ERROR_ATTR_MASK, null);
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


  final PsychographicModBO aBoNew = (PsychographicModBO) aBoObj;
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

