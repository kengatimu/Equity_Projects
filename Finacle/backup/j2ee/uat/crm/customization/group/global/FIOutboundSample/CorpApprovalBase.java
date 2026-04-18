/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CorpApprovalBase.java $
 *
 * Author: Aditya_Mohanty
 *
 * $Archive: /FCRM62BASE/com/infy/cis/ui/corpcif/CorpApprovalBase.java $
 *
 * $History: CorpApprovalBase.java $

 ******************************************************************************/
package com.infy.cis.custom;

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
import java.sql.*;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.infy.cis.srmbo.*;
import com.infy.cis.daemons.*;
import com.infy.cis.ui.common.*;
import com.infy.cis.log.LogType ;
import com.infy.cis.srmbo.security.user.SRMLogonContext;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.srmbo.security.user.SRMSecurityManager;
import com.infy.cis.adaptor.web.WebAdaptor;
import com.infy.cis.common.dbmgr.IDBOps;
import com.infy.cis.common.dbmgr.SRMDBMgrDefaultProvider;
import com.infy.cis.exception.SRMDBException;

import com.infy.cis.ui.cif.*;
import com.infy.cis.ui.cif.DedupConf;

//Fioutbound: added for using same BC
import com.infy.cis.common.dbmgr.* ;
import com.infy.cis.exception.SRMSecurityException;

//Fioutbound: Added for getting CisSessionContext
import com.infy.cis.servletruntime.*;

//FI Out custom client
import com.infosys.ci.fioutbound.client.*;



/**
	*Brief Description of class:
	*
	*Functionality: The base class which will get invoked from Daemon and Corporate BO entry.
	*
	*@author: Aditya_Mohanty
	*
	*External Methods called:
	*
	*Known Bugs:
	*
	*Start Date: 10\10\2006
	*
	*Modification log :
*/

public class CorpApprovalBase extends DaemonBase
{

    SRMLogonContext lc	  = null;
	SRMBusinessContext bc = null;
    DedupRefresh ref	  = null;
	IDBOps idbOps 		  = null;

    /*
	 * defined Connection Variable which will be passed to further files.
     */

    /*
     * Assigning processid and stepkey to 0 for Corp Approval checks.
     */
    int iProcessId        = 0;
    int iStepKey          = 0;

	String keydata        = null;
	String inputMesg      = null;
	String InputMesg      = null;

    public CorpApprovalBase()
    {
	}

    /*
     * invokeCorpApproval method which will be invoked by Daemon for process related Corp Approval Checks
     */

    public void invokeCorpApproval()
    {

			String SIMPLERM_ROOT          = System.getProperty("SIMPLERM_ROOT");
			System.setProperty("FIN_APP_PATH", SIMPLERM_ROOT);
			System.setProperty("FIN_PROP_FILE","Interface/properties/fi_client.properties");

			try{
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

			ResultSet rs          = null;
			String strCorpKey     = null;

			int processId         = getProcessID();
			int stepKey           = getStepKey();
			String strEntityName  = getEntityName();


			try
			{
				lc = getLogonContext();
				bc	=  SRMSecurityManager.createBusinessContext(lc,true,java.sql.Connection.TRANSACTION_READ_COMMITTED);
			}catch(Exception e)
			{
				WebAdaptor.log(com.infy.cis.log.LogType.MINOR, e.toString());
				throw e;
			}

			//getting the DB connection
			try
			{
				idbOps = SRMDBMgrDefaultProvider.getDBOps();
			}catch (Exception exp) {
				WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "Could not get dbops");
			}
			if(idbOps == null) {
				WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "Could not get iDBOps");
			}


			try
			{
				String userInfoPart      = "<FiUserInfo>UserId,"+userId+"|ApplicationId,"+applicationId+"|ChannelId,"+accessChannelId+"|BankId,"+bankId+"|CorrelationId,"+CorrelationId+"</FiUserInfo>";

				// forming the input message by taking data from Corporate_Mod table

				String strQuery	= "Select CORPMOD_ID,ENTITY_TYPE,CORPORATE_NAME,CORPORATENAME_NATIVE,"+
				"RELATIONSHIP_STARTDATE,STATUS,PRIORITY,DELINQUENCY_FLAG,BLACKLIST_FLAG,LEGALENTITY_TYPE,"+
				"SEGMENT,KEYCONTACT_PERSONNAME,BUSINESS_TYPE from Corporate_Mod where ProcessID = "+processId+
				" and CurrentStep = " + stepKey + " and ProcessStatus = 'open' ";
				rs = (ResultSet)idbOps.execSQL(strQuery);
				try
				{
				  if(rs.next())
				  {
					String corpidNV          = "corpid,"+rs.getInt(1)+"|";
					String entityTypeNV      = "entityType,"+rs.getString(2)+"|";
					String corpNameNV        = "corpName,"+rs.getString(3)+"|";
					String corpNameNativeNV  = "corpNameNative,"+rs.getString(4)+"|";
					String relnStartdateNV   = "relnStartdate,"+rs.getString(5)+"|";
					String statusNV          = "status,"+rs.getString(6)+"|";
					String priorityNV        = "priority,"+rs.getString(7)+"|";
					String delinqFlagNV      = "delinqFlag,"+rs.getString(8)+"|";
					String blackListFlagNV   = "blackListFlag,"+rs.getString(9)+"|";
					String legalEntTypNV     = "legalEntTyp,"+rs.getString(10)+"|";
					String segmentNV         = "segment,"+rs.getString(11)+"|";
					String contactNameNV     = "contactName,"+rs.getString(12)+"|";
					String BusinesstypeNV    = "Businesstype,"+rs.getString(13);


					String inputMesgPart = corpidNV+entityTypeNV+corpNameNV+corpNameNativeNV+
									relnStartdateNV+statusNV+priorityNV+delinqFlagNV+blackListFlagNV+
									legalEntTypNV+segmentNV+contactNameNV+BusinesstypeNV;


					String InputMesg = userInfoPart+"<InputMesg>"+inputMesgPart+"</InputMesg>";

				   }
				}
				catch(SQLException exSQL) {
					WebAdaptor.log (LogType.EVENT, "Error Retrieving record...");
					throw new Exception(exSQL.toString());
				} finally{
					if(rs!=null){
						rs.close();
					}
					if(idbOps!=null){
						idbOps.Release();
					}
				}

			}catch(SRMDBException dbException) {
				WebAdaptor.log (LogType.EVENT, "Transaction Already started...");
				throw new Exception(dbException.toString());
			}


			try
			{

			//Logic for insert into Fi Table Here

			FIOutboundDBOps  outDBops = new FIOutboundDBOps();
			outDBops.insertIntoRepl(bc,userId,bankId,InputMesg);
			bc.terminate(true);

			}

			catch(SRMSecurityException se)
			{
				WebAdaptor.log(com.infy.cis.log.LogType.MINOR,se.toString());
				throw new Exception(se.toString());
			}

			catch (SRMDBException dbexcp)
			{
				WebAdaptor.log(com.infy.cis.log.LogType.MINOR,dbexcp.toString());
				throw new Exception(dbexcp.toString());
			}


		}
	}

	catch (Exception e)
	{
		try{
		bc.terminate(false);
		}
		catch (SRMDBException dbe)
		{
			WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "Could not terminate the BC");
		}
	}

}

}