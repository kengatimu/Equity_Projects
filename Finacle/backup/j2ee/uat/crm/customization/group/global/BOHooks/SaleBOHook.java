/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: SalesBOHook.java $
 *
 * Author: Bijit Borah
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/SalesBOHook.java $
 *
 * *********************************** */

/* CRM61SR:SRCIUHBO:TRACKER# 44231 **BEGIN  CHANGES** */
package com.infy.cis.custom;

import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.SaleBO;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.exception.*;
import com.infy.cis.srmbo.Core;
import com.infy.cis.srmbo.SRMQueryBuilder;
import com.infy.cis.srmbo.IQuery;
import com.infy.cis.srmbo.OpportunityBO;
import com.infy.cis.srmbo.SRMQueryResult;
import com.infy.cis.srmbo.SRMRecordSet;
import com.infy.cis.ui.common.QueryAssist;
import com.infy.cis.srmbo.SRMBase;
import com.infy.cis.srmbo.AttrAccValidator;
import com.infy.cis.srmbo.AccountBO;
import com.infy.cis.srmbo.SuspectBO;
import com.infy.cis.srmbo.ContactBO;

import java.util.Date;
import java.util.List;
import com.infosys.insulate.util.HashMap;
import com.infosys.insulate.util.ArrayList;

public class SaleBOHook implements IHooks {

   public SaleBOHook(){}

// sample hook - postWrite

 /* public void preWrite (SRMBusinessContext bc, Object bo)
    //throws SRMPreWriteException {
    //    customized implementation place holder
   //SaleBO abo = (SaleBO)bo;
      } */

  /* CRM61LR:TRACKER:44575:BEGINOFCHANGES */

