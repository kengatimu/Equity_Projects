/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: BulkCustomerHook.java $
 *
 * Author: Vasanth_Raj
 *
 * $Archive: /FCRM70CIF/com/infy/cis/custom/BOHooks/BulkCustomerHook.java $
 *
 * $History:
 *************************************************/


package com.infy.cis.custom;

import com.infy.cis.exception.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.ui.admin.IBulkCustHook;
import com.infosys.insulate.util.ArrayList;
import java.util.List;
/* Changes begin for Ticket id- 361968*/
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;
/* Changes end for Ticket id- 361968*/
/**
 * The custom class is provided to add any inner class
 * attributes if required at the customer side during
 * Bulk Customer Creation for Retail and Corporate Customer
 * (AccountBO and CorporateBO)
 *
 * @author vasanth_raj
 */
public class BulkCustomerHook implements IBulkCustHook{

	private final String MISCTYPE = "CURRENCY";
	private final String ADDTYPE1 = "Mailing";
	private final String ADDTYPE2 = "Registered";
	private final String ADDFORMAT = "STRUCTURED_FORMAT";
	/* Changes begin for Ticket id- 361968*/
	Date currDate =new Date();
	/* Changes end for Ticket id- 361968*/
	public Integer loggedOnUser = null;
	public String sloggedUser = null;

	public String CUSTCURRENCY = null;


	//Call ID: 327197 Begin of changes
	private final String PREFETYPE = "CURRENCY";
	private final String PREFECURRENCY = "INR";
	//Call ID: 327197 End of changes



	public BulkCustomerHook()throws Exception{

		CUSTCURRENCY = SRMCurrencyMgr.getBaseCurrency().getSymbol();


	}

	/**
	 * @semantics populateAccountBO method -populates the accountbo
	 * @param acctBO
	 * @param busCtxt
	 * @throws Exception
	 * @see n/a
	 */

		//changes for tracker 410286
	public AccountBO populateAccountBO(AccountBO acctBO,SRMBusinessContext busCtxt)
	throws SRMBOException,SRMTypeValidatorException,CISInvalidArgumentException,
	SRMSecurityException,ParseException{

		/*	BEGIN: CRM_ARCH*/
		/*	return type of the getAgent() method changed
		 *	to SRMBOBase, hence being typecasted	*/
		loggedOnUser= ((AgentBO)AgentGroupMgr.getLoggedonUser(busCtxt).getAgent()).getAgentID();
		/*	END: CRM_ARCH*/


		acctBO.setIsDummy("Y");
		acctBO.setSuspended("N");
		acctBO.setBlackListed("N");
		acctBO.setNegated("N");
		acctBO.setRecordStatus("A");
		acctBO.setEntity_cre_flag("Y");
		acctBO.setIsCorpRep("N");
		acctBO.setCreatedUserID(loggedOnUser);
		acctBO.setAssignedToGroup(1);
		//Changes for tracker ID 429896 starts
		acctBO.setPurgeFlag("N");
		//Changes for tracker ID 429896 ends
		acctBO = populateRetAdd(acctBO);
		return acctBO;
	}

