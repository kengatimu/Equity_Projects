/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: IncidentBOHook.java $
 *
 * Author: Lakshmi Narayana. R
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/IncidentBOHook.java $
 *
 * *********************************** */

/* CRM6206:TRACKER:68427:BEGINOFCHANGES  */

package com.infy.cis.custom;

import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.exception.*;
import com.infy.cis.srmbo.*;
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
import com.infy.cis.common.*;
//10.4.02 SPE Changes - tracker id 339164 Begin
import com.infy.cis.srmbo.SupportFuncs;
//10.4.02 SPE Changes - tracker id 339164 End
import com.infy.cis.ui.common.*;


public class IncidentBOHook implements IHooks
{
   public IncidentBOHook(){}
   //ICICI - CRM UNIX RECON
   // Tracker id 	86142
   // changes made by rohit_agrawal to take the parameters form JNDI instead of hard coding */
   	public String custAttribute =null;
   	public String prosAttribute =null;
   	public String contAttribute =null;
   	// tracker id 339164 begin
   	public String corpCustAttribute =null;
   	public String corpProsAttribute =null;
   	// tracker id 339164 end
   //10.4.02 SPE Changes - Begin for tracker id 339164
   //Properties prop = (Properties)EditorUtil.getServiceLevelSLAConfigInfo();
  //10.4.02 SPE Changes - End for tracker id 339164
	// end of Tracker id 	86142
	//ICICI - CRM UNIX RECON
  /* CRM6206:TRACKER:68427:BEGINOFCHANGES */