    public void preWrite (SRMBusinessContext bc, Object bo)
    throws SRMPreWriteException,SRMSecurityException{
        // customized implementation place holder
        SaleBO boSale = (SaleBO)bo;
        //Tracker:90196: Changes for attibute masking
		try {
			AttrAccValidator.validatecreate((SRMBase) bo);
		} catch(SRMSecurityException e) {
			throw new SRMSecurityException(SRMSecurityException.ERROR_ATTR_MASK, null) ;
		}

		//Tracker:90196: End of Changes
		try {

        HashMap applcfg = SizeUtil.getApplConfig (bc, "ProductID", boSale.getProductID());
        if (applcfg != null) {
            SRMBOException boe = null;
            String parent = "SaleBO";
            boe = SizeUtil.checkFieldSizes (boSale, applcfg, boe);

            // Verify SaleGenInfo...
            if (boSale.getSaleGenInfo() != null) {
                SRMCollection geninfColl = boSale.getSaleGenInfo();
                SaleBO.SaleGenInfo geninf = null;
                for (int i = 0; i < geninfColl.size(); ++i) {
                    geninf = (SaleBO.SaleGenInfo)geninfColl.get(i);
                    boe = SizeUtil.checkFieldSizes (geninf, parent, geninf.getSaleInfoType(), applcfg, boe);
                }
            }
			Integer opprID  = boSale.getOpportunityID();
			SRMQueryBuilder querybuilder = null;

            String applStatus = boSale.getApplStatus();
            if(applStatus!=null && applStatus.equalsIgnoreCase("Closed")){
				/* Method call to get the ID and CIF Type of Main Account Holder */
				ArrayList macDetails = getMainAcctHolder(boSale);
				if(macDetails!=null && !macDetails.isEmpty()){
					Integer macOrgID 	 = (Integer)macDetails.get(0);
					String macCIFType	 = (String)macDetails.get(1);
					if(macOrgID!=null && macCIFType!=null){
					/* Method call to get the Access Control Attributes of the Main Account Holder */
					ArrayList accessAttribs = getEntityAccessAttributes(bc,macOrgID,macCIFType);
						if(accessAttribs!=null && !accessAttribs.isEmpty()){
						boSale.setAccessOwnerAgent((Integer)accessAttribs.get(0));
						boSale.setAccessAssigneeAgent((Integer)accessAttribs.get(1));
						boSale.setAccessOwnerGroup((Integer)accessAttribs.get(2));
						boSale.setAccessOwnerBC((Integer)accessAttribs.get(3));
						boSale.setAccessOwnerSegment((String)accessAttribs.get(4));
						}/* End of if block to get Access Attributes */
					}

				}

			}else{
 			/******************* Tracker 89798 Begin Of Changes******************/
            querybuilder = QueryAssist.singleObjectQuery("OpportunityBO", OpportunityBO.OPPORTUNITYID);
            QueryAssist.addSimpleCondition(querybuilder,  "OpportunityBO",  OpportunityBO.OPPORTUNITYID, IQuery.ComparisonOperation_EQ, opprID);
            querybuilder.addAttribScope ( QueryAssist.getTransformFn ("OpportunityBO",  OpportunityBO.ACCESSOWNERAGENT) );
            querybuilder.addAttribScope ( QueryAssist.getTransformFn ("OpportunityBO",  OpportunityBO.ACCESSASSIGNEEAGENT ) );
            querybuilder.addAttribScope ( QueryAssist.getTransformFn ("OpportunityBO",  OpportunityBO.ACCESSOWNERGROUP ) );
            querybuilder.addAttribScope ( QueryAssist.getTransformFn ("OpportunityBO",  OpportunityBO.ACCESSOWNERBC ) );
            querybuilder.addAttribScope ( QueryAssist.getTransformFn ("OpportunityBO",  OpportunityBO.ACCESSOWNERSEGMENT ) );

            SRMRecordSet srmRecSet = null;

            SRMQueryResult queryRes  =  querybuilder.runQuery(bc , -1);
            srmRecSet = queryRes.getRecordSet();


            List result = null;
            if (srmRecSet.hasNext()) {
                result = srmRecSet.getNext();
            }

			if(null != result) {
				if(null != result.get(0)) {
					boSale.setAccessOwnerAgent(new Integer(result.get(0).toString()));
				}
				if(null != result.get(1)) {
					boSale.setAccessAssigneeAgent(new Integer(result.get(1).toString()));
				}
				if(null != result.get(2)) {
					boSale.setAccessOwnerGroup(new Integer(result.get(2).toString()));
				}
				if(null != result.get(3)) {
					boSale.setAccessOwnerBC(new Integer(result.get(3).toString()));
				}
				if(null != result.get(4)) {
					boSale.setAccessOwnerSegment(result.get(4).toString());
				}
			}


                }
			/* ***** Tracker#122906 BETA Fixes : End ***** */
            /******************* Tracker 89798 End Of Changes******************/

            // Verify other inner classes...
            boe = SizeUtil.checkFieldSizes (boSale.getSaleCustomer(), parent, applcfg, boe);
            boe = SizeUtil.checkFieldSizes (boSale.getSaleContact(), parent, applcfg, boe);
            boe = SizeUtil.checkFieldSizes (boSale.getSaleProspect(), parent, applcfg, boe);
            boe = SizeUtil.checkFieldSizes (boSale.getSaleDocument(), parent, applcfg, boe);

            if (boe != null) {
                throw new SRMPreWriteException (boe.getErrorCode(), boe);
            }
        }
      }catch (Exception e){
	   throw new SRMPreWriteException (SRMBaseException.ERROR_INTERNAL, e);
      }
     }

 /* CRM61LR:TRACKER:44575:ENDOFCHANGES */



// sample hook - postWrite

