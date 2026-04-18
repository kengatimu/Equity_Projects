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
import com.infy.cis.srmbo.FinancialModBO;
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


public class FinancialModBOHook implements IHooks {

    public FinancialModBOHook() { }

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

	final FinancialModBO aBoNew = (FinancialModBO) aBoObj;


	//String getFinancial_Year()
	//String getShareHld_Flg()


	if (!(aBoNew.getNumberOf_Employees() == null &&
		aBoNew.getFinancial_Year() == null &&
		aBoNew.getShareHld_Flg() == null))
	{

	final Integer corpId = aBoNew.getCorpMod_ID();
	// Only CorporateBO  is using FinancialModBO
	String[] aString = new String[3];
	aString[0] = aBoNew.getShareHld_Flg();
	aString[1] = aBoNew.getFinancial_Year();
	if (aBoNew.getNumberOf_Employees() != null) {
	aString[2] = aBoNew.getNumberOf_Employees().toString();}
	else {aString[2] = "";}
	for(int i=0; i<=2; i++){
		if (aString[i] == null){
			aString[i] = "";
		}

	StringBuffer sChkSumFin = new StringBuffer(256);
	for(int iAppend = 0; iAppend <= 2 ; iAppend++)
	{
		sChkSumFin.append(aString[iAppend]);
		sChkSumFin.append("|");
	}
		  final String chkSumCalc1 = MsgDigest.getDigestToken(sChkSumFin.toString());
		  aBoNew.setCheckSum(chkSumCalc1);

     }
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

