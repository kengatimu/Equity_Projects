/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: AcctUploadComponentIHook.java $
 *
 * Author: Jamuna G
 *
 * $Archive: $
 *
 *
 * $History: AcctUploadComponentIHook $
 *
 */

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **BEGIN  CHANGES** */

package com.infy.intl.custom;

import com.infosys.insulate.util.Vector;
import java.util.Hashtable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import com.infy.intl.common.InterfaceDBAccess;
import com.infy.intl.common.InterfaceResultSet;
import com.infy.intl.util.InterfaceDBConn;
import com.infy.intl.exception.IntlBypassException;

public interface AcctUploadComponentIHook {

    public void pregetSalesId(Hashtable htbSales, Vector vctProdId,
    							Connection connCRM) throws IntlBypassException;
    public void postgetSalesId(Hashtable htbSales, Vector vctProdId,
    							Connection connCRM);

    public void predoInsertUpdateSales(String strSalesUpdateId, int irecCount,
    										Hashtable htbSales,Vector vctProdId,
    										Connection connCRM) throws IntlBypassException;
    public void postdoInsertUpdateSales(String strSalesUpdateId, int irecCount,
    										Hashtable htbSales,Vector vctProdId,
    										Connection connCRM);

    public void predoCustomerUpload(String strSalesID,Connection connCRM) throws IntlBypassException;
    public void postdoCustomerUpload(String strSalesID,Connection connCRM);

    public void predoSaleCustUpload(Connection connCRM,String strSalesID,
    									String strOrgID, String strRole,
    									String strProdProc, String strProdCustID,
    									String strPersonTypeTable) throws IntlBypassException;
    public void postdoSaleCustUpload(Connection connCRM,String strSalesID,
    									String strOrgID, String strRole,
    									String strProdProc, String strProdCustID,
    									String strPersonTypeTable);

    public void presalesCustInsertUpdate(Hashtable htbSales, Connection connCRM,
									   String strCRMTable) throws IntlBypassException;
    public Vector postsalesCustInsertUpdate(Hashtable htbSales, Connection connCRM,
									   String strCRMTable , Vector vctRetVal);


    public void preinsertSalesCustomer(Connection connCRM, String strSalesID,
									String strOrgID, String strRole,
									Vector vctParams, String strPersonTypeTable) throws IntlBypassException;
    public void postinsertSalesCustomer(Connection connCRM, String strSalesID,
									String strOrgID, String strRole,
									Vector vctParams, String strPersonTypeTable);

    public void preAccountExtension(Connection ConnCRM,String strSeqIdFromAccount,
								   String strProductType, String strSalesID,
								   String strRequestID) throws IntlBypassException;
    public Vector postAccountExtension(Connection ConnCRM, String strSeqIdFromAccount,
								   String strProductType,String strSalesID,
								   String strRequestID,Vector vctRetVal);


    public void predeleteAccountsExtnDetails(String strSalesID,Connection ConnCRM,
    										InterfaceResultSet rsExtn) throws IntlBypassException;
    public void postdeleteAccountsExtnDetails(String strSalesID,Connection ConnCRM,
    										InterfaceResultSet rsExtn);

    public void presaleCustUploadProcess(Hashtable htbCustData, String strSalesID,
									   Connection connCRM ) throws IntlBypassException;
    public void postsaleCustUploadProcess(Hashtable htbCustData, String strSalesID,
									   Connection connCRM );

}

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **END OF CHANGES** */


