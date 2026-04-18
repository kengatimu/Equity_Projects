/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: OpportunityBOHook.java $
 *
 * Author: Pavithra R
 *
 * $Archive: /CRM61DEV/com/infy/cis/custom/BOHooks/OpportunityBOHook.java $
 *
 *******************************************************************************/
package com.infy.cis.custom;

import javax.servlet.*;
import javax.servlet.http.*;

import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.OpportunityBO;
import com.infy.cis.srmbo.ProductBO;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.ui.common.*;
import com.infy.cis.exception.*;
import com.infy.cis.ui.sales.*;

//Added by Pradeep
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
import com.infy.cis.log.*;
import com.infy.cis.adaptor.web.WebAdaptor;

import com.infy.cis.common.*;
public class OpportunityBOHook implements IHooks {

    public OpportunityBOHook(){}

    private static String OPPORTUNITYBOHOOK_PRODUCT = "com.infy.cis.custome.BOHooks.OpportunityBOHook.ProductBO";
    private static String OPPORTUNITYBOHOOK_ACCOUNTBO = "com.infy.cis.custome.BOHooks.OpportunityBOHook.AccountBO";
    private static String OPPORTUNITYBOHOOK_SUSPECTBO = "com.infy.cis.custome.BOHooks.OpportunityBOHook.SuspectBO";
    private static String OPPORTUNITYBOHOOK_CONTACTBO = "com.infy.cis.custome.BOHooks.OpportunityBOHook.SuspectBO";

