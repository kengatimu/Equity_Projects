
/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: UpdateOrInsertIHook.java $
 *
 * Author: Jamuna G
 *
 * $Archive: /CRM61DEV/Interface/Source/com/infy/custom/UpdateOrInsertIHook.java $
 *
 *
 * $History: UpdateOrInsertIHook.java $
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

import com.infy.intl.exception.IntlBypassException;

public interface UpdateOrInsertIHook {

	public void preinsertRec(Connection ConnCRM, String strSalesID, String strProductType, Hashtable htbTranData,
							Vector vctExtraData, Hashtable htbCRMMetaData,
							String strRole,boolean isStandAlone,String strPSPersonType,
							String strUploadType) throws IntlBypassException;

	public String postinsertRec(Connection ConnCRM, String strSalesID, String strProductType, Hashtable htbTranData,
								Vector vctExtraData, Hashtable htbCRMMetaData,
								String strRole,boolean isStandAlone,String strPSPersonType,
								String strUploadType,String strRetVal);

    public void preinsertIntoAcc(Connection ConnCRM, Hashtable htbAcc, Hashtable htbCRMMetaData)
								 throws IntlBypassException;

	public int postinsertIntoAcc(Connection ConnCRM, Hashtable htbAcc, Hashtable htbCRMMetaData ,int iRetVal);

	public void preinsertIntoContact(Connection ConnCRM, Hashtable htbContact, Hashtable htbCRMMetaData)
								 throws IntlBypassException;

	public int postinsertIntoContact(Connection ConnCRM, Hashtable htbContact, Hashtable htbCRMMetaData , int iRetVal);

	public void preinsertIntoPsy(Connection ConnCRM, int iAccId, Hashtable htbPsy,
								  Hashtable htbCRMMetaData, String strProcessTable	)
							  throws IntlBypassException;

	public int postinsertIntoPsy(Connection ConnCRM, int iAccId, Hashtable htbPsy,
							  Hashtable htbCRMMetaData, String strProcessTable , int iRetVal);


	public void preinsertIntoDemo(Connection ConnCRM, int iAccId, Hashtable htbDemo,
							   Hashtable htbCRMMetaData, String strProcessTable)
							   throws IntlBypassException;

	public int postinsertIntoDemo(Connection ConnCRM, int iAccId, Hashtable htbDemo,
							   Hashtable htbCRMMetaData, String strProcessTable , int iRetVal);

	public void preinsertIntoAddr(Connection ConnCRM, int iAccId, Hashtable htbAddr,
							   Hashtable htbCRMMetaData, String strPSPersonType)
							   throws IntlBypassException;

	public void postinsertIntoAddr(Connection ConnCRM, int iAccId, Hashtable htbAddr,
							   Hashtable htbCRMMetaData, String strPSPersonType);

	public void preinsertIntoMisc(Connection ConnCRM, int iAccId,
							   Hashtable htbMisc, Hashtable htbCRMMetaData,
							   String strPSPersonType ,String strKeyDemo, String strKeyPsyc)
							   throws IntlBypassException;

	public void postinsertIntoMisc(Connection ConnCRM, int iAccId,
								   Hashtable htbMisc, Hashtable htbCRMMetaData,
								   String strPSPersonType ,String strKeyDemo, String strKeyPsyc);

	public void preinsertIntoSuspect(Connection ConnCRM, Hashtable htbContact, Hashtable htbCRMMetaData)
								 throws IntlBypassException;
	public int postinsertIntoSuspect(Connection ConnCRM, Hashtable htbContact, Hashtable htbCRMMetaData , int iRetVal);

	public void preinsertOrUpdateRec(Connection ConnCRM, String strSalesID, String strProductType,
										Hashtable htbTranData, Hashtable htbCRMMetaData,
										String[] arrIdentifier, Vector vctExtradata,
										String strRole,boolean isStandAlone,
										String strPSPersonType, String strUploadType,
	                                    String strProdKeyVal) throws IntlBypassException;

	public String postinsertOrUpdateRec(Connection ConnCRM, String strSalesID, String strProductType,
										Hashtable htbTranData, Hashtable htbCRMMetaData,
										String[] arrIdentifier, Vector vctExtradata,
										String strRole,boolean isStandAlone,
										String strPSPersonType, String strUploadType,
	                                    String strProdKeyVal , String strRetVal);

    public void preinsertIntoEvent(Connection ConnCRM,Vector vctField, Vector vctVal)
								  	 throws IntlBypassException;

	public void postinsertIntoEvent(Connection ConnCRM,Vector vctField, Vector vctVal);


}

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **END OF CHANGES** */




