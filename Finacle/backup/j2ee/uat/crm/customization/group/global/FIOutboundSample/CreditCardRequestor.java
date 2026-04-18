/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CreditCardRequestor.java $
 *
 * Author: amitsingh_pundeer
 *
 * $Archive: /FCRM100/com/infy/cis/custom/FIOutboundSample/CreditCardRequestor.java $
 *
 * *********************************** */


package com.infy.cis.custom;


import java.io.*;
import java.io.*;
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
import com.infy.COTP.LinkList;
import com.infy.bbu.LimoClient;
import com.infosys.ci.fioutbound.client.*;
import com.infy.cis.adaptor.web.WebAdaptor;
import com.infy.cis.srmbo.security.user.SRMLogonContext;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.srmbo.security.user.SRMSecurityManager;
import com.infy.cis.common.dbmgr.SRMDBMgrDefaultProvider;
import com.infy.cis.exception.SRMDBException;
import com.infy.cis.exception.SRMSecurityException;
import com.infy.cis.ui.cif.*;
import com.infy.cis.ui.cif.DedupConf;
import com.infy.cis.common.dbmgr.* ;
import com.infy.cis.custom.FIOutboundDBOps;


public class CreditCardRequestor {

	public FIOutboundRequestor os = null;
	int iReturnVal ;
	int freeConn   = 0;

	public CreditCardRequestor()
	{

	}
	public int SendMesg(String userId,String InputMessage, ReqOutputMesg outMsg)
	{
		LinkList ferr 		= new LinkList("com.infosys.ci.fioutbound.client.FIOutboundFatalError");
		LinkList nferr 		= new LinkList("com.infosys.ci.fioutbound.client.FIOutboundNonFatalError");
		LinkList outputMesg = new LinkList("com.infosys.ci.fioutbound.client.ReqOutputMesg");

		ReqInputMesg input  		  = new ReqInputMesg();
		FIOutboundUserInfo OBUserInfo = new FIOutboundUserInfo();
		int ret = 0;
		String msgId = null;

		try
		{

			//setting system properties
			String SIMPLERM_ROOT          = System.getProperty("SIMPLERM_ROOT");
			System.setProperty("FIN_APP_PATH",SIMPLERM_ROOT);
			System.setProperty("FIN_PROP_FILE","Interface/properties/fi_client.properties");

			//Getting values from property file
			String profileId 			  = FIOUTClientAppProperties.getProperty("REQUESTOR_PROFILE_ID");
  			String applicationId		  = FIOUTClientAppProperties.getProperty("APPLICATION_ID");
			String accessChannelId  	  = FIOUTClientAppProperties.getProperty("ACCESS_CHANNEL_ID");
			String bankId  	  			  = FIOUTClientAppProperties.getProperty("BANK_ID");
			String CorrelationId		  = null;

			if(applicationId==null)
			{
				outMsg.outputMessage = "INVALID VALUE OF APPLICATION ID";
				WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "INVALID VALUE OF APPLICATION ID");
				return iReturnVal;
			}

			if(accessChannelId==null)
			{
				outMsg.outputMessage = "INVALID VALUE OF ACCESS CHANNEL ID";
				WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "INVALID VALUE OF ACCESS CHANNEL ID");
				return iReturnVal;
			}

			//Generating the message Id
			FIOutboundClient OBClient = new FIOutboundClient();
			msgId = OBClient.getMessageId(applicationId);

			//Populating FIOutboundUserInfo
			OBUserInfo.userId   	  	= userId;
			OBUserInfo.applicationId   	= applicationId;
			OBUserInfo.accessChannelId  = accessChannelId;
			OBUserInfo.bankId    		= bankId;

			//populating the input message
			input.profileId             = profileId;
			input.inputMessage          = "<FiUserInfo>User Id,"+userId+"|Application Id,"+applicationId+"|Channel Id,"+accessChannelId+"|Correlation Id,"+CorrelationId+"|Bank Id,"+bankId+"</FiUserInfo>"+InputMessage ;
			input.messageId				= msgId;

			//Getting the orb instance
			os = FIConnectionPool.getOrbInstance();

			if (os == null)
			{
				ret = -2;
			}
			else
			{
			//making the server call
			 	ret = os.OutBoundReqProcMesg(OBUserInfo,input,outputMesg,ferr,nferr);
			}
				//Handling the different return values from the server
				switch (ret)
				{
					case 0:
					if(ferr.size()!=0)
					{
					outMsg.outputMessage = "Fatal Errorin APP CLASS at server "+((FIOutboundFatalError)ferr.get(0)).errorMesg ;
					iReturnVal = 2;
					}
					if(nferr.size()!=0)
					{
					outMsg.outputMessage = "NonFatal Error in APP CLASS at server "+((FIOutboundNonFatalError)nferr.get(0)).errorMesg  ;
					iReturnVal = 2;
					}
					if(outputMesg.size()!=0)
					{
					outMsg.outputMessage = ((ReqOutputMesg)outputMesg.get(0)).outputMessage ;
					iReturnVal = 0;
					}
					break;

					case -1:
					outMsg.outputMessage = "Service Failed ";
					WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "Service Failed");
					iReturnVal = 1;
					break;

					case -2:
					outMsg.outputMessage = "Service Not Available ";
					WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "Service Not Available");
					iReturnVal = 1;
					break;

					case -3:
					outMsg.outputMessage = "Error In Transieve ";
					WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "Error In Transieve ");
					iReturnVal = 1;
					break;

					case -4:
					outMsg.outputMessage = "Abnormal Termination ";
					WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "Abnormal Termination");
					iReturnVal = 1;
					break;

					case -5:
					outMsg.outputMessage = "Server did not respond ";
					WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "Server did not respond");
					iReturnVal = 1;
					break;

					case -7:
					outMsg.outputMessage = "Abnormal Termination RAC ";
					WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "Abnormal Termination RAC");
					iReturnVal = 1;
					break;

					default:
					outMsg.outputMessage = "Unknown Error occured ";
					WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "Unknown Error occured");
					iReturnVal = 1;
					break;
				}

		}
		catch(Exception e)
		{
			outMsg.outputMessage = "Error at client: "+ e ;
			WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "Unknown Error occured"+e);
			iReturnVal = 1;
		}
		finally
		{
			if (os != null)
			FIConnectionPool.freeOrbInstance(os, freeConn);
		}


		if (iReturnVal ==1 && ret != -2  )
		{
			/*Error returned from App Class, Marking the record for reversal*/

			try
			{
				FIOutboundDBOps  outDBops = new FIOutboundDBOps();
				outDBops.updateLogtable(userId,msgId);
			}catch (SRMDBException sdbe)
			{
				WebAdaptor.log(com.infy.cis.log.LogType.MINOR, "SRM DB exception occured while updating outbound log table:"+sdbe);
			}

		}

		return iReturnVal;

 	}


}