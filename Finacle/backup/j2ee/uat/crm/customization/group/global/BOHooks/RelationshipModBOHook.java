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

import com.infy.finacle.crypt.MsgDigest;
import java.util.Date;
import java.util.Properties;
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.cis.srmbo.RelationshipModBO;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.SRMDataObject;
import com.infy.cis.exception.SRMTypeValidatorException;
import com.infy.cis.exception.CISContextException;
import com.infy.cis.exception.SRMBOException;
import com.infy.cis.common.EditorUtil;


public class RelationshipModBOHook implements IHooks {

    public RelationshipModBOHook() { }

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

	 final RelationshipModBO aBoNew = (RelationshipModBO) aBoObj;
	 String primeIntro = aBoNew.getPrimaryIntroducer();
	 if (primeIntro == null) {
		 primeIntro = "";
		 }
	 if (primeIntro.equalsIgnoreCase("Y")) {

	 String[] aString = new String[2];
	 final String parentEntity = aBoNew.getParentEntity();
	 final Integer prtEntityId = aBoNew.getParentEntityID();
	 aString[0] = aBoNew.getChildEntity();
	 if (aBoNew.getChildEntityID() != null) {
	 aString[1] = aBoNew.getChildEntityID().toString();}
	 else { aString[1] = "";}
	 for(int i=0; i<=1 ; i++){
		if(aString[i] == null){
			aString[i] = "";
			}
      	}
	 /*** Account, Contact nd Suspect  using same fields
	       of RelationshipModBO  for calculating CheckSum ***/

	 StringBuffer chkSumER = new StringBuffer(256);
	 for(int iAppend = 0; iAppend <= 1 ; iAppend++)
	 {
	    chkSumER.append(aString[iAppend]);
		chkSumER.append("|");
	 }
		  String chkSumCalc1 = MsgDigest.getDigestToken(chkSumER.toString());
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

