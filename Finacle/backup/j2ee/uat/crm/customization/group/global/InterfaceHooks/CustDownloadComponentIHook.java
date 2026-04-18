/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CustDownloadComponentIHook.java $
 *
 * Author: Jamuna G
 *
 * $Archive: $
 *
 *
 * $History: CustDownloadComponentIHook.java $
 *
 */

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **BEGIN  CHANGES** */

package com.infy.intl.custom;

import com.infosys.insulate.util.Vector;
import java.sql.Connection;
import java.sql.Statement;

import com.infy.intl.exception.IntlBypassException;
import com.infy.intl.common.InterfaceResultSet;

public interface CustDownloadComponentIHook {

    public void predeleteCustRec(Connection connInterface, int iCRMPersonId) throws IntlBypassException;
    public void postdeleteCustRec(Connection connInterface, int iCRMPersonId);

    public void preinsertCustRec(Connection connInterface,
                                   InterfaceResultSet rsCRMALLData,
                                   String strTableName, String strSequenceId,
                                   String strSalesId, String strProductproctype,
                                   int iCallerId) throws IntlBypassException;
    public String postinsertCustRec(Connection connInterface,
                                   InterfaceResultSet rsCRMALLData,
                                   String strTableName, String strSequenceId,
                                   String strSalesId, String strProductproctype,
                                   int iCallerId, String strRetVal);

    public void precustDownLoadFromCrm(Connection connInterface,String strSequenceId,
                                       String strTableName,String strSalesId,
									   String strProductproctype,
                                       String strValue, int iCallerId) throws IntlBypassException;
    public String postcustDownLoadFromCrm(Connection connInterface,String strSequenceId,                                              String strTableName,
                                       String strSalesId, String strProductproctype,
                                       String strValue, int iCallerId, String strRetVal);

    public void pregetSqlQueryForCustDownload(Connection connInterface,
                                             Vector vctAllInterfaceData) throws IntlBypassException;
    public void postgetSqlQueryForCustDownload(Connection connInterface,
                                             Vector vctAllInterfaceData);

    public void pregetCustomerDetails(Connection connInterface, String strSequenceId,
							   String strSalesId, String strProductproctype,
                               String strValue) throws IntlBypassException;
    public String postgetCustomerDetails(Connection connInterface, String strSequenceId,
							   String strSalesId, String strProductproctype,
                               String strValue , String strRetVal);

    public void precustomerDownLoad(Connection connInterface,
									String strSequenceId, String strSalesId,
                                    String strProductproctype,
									String strREQUESTCATEGORY,
                                    String strREQUESTTYPE) throws IntlBypassException;
    public boolean postcustomerDownLoad(Connection connInterface,
									String strSequenceId, String strSalesId,
                                    String strProductproctype,
									String strREQUESTCATEGORY,
                                    String strREQUESTTYPE , boolean blRetVal);
}

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **END OF CHANGES** */