  public void postWrite (SRMBusinessContext bc, Object bo)
    throws SRMPostWriteException {
/* CRM61SR:SREVNTBO:TRACKER# 44228 **BEGIN CHANGES** */
       // customized implementation place holder
   //SaleBO abo = (SaleBO)bo;
   /*
    try{

        SaleBO boSales = (SaleBO)bo;
        Integer SalesId = boSales.getSalesID();
        String sEventFor = "Application";
        String sEventType = "DOB";
        Date dEventDate = boSales.getCust_DOB();
        String sEventDesc = "Date of Birth";
        boolean bEditable = false;
        Core.CreateNewEvent(bc,sEventFor,SalesId,sEventType,dEventDate,sEventDesc,bEditable);
    }catch(Exception e){
        throw new SRMPostWriteException(SRMPostWriteException.ERROR_EVENT_WRITEFAILURE,e);
    }
   */
/* CRM61SR:SREVNTBO:TRACKER# 44228 **END OF CHANGES** */
   }

// sample hook - preDelete
  public void preDelete (SRMBusinessContext bc, Object bo)
    throws SRMPreDeleteException {
           // customized implementation place holder

   }

// sample hook - postDelete
  public void postDelete (SRMBusinessContext bc, Object bo)
    throws SRMPostDeleteException {
           // customized implementation place holder
         }
// sample hook - preFill

