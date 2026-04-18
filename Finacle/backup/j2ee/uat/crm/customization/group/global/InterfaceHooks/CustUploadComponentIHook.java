/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CustUploadComponentIHook.java $
 *
 * Author: Jamuna G
 *
 * $Archive: $
 *
 *
 * $History: CustUploadComponentIHook.java $
 *
 */

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **BEGIN  CHANGES** */

package com.infy.intl.custom;

import com.infosys.insulate.util.Vector;
import java.util.Hashtable;
import java.sql.Connection;

import com.infy.intl.exception.IntlBypassException;

public interface CustUploadComponentIHook {

    public void prestartCustomerUpload(String strSalesID,
	                                     Connection connCRM , int iSeqId,
	                                     boolean isStandalone,String strProdProcType,
										 String strProdCustID) throws IntlBypassException;
    public Vector poststartCustomerUpload(String strSalesID,
	                                     Connection connCRM , int iSeqId,
	                                     boolean isStandalone,String strProdProcType,
										 String strProdCustID ,Vector vctRetVal);

    public void prevctAddExtData(Connection ConnIn , int iSeqId, String strProdType,
                                    String strProdKeyVal) throws IntlBypassException;
    public Vector postvctAddExtData(Connection ConnIn , int iSeqId, String strProdType,
                                    String strProdKeyVal,Vector vctRetVal);

    public void preprocessRec(Connection ConnInterface, Connection ConnCRM,
                            String strProdType, String strSalesID,String strProdKeyVal,
                            Hashtable htbCustData, Vector vctExtraData,
                            boolean isStandAlone) throws IntlBypassException;
    public String[] postprocessRec(Connection ConnInterface, Connection ConnCRM,
                            String strProdType, String strSalesID,String strProdKeyVal,
                            Hashtable htbCustData, Vector vctExtraData,
                            boolean isStandAlone, String[] strRetVal);

    public void preupdateStatusFlag(Connection connInt,int iSeqId,String strProdType,
    								String strProdValue) throws IntlBypassException;
    public void postupdateStatusFlag(Connection connInt,int iSeqId,String strProdType,String strProdValue);


	/*  As this method is commented in the customerUploadComponent.java
	public void predoPartialUpload(Hashtable htbCustData, String strCRMId, Connection ConnCRM,
							Hashtable htbTranData, Vector vctExtradata, Hashtable htbCRMMetaData,
							String strJoinCond, boolean doAccounts) throws IntlBypassException;
    public String[] postdoPartialUpload(Hashtable htbCustData, String strCRMId, Connection ConnCRM,
							Hashtable htbTranData, Vector vctExtradata, Hashtable htbCRMMetaData,
							String strJoinCond, boolean doAccounts , String[] strRetVal); */

	/* CRM61SR:SRCIUHIN:TRACKER# 44232 **END OF CHANGES** */
}