	public void preWrite (SRMBusinessContext bc, Object bo)
	 throws SRMPreWriteException,SRMSecurityException{

		/** CRM10.0 to CRM95 Access Control recon Start TrackerID: 97272*/
		OpportunityBO boOpportunity = (OpportunityBO)bo;
		try {
		/** CRM10.0 to CRM95 Access Control recon End*/

			//Tracker:90196: Changes for attibute masking
			 AttrAccValidator.validatecreate((SRMBase) bo);
            //Tracker:90196: End of Changes
			ProductBO boProduct = null;
			int iUniqueIdentifier = 0;
			String scrCurr = boOpportunity.getValueUnits();
			String autoCreateApplForm = boOpportunity.getAutoCreateApplForm();
			SRMCollection exist_prod = boOpportunity.getProduct();
			if(exist_prod!=null){
			OpportunityBO.Product boOppProd = (OpportunityBO.Product)exist_prod.get(0);
			String prodUrl = boOppProd.getProductBOURL();
			Integer prodIDScreen = boOppProd.getProductID();
			if ( exist_prod.size() < 2 ) {
				if ( autoCreateApplForm.equals("Y") ) {
					Integer prodId = prodIDScreen;
					SRMQueryBuilder qbp = QueryAssist.singleObjectQuery("ProductBO",ProductBO.PRODUCTID, OPPORTUNITYBOHOOK_PRODUCT);
					QueryAssist.addSimpleCondition(qbp, "ProductBO", ProductBO.PRODUCTID,
															IQuery.ComparisonOperation_EQ, prodId);
					QueryAssist.addSimpleCondition(qbp, "ProductBO", ProductBO.PRODUCTCURRENCY_CURRENCYCODE,
															IQuery.ComparisonOperation_EQ, scrCurr);
					TransFormFn tfn= new TransFormFn();
						  	tfn.COUNT(null,true);

	  				qbp.addAttribScope(tfn);

					SRMQueryResult qrp = qbp.runQuery(bc, -1);
					SRMRecordSet prodRs = qrp.getRecordSet();
					int iCount = 0;
					if(prodRs.hasNext()) {
						iCount = ((Integer)prodRs.getNext().get(0)).intValue();
						boOpportunity.setValueUnits(scrCurr);
					}
					if ( iCount == 0 ) {
						Exception e = new FCRMGenericException("MSGEXC0113",new Exception("This Product is not available for the given Currency."));
						throw new SRMPreWriteException(SRMBOException.ERROR_CURRENCY_PRODUCT_NOEXIST , e);
					}
				}
			}else {
				boOpportunity.setValueUnits("");
			}
		}
			/***********************************/
			//Setting the Opportunity.SLALEVEL for if the Opportunity request raised for a Customer
		if(boOpportunity.getOrgID() != null)
		{
			ArrayList ratingsList = new ArrayList();
			String sRating = "";
			try{
				ArrayList inciAttrList = new ArrayList();
	            inciAttrList.add(AccountBO.STRFIELD1);
				SRMQueryBuilder qb = QueryAssist.singleObjectQuery("AccountBO", AccountBO.ACCOUNTID, OPPORTUNITYBOHOOK_ACCOUNTBO);

	            QueryAssist.addSimpleCondition(qb, "AccountBO", AccountBO.ACCOUNTID,
	                                                IQuery.ComparisonOperation_EQ, ""+boOpportunity.getOrgID());;
	            QueryAssist.selectAttr( qb, "AccountBO",inciAttrList);

	            SRMQueryResult qrInci = qb.runQuery(bc , 1 ) ;
	            SRMRecordSet rsInci = qrInci.getRecordSet();
	            if(rsInci.hasNext()){
	            	ratingsList = (ArrayList)rsInci.getNext();
	            }
	            int size = ratingsList.size();
	            for( int i = 0; i < size; i = i + 1 ){
                    sRating = ratingsList.get( i ).toString();
                }
                //Setting the value for OpportunityBO.SLALEVEL
	            if( sRating.equals("Diamond") ){
	            	boOpportunity.setSLALevel("SLA5");
	            }
	            else if( sRating.equals("Platinum") ){
	            	boOpportunity.setSLALevel("SLA4");
	            }
	            else if( sRating.equals("Gold") ){
	            	boOpportunity.setSLALevel("SLA3");
	            }
	            else if( sRating.equals("Silver") ){
	            	boOpportunity.setSLALevel("SLA2");
	            }
	            else{
	            	boOpportunity.setSLALevel("SLA1");
	            }
        	}
        	catch(Exception e){
        		try{
        				boOpportunity.setSLALevel("SLA1");
        			}catch (Exception e1){}
      		}
		}
		//Setting the Opportunity.SLALEVEL for if the Opportunity request raised for a Prospect
		else if(boOpportunity.getSuspectID() != null)
		{
			ArrayList ratingsList = new ArrayList();
			String sRating = "";
			try{
				ArrayList inciAttrList = new ArrayList();
	            inciAttrList.add(SuspectBO.STRFIELD1);
				SRMQueryBuilder qb = QueryAssist.singleObjectQuery("SuspectBO", SuspectBO.SUSPECTID, OPPORTUNITYBOHOOK_SUSPECTBO);

	            QueryAssist.addSimpleCondition(qb, "SuspectBO", SuspectBO.SUSPECTID,
	                                                IQuery.ComparisonOperation_EQ, ""+boOpportunity.getSuspectID());;
	            QueryAssist.selectAttr( qb, "SuspectBO",inciAttrList);

	            SRMQueryResult qrInci = qb.runQuery(bc , 1 ) ;
	            SRMRecordSet rsInci = qrInci.getRecordSet();
	            if(rsInci.hasNext()){
	            	ratingsList = (ArrayList)rsInci.getNext();
	            }
	            int size = ratingsList.size();
	            for( int i = 0; i < size; i = i + 1 ){
                    sRating = ratingsList.get( i ).toString();
                }
                //Setting the value for OpportunityBO.SLALEVEL
	            if( sRating.equals("Diamond") ){
	            	boOpportunity.setSLALevel("SLA5");
	            }
	            else if( sRating.equals("Platinum") ){
	            	boOpportunity.setSLALevel("SLA4");
	            }
	            else if( sRating.equals("Gold") ){
	            	boOpportunity.setSLALevel("SLA3");
	            }
	            else if( sRating.equals("Silver") ){
	            	boOpportunity.setSLALevel("SLA2");
	            }
	            else{
	            	boOpportunity.setSLALevel("SLA1");
	            }
        	}
        	catch(Exception e){
        		try{
        				boOpportunity.setSLALevel("SLA1");
        			}catch (Exception e1){}
      		}
		}
		//Setting the Opportunity.SLALEVEL for if the Opportunity request raised for a Contact
		else if(boOpportunity.getContactID() != null)
		{
			ArrayList ratingsList = new ArrayList();
			String sRating = "";
			try{
				ArrayList inciAttrList = new ArrayList();
	            inciAttrList.add(ContactBO.STRFIELD1);
				SRMQueryBuilder qb = QueryAssist.singleObjectQuery("ContactBO", ContactBO.CONTACTID, OPPORTUNITYBOHOOK_CONTACTBO);

	            QueryAssist.addSimpleCondition(qb, "ContactBO", ContactBO.CONTACTID,
	                                                IQuery.ComparisonOperation_EQ, ""+boOpportunity.getContactID());;
	            QueryAssist.selectAttr( qb, "ContactBO",inciAttrList);

	            SRMQueryResult qrInci = qb.runQuery(bc , 1 ) ;
	            SRMRecordSet rsInci = qrInci.getRecordSet();
	            if(rsInci.hasNext()){
	            	ratingsList = (ArrayList)rsInci.getNext();
	            }
	            int size = ratingsList.size();
	            for( int i = 0; i < size; i = i + 1 ){
                    sRating = ratingsList.get( i ).toString();
                }
                //Setting the value for OpportunityBO.SLALEVEL
	            if( sRating.equals("Diamond") ){
	            	boOpportunity.setSLALevel("SLA5");
	            }
	            else if( sRating.equals("Platinum") ){
	            	boOpportunity.setSLALevel("SLA4");
	            }
	            else if( sRating.equals("Gold") ){
	            	boOpportunity.setSLALevel("SLA3");
	            }
	            else if( sRating.equals("Silver") ){
	            	boOpportunity.setSLALevel("SLA2");
	            }
	            else{
	            	boOpportunity.setSLALevel("SLA1");
	            }
        	}
        	catch(Exception e){
				try{
					boOpportunity.setSLALevel("SLA1");
				}catch (Exception e1){}
      		}
		}
		Date dDueDate = null;
		try{
			dDueDate = boOpportunity.getDueDate();
			if(dDueDate == null){
				dDueDate = Sales.setDueDate(bc, boOpportunity);
			}
			//System.out.println("dDueDate========>"+dDueDate);
		}
		catch(Exception e){
			WebAdaptor.log (LogType.EVENT, "Exception while Setting the dueDate for Opportunity" );
		}


		/*Changes for Setting Escalation Due Time*/
		Integer iProcessid = boOpportunity.getProcessID();
		Integer iStepKey = boOpportunity.getCurrentStep();
		Integer iEscMatID = null;
		ProcessBO processBO = null;
		Integer iOwnerID = null;
		Integer iLocnID		= null;
		Integer iGroupID 	= null;
		String tat[] = new String[2];
		String processURL = boOpportunity.getProcessBOURL();
		iOwnerID 			= boOpportunity.getOwnedUserID();
		iLocnID				= boOpportunity.getOwnedLocationID();
		iGroupID			= boOpportunity.getOwnerGroup();
		Date iCurrStepDueDate	= boOpportunity.getCurrStepDueDate();
		int currentStepInt = 0;
		if(iStepKey !=null && !(iStepKey.equals(null)) && !(iStepKey.equals("")))
		currentStepInt = iStepKey.intValue();


		if (processURL != null && !(processURL.equals(null))) {
			//processBO = (ProcessBO)SRMURLResolver.getObject(bc, processURL, true);
			processBO = Processes.findProcessBO(iProcessid, bc);
			SRMCollection procStepCollection = processBO.getProcessSteps();
			for (int i=0;i<procStepCollection.size();i++)
			{
				ProcessBO.ProcessSteps bo1 = (ProcessBO.ProcessSteps)procStepCollection.get(i);
				if(bo1.getStepKey().intValue() == iStepKey.intValue()) {
					iEscMatID = bo1.getEscalationMatrix();
				}
			}

			ArrayList aTatArray = new ArrayList();
			aTatArray = getEscTatDuration(bc, iEscMatID, boOpportunity.getOpportunityID());
			for( int i = 0; i < aTatArray.size(); i++){
				tat[i] = aTatArray.get( i ).toString();
			}
			int iTat = Integer.parseInt(tat[0]);
			String sUnit = tat[1];
			ASGenerator asgen = new ASGenerator();
			String sAvailString = Utils.getAvailString(bc, iOwnerID, iLocnID, iGroupID);
			/* Fix for recon TrackerId 303001 : begin */
			/* Fix for CallId 271790 : begin */
			//Changes for call id 444774 starts
			/*
			int offset = - iCurrStepDueDate.getTimezoneOffset();
			iCurrStepDueDate.setMinutes(iCurrStepDueDate.getMinutes() + offset);*/
			//Changes for call id 444774 ends
			Date tempStepDueDate = asgen.findDueDate(sAvailString, iTat, sUnit, iCurrStepDueDate);
			//Changes for call id 445924 starts
		            boOpportunity.setCurrStepDueDate(iCurrStepDueDate);
			//boOpportunity.setCurrStepDueDate(SRMDate.getGMTFromServerDate(iCurrStepDueDate));
			/* Fix for CallId 271790 : end */
			/* Fix for recon TrackerId 303001 : end */
			boOpportunity.setEscDueTime(tempStepDueDate);
// changes by rohit_agrawal to set Escduetime in GMT format and set ProcEscDueTime only for First step.
			//boOpportunity.setEscDueTime(SRMDate.getGMTFromServerDate(tempStepDueDate));
			//Changes for call id 445924 ends
			Date tempDueDate = asgen.findDueDate(sAvailString, iTat, sUnit, dDueDate);
            if(currentStepInt == 1)
			boOpportunity.setProcEscDuetime(SRMDate.getGMTFromServerDate(tempDueDate));

		}
		/*Changes for Setting Escalation Due Time*/


		//End of changes
			/**********************************/


		}catch(SRMPreWriteException pr){
			throw pr;
		}

		//Tracker:90196: Changes for attibute masking
				catch(SRMSecurityException e) {
					throw new SRMSecurityException(SRMSecurityException.ERROR_ATTR_MASK, null) ;
				}
				//Tracker:90196: End of Changes
        catch(Exception e){}

		/** CRM10.0 to CRM95 Access Control recon Start TrackerID: 97272*/
			 /*****************Tracker ID :89798 Start Of Changes*************/
		try {
			Integer asgndAgntID = boOpportunity.getAssignedUserID();


			boOpportunity.setAccessOwnerAgent(boOpportunity.getOwnedUserID());
			boOpportunity.setAccessAssigneeAgent(asgndAgntID);

			Integer asgndGpId = boOpportunity.getAssignedGroupID();
			Integer owndGpId = boOpportunity.getOwnerGroup();

			if (null == asgndGpId && null != owndGpId)
			{
				boOpportunity.setAccessOwnerGroup(owndGpId);
			}
			else if (null != asgndGpId && null == owndGpId)
			{
				boOpportunity.setAccessOwnerGroup(asgndGpId);
			}
			else if (null != asgndGpId && null != owndGpId)
			{
				boOpportunity.setAccessOwnerGroup(owndGpId);
			}

			Integer AsgndLocnID = boOpportunity.getAssignedLocationID();

			if (null == AsgndLocnID && null != boOpportunity.getOwnedLocationID())
			{
				boOpportunity.setAccessOwnerBC(boOpportunity.getOwnedLocationID());
			}
			else if (null != AsgndLocnID && null == boOpportunity.getOwnedLocationID())
			{
				boOpportunity.setAccessOwnerBC(AsgndLocnID);
			}
			else if (null != AsgndLocnID && null != boOpportunity.getOwnedLocationID())
			{
				boOpportunity.setAccessOwnerBC(boOpportunity.getOwnedLocationID());
			}
		} catch (SRMTypeValidatorException stv) {

			throw new SRMPreWriteException(stv.getErrorCode(),stv);}

            /*****************Tracker ID :89798 End Of Changes*************/
            /** CRM10.0 to CRM95 Access Control recon End*/
	 }


