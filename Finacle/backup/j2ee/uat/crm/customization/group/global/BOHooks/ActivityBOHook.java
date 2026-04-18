/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: ActivityBOHook.java $
 *
 * Author:
 *
 * $Archive:
 *
 * *********************************** */

package com.infy.cis.custom;
 /**** Alert server recon to 10.2.14 Start Tracker ID 378548 ****/
//Alert server recon to 10.2.14 starts
import com.infosys.insulate.util.ArrayList;
import com.infosys.insulate.util.HashMap;
import java.util.Properties;

import com.infy.cis.adaptor.web.WebAdaptor;
import com.infy.cis.alert.CRMAlert;
import com.infy.cis.common.dbmgr.DBAccess;
import com.infy.cis.common.dbmgr.PreparedStmtParam;
import com.infy.cis.common.EditorUtil;
import com.infy.cis.common.NameValue;
import com.infy.cis.exception.SRMPostDeleteException;
import com.infy.cis.exception.SRMPostFillException;
import com.infy.cis.exception.SRMPostWriteException;
import com.infy.cis.exception.SRMPreDeleteException;
import com.infy.cis.exception.SRMPreFillException;
import com.infy.cis.exception.SRMPreWriteException;
import com.infy.cis.srmbo.AccountModBO;
import com.infy.cis.srmbo.ActivityBO;
import com.infy.cis.srmbo.AlertBO;
import com.infy.cis.srmbo.ApplRelPartyXML;
import com.infy.cis.srmbo.ContactBO;
import com.infy.cis.srmbo.ContactModBO;

	/**** Alert server recon to 10.2.14 End    Tracker ID 378548 ****/
//Alert server recon to 10.2.14 ends
import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.*;
/*** FCRM6206-IC-ST1:TRACKER 68116*** start ***/
//import com.infy.cis.ui.common.Processes;
 /*** FCRM6206-IC-ST1:TRACKER 68116*** end ***/
import com.infy.cis.srmbo.ApplRelPartyXML;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.exception.*;
import com.infy.cis.common.dbmgr.*;
 /**** Alert server recon to 10.2.14 Start Tracker ID 378548 ****/
//Alert server recon to 10.2.14 starts
import com.infy.cis.ui.common.QueryAssist;
import com.infy.cis.ui.common.Utils;

	/**** Alert server recon to 10.2.14 End    Tracker ID 378548 ****/
//Alert server recon to 10.2.14 ends
import com.infy.cis.common.*;



public class ActivityBOHook implements IHooks {

   public ActivityBOHook(){}

// sample hook - postWrite

	public void preWrite (SRMBusinessContext bc, Object bo)
	 throws SRMPreWriteException {
	   // customized implementation place holder
	 }


// sample hook - postWrite