	/**
	 * @semantics populateRetAdd method -populates inner class of accountbo
	 * @param acctBO
	 * @throws Exception
	 * @see n/a
	 */
		//changes for tracker 410286
	public AccountBO populateRetAdd(AccountBO acctBO)
	throws SRMBOException,SRMTypeValidatorException,CISInvalidArgumentException,
	SRMSecurityException,ParseException{
		/*Changes for Ticketid:-(346500)Callid:-(158212)Changes Begin(Fetching corecustid)*/
		String core_cust_id = acctBO.getCore_cust_id();
		/*Changes for Ticketid:-(346500)Callid:-(158212)Changes End*/
		AccountBO.Address NewAddressDet = (AccountBO.Address)acctBO
		.getInstance("Address");
		SRMCollection address =acctBO.getAddress();
		NewAddressDet.setAddressCategory(ADDTYPE1);
		//Changes for Tracker id 356342 STARTS
		NewAddressDet.setPreferredAddress("Y");
		NewAddressDet.setPreferredFormat(ADDFORMAT);
		//changes for tracker 410286 begin
			NewAddressDet.setHouse_no("11");
			NewAddressDet.setBuilding_level("3");
			NewAddressDet.setPremise_name("PREMISE");
			NewAddressDet.setAddress_Line1("11,3,PREMISE");
		//changes for tracker 410286 ends
		//Changes for Tracker id 356342 ENDS
		/*Changes for Ticketid:-(346500)Callid:-(158212)Changes Begin(Setting the same in AddressBO)*/
		NewAddressDet.setCore_cust_id(core_cust_id);
		/*Changes for Ticketid:-(346500)Callid:-(158212)Changes End*/
		//changes for tracker 410286 begin
		NewAddressDet.setStart_Date(currDate);
		SimpleDateFormat smplDF = new SimpleDateFormat("dd/MM/yyyy");
		Date hdCodedEndDate = null;
		try {
			hdCodedEndDate = smplDF.parse("31/12/2099");
		} catch (ParseException e ) {
			throw e;
		}
		NewAddressDet.setEnd_Date(hdCodedEndDate);
		//changes for tracker 410286 ends
		address.add(NewAddressDet);
		return acctBO;
	}

	/**
	 * @semantics populateCorporateBO method -populates corporatebo
	 * @param corpBO
	 * @param busCtxt
	 * @throws Exception
	 * @see n/a
	 */
	/*changes for ticket id 361968*/
	public CorporateBO populateCorporateBO(CorporateBO corpBO,SRMBusinessContext busCtxt)
	throws SRMBOException,SRMTypeValidatorException,CISInvalidArgumentException,
	SRMSecurityException,ParseException{

		/*	BEGIN: CRM_ARCH*/
		/*	return type of the getAgent() method changed
		 *	to SRMBOBase, hence being typecasted	*/
		loggedOnUser= ((AgentBO)AgentGroupMgr.getLoggedonUser(busCtxt).getAgent()).getAgentID();
		/*	END: CRM_ARCH*/

		/*	BEGIN: CRM_ARCH*/
		/*	return type of the getAgent() method changed
		 *	to SRMBOBase, hence being typecasted	*/
		sloggedUser = ((AgentBO)AgentGroupMgr.getLoggedonUser(busCtxt).getAgent()).getLoginID();
		/*	END: CRM_ARCH*/


		corpBO.setCrncy_Code(CUSTCURRENCY);
		corpBO.setIsDummy("Y");
		corpBO.setRelationship_CreatedBy(sloggedUser);
		corpBO.setSuspend_Flag("N");
		corpBO.setNegative_Flag("N");
		corpBO.setBlacklist_Flag("N");
		corpBO.setRecord_Status("A");
		corpBO.setEntity_Create_Flg("Y");
		//Changes for tracker ID 429896 starts
		corpBO.setPurge_Allowed_Flag("N");
		//Changes for tracker ID 429896 ends
		corpBO = populateCorpAdd(corpBO);
		return corpBO;

	}