	public void preWrite (SRMBusinessContext bc, Object bo)
		throws SRMPreWriteException,SRMSecurityException{

		IncidentBO inciBO = ((IncidentBO)bo);
		  //Tracker:90196: Changes for attibute masking
				try {
					AttrAccValidator.validatecreate((SRMBase) bo);
				} catch(SRMSecurityException e) {
					throw new SRMSecurityException(SRMSecurityException.ERROR_ATTR_MASK, null) ;
				}
		//Tracker:90196: End of Changes
		try
		{
			inciBO.setLockFields("N");
		}catch (SRMTypeValidatorException validatExp)
		{}

		//Setting the Incident.SLALEVEL for if the Incident request raised for a Customer
		if(inciBO.getOrgID() != null)
		{
			ArrayList ratingsList = new ArrayList();
			String sRating = "";
			String boName =null;
			String boAttribute =null;
			SRMQueryBuilder qb = null;
			try{
				//ICICI - CRM UNIX RECON
				// Tracker id 	86142
				try{
                 //10.4.02 SPE Changes - Begin for tracker id 339164
				// custAttribute = prop.getProperty("CUST_ATTR");
				 custAttribute = SupportFuncs.getCalServiceLevelProps("CUST_ATTR");
                //10.4.02 SPE Changes - End for tracker id 339164
				boName = custAttribute.substring(0, custAttribute.indexOf(".")).trim();
				boAttribute= custAttribute.substring(custAttribute.indexOf(".") + 1).trim();
			}
				catch(Exception e){}
				// end of Tracker id 	86142
				//ICICI - CRM UNIX RECON
				ArrayList inciAttrList = new ArrayList();
	            //inciAttrList.add(AccountBO.STRFIELD1);
	            inciAttrList.add(custAttribute);
	          if(boName!= null && boName!="" && boName.equalsIgnoreCase("AccountBO")){
				qb = QueryAssist.singleObjectQuery("AccountBO", AccountBO.ACCOUNTID);

	            QueryAssist.addSimpleCondition(qb, "AccountBO", AccountBO.ACCOUNTID,
	                                                IQuery.ComparisonOperation_EQ, ""+inciBO.getOrgID());;
	            QueryAssist.selectAttr( qb, "AccountBO",inciAttrList);
	          } else if (boName != null && boName != ""
						&& boName.equalsIgnoreCase("PsychographicBO")) {
					qb = QueryAssist.singleObjectQuery("PsychographicBO",
							PsychographicBO.ACCOUNTID);
					QueryAssist.addSimpleCondition(qb, "PsychographicBO",
							PsychographicBO.ACCOUNTID,
							IQuery.ComparisonOperation_EQ, ""
									+ inciBO.getOrgID());
					;
					QueryAssist.selectAttr(qb, "PsychographicBO", inciAttrList);
				} else if (boName != null && boName != ""
						&& boName.equalsIgnoreCase("DemographicBO")) {
					qb = QueryAssist.singleObjectQuery("DemographicBO",
							DemographicBO.ACCOUNTID);
					QueryAssist.addSimpleCondition(qb, "DemographicBO",
							DemographicBO.ACCOUNTID,
							IQuery.ComparisonOperation_EQ, ""
									+ inciBO.getOrgID());
					;
					QueryAssist.selectAttr(qb, "DemographicBO", inciAttrList);
				}
	            SRMQueryResult qrInci = qb.runQuery(bc , 1 ) ;
				//10.4.01 SPE Changes - tracker id 339164 end : Removing rownum
	            SRMRecordSet rsInci = qrInci.getRecordSet();
	            if(rsInci.hasNext()){
	            	ratingsList = (ArrayList)rsInci.getNext();
	            }
	            for( int i = 0; i < ratingsList.size(); i = i + 1 ){
                    sRating = ratingsList.get( i ).toString();
                }
                //Setting the value for IncidentBO.SLALEVEL
                //tracker id 339164 BEGIN
	            if( sRating.equalsIgnoreCase("Diamond") ){
	            	inciBO.setSLALevel("SLA5");
	            }
	            else if( sRating.equalsIgnoreCase("Platinum") ){
	            	inciBO.setSLALevel("SLA4");
	            }
	            else if( sRating.equalsIgnoreCase("Gold") ){
	            	inciBO.setSLALevel("SLA3");
	            }
	            else if( sRating.equalsIgnoreCase("Silver") ){
	            	inciBO.setSLALevel("SLA2");
	            }
	            else{
	            	inciBO.setSLALevel("SLA1");
	            }
	            //tracker id 339164 END
        	}
        	catch(Exception e){
        		try{
        				inciBO.setSLALevel("SLA1");
        			}catch (Exception e1){}
      		}
		}
		//Setting the Incident.SLALEVEL for if the Incident request raised for a Prospect
		else if(inciBO.getSuspectID() != null)
		{
			ArrayList ratingsList = new ArrayList();
			String sRating = "";
			String boName =null;
			String boAttribute =null;
			SRMQueryBuilder qb = null;
			try{
					//ICICI - CRM UNIX RECON
					// Tracker id 	86142
					try{
					//10.4.02 SPE Changes - Begin for tracker id 339164
					//prosAttribute = prop.getProperty("PROS_ATTR");
					prosAttribute = SupportFuncs.getCalServiceLevelProps("PROS_ATTR");
					//10.4.02 SPE Changes - End for tracker id 339164
					boName = prosAttribute.substring(0, prosAttribute.indexOf(".")).trim();
					boAttribute= prosAttribute.substring(prosAttribute.indexOf(".") + 1).trim();
					} /****Changes for Tracker:236041 for 11.0****Ends***/
					catch(Exception e){}
					//end of  Tracker id 	86142
					//ICICI - CRM UNIX RECON

				ArrayList inciAttrList = new ArrayList();
	           // inciAttrList.add(SuspectBO.STRFIELD1);
	           inciAttrList.add(prosAttribute);
	    if(boName!= null && boName!="" && boName.equalsIgnoreCase("SuspectBO")){
				qb = QueryAssist.singleObjectQuery("SuspectBO", SuspectBO.SUSPECTID);

	            QueryAssist.addSimpleCondition(qb, "SuspectBO", SuspectBO.SUSPECTID,
	                                                IQuery.ComparisonOperation_EQ, ""+inciBO.getSuspectID());;
	            QueryAssist.selectAttr( qb, "SuspectBO",inciAttrList);
	    } else if (boName != null && boName != ""
						&& boName.equalsIgnoreCase("PsychographicBO")) {
					qb = QueryAssist.singleObjectQuery("PsychographicBO",
							PsychographicBO.SUSPECTID);
					QueryAssist.addSimpleCondition(qb, "PsychographicBO",
							PsychographicBO.SUSPECTID,
							IQuery.ComparisonOperation_EQ, ""
									+ inciBO.getSuspectID());
					;
					QueryAssist.selectAttr(qb, "PsychographicBO", inciAttrList);
				} else if (boName != null && boName != ""
						&& boName.equalsIgnoreCase("DemographicBO")) {
					qb = QueryAssist.singleObjectQuery("DemographicBO",
							DemographicBO.SUSPECTID);
					QueryAssist.addSimpleCondition(qb, "DemographicBO",
							DemographicBO.SUSPECTID,
							IQuery.ComparisonOperation_EQ, ""
									+ inciBO.getSuspectID());
					;
					QueryAssist.selectAttr(qb, "DemographicBO", inciAttrList);
				}
	            SRMQueryResult qrInci = qb.runQuery(bc , 1 ) ;
	            SRMRecordSet rsInci = qrInci.getRecordSet();
	            if(rsInci.hasNext()){
	            	ratingsList = (ArrayList)rsInci.getNext();
	            }
	            for( int i = 0; i < ratingsList.size(); i = i + 1 ){
                    sRating = ratingsList.get( i ).toString();
                }
                //Setting the value for IncidentBO.SLALEVEL
                //tracker id 339164 BEGIN
	            if( sRating.equalsIgnoreCase("Diamond") ){
	            	inciBO.setSLALevel("SLA5");
	            }
	            else if( sRating.equalsIgnoreCase("Platinum") ){
	            	inciBO.setSLALevel("SLA4");
	            }
	            else if( sRating.equalsIgnoreCase("Gold") ){
	            	inciBO.setSLALevel("SLA3");
	            }
	            else if( sRating.equalsIgnoreCase("Silver") ){
	            	inciBO.setSLALevel("SLA2");
	            }
	            else{
	            	inciBO.setSLALevel("SLA1");
	            }
	            //tracker id 339164 END
        	}
        	catch(Exception e){
        		try{
        				inciBO.setSLALevel("SLA1");
        			}catch (Exception e1){}
      		}
		}
		//Setting the Incident.SLALEVEL for if the Incident request raised for a Contact
		else if(inciBO.getContactID() != null)
		{
			ArrayList ratingsList = new ArrayList();
			String sRating = "";
			 String boName =null;
			 String boAttribute =null;
			 SRMQueryBuilder qb = null;
			try{
				//ICICI - CRM UNIX RECON
				// Tracker id 	86142
				try{
					//10.4.02 SPE Changes - Begin for tracker id 339164
					//contAttribute = prop.getProperty("CONT_ATTR");
					contAttribute = SupportFuncs.getCalServiceLevelProps("CONT_ATTR");
					//10.4.02 SPE Changes - End for tracker id 339164
					boName = contAttribute.substring(0, contAttribute.indexOf(".")).trim();
					boAttribute= contAttribute.substring(contAttribute.indexOf(".") + 1).trim();
					}
					catch(Exception e){}
				// end of Tracker id 	86142
				ArrayList inciAttrList = new ArrayList();
	            //inciAttrList.add(ContactBO.STRFIELD1);
	            inciAttrList.add(contAttribute);
	            //ICICI - CRM UNIX RECON
	      if(boName!= null && boName!="" && boName.equalsIgnoreCase("ContactBO")){
				qb = QueryAssist.singleObjectQuery("ContactBO", ContactBO.CONTACTID);

	            QueryAssist.addSimpleCondition(qb, "ContactBO", ContactBO.CONTACTID,
	                                                IQuery.ComparisonOperation_EQ, ""+inciBO.getContactID());;
	            QueryAssist.selectAttr( qb, "ContactBO",inciAttrList);
	      } else if (boName != null && boName != ""
						&& boName.equalsIgnoreCase("PsychographicBO")) {

					qb = QueryAssist.singleObjectQuery("PsychographicBO",
							PsychographicBO.CONTACTID);
					QueryAssist.addSimpleCondition(qb, "PsychographicBO",
							PsychographicBO.CONTACTID,
							IQuery.ComparisonOperation_EQ, ""
									+ inciBO.getContactID());
					;
					QueryAssist.selectAttr(qb, "PsychographicBO", inciAttrList);
				} else if (boName != null && boName != ""
						&& boName.equalsIgnoreCase("DemographicBO")) {
					qb = QueryAssist.singleObjectQuery("DemographicBO",
							DemographicBO.CONTACTID);
					QueryAssist.addSimpleCondition(qb, "DemographicBO",
							DemographicBO.CONTACTID,
							IQuery.ComparisonOperation_EQ, ""
									+ inciBO.getContactID());
					;
					QueryAssist.selectAttr(qb, "DemographicBO", inciAttrList);
				}
	            SRMQueryResult qrInci = qb.runQuery(bc , 1 ) ;
	            SRMRecordSet rsInci = qrInci.getRecordSet();
	            if(rsInci.hasNext()){
	            	ratingsList = (ArrayList)rsInci.getNext();
	            }
	            for( int i = 0; i < ratingsList.size(); i = i + 1 ){
                    sRating = ratingsList.get( i ).toString();
                }
                //Setting the value for IncidentBO.SLALEVEL
                //tracker id 339164 BEGIN
	            if( sRating.equalsIgnoreCase("Diamond") ){
	            	inciBO.setSLALevel("SLA5");
	            }
	            else if( sRating.equalsIgnoreCase("Platinum") ){
	            	inciBO.setSLALevel("SLA4");
	            }
	            else if( sRating.equalsIgnoreCase("Gold") ){
	            	inciBO.setSLALevel("SLA3");
	            }
	            else if( sRating.equalsIgnoreCase("Silver") ){
	            	inciBO.setSLALevel("SLA2");
	            }
	            else{
	            	inciBO.setSLALevel("SLA1");
	            }
	            //tracker id 339164 END
        	}
        	catch(Exception e){
        		try{
        				inciBO.setSLALevel("SLA1");
        			}catch (Exception e1){}
      		}
		}
		try{

			 //getting process tat & tat units
	/*		  SRMQueryBuilder qbProcess = new SRMQueryBuilder();
			  List attr = new ArrayList();
			  attr.add(ProcessBO.TAT);
			  attr.add(ProcessBO.TATUNITS);
			  QueryAssist.addJoin (qbProcess, "ProcessBO", ProcessBO.PROCESSID,
			                                 "ProcessBO", ProcessBO.PROCESSID,
                                IQuery.JoinType_Equi);

              QueryAssist.addSimpleCondition(qbProcess, "ProcessBO", ProcessBO.PROCESSID,
                                            IQuery.ComparisonOperation_EQ,
                                            inciBO.getProcessID());
              QueryAssist.selectAttr(qbProcess, "ProcessBO", attr);

              SRMQueryResult qrProcess = qbProcess.runQuery(bc, -1);
              SRMRecordSet rsProcess = qrProcess.getRecordSet();
			  ArrayList procList = new ArrayList();
			  while(rsProcess.hasNext()){
				  ArrayList rowObj = (ArrayList) rsProcess.getNext() ;
				  procList.add(rowObj.get(0));
				  procList.add(rowObj.get(1));
			  }
	          int tat=0;
	          String tatUnits = null;
	          if (!(procList.isEmpty())){
	          	tat = ((Integer)procList.get(0)).intValue();
			  	tatUnits = procList.get(1).toString();
			 }
*/
			  ProcessBO processBO = (ProcessBO)Processes.findProcessBO(inciBO.getProcessID(), bc);
	          int tat=0;
	          String tatUnits = null;
	          if(processBO != null){
				  	if (processBO.getTat() != null){
						tat=((Integer)processBO.getTat()).intValue();
					}
					tatUnits = processBO.getTatUnits();
			}
/*SPE Changes for Caching the query*/
			 //getting the rating %age
			 List attrCat = new ArrayList();
			 attrCat.add(CategoryBO.RATING);

			 SRMQueryBuilder qbCategory = QueryAssist.singleObjectQuery("CategoryBO",CategoryBO.CATEGORYID);
			 QueryAssist.addSimpleCondition(qbCategory, "CategoryBO", CategoryBO.CATEGORYTYPE,
														IQuery.ComparisonOperation_EQ, "SLA");
			 QueryAssist.addSimpleCondition(qbCategory, "CategoryBO", CategoryBO.VALUE,
														IQuery.ComparisonOperation_EQ, inciBO.getSLALevel());

			 QueryAssist.selectAttr(qbCategory, "CategoryBO", attrCat);

             SRMQueryResult qrCategory = qbCategory.runQuery(bc, -1);

             SRMRecordSet rsCategory = qrCategory.getRecordSet();
			 ArrayList catList = new ArrayList();
			 while(rsCategory.hasNext()){
				ArrayList rowObj = (ArrayList) rsCategory.getNext() ;
			 	catList.add(rowObj.get(0));
			 }
			 //ICICI - CRM UNIX RECON
			 //int rating = Integer.parseInt(catList.get(0).toString());
			// Tracker id 	86142 -->rating changed to double from int --> to compute the TAT duration for diff class entities correctly*/
			double rating = Integer.parseInt(catList.get(0).toString());
				//ICICI - CRM UNIX RECON
			 double temp = rating / 100;
			if (tatUnits!=null) {
			 Long temp1 = new Long(Math.round(tat*temp));

			 if( temp1.doubleValue() < (tat*temp) ){
			 	temp1 = new Long(temp1.intValue() + 1);
			 }

			 if ( temp1.doubleValue() == 0 ){
				temp1 = new Long(1);
			 }
			 else{
			 	temp1 = temp1;
			 }
			 String entityTatDuration = temp1+" "+tatUnits;
			 inciBO.setTATDuration(entityTatDuration);
			}
			 //

			 RequestControlBO reqCntrlBO = null;
			 reqCntrlBO = Support.getRequestControl(bc, inciBO );
			 RequestControlBO.ServiceLevel sl = (RequestControlBO.ServiceLevel)Support.getServiceLevel(bc, inciBO, reqCntrlBO);
			 Support.setDueDate(bc, inciBO);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		//End of changes
		if (inciBO.getIncidentID()!=null)
		{
			Integer inciBOProcId = inciBO.getProcessID();

			if ( (inciBOProcId!=null) && (inciBO.getLockFields().equals("N")) )
			{
				ProcessBO inciProcBO = Processes.findProcessBO(inciBOProcId,bc);
				Integer currStep = inciBO.getCurrentStep();
				Integer firstStep = CommonQueries.getFirstStepKey(inciProcBO);
				//System.out.println("\n\n\nin incihook******currStep***"+currStep);
				//System.out.println("\n\n\nin incihook******firstStep***"+firstStep);
		/****changes: tracker:163177, added if condition to check the processsteps are not null*******************/
			if((currStep!= null) && (firstStep != null))
			{
				if (firstStep.intValue()!=currStep.intValue())
				{
					try
					{
						inciBO.setLockFields("Y");
					}catch (SRMTypeValidatorException validatExp)
					{}
				}
			}
			} // end of getLockField not equals Yes
		}
		 /*****************Tracker ID :89798 Start Of Changes*************/

		        try {
		        Integer iLocnID = inciBO.getOwnedLocationID();
		        Integer asgiLocnID = inciBO.getAssignedLocationID();
		        Integer iOwnerID = inciBO.getOwnedUserID();
		        Integer asgndAgntID = inciBO.getAssignedUserID();

		        //inciBO.setAccessOwnerBC(iLocnID);
		        inciBO.setAccessOwnerAgent(iOwnerID);
		        inciBO.setAccessAssigneeAgent(asgndAgntID);

		        Integer asgndGpId = inciBO.getAssignedGroupID();
		        Integer owndGpId = inciBO.getOwnerGroup();
		        if (null == asgndGpId && null != owndGpId)
		        {
		            inciBO.setAccessOwnerGroup(owndGpId);
		        }
		        else if (null != asgndGpId && null == owndGpId)
		        {
		            inciBO.setAccessOwnerGroup(asgndGpId);
		        }
		        else if (null != asgndGpId && null != owndGpId)
		        {
		            inciBO.setAccessOwnerGroup(owndGpId);
		        }

		        if (null == asgiLocnID && null != iLocnID)
		        {
		            inciBO.setAccessOwnerBC(iLocnID);
		        }
		        else if (null != asgiLocnID && null == iLocnID)
		        {
		            inciBO.setAccessOwnerBC(asgiLocnID);
		        }
		        else if (null != asgiLocnID && null != iLocnID)
		        {
		            inciBO.setAccessOwnerBC(iLocnID);
		        }

		        } catch (SRMTypeValidatorException stype) { }
		        /*****************Tracker ID :89798 End Of Changes*************/

	 }
 /* CRM6206:TRACKER:68427:ENDOFCHANGES */

// sample hook - postWrite

  public void postWrite (SRMBusinessContext bc, Object bo)
    throws SRMPostWriteException {
	   // customized implementation place holder
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
/*APAC modification for support module requirement no 24*/
  public static boolean updateActivity(SRMBusinessContext bc, String activityType)
  throws SRMPreFillException {

	  	if (activityType == null) {
			activityType = "";
		}

		if (activityType.equals("IncidentCreated")){
			return true;
		}

		if (activityType.equals("NewMessageCreated")){
			return true;
		}

		if (activityType.equals("FileAttached")){
			return true;
		}

		if (activityType.equals("WItemCreated")){
			return true;

		}

		if (activityType.equals("WItemUpdated")){
			return true;
		}

		return false;
  }
  /*End of APAC modification for support module requirement no 24*/
}

