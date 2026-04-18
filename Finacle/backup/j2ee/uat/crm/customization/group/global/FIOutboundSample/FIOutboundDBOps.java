package com.infy.cis.custom;

import com.infy.cis.srmbo.security.user.SRMLogonContext;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;
import com.infy.cis.srmbo.security.user.SRMSecurityManager;
import com.infy.cis.exception.*;
import com.infy.cis.common.dbmgr.* ;
import com.infosys.ci.fioutbound.client.FIOUTClientAppProperties;

public class FIOutboundDBOps {

	public void insertIntoRepl (SRMBusinessContext bcCorp,String userID,String bankId, String InputMesg)
	throws SRMSecurityException,SRMDBException
	{


			int        profileID     = Integer.parseInt(FIOUTClientAppProperties.getProperty("DATASYNC_PROFILE_ID"));//gets the profile detail from the properties file
			int        retryCount    = 0; //always zero because it is the first time insertion
			int        datatype      = 2; //2 is for the EMS format
			String     entityID      = "E1234";
			String     createUser    = userID;
			String     lmu           = userID;
			String     replStatus    = "W"; // it should be "W" for the first-time insertion.Hnece hard-coded
			String     profStatus    = "processed"; // the record should have the status as 'verified' before inserting. Hence hard-coded
			String     statRemarks   = "Waiting to be Synchronised"; //the remarks should be the same. hence hard-coded
			String     keydata       = null;
			String     inputMesg     = InputMesg;
			String     fmtInputMesg  = null;
			String     outputMesg    = null;
			String     fmtOutputMesg = null;
			String     mesgId        = null;



			//getting the DB connection
			IDBBase dbsvc = bcCorp.getDBAccessPoint();

			//forming the insert query
			String insertQuery = "INSERT INTO OUTBOUND_REPLICATION"+
								 "(REPL_SRL_NUM,"+
			 					 "REPL_MESSAGE_ID,"+
			 					 "REPL_STATUS,"+
			 					 "REPL_ENTITY_ID,"+
								 "OUTBOUND_PROF_ID,"+
			 					 "OUTBOUND_PROF_STATUS,"+
			 					 "KEY_DATA,"+
			 					 "REPL_STATUS_REMARKS,"+
			 					 "REPL_INPUT_MESG,"+
					  			 "REPL_FORMATTED_INPUT_MESG,"+
			 					 "REPL_OUTPUT_MESG,"+
			 					 "REPL_FORMATTED_OUTPUT_MESG,"+
			 					 "REC_RETRY_COUNT,"+
			 					 "REPL_REC_LMU,"+
			 					 "REPL_REC_LMD,"+
			 					 "REPL_DATA_TYPE,"+
			 					 "REC_CRE_USER,"+
 								 "REC_CRE_DATE,"+
 								 "BANK_ID)"+
								 " VALUES"+
								 "(FI_REPL_SRL_ID.nextval,"+
								 "'"+mesgId+"',"+
								 "'"+replStatus+"',"+
								 "'"+entityID+"',"+
								 +profileID+","+
								 "'"+profStatus+"',"+
						 		"'"+keydata+"',"+
						 		"'"+statRemarks+"',"+
						 		"'"+inputMesg+"',"+
						 		"'"+fmtInputMesg+"',"+
						 		"'"+outputMesg+"',"+
						 		"'"+fmtOutputMesg+"',"+
						 		retryCount+","+
						 		"'"+lmu+"',"+
						 		"sysdate,"+
			             		datatype+","+
			             		"'"+createUser+"',"+
			             		"sysdate,"+
			             		bankId +
			             		")";


			//executing the query
			dbsvc.execSQL(insertQuery);

	}

/*********************Method for updating record for reversal********/
public void updateLogtable (String userId,String messageId)
	   throws SRMDBException
	{
			IDBOps idbOps = SRMDBMgrDefaultProvider.getDBOps();
			String strQuery	= "UPDATE OUTBOUND_LOG set "+
								"MESG_STATUS = 'R',"+
								"MESG_STATUS_REMARKS = 'Marked for Reversal',"+
								"LOG_REC_LMD = sysdate,"+
								"LOG_REC_LMU='"+userId+"'"+
								"where MESSAGE_ID ='"+messageId+"'" ;
			idbOps.execSQL(strQuery);
	}
/*********************************************************************/

}