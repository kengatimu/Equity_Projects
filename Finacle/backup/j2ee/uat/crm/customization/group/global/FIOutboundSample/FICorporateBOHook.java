/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CorporateBOHook.java $
 *
 * Author: Aditya_Mohanty
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/CorporateBOHook.java $
 *
 * *********************************** */

/* CRM61SR:SRCIUHBO:TRACKER# 44231 **BEGIN  CHANGES** */
package com.infy.cis.custom;

import com.infy.cis.srmbo.IHooks;
import com.infy.cis.srmbo.CorporateBO;
import com.infy.cis.srmbo.SRMCollection;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.exception.*;


import com.infy.cis.srmbo.*;
import java.util.Date;
import com.infosys.insulate.util.HashMap;
import java.sql.*;
import javax.sql.DataSource;
import javax.naming.InitialContext;


//FIOutbound: added for using same BC
import com.infy.cis.common.dbmgr.* ;
//FIOutbound: added for using same BC

//FIOutbound: Added for getting CisSessionContext
import com.infy.cis.servletruntime.*;

import com.infy.cis.adaptor.web.WebAdaptor;

//FI Out custom client
import com.infosys.ci.fioutbound.client.*;



public class FICorporateBOHook implements IHooks {

   public FICorporateBOHook(){}



	public void preWrite (SRMBusinessContext bc, Object bo)
	 throws SRMPreWriteException {
		CorporateBO boCorporate = (CorporateBO)bo;
		int  ret = 0;
		boolean status = false;

		String SIMPLERM_ROOT          = System.getProperty("SIMPLERM_ROOT");
		System.setProperty("FIN_APP_PATH", SIMPLERM_ROOT);
		System.setProperty("FIN_PROP_FILE","Interface/properties/fi_client.properties");

		try{
		//get the CIS session context
		CISSessionContext  sc =  ((com.infy.cis.servletruntime.CISSessionContext) com.infy.cis.common.SRMTLVar.sc.get());

		String userId            = sc.getAgentName();

		String applicationId     = FIOUTClientAppProperties.getProperty("APPLICATION_ID");
		String accessChannelId   = FIOUTClientAppProperties.getProperty("ACCESS_CHANNEL_ID");
        String bankId            = FIOUTClientAppProperties.getProperty("BANK_ID");
        String CorrelationId     = null;


		if (applicationId == null)
		{
			WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "application id is null");
			throw new Exception("application id is null");
		}
		else if (accessChannelId == null)
		{
			WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "channel id is null");
			throw new Exception("channel id is null");
		}
		else if (bankId == null)
		{
			WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "bank id is null");
			throw new Exception("bank id is null");
		}
		else
		{

		//form the userInfo part
		String userInfoPart      = "<FiUserInfo>UserId,"+userId+"|ApplicationId,"+applicationId+"|ChannelId,"+accessChannelId+"|BankId,"+bankId+"|CorrelationId,"+CorrelationId+"</FiUserInfo>";

		//get the details from the FCRM UI for corporate BO and conactenating it with delimiters in between

		String corpidNV          = "corpid,"+boCorporate.getCorp_ID()+"|";
		String entityTypeNV      = "entityType,"+boCorporate.getEntity_Type()+"|";
		String corpNameNV        = "corpName,"+boCorporate.getCorporate_Name()+"|";
		String corpNameNativeNV  = "corpNameNative,"+boCorporate.getCorporateName_Native()+"|";
		String relnStartdateNV   = "relnStartdate,"+boCorporate.getRelationship_StartDate()+"|";
		String statusNV          = "status,"+boCorporate.getStatus()+"|";
		String priorityNV        = "priority,"+boCorporate.getPriority()+"|";
		String delinqFlagNV      = "delinqFlag,"+boCorporate.getDelinquency_Flag()+"|";
		String blackListFlagNV   = "blackListFlag,"+boCorporate.getBlacklist_Flag()+"|";
		String legalEntTypNV     = "legalEntTyp,"+boCorporate.getLegalEntity_Type()+"|";
		String segmentNV         = "segment,"+boCorporate.getSegment()+"|";
		String contactNameNV     = "contactName,"+boCorporate.getKeyContact_PersonName()+"|";
		String BusinesstypeNV    = "Businesstype,"+boCorporate.getBusiness_Type();

		String inputMesgPart     = corpidNV+entityTypeNV+corpNameNV+corpNameNativeNV+relnStartdateNV+statusNV+priorityNV+delinqFlagNV+
						           blackListFlagNV+legalEntTypNV+segmentNV+contactNameNV+BusinesstypeNV;

		//form the final input message
		String finalInpMesg      = 	userInfoPart+"<InputMesg>"+inputMesgPart+"</InputMesg>";

		FIOutboundDBOps  outDBops = new FIOutboundDBOps();
		outDBops.insertIntoRepl(bc,userId,bankId,finalInpMesg);

		//terminate the business context
		status = true;

		}
		}
		catch (SRMSecurityException se)
		{
			WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "SRM security exception occured");
//			throw new Exception("SRM security exception occured");
			status = false;

		}

		catch (SRMDBException se)
		{
			WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "SRM DB exception occured in insertIntoRepl()");
//			throw new Exception("SRM DB exception occured");
			status = false;

		}
		catch (Exception e)
		{
			status = false;
		}
		finally
		{
			try{
			bc.terminate(status);//terminate the BC
			}
			catch (SRMDBException dbe)
			{
				WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "Could not terminate the BC");
			}
		}


	 }



// sample hook - postWrite

  public void postWrite (SRMBusinessContext bc, Object bo)
    throws SRMPostWriteException {


	   // customized implementation place holder
	}

 /* CRM61SR:SREVNTBO:TRACKER# 44228 **END OF CHANGES** */
   //AccountBO abo = (AccountBO)bo;


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
