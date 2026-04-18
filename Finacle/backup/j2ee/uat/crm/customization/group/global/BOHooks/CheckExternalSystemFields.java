/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CheckEBankingFields.java $
 *
 * Author: Suman Kumar
 *
 *
 * *********************************** */

package com.infy.cis.custom;

import com.infy.cis.common.EditorUtil;
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.AccountBO;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.exception.*;
import com.infy.cis.srmbo.SRMBase;
import com.infy.cis.srmbo.AttrAccValidator;
import com.infy.cis.srmbo.ExceptThrow;
import com.infy.cis.srmbo.*;
import com.infy.cis.common.*;
import com.infy.cis.ui.common.*;
import com.infy.cis.log.*;
import com.infy.cis.adaptor.web.WebAdaptor;
import java.util.*;

import com.infosys.insulate.util.HashMap;
import com.infosys.insulate.util.Vector;
import com.infosys.insulate.util.ArrayList;
import com.infosys.insulate.util.HashSet;
import com.infosys.insulate.util.TreeSet;
import com.infosys.insulate.util.IdentityHashMap;
import com.infosys.insulate.util.LinkedHashMap;
import com.infosys.insulate.util.LinkedHashSet;
import com.infosys.insulate.util.LinkedList;
import com.infosys.insulate.util.Stack;
import com.infosys.insulate.util.TreeMap;
import com.infosys.insulate.util.WeakHashMap;
import com.infosys.insulate.util.PriorityQueue;
import com.infy.cis.srmbo.Core;
import java.util.Date;
import com.infosys.insulate.util.HashMap;
import java.util.Properties;
import java.text.SimpleDateFormat;

public class CheckExternalSystemFields {

  public static HashMap hmJMSEntry = new HashMap();
   public CheckExternalSystemFields(){}

