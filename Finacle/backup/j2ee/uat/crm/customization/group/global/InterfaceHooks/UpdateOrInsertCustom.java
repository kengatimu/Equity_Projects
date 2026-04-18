/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: UpdateOrInsertCustom.java $
 *
 * Author: Jamuna G
 *
 * $Archive: /FCRM62BASE/Interface/Source/com/infy/custom/UpdateOrInsertCustom.java $
 *
 *
 * $History: UpdateOrInsertCustom.java $
 *
 * *****************  Version 4  *****************
 * User: Gayasb_moghal Date: 19/06/03   Time: 3:46p
 * Updated in $/FCRM62BASE/Interface/Source/com/infy/custom
 * Tracker : 52815
 * Removed Unwanted system.out.println and used Debug.print to log into
 * error logger.
 *
 * Modified By:
 * Raghavendren
 *
 * Reviewed By:
 * Gayas Baig Moghal
 *
 * *****************  Version 3  *****************
 * User: Sudhindra_magadi Date: 3/07/03    Time: 5:56p
 * Updated in $/FCRM62BASE/Interface/Source/com/infy/custom
 * For Performance Related Changes
 *
 * *****************  Version 2  *****************
 * User: Anurag_gupta Date: 12/21/02   Time: 5:43p
 * Updated in $/CRM61DEV/Interface/Source/com/infy/custom
 * Tracker id -44228---
 *
 * Checking is done for DOB field , if at all it is coming null, just
 * ignore call to that function.
 *
 * *****************  Version 1  *****************
 * User: Deepak_sethumadhavan Date: 12/12/02   Time: 9:10p
 * Created in $/CRM61DEV/Interface/Source/com/infy/custom
 * CRM61SR --
 *
 * New Custom files For UpdateOrInsertCustom
 *
 */

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **BEGIN  CHANGES** */

package com.infy.intl.custom;

import com.infosys.insulate.util.Vector;
import java.util.Hashtable;
import java.sql.Connection;
import java.util.Date;
import java.sql.Statement;
import java.sql.ResultSet;


import com.infy.intl.exception.IntlBypassException;
import com.infy.intl.custom.UpdateOrInsertIHook;

import com.infy.intl.common.InterfaceDBAccess;
import com.infy.intl.common.InterfaceResultSet;
import com.infy.intl.util.*;

import com.infy.cis.common.MEUtils;
public class UpdateOrInsertCustom implements UpdateOrInsertIHook {
	/*CRM101MN: Multi Entitiy changes start*/
	/*updated for:bankID is used as a filter*/

	/* CRM11MEM Changes by Hema Start*/
	//final String bankID = (String)com.infy.cis.common.SRMTLVar.bank_id.get();
	final String bankID = MEUtils.getBankId();
	/* CRM11MEM Changes by Hema End*/
	/*CRM101MN: Multi Entitiy changes end*/

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return		void
	 	 * @exception   IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */

    public void preinsertRec(Connection ConnCRM, String strSalesID, String strProductType, Hashtable htbTranData,
									Vector vctExtraData, Hashtable htbCRMMetaData,
									String strRole,boolean isStandAlone,String strPSPersonType,
									String strUploadType) throws IntlBypassException{



	//if the base interface related code needs to be bypassed , then IntlBypassException needs to be thrown
	//throw  new IntlBypassException("IntlBypassException occured.......");

	}


	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return		void
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */


