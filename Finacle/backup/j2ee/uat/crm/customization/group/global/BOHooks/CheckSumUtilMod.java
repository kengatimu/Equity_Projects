/******************************************************************************
 * Copyright (c) 2000-2006 Infosys Ltd.  All rights reserved.
 *
 * $Workfile  : CheckSumUtilMain.java $
 *
 * Author     : Greety Varghese
 *
 * $Archive   :
 *
 * $History   : CheckSumUtilMain.java $
 *
 *****************************************************************************/

//Package declaration
package com.infy.cis.custom;
// Import classes
import com.infy.cis.common.EditorUtil;
import com.infy.cis.srmbo.Audit;
import com.infy.cis.srmbo.AccountModBO;
import com.infy.cis.srmbo.AccountCheckSumModBO;
import com.infy.cis.srmbo.ContactModBO;
import com.infy.cis.srmbo.ContactCheckSumModBO;
import com.infy.cis.srmbo.CorporateModBO;
import com.infy.cis.srmbo.CorporateCheckSumModBO;
import com.infy.cis.srmbo.NonCustomerModBO;
import com.infy.cis.srmbo.NonCustomerCheckSumModBO;
import com.infy.cis.srmbo.SRMDataObject;
import com.infy.cis.srmbo.SuspectModBO;
import com.infy.cis.srmbo.SuspectCheckSumModBO;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.finacle.crypt.MsgDigest;
import java.util.Properties;

/**
 * File to check if record has been tampered or not
 * If tampered, entry is to be made into CheckSumErrorBO
 * @author Greety
 */


public final class CheckSumUtilMod
{
	// Constructor
	public CheckSumUtilMod()
	{
		// No implementation
	}

	/**
	 * Function to find if the NonCustomer record has been tampered
	 * @param aBusiCntxt	 Business Context
	 * @param aNonCustID	 Id of the record
	 * @return boolean, true if record has been tampered,false otherwise
	 * @throws  Exception throws Exception
	 */
	public static boolean isNonCustomerRecordTampered(
								  final SRMBusinessContext aBusiCntxt,
								  final int aNonCustID) throws Exception
	{
		//Check for Checksum enable flag
		final Properties keyProp = EditorUtil.getCIFGeneralInfo();
		String chkEnFlag = keyProp.getProperty(EditorUtil.CHECKSUM_ENABLE).trim();
		if (chkEnFlag.equalsIgnoreCase("False")) {
			return false;
		}
		/* Get the busiObj corresponding to the NonCustomerID received
			   as input param */
		final NonCustomerCheckSumModBO boNonCustChk =
		(NonCustomerCheckSumModBO) CheckSumHelper.getBOForAttr(
										   aBusiCntxt, "NonCustomerCheckSumModBO",
										   NonCustomerCheckSumModBO.NONCUSTOMERID,
										   new Integer(aNonCustID));
		if (boNonCustChk == null) { return false;}
		// CheckSum Fields : NonCustomerModBO
		final String[] aString = new String[16];
		aString[0] = boNonCustChk.getNonCustomerID().toString();
		aString[1] = boNonCustChk.getUserStrField1();
		aString[2] = boNonCustChk.getUserStrField2();
		aString[3] = boNonCustChk.getUserStrField3();
		aString[4] = boNonCustChk.getUserStrField4();
		aString[5] = boNonCustChk.getUserStrField5();
		aString[6] = boNonCustChk.getUserStrField6();
		aString[7] = boNonCustChk.getUserStrField7();
		aString[8] = boNonCustChk.getUserStrField8();
		aString[9] = boNonCustChk.getUserStrField9();
		if (boNonCustChk.getUserDblField1() != null) {
		aString[10] = boNonCustChk.getUserDblField1().toString();}
		else { aString[10] = null;}
		// CheckSum Fields : NonCustomerModBO... End
		// CheckSum Fields : TradeFinanceBO
		aString[11] = boNonCustChk.getUserStrField10();
		aString[12] = boNonCustChk.getUserStrField16();
		aString[13] = boNonCustChk.getUserStrField17();
		if ( boNonCustChk.getUserDblField2() != null) {
		aString[14] = boNonCustChk.getUserDblField2().toString();}
		else { aString[14] = null;}
		if ( boNonCustChk.getUserIntField1() != null) {
		aString[15] = boNonCustChk.getUserIntField1().toString();}
		else { aString[15] = null;}
        // CheckSum Fields : TradeFinanceBO...End
		for (int iForNull = 1; iForNull <= 15; iForNull = iForNull + 1) {
			if (aString[iForNull] == null)
			{
				aString[iForNull] = "";
			}
		}
		// Input String to CheckSum API : NonCust
		final StringBuffer sChkSumNC = new StringBuffer();
		for (int iAppend = 1; iAppend <= 10; iAppend = iAppend + 1)
		{
			sChkSumNC.append(aString[iAppend]);
			sChkSumNC.append("|");
		}
		// Input String to CheckSum API : TradeFinance
		final StringBuffer sChkSumTrade = new StringBuffer();
		for (int iAppend = 11; iAppend <= 15; iAppend = iAppend + 1)
		{
			sChkSumTrade.append(aString[iAppend]);
			sChkSumTrade.append("|");
		}
		//Call  to CheckSum API
		String nChkSumNC;
		String nChkSumTrade;
		if ( sChkSumNC != null) {
			nChkSumNC = sChkSumNC.toString();}
		else { nChkSumNC = "";}
		if (sChkSumTrade != null) {
			nChkSumTrade = sChkSumTrade.toString();
		}
		else { nChkSumTrade = "";}
		final String chkSumCalc1 = MsgDigest.getDigestToken(
									nChkSumNC);
		final String chkSumCalc2 = MsgDigest.getDigestToken(
									nChkSumTrade);
		// Get the checksum already in the table
		final String chkExisting = boNonCustChk.getCheckSum();
	    final String tradeChekSum = boNonCustChk.getTradeCheckSum();
	    //Compare both CheckSums and if they are not equal, return true
		if ((!(chkSumCalc1.equalsIgnoreCase(chkExisting))) ||
		   (!(chkSumCalc2.equalsIgnoreCase(tradeChekSum))))
		{
			// Call function to write into CheckSumErrorBO
			final String sNonCustBO = "NonCustomerModBO";
			final NonCustomerModBO boNonCust =
			(NonCustomerModBO) CheckSumHelper.getBOForAttr(
											aBusiCntxt, sNonCustBO,
											NonCustomerModBO.NONCUSTOMERID,
											new Integer(aNonCustID));
			final String sOrgKey 	= boNonCust.getOrgKey();
			CheckSumHelper.writeCheckSumError(aBusiCntxt,
												sNonCustBO, aNonCustID,sOrgKey);
			boNonCust.setIsTampered("Y");
			Audit.SaveAudit("NMSGADT50008$", boNonCust, aBusiCntxt);
			SRMDataObject.write(boNonCust, aBusiCntxt);
			return true;
		}
	//NonCustomer Record not tampered.
	return false;
	}