	/**
	 * @semantics populateCorpAdd method -populates inner class of corporatebo
	 * @param corpBO
	 * @throws Exception
	 * @see n/a
	 */
	/*changes for ticket id 361968*/
	public CorporateBO populateCorpAdd(CorporateBO corpBO)
	throws SRMBOException,SRMTypeValidatorException,CISInvalidArgumentException,
	SRMSecurityException,ParseException{
		/*Changes for Ticketid:-(346500)Callid:-(158212)Changes Begin*/
		String core_cust_id = corpBO.getCore_Cust_ID();
		/*Changes for Ticketid:-(346500)Callid:-(158212)Changes End*/
		CorporateBO.Address NewAddressDet = (CorporateBO.Address)corpBO
		.getInstance("Address");
		SRMCollection address =corpBO.getAddress();
		NewAddressDet.setAddressCategory(ADDTYPE2);
		NewAddressDet.setPreferredAddress("N");
		NewAddressDet.setPreferredAddress(ADDFORMAT);
		/*Changes for Ticketid:-(346500)Callid:-(158212)Changes Begin*/
		NewAddressDet.setCore_Cust_ID(core_cust_id);
		/*Changes for Ticketid:-(346500)Callid:-(158212)Changes End*/
		/* Changes Begin for Ticket id- 361968*/
		NewAddressDet.setStart_Date(currDate);
		SimpleDateFormat smplDF = new SimpleDateFormat("dd/MM/yyyy");
		Date hdCodedEndDate = null;
		try {
			hdCodedEndDate = smplDF.parse("31/12/2099");
		} catch (ParseException e ) {
			throw e;
		}
		NewAddressDet.setEnd_Date(hdCodedEndDate);
		/* Changes end for Ticket id- 361968*/
		address.add(NewAddressDet);
		return corpBO;

	}


	/**
	 * @semantics updatePsychoDetails method -populates psychobo
	 * @param lAcctBO
	 * @throws Exception
	 * @see n/a
	 */


	public List updatePsychoDetails(List lAcctBO) throws SRMBOException,
	SRMTypeValidatorException,CISInvalidArgumentException,
	SRMSecurityException{

		int iSize = lAcctBO.size();
		int iAcctID = 0;
		String orgKey=null;
		/*Changes for Ticketid:-(346500)Callid:-(158212)Changes Begin*/
		String core_cust_id =null;
		/*Changes for Ticketid:-(346500)Callid:-(158212)Changes End*/
		List lPsychoBO = new ArrayList();
		if (lAcctBO!= null) {

			for(int iCnt=0; iCnt<iSize; iCnt++){

				iAcctID = ((AccountBO)(lAcctBO.get(iCnt))).getAccountID()
				.intValue();
				orgKey = ((AccountBO)(lAcctBO.get(iCnt))).getAccountKey();
				/*Changes for Ticketid:-(346500)Callid:-(158212)Changes Begin*/
				core_cust_id = ((AccountBO)(lAcctBO.get(iCnt))).getCore_cust_id();
				/*Changes for Ticketid:-(346500)Callid:-(158212)Changes End*/
				PsychographicBO psychoBO = new PsychographicBO();
				psychoBO.setAccountID(new Integer(iAcctID));
				psychoBO.setCustomerCurrency(CUSTCURRENCY);
				psychoBO.setOrgKey(orgKey);
				/*Changes for Ticketid:-(346500)Callid:-(158212)Changes Begin*/
				psychoBO = populatePsychCurr(psychoBO,core_cust_id);
				/*Changes for Ticketid:-(346500)Callid:-(158212)Changes End*/
				lPsychoBO.add(psychoBO);

			}
		}
		return lPsychoBO;
	}


	/**
	 * @semantics updateDemoDetails method -populates demobo
	 * @param lAcctBO
	 * @throws Exception
	 * @see n/a
	 */

	public List updateDemoDetails(List lAcctBO) throws SRMBOException,
	SRMTypeValidatorException,CISInvalidArgumentException,
	SRMSecurityException{

		int iSize = lAcctBO.size();
		int iAcctID = 0;
		List lDemoBO = new ArrayList();
		String orgKey=null;

		if (lAcctBO!= null) {

			for(int iCnt=0; iCnt<iSize; iCnt++){

				iAcctID = ((AccountBO)(lAcctBO.get(iCnt))).getAccountID()
				.intValue();
				orgKey = ((AccountBO)(lAcctBO.get(iCnt))).getAccountKey();
				DemographicBO demoBO = new DemographicBO();
				demoBO.setAccountID(new Integer(iAcctID));
				demoBO.setOrgKey(orgKey);
				lDemoBO.add(demoBO);

			}
		}
		return lDemoBO;
	}

