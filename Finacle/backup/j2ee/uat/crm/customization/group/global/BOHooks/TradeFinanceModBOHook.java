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
import com.infy.cis.srmbo.TradeFinanceModBO;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.SRMDataObject;
import com.infy.cis.exception.SRMTypeValidatorException;
import com.infy.cis.exception.CISContextException;
import com.infy.cis.exception.SRMBOException;
import com.infy.cis.common.EditorUtil;


public class TradeFinanceModBOHook implements IHooks {

    public TradeFinanceModBOHook() { }

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

	final TradeFinanceModBO aBoNew = (TradeFinanceModBO) aBoObj;
	final Integer accId = aBoNew.getAccountID();
	final Integer corpId = aBoNew.getCorp_ID();
	final Integer nonCustID = aBoNew.getNonCustomerID();
	final String aAccount = "Account";
	final String aCorporate = "Corporate";
	final String aNonCust = "NonCustomer";
	String aTradeType = aAccount;
	if ((accId == null) && (nonCustID != null))
	 {
	   aTradeType = aNonCust;
     }
	if (corpId != null)
	{
	   aTradeType = aCorporate;
	}
	String[] aString = new String[5];
    aString[0] = aBoNew.getExp_Imp_Ind();
    aString[1] = aBoNew.getParty_Type();
    aString[2] = aBoNew.getCrncy_Code();
	if (aBoNew.getDc_MarginPercentage() != null ) {
	aString[3] = aBoNew.getDc_MarginPercentage().toString();}
	else {aString[3] = "";}
	if (aBoNew.getProduction_Cycle() != null) {
    aString[4] = aBoNew.getProduction_Cycle().toString();}
	else {aString[4] = "";}
	for(int i=0; i<=4; i++){
		if (aString[i] == null){
			aString[i] = "";
		}
	}
	//CALL CHECKSUM API --> ACCOUNTBO
	final String sChkSumAcc = aString[3];
		 String chkSumCalc2 = MsgDigest.getDigestToken(sChkSumAcc);
		 aBoNew.setCheckSum(chkSumCalc2);

	if (!(aTradeType.equalsIgnoreCase(aAccount))) {
	// CALL CHECKSUM API --> CORPORATEBO

	if (aTradeType.equalsIgnoreCase(aCorporate)) {
	StringBuffer sChkSumCorp = new StringBuffer(256);
	for(int iAppend = 1; iAppend <= 4 ; iAppend++)
	{
	   sChkSumCorp.append(aString[iAppend]);
	   sChkSumCorp.append("|");
	 }
		String chkSumCalc3 = MsgDigest.getDigestToken(sChkSumCorp.toString());
		aBoNew.setCheckSum(chkSumCalc3);
	}

	if (!(aTradeType.equalsIgnoreCase(aCorporate))) {
		// CALL CHECKSUM API --> NONCUSTOMERBO
		StringBuffer sChkSumTrade = new StringBuffer(256);
		for(int iAppend = 0; iAppend <= 4 ; iAppend++)
		{
			sChkSumTrade.append(aString[iAppend]);
			sChkSumTrade.append("|");
		}
		String chkSumCalc1 = MsgDigest.getDigestToken(sChkSumTrade.toString());
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

