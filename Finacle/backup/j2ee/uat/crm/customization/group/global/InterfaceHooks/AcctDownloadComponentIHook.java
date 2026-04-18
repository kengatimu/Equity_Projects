
/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: AcctDownloadComponentIHook.java $
 *
 * Author: Jamuna G
 *
 * $Archive: $
 *
 *
 * $History: AcctDownloadComponentIHook $
 *
 */

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **BEGIN  CHANGES** */

package com.infy.intl.custom;

import com.infosys.insulate.util.Vector;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;


import com.infy.intl.exception.IntlBypassException;
import com.infy.intl.util.InterfaceDBConn;


public interface AcctDownloadComponentIHook {

    public void pregetSqlQueryForAppDownload(Connection connInterface,
    											Vector vctAllInterfaceData,
    											String strSalesId) throws IntlBypassException;
    public String postgetSqlQueryForAppDownload(Connection connInterface,
    											Vector vctAllInterfaceData,
    											String strSalesId,String strRetVal);

}

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **END OF CHANGES** */