	/**
	 * @semantics populatePsychCurr method -populates inner class of psychobo
	 * @param psyBO
	 * @throws Exception
	 * @see n/a
	 */
	/*Changes for Ticketid:-(346500)Callid:-(158212)Changes Begin(Including one more parameter to teh method definition)*/
	public PsychographicBO populatePsychCurr(PsychographicBO psyBO,String core_cust_id)
	throws SRMBOException,SRMTypeValidatorException,CISInvalidArgumentException,
	SRMSecurityException{

		PsychographicBO.MiscellaneousInfo NewMiscInfo = (PsychographicBO.MiscellaneousInfo)psyBO
		.getInstance("MiscellaneousInfo");
		SRMCollection miscInfo =psyBO.getMiscellaneousInfo();
		NewMiscInfo.setStrText10(CUSTCURRENCY);
		NewMiscInfo.setType(MISCTYPE);
		/*Changes for Ticketid:-(346500)Callid:-(158212)Changes Begin*/
		NewMiscInfo.setCore_cust_id(core_cust_id);
		NewMiscInfo.setEntity_cre_flg("Y");
		/*Changes for Ticketid:-(346500)Callid:-(158212)Changes End*/
		miscInfo.add(NewMiscInfo);
		return psyBO;

	}

	/**
	 * @semantics updatePreferenceDetails method -populates PreferenceDetails--
					---- Introducing PreferenceDetails for Currency Updation
	 * @param lAcctBO
	 * @throws Exception
	 * @see n/a
	 */
	//Call ID: 341571 Begin of changes
	public List updatePreferenceDetails(List lCorpBO) throws SRMBOException,
	SRMTypeValidatorException,CISInvalidArgumentException,
	SRMSecurityException{

		//System.out.println("Inside BulkCustomerHook cls n updatePreferenceDetails method");

		int iSize = lCorpBO.size();
		int iCorpID = 0;
		String sCorp_Key = null;
		String sCoreCustID = null;
		List lPRFBO = new ArrayList();
		if (lCorpBO!= null) {

			for(int iCnt=0; iCnt<iSize; iCnt++){

				iCorpID = ((CorporateBO)(lCorpBO.get(iCnt))).getCorp_ID().intValue();
				sCorp_Key = ((CorporateBO)(lCorpBO.get(iCnt))).getCorp_Key();
				sCoreCustID = ((CorporateBO)(lCorpBO.get(iCnt))).getCore_Cust_ID();

				PreferencesBO preferBO = new PreferencesBO();

				preferBO.setCorp_ID(new Integer(iCorpID));
				preferBO.setCore_Cust_ID(sCoreCustID);
				preferBO.setOrgKey(sCorp_Key);
				//System.out.println("before calling populatePreferCurr");
				preferBO = populatePreferCurr(preferBO,sCoreCustID);
				lPRFBO.add(preferBO);
			}
		}
		//System.out.println("after calling populatePreferCurr");
		return lPRFBO;
	}

	/**
	 * @semantics populatePreferCurr method -populates inner class of prefBO
	 * @param prefBO
	 * @throws Exception
	 * @see n/a
	 */

	public PreferencesBO populatePreferCurr(PreferencesBO prefBO, String sCoreCustID)
	throws SRMBOException,SRMTypeValidatorException,CISInvalidArgumentException,
	SRMSecurityException{

		//System.out.println("Inside populatePreferCurr of HOOK");

		PreferencesBO.CorpMiscellaneousInfo NewCorpMiscInfo = (PreferencesBO.CorpMiscellaneousInfo)prefBO
		.getInstance("CorpMiscellaneousInfo");
		SRMCollection corpmiscInfo =prefBO.getCorpMiscellaneousInfo();
		NewCorpMiscInfo.setStr1(CUSTCURRENCY);
		NewCorpMiscInfo.setType(PREFETYPE);
		NewCorpMiscInfo.setCore_Cust_ID(sCoreCustID);//Added by Vinay
		corpmiscInfo.add(NewCorpMiscInfo);
		//System.out.println("before return inside populatePreferCurr");
		return prefBO;
	}
	//Call ID: 341571 End of changes
}