   public ArrayList getEscTatDuration(SRMBusinessContext bc, Integer iEscMatID, Integer iOpporID) throws Exception{
	   ArrayList newEscTat = new ArrayList();
	   String sExpr                = null;
	   EscalationMatrixBO eMatBO   = null;
	   String sReturnType          = "boolean";
	   EscalationMatrixBO eTempMatBO   = null;
	   String sResult				= null;
	   ArrayList  arrSale          =   null;
	   int iSalesID				= 0;
		try {
			ArrayList arrAttrList = new ArrayList();
			arrAttrList.add(SaleBO.SALESID);
			SRMQueryBuilder qb = JobFuncs.singleObjectQuery("SaleBO", SaleBO.SALESID);
			JobFuncs.addSimpleCondition(qb, "SaleBO", SaleBO.OPPORTUNITYID,
												IQuery.ComparisonOperation_EQ,
												iOpporID);
			QueryAssist.selectAttr(qb, "SaleBO", arrAttrList);
			SRMQueryResult rs1 = qb.runQuery(bc, true, -1);
			SRMRecordSet record = rs1.getRecordSet();
			while(record.hasNext()) {
				/*changes for call id 372306: recon of 366501 start*/

				//arrSale = (ArrayList)record.getNext().get(0);
				//Integer iSalID = (Integer)arrSale.get(0);
                   Integer iSalID = 0;
				 iSalID = (Integer)record.getNext().get(0);
				/*changes for call id 372306: recon of 366501 ends*/
				if(iSalID!=null)
				iSalesID=iSalID.intValue();
				break;
			}
		} catch (CISInvalidArgumentException e) {
			e.printStackTrace();
		} catch (SRMSecurityException e) {
			e.printStackTrace();
		} catch (SRMBOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

	   try {
			SRMQueryBuilder qb = QueryAssist.singleObjectQuery(
									"EscalationMatrixBO", EscalationMatrixBO.EMID);
			// Changes for Tracker ID- 161814 Start
			ArrayList arrAttrList = new ArrayList();
			arrAttrList.add(EscalationMatrixBO.EXPRESSION);
			arrAttrList.add(EscalationMatrixBO.ESCALATIONDETAILS_TAT);
			arrAttrList.add(EscalationMatrixBO.ESCALATIONDETAILS_TATUNITS);


			QueryAssist.addSimpleCondition(qb, "EscalationMatrixBO", EscalationMatrixBO.EMID,
								IQuery.ComparisonOperation_EQ, iEscMatID);
			QueryAssist.addSimpleCondition(qb, "EscalationMatrixBO", EscalationMatrixBO.MATRIXFOR,
								IQuery.ComparisonOperation_EQ, "Opportunity");
			QueryAssist.addSimpleCondition(qb, "EscalationMatrixBO", EscalationMatrixBO.ESCALATIONDETAILS_ESCLEVEL,
								IQuery.ComparisonOperation_NOTEQ, "Exceeded transfers");
			QueryAssist.selectAttr(qb, "EscalationMatrixBO", arrAttrList);


			//Changing the numMaxRows from -1 for max records to 1 for fetching only one record
			SRMQueryResult qr 		= qb.runQuery(bc, true, 1);
			SRMRecordSet rs1 		= qr.getRecordSet();
			/* Commenting the below code as this was preventing the fetching of child table values
			while(rs1.hasNext()) {
				eTempMatBO 			= (EscalationMatrixBO)rs1.getNext().get(0);
				sExpr           	= eTempMatBO.getExpression();

				try{
					EvaluateBOExpression ee = new EvaluateBOExpression();
					sResult 			= ee.evalExpression(sExpr, sReturnType, iSalesID, bc);
				} catch(Exception e) {}

				if(sResult.trim().equalsIgnoreCase("True")){
					eMatBO = eTempMatBO;
					break;
				}
			}
			if((sResult != null) && (sResult.trim().equalsIgnoreCase("True"))){
				EscalationMatrixBO.EscalationDetails escDetails = null;
				SRMCollection esclDetailsColl = eMatBO.getEscalationDetails();
				for(int i=0;i<esclDetailsColl.size(); i++){
					escDetails = (EscalationMatrixBO.EscalationDetails) esclDetailsColl.get(i);
					break;
				}
				newEscTat.add(escDetails.getTat());
				newEscTat.add(escDetails.getTatUnits());
            */

					while(rs1.hasNext()) {
						List strTatList =	rs1.getNext();
						sExpr = strTatList.get(0).toString();

						try{
							EvaluateBOExpression ee = new EvaluateBOExpression();
							sResult = ee.evalExpression(sExpr, sReturnType, iSalesID, bc);
						} catch(Exception e) {}

						if((sResult != null) && (sResult.trim().equalsIgnoreCase("True"))){
						newEscTat.add(strTatList.get(1));
						newEscTat.add(strTatList.get(2));
						}
					}

				} catch (Exception e){e.printStackTrace();
		}
		return newEscTat;
   }

   public void postWrite (SRMBusinessContext bc, Object bo)
    throws SRMPostWriteException {

   }

   public void preDelete (SRMBusinessContext bc, Object bo)
    throws SRMPreDeleteException {

   }

   public void postDelete (SRMBusinessContext bc, Object bo)
    throws SRMPostDeleteException {

   }

   public void preFill (SRMBusinessContext bc, Object bo)
    throws SRMPreFillException {

   }

   public void postFill (SRMBusinessContext bc, Object bo)
    throws SRMPostFillException {

   }
}