    public String postinsertRec(Connection ConnCRM, String strSalesID, String strProductType, Hashtable htbTranData,
								Vector vctExtraData, Hashtable htbCRMMetaData,
								String strRole,boolean isStandAlone,String strPSPersonType,
								String strUploadType,String strRetVal){
    return  strRetVal;

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return			void
	 	 * @exception		IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */


	public void preinsertIntoAcc(Connection ConnCRM, Hashtable htbAcc, Hashtable htbCRMMetaData)
										 throws IntlBypassException {

	//throw  new IntlBypassException("IntlBypassException occured.......");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return			void
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */


    public int postinsertIntoAcc(Connection ConnCRM, Hashtable htbAcc,
    							  Hashtable htbCRMMetaData , int iRetVal){

	return iRetVal;
	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return			void
	 	 * @exception		IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */



	public void preinsertIntoContact(Connection ConnCRM, Hashtable htbContact, Hashtable htbCRMMetaData)
										 throws IntlBypassException{

	//throw  new IntlBypassException("IntlBypassException occured.......");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public int postinsertIntoContact(Connection ConnCRM, Hashtable htbContact,
    								 Hashtable htbCRMMetaData , int iRetVal){

	return iRetVal;
	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception			IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void preinsertIntoPsy(Connection ConnCRM, int iAccId, Hashtable htbPsy,
							     Hashtable htbCRMMetaData, String strProcessTable	)
								 throws IntlBypassException{


	//throw  new IntlBypassException("IntlBypassException occured.......");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				int
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public int postinsertIntoPsy(Connection ConnCRM, int iAccId, Hashtable htbPsy,
							  Hashtable htbCRMMetaData, String strProcessTable , int iRetVal){

    return iRetVal;
	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception			IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void preinsertIntoDemo(Connection ConnCRM, int iAccId, Hashtable htbDemo,
									   Hashtable htbCRMMetaData, String strProcessTable)
									   throws IntlBypassException{

		//throw  new IntlBypassException("IntlBypassException occured.......");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				int
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public int postinsertIntoDemo(Connection ConnCRM, int iAccId, Hashtable htbDemo,
							   Hashtable htbCRMMetaData, String strProcessTable , int iRetVal){

	return iRetVal;
	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception			IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */
	public void preinsertIntoAddr(Connection ConnCRM, int iAccId, Hashtable htbAddr,
								   Hashtable htbCRMMetaData, String strPSPersonType)
								   throws IntlBypassException{

	//throw  new IntlBypassException("IntlBypassException occured.......");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
	public void postinsertIntoAddr(Connection ConnCRM, int iAccId, Hashtable htbAddr,
								   Hashtable htbCRMMetaData, String strPSPersonType){
	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception			IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void preinsertIntoMisc(Connection ConnCRM, int iAccId,
									   Hashtable htbMisc, Hashtable htbCRMMetaData,
									   String strPSPersonType ,String strKeyDemo, String strKeyPsyc)
									   throws IntlBypassException{


	//throw  new IntlBypassException("IntlBypassException occured.......");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void postinsertIntoMisc(Connection ConnCRM, int iAccId,
								   Hashtable htbMisc, Hashtable htbCRMMetaData,
								   String strPSPersonType ,String strKeyDemo, String strKeyPsyc){


	}


	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception			IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */
	public void preinsertIntoSuspect(Connection ConnCRM, Hashtable htbContact, Hashtable htbCRMMetaData)
									 throws IntlBypassException{

	//throw  new IntlBypassException("IntlBypassException occured.......");

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				int
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public int postinsertIntoSuspect(Connection ConnCRM, Hashtable htbContact,
    								 Hashtable htbCRMMetaData , int iRetVal){

	return iRetVal;
	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception			IntlBypassException
	 	 * @since
	 	 ********************************************************************************************
	 */
    public void preinsertOrUpdateRec(Connection ConnCRM, String strSalesID, String strProductType,
									Hashtable htbTranData, Hashtable htbCRMMetaData,
									String[] arrIdentifier, Vector vctExtradata,
									String strRole,boolean isStandAlone,
									String strPSPersonType, String strUploadType,
                                    String strProdKeyVal) throws IntlBypassException{


	//throw  new IntlBypassException("IntlBypassException occured.......");


	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				String
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
    public String postinsertOrUpdateRec(Connection ConnCRM, String strSalesID, String strProductType,
										Hashtable htbTranData, Hashtable htbCRMMetaData,
										String[] arrIdentifier, Vector vctExtradata,
										String strRole,boolean isStandAlone,
										String strPSPersonType, String strUploadType,
	                                    String strProdKeyVal , String strRetVal){
		return strRetVal;
	}

	/* CRM61SR:SREVNTBO:TRACKER# 44228 **BEGIN  CHANGES** */



    public void preinsertIntoEvent(Connection ConnCRM,Vector vctField,Vector vctVal)
								 throws IntlBypassException{

	//throw  new IntlBypassException("IntlBypassException occured.......");

		// strIDFrom denotes if its from Customer/contact/suspect
		String strIDFrom = null;
		String sEventType = "DOB";
		String strdate = null;
		String streventType = null;
		String sEventDesc = "Date of Birth";
		String sEditable = "N";
		String strQry = null;
		String strUpdateQry = null;
		String strUpdateQry1 = null;
		String seventid = null;
		// iIDFrom denotes if its from Customer/contact/suspect
		int iIDFrom = 0;
		int ieventid = 0;
		int ieventdetid = 0;
		int index = -1;
		Statement stmt = null;
		ResultSet rs = null;

		//CustomerUploadUtils cuu = new CustomerUploadUtils();

	try{

		index = vctField.indexOf("ACCOUNTS.AccountID");
		if(index >= 0){

			String sAccountID = vctVal.get(index).toString();
			iIDFrom = Integer.parseInt(sAccountID);
			strIDFrom = "CustomerID";
			//System.out.println("CUSTOMR DATE OF BIRTH");
			index = vctField.indexOf("CUST_DOB");
			if(index >= 0){
				strdate = vctVal.get(index).toString();
			}else{
				return;
			}
		}

		index = vctField.indexOf("CONTACTS.ContactID");
		if(index >= 0){
			String sContactID = vctVal.get(index).toString();
			iIDFrom = Integer.parseInt(sContactID);
			strIDFrom = "ContactID";
			index = vctField.indexOf("CONTACT_DOB");
			if(index >= 0){
				strdate = vctVal.get(index).toString();
			}else{
				return;
			}
		}

		index = vctField.indexOf("SUSPECTS.SuspectID");
		if(index >= 0){
			String sSuspectID = vctVal.get(index).toString();
			iIDFrom = Integer.parseInt(sSuspectID);
			strIDFrom = "SuspectID";
			index = vctField.indexOf("SUSPECTS_DOB");
			if(index >= 0){
				strdate = vctVal.get(index).toString();
			  // //System.out.println("The Date is :::"+ strdate);
			}else{
				return;
			}
		}

		strQry = "Select EventID from Event where " + strIDFrom + "=" +iIDFrom ;
		rs = InterfaceDBAccess.getResultSetFromCrm(strQry,null);
		while(rs.next()){
			seventid = rs.getString(1);
		}
		rs.close();
		if(seventid == null){
			SequenceHelper sh=new SequenceHelper();
			ieventid = sh.getNextSequenceCRM(ConnCRM,"EventID");
			ieventdetid = sh.getNextSequenceCRM(ConnCRM,"EventDetailID");
			/* CRM11MEM Changes by Hema Start*/
			//strUpdateQry = "Insert into Event(EventID," + strIDFrom + ",BANK_ID)values(" + ieventid + "," + iIDFrom + ","+bankID+")";
			strUpdateQry = "Insert into Event(EventID," + strIDFrom + ",BANK_ID)values(" + ieventid + "," + iIDFrom + ",'"+bankID+"')";
			/* CRM11MEM Changes by ff End*/
			//FCRM70ORC Begin Changes
			if(DBUtil.isOracleServer())
			{
			strUpdateQry1 =	"Insert into Event_Details(EventID,EventDetailID,EventType,EventDate,EventDesc,EventEditable,BANK_ID) values("
							+ieventid + "," +ieventdetid+ ",'" + sEventType + "',to_date('" + strdate + "','yyyy-mm-dd hh24:mi:ss'),'" + sEventDesc + "','" + sEditable +"','"+bankID+"')";
			}else{
				strUpdateQry1 =	"Insert into Event_Details(EventID,EventDetailID,EventType,EventDate,EventDesc,EventEditable,BANK_ID) values("
							+ieventid + "," +ieventdetid+ ",'" + sEventType + "','" + strdate + "','" + sEventDesc + "','" + sEditable +"','"+bankID+"')";
					}
			//FCRM70ORC End Changes
			sh=null;
		}else{
			ieventid = Integer.parseInt(seventid);
			strQry = "Select EventType from Event_Details where EventID=" +ieventid ;
			rs = InterfaceDBAccess.getResultSetFromCrm(strQry,null);
			while(rs.next()){
				streventType = rs.getString(1);
			}
			rs.close();
			if(streventType.trim().equalsIgnoreCase(sEventType)){
				return;
			}else{
				ieventdetid = (new SequenceHelper()).getNextSequenceCRM(ConnCRM, "EventDetailID");
				//FCRM70ORC Begin Changes
				if(DBUtil.isOracleServer())
				{
				strUpdateQry1 = "Insert into Event_Details (EventDetailID,EventType,EventDate,EventDesc,EventEditable,BANK_ID) " +
										"values(" +ieventdetid +",'"+ sEventType + "',to_date('" + strdate + "','yyyy-mm-dd hh24:mi:ss'),'" + sEventDesc + "','" + sEditable +
										"','"+bankID+"') where EventID=" +ieventid;
					}else{

						strUpdateQry1 = "Insert into Event_Details (EventDetailID,EventType,EventDate,EventDesc,EventEditable,BANK_ID) " +
										"values(" +ieventdetid +",'"+ sEventType + "','" + strdate + "','" + sEventDesc + "','" + sEditable +
										"','"+bankID+"') where EventID=" +ieventid;

						}
				}
				//FCRM70ORC END OF Changes
			}
		   ////System.out.println("The update query is:::"+	strUpdateQry1);
			stmt = ConnCRM.createStatement();
			if(strUpdateQry != null){
				stmt.addBatch(strUpdateQry);
			}
			if(strUpdateQry1 != null){
				stmt.addBatch(strUpdateQry1);
			}
			stmt.executeBatch();
			strUpdateQry=null;
			strUpdateQry1=null;

		}catch(Exception e){
             Debug.print("UpdateOrInsertCustom","preinsertIntoEvent",
                         "Exception: Error in Pre hook",e);
		}finally
		{
			try{
					if(null != stmt)stmt.close();
			}catch(Exception e){}
		}

	}

	/**
	 	 *********************************************************************************************
	 	 * method description
	 	 * @param
	 	 * @return				void
	 	 * @exception
	 	 * @since
	 	 ********************************************************************************************
	 */
	public void postinsertIntoEvent(Connection ConnCRM, Vector vctField, Vector vctVal){


	}

	  /* CRM61SR:SREVNTBO:TRACKER# 44228 **END OF CHANGES** */

}

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **END OF CHANGES** */