	/**
	 * Function to find if the Contact record has been tampered
	 * @param aBusiCntxt	 Business Context
	 * @param aContactID	 Id of the record
	 * @return boolean, true if record has been tampered,false otherwise
	 * @throws  Exception throws Exception
	 */
	public static boolean isContactRecordTampered(
									  final SRMBusinessContext aBusiCntxt,
									  final int aContactID) throws Exception
	{
		//Check for Checksum enable flag
		final Properties keyProp = EditorUtil.getCIFGeneralInfo();
		String chkEnFlag = keyProp.getProperty(EditorUtil.CHECKSUM_ENABLE).trim();
		if (chkEnFlag.equalsIgnoreCase("False")) {
			return false;
		}
		/* Get the busiObj corresponding to the Contact ID received
				   as input param */
		final ContactCheckSumModBO boContChk =
		(ContactCheckSumModBO) CheckSumHelper.getBOForAttr(
											aBusiCntxt, "ContactCheckSumModBO",
											ContactCheckSumModBO.CONTACTID,
											new Integer(aContactID));

		if (boContChk == null) { return false;}
		final String[] aString = new String[16];
		// CheckSum Fields : ContactModBO
		//aString[0] = boContChk.getContactID().toString();
		aString[1] = boContChk.getUserStrField1();
		aString[2] = boContChk.getUserStrField2();
		aString[3] = boContChk.getUserStrField3();
		aString[4] = boContChk.getUserStrField4();
		aString[5] = boContChk.getUserStrField5();

		// CheckSum Fields : ContactModBO... End
		// CheckSum Fields : DEMOGRAPHICBO
		aString[6] = boContChk.getUserStrField6();
		if (boContChk.getUserDblField1() != null) {
		aString[7] = boContChk.getUserDblField1().toString(); }
		else { aString[7] = ""; }
		if (boContChk.getUserDblField2() != null) {
		aString[8] = boContChk.getUserDblField2().toString(); }
		else { aString[8] = ""; }
		// CheckSum Fields : DEMOGRAPHICBO... End
		// CheckSum Fileds : PsychographicBO
		aString[9] = boContChk.getUserStrField9();
		if ( boContChk.getUserIntField1() != null) {
		aString[10] = boContChk.getUserIntField1().toString(); }
		else { aString[10] = ""; }
		if ( boContChk.getUserIntField2() != null) {
		aString[11] = boContChk.getUserIntField2().toString(); }
		else { aString[11] = "";}
		// CheckSum Fileds : PsychographicBO...End
		// CheckSum Fileds : EntityRelationshipModBO
		aString[12] = boContChk.getUserStrField10();
		if ( boContChk.getUserIntField3() != null) {
		aString[13] = boContChk.getUserIntField3().toString();}
		else { aString[13] = "";}
		// CheckSum Fileds : EntityRelationshipModBO...End
		// CheckSum Fields : ENTITYDOCUMENTMODBO
		aString[14] = boContChk.getUserStrField7();
		aString[15] = boContChk.getUserStrField8();
		// CheckSum Fields : ENTITYDOCUMENTMODBO...End

		for (int iForNull = 1; iForNull <= 15; iForNull = iForNull + 1) {
			if (aString[iForNull] == null) {
				aString[iForNull] = "";
				}
			}
		// Input String to CheckSum API : ContactModBO
		final StringBuffer chkSumCont = new StringBuffer();
		for (int iAppend = 1; iAppend <= 5; iAppend = iAppend + 1)
		{
			chkSumCont.append(aString[iAppend]);
			chkSumCont.append("|");
		}
		// Input String to CheckSum API : DEMOGRAPHICBO
		final StringBuffer chkSumDemo = new StringBuffer();
		for (int iAppend = 6; iAppend <= 8; iAppend = iAppend + 1)
		{
			chkSumDemo.append(aString[iAppend]);
			chkSumDemo.append("|");
		}
		// Input String to CheckSum API : PSYCHOGRAPHICBO
		final StringBuffer chkSumPsycho = new StringBuffer();
		for (int iAppend = 9; iAppend <= 11; iAppend = iAppend + 1)
		{
			chkSumPsycho.append(aString[iAppend]);
			chkSumPsycho.append("|");
		}
		// Input String to CheckSum API : ENTITYRelationshipModBO
		final StringBuffer chkSumER = new StringBuffer();
		for (int iAppend = 12; iAppend <= 13; iAppend = iAppend + 1)
		{
			chkSumER.append(aString[iAppend]);
			chkSumER.append("|");
		}
		// Input String to CheckSum API : ENTITYDOCUMENTMODBO
		String chkSumED1 = aString[14];
		String chkSumED2 = aString[15];

		String nChkSumCont;
		String nChkSumDemo;
		String nChkSumPsycho;
		String nChkSumER;

       	// Get the checksum already in the table
		final String contChkSum 	= boContChk.getCheckSum();
		final String demoChkSum 	= boContChk.getDemoCheckSum();
		final String psychoChkSum 	= boContChk.getPsychoCheckSum();
		String entrelChkSum 		= boContChk.getEntityRelCheckSum();
		String EDChkSum1 			= boContChk.getEntityDocCheckSum1();
		String EDChkSum2	 		= boContChk.getEntityDocCheckSum2();

		if ( chkSumCont != null) {
			nChkSumCont = chkSumCont.toString();}
		else { nChkSumCont = "";}
		if ( chkSumDemo != null) {
			nChkSumDemo = chkSumDemo.toString();}
		else { nChkSumDemo = "";}
		if (chkSumPsycho != null) {
			nChkSumPsycho = chkSumPsycho.toString();}
		else { nChkSumPsycho = "";}
		if (chkSumER != null) {
			nChkSumER = chkSumER.toString();}
		else {nChkSumER = "";}

		final String chkSumCalc1 = MsgDigest.getDigestToken(
									nChkSumCont);
		final String chkSumCalc2 = MsgDigest.getDigestToken(
									nChkSumDemo);
		final String chkSumCalc3 = MsgDigest.getDigestToken(
									nChkSumPsycho);
		String chkSumCalc4 = MsgDigest.getDigestToken(
									nChkSumER);
		String	chkSumCalc6 = MsgDigest.getDigestToken(
										chkSumED1);
		String	chkSumCalc7 = MsgDigest.getDigestToken(
										chkSumED2);

		if (aString[12].equalsIgnoreCase("") &&
					aString[13].equalsIgnoreCase("")) {
			chkSumCalc4 = "";
			entrelChkSum = "";
		}
		if (aString[14].equalsIgnoreCase("") &&
						null == EDChkSum1) {
					chkSumCalc6 = "";
					EDChkSum1 = "";
				}
		if (aString[15].equalsIgnoreCase("") &&
						null == EDChkSum2)  {
					chkSumCalc7 = "";
					EDChkSum2 = "";
		}
		if ((!(chkSumCalc1.equalsIgnoreCase(contChkSum))) ||
		   (!(chkSumCalc2.equalsIgnoreCase(demoChkSum))) ||
		   (!(chkSumCalc3.equalsIgnoreCase(psychoChkSum))) ||
		   (!(chkSumCalc4.equalsIgnoreCase(entrelChkSum))) ||
		   (!(chkSumCalc6.equalsIgnoreCase(EDChkSum1))) ||
		   (!(chkSumCalc7.equalsIgnoreCase(EDChkSum2)))
		  )
		{
			// Call function to write into CheckSumErrorBO
			final String sContactModBO = "ContactModBO";
			final ContactModBO boCont =
			(ContactModBO) CheckSumHelper.getBOForAttr(
												aBusiCntxt, sContactModBO,
												ContactModBO.CONTACTID,
												new Integer(aContactID));
			final String sOrgKey 	= boCont.getContactsKey();
			CheckSumHelper.writeCheckSumError(aBusiCntxt,
												sContactModBO, aContactID,sOrgKey);
		    boCont.setIsTampered("Y");
		    Audit.SaveAudit("NMSGADT50008$", boCont, aBusiCntxt);
			SRMDataObject.write(boCont, aBusiCntxt);
			return true;
		}
   	// CONTACT RECORD IS NOT TAMPERED
	return false;
	}

