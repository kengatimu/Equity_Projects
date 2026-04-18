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

import com.infy.cis.common.EditorUtil;
import com.infy.cis.exception.SRMTypeValidatorException;
import com.infy.cis.exception.CISContextException;
import com.infy.cis.exception.SRMBOException;
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.cis.srmbo.PreferencesModBO;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.SRMDataObject;
import com.infy.finacle.crypt.MsgDigest;
import java.util.Date;
import java.util.Properties;


public class PreferencesModBOHook implements IHooks {

    public PreferencesModBOHook() { }

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

	final PreferencesModBO aBoNew = (PreferencesModBO) aBoObj;

	final Integer corpId = aBoNew.getCorp_ID();
	// PreferencesModBO --> For Corporate Only
	String[] aString = new String[2];
	aString[0] = aBoNew.getCreated_From();
	if (aBoNew.getCust_Floor_Limit_Tds() != null) {
   	aString[1] = aBoNew.getCust_Floor_Limit_Tds().toString();}
   	else {aString[1] = "";}
	for(int i=0; i<= 1;i++){
		   if (aString[i] == null){
			  aString[i] = "";
			}
	  }
	// Input String to CheckSum API : PreferenceBO
	if(!(aString[0].equalsIgnoreCase("") &&
	   aString[1].equalsIgnoreCase(""))) {
	StringBuffer chkSumPref = new StringBuffer(256);
	for(int iAppend = 0; iAppend <= 1 ; iAppend++)
	{
		chkSumPref.append(aString[iAppend]);
		chkSumPref.append("|");
	}
		final String chkSumCalc1 = MsgDigest.getDigestToken(chkSumPref.toString());
		//System.out.println("Inside PreferencesModBOHook chkSumCalc1>>>"+chkSumCalc1);
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

