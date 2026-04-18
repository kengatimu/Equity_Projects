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
import com.infy.cis.common.EditorUtil;
import com.infy.cis.exception.CISContextException;
import com.infy.cis.exception.SRMBOException;
import com.infy.cis.exception.SRMTypeValidatorException;
import com.infy.cis.srmbo.DemographicModBO;
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


public class DemographicModBOHook implements IHooks {

    public DemographicModBOHook() { }

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

	final DemographicModBO aBoNew = (DemographicModBO) aBoObj;
	final Integer demoAccId  = aBoNew.getAccountID();
	final Integer demoContId = aBoNew.getContactID();
	final Integer demoSuspId = aBoNew.getSuspectID();
	final String aAccount = "AccountBO";
	final String aContact = "ContactBO";
	final String aSuspect = "SuspectBO";
	final String aNone = "None";
	String aDemoType = aAccount;
	if ( demoAccId == null ||
		 demoAccId.equals(demoSuspId) ||
		 demoAccId.equals(demoContId))
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
	aString[0] = aBoNew.getEmployment_Status();
	if (aBoNew.getTotalHouseholdIncm() != null) {
	aString[1] = aBoNew.getTotalHouseholdIncm().toString(); }
	else { aString[1] = ""; }
	if (aBoNew.getAnnual_Salary_Income() != null) {
	aString[2] = aBoNew.getAnnual_Salary_Income().toString();}

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
		 aBoNew.setCheckSum(chkSumCalc2);
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
		   aBoNew.setCheckSum(chkSumCalc1);

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