	/**
	 * Function to find if the Account record has been tampered
	 * @param aBusiCntxt	 Business Context
	 * @param aAccntID	 Id of the record
	 * @return boolean, true if record has been tampered,false otherwise
	 * @throws  Exception throws Exception
	 */
	public static boolean isAccountRecordTampered(
								  final SRMBusinessContext aBusiCntxt,
								  final int aAccntID) throws Exception
	{
		//Check for Checksum enable flag
		final Properties keyProp = EditorUtil.getCIFGeneralInfo();
		String chkEnFlag = keyProp.getProperty(EditorUtil.CHECKSUM_ENABLE).trim();
		if (chkEnFlag.equalsIgnoreCase("False")) {
			return false;
		}
		/* Get the busiObj corresponding to the Contact ID received
				   as input param */
		final AccountCheckSumModBO boAccChk =
		(AccountCheckSumModBO) CheckSumHelper.getBOForAttr(
										aBusiCntxt, "AccountCheckSumModBO",
										AccountCheckSumModBO.ACCOUNTID,
										new Integer(aAccntID));
		if (boAccChk == null) { return false;}
		final String[] aString = new String[16];
		// CheckSum Fields : AccountModBO
		//aString[0] = boAccChk.getAccountID().toString();
		aString[1] = boAccChk.getUserStrField1();
		aString[2] = boAccChk.getUserStrField2();
		aString[3] = boAccChk.getUserStrField3();
		aString[4] = boAccChk.getUserStrField4();
		aString[5] = boAccChk.getUserStrField5();
		// CheckSum Fields : AccountModBO...End
		// CheckSum Fields : DEMOGRAPHICBO
		aString[6] = boAccChk.getUserStrField6();
		if (boAccChk.getUserDblField1() != null) {
		aString[7] = boAccChk.getUserDblField1().toString(); }
		else { aString[7] = null;}
		// CheckSum Fields : DEMOGRAPHICBO...End
		// CheckSum Fields : PSYCHOGRAPHICBO
		aString[8] = boAccChk.getUserStrField9();
		if ( boAccChk.getUserIntField1() != null) {
		aString[9] = boAccChk.getUserIntField1().toString(); }
		else { aString[9] = null;}
		if ( boAccChk.getUserIntField2() != null) {
		aString[10] = boAccChk.getUserIntField2().toString();}
		else { aString[10] = null;}
	    // CheckSum Fields : PSYCHOGRAPHICBO...End
		// CheckSum Fields : ENTITYRelationshipModBO
		aString[11] = boAccChk.getUserStrField10();
		if ( boAccChk.getUserIntField3() != null) {
	    aString[12] = boAccChk.getUserIntField3().toString();}
	    else { aString[12] = null;}
		// CheckSum Fields : ENTITYRelationshipModBO...End
		// CheckSum Fields : TRADEFINANCEBO
		if ( boAccChk.getUserDblField2() != null) {
		aString[13] = boAccChk.getUserDblField2().toString();}
		else { aString[13] = null;}
		// CheckSum Fields : TRADEFINANCEBO...End
		// CheckSum Fields : ENTITYDOCUMENTMODBO
		aString[14] = boAccChk.getUserStrField7();
		aString[15] = boAccChk.getUserStrField8();
		// CheckSum Fields : ENTITYDOCUMENTMODBO...End

		for (int iForNull = 1; iForNull <= 15; iForNull = iForNull + 1) {
			if (aString[iForNull] == null) {
				aString[iForNull] = "";
				}
			}
		// Input String to CheckSum API : AccountModBO
		final StringBuffer chkSumAcc = new StringBuffer();
		for (int iAppend = 1; iAppend <= 5; iAppend = iAppend + 1)
		{
			chkSumAcc.append(aString[iAppend]);
			chkSumAcc.append("|");
		}
		// Input String to CheckSum API : DEMOGRAPHICBO
		final StringBuffer chkSumDemo = new StringBuffer();
		for (int iAppend = 6; iAppend <= 7; iAppend = iAppend + 1)
		{
			chkSumDemo.append(aString[iAppend]);
			chkSumDemo.append("|");
		}
		// Input String to CheckSum API : PSYCHOGRAPHICBO
		final StringBuffer chkSumPsycho = new StringBuffer();
		for (int iAppend = 8; iAppend <= 10; iAppend = iAppend + 1)
		{
			chkSumPsycho.append(aString[iAppend]);
			chkSumPsycho.append("|");
		}
		// Input String to CheckSum API : ENTITYRelationshipModBO
		final StringBuffer chkSumER = new StringBuffer();
		for (int iAppend = 11; iAppend <= 12; iAppend = iAppend + 1)
		{
			chkSumER.append(aString[iAppend]);
			chkSumER.append("|");
		}
		// Input String to CheckSum API : TRADEFINANCEBO
		final String chkSumTF = aString[13];
		// Input String to CheckSum API : ENTITYDOCUMENTMODBO
		String chkSumED1 = aString[14];
		String chkSumED2 = aString[15];
		//Call to CheckSum API
		String nChkSumAcc;
		String nChkSumDemo;
		String nChkSumPsycho;
		String nChkSumER;
		if (chkSumAcc != null) {
			nChkSumAcc = chkSumAcc.toString();}
		else { nChkSumAcc = "";}
		if (chkSumDemo != null) {
			nChkSumDemo = chkSumDemo.toString();}
		else { nChkSumDemo = "";}
		if (chkSumPsycho != null) {
			nChkSumPsycho = chkSumPsycho.toString();}
		else { nChkSumPsycho = "";}
		if (chkSumER != null) {
			nChkSumER = chkSumER.toString();}
		else { nChkSumER = "";}

		final String	chkSumCalc1 = MsgDigest.getDigestToken(
										nChkSumAcc);
		final String	chkSumCalc2 = MsgDigest.getDigestToken(
										nChkSumDemo);
		final String	chkSumCalc3 = MsgDigest.getDigestToken(
										nChkSumPsycho);
		String	chkSumCalc4 = MsgDigest.getDigestToken(
										nChkSumER);
		String	chkSumCalc5 = MsgDigest.getDigestToken(
										chkSumTF);
		String	chkSumCalc6 = MsgDigest.getDigestToken(
										chkSumED1);
		String	chkSumCalc7 = MsgDigest.getDigestToken(
										chkSumED2);
		// Get the checksum already in the table
		final String accChkSum = boAccChk.getCheckSum();
		final String demoChkSum = boAccChk.getDemoCheckSum();
		final String psychoChkSum = boAccChk.getPsychoCheckSum();
		String entrelChkSum = boAccChk.getEntityRelCheckSum();
		String tfChkSum = boAccChk.getTFCheckSum();
		String EDChkSum1 = boAccChk.getEntityDocCheckSum1();
		String EDChkSum2 = boAccChk.getEntityDocCheckSum2();

		if (aString[11].equalsIgnoreCase("") &&
				aString[12].equalsIgnoreCase("") &&
				null == entrelChkSum)  {
			chkSumCalc4 = "";
			entrelChkSum = "";
		}
		if (aString[14].equalsIgnoreCase("") && null == EDChkSum1) {
			chkSumCalc6 = "";
			EDChkSum1 = "";
		}
		if (aString[15].equalsIgnoreCase("") && null == EDChkSum2)  {
			chkSumCalc7 = "";
			EDChkSum2 = "";
		}
		if (aString[13].equalsIgnoreCase("") && null == tfChkSum)  {
			chkSumCalc5 = "";
			tfChkSum = "";
		}
		if ((!(chkSumCalc1.equalsIgnoreCase(accChkSum))) ||
		   (!(chkSumCalc2.equalsIgnoreCase(demoChkSum))) ||
		   (!(chkSumCalc3.equalsIgnoreCase(psychoChkSum))) ||
		   (!(chkSumCalc4.equalsIgnoreCase(entrelChkSum))) ||
		   (!(chkSumCalc5.equalsIgnoreCase(tfChkSum))) ||
		   (!(chkSumCalc6.equalsIgnoreCase(EDChkSum1))) ||
		   (!(chkSumCalc7.equalsIgnoreCase(EDChkSum2)))
		  )
		{
			// Call function to write into CheckSumErrorBO
			final String sAccountModBO = "AccountModBO";
			final AccountModBO boAcc =
				(AccountModBO) CheckSumHelper.getBOForAttr(
											aBusiCntxt, sAccountModBO,
											AccountModBO.ACCOUNTID,
											new Integer(aAccntID));
			final String sOrgkey = boAcc.getAccountKey();
			CheckSumHelper.writeCheckSumError(aBusiCntxt,
												sAccountModBO, aAccntID,sOrgkey);
				boAcc.setIsTampered("Y");
				Audit.SaveAudit("NMSGADT50008$", boAcc, aBusiCntxt);
				SRMDataObject.write(boAcc, aBusiCntxt);
				return true;
		}
          // RECORD IS NOT TAMPERED
          return false;
	}