	public String checkChangedFields (SRMBusinessContext bc, SRMBOBase srmbobase)
	 throws SRMPreWriteException,SRMSecurityException {

			String isUpdate="N";
			try {

				AttrAccValidator.validatecreate((SRMBase) srmbobase);
			} catch(SRMSecurityException e){
				throw new SRMSecurityException(SRMSecurityException.ERROR_ATTR_MASK, null) ;
			}

		try{
			if(srmbobase instanceof AccountBO){
				AccountBO boNew=(AccountBO)srmbobase;
				Integer acctID=boNew.getAccountID();
				String newCreFlag = boNew.getEntity_cre_flag();
 				if(acctID==null){
					//Its a new record in approval disabled case.
					String isEbankEnabled=boNew.getIsEbankingEnabled();
 					if(isEbankEnabled!=null && isEbankEnabled.equals("Y") && newCreFlag.equals("Y")){
						isUpdate="C";
					}
				}else{

					AccountBO boOld = (AccountBO)Core.getBOClone(boNew);
					if (boOld != null) {
					String isEBanking			= boOld.getIsEbankingEnabled();
					if(isEBanking == null)  isEBanking = "";
					String isSMSBanking			= boOld.getIsSMSBankingEnabled();
					if(isSMSBanking == null)  isSMSBanking = "";
					String isWAPBanking			= boOld.getIsWAPBankingEnabled();
					if(isWAPBanking == null)  isWAPBanking = "";
					String SMSMobileNo			= boOld.getSMSBankingMobileNumber();
					String entityCreFlag		= boOld.getEntity_cre_flag();
					String alreadyCreatedFlag	= boOld.getAlreadyCreatedInEBanking();
					if(alreadyCreatedFlag == null)  alreadyCreatedFlag = "";
					String salutation			= boOld.getSalutation();
					String firstName			= boOld.getCust_First_Name();
					String middleName			= boOld.getCust_Middle_Name();
					String lastName				= boOld.getCust_Last_Name();
					String gender				= boOld.getGender();
					String custNRE				= boOld.getCustomerNREFlg();
 					String defaultAddrType		= boOld.getDefaultAddressType();
 					SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
					String custDOBOld="";
 					if(boOld.getCust_DOB()!=null)
					 custDOBOld			= dateFormat.format(boOld.getCust_DOB());
					 if(custDOBOld==null){
							custDOBOld = "";
					}
					String custDOBNew="";
					if(boNew.getCust_DOB()!=null)
					 custDOBNew			= dateFormat.format(boNew.getCust_DOB());

 					if(custDOBNew==null){
							 custDOBNew = "";
					}
                    String salutationNew	    = boNew.getSalutation();
				    String firstNameNew		    = boNew.getCust_First_Name();
                    String middleNameNew		= boNew.getCust_Middle_Name();
                    String lastNameNew		    = boNew.getCust_Last_Name();
                    String genderNew			= boNew.getGender();
                    String custNRENew		    = boNew.getCustomerNREFlg();
                    String defaultAddrTypeNew   = boNew.getDefaultAddressType();
                     String SMSMobileNoNew		= boNew.getSMSBankingMobileNumber();

                    if(salutation==null){
							 salutation = "";
					}
                    if(firstName==null){
							 firstName = "";
					}
                    if(middleName==null){
							 middleName = "";
					}
                    if(lastName==null){
							 lastName = "";
					}
                    if(gender==null){
							 gender = "";
					}
                    if(custNRE==null){
							 custNRE = "";
					}
                     if(defaultAddrType==null){
							 defaultAddrType = "";
					}
                     if(SMSMobileNo==null){
							 SMSMobileNo = "";
					}

                    if(salutationNew==null){
							 salutationNew = "";
					}
                    if(firstNameNew==null){
							 firstNameNew = "";
					}
                    if(middleNameNew==null){
							 middleNameNew = "";
					}
                    if(lastNameNew==null){
							 lastNameNew = "";
					}
                    if(genderNew==null){
							 genderNew = "";
					}
                    if(custNRENew==null){
							 custNRENew = "";
					}
                     if(defaultAddrTypeNew==null){
							 defaultAddrTypeNew = "";
					}
                    if(SMSMobileNoNew==null){
							 SMSMobileNoNew = "";
					}

  					if(newCreFlag.equals("Y"))
					{
						if(entityCreFlag.equals("N")){
							//Its a new record in approval enabled case
 							String isEbankEnabled=boNew.getIsEbankingEnabled();
 							String alreadyCreated=boNew.getAlreadyCreatedInEBanking();
 							if(alreadyCreated==null){
								alreadyCreated = "";
							}
							/* tracker:145883 :BEGIN */
							if(isEbankEnabled==null){
								isEbankEnabled = "";
							}
							/* tracker:145883 :END */
							if(isEbankEnabled.equals("Y") && !alreadyCreated.equals("Y")){
									isUpdate="CE";
								}
							}else{

							String isEBankEnabledNew = boNew.getIsEbankingEnabled();
							String isSMSBankingNew = boNew.getIsSMSBankingEnabled();
							String isWAPBankingNew = boNew.getIsWAPBankingEnabled();
							if(isEBankEnabledNew == null)  isEBankEnabledNew = "";
							//E-banking CR changes uday Start
							if(isSMSBankingNew==null){
								isSMSBankingNew="";
							}
							if(isWAPBankingNew==null){
								isWAPBankingNew="";
							}
							//E-banking CR changes uday End
						//	//System.out.println("isEBankEnabledNew: "+isEBankEnabledNew);
						//	//System.out.println("getIsSMSBankingEnabled: "+boNew.getIsSMSBankingEnabled());
							//Its a case of edit of approved record.
 							if(!isEBanking.equals(isEBankEnabledNew)||!isSMSBanking.equals(isSMSBankingNew)
								|| !isWAPBanking.equals(isWAPBankingNew)
								||(isEBankEnabledNew.equals("Y") && !SMSMobileNo.equals(SMSMobileNoNew))){

									if(alreadyCreatedFlag.equals("N") && isEBankEnabledNew.equals("Y")){
										isUpdate="C";
									}else {
										isUpdate="E";
									}

								}
							 if(("Y").equals(alreadyCreatedFlag)){
								 	// Changes for phone-email
									boolean addrChange = compareCustomerPhoneFields(boNew,boOld);
								 if(!salutation.equals(salutationNew) || !firstName.equals(firstNameNew)
								    || !middleName.equals(middleNameNew) || !lastName.equals(lastNameNew)
								    || !gender.equals(genderNew)|| !custNRE.equals(custNRENew)
								    || !defaultAddrType.equals(defaultAddrTypeNew) || !custDOBOld.equals(custDOBNew)
								    || addrChange){
										isUpdate = "E";
									}
						   		}
							}
						}
					}
					}

		} else if(srmbobase instanceof CorporateBO){
			//Write the similar logic for corporate BO
			CorporateBO corpBONew = (CorporateBO)srmbobase;
			Integer corpID = corpBONew.getCorp_ID();
			String newCreFlag = corpBONew.getEntity_Create_Flg();
			String isEbankEnabled=corpBONew.getIsEbankingEnabled();
            if(isEbankEnabled == null)  isEbankEnabled = "";


			if(corpID==null){
			    if(isEbankEnabled!="")
			    {
				 if(isEbankEnabled.equals("Y") && newCreFlag.equals("Y")){
					isUpdate="C";
				}
				}
			}
			else
			{
				CorporateBO corpBOOld = (CorporateBO)Core.getBOClone(corpBONew);
				 //E-banking CR changes uday Start
				if(corpBOOld!=null){
				//E-banking CR changes uday END
				String isEBanking				= corpBOOld.getIsEbankingEnabled();
				if(isEBanking == null)  isEBanking = "";

 				String entityCreFlag			= corpBOOld.getEntity_Create_Flg();
				String alreadyCreatedFlag		= corpBOOld.getAlreadyCreatedInEBanking();

                if(alreadyCreatedFlag == null)  alreadyCreatedFlag = "";

				String corpName					= corpBOOld.getCorporate_Name();
				String corpPhone				= corpBOOld.getPhone();
				String corpEmail				= corpBOOld.getEmail2();
				String corpBusinessType			= corpBOOld.getBusiness_Type();
				Date DateOfInc				    = corpBOOld.getDate_Of_Incorporation();

				String corpNameNew				= corpBONew.getCorporate_Name();
				String corpPhoneNew				= corpBONew.getPhone();
				String corpEmailNew				= corpBONew.getEmail2();
				String corpBusinessTypeNew		= corpBONew.getBusiness_Type();
				Date DateOfIncNew				= corpBONew.getDate_Of_Incorporation();

				//E-banking CR changes uday Start
 				//SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");


 				long dateIncOld=0;
				long dateIncNew=0;
				if(DateOfInc==null || DateOfInc.equals("")){
					dateIncOld=0;
				}else{
					dateIncOld			= DateOfInc.getTime();
				}

				if(DateOfIncNew==null || DateOfIncNew.equals("")){
					dateIncNew=0;
				}else{
					dateIncNew			= DateOfIncNew.getTime();
				}


				/*if(DateOfInc!=null){
					String dateIncOld			= dateFormat.format(DateOfInc);
				}
				if(DateOfIncNew!=null){
					String dateIncNew			= dateFormat.format(DateOfIncNew);
			    }*/

				if(isEBanking == null)
					isEBanking = "";
				if(alreadyCreatedFlag == null)
					alreadyCreatedFlag = "";

				//E-banking CR changes uday end
  				if(corpName==null){
					corpName = "";
				}
				if(corpPhone==null){
					corpPhone = "";
				}
				if(corpEmail==null){
					corpEmail = "";
				}
				if(corpBusinessType==null){
					corpBusinessType = "";
				}


 				if(corpNameNew==null){
					corpNameNew = "";
				}
				if(corpPhoneNew==null){
					corpPhoneNew = "";
				}
				if(corpEmailNew==null){
					corpEmailNew = "";
				}
				if(corpBusinessTypeNew==null){
					corpBusinessTypeNew = "";
				}

 				if(newCreFlag.equals("Y"))
				{
					if(entityCreFlag.equals("N"))
					{
                                // Its a new record in approval enabled case
                                if(isEbankEnabled!="")
                                {
                                   if(isEbankEnabled.equals("Y"))
                                   {
                                       isUpdate="C";
                                   }
							    }
                    }

                    else
                    {
                                if(isEbankEnabled!="")
                                {
                                       if(!isEBanking.equals(isEbankEnabled))
                                       {
										   if(alreadyCreatedFlag.equals("N") && isEbankEnabled.equals("Y"))
										   {
										   			isUpdate="C";
										   }

										   else
										   {
										   			isUpdate="E";
										   }
									   }
								 }

								if(alreadyCreatedFlag!="")
								{
									if(alreadyCreatedFlag.equals("Y"))
									{
										// changes for phone email
										boolean corpAddrChange = compareCorpPhoneFields(corpBONew,corpBOOld);

										if( !corpName.equals(corpNameNew)|| !corpPhone.equals(corpPhoneNew)
									    || !corpEmail.equals(corpEmailNew)|| !corpBusinessType.equals(corpBusinessTypeNew)
									    /*|| !dateIncOld.equals(dateIncNew)*/ || corpAddrChange
							   		  )
							   		  {
										  isUpdate = "E";
									  }
									}
								}

				}

			 }
			}//end of else - if(corpid==null)
		}
	}

		else if(srmbobase instanceof DemographicBO){
			//Write the similar logic for DemographicBO

 			DemographicBO boDemo = (DemographicBO)srmbobase;
			Integer demoID	 = boDemo.getDemographicID();
			ArrayList alOldFields = getOldBO(bc,demoID.toString(),"Demographic");
			String oldMaritalStatus=(String)alOldFields.get(0);
			String isEbankEnabled=(String)alOldFields.get(1);
			String alreadyCreatedFlag=(String)alOldFields.get(2);
			String newMaritalStatus = boDemo.getMarital_Status();

			DemographicBO boDemoOld = (DemographicBO)Core.getBOClone(boDemo);

			if(alreadyCreatedFlag!=null && alreadyCreatedFlag.equals("Y") && isEbankEnabled.equals("Y"))
			{
				if(newMaritalStatus==null)
				{
					newMaritalStatus = "";
				}

 				if(!newMaritalStatus.equals(oldMaritalStatus))
				{
					isUpdate="E";
				}

 			}



		}else if(srmbobase instanceof PsychographicBO){
			//Write the similar logic for corporate BO
			PsychographicBO boPsycho = (PsychographicBO)srmbobase;
			Integer psychoID	 = boPsycho.getPsychographicID();
			ArrayList alOldFields = getOldBO(bc,psychoID.toString(),"Psychographic");
			String oldHobbyField1=(String)alOldFields.get(0);
			String isEbankEnabled=(String)alOldFields.get(1);
			String alreadyCreatedFlag=(String)alOldFields.get(2);
			String newHobbyField1 = boPsycho.getHobbyField1();
			if(alreadyCreatedFlag!=null && alreadyCreatedFlag.equals("Y") && isEbankEnabled.equals("Y"))
			{
				if(newHobbyField1==null)
				{
					newHobbyField1 = "";
				}
 				if(!newHobbyField1.equals(oldHobbyField1))
				{
					isUpdate="E";
				}
 			}

		}else if(srmbobase instanceof TradeFinanceBO){
			//Write the similar logic for TradeFinanceBO
		}else if(srmbobase instanceof RelBankBO){
			//Write the similar logic for RelBankBO
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
 		 catch (Exception e)
		 { e.printStackTrace();
			 ExceptThrow.Throw(
			 new SRMPreWriteException(SRMPreWriteException.ERROR_INTERNAL, e));
		 }

		 return isUpdate;
	}

	 public  ArrayList getOldBO(SRMBusinessContext bc,String sAccessID, String accessType)
	     throws SRMIllegalURLException, CISInvalidArgumentException, SRMBOException, SRMSecurityException, ClassNotFoundException, CISConfigException {
 	 		/* CRA10MSC - ARM - Begin of changes : Starting BL Layer transaction */


	 		/* CRA10MSC - ARM - End of changes */
			ArrayList alQueryFields = new ArrayList();
			ArrayList oldFields=new  ArrayList();
			SRMQueryBuilder qbOldValues = new SRMQueryBuilder();
 			if(accessType.equals("Demographic"))
			{
   			    alQueryFields.add(QueryAssist.getTransformFn("DemographicBO", DemographicBO.MARITAL_STATUS));
  			    alQueryFields.add(QueryAssist.getTransformFn("AccountBO",AccountBO.ISEBANKINGENABLED));
				alQueryFields.add(QueryAssist.getTransformFn("AccountBO",AccountBO.ALREADYCREATEDINEBANKING));

	            QueryAssist.addJoin(qbOldValues, "DemographicBO", DemographicBO.DEMOGRAPHICID,
	                               "DemographicBO",  DemographicBO.DEMOGRAPHICID, IQuery.JoinType_Equi);
	            QueryAssist.addJoin(qbOldValues, "DemographicBO", DemographicBO.ACCOUNTID,
	                               "AccountBO",  AccountBO.ACCOUNTID, IQuery.JoinType_Equi);
				QueryAssist.addSimpleCondition(qbOldValues, "DemographicBO", DemographicBO.DEMOGRAPHICID, IQuery.ComparisonOperation_EQ,""+sAccessID);
				for (int b=0; b<alQueryFields.size(); b++){
					qbOldValues.addAttribScope((TransFormFn) alQueryFields.get(b));
				}

 				SRMQueryResult qrOldValues = qbOldValues.runQuery(bc,-1);
				SRMRecordSet rsOldValues = qrOldValues.getRecordSet();
	 			ArrayList alBcknd 					= null;
	 			String strMaritalStatus 			= null;
	 			String strIsEbankEnabled			= null;
	 			String strAlreadyCreatedInEbanking  = null;


	 			if(rsOldValues.hasNext()){
 					alBcknd = (ArrayList)rsOldValues.getNext();
					if(null != alBcknd){
 						strMaritalStatus				= (String)alBcknd.get(0);
 						strIsEbankEnabled				= (String)alBcknd.get(1);
						strAlreadyCreatedInEbanking		= (String)alBcknd.get(2);
						if(strMaritalStatus==null){
							strMaritalStatus = "";
						}
						oldFields.add(strMaritalStatus);
 						oldFields.add(strIsEbankEnabled);
						oldFields.add(strAlreadyCreatedInEbanking);

					}

				}else
				{
						oldFields.add(strMaritalStatus);
 						oldFields.add(strIsEbankEnabled);
						oldFields.add(strAlreadyCreatedInEbanking);
				}
			 }
			else if(accessType.equals("Psychographic"))
			{
  			    alQueryFields.add(QueryAssist.getTransformFn("PsychographicBO", PsychographicBO.HOBBYFIELD1));
  			    alQueryFields.add(QueryAssist.getTransformFn("AccountBO",AccountBO.ISEBANKINGENABLED));
				alQueryFields.add(QueryAssist.getTransformFn("AccountBO",AccountBO.ALREADYCREATEDINEBANKING));

	            QueryAssist.addJoin(qbOldValues, "PsychographicBO", PsychographicBO.PSYCHOGRAPHICID,
	                               "PsychographicBO",  PsychographicBO.PSYCHOGRAPHICID, IQuery.JoinType_Equi);
	            QueryAssist.addJoin(qbOldValues, "PsychographicBO", PsychographicBO.ACCOUNTID,
	                               "AccountBO",  AccountBO.ACCOUNTID, IQuery.JoinType_Equi);
				QueryAssist.addSimpleCondition(qbOldValues, "PsychographicBO", PsychographicBO.PSYCHOGRAPHICID, IQuery.ComparisonOperation_EQ,""+sAccessID);
				for (int b=0; b<alQueryFields.size(); b++){
					qbOldValues.addAttribScope((TransFormFn) alQueryFields.get(b));
				}
				SRMQueryResult qrOldValues = qbOldValues.runQuery(bc,-1);
				SRMRecordSet rsOldValues = qrOldValues.getRecordSet();
	 			ArrayList alBcknd = null;
	 			String strHobbyField1	 			= null;
	 			String strIsEbankEnabled			= null;
	 			String strAlreadyCreatedInEbanking  = null;

	 			if(rsOldValues.hasNext()){
					alBcknd = (ArrayList)rsOldValues.getNext();
					if(null != alBcknd){
						strHobbyField1				= (String)alBcknd.get(0);
 						strIsEbankEnabled				= (String)alBcknd.get(1);
						strAlreadyCreatedInEbanking		= (String)alBcknd.get(2);
						if(strHobbyField1==null){
							strHobbyField1 = "";
						}
						oldFields.add(strHobbyField1);
 						oldFields.add(strIsEbankEnabled);
						oldFields.add(strAlreadyCreatedInEbanking);

					}

				}
				else
				{
						oldFields.add(strHobbyField1);
 						oldFields.add(strIsEbankEnabled);
						oldFields.add(strAlreadyCreatedInEbanking);
				}
			 }


	 			/* CRA10MSC - ARM - Begin of changes : Stopping BL Layer transaction */

	 			/* CRA10MSC - ARM - End of changes */
 	        	 return oldFields;
		}

		// phone email changes
		public boolean compareCustomerPhoneFields(AccountBO boNew,AccountBO boOld)
		{

			boolean isChange			 = false;
			SRMCollection oldPhoneColl	 = boOld.getPhoneEmail();
			SRMCollection newPhoneColl	 = boNew.getPhoneEmail();

			if(null!=oldPhoneColl){ //EBanking CR change
				int noOfOldPhone			 = oldPhoneColl.size();
				int noOfNewPhone			 = newPhoneColl.size();
				List newPhoneList			 = new ArrayList();
				List oldPhoneList			 = new ArrayList();
				if (noOfOldPhone!=noOfNewPhone) {
					return true;
				}
				for(int i=0;i<noOfNewPhone;i++)
				{
					AccountBO.PhoneEmail newPhone = (AccountBO.PhoneEmail)newPhoneColl.get(i);
					Integer newPhoneID = newPhone.getPhoneEmailID();
					newPhoneList.add(newPhoneID);

					String newPhEmailType	= newPhone.getPhoneEmailType();
					String newPhoneNo		= newPhone.getPhoneNo();
					String newWorkExt		= newPhone.getWorkExtension();
					String newEmail			= newPhone.getEmail();
					String newEmailPalm		= newPhone.getEmailPalm();
					String newPhOrEmail		= newPhone.getPhoneOrEmail();

					if(newPhEmailType==null){
						newPhEmailType = "";
					}
					if(newPhoneNo==null){
						newPhoneNo = "";
					}
					if(newWorkExt==null){
						newWorkExt = "";
				}
  			    if(newEmail==null){
					newEmail = "";
				}
					if(newEmailPalm==null){
						newEmailPalm = "";
					}
					if (newPhOrEmail ==null) {
						newPhOrEmail ="";
					}

					for(int j=0;j<noOfOldPhone;j++)
					{
						AccountBO.PhoneEmail oldPhone = (AccountBO.PhoneEmail)oldPhoneColl.get(j);
						Integer oldPhoneID = oldPhone.getPhoneEmailID();
					if(i==0){
							oldPhoneList.add(oldPhoneID);
						}
						if(newPhoneID==null || !newPhoneID.equals(oldPhoneID)){
						continue;
					}
					else
					{

							String oldPhEmailType	= oldPhone.getPhoneEmailType();
							String oldPhoneNo		= oldPhone.getPhoneNo();
							String oldWorkExt		= oldPhone.getWorkExtension();
							String oldEmail			= oldPhone.getEmail();
							String oldEmailPalm		= oldPhone.getEmailPalm();
							String oldPhOrEmail		= oldPhone.getPhoneOrEmail();

							if(oldPhEmailType==null){
								oldPhEmailType = "";
							}
							if(oldPhoneNo==null){
								oldPhoneNo = "";
							}
							if(oldWorkExt==null){
								oldWorkExt = "";
						}
						if(oldEmail==null){
							oldEmail = "";
						}
							if(oldEmailPalm==null){
								oldEmailPalm = "";
							}

							if (oldPhOrEmail==null) {
								oldPhOrEmail ="";
							}

							if (!newPhOrEmail.equals(oldPhOrEmail) || !newPhEmailType.equals(oldPhEmailType) ||
								!newPhoneNo.equals(oldPhoneNo) || !newWorkExt.equals(oldWorkExt) || !newEmail.equals(oldEmail)
								|| !newEmailPalm.equals(oldEmailPalm) ) {
							  isChange = true;
							  break;
					   	   }

						 }
					}
					if(!oldPhoneList.contains(newPhoneID)){
					isChange = true;
				}
 				if(isChange)
				{
					break;
				}
			}
			if(!isChange){
					int oldListSize = oldPhoneList.size();
				for(int i=0;i<oldListSize;i++){
						Integer oldId = (Integer)oldPhoneList.get(i);
						if(!newPhoneList.contains(oldId)){
						isChange = true;
					}
				}
 			}
			}
			else if (newPhoneColl!=null){
				isChange = true;
			}
			return isChange;
 		}

		public boolean compareCorpPhoneFields(CorporateBO boNew,CorporateBO boOld)
		{
			boolean isChange			 = false;
			SRMCollection oldPhoneColl	 = boOld.getPhoneEmail();
			SRMCollection newPhoneColl	 = boNew.getPhoneEmail();

			if(null!=oldPhoneColl){ //EBanking CR change
				int noOfOldPhone			 = oldPhoneColl.size();
				int noOfNewPhone			 = newPhoneColl.size();
				List newPhoneList			 = new ArrayList();
				List oldPhoneList			 = new ArrayList();

				if (noOfOldPhone!=noOfNewPhone) {
					return true;
				}
				for(int i=0;i<noOfNewPhone;i++)
				{
					CorporateBO.PhoneEmail newPhone = (CorporateBO.PhoneEmail)newPhoneColl.get(i);
					Integer newPhoneID = newPhone.getPhoneEmailID();
					newPhoneList.add(newPhoneID);

					String newPhEmailType	= newPhone.getPhoneEmailType();
					String newPhoneNo		= newPhone.getPhoneNo();
					String newWorkExt		= newPhone.getWorkExtension();
					String newEmail			= newPhone.getEmail();
					String newEmailPalm		= newPhone.getEmailPalm();
					String newPhOrEmail		= newPhone.getPhoneOrEmail();

					if(newPhEmailType==null){
						newPhEmailType = "";
					}
					if(newPhoneNo==null){
						newPhoneNo = "";
					}
					if(newWorkExt==null){
						newWorkExt = "";
					}
					if(newEmail==null){
						newEmail = "";
					}
					if(newEmailPalm==null){
						newEmailPalm = "";
					}
					if (newPhOrEmail ==null) {
						newPhOrEmail ="";
					}

					for(int j=0;j<noOfOldPhone;j++)
					{
						CorporateBO.PhoneEmail oldPhone = (CorporateBO.PhoneEmail)oldPhoneColl.get(j);
						Integer oldPhoneID = oldPhone.getPhoneEmailID();
					if(i==0){
							oldPhoneList.add(oldPhoneID);
						}
						if(newPhoneID==null || !newPhoneID.equals(oldPhoneID)){
						continue;
					}
					else
					{

							String oldPhEmailType	= oldPhone.getPhoneEmailType();
							String oldPhoneNo		= oldPhone.getPhoneNo();
							String oldWorkExt		= oldPhone.getWorkExtension();
							String oldEmail			= oldPhone.getEmail();
							String oldEmailPalm		= oldPhone.getEmailPalm();
							String oldPhOrEmail		= oldPhone.getPhoneOrEmail();

							if(oldPhEmailType==null){
								oldPhEmailType = "";
							}
							if(oldPhoneNo==null){
								oldPhoneNo = "";
							}
							if(oldWorkExt==null){
								oldWorkExt = "";
							}
							if(oldEmail==null){
								oldEmail = "";
							}
							if(oldEmailPalm==null){
								oldEmailPalm = "";
							}

							if (oldPhOrEmail==null) {
								oldPhOrEmail ="";
							}

							if (!newPhOrEmail.equals(oldPhOrEmail) || !newPhEmailType.equals(oldPhEmailType) ||
								!newPhoneNo.equals(oldPhoneNo) || !newWorkExt.equals(oldWorkExt) || !newEmail.equals(oldEmail)
								|| !newEmailPalm.equals(oldEmailPalm) ) {
							  isChange = true;
							  break;
					   	   }

						 }
					}
					if(!oldPhoneList.contains(newPhoneID)){
					isChange = true;
				}
				if(isChange)
				{
					break;
				}
			}
			if(!isChange){
					int oldListSize = oldPhoneList.size();
				for(int i=0;i<oldListSize;i++){
						Integer oldId = (Integer)oldPhoneList.get(i);
						if(!newPhoneList.contains(oldId)){
						isChange = true;
					}
				}
 			}
			}
			else if (newPhoneColl!=null){
				isChange = true;
			}
			return isChange;
		}

		/* EBanking CR changes -- start */
	public static String getOrgKey(SRMBusinessContext bc,Integer iAccountID) throws Exception
		{
			String sOrgKey=null;
			SRMQueryBuilder qbID = QueryAssist.singleObjectQuery("AccountBO",AccountBO.ACCOUNTID);
	      	QueryAssist.addSimpleCondition(qbID, "AccountBO", AccountBO.ACCOUNTID, IQuery.ComparisonOperation_EQ,""+iAccountID);
	        qbID.addAttribScope (AccountBO.ATTR_ACCOUNTKEY);
	        SRMQueryResult qrID = qbID.runQuery(bc, false, -1);
			SRMRecordSet rsID = qrID.getRecordSet();

			if(rsID!=null && rsID.hasNext())
			{
				ArrayList lIDList = (ArrayList)rsID.getNext();
				sOrgKey = (String)lIDList.get(0);
			}

			return sOrgKey;
	}
		/* EBanking CR changes -- end */
 }