  public void preFill (SRMBusinessContext bc, Object bo)
    throws SRMPreFillException {
           // customized implementation place holder

   }

// sample hook - postFill
  public void postFill (SRMBusinessContext bc, Object bo)
    throws SRMPostFillException {
        // customized implementation place holder
       }

/* ***** Tracker#122906 BETA Fixes ***** */
/* method getMainAcctHolder
 * Returns a list containing the ID and CIF Type of the Main Account Holder for the particular account
 */
  public ArrayList getMainAcctHolder(SaleBO boSale) throws Exception{
		boolean macFlag  = false;
		ArrayList macDetails = new ArrayList();
        /* Tracker# 124202 - BETA fixes */
		Integer macOrgID =null;
		SRMCollection saleCustColl = boSale.getSaleCustomer();
		/*  Tracker# 124202 : Null check introduced to handle partial bo write */
		if(saleCustColl!=null){
			int iSaleCustSize      = saleCustColl.size();
		for(int i=0;i<iSaleCustSize;i++){
			SaleBO.SaleCustomer saleCust = (SaleBO.SaleCustomer)saleCustColl.get(i);
			String sRole = saleCust.getRole();
			if(sRole!=null && sRole.trim().equalsIgnoreCase("Main Account Holder")){
				macOrgID = saleCust.getOrgID();
				macFlag = true;
				macDetails.add(macOrgID);
				macDetails.add("Customer");
				break;
			}
		}//end of for loop
		}/* end of null check for collection*/
		if(!macFlag){
			SRMCollection salePropsectColl = boSale.getSaleProspect();
			/*  Tracker# 124202 : Null check introduced to handle partial bo write */
			if(salePropsectColl!=null){
			int iSaleProspectSize = salePropsectColl.size();
			for(int i=0;i<iSaleProspectSize;i++){
				SaleBO.SaleProspect saleProspect = (SaleBO.SaleProspect)salePropsectColl.get(i);
				String sRole = saleProspect.getRole();
				if(sRole!=null && sRole.trim().equalsIgnoreCase("Main Account Holder")){
					macOrgID = saleProspect.getSuspectID();
					macFlag = true;
					macDetails.add(macOrgID);
					macDetails.add("Prospect");
					break;
				}
			}//end of for loop
			}/* end of null check for collection*/

		}
		if(!macFlag){
			SRMCollection saleContactColl = boSale.getSaleContact();
			/* Tracker# 124202 : Null check introduced to handle partial bo write */
			if(saleContactColl!=null){
			int iSaleContactSize = saleContactColl.size();
			for(int i=0;i<iSaleContactSize;i++){
				SaleBO.SaleContact saleContact = (SaleBO.SaleContact)saleContactColl.get(i);
				String sRole = saleContact.getRole();
				if(sRole!=null && sRole.trim().equalsIgnoreCase("Main Account Holder")){
					macOrgID = saleContact.getContactID();
					macDetails.add(macOrgID);
					macDetails.add("Contact");
					break;
				}
			}//end of for loop
			}/* end of null check for collection*/

		}
		return macDetails;
	}
	/* End of method getMainAcctHolder */

/* ***** Tracker#122906 BETA Fixes ***** */
/* method getMainAcctHolder
 * Returns a list containing the Access Control Attributes of the given Entity
 */
  public ArrayList getEntityAccessAttributes(SRMBusinessContext bc,Integer iOrgID, String sCIFType)
  throws Exception{

	  ArrayList accessAttribs = new ArrayList();
	  SRMQueryBuilder qbMacAccess = null;
	  if(sCIFType.equals("Customer")){
		  qbMacAccess = QueryAssist.singleObjectQuery("AccountBO", AccountBO.ACCOUNTID);
          QueryAssist.addSimpleCondition(qbMacAccess, "AccountBO", AccountBO.ACCOUNTID, IQuery.ComparisonOperation_EQ, iOrgID);
		  qbMacAccess.addAttribScope ( QueryAssist.getTransformFn ("AccountBO",  AccountBO.ACCESSOWNERAGENT) );
		  qbMacAccess.addAttribScope ( QueryAssist.getTransformFn ("AccountBO",  AccountBO.ACCESSASSIGNEEAGENT ) );
		  qbMacAccess.addAttribScope ( QueryAssist.getTransformFn ("AccountBO",  AccountBO.ACCESSOWNERGROUP ) );
		  qbMacAccess.addAttribScope ( QueryAssist.getTransformFn ("AccountBO",  AccountBO.ACCESSOWNERBC ) );
		  qbMacAccess.addAttribScope ( QueryAssist.getTransformFn ("AccountBO",  AccountBO.ACCESSOWNERSEGMENT ) );

	  }else if(sCIFType.equals("Prospect")){
		  qbMacAccess = QueryAssist.singleObjectQuery("SuspectBO", SuspectBO.SUSPECTID);
			QueryAssist.addSimpleCondition(qbMacAccess, "SuspectBO", SuspectBO.SUSPECTID, IQuery.ComparisonOperation_EQ, iOrgID);
		  qbMacAccess.addAttribScope ( QueryAssist.getTransformFn ("SuspectBO",  SuspectBO.ACCESSOWNERAGENT) );
		  qbMacAccess.addAttribScope ( QueryAssist.getTransformFn ("SuspectBO",  SuspectBO.ACCESSASSIGNEEAGENT ) );
		  qbMacAccess.addAttribScope ( QueryAssist.getTransformFn ("SuspectBO",  SuspectBO.ACCESSOWNERGROUP ) );
		  qbMacAccess.addAttribScope ( QueryAssist.getTransformFn ("SuspectBO",  SuspectBO.ACCESSOWNERBC ) );
		  qbMacAccess.addAttribScope ( QueryAssist.getTransformFn ("SuspectBO",  SuspectBO.ACCESSOWNERSEGMENT ) );

	  }else if(sCIFType.equals("Contact")){
		  qbMacAccess = QueryAssist.singleObjectQuery("ContactBO", ContactBO.CONTACTID);
		  QueryAssist.addSimpleCondition(qbMacAccess, "ContactBO", ContactBO.CONTACTID, IQuery.ComparisonOperation_EQ, iOrgID);
		  qbMacAccess.addAttribScope ( QueryAssist.getTransformFn ("ContactBO",  ContactBO.ACCESSOWNERAGENT) );
		  qbMacAccess.addAttribScope ( QueryAssist.getTransformFn ("ContactBO",  ContactBO.ACCESSASSIGNEEAGENT ) );
		  qbMacAccess.addAttribScope ( QueryAssist.getTransformFn ("ContactBO",  ContactBO.ACCESSOWNERGROUP ) );
		  qbMacAccess.addAttribScope ( QueryAssist.getTransformFn ("ContactBO",  ContactBO.ACCESSOWNERBC ) );
		  qbMacAccess.addAttribScope ( QueryAssist.getTransformFn ("ContactBO",  ContactBO.ACCESSOWNERSEGMENT ) );
	  }

	  SRMQueryResult qrMacAccess = qbMacAccess.runQuery(bc,false,-1);
	  SRMRecordSet rsMacAccess   = qrMacAccess.getRecordSet();

	  if(rsMacAccess.hasNext()){
		  accessAttribs = (ArrayList)rsMacAccess.getNext();
	  }
	  return accessAttribs;
  }
  /* End of method getEntityAccessAttributes */
}