	/**
     * Function to find if the Suspect record has been tampered
	 * @param aBusiCntxt	 Business Context
	 * @param aSuspID	 Id of the record
	 * @return boolean, true if record has been tampered,false otherwise
	 * @throws  Exception throws Exception
	 */
	public static boolean isSuspectRecordTampered(
									final SRMBusinessContext aBusiCntxt,
									final int aSuspID)throws Exception
	{
		//Check for Checksum enable flag
		final Properties keyProp = EditorUtil.getCIFGeneralInfo();
		String chkEnFlag = keyProp.getProperty(EditorUtil.CHECKSUM_ENABLE).trim();
		if (chkEnFlag.equalsIgnoreCase("False")) {
			return false;
		}
		/* Get the busiObj corresponding to the Suspect ID received
					  as input param */
		final SuspectCheckSumModBO boSusChk =
				(SuspectCheckSumModBO) CheckSumHelper.getBOForAttr(
											aBusiCntxt, "SuspectCheckSumModBO",
											SuspectCheckSumModBO.SUSPECTID,
											new Integer(aSuspID));
		if (boSusChk == null) { return false;}
	    final String[] aString = new String[16];
		// CheckSum Fields : SuspectModBO
		//aString[0] = boSusChk.getSuspectID().toString();
		aString[1] = boSusChk.getUserStrField1();
		aString[2] = boSusChk.getUserStrField2();
		aString[3] = boSusChk.getUserStrField3();
		aString[4] = boSusChk.getUserStrField4();
		aString[5] = boSusChk.getUserStrField5();
		// CheckSum Fields : SuspectModBO...End
		// CheckSum Fields : DEMOGRAPHICMODBO
		aString[6] = boSusChk.getUserStrField6();
		if ( boSusChk.getUserDblField1() != null) {
		aString[7] = boSusChk.getUserDblField1().toString();}
		else { aString[7] = null;}
		if ( boSusChk.getUserDblField2() != null) {
		aString[8] = boSusChk.getUserDblField2().toString();}
		else { aString[8] = null;}
		// CheckSum Fields : DEMOGRAPHICMODBO..End
		// CheckSum Fields : PSYCHOGRPHICBO
		aString[9] = boSusChk.getUserStrField9();
		if (boSusChk.getUserIntField1() != null) {
		aString[10] = boSusChk.getUserIntField1().toString();}
		else { aString[10] = null;}
		if ( boSusChk.getUserIntField2() != null) {
		aString[11] = boSusChk.getUserIntField2().toString();}
		else { aString[11] = null;}
		// CheckSum Fields : PSYCHOGRPHICBO...End
     	// CheckSum Fields : ENTITYRelationshipModBO
		aString[12] = boSusChk.getUserStrField10();
		if ( boSusChk.getUserIntField3() != null) {
		aString[13] = boSusChk.getUserIntField3().toString();}
		else { aString[13] = null;}
     	// CheckSum Fields : ENTITYRelationshipModBO...End
     	// CheckSum Fields : ENTITYDOCUMENTMODBO
		aString[14] = boSusChk.getUserStrField7();
		aString[15] = boSusChk.getUserStrField8();
     	// CheckSum Fields : ENTITYDOCUMENTMODBO...End
		for (int iForNull = 1; iForNull <= 15; iForNull = iForNull + 1) {
			if (aString[iForNull] == null) {
				aString[iForNull] = "";
				}
			}
		// Input String to CheckSum API : SuspectModBO
		final StringBuffer chkSumSus = new StringBuffer();
		for (int iAppend = 1; iAppend <= 5; iAppend = iAppend + 1)
		{
			chkSumSus.append(aString[iAppend]);
			chkSumSus.append("|");
		}
		// Input String to CheckSum API : DEMOGRAPHICBO
		final StringBuffer chkSumDemo = new StringBuffer();
		for (int iAppend = 6; iAppend <= 8; iAppend = iAppend + 1)
		{
			chkSumDemo.append(aString[iAppend]);
			chkSumDemo.append("|");
		}
		// Input String to CheckSum API : PSYCHOGRAPHICBO
		final StringBuffer chkSumPsycho = new StringBuffer();
		for (int iAppend = 9; iAppend <= 11; iAppend = iAppend + 1)
		{
			chkSumPsycho.append(aString[iAppend]);
			chkSumPsycho.append("|");
		}
		// Input String to CheckSum API : ENTITYRelationshipModBO
		final StringBuffer chkSumER = new StringBuffer();
		for (int iAppend = 12; iAppend <= 13; iAppend = iAppend + 1)
		{
			chkSumER.append(aString[iAppend]);
			chkSumER.append("|");
		}
		// Input String to CheckSum API : ENTITYDOCUMENTMODBO
		String chkSumED1 = aString[14];
		String chkSumED2 = aString[15];

		String nChkSumSus;
		String nChkSumDemo;
		String nChkSumPsycho;
		String nChkSumER;

		if (chkSumSus != null) {
			nChkSumSus = chkSumSus.toString();}
		else { nChkSumSus = "";}
		if (chkSumDemo != null) {
			nChkSumDemo = chkSumDemo.toString();}
		else { nChkSumDemo = "";}
		if (chkSumPsycho != null) {
			nChkSumPsycho = chkSumPsycho.toString();}
		else { nChkSumPsycho = "";}
		if (chkSumER != null) {
			nChkSumER = chkSumER.toString();}
		else {nChkSumER = "";}
		final String chkSumCalc1 = MsgDigest.getDigestToken(
										nChkSumSus);
		final String chkSumCalc2 = MsgDigest.getDigestToken(
										nChkSumDemo);
		final String chkSumCalc3 = MsgDigest.getDigestToken(
										nChkSumPsycho);
		String chkSumCalc4 = MsgDigest.getDigestToken(
										nChkSumER);
		String	chkSumCalc6 = MsgDigest.getDigestToken(
										chkSumED1);
		String	chkSumCalc7 = MsgDigest.getDigestToken(
										chkSumED2);
        // Get the checksum already in the table
		final String susChkSum = boSusChk.getCheckSum();
		final String demoChkSum = boSusChk.getDemoCheckSum();
		final String psychoChkSum = boSusChk.getPsychoCheckSum();
		String entrelChkSum = boSusChk.getEntityRelCheckSum();
		String EDChkSum1 = boSusChk.getEntityDocCheckSum1();
		String EDChkSum2 = boSusChk.getEntityDocCheckSum2();

		if (aString[12].equalsIgnoreCase("") &&
			aString[13].equalsIgnoreCase("") &&
			null == entrelChkSum) {
			chkSumCalc4 = "";
			entrelChkSum = "";
		}
		if (aString[14].equalsIgnoreCase("") &&
				null == EDChkSum1) {
					chkSumCalc6 = "";
					EDChkSum1 = "";
				}
		if (aString[15].equalsIgnoreCase("") &&
				null == EDChkSum2)  {
					chkSumCalc7 = "";
					EDChkSum2 = "";
		}
		// If Both CheckSums are not equal, return true
		if ((!(chkSumCalc1.equalsIgnoreCase(susChkSum))) ||
		   (!(chkSumCalc2.equalsIgnoreCase(demoChkSum))) ||
		   (!(chkSumCalc3.equalsIgnoreCase(psychoChkSum))) ||
		   (!(chkSumCalc4.equalsIgnoreCase(entrelChkSum))) ||
		   (!(chkSumCalc6.equalsIgnoreCase(EDChkSum1))) ||
		   (!(chkSumCalc7.equalsIgnoreCase(EDChkSum2)))
		  )
		{
			// Call function to write into CheckSumErrorBO
			final String sSuspectModBO = "SuspectModBO";
			final SuspectModBO boSus =
				(SuspectModBO) CheckSumHelper.getBOForAttr(
												aBusiCntxt, sSuspectModBO,
												SuspectModBO.SUSPECTID,
												new Integer(aSuspID));
			final String sOrgKey 	= boSus.getSuspectsKey();
			CheckSumHelper.writeCheckSumError(aBusiCntxt,
														sSuspectModBO, aSuspID,sOrgKey);
			boSus.setIsTampered("Y");
			Audit.SaveAudit("NMSGADT50008$", boSus, aBusiCntxt);
			SRMDataObject.write(boSus, aBusiCntxt);
			return true;
		}
		// RECORD IS NOT TAMPERED
		return false;
	}