  public void postWrite (SRMBusinessContext bc, Object bo)
    throws SRMPostWriteException {
	   // customized implementation place holder
	   DBAccess db = null;
		 try{
			 ActivityBO activityBO = (ActivityBO)bo;
			 Integer opportunityID = activityBO.getOpportunityID();
 /**** Alert server recon to 10.2.14 Start Tracker ID 378548 ****/
			//Alert server recon to 10.2.14 starts
			 Integer orgID = activityBO.getOrgID();
			 Integer incidentID = activityBO.getIncidentID();

	/**** Alert server recon to 10.2.14 End    Tracker ID 378548 ****/
			//Alert server recon to 10.2.14 ends
			 Integer stepKey = activityBO.getStep();
			 Integer processID = activityBO.getProcessID();
			 String stepName = null;
			 String processName = null;
			 if(opportunityID != null && activityBO.getEntity().equals(ActivityBO.ACTIVITY_ENTITY_PROCESSSTEP)
				&& activityBO.getReasonCode().equals(ActivityBO.ACTIVITY_CLOSURE_REASONCODE_PROCESS_COMPL)
				&& activityBO.getOperation().equals(ActivityBO.ACTIVITY_OPER_CLOSURE)) {
				/*Setting for default processid and step keys
				  One condition for each process*/
				int iProcID = processID.intValue();
				int iStpKy = stepKey.intValue();
				/*for processid 8 and stepkey=1,2,4,6,8,10,11,17,19,22 */
				boolean proccond1 = (iProcID == 8 && (iStpKy == 1 || iStpKy == 2 || iStpKy == 4 || iStpKy == 6 ||
									iStpKy == 8 || iStpKy == 10 || iStpKy == 11 || iStpKy == 17 || iStpKy == 19|| iStpKy ==  22));
				/*for processid 9 and stepkey=1,2,11,17*/
				boolean proccond2 = (iProcID == 9 && (iStpKy == 1 || iStpKy == 2 || iStpKy == 11 || iStpKy == 17));

				/*for processid 11 and stepkey=1,6,9*/
				boolean proccond3 = (iProcID == 11 && (iStpKy == 1 || iStpKy == 6 || iStpKy == 9));

				/*for processid 12 and stepkey=1,6,9*/
				boolean proccond4 = (iProcID == 12 && (iStpKy == 1 || iStpKy == 6 || iStpKy == 9));

				/*for processid 13 and stepkey=1,2,4,6,8,10,11, 17,19,22*/
				boolean proccond5 = (iProcID == 13 && (iStpKy == 1 || iStpKy == 2 || iStpKy == 4 || iStpKy == 6 ||
									iStpKy == 8 || iStpKy == 10 || iStpKy == 11 || iStpKy == 17 || iStpKy == 19 || iStpKy == 22));

				/*for processid 14 and stepkey=1,2,11,17*/
				boolean proccond6 = (iProcID == 14 && (iStpKy == 1 || iStpKy == 2 || iStpKy == 11 || iStpKy == 17));

				/*final condition*/
				boolean condition = proccond1 || proccond2 || proccond3 || proccond4 || proccond5 || proccond6;
				if(condition) {
					ProcessBO process = Processes.findProcessBO(processID, bc);
					processName = process.getProcessName();
					SRMCollection processStepList = process.getProcessSteps();
					for(int i = 0; i<processStepList.size();i++){
						ProcessBO.ProcessSteps processStep = (ProcessBO.ProcessSteps) processStepList.get(i);
						if(processStep.getStepKey().intValue() == stepKey.intValue()){
							stepName = processStep.getStepDesc();
							break;
						}
					}
					String strXML = ApplRelPartyXML.generateXML(opportunityID,stepName,bc );
					////System.out.println("strXML "+strXML);
  					String bank_ID = bc.getBank_id();
					if(strXML != null){
						PreparedStmtParam[] param = new PreparedStmtParam[4];

						param[0] = new PreparedStmtParam(opportunityID, java.sql.Types.INTEGER);
						param[1] = new PreparedStmtParam(processName, java.sql.Types.VARCHAR);
						param[2] = new PreparedStmtParam(stepKey, java.sql.Types.INTEGER);
				        param[3] = new PreparedStmtParam(strXML, java.sql.Types.VARCHAR);
						db = new DBAccess();
						/* CRM11MEM Changes by Hema Start*/
						/*String insertEntry = "insert into TempStatData (OpportunityID, ProcessName, StepKey, XMLData, Bank_ID)  "
                                             + " values (?, ?, ?,?," + bank_ID + ")";*/
						String insertEntry = "insert into TempStatData (OpportunityID, ProcessName, StepKey, XMLData, Bank_ID)  "
											 + " values (?, ?, ?,?,'" + bank_ID + "')";
						/* CRM11MEM Changes by Hema End*/
            			db.setSQLExecStart( true );
            			db.executePreparedDML(insertEntry, param);
						db.setSQLExecEnd();
                		db.close();
					}
				}
			}
 /**** Alert server recon to 10.2.14 Start Tracker ID 378548 ****/
			//Alert server recon to 10.2.14 starts
				String stepState = activityBO.getStepState();
				boolean isAlertReq = Boolean.parseBoolean(EditorUtil.getAlertDetails());
				String internalAlert1 = null;
				String internalAlert2 = null;
				String externalAlert1 = null;
				String externalAlert2 = null;
				WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: AcitivityBOHook strIsAlertReq " +isAlertReq);
				if(isAlertReq){
					StackTraceElement[] stackTraceElements = Thread.currentThread().getStackTrace();
					ProcessBO process = Processes.findProcessBO(processID, bc);
					if(processID != null && "Completed".equals(stepState)){
						Integer contactID = activityBO.getContactID();
						Integer prospectID = activityBO.getProspectID();
						Integer nonCustomerID = activityBO.getNonCustomerID();
						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: ACTIVITYBOHook postWrite() Process STEP completion triggering starts");
						SRMCollection processStepList = process.getProcessSteps();
						int size= processStepList.size();
						for(int i = 0; i<size;i++){
							ProcessBO.ProcessSteps processStep = (ProcessBO.ProcessSteps) processStepList.get(i);
							if(processStep.getStepKey().intValue() == stepKey.intValue()){
								internalAlert1 = processStep.getInternalAlert1();
								internalAlert2 = processStep.getInternalAlert2();
								externalAlert1 = processStep.getExternalAlert1();
								externalAlert2 = processStep.getExternalAlert2();
								break;
							}
						}
						Properties keyProp = EditorUtil.getCIFGeneralInfo();
						String apprFlag = keyProp.getProperty(EditorUtil.APPROVAL_MECHANISM).trim();
						boolean apprProcess= false;
						HashMap parameterMap = new HashMap();
						ArrayList arrParamsList = new ArrayList();
						ProcessCRMAlert procCRMAlert = new ProcessCRMAlert();
						Integer iboID = null;
						Integer tempIboID = 0;
						Integer modIboID = 0;
						String strBOName = "";
						String strParam  = "";
						Integer orgModID = null;
						Integer contactModID = null;
						Integer prospectModID = null;
						Integer nonCustomerModID = null;
						Integer iProcAssignee = null;
						Integer iProcOwner = null;



						if(externalAlert1 != null || externalAlert2 != null || internalAlert1 != null || internalAlert2 != null) {
				   		    	orgModID = activityBO.getModOrgID();
				   		    	contactModID = activityBO.getModContactID();
				   		    	prospectModID = activityBO.getModProspectID();
				   		    	nonCustomerModID = activityBO.getModNonCustomerID();

				   		    	//Customer Checking
							    if(orgModID !=null || orgID != null) {

								//If approval enabled
									if("true".equals(apprFlag)) {
										if(null != orgModID){
											AccountModBO acctModBO = (AccountModBO)Utils.getBOFromID( bc, "AccountModBO",AccountModBO.ACCOUNTID, ""+ orgModID, false );
											Integer orgMainKey= acctModBO.getMainTableID();
											AccountBO acctBO = (AccountBO)Utils.getBOFromID( bc, "AccountBO",AccountBO.ACCOUNTID, ""+ orgMainKey, false );
											String entityCreateFlag =acctBO.getEntity_cre_flag();
											//AccountBO oldBO = (AccountBO)Core.getBOClone(acctBO);
											////System.out.println("**********oldBO**********"+oldBO);
											iProcAssignee = acctModBO.getAssignedTo();
											////System.out.println("**********insideiProcAssignee**********"+iProcAssignee);
											iProcOwner= acctModBO.getOwnedUserID();
											////System.out.println("**********inside iProcOwner**********"+iProcOwner);
											iboID = orgMainKey;
											tempIboID= orgModID;
											modIboID=orgModID;
											strBOName = "AccountBO";
											apprProcess= true;
											strParam = "CIF_ID";
											parameterMap.put("CIF_TYPE","CUSTOMERMOD");

										//Approved records
										} else {
											 iboID = orgID;
											 tempIboID= orgID;
											 modIboID=orgID;
											 strBOName = "AccountBO";
											 apprProcess= false;
											 strParam = "CIF_ID";
											 parameterMap.put("CIF_TYPE","CUSTOMER");
										}
									}
									//	If approval disabled
									else {
										 iboID = orgID;
										 tempIboID= orgID;
										 modIboID=orgID;
										 strBOName = "AccountBO";
										 apprProcess= false;
										 strParam = "CIF_ID";
										 parameterMap.put("CIF_TYPE","CUSTOMER");
									}
								}

							    // Contact Checking
							    if(contactModID !=null || contactID != null) {

									//If approval enabled
										if("true".equals(apprFlag)) {
											if(null != contactModID){
												ContactModBO contModBO = (ContactModBO)Utils.getBOFromID( bc, "ContactModBO",ContactModBO.CONTACTID, ""+ contactModID, false );
												Integer orgMainKey= contModBO.getMainTableID();
												ContactBO contactBO = (ContactBO)Utils.getBOFromID( bc, "ContactBO",ContactBO.CONTACTID, ""+ orgMainKey, false );
												String entityCreateFlag =contactBO.getEntity_cre_flag();
											 	//ContactBO oldBO = (ContactBO)Core.getBOClone(contactBO);
											 	////System.out.println("**********oldBO**********"+oldBO);
											 	iProcAssignee = contModBO.getAssignedTo();
											 	////System.out.println("**********insideiProcAssignee**********"+iProcAssignee);
												iProcOwner= contModBO.getOwnedUserID();
												////System.out.println("**********inside iProcOwner**********"+iProcOwner);
											 	iboID = orgMainKey;
											 	modIboID=contactModID;
											 	tempIboID= contactModID;
												strBOName = "ContactBO";
												apprProcess= true;
												strParam = "CIF_ID";
												parameterMap.put("CIF_TYPE","CONTACTMOD");

											//Approved records
											} else {
												 iboID = contactID;
												 modIboID=contactID;
												 tempIboID= contactID;
												 strBOName = "ContactBO";
												 apprProcess= false;
												 strParam = "CIF_ID";
												 parameterMap.put("CIF_TYPE","CONTACT");
											}
										}
										//	If approval disabled
										else {
											 iboID = contactID;
											 modIboID=contactID;
											 tempIboID= contactID;
											 strBOName = "ContactBO";
											 apprProcess= false;
											 strParam = "CIF_ID";
											 parameterMap.put("CIF_TYPE","CONTACT");
										}
								}

							    //Checking for Prospect
							    if(prospectModID !=null || prospectID != null) {

									//If approval enabled
										if("true".equals(apprFlag)) {
											if(null != prospectModID){
												SuspectModBO suspModBO = (SuspectModBO)Utils.getBOFromID( bc, "SuspectModBO",SuspectModBO.SUSPECTID, ""+ prospectModID, false );
												Integer orgMainKey= suspModBO.getMainTableID();
												SuspectBO suspBO = (SuspectBO)Utils.getBOFromID( bc, "SuspectBO",SuspectBO.SUSPECTID, ""+ orgMainKey, false );
												String entityCreateFlag =suspBO.getEntity_cre_flag();
												//SuspectBO oldBO = (SuspectBO)Core.getBOClone(suspBO);
												////System.out.println("**********oldBO**********"+oldBO);
												iProcAssignee = suspModBO.getAssignedTo();
												////System.out.println("**********insideiProcAssignee**********"+iProcAssignee);
												iProcOwner= suspModBO.getOwneduserid();
												////System.out.println("**********inside iProcOwner**********"+iProcOwner);
												iboID = orgMainKey;
											 	modIboID=prospectModID;
											 	tempIboID= prospectModID;
												strBOName = "SuspectBO";
												apprProcess= true;
												strParam = "CIF_ID";
												parameterMap.put("CIF_TYPE","PROSPECTMOD");

											//Approved records
											} else {
												 iboID = prospectID;
												 modIboID=prospectID;
												 tempIboID= prospectID;
												 strBOName = "SuspectBO";
												 apprProcess= false;
												 strParam = "CIF_ID";
												 parameterMap.put("CIF_TYPE","PROSPECT");
											}
										}

										//	If approval disabled
										else {
											 iboID = prospectID;
											 modIboID=prospectID;
											 tempIboID= prospectID;
											 strBOName = "SuspectBO";
											 apprProcess= false;
											 strParam = "CIF_ID";
											 parameterMap.put("CIF_TYPE","PROSPECT");
										}
									}
							    if(nonCustomerModID !=null || nonCustomerID != null) {

									//If approval enabled
										if("true".equals(apprFlag)) {
											if(null != nonCustomerModID){
												NonCustomerModBO nonCustModBO = (NonCustomerModBO)Utils.getBOFromID( bc, "NonCustomerModBO",NonCustomerModBO.NONCUSTOMERID, ""+ nonCustomerModID, false );
												Integer orgMainKey= nonCustModBO.getMainTableID();
												NonCustomerBO nonCustBO = (NonCustomerBO)Utils.getBOFromID( bc, "NonCustomerBO",NonCustomerBO.NONCUSTOMERID, ""+ orgMainKey, false );
												String entityCreateFlag =nonCustBO.getEntity_cre_flg();
												//NonCustomerBO oldBO = (NonCustomerBO)Core.getBOClone(nonCustBO);
												////System.out.println("**********oldBO**********"+oldBO);
												iProcAssignee = nonCustModBO.getAssignedTo();
												////System.out.println("**********insideiProcAssignee**********"+iProcAssignee);
												iProcOwner= nonCustModBO.getOwnedUserID();
												////System.out.println("**********inside iProcOwner**********"+iProcOwner);
												iboID = orgMainKey;
												modIboID=nonCustomerModID;
												tempIboID= nonCustomerModID;
												strBOName = "NonCustomerBO";
												apprProcess= true;
												strParam = "CIF_ID";
												parameterMap.put("CIF_TYPE","NONCUSTOMERMOD");

											//Approved records
											} else {
												 iboID = nonCustomerID;
												 modIboID=nonCustomerID;
												 tempIboID= nonCustomerID;
												 strBOName = "NonCustomerBO";
												 apprProcess= false;
												 strParam = "CIF_ID";
												 parameterMap.put("CIF_TYPE","NONCUSTOMER");
											}
										}
										//	If approval disabled
										else {
											 iboID = nonCustomerID;
											 modIboID=nonCustomerID;
											 tempIboID= nonCustomerID;
											 strBOName = "NonCustomerBO";
											 apprProcess= false;
											 strParam = "CIF_ID";
											 parameterMap.put("CIF_TYPE","NONCUSTOMER");
										}
									}
							    if(incidentID!= null){
									IncidentBO incidentBO = (IncidentBO)Utils.getBOFromID( bc, "IncidentBO",IncidentBO.INCIDENTID, ""+ incidentID, false );
									Integer cifId = null;
									iboID = incidentID;
									tempIboID = incidentID;
									strBOName = "IncidentBO";
									strParam = "INCIDENT_ID";
									apprProcess= false;

									String inciFor = incidentBO.getIncidentFor();
									if("CUSTOMER".equalsIgnoreCase(inciFor))
										cifId = incidentBO.getOrgID();
									else if("CONTACT".equalsIgnoreCase(inciFor))
										cifId = incidentBO.getContactID();
									else if("PROSPECT".equalsIgnoreCase(inciFor))
										cifId = incidentBO.getSuspectID();

									parameterMap.put("CIF_TYPE", inciFor);
									parameterMap.put("CIF_ID", cifId);

								}
								if(opportunityID!= null){
									OpportunityBO oppBO = (OpportunityBO)Utils.getBOFromID( bc, "OpportunityBO",OpportunityBO.OPPORTUNITYID, ""+ opportunityID, false );
									Integer cifId = null;
									iboID = opportunityID;
									tempIboID = opportunityID;
									strBOName = "OpportunityBO";
									strParam = "OPPORTUNITY_ID";
									apprProcess= false;

									String oppoFor = oppBO.getOpportunityFor();
									if("CUSTOMER".equalsIgnoreCase(oppoFor))
										cifId = oppBO.getOrgID();
									else if("CONTACT".equalsIgnoreCase(oppoFor))
										cifId = oppBO.getContactID();
									else if("PROSPECT".equalsIgnoreCase(oppoFor))
										cifId = oppBO.getSuspectID();

									parameterMap.put("CIF_TYPE", oppoFor);
									parameterMap.put("CIF_ID", cifId);

								}
				   		    }


						ArrayList activityAlertList = new ArrayList();
						if(internalAlert1 != null)
							activityAlertList.add(internalAlert1);
						if(internalAlert2 != null)
							activityAlertList.add(internalAlert2);
						if(externalAlert1 != null)
							activityAlertList.add(externalAlert1);
						if(externalAlert2 != null)
							activityAlertList.add(externalAlert2);
						if(activityAlertList.size() > 0 && ((!("true".equals(apprFlag))) || (incidentID!= null || opportunityID!= null || nonCustomerModID != null || prospectModID !=null || contactModID !=null || orgModID !=null))) {
							WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: ACTIVITYBOHook postWrite() Process STEP completion triggering activityAlertList size >0");
							arrParamsList.add(0,strBOName);
							arrParamsList.add(1,iboID);
							arrParamsList.add(2,bc.getBank_id());
							arrParamsList.add(3,apprProcess);
							arrParamsList.add(4,modIboID);
							parameterMap.put(strParam,tempIboID);
							//System.out.println("System Call Stact Trace");
														for (int i=2 ; i<stackTraceElements.length; i++)
														{
															StackTraceElement ste = stackTraceElements[i];
															String classname = ste.getClassName();
															String methodName = ste.getMethodName();
															int lineNumber = ste.getLineNumber();
															//System.out.println(classname+"."+methodName+":"+lineNumber);
														}

							procCRMAlert.generateBOAlert(parameterMap, arrParamsList,activityAlertList,iProcAssignee,iProcOwner);
						}
						WebAdaptor.log(com.infy.cis.log.LogType.DEBUG,"Alertserver: ACTIVITYBOHook postWrite() Process STEP completion triggering ends");

				}
			}
		}

	/**** Alert server recon to 10.2.14 End    Tracker ID 378548 ****/
		//Alert server recon to 10.2.14 ends
		catch(Exception e){
		}finally{
			if(db!=null){
				db.close();
			}
		}
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


}