	/**
	 * Function to find if the Corporate record has been tampered
	 * @param aBusiCntxt	 Business Context
	 * @param aCorpID	 Id of the record
	 * @return boolean, true if record has been tampered,false otherwise
	 * @throws  Exception throws Exception
	 */
	public static boolean isCorporateRecordTampered(
										  final SRMBusinessContext aBusiCntxt,
										  final int aCorpID)throws Exception
	{
		//Check for Checksum enable flag
		final Properties keyProp = EditorUtil.getCIFGeneralInfo();
		String chkEnFlag = keyProp.getProperty(EditorUtil.CHECKSUM_ENABLE).trim();
		if (chkEnFlag.equalsIgnoreCase("False")) {
			return false;
		}
		/* Get the busiObj corresponding to the Corporate ID received
					 as input param */
		final CorporateCheckSumModBO boCorpChk =
		(CorporateCheckSumModBO) CheckSumHelper.getBOForAttr(aBusiCntxt,
									"CorporateCheckSumModBO",
									CorporateCheckSumModBO.CORPMOD_ID,
									new Integer(aCorpID));
		if (boCorpChk == null) { return false;}
		final String[] aString = new String[15];
		// CheckSum Fields : CorporateModBO
		//aString[0] = boCorpChk.getCORP_ID().toString();
		aString[1] = boCorpChk.getUserStrField1();
		aString[2] = boCorpChk.getUserStrField2();
		aString[3] = boCorpChk.getUserStrField3();
		aString[4] = boCorpChk.getUserStrField4();
		aString[5] = boCorpChk.getUserStrField5();
		// CheckSum Fields : CorporateModBO...End
		// CheckSum Fields : PREFERENCEBO
		aString[6] = boCorpChk.getUserStrField6();
		if (boCorpChk.getUserDblField1() != null) {
		aString[7] = boCorpChk.getUserDblField1().toString();}
		else { aString[7] = "";}
		// CheckSum Fields : PREFERENCEBO...End
		// CheckSum Fields : FINANCEBO
		aString[8] = boCorpChk.getUserStrField7();
		aString[9] = boCorpChk.getUserStrField8();
		if (boCorpChk.getUserIntField1() != null) {
		aString[10] = boCorpChk.getUserIntField1().toString();}
		else { aString[10] = "";}
		// CheckSum Fields : FINANCEBO...End
		// CheckSum Fields : TRADEFINANCEBO
		aString[11] = boCorpChk.getUserStrField9();
		aString[12] = boCorpChk.getUserStrField10();
		if ( boCorpChk.getUserDblField2() != null) {
		aString[13] = boCorpChk.getUserDblField2().toString();}
		else { aString[13] = "";}
		if (boCorpChk.getUserIntField2() != null) {
		aString[14] = boCorpChk.getUserIntField2().toString();}
		else { aString[14] = "";}
		// CheckSum Fields : TRADEFINANCEBO...End
		for (int iForNull = 1; iForNull <= 14; iForNull = iForNull + 1) {
			if (aString[iForNull] == null) {
			aString[iForNull] = "";
				}
			}
		// Input String to CheckSum API : CorporateModBO
		final StringBuffer chkSumCorp = new StringBuffer();
		for (int iAppend = 1; iAppend <= 5; iAppend = iAppend + 1)
		{
			chkSumCorp.append(aString[iAppend]);
			chkSumCorp.append("|");
		}
		// Input String to CheckSum API : PREFERENCEBO
		final StringBuffer chkSumPref = new StringBuffer();
		for (int iAppend = 6; iAppend <= 7; iAppend = iAppend + 1)
		{
			chkSumPref.append(aString[iAppend]);
			chkSumPref.append("|");
		}
		// Input String to CheckSum API : FINANCEBO
		final StringBuffer chkSumFin = new StringBuffer();
		for (int iAppend = 8; iAppend <= 10; iAppend = iAppend + 1)
		{
			chkSumFin.append(aString[iAppend]);
			chkSumFin.append("|");
		}
		// Input String to CheckSum API : TRADEFINANCEBO
		final StringBuffer chkSumTF = new StringBuffer();
		for (int iAppend = 11; iAppend <= 14; iAppend = iAppend + 1)
		{
			chkSumTF.append(aString[iAppend]);
			chkSumTF.append("|");
		}
		String nChkSumCorp;
		String nChkSumPref;
		String nChkSumFin;
		String nChkSumTF;
		if ( chkSumCorp != null) {
			nChkSumCorp = chkSumCorp.toString();}
		else { nChkSumCorp = "";}
		if ( chkSumPref != null) {
			nChkSumPref = chkSumPref.toString();}
		else { nChkSumPref = "";}
		if (chkSumFin != null) {
			nChkSumFin = chkSumFin.toString();}
		else { nChkSumFin = "";}
		if ( chkSumTF != null) {
			nChkSumTF = chkSumTF.toString();}
		else { nChkSumTF = "";}


		final String chkSumCalc1 = MsgDigest.getDigestToken(
										nChkSumCorp);
		String chkSumCalc2;
		String prefChkSum;
		if (aString[6].equalsIgnoreCase("") &&
			aString[7].equalsIgnoreCase("")) {
		chkSumCalc2 = "";
		prefChkSum = "";}
		else {
		chkSumCalc2 = MsgDigest.getDigestToken(
										nChkSumPref);
		prefChkSum = boCorpChk.getPrefCheckSum();
		}

		String chkSumCalc3;
		String finChkSum;
		if (aString[8].equalsIgnoreCase("") &&
			aString[9].equalsIgnoreCase("") &&
			aString[10].equalsIgnoreCase("")) {
		chkSumCalc3 = "";
		finChkSum = "";}
		else {
		chkSumCalc3 = MsgDigest.getDigestToken(
										nChkSumFin);
		finChkSum = boCorpChk.getFinanCheckSum();
		}

		String chkSumCalc4 = MsgDigest.getDigestToken(
										nChkSumTF);
	// Get the checksum already in the table
		final String corpChkSum = boCorpChk.getCheckSum();
		String tradeChkSum = boCorpChk.getTradeCheckSum();

		if (tradeChkSum == null 			 &&
			aString[11].equalsIgnoreCase("") &&
			aString[12].equalsIgnoreCase("") &&
			aString[13].equalsIgnoreCase("") &&
			aString[14].equalsIgnoreCase("")) {
			chkSumCalc4 = "";
			tradeChkSum = "";
			}

		if ((!(chkSumCalc1.equalsIgnoreCase(corpChkSum))) ||
		   (!(chkSumCalc2.equalsIgnoreCase(prefChkSum))) ||
		   (!(chkSumCalc3.equalsIgnoreCase(finChkSum)))  ||
			   (!(chkSumCalc4.equalsIgnoreCase(tradeChkSum)))
		  )
		{
		// Call function to write into CheckSumErrorBO
		final String sCorporateModBO = "CorporateModBO";
		final CorporateModBO boCorp =
		(CorporateModBO) CheckSumHelper.getBOForAttr(aBusiCntxt,
							sCorporateModBO,
							CorporateModBO.CORP_MOD_ID,
							new Integer(aCorpID));
		final String sOrgKey 	  = boCorp.getCorp_Key();
		CheckSumHelper.writeCheckSumError(aBusiCntxt,
												sCorporateModBO, aCorpID,sOrgKey);
		boCorp.setIsTampered("Y");
		Audit.SaveAudit("NMSGADT50008$", boCorp, aBusiCntxt);
		SRMDataObject.write(boCorp, aBusiCntxt);
		return true;
		}

	// RECORD IS NOT TAMPERED
	return false;
	}
//End of fille ChecksumUtilMain.java
}